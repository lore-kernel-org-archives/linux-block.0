Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] block: sed-opal: support write to shadow mbr
Date: Tue, 13 Mar 2018 14:08:53 +0100
Message-Id: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Hi,
this patchset adds support to write data into the shadow mbr of sed-opal
enabled devices. They apply cleanly on today next-tree (next-20180313)
and requires the u64 short atom length fix from [0] as that is still
missing in that tree. As I only can test on my only sed-opal enabled
Samsung 850 Evo on amd64, tests on other hardware would be appreciated.

The first six patches provide helper functions that are used in the
following up patches as well as do some refactoring and unification of
the existing code.

With the seventh patch, a new ioctl is added to mark the shadow mbr as
done without having to enable/disable the shadow mbr feature as a whole.

Finally, the last patch adds an ioctl to write data into the shadow mbr.

A modified version of the user space tools with support for those ioctls
can be found at [1].

Looking forward to feedback and suggestions for improvement,
 Jonas

[0] https://lkml.org/lkml/2018/3/7/534
[1] https://github.com/ghostav/sed-opal-temp

Jonas Rabenstein (8):
  block: sed-opal: use correct macro for method length
  block: sed-opal: unify space check in add_token_*
  block: sed-opal: unify cmd start and finalize
  block: sed-opal: unify error handling of responses
  block: sed-opal: print failed function address
  block: sed-opal: split generation of bytestring header and content
  block: sed-opal: add ioctl for done-mark of shadow mbr
  block: sed-opal: ioctl for writing to shadow mbr

 block/sed-opal.c              | 432 +++++++++++++++++++++---------------------
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |   9 +
 3 files changed, 223 insertions(+), 220 deletions(-)

-- 
2.16.1
