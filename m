Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912682;
	b=UgGbOAYZqj/y393RUgEHpymE/XdXAU1MuBpslvRDZ9aF8UPbBverJhVefzUtt21Co7/a
	 QxV/yzNEdLdaZB5TfZY/T3pC8roV+0En+HZdP0kclxVcYR5xf5M/F6FLVzSEWoNptQupj
	 aIC/XIP6LqL0aQcaVEleMgknNMCJYrq+NbtRyn/r9MrGYH5uxyOZFDW5GFx+XGPe+f2Yi
	 s8s/TTW8Ici4l/s4fjfiIoAEBrrzMcLdL4u/UdDfy//3HnO7MpBk4m5T0B116TWUor5km
	 ZwcbsiH4ImR948YuLL7U+GL6806FmNL/43JZACag8aYV24y7HQNltgmZ9ZO0PN8qeVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912682;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=D5L6+ctkUXEVCvLdhSmE9kuyDK2TKGhWbB/u6kdjjno=;
	b=M+VPDjIPbS/riTpklpASPp8Xz8ex4CAam5mxNFWBPjzNuHu9GQfGQLIi/Tk6lXtWPPID
	 ozuE/SYw1+dRsbFKhYlgL78qrN6w0Rkw7bavIdBJa8mKzlaV6cAuCeK9nDhNRaGwiCZ2q
	 v4TD9mBdKvhAu0IYXTz+g5J8Lfyl2JIvIQbzzE7+org+XfYAlPV9+PIufPjFNoYXnJ3kE
	 1d6ZyFeeEh8ZMzUwDezydE7tJFdQHLcSGgXxKRDsNubiDNYBBBZjD2jHIpg3MjKSnOHY+
	 wM8rydAx3DuxOHLwX7EDktuDJxXi3wYYBkxcEajLpSvK0TH5hzq53ls0Rg8LFA9BPWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48395606A32F;
	Tue, 17 Nov 2026 10:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48395606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAHD5+jMfxqv5JWBg--.38471S2;
	Tue, 17 Nov 2026 18:51:15 +0800 (CST)
