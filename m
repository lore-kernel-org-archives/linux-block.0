Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B0C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160E120868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LWusBnpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160E120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLGCHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:07:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43009 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 21:07:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so984736pgk.10
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 18:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upHswlLDl+BrkPoeqR/SBb+EmCxEFzR6YjSmE5zANj8=;
        b=LWusBnpNp4gnxSrzz6h8/zpj/2wuCyr7YiQBn8c9yXo4JcvkDq+EwhOLKZ/GX81XJM
         n1T+VPf635vK6Iey8wvzjyV6WVpAx9JTJnOnOkM8vptSmcvoWHmfu/CASWoiWhVR/3uw
         ZpWyKxbbAGv3ryWXMoaPEx95YdX2roQcEtlOv+vs4EkcxFij1JKkJAQVAl3XF/DasmFi
         uEZfouNPLvtB2xBkU+A/izafUkJCWI/eW3QnQKGUbqMlm86HFQhA2xs/D1qqzwlaUCHi
         XBSxNLY20j3+exj/rXjrBAcZ5ya3p7W0jVNe8SczP+W/qJ2V3BQmCyXnIoqrWXL8SSOL
         O9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upHswlLDl+BrkPoeqR/SBb+EmCxEFzR6YjSmE5zANj8=;
        b=NmGXXvycAdEUYDbtjnkTr/GjUxfJXULtAgk7DYdvt/bDM9aqGolraJY89fcEHoF/Mf
         BGURdG1/j5hF8RwWAFjeorumc2S/nWLNpAW0jcvHzMIt+pu9Q2KqKgYp7y06jo0RQCrw
         4klilLCUiiyYpuPkeC3jcZthbVSNyBCDCFrGMLV91cjrKfsmHvHQUZk4qKEbpAykdTK1
         iEu6otBNk/BjTQgD+QD+5a3T0g8l2sdphcc20G3RHjEMoHUuvAuOZ4MZJctY1Dkf8l+y
         EeCuJMAa6Y4FLYHhlN+bVOvo8dyQC3fn0c8dKm8VKwPc30hkdsXJDg8d/mKO5PynYein
         9WIw==
X-Gm-Message-State: AA+aEWa7wCFIXy+Ud0+H/+InuXSj/lqz+UQeNu559qx6cdEdzwQxsO9q
        pXQSCQzwccbK4NmRa1+ZHAKuOQ==
X-Google-Smtp-Source: AFSGD/VnCwjZwlbasDGSFujN98+daRFkzGPGlVjVmxQpA6xztDnw7dFbaVEEXRz7s3fSrvUp5o8Sbw==
X-Received: by 2002:a62:d0c1:: with SMTP id p184mr357768pfg.245.1544148422404;
        Thu, 06 Dec 2018 18:07:02 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d129sm2309077pfc.31.2018.12.06.18.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:07:01 -0800 (PST)
Subject: Re: block: fix direct dispatch issue failure for clones
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
 <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
 <36822da2-ecde-ad71-7b49-f98e845b4fc2@kernel.dk>
 <20181207015830.GC17427@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <782a0a84-ac8e-31fc-255c-1f967a4740dd@kernel.dk>
Date:   Thu, 6 Dec 2018 19:06:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207015830.GC17427@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 6:58 PM, Mike Snitzer wrote:
>> There is another way to fix this - still do the direct dispatch, but have
>> dm track if it failed and do bypass insert in that case. I didn't want do
>> to that since it's more involved, but it's doable.
>>
>> Let me cook that up and test it... Don't like it, though.
> 
> Not following how DM can track if issuing the request worked if it is
> always told it worked with BLK_STS_OK.  We care about feedback when the
> request is actually issued because of the elaborate way blk-mq elevators
> work.  DM is forced to worry about all these details, as covered some in
> the header for commit 396eaf21ee17c476e8f66249fb1f4a39003d0ab4, it is
> trying to have its cake and eat it too.  It just wants IO scheduling to
> work for request-based DM devices.  That's it.

It needs the feedback, I don't disagree on that part at all. If we
always return OK, then that loop is broken. How about something like the
below? Totally untested right now...

We track if a request ever saw BLK_STS_RESOURCE from direct dispatch,
and if it did, we store that information with RQF_DONTPREP. When we then
next time go an insert a request, if it has RQF_DONTPREP set, then we
ask blk_insert_cloned_request() to bypass insert.

I'll go test this now.

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
index 7cd36e4d1310..8d4c5020ccaa 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -299,16 +299,27 @@ static void end_clone_request(struct request *clone, blk_status_t error)
 
 static blk_status_t dm_dispatch_clone_request(struct request *clone, struct request *rq)
 {
+	bool was_busy = (rq->rq_flags & RQF_DONTPREP) != 0;
 	blk_status_t r;
 
 	if (blk_queue_io_stat(clone->q))
 		clone->rq_flags |= RQF_IO_STAT;
 
 	clone->start_time_ns = ktime_get_ns();
-	r = blk_insert_cloned_request(clone->q, clone);
-	if (r != BLK_STS_OK && r != BLK_STS_RESOURCE && r != BLK_STS_DEV_RESOURCE)
+
+	r = blk_insert_cloned_request(clone->q, clone, was_busy);
+	switch (r) {
+	default:
 		/* must complete clone in terms of original request */
 		dm_complete_request(rq, r);
+		/* fall through */
+	case BLK_STS_RESOURCE:
+	case BLK_STS_DEV_RESOURCE:
+		rq->rq_flags |= RQF_DONTPREP;
+	case BLK_STS_OK:
+		break;
+	}
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

