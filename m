Return-Path: <owner-linux-aio@kvack.org>
Subject: [PATCH 0/5] blkcg: Limit maximum number of aio requests available
 for cgroup
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
 oleg@redhat.com, ktkhai@virtuozzo.com
Date: Mon, 04 Dec 2017 19:12:51 +0300
Message-ID: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-linux-aio@kvack.org
List-ID: <linux-block@vger.kernel.org>

Hi,

this patch set introduces accounting aio_nr and aio_max_nr per blkio cgroup.
It may be used to limit number of aio requests, which are available for
a cgroup, and could be useful for containers.

The accounting is hierarchical, and aio contexts, allocated in child cgroup,
are accounted in parent cgroups too.

Also, new cgroup file "io.aio_nr" is introduced. It's used to set cgroup
aio requests limit, to show current limit and number of currenly occupied
requests.

Patches 1-3 are refactoring.
Patch 4 is the place where the accounting actually introduced.
Patch 5 adds "io.aio_nr" file.

---

Kirill Tkhai (5):
      aio: Move aio_nr increment to separate function
      aio: Export aio_nr_lock and aio_max_nr initial value to include/linux/aio.h
      blkcg: Add blkcg::blkg_aio_nr and blkcg::blkg_aio_max_nr
      blkcg: Charge aio requests in blkio cgroup hierarchy
      blkcg: Add cgroup file to configure blkcg::blkg_aio_max_nr


 block/blk-cgroup.c         |   88 +++++++++++++++++++++++++-
 fs/aio.c                   |  151 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/aio.h        |   21 ++++++
 include/linux/blk-cgroup.h |    4 +
 4 files changed, 247 insertions(+), 17 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