Received: from phytium.. (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSnOdMfxqF977AA--.36666S3;
	Tue, 17 Nov 2026 18:51:10 +0800 (CST)
From: Ethan <yangyizhen3198@phytium.com.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yangyizhen3198@phytium.com.cn
Subject: [RFC PATCH 0/1] block: long udev open waits during cache teardown
Date: Tue, 17 Nov 2026 18:51:06 +0800
Message-Id: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwSnOdMfxqF977AA--.36666S3
X-CM-SenderInfo: 51dqw5pl2kv0atrzmqxsk13x1xpou0fpof0/1tbiAQACDWr7WcwEQQALsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=yangyizhen
	3198@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr1kZrWUtr43JF1UuF45ZFb_yoW3GF1kpF
	WfGFZxtrWkGrWxKrn7Zw4UWr1rKrWrGa15JrnxK340ywn8CryvqrW0qF18XayUCrZ5JF4j
	qr4jqrZ5C34DAaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Hi,

This is the first posting of this proposal.

I am requesting feedback on long device-open blocking during final cache
teardown after large buffered writes to a raw block device. In repeated
full mkfs.ntfs runs, formatting succeeds, but a udev process opening the
same device waits for several minutes on disk->open_mutex. The system
reports hung tasks and udev is restarted after watchdog timeouts.

The issue is not simply that formatting or close takes a long time.
The concern is that device lifecycle exclusion is held while large-scale
cache cleanup runs, preventing another device opener from progressing.
The attached patch is an early pre-reclaim prototype for discussing how
to address that exclusion. It is not a current-mainline merge request
or a 6.6.y stable backport request.

Reproduction context and observed impact
----------------------------------------
The recorded system is Phytium ARM64 with about 1 TiB RAM, a 1.92 TB NVMe
device and 512-byte logical sectors. The reproducer is a full, non-quick
mkfs.ntfs run using the original userspace binary and library. Such a
reproducer destroys the target; it was run only on a disposable device.
No userspace cache-drop option or changed write-size option was enabled.
The hung-task reporting threshold remained 120 seconds.

The baseline was 6.6.0.6.6-server-v11-bdevdbg: a vendor 6.6 kernel with
BDEVDBG diagnostics for observing the close path. No preclose cache
reclaim hook was present. This is not an unmodified upstream v6.6 binary.
Three consecutive runs on the same boot produced:

  Run   Mapping cache at close   Final truncate   Udev entire open
        (4 KiB pages / GiB)      (seconds)        (seconds)
   1    211073040 / 805.180      423.281554       423.281502
   2    211110775 / 805.324      447.063839       447.061432
   3    211255349 / 805.875      420.785212       420.785106

All three mkfs runs and subsequent NTFS information checks returned 0.
Nevertheless, each run recorded target udev hung-task reports and one
associated udev watchdog restart; the service recovered afterwards.
The three runs contained seven hung-task messages in total. These are
repeated reports of the waiting tasks, not seven independent failures.
No soft lockup, RCU stall, media I/O error or new AER was recorded in
this baseline batch. Other device-event latency was not quantified.

A shortened stack from the first run is:

  INFO: task systemd-udevd:95598 blocked for more than 122 seconds.
  task:systemd-udevd state:D
    __mutex_lock.constprop.0
    __mutex_lock_slowpath
    mutex_lock
    blkdev_get_by_dev.part.0
    blkdev_get_by_dev
    blkdev_open
    do_dentry_open

The same task was subsequently reported blocked for over 245 seconds.
The diagnostic mutex wait was 423281 ms, agreeing with the paired udev
open at millisecond resolution. The entire open includes more than the
mutex wait, so it is not itself an exact mutex measurement. Likewise,
120 seconds is a hung-task reporting threshold, not a timed mutex that
returns an error after 120 seconds.

Where the time is spent
------------------------
The examined vendor block release path is:

  mkfs final file release               Concurrent udev open
    blkdev_release                       blkdev_open
      blkdev_put                           blkdev_get_by_dev
        sync before lock where applicable    mutex_lock(open_mutex)
        mutex_lock(open_mutex)                -> sleeps waiting
        blkdev_put_whole
          last opener reaches zero
          blkdev_flush_mapping
            sync_blockdev
            kill_bdev
              invalidate_bh_lrus
              truncate_inode_pages
        mutex_unlock(open_mutex)              -> can proceed

The last-opener check is significant: the existing final cleanup is
performed when the opener count reaches zero. A new opener is serialized
by the same disk mutex while that cleanup completes. The proposed hook,
in contrast, is per struct file and is not a last-device-opener check.

The diagnostic logs bracket cache teardown and show the target mapping
falling from the page counts above to zero. Paired tracing places nearly
all the final release interval inside truncate_inode_pages. The final
sync was recorded as 0 ms at the diagnostic timer's resolution; this is
not zero cost or proof that every page was always clean. A completed
sync need not evict clean cache pages or remove all associated metadata,
so finishing writes does not eliminate the later cache teardown work.
The cache is a shared block-device mapping, not mkfs process-private RSS.

This supports cache teardown under lifecycle exclusion as the bottleneck
in these runs. It does not establish the separate CPU cost of every BH,
shadow entry or traversal, or prove the same delay on every system.

Proposed direction and scope of this RFC
----------------------------------------
Try vfs_fsync followed by vfs_fadvise(DONTNEED) before fsnotify_close and
the original release, outside open_mutex at the hook. Keep the original
release to clean up remaining pages and concurrent activity. Allow cache
residue; no zero-page invariant or fixed timeout bound is promised.
The objective is to reduce how much cleanup other openers wait behind,
not to eliminate reclaim cost or guarantee a shorter complete close.

The proposed hook applies to block-device files that have a fsync
operation, excluding O_PATH handles. It runs at the final reference to
each such struct file, including read-only and O_DIRECT opens; this is
not a last-device-opener hook. Syncing and evicting a shared mapping at
that point can affect other users. Sync/reclaim may be long and run in
task work, exit or delayed fput context. These are unresolved policy and
placement concerns. Placing the hook before fsnotify_close also defers
notification, which must be distinguished from reduced mutex hold time.

The main questions are whether __fput is an acceptable hook, whether
this should instead remain an explicit userspace action, and whether
a different block close locking design would better address the issue.
If a kernel pre-reclaim policy is appropriate, what eligibility and
accounting could prevent repeated work and interference with other users?

Validation boundaries
----------------------
The implementation is based on the recorded vendor Linux 6.6 source
snapshot. Patch application and comparison with the prepared source
files passed. checkpatch reports 0 errors and one new-file MAINTAINERS
warning. Current mainline has not been used to reproduce or validate
this RFC, and no additional build or runtime test was run while preparing
this posting. The three baseline runs above characterize the problem;
they are not performance or safety results for the proposed patch.

This posting does not claim that all workloads are free of regressions,
or that the change fixes soft lockups or RCU stalls. Buffered-cache and
concurrent-open behavior need dedicated validation.

If the direction is appropriate, the next step is to rebase to the
agreed current tree and validate lifecycle contexts, concurrent buffered
I/O and open/close, error/removal paths, lockdep, CONFIG_BLOCK=n and
complete close and command cost. I would appreciate design feedback
before pursuing a mergeable implementation.

Thanks,
Ethan

Ethan (1):
  block: reclaim cache before block file close notification

 block/Makefile                |  2 ++
 block/bdev-preclose.c         | 29 +++++++++++++++++++++++++++++
 fs/file_table.c               |  4 ++++
 include/linux/bdev-preclose.h | 14 ++++++++++++++
 4 files changed, 49 insertions(+)

