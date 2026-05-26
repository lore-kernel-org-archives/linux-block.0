Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A818EB0
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755134; cv=none; b=qXAj3vdtXbNqwNdAAUvxKsID0RX+lGIgWC5iPgtbpGs4x8jgFhJ/SEgeR9nbBFvu5ORKwgHJ+IvMutuEvJ6Z0aLQjc9LKZvnO1e+R2StBcuIT73xuV5aBOyJVJqA0o9cmPMLNMLwnrNZallDSrxCCSVgyHH0ndnwXzFD2AUeZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755134; c=relaxed/simple;
	bh=Fc3F4hc5UbbKjMJ4ZeksXQaSKF9SpcAYJixuz33j5hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPok9MIpb7UWBefD5AXmWp2u72EW8pGZrhwIQ21AnHpuJJD39sGUnzay/o9ybdiOnADGY6WdNKKeyBRIXRkHw8g8QYTqGW7P93jcr8CngaFyXyZiiEGsfa0DUN5uQW2THtveSXfW/QuFALcmfKLmat0ZiHUn6P8f+pzc+ttNfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64Q0PUNx098584;
	Tue, 26 May 2026 09:25:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64Q0PTi2098581
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 09:25:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
Date: Tue, 26 May 2026 09:25:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
 <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ahRocb0Vs_m6RF_O@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/26 0:19, Ming Lei wrote:
> On Mon, May 25, 2026 at 12:40:19PM +0900, Tetsuo Handa wrote:
>> Some commit which was merged in the merge window for 7.1 broke the loop
>> driver; a race window where lo_release() clears the backing file via
>> __loop_clr_fd() despite some I/O requests are pending was introduced [1][2].
>>
>> The exact commit which changed the behavior is not known due to lack of
>> reproducer and timing dependent behavior, but it seems that we need to
>> solve this problem in the loop driver despite there was no change for the
>> loop driver during this merge window.
>>
>> To close this race, try to flush pending I/O requests. However, calling
>> drain_workqueue() from __loop_clr_fd() with disk->open_mutex held causes
>> lockdep warnings [3][4]. We need to flush pending I/O requests without
>> disk->open_mutex held.
> 
> No, please don't workaround before root cause.
> 
> No proof shows that the issue is in block layer or loop driver, the IO isn't
> expected, you need to figure out why btrfs still issues IO after this loop
> disk is closed by everyone and writeback is done.
> 
> https://syzkaller.appspot.com/x/log.txt?x=101e4702580000
> 

