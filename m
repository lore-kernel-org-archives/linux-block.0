Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743EB20E312
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270651; cv=none; b=vAR+vgfio3Sh3PjHVNYjd/Y53YxIELbrTPqLtdGQKRWs78PM9uOhqqzLGymOm7fqMpJcYneQ5dfS3Wo6N21b7bmv/ZN5uOtYqkRYveE1YZePGmP7DIV2oYOX+zPi5K7wXiPQFVhDJrCZcW1r6OalNwbxy4zwG+1eZvl9cnErmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270651; c=relaxed/simple;
	bh=gPaOFN88TzYUZhGmf4nhN4wXrdFv7Lkvt2l8TwbJZuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IavQnohDzbCJBEu5gDGwjMHzLA7rQ9ba21B4b1XhkUgv3bFlBLSGvJLQqSe9QD3FGUynmj1QEOPUAnj8eFa4QGSNAhhRbfHVwZaLDbuf8oX+H0rz5rjpzaOs0/AofUGRy9j6aaAo+1Gw6F4waWTVe9gzYI9YV95hRjzdSeQoVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qv5BBzRh; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qv5BBzRh"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XVW8g1rsyzlhw8X;
	Fri, 18 Oct 2024 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729270636; x=1731862637; bh=lnvPlNDj8BCbCtKTPAnfu+/R
	eFqfdCTic4b7CP7dkuc=; b=Qv5BBzRhOlSS/tB1+VhAjwThycXI8KuH6ARsDRph
	HRv/2ftGaylgCfsw0/PBDlxoZj5iYTDEJNlPzWpjZ++ZpfznVLhUjsw+Gl9qsVSY
	oOTZd6wC6o1tw3FQHb4fRb9KNIh5214MZR1TNAIkzUerq+jy3VDQLDY+wfI1h6S6
	ng1xqwvhEWSj5WmwZ6aYGK3jcOW4rFlQixd8qr0R7SGsG7+fj+rEYYtuKS6uLXQX
	DIx4QxmRdPd/M3FLnrneoU94sl3rV3k4mpjcaaQik2XlUXHzj0hlI7SvMEasTYCJ
	iAtp/mh5C3I6VF7dv+994NLnBC5G1voQGANHwfSGlh+Hxg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WLW03YRtF5CL; Fri, 18 Oct 2024 16:57:16 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XVW8V3bNpzlgT1K;
	Fri, 18 Oct 2024 16:57:13 +0000 (UTC)
Message-ID: <46493f6f-850e-459e-a4be-116deb5d3ca0@acm.org>
Date: Fri, 18 Oct 2024 09:57:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for supporting
 lockdep
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241018013542.3013963-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/17/24 6:35 PM, Ming Lei wrote:
> Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> and blk_enter_queue().
> 
> Turns out the two are just like one rwsem, so model them as rwsem for
> supporting lockdep:
> 
> 1) model blk_mq_freeze_queue() as down_write_trylock()
> - it is exclusive lock, so dependency with blk_enter_queue() is covered
> - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently
> 
> 2) model blk_enter_queue() as down_read()
> - it is shared lock, so concurrent blk_enter_queue() are allowed
> - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> - blk_queue_exit() is often called from other contexts(such as irq), and
> it can't be annotated as rwsem_release(), so simply do it in
> blk_enter_queue(), this way still covered cases as many as possible
> 
> NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> blk_mq_unfreeze_queue() from different context, so it is the only
> exception for the modeling. Add one tagset flag to exclude it from
> the lockdep support.
> 
> With lockdep support, such kind of reports may be reported asap and
> needn't wait until the real deadlock is triggered.
> 
> For example, the following lockdep report can be triggered in the
> report[3].

Hi Ming,

Thank you for having reported this issue and for having proposed a
patch. I think the following is missing from the patch description:
(a) An analysis of which code causes the inconsistent nested lock order.
(b) A discussion of potential alternatives.

It seems unavoidable to me that some code freezes request queue(s)
before the limits are updated. Additionally, there is code that freezes
queues first (sd_revalidate_disk()), executes commands and next updates
limits. Hence the inconsistent order of freezing queues and obtaining
limits_lock.

The alternative (entirely untested) solution below has the following
advantages:
* No additional information has to be provided to lockdep about the
   locking order.
* No new flags are required (SKIP_FREEZE_LOCKDEP).
* No exceptions are necessary for blk_queue_exit() nor for the NVMe
   driver.

Thanks,

Bart.


diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 83b696ba0cac..50962ca037d7 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -211,6 +211,7 @@ static ssize_t flag_store(struct device *dev, const 
char *page, size_t count,
  	if (err)
  		return err;

+	blk_mq_freeze_queue(q);
  	/* note that the flags are inverted vs the values in the sysfs files */
  	lim = queue_limits_start_update(q);
  	if (val)
@@ -218,7 +219,6 @@ static ssize_t flag_store(struct device *dev, const 
char *page, size_t count,
  	else
  		lim.integrity.flags |= flag;

-	blk_mq_freeze_queue(q);
  	err = queue_limits_commit_update(q, &lim);
  	blk_mq_unfreeze_queue(q);
  	if (err)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc105..a3d2613bad1d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1106,12 +1106,12 @@ cache_type_store(struct device *dev, struct 
device_attribute *attr,

  	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);

+	blk_mq_freeze_queue(disk->queue);
  	lim = queue_limits_start_update(disk->queue);
  	if (virtblk_get_cache_mode(vdev))
  		lim.features |= BLK_FEAT_WRITE_CACHE;
  	else
  		lim.features &= ~BLK_FEAT_WRITE_CACHE;
-	blk_mq_freeze_queue(disk->queue);
  	i = queue_limits_commit_update(disk->queue, &lim);
  	blk_mq_unfreeze_queue(disk->queue);
  	if (i)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca4bc0ac76ad..1f6ab9768ac7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -175,9 +175,9 @@ cache_type_store(struct device *dev, struct 
device_attribute *attr,
  		sdkp->WCE = wce;
  		sdkp->RCD = rcd;

+		blk_mq_freeze_queue(sdkp->disk->queue);
  		lim = queue_limits_start_update(sdkp->disk->queue);
  		sd_set_flush_flag(sdkp, &lim);
-		blk_mq_freeze_queue(sdkp->disk->queue);
  		ret = queue_limits_commit_update(sdkp->disk->queue, &lim);
  		blk_mq_unfreeze_queue(sdkp->disk->queue);
  		if (ret)
@@ -481,9 +481,9 @@ provisioning_mode_store(struct device *dev, struct 
device_attribute *attr,
  	if (mode < 0)
  		return -EINVAL;

+	blk_mq_freeze_queue(sdkp->disk->queue);
  	lim = queue_limits_start_update(sdkp->disk->queue);
  	sd_config_discard(sdkp, &lim, mode);
-	blk_mq_freeze_queue(sdkp->disk->queue);
  	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
  	blk_mq_unfreeze_queue(sdkp->disk->queue);
  	if (err)
@@ -592,9 +592,9 @@ max_write_same_blocks_store(struct device *dev, 
struct device_attribute *attr,
  		sdkp->max_ws_blocks = max;
  	}

+	blk_mq_freeze_queue(sdkp->disk->queue);
  	lim = queue_limits_start_update(sdkp->disk->queue);
  	sd_config_write_same(sdkp, &lim);
-	blk_mq_freeze_queue(sdkp->disk->queue);
  	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
  	blk_mq_unfreeze_queue(sdkp->disk->queue);
  	if (err)
@@ -3700,7 +3700,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
  	struct scsi_disk *sdkp = scsi_disk(disk);
  	struct scsi_device *sdp = sdkp->device;
  	sector_t old_capacity = sdkp->capacity;
-	struct queue_limits lim;
+	struct queue_limits lim = {};
  	unsigned char *buffer;
  	unsigned int dev_max;
  	int err;
@@ -3724,8 +3724,6 @@ static int sd_revalidate_disk(struct gendisk *disk)

  	sd_spinup_disk(sdkp);

-	lim = queue_limits_start_update(sdkp->disk->queue);
-
  	/*
  	 * Without media there is no reason to ask; moreover, some devices
  	 * react badly if we do.
@@ -3804,7 +3802,36 @@ static int sd_revalidate_disk(struct gendisk *disk)
  	kfree(buffer);

  	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
+	{
+		struct queue_limits lim2 =
+			queue_limits_start_update(sdkp->disk->queue);
+		/* Keep the lim2 member assignments below in alphabetical order. */
+		lim2.alignment_offset = lim.alignment_offset;
+		lim2.atomic_write_hw_boundary = lim.atomic_write_hw_boundary;
+		lim2.atomic_write_hw_max = lim.atomic_write_hw_max;
+		lim2.atomic_write_hw_unit_max = lim.atomic_write_hw_unit_max;
+		lim2.atomic_write_hw_unit_min = lim.atomic_write_hw_unit_min;
+		lim2.chunk_sectors = lim.chunk_sectors;
+		lim2.discard_alignment = lim.discard_alignment;
+		lim2.discard_granularity = lim.discard_granularity;
+		lim2.dma_alignment = lim.dma_alignment;
+		lim2.features |= lim.features;
+		lim2.integrity = lim.integrity;
+		lim2.logical_block_size = lim.logical_block_size;
+		lim2.max_active_zones = lim.max_active_zones;
+		lim2.max_hw_discard_sectors = lim.max_hw_discard_sectors;
+		lim2.max_hw_sectors = lim.max_hw_sectors;
+		lim2.max_integrity_segments = lim.max_integrity_segments;
+		lim2.max_open_zones = lim.max_open_zones;
+		lim2.max_segment_size = lim.max_segment_size;
+		lim2.max_segments = lim.max_segments;
+		lim2.max_write_zeroes_sectors = lim.max_write_zeroes_sectors;
+		lim2.max_zone_append_sectors = lim.max_zone_append_sectors;
+		lim2.physical_block_size = lim.physical_block_size;
+		lim2.virt_boundary_mask = lim.virt_boundary_mask;
+		lim2.zone_write_granularity = lim.zone_write_granularity;
+		err = queue_limits_commit_update(sdkp->disk->queue, &lim2);
+	}
  	blk_mq_unfreeze_queue(sdkp->disk->queue);
  	if (err)
  		return err;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 198bec87bb8e..e9c1673ce6bb 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -795,9 +795,9 @@ static int get_sectorsize(struct scsi_cd *cd)
  		set_capacity(cd->disk, cd->capacity);
  	}

+	blk_mq_freeze_queue(q);
  	lim = queue_limits_start_update(q);
  	lim.logical_block_size = sector_size;
-	blk_mq_freeze_queue(q);
  	err = queue_limits_commit_update(q, &lim);
  	blk_mq_unfreeze_queue(q);
  	return err;

