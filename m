Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820680;
	b=zRs9EUGV8gn195qznOJc+KGCuQQBIMsAZIVeyVJ2ZLSVmh31XFX4/0PmumRt/YO8YtSJ
	 eXiDCv8BiAwcjPFhVeIP+OCVl99sncF2QOQQl03wJtYpwel2eZULyRghnNFPbUhrYAKwO
	 tBBBQXjEySlPQ8d3DNilgkKdVBzyL3S/qfMvbyk4vCkOnHLdJdlXG1Ep2taPTJIAJ6Biq
	 6sMYmBXy4d6Z1mkVKlkFX2SgZ/SlnjIRdz4xUQwj6O7krp6P0FOF9iq2lPBVns31JZQSz
	 salxoc/jUaZaSdkDHbommryvopBo5hAifclNJtcs2kgQqmyto0PKbMj4Y7zsZTWAmkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject;
	bh=87Z8zwJarjKAZcG7q37D5+mnW6z05/4D2Aky4jDPXkY=;
	b=3ibYd3vKGp4rYa8TaNRZQUaHV3F81sYNRuavJbEH+bB7fIU22VBc6bEZ7E5j4TlWsGFZ
	 UZEH51UQjSnQd+v55h5wFQubWfGD1Y+HLV9R+oXNWBb6iLDyH5Y2aabqJp8waWEItfwIi
	 d+sfNUUXthf2vG7Agm1dT0Y45m/DS/7O4HI5NV/XU24mektJG9ciISPtvrSoda0f+8I1c
	 hNs2O+AQJRZ15q/sAZo0W3MEozxZVlXWWdXLz/CFAPhfpQEdqfXtFyOVUYvBf6i4uSep0
	 mk9nqwgYkY5iAXZqVmvn1kyYULwa5VkCDeEzdoL8n1wgWNtZ5odbvP4U3Pzbhx6vU1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8oj7753;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1C606C59F
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 19:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3D1C606C59F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8oj7753
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c434376dbebso222559166b.1
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820678; x=1794425478; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87Z8zwJarjKAZcG7q37D5+mnW6z05/4D2Aky4jDPXkY=;
        b=F8oj7753/Vser52ngZRVswZ1IJBhvPgzWQF1Y6lD12L/hF2sJWymrX+Em2/w5nn7ZT
         SYwhVU+kzbn/M6RsKafESjbH/ZX9slPJ0rpYSwM3t/HdaySIrgOSYPesjCqUUHGR6Gyl
         BZrWyWaTXK87SM5DGs+eKZzXiMmDYOzU42+EFj1Ew+Wo56661buP7hw0X+FbPkJRTSPD
         SpzR4GHIz1hEfGGpAi9QeisDgZCoFHibeyo4j5U7lZcmAMY4n91BRPM6S5sXZQQXtqLf
         7r+wgBQxx1+7yQYBsC6gQNVia8vhXhgR+2megAW3lWNjJgGbAN6QgyW3R37aLeLVVOs4
         OdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820678; x=1794425478;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=87Z8zwJarjKAZcG7q37D5+mnW6z05/4D2Aky4jDPXkY=;
        b=nMRG+iD37Cs+06oqXq8Fex0VhSQkdyLtT81hbMUpUMwVC8wdeb79vodLlTqWNEMJIX
         ySykYdnryYbHD7d39RA3nRSc2NpEwSE7A07w+ZUkL4J9D3pjRd5uNKa2VpkOHiNiACNq
         uH9LntWVdrCRSXkmXfroA+j/R1prr7pivmy5X6iDNU4LO9VpORHyNa7PHF8Ah1K1BEps
         hW/k5/b3hYxBaEiefE+92W4WP6SfCH5OweW+DjlF5eJ+LUmt4GhYyPfV013M2QZ+PIbC
         /cIw8CpHezXtUP2ATuC1TGljOxlPPpJoEYAoKSOBLELfcdBgqLHex3OC2ZrXSSAGPxvY
         h5sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYkzzPfjBbzfG69jBOAzGRlf+AFG3RGVikOzqBaW+XLS0mWEgd5sbttivhlQqCf0Y5L5OBxMzRpJdwvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/bVqHitPWQEZ+baPloHHBNW07QEWKX6fEA/ltWrq+1pyPESRiC
	I5bKp/+nDyjSfjbyUiTGx3lkBVb52u4ignPDXLicDGwIo1aqbg4+wvGV
X-Gm-Gg: AYBFou0IG8X71wztSCwkyMLb/XDNv9vh/UZK3dsJncjY1mRo/KN9OJo03AEF5xD+0y6
	t/5EOpUptIPu/7m/ZTL3yFhOE7iYeyDYP2JiRPOgmCBhatF4vbeaABdJfhgQU7ZjK8Njr/Vromw
	mzrNd0PTPrix7M6qxus53V1AXWE2O5hbDAf195/sU8kqsNerIfamAL6X76buGowoyGBZXX9/l8k
	zbNpT2Er0mVqyV/inIzdxk6EmyGwYZPtqs1MKMVPnFQ5uVsc8f69NO4ixF3iFp0yLUPuO2ehdfY
	gWEJlIJSTZalju9j4PFvypnRXwXIv3FgP5hOM62lXaYGXU6qWVA+lUjAK8mYWJ811BdFIMJaCLJ
	SFcQomQSwHuhw5MR8I3pqIrMLdQIi2W6IXVftJ4KkGs6XAnoARMQIAEgES8lwgccGHBQs/FNMBP
	e2woDu68VDjB73zXa/uAcfriH3rVwc1AX11Wa4mu7WPINuC2vwDkiqf+Xb7mP7U1jn1YU/PB1lI
	m7BukIhG0MwaHy0Lj8uEWZgKvLpY6OCGB9c4nsNYH8YJU0tDBUt2rI9U6QbMdsTeJIxSZ+ReMM0
	QuGUQJD9fyeDLc4+cgxm2YlW8HkEQ2bUrXFmrsR4tXcg4rZ0Wf1eTFh1+ugA6fJYBsNeY5L0+MN
	BLgaZ0bHlns2FMi9g7BxIEGgNvOlCsmgtEzUNCA==
