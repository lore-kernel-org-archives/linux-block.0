Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBVy2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:28 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 00/11]blktrace: output cgroup info
Date: Fri,  2 Jun 2017 14:53:53 -0700
Message-Id: <cover.1496432591.git.shli@fb.com>
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

The first 5 patches adds export operation handlers for kernfs, so userspace can
use open_by_handle_at/name_to_handle_at to a kernfs file. Later patches make
blktrace output cgroup info.

Thanks,
Shaohua

Shaohua Li (11):
  kernfs: implement i_generation
  kernfs: use idr instead of ida to manage inode number
  kernfs: add an API to get kernfs node from inode number
  kernfs: don't set dentry->d_fsdata
  kernfs: add exportfs operations
  cgroup: export fhandle info for a cgroup
  blktrace: export cgroup info in trace
  block: always attach cgroup info into bio
  block: call __bio_free in bio_endio
  blktrace: add an option to allow displying cgroup path
  block: use standard blktrace API to output cgroup info for debug notes

 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |   2 +-
 block/bfq-iosched.h                      |  16 +-
 block/bio-integrity.c                    |   1 +
 block/bio.c                              |   1 +
 block/blk-throttle.c                     |  13 +-
 block/cfq-iosched.c                      |  15 +-
 fs/kernfs/dir.c                          |  80 +++++++---
 fs/kernfs/file.c                         |   6 +-
 fs/kernfs/inode.c                        |   7 +-
 fs/kernfs/kernfs-internal.h              |   4 +
 fs/kernfs/mount.c                        | 107 +++++++++++--
 fs/kernfs/symlink.c                      |   6 +-
 fs/sysfs/mount.c                         |   2 +-
 include/linux/blk-cgroup.h               |  16 +-
 include/linux/blktrace_api.h             |  12 +-
 include/linux/cgroup-defs.h              |   2 +
 include/linux/cgroup.h                   |  14 ++
 include/linux/kernfs.h                   |  23 ++-
 include/uapi/linux/blktrace_api.h        |   3 +
 kernel/cgroup/cgroup.c                   |  18 ++-
 kernel/trace/blktrace.c                  | 254 +++++++++++++++++++++----------
 21 files changed, 430 insertions(+), 172 deletions(-)

-- 
2.9.3