Of course we should try to figure out the root cause first, but how can we do?

  Absolute fact:

    This problem started happening no later than next-20260413 in the linux-next.git tree.
    ( syzbot was unable to test next-202604{03,06,07,08,09,10} due to a different bug. )

    This problem is still happening as of v7.1-rc5 in the linux.git tree.

    No one has succeeded establishing steps to reproduce this problem.

    No one has identified the exact commit that is causing this problem.

  Likely fact:

    Since this problem did not happen using next-20260402 in the linux-next.git tree until 2026/04/13 16:31,
    this problem did not exist until next-20260402 in the linux-next.git tree.

    Since this problem did not happen until v7.0, this problem did not exist until v7.0.
    (Although last minute changes for v7.0-rc{6,7} or v7.0 could become the culprit,
     the merge window which accepts big changes for v7.1 is more likely.)

  My guess:

    The culprit commit is in between commit a028739a4330 ("Merge tag 'block-7.0-20260305' of
    git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux") and commit 7fe6ac157b7e ("Merge tag
    'for-7.1/block-20260411' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux"), for
    changes related to bio handling are merged in this period.

    "git log --oneline block/ drivers/block/" between next-20260402 and next-20260413 shows the following diff:

--------------------
-da93b347876b Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
-9b75c6e054b7 Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
-265720725a47 Merge branch 'fs-next' of linux-next
-ac9e99118030 Merge branch into tip/master: 'x86/cleanups'
-8ea5c0750d36 zram: do not forget to endio for partial discard requests
-0476d2e93477 zram: change scan_slots to return void
-1207420afea8 zram: propagate read_from_bdev_async() errors
-aafa569edb41 zram: optimize LZ4 dictionary compression performance
-24c76a259819 Merge branch 'for-7.1/block' into for-next
-eca714c0aac1 Merge branch 'vfs-7.1.bh.metadata' into vfs.all
+7d8d908556ca Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
+4391dc7df11d Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
+18c6a4c24187 Merge branch 'fs-next' of linux-next
+7f828a86cfef Merge branch into tip/master: 'x86/cleanups'
+716aa108c5bb zram: reject unrecognized type= values in recompress_store()
+3470a1d34f40 zram: do not forget to endio for partial discard requests
+88a57e158619 Merge branch 'for-7.1/block' into for-next
+36446de0c30c ublk: fix tautological comparison warning in ublk_ctrl_reg_buf
+f2bab85781e8 Merge branch 'vfs-7.1.bh.metadata' into vfs.all
+9357dc97533a Merge branch 'vfs-7.1.integrity' into vfs.all
+e0b15707598c Merge branch 'for-7.1/block' into for-next
+539fb773a3f7 block: refactor blkdev_zone_mgmt_ioctl
+ddc1dfffcbea Merge branch 'for-7.1/block' into for-next
+365ea7cc6244 ublk: allow buffer registration before device is started
+5e864438e285 ublk: replace xarray with IDA for shmem buffer index allocation
+8ea8566a9aee ublk: simplify PFN range loop in __ublk_ctrl_reg_buf
+211ff1602b67 ublk: verify all pages in multi-page bvec fall within registered range
+23b3b6f0b584 ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB buffer support
+cb793ff1353d Merge branch 'for-7.1/block' into for-next
+92c3737a2473 block: add a bio_submit_or_kill helper
+6fa747550e35 block: factor out a bio_await helper
+65565ca5f99b block: unify the synchronous bi_end_io callbacks
+cc91702dedc5 Merge branch 'for-7.1/block' into for-next
+8a34e88769f6 ublk: eliminate permanent pages[] array from struct ublk_buf
+08677040a911 ublk: enable UBLK_F_SHMEM_ZC feature flag
+4d4a512a1f87 ublk: add PFN-based buffer matching in I/O path
+2fb0ded237bb ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
+dec615fa43c3 Merge branch 'for-7.1/block' into for-next
+fa0cac9a5158 drbd: use get_random_u64() where appropriate
+0b581d2fb4cf Merge branch 'for-7.1/block' into for-next
+a9c4b1d37622 drbd: remove DRBD_GENLA_F_MANDATORY flag handling
+d436cfb3a259 Merge branch 'for-7.1/block' into for-next
+e9b004ff8306 blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
+09ebc43b5edc Merge branch 'for-7.1/block' into for-next
+0842186d2c4e ublk: reset per-IO canceled flag on each fetch
+cba82993308d zram: change scan_slots to return void
+bf989ade270d zram: propagate read_from_bdev_async() errors
+f0f6f7871430 zram: optimize LZ4 dictionary compression performance
+301f39220096 zram: unify and harden algo/priority params handling
+cedfa028b54e zram: remove chained recompression
+5004a27edba5 zram: drop ->num_active_comps
+ed19b9d5504f zram: do not autocorrect bad recompression parameters
+241f9005b1c8 zram: do not permit params change after init
+c09fb53d293a zram: use statically allocated compression algorithm names
+6030f93e5c71 Merge branch 'for-7.1/io_uring-fuse' into for-next
+29ebfdd7db89 io_uring/rsrc: rename io_buffer_register_bvec()/io_buffer_unregister_bvec()
+6568edbea553 Merge branch 'for-7.1/block' into for-next
+a175ee827331 block: use sysfs_emit in sysfs show functions
+c691e4b0d80b bio: fix kmemleak false positives from percpu bio alloc cache
 f91ffe89b201 blk-iocost: fix busy_level reset when no IOs complete
 23308af722fe blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
 b2a78fec344e zloop: add max_open_zones option
 2a2f520fda82 block: fix zones_cond memory leak on zone revalidation error paths
 267ec4d7223a loop: fix partition scan race between udev and loop_reread_partitions()
 499d2d2f4cf9 sed-opal: Add STACK_RESET command
-c61825bb46bc Merge branch 'vfs-7.1.integrity' into vfs.all
-fc2093641448 zram: unify and harden algo/priority params handling
-4fd453f16446 zram: remove chained recompression
-e2b717936d1a zram: drop ->num_active_comps
-3578bb37f7d1 zram: do not autocorrect bad recompression parameters
-5331373bfebd zram: do not permit params change after init
 2b31e86387e6 drbd: Balance RCU calls in drbd_adm_dump_devices()
 f9480ecf939d bdev: Drop pointless invalidate_inode_buffers() call
-b00ff1b25f85 zram: use statically allocated compression algorithm names
 630bbba45cfd drbd: use genl pre_doit/post_doit
 829def1e35ca zloop: forget write cache on force removal
 eff8d1656e83 zloop: refactor zloop_rw
--------------------

    "git log --oneline block/" between next-20260402 and next-20260413 shows the following diff:

--------------------
-9b75c6e054b7 Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
-eca714c0aac1 Merge branch 'vfs-7.1.bh.metadata' into vfs.all
+4391dc7df11d Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
+f2bab85781e8 Merge branch 'vfs-7.1.bh.metadata' into vfs.all
+539fb773a3f7 block: refactor blkdev_zone_mgmt_ioctl
+92c3737a2473 block: add a bio_submit_or_kill helper
+6fa747550e35 block: factor out a bio_await helper
+65565ca5f99b block: unify the synchronous bi_end_io callbacks
+e9b004ff8306 blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
+a175ee827331 block: use sysfs_emit in sysfs show functions
+c691e4b0d80b bio: fix kmemleak false positives from percpu bio alloc cache
 f91ffe89b201 blk-iocost: fix busy_level reset when no IOs complete
 23308af722fe blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
 2a2f520fda82 block: fix zones_cond memory leak on zone revalidation error paths
--------------------

Possible approaches for finding the exact commit that is causing this problem:

  (a) Revert all changes in the block layer from linux.git and monitor for one week for whether this
      problem is still happening (because linux.git is more frequently hitting this problem than
      linux-next.git ).

  (b) Revert all changes in the block layer from linux-next.git and monitor for two weeks for
      whether this problem is still happening (less reliable than linux.git but a candidate).

  (c) Let sashiko review all changes between v7.0 and v7.1 that may cause this problem.
      (Human developers have no time to review. But is investigation with moving baseline commit
      possible for sashiko ?)

  (d) Any ideas?

P.S. Since the loop driver is a critical infrastructure for testing filesystems by syzbot,
I want this problem be addressed before 7.1 is released.
