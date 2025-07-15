Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4B25486D
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595023; cv=none; b=hU6lCuiJNMdSJ4GXo3BF4ehJpqVEQbnySbOVlkHin0GXaa4/l6S2WGRj2MqlyUuNOxm43ed0k/B0fKmDtJR4FJRVmTtRmCmy9IwQ4j2a8PyiuSxEopXxixLZCleue8bZ412eih65yCeanlGazwYiI+3ge5poh1q9PPOVJr3s/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595023; c=relaxed/simple;
	bh=BEZrOkhpb24HE3sPI9hTEW3vL9h+HeOuOxJOLMzukHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NizTEyvTt/WJ3JAdPztReFNzudaNj7ZyKWVNKP+a21ZNM7xxVQrAergB4yZlC8XEIM0+X7OGJfW/zIeBOEcXyrOKkpXS5EqiLlAtfS+sgWNk5e+V8gU71r0PVg3bRfX9uIOQGr3ngjMTVSspI1p27EvXWKfepMl/I3bZKRWD/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTzMiOMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTzMiOMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BC7C4CEFB;
	Tue, 15 Jul 2025 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595021;
	bh=BEZrOkhpb24HE3sPI9hTEW3vL9h+HeOuOxJOLMzukHQ=;
	h=Date:From:To:Cc:Subject:From;
	b=cTzMiOMnm+FAQXE0H7U5dEuGw8bJnYsDpqd03JKYrvRk0K9szE1CTFiBgRbscVksR
	 jKtvhMZKMNUs4HLLE+VBY2I75bb/azMGPXnL8OG19cF2GiZGhrxLjid1YG/l4R/ROg
	 Xxqwh2VlwZMw5vrX0bwBCYtny2ew1HMYQeJyh/lzmHdb2MvZKDvJrJq+oYwP3X/H8c
	 Ulh3ImWwkJo5DyImmpOoMuKkUewFpwD5NFJZmcR1VH1VX0A7llV27spqP/ecwz92mP
	 cnh0D6uoVJ2PkVs+N9EQ3EjskBLdCQRH/k9qLunt21HSM+kp+oz++0xBAfpwUd13dp
	 uiKFcS3CR2AlA==
Date: Tue, 15 Jul 2025 23:56:57 +0800
From: Coly Li <colyli@kernel.org>
To: hch@lst.de
Cc: linux-block@vger.kernel.org
Subject: Improper io_opt setting for md raid5
Message-ID: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Christoph,

I don’t know why is the proper person to ask for this issue, but I see your
patch in the questionable code path and I know you are always helpful, so
ask you here.

Let me rescript the problem I encountered.
1, There is an 8 disks raid5 with 64K chunk size on my machine, I observe
/sys/block/md0/queue/optimal_io_size is very large value, which isn’t
reasonable size IMHO.

2,  It was from drivers/scsi/mpt3sas/mpt3sas_scsih.c, 
11939 static const struct scsi_host_template mpt3sas_driver_template = {
11940         .module                         = THIS_MODULE,
11941         .name                           = "Fusion MPT SAS Host",
11942         .proc_name                      = MPT3SAS_DRIVER_NAME,
11943         .queuecommand                   = scsih_qcmd,
11944         .target_alloc                   = scsih_target_alloc,
11945         .sdev_init                      = scsih_sdev_init,
11946         .sdev_configure                 = scsih_sdev_configure,
11947         .target_destroy                 = scsih_target_destroy,
11948         .sdev_destroy                   = scsih_sdev_destroy,
11949         .scan_finished                  = scsih_scan_finished,
11950         .scan_start                     = scsih_scan_start,
11951         .change_queue_depth             = scsih_change_queue_depth,
11952         .eh_abort_handler               = scsih_abort,
11953         .eh_device_reset_handler        = scsih_dev_reset,
11954         .eh_target_reset_handler        = scsih_target_reset,
11955         .eh_host_reset_handler          = scsih_host_reset,
11956         .bios_param                     = scsih_bios_param,
11957         .can_queue                      = 1,
11958         .this_id                        = -1,
11959         .sg_tablesize                   = MPT3SAS_SG_DEPTH,
11960         .max_sectors                    = 32767,
11961         .max_segment_size               = 0xffffffff,
11962         .cmd_per_lun                    = 128,
11963         .shost_groups                   = mpt3sas_host_groups,
11964         .sdev_groups                    = mpt3sas_dev_groups,
11965         .track_queue_depth              = 1,
11966         .cmd_size                       = sizeof(struct scsiio_tracker),
11967         .map_queues                     = scsih_map_queues,
11968         .mq_poll                        = mpt3sas_blk_mq_poll,
11969 };
at line 11960, max_sectors of mpt3sas driver is defined as 32767.

Then in drivers/scsi/scsi_transport_sas.c, at line 241 inside sas_host_setup(),
shots->opt_sectors is assigned by 32767 from the following code,
240         if (dma_dev->dma_mask) {
241                 shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
242                                 dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
243         }

Then in drivers/scsi/sd.c, inside sd_revalidate_disk() from the following coce,
3785         /*
3786          * Limit default to SCSI host optimal sector limit if set. There may be
3787          * an impact on performance for when the size of a request exceeds this
3788          * host limit.
3789          */
3790         lim.io_opt = sdp->host->opt_sectors << SECTOR_SHIFT;
3791         if (sd_validate_opt_xfer_size(sdkp, dev_max)) {
3792                 lim.io_opt = min_not_zero(lim.io_opt,
3793                                 logical_to_bytes(sdp, sdkp->opt_xfer_blocks));
3794         }

lim.io_opt of all my sata disks attached to mpt3sas HBA are all 32767 sectors,
because the above code block.

Then when my raid5 array sets its queue limits, because its io_opt is 64KiB*7,
and the raid component sata hard drive has io_opt with 32767 sectors, by
calculation in block/blk-setting.c:blk_stack_limits() at line 753,
753         t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
the calculated opt_io_size of my raid5 array is more than 1GiB. It is too large.

I know the purpose of lcm_not_zero() is to get an optimized io size for both
raid device and underlying component devices, but the resulted io_opt is bigger
than 1 GiB that's too big.

For me, I just feel uncomfortable that using max_sectors as opt_sectors in
sas_host_stup(), but I don't know a better way to improve. Currently I just
modify the mpt3sas_driver_template's max_sectors from 32767 to 64, and observed
5~10% sequetial write performance improvement (direct io) for my raid5 devices
by fio.

So there should be something to fix. Can you take a look, or give me some hint
to fix?

Thanks in advance.

Coly Li






-- 
Coly Li
