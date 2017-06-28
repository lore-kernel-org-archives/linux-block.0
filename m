Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdF1QaF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:05 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V4 00/12] blktrace: output cgroup info
Date: Wed, 28 Jun 2017 09:29:50 -0700
Message-Id: <cover.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Hi,

Currently blktrace isn't cgroup aware. blktrace prints out task name of current
context, but the task of current context isn't always in the cgroup where the
BIO comes from. We can't use task name to find out IO cgroup. For example,
Writeback BIOs always comes from flusher thread but the BIOs are for different
blk cgroups. Request could be requeued and dispatched from completely different
tasks. MD/DM are another examples. This brings challenges if we want to use
blktrace for performance tunning with cgroup enabled.

This patchset try to fix the gap. We print out cgroup fhandle info in blktrace.
Userspace can use open_by_handle_at() syscall to find the cgroup by fhandle. Or
userspace can use name_to_handle_at() syscall to find fhandle for a cgroup and
use a BPF program to filter out blktrace for a specific cgroup.

The first 6 patches adds export operation handlers for kernfs, so userspace can
use open_by_handle_at/name_to_handle_at to a kernfs file. Later patches make
blktrace output cgroup info.

Thanks,
Shaohua

V3 -> V4:
- Address some issues pointed out by Tejun
- Fix build errors with latest -next tree

V2 -> V3:
- Uses 32 bits inode number
- Refresh to latest -next tree

V1 -> V2:
- Fix a bug in cgroup association
- Fix build errors reported by 0day
- Address some issues pointed out by Tejun


Shaohua Li (12):
  kernfs: use idr instead of ida to manage inode number
  kernfs: implement i_generation
  kernfs: add an API to get kernfs node from inode number
  kernfs: don't set dentry->d_fsdata
  kernfs: introduce kernfs_node_id
  kernfs: add exportfs operations
  cgroup: export fhandle info for a cgroup
  blktrace: export cgroup info in trace
  block: always attach cgroup info into bio
  block: call __bio_free in bio_endio
  blktrace: add an option to allow displying cgroup path
  block: use standard blktrace API to output cgroup info for debug notes

 block/bfq-iosched.h               |  13 +-
 block/bio-integrity.c             |   1 +
 block/bio.c                       |   2 +
 block/blk-throttle.c              |  13 +-
 block/cfq-iosched.c               |  15 +--
 fs/kernfs/dir.c                   | 111 ++++++++++++----
 fs/kernfs/file.c                  |  10 +-
 fs/kernfs/inode.c                 |   9 +-
 fs/kernfs/kernfs-internal.h       |   9 ++
 fs/kernfs/mount.c                 |  94 ++++++++++++--
 fs/kernfs/symlink.c               |   6 +-
 include/linux/blk-cgroup.h        |   3 +
 include/linux/blktrace_api.h      |  13 +-
 include/linux/cgroup.h            |  16 ++-
 include/linux/kernfs.h            |  28 ++++-
 include/trace/events/writeback.h  |   2 +-
 include/uapi/linux/blktrace_api.h |   3 +
 kernel/cgroup/cgroup.c            |  15 ++-
 kernel/trace/blktrace.c           | 259 ++++++++++++++++++++++++++------------
 19 files changed, 470 insertions(+), 152 deletions(-)

-- 
2.9.3