X-Received: by 2002:a17:906:dc8c:b0:c46:7fa4:9212 with SMTP id a640c23a62f3a-c4d2070243fmr44806466b.23.1793820678031;
        Wed, 04 Nov 2026 11:31:18 -0800 (PST)
Received: from localhost ([85.9.211.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e48d0dcsm100093566b.70.2026.11.04.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:31:17 -0800 (PST)
Date: Thu, 05 Nov 2026 00:31:14 +0500
Message-ID: <99d859b83b39f4941dd214d30ea796c0@gmail.com>
From: Mark Korenberg <socketpair@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: [RFC] ublk: removing the disk of a dead server hangs on a stuck filesystem
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

Hi Ming,

When a ublk server dies and the device is not recoverable,
ublk_ch_release_work_fn() stops it with del_gendisk() under ub->mutex.
The disk isn't marked dead, so del_gendisk() reports a normal removal
and fs_bdev_mark_dead() syncs the filesystem on it. All I/O to the disk
fails by then, but if the filesystem is stuck for another reason, the
sync never returns, and STOP_DEV and DEL_DEV of the device sleep on
ub->mutex uninterruptibly until reboot.

I hit it with btrfs on a ublk zoned device whose writeback deadlocked
on its own (a btrfs bug, handled separately); killing the server was
the last resort. It reproduces without btrfs: XFS on a ublk loop
device, its external log on dm-linear over null_blk;
"dmsetup suspend --nolockfs --noflush" the log, write a file and syncfs,
kill -9 the server. The release work then sits in

  xlog_wait_on_iclog <- xfs_fs_sync_fs <- sync_filesystem
  <- fs_bdev_mark_dead <- bdev_mark_dead <- blk_report_disk_dead
  <- __del_gendisk <- del_gendisk <- ublk_stop_dev_unlocked
  <- ublk_ch_release_work_fn

and DEL_DEV in ublk_stop_dev(). Same with ext4 and an external journal.
The series "ublk: don't let one stuck device block control of all ublk
devices" keeps this from blocking ADD_DEV/DEL_DEV of the other devices,
but the device itself stays stuck.

Since the server is gone, the removal should be a surprise one. What I
found trying to fix it:

1. blk_mark_disk_dead() before del_gendisk() under ub->mutex isn't
   enough: fs_bdev_mark_dead() then calls ->shutdown(), which blocks the
   same way (xlog_force_shutdown() waits for the log I/O,
   jbd2_journal_abort() writes the journal superblock), and
   del_gendisk() itself can wait in bdi_unregister() -> wb_shutdown()
   for a flusher stuck in the filesystem. So it has to run without
   ub->mutex.

2. Dropping ub->mutex around the removal opens windows that the
   current code doesn't expect:
   - a STOP_DEV/DEL_DEV waiting on ub->mutex runs a normal, syncing
     del_gendisk() before GD_DEAD is set;
   - a STOP_DEV/DEL_DEV issued right after the server exited, before
     the release work runs, does the syncing removal itself;
   - with UBLK_F_USER_RECOVERY, the release work can set QUIESCED or
     FAIL_IO on a disk that is being removed, and recovery can bring
     it back;
   - once the release work has cleared UB_STATE_OPEN, a new server can
     open /dev/ublkcN and FETCH, which resets the queues' canceling,
     fail_io and force_abort while the old disk still drains;
   - UPDATE_SIZE and REG_BUF/UNREG_BUF can touch the disk meanwhile.

A version that sets UBLK_S_DEV_DEAD under ub->mutex, then does
blk_mark_disk_dead() + del_gendisk() without it and detaches the disk
after, fixes the hang in my tests, but has the recovery and new-server
problems above, and whoever gets there first (the release work, or a
STOP_DEV/DEL_DEV from userspace) can still block unkillably in the
filesystem.

Which direction would you prefer?

(a) An explicit "removing" state, set under ub->mutex, that the release
    work, FETCH, recovery, UPDATE_SIZE and the buffer registration
    check; the removal itself runs from a work item without ub->mutex,
    and STOP_DEV/DEL_DEV wait for it killably.

(b) Leave the removal of a server-less device entirely to the release
    work, run it there without ub->mutex, and make STOP_DEV/DEL_DEV of
    such a device only wait for it, killably.

(c) Something else, e.g. never syncing on the release path and
    accepting that the release work may block, as long as it doesn't
    hold ub->mutex.

I can send the draft of the version above if it helps.

This analysis was done with the help of an AI coding assistant
(Claude); I reviewed and tested it.

Thanks,
Mark
