Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B747F3C3;
	Tue, 22 Sep 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100620; cv=none; b=mmQpGDMOraQ01b1k8/vqX8ELH2H/fD2UZUj/CV+Sj3Q72hoMjdQKUQ2BhxN0BcqI0OyhaW2191Atxiiwh+tS2FPgA3825tQ3tzckPjLZAqlr3qgwKCYESwmp3n/KuIC0+JXz32gxHSQLpl0LNc4ne2mGINz3Xq9UnIpmltPutBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100620; c=relaxed/simple;
	bh=deKIgFiUGBErYiAo09/pFi8Zuuux40USuhet68Qc0jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKEqusmimhFuxLg1gA4HfGavfTj1beoqfuDmhNcXsnTGtrWXUSXt9E8r7R4HqygApG68NEM79zvgg9StPgHVG/6VvQY0Qisnqzwnd+q4HeT58hzfgg5sM3ge35Qrp2nMhgcEcbIyI+kbC1wVlnOdF+A4F8sG8I9YQmwaNnWuhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TzE1ft7S; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TzE1ft7S"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hq7Rs3fgFz1XM4TB;
	Tue, 22 Sep 2026 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790100601; x=1792692602; bh=6iFUwmy3Y7707Y6oNNSb5VkG
	F0O3ViC9MBP2z4P2CIs=; b=TzE1ft7Sw8h9N7ctQFg1mr3uZsJIFWnugd+GGPze
	w5/cxTs7YuwxpETzPcLbVh16/kNq742MCOw5TNGC32xYb/Ta5PpGoJPwhJYjCrOT
	VchYRkiwp04Da1nNzFNUk+XDXjB7aaSX13snXIfuLttV3JhZ4Rsa+T+ATe59Pp2W
	zM3v6kjkzvXm5a67gcmIsT7J6+QurLOh/r4WsLvFIMSefSLtbSRFdTBnxl2F7aQA
	dOw8clumwTKRKIAb8MCDKsK7t78o5e+iZoC4NO1R3uKCV1uhr8HmU4K+1aKs53hu
	BJOIF9//u4anBJglNZGVo9D4tfrPO43DuQsyKKGT8K/MWQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7bApeaQEWz9c; Tue, 22 Sep 2026 18:10:01 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hq7RR17XPz1XM4Sx;
	Tue, 22 Sep 2026 18:09:54 +0000 (UTC)
Message-ID: <ac1d3825-8a10-42e1-9eaa-f2ba51216660@acm.org>
Date: Tue, 22 Sep 2026 11:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] block: Add run_todo() operation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
 <afbf50a0-d409-45a3-8e95-99c04ca0e302@acm.org>
 <24ef93b9-7385-4dda-8912-f7c78f9705d1@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <24ef93b9-7385-4dda-8912-f7c78f9705d1@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 10:08 PM, Tetsuo Handa wrote:
> I think post_release() is misleading because post_release() is also called
> when disk->fops->open() in blkdev_get_whole() failed (and therefore
> bdev->bd_disk->fops->release() in blkdev_put_whole() from blkdev_get_whole()
> was not called).

Has it been considered to call the new callback only if fops->release()
has been invoked? Here is an (untested) example of how this could be
implemented:

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..82be4812a7a0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -766,7 +766,8 @@ static void blkdev_put_whole(struct block_device *bdev)
  		bdev->bd_disk->fops->release(bdev->bd_disk);
  }

-static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
+static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode,
+			    bool *called_release)
  {
  	struct gendisk *disk = bdev->bd_disk;
  	int ret;
@@ -793,18 +794,20 @@ static int blkdev_get_whole(struct block_device 
*bdev, blk_mode_t mode)
  		ret = bdev_disk_changed(disk, false);
  		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
  			blkdev_put_whole(bdev);
+			*called_release = true;
  			return ret;
  		}
  	}
  	return 0;
  }

-static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
+static int blkdev_get_part(struct block_device *part, blk_mode_t mode,
+			   bool *called_release)
  {
  	struct gendisk *disk = part->bd_disk;
  	int ret;

-	ret = blkdev_get_whole(bdev_whole(part), mode);
+	ret = blkdev_get_whole(bdev_whole(part), mode, called_release);
  	if (ret)
  		return ret;

@@ -821,6 +824,7 @@ static int blkdev_get_part(struct block_device 
*part, blk_mode_t mode)

  out_blkdev_put:
  	blkdev_put_whole(bdev_whole(part));
+	*called_release = true;
  	return ret;
  }

@@ -973,6 +977,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t 
mode, void *holder,
  {
  	bool unblock_events = true;
  	struct gendisk *disk = bdev->bd_disk;
+	bool called_release = false;
  	int ret;

  	if (holder) {
@@ -997,9 +1002,9 @@ int bdev_open(struct block_device *bdev, blk_mode_t 
mode, void *holder,
  	if (!bdev_may_open(bdev, mode))
  		goto put_module;
  	if (bdev_is_partition(bdev))
-		ret = blkdev_get_part(bdev, mode);
+		ret = blkdev_get_part(bdev, mode, &called_release);
  	else
-		ret = blkdev_get_whole(bdev, mode);
+		ret = blkdev_get_whole(bdev, mode, &called_release);
  	if (ret)
  		goto put_module;
  	bdev_claim_write_access(bdev, mode);
@@ -1037,7 +1042,14 @@ int bdev_open(struct block_device *bdev, 
blk_mode_t mode, void *holder,

  	return 0;
  put_module:
+	if (holder)
+		bd_abort_claiming(bdev, holder);
+	mutex_unlock(&disk->open_mutex);
+	if (called_release && disk->fops->post_release)
+		disk->fops->post_release(disk);
+	disk_unblock_events(disk);
  	module_put(disk->fops->owner);
+	return ret;
  abort_claiming:
  	if (holder)
  		bd_abort_claiming(bdev, holder);
@@ -1189,6 +1201,9 @@ void bdev_release(struct file *bdev_file)
  		blkdev_put_whole(bdev);
  	mutex_unlock(&disk->open_mutex);

+	if (disk->fops->post_release)
+		disk->fops->post_release(disk);
+
  	module_put(disk->fops->owner);
  put_no_open:
  	blkdev_put_no_open(bdev);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..f2a2f70a9582 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1577,6 +1577,7 @@ struct block_device_operations {
  			unsigned int flags);
  	int (*open)(struct gendisk *disk, blk_mode_t mode);
  	void (*release)(struct gendisk *disk);
+	void (*post_release)(struct gendisk *disk);
  	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
  			unsigned cmd, unsigned long arg);
  	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,

Thanks,

Bart.
