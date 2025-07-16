Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC051EA7D2
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650769; cv=none; b=dCl/WgDrwtitUfTgNQxLkDsyBjVHeBoreuwlud8KjHWqBl/8Q8Gbkt4cGHDInd2GZQ9MPNmvMPHPDjQONSxoZJu8NNCO4wJgpl70MeQfaMFHd4axz1D3fua9pvkpyzPV7ut0TKXMTGSRDvULKjxwQ+bt4UgPr2MxU9FqvZ2K4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650769; c=relaxed/simple;
	bh=SSEcvsfNdFTMymvo2j5DOCIUVrUd6bODDh+sgoJUCB0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jdLfE/UZfzeYpMFnAizcPvnGV773rDoEiff2S+1Zfdg/s5CM6MCHftdaYgbe70FThAJWmOJfruaEeQ6f390IYFUIU0AqhtT9Iqp5MfjlU3SPF0vlLULUkRFLTlLHxKwA8UI+xtpE51yZAOUFG+yNoC3kc73lbZ5fjd8vo6L91LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bhnfP1XhNzYQv0w
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 15:26:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F15441A2206
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 15:26:03 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMKVHdoWOy+AQ--.2420S3;
	Wed, 16 Jul 2025 15:26:03 +0800 (CST)
Subject: Re: Improper io_opt setting for md raid5
To: Coly Li <colyli@kernel.org>, hch@lst.de
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9b4027e8-6efa-7b28-8f00-3f4a5435b6c9@huaweicloud.com>
Date: Wed, 16 Jul 2025 15:26:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhMKVHdoWOy+AQ--.2420S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rCFWxKF4fCF47GFWrAFb_yoW5Ww1DpF
	nruF9rZayjqF17Za4kA3W3CFZYvr45KrWxCF1rCws5uw1v9r129rWxtFy5Xr97Krs8u3yU
	t3WrtryDZayj9rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/15 23:56, Coly Li 写道:
> Then when my raid5 array sets its queue limits, because its io_opt is 64KiB*7,
> and the raid component sata hard drive has io_opt with 32767 sectors, by
> calculation in block/blk-setting.c:blk_stack_limits() at line 753,
> 753         t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> the calculated opt_io_size of my raid5 array is more than 1GiB. It is too large.

Perhaps we should at least provide a helper for raid5 that we prefer
raid5 io_opt over underlying disk's io_opt. Because of raid5 internal
implemation, chunk_size * data disks is the best choice, there will be
significant differences in performance if not aligned with io_opt.

Something like following:

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..04e7b4808e7a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -700,6 +700,7 @@ int blk_stack_limits(struct queue_limits *t, struct 
queue_limits *b,
                 t->features &= ~BLK_FEAT_POLL;

         t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
+       t->flags |= (b->flags & BLK_FLAG_STACK_IO_OPT);

         t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
         t->max_user_sectors = min_not_zero(t->max_user_sectors,
@@ -750,7 +751,10 @@ int blk_stack_limits(struct queue_limits *t, struct 
queue_limits *b,
                                      b->physical_block_size);

         t->io_min = max(t->io_min, b->io_min);
-       t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+       if (!t->io_opt || !(t->flags & BLK_FLAG_STACK_IO_OPT) ||
+           (b->flags & BLK_FLAG_STACK_IO_OPT))
+           t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+
         t->dma_alignment = max(t->dma_alignment, b->dma_alignment);

         /* Set non-power-of-2 compatible chunk_sectors boundary */
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5b270d4ee99c..bb482ec40506 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7733,6 +7733,7 @@ static int raid5_set_limits(struct mddev *mddev)
         lim.io_min = mddev->chunk_sectors << 9;
         lim.io_opt = lim.io_min * (conf->raid_disks - conf->max_degraded);
         lim.features |= BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
+       lim.flags |= BLK_FLAG_STACK_IO_OPT;
         lim.discard_granularity = stripe;
         lim.max_write_zeroes_sectors = 0;
         mddev_stack_rdev_limits(mddev, &lim, 0);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d9..65317e93790e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_flags_t;
  /* passthrough command IO accounting */
  #define BLK_FLAG_IOSTATS_PASSTHROUGH   ((__force blk_flags_t)(1u << 2))

+/* ignore underlying disks io_opt */
+#define BLK_FLAG_STACK_IO_OPT          ((__force blk_flags_t)(1u << 3))
+
  struct queue_limits {
         blk_features_t          features;
         blk_flags_t             flags;

