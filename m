Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B00CC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3402064D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GxTDvCoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3402064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGCtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:49:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40946 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 21:49:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so1166689pfo.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 18:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5Uvgn4H5n0U/MFNF2f3JHsp2q+/zeP8MnrxaKTKWNrk=;
        b=GxTDvCoZzelywLDB26TK9OCniVpt1Boqv4ILIatSt2nqU980zyrFXNXht2+KcMIJSR
         Vo1DH2GXkiA73rn6NRBtgldhKKEAZr4iPrFB12Wh6nIh93mvYpRNU3GXZuBvkl+U03Aj
         ttWsaDQUP/Hm7HZxfqobEUsrONho4jnayBXCjyz4jVuA2454tK7UCMs/M0c8Hd+oLPgu
         j6tj9dG54eFUO0FkgKe7KmnP2Ssdp96GckhUhAgxiZ7sGcm1Sg8j57iKU2DU139TKPWQ
         0SVpMkfXoQf6AIglK0H0+WIQeb6TmJltnjvBi+EvMPsQ+QdCxTVe9uohMt+NHEZP2Jyd
         TI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5Uvgn4H5n0U/MFNF2f3JHsp2q+/zeP8MnrxaKTKWNrk=;
        b=SPXpZVR4ZwU3pacO3tEK2L2QiAZkdL5ZTEmX2yOi6s/AswLv+4klJTI9dEfQwaDa96
         4lXPZo4fx3qQA3+ymFcjj+Fsyf8zc/XwKMgpQLyWvTzj26c03iBfVMCo/62fyjLdVkEQ
         VHBGIhZuPJ93eDnPwvrgwuqbYARESEn5x+9QeKMqAukpkn8ysapk/y5LwEG6iv2s2osv
         bkYNIGzhqzKAl6E2goW90SU4TJh0Td8GmXHrLzR+dhUzKQhsjHT5z/09JEuiWj0TsmKE
         bxf+H+JwsPFC6t5DwYML5b84idSrwji/Zz5oJt/p9zANK5hfsgCPXtRseGxsjzVBEX3Q
         Pxjw==
X-Gm-Message-State: AA+aEWZg0H6xFopZuA5mfDgxhPKBFRYj8KkQwC32BXvpEg0C6Dt9xWkp
        FeHk8+9QPvDRts46292gFKQ78AlDINo=
X-Google-Smtp-Source: AFSGD/W7yDty2i3j3aE9W+dFYtu0z+ZeeeV/4f48jnJBivk0dep8xoBesWtnSacVKv7kI0TAuhS59Q==
X-Received: by 2002:a62:442:: with SMTP id 63mr525424pfe.156.1544150957143;
        Thu, 06 Dec 2018 18:49:17 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w10sm2130725pgi.81.2018.12.06.18.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:49:15 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block/dm: fix handling of busy off direct dispatch path
Message-ID: <e6024b99-579a-ce20-ca3a-a9983582ea36@kernel.dk>
Date:   Thu, 6 Dec 2018 19:49:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After the direct dispatch corruption fix, we permanently disallow direct
dispatch of non read/write requests. This works fine off the normal IO
path, as they will be retried like any other failed direct dispatch
request. But for the blk_insert_cloned_request() that only DM uses to
bypass the bottom level scheduler, we always first attempt direct
dispatch. For some types of requests, that's now a permanent failure,
and no amount of retrying will make that succeed.

Use the driver private RQF_DONTPREP to track this condition in DM. If
we encounter a BUSY condition from blk_insert_cloned_request(), then
flag the request with RQF_DONTPREP. When we next time see this request,
ask blk_insert_cloned_request() to bypass insert the request directly.
This avoids the livelock of repeatedly trying to direct dispatch a
request, while still retaining the BUSY feedback loop for blk-mq so
that we don't over-dispatch to the lower level queue and mess up
opportunities for merging on the DM queue.

Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This passes my testing as well, like the previous patch. But unlike the
previous patch, we retain the BUSY feedback loop information for better
merging.

diff --git a/block/blk-core.c b/block/blk-core.c
index deb56932f8c4..cccda51e165f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2617,7 +2617,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
  * @q:  the queue to submit the request
  * @rq: the request being queued
  */
-blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
+blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq,
+				       bool force_insert)
 {
 	unsigned long flags;
 	int where = ELEVATOR_INSERT_BACK;
@@ -2637,7 +2638,11 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		 * bypass a potential scheduler on the bottom device for
 		 * insert.
 		 */
-		return blk_mq_request_issue_directly(rq);
+		if (force_insert) {
+			blk_mq_request_bypass_insert(rq, true);
+			return BLK_STS_OK;
+		} else
+			return blk_mq_request_issue_directly(rq);
 	}
 
 	spin_lock_irqsave(q->queue_lock, flags);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 7cd36e4d1310..e497a2ab6766 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -299,16 +299,20 @@ static void end_clone_request(struct request *clone, blk_status_t error)
 
 static blk_status_t dm_dispatch_clone_request(struct request *clone, struct request *rq)
 {
+	bool was_busy = (rq->rq_flags & RQF_DONTPREP) != 0;
 	blk_status_t r;
 
 	if (blk_queue_io_stat(clone->q))
 		clone->rq_flags |= RQF_IO_STAT;
 
 	clone->start_time_ns = ktime_get_ns();
-	r = blk_insert_cloned_request(clone->q, clone);
-	if (r != BLK_STS_OK && r != BLK_STS_RESOURCE && r != BLK_STS_DEV_RESOURCE)
+	r = blk_insert_cloned_request(clone->q, clone, was_busy);
+	if (r == BLK_STS_RESOURCE || r == BLK_STS_DEV_RESOURCE)
+		rq->rq_flags |= RQF_DONTPREP;
+	else if (r != BLK_STS_OK)
 		/* must complete clone in terms of original request */
 		dm_complete_request(rq, r);
+
 	return r;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4293dc1cd160..7cb84ee4c9f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -994,7 +994,7 @@ extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 			     void *data);
 extern void blk_rq_unprep_clone(struct request *rq);
 extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
-				     struct request *rq);
+				     struct request *rq, bool force_insert);
 extern int blk_rq_append_bio(struct request *rq, struct bio **bio);
 extern void blk_delay_queue(struct request_queue *, unsigned long);
 extern void blk_queue_split(struct request_queue *, struct bio **);

-- 
Jens Axboe

