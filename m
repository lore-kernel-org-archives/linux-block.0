Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF68C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D082071A
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYW1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:27:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38747 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYW1i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:27:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id o8so2797120pls.5
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2019 14:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HzuHfRodH7WZHlYTmEwjSolWAoCZueWhG7BhVeThA0k=;
        b=dOucUm+l//6cP+XLmzIhMZtcgXZswnDG0m9GQie5mXlX2GtAlKUvYJOc6KmnY9RsVF
         ZEj7CMyMBgzfW8Sc6Av/mrkCchdN0+YZc7I61H7kJ7Q2i3ylNamgxTSuKUVF4Bomppvz
         y7htdGVC/dPD1C1D+kBerayBLEGzIYTcwQ/BMT6N3zIA2MbYNpvLKij457NaKOE1G+hQ
         IaHVL/QxIT1ARl+0xskRQfIxwMt1HdVQ8Onn/yKEpc64EVmNuMhS2TKuX61FNT4Guc5j
         qAWB2vhjybOTQHtDZbrR4IN4Xrv87k9cHIpGeDlU97GCVMmv1OfL7SIHssXtbfBSqjVp
         f0gw==
X-Gm-Message-State: APjAAAVzafvd8uXrZXp4+/kiFKxyaPPFeEnBMWp3946bK7Wgr/Wu8qx/
        TIY89lRz3+XSdd0XSOsJLO6H6lFn
X-Google-Smtp-Source: APXvYqyvFFVHoB2jh+kWhtpvHc+P4Oen8pVCyF0KbAQ8TXxhfzlWunYU8aRtdKJdToSK0jckVmBq1w==
X-Received: by 2002:a17:90a:d78b:: with SMTP id z11mr1911548pju.36.1574720856875;
        Mon, 25 Nov 2019 14:27:36 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m34sm9350555pgb.26.2019.11.25.14.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 14:27:35 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20190518004751.18962-1-jaegeuk@kernel.org>
 <20190518005304.GA19446@jaegeuk-macbookpro.roam.corp.google.com>
 <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
Message-ID: <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
Date:   Mon, 25 Nov 2019 14:27:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/19 11:41 AM, Bart Van Assche wrote:
> On 11/25/19 11:22 AM, Jaegeuk Kim wrote:
>> On 11/25, Bart Van Assche wrote:
>>> Thank you for the additional and very helpful clarification. Can you 
>>> have a look at the (totally untested) patch below? I prefer that 
>>> version because it prevents concurrent processing of requests and 
>>> syncing/killing the bdev.
>>
>> Yeah, I thought this was much cleaner way, but wasn't sure it could be 
>> doable
>> to sync|kill block device after freezing the queue. Is it okay?
> 
> Hi Jaegeuk,
> 
> That patch was based on an incorrect interpretation of the meaning of 
> lo_device. After having taken another loop at the block driver, I don't 
> think that calling sync after freezing the queue is OK. How about using 
> the following call sequence:
> * sync_blockdev()
> * blk_mq_freeze_queue()
> * kill_bdev()

This is what I had in mind (still untested):


Subject: [PATCH] loop: Avoid EAGAIN if the offset or the block_size are changed

After sync_blockdev() has been called, more requests can be submitted
to the loop device. These requests dirty additional pages, causing
loop_set_status() to return -EAGAIN. Not all user space code that
changes the offset and/or the block size handles -EAGAIN correctly.
Hence make sure that loop_set_status() does not return -EAGAIN.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: grygorii tertychnyi <gtertych@cisco.com>
Cc: Andrew Norrie <andrew.norrie@cgg.com>
Cc: <stable@vger.kernel.org>
Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
Reported-by: Gwendal Grignou <gwendal@chromium.org>
Reported-by: grygorii tertychnyi <gtertych@cisco.com>
Reported-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/block/loop.c | 56 ++++++++++++++++++--------------------------
  1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..84bdb3a6f6d0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1264,14 +1264,17 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
  		goto out_unlock;
  	}

-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	/*
+	 * Drain the page cache and the request queue. Set the "dying" flag to
+	 * prevent that kill_bdev() locks up.
+	 */
+	sync_blockdev(lo->lo_device);

-	/* I/O need to be drained during transfer transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	blk_set_queue_dying(lo->lo_queue);
+	blk_mq_freeze_queue_wait(lo->lo_queue);
+
+	/* Kill buffers that got dirtied after the sync_blockdev() call. */
+	kill_bdev(lo->lo_device);

  	err = loop_release_xfer(lo);
  	if (err)
@@ -1298,14 +1301,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)

  	if (lo->lo_offset != info->lo_offset ||
  	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
  		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
  			err = -EFBIG;
  			goto out_unfreeze;
@@ -1341,6 +1336,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
  	__loop_update_dio(lo, lo->use_dio);

  out_unfreeze:
+	blk_queue_flag_clear(QUEUE_FLAG_DYING, lo->lo_queue);
  	blk_mq_unfreeze_queue(lo->lo_queue);

  	if (!err && (info->lo_flags & LO_FLAGS_PARTSCAN) &&
@@ -1531,39 +1527,33 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)

  static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
  {
-	int err = 0;
-
  	if (lo->lo_state != Lo_bound)
  		return -ENXIO;

  	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
  		return -EINVAL;

-	if (lo->lo_queue->limits.logical_block_size != arg) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	/*
+	 * Drain the page cache and the request queue. Set the "dying" flag to
+	 * prevent that kill_bdev() locks up.
+	 */
+	sync_blockdev(lo->lo_device);

-	blk_mq_freeze_queue(lo->lo_queue);
+	blk_set_queue_dying(lo->lo_queue);
+	blk_mq_freeze_queue_wait(lo->lo_queue);

-	/* kill_bdev should have truncated all the pages */
-	if (lo->lo_queue->limits.logical_block_size != arg &&
-			lo->lo_device->bd_inode->i_mapping->nrpages) {
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
+	/* Kill buffers that got dirtied after the sync_blockdev() call. */
+	kill_bdev(lo->lo_device);

  	blk_queue_logical_block_size(lo->lo_queue, arg);
  	blk_queue_physical_block_size(lo->lo_queue, arg);
  	blk_queue_io_min(lo->lo_queue, arg);
  	loop_update_dio(lo);
-out_unfreeze:
+
+	blk_queue_flag_clear(QUEUE_FLAG_DYING, lo->lo_queue);
  	blk_mq_unfreeze_queue(lo->lo_queue);

-	return err;
+	return 0;
  }

  static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
