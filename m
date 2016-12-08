Return-Path: <linux@rasmusvillemoes.dk>
Return-Path: <linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC 00/10] implement alternative and much simpler id allocator
Date: Thu,  8 Dec 2016 02:22:55 +0100
Message-Id: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
List-ID: <linux-block@vger.kernel.org>

TL;DR: these patches save 250 KB of memory, with more low-hanging
fruit ready to pick.

While browsing through the lib/idr.c code, I noticed that the code at
the end of ida_get_new_above() probably doesn't work as intended: Most
users of ida use it via ida_simple_get(), and that starts by
unconditionally calling ida_pre_get(), ensuring that ida->idr has
8==MAX_IDR_FREE idr_layers in its free list id_free. In the common
case, none (or at most one) of these get used during
ida_get_new_above(), and we only free one, leaving at least 6 (usually
7) idr_layers in the free list.

The comment suggests that the idea is that subsequent allocations
would get rid of these one by one, but this doesn't work due to the
unconditional filling done by ida_simple_get - and callers who do
their own locking presumably call ida_pre_get themselves, with the
same effect.

To confirm my suspicion, and to see how many idas are actually in use
and how much they're utilized, I hacked together a /proc/ida file to
provide some stats on the currently active idas. Some examples of
lines from that on my laptop:

file:line	gets	puts	diff	layers	id_free_cnt
block/blk-core.c:49	27	0	27	1	7
drivers/base/platform.c:35	1	0	1	1	6
drivers/gpu/drm/drm_crtc.c:201	0	0	0	0	0
drivers/gpu/drm/drm_crtc.c:201	0	0	0	0	0
...
drivers/gpu/drm/drm_crtc.c:201	1	0	1	1	6
drivers/gpu/drm/drm_crtc.c:201	2	0	2	1	7
drivers/gpu/drm/drm_crtc.c:5700	5	0	5	1	7
...
drivers/scsi/hosts.c:45	6	0	6	1	7
drivers/scsi/sd.c:123	1	0	1	1	6
fs/devpts/inode.c:386	57	40	17	1	7
fs/kernfs/dir.c:918	10	0	10	1	7
fs/kernfs/dir.c:918	11	0	11	1	7
...
fs/kernfs/dir.c:918	24799	1609	23190	1	7
...
fs/super.c:882	49	5	44	1	7
kernel/workqueue.c:3198	10	8	2	1	7
kernel/workqueue.c:3198	11	9	2	1	7
kernel/workqueue.c:3198	2	0	2	1	7
kernel/workqueue.c:3198	2	0	2	1	7
kernel/workqueue.c:3198	2	0	2	1	7
kernel/workqueue.c:3198	94	91	3	1	7

file:line is the location of the ida_init or DEFINE_IDA, gets and puts
are the lifetime number of allocations/frees - their difference is
thus the current number of allocated ids. layers and id_free_cnt are
the members of ida->idr.

As expected, there are 0, 6 or 7 idr_layers cached and unused in each
ida, depending on whether there have been 0, 1 or more allocations
done. Add the idr_layer which is in use, and we see that e.g. the
workqueue instances use more than 6*8*sizeof(struct idr_layer) ~ 100K
of memory, or almost 1K per allocated id.

Patches 1 and 2 are minor optimization opportunities, while patch 3 is
an attempt at making the 'free the extra idr_layers one at a time'
actually work. But it's not a very good solution, since it doesn't
help the users who never do more than a handful of allocations, nor
does it help those who call ida_pre_get/ida_get_new
directly. Moreover, even if we somehow had perfect heuristics and got
rid of all excess idr_layers and ida_bitmap (another 128 bytes we
usually have hanging around), the minimum overhead of sizeof(struct
idr_layer)+sizeof(struct ida_bitmap) ~ 2200 bytes is quite a lot for
the many ida users who never allocate more than 100 ids.

So instead/in addition, I suggest we introduce a much simpler
allocator based on a dynamically growing bitmap. Patches 4-10
introduce struct tida and has a few examples of replacing ida with
tida. [Yeah, tida is not a good name, and probably _get and _put are also
bad.]

I've booted a 4.8.12 kernel with these backported, and as expected
they save around 250KB of memory. There's more to gain, but this is
just an RFC.



Rasmus Villemoes (10):
  lib/idr.c: reused free bitmaps are already clear
  lib/idr.c: delete useless condition
  lib/idr.c: only fill ida->idr when needed
  lib/tida.c: a very simple integer id allocator
  kernel/workqueue.c: replace id allocator ida with tida
  block: use tida as small id allocator
  drivers/base/platform.c: use simpler id allocator
  lib/tida.c: introduce tida_get_above
  drm: use simpler id allocator
  fs/devpts: use tida for id allocation

 block/blk-core.c                |   6 +--
 block/blk-sysfs.c               |   2 +-
 block/blk.h                     |   4 +-
 drivers/base/platform.c         |  10 ++--
 drivers/gpu/drm/drm_connector.c |  21 ++++----
 drivers/gpu/drm/drm_crtc.c      |   4 +-
 fs/devpts/inode.c               |  28 ++++-------
 include/drm/drm_crtc.h          |   3 +-
 include/linux/tida.h            |  32 ++++++++++++
 kernel/workqueue.c              |  14 +++---
 lib/Makefile                    |   2 +-
 lib/idr.c                       |  13 +++--
 lib/tida.c                      | 107 ++++++++++++++++++++++++++++++++++++++++
 13 files changed, 188 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/tida.h
 create mode 100644 lib/tida.c

-- 
2.1.4
