Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA3AC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41A82086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="txgkFWnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41A82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeK1K6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:58:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeK1K6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:58:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so16401343pln.9
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHMe+dUHUa2oH+sotU0NjJLbcDiE6Zell80P7lFl1kg=;
        b=txgkFWnJJH72+WPsQOACygp2XDaLZ1PlBjZGzpljs7CDnGFw0gUWCRRlZ3YUmM/0K7
         qVdKHkCmZod5+JTQ5WeyIrNbwXwahoYanF9zkH2m4BIm4qKUpfaUeBhKBeYlfj+4HnsL
         grYyZTLMJhgusUG7MngkoXzCWK2ZnnbMJy16h831Gh/Pav7SdBpH2FhkEnnZHxexPU2k
         PwnzhNU/e037ahQcOFnSQVtRm6RyJmBYZkbgO8psv47mDNWfrAnYXkuMnysJfWSi1Xiy
         a2UGmRcNx03cLvnl9BxKg1m7JvATpB73pg0XGJli0U88jXYUAWI1DJSnMVtl4iT4X2eD
         pCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHMe+dUHUa2oH+sotU0NjJLbcDiE6Zell80P7lFl1kg=;
        b=gSN2UKERG0+jwSHDkfCtfOMjbYtwXCWBpRWbxOL/PP2aJpIH+oVZXSasc/ID7WvTXb
         fy90AtJzemuAdGlX/WpIXntVB2NCK9rxjZQ4TKX+atfWd0QaeIS6RIyWV7veHgD/c2g/
         INoLvfPIRjwbMA4lD8LkEik6avKT6FqazUiUUAB1TmPlPODJQcBQbnI19dDPRT8+8Gsf
         mxPWzOypVGuiOO6QCmHWfkneZt/pbVABUgHvQ/43582d1rhmcvZptEZXKM6joo7MpUdf
         KabHg7AxJwixXfoV9HtSpPf+jwKVcecLdxUA/LUT6+R/RwDN63nXzVy+zM7L6fWrif7V
         GOnQ==
X-Gm-Message-State: AA+aEWZPei2Mlx/j49X2/TKnbTEZG5J5cFRbyP/+cwPhcxqdJqwCy8Sv
        17j7EpyYdNxcJnESIE2Ga1VVIgP6wCw=
X-Google-Smtp-Source: AFSGD/XJcPgEw7VoNrSzy4OxZf+Tr621sDsgZFgIflvYH7wMMhmpbt/cA9AfkMzRSMTcKyEzv4cuvQ==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr34042309plb.266.1543363157046;
        Tue, 27 Nov 2018 15:59:17 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s84sm12133908pfi.15.2018.11.27.15.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 15:59:16 -0800 (PST)
Subject: Re: [PATCH 2/8] block: improve logic around when to sort a plug list
From:   Jens Axboe <axboe@kernel.dk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk> <20181127233142.GB846@vader>
 <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
Message-ID: <62f96268-f596-78b8-d227-6be1f5ae1cea@kernel.dk>
Date:   Tue, 27 Nov 2018 16:59:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 4:49 PM, Jens Axboe wrote:
> On 11/27/18 4:31 PM, Omar Sandoval wrote:
>> On Mon, Nov 26, 2018 at 09:35:50AM -0700, Jens Axboe wrote:
>>> Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
>>> case if we have requests for multiple devices in the plug.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  block/blk-core.c       | 1 +
>>>  block/blk-mq.c         | 7 +++++--
>>>  include/linux/blkdev.h | 1 +
>>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index be9233400314..c9758d185357 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
>>>  	INIT_LIST_HEAD(&plug->mq_list);
>>>  	INIT_LIST_HEAD(&plug->cb_list);
>>>  	plug->rq_count = 0;
>>> +	plug->do_sort = false;
>>>  
>>>  	/*
>>>  	 * Store ordering should not be needed here, since a potential
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 99c66823d52f..6a249bf6ed00 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>>  	list_splice_init(&plug->mq_list, &list);
>>>  	plug->rq_count = 0;
>>>  
>>> -	list_sort(NULL, &list, plug_rq_cmp);
>>> +	if (plug->do_sort)
>>> +		list_sort(NULL, &list, plug_rq_cmp);
>>>  
>>>  	this_q = NULL;
>>>  	this_hctx = NULL;
>>> @@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>>  
>>>  		list_add_tail(&rq->queuelist, &plug->mq_list);
>>>  		plug->rq_count++;
>>> +		plug->do_sort = true;
>>>  	} else if (plug && !blk_queue_nomerges(q)) {
>>>  		blk_mq_bio_to_request(rq, bio);
>>>  
>>> @@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>>  			data.hctx = same_queue_rq->mq_hctx;
>>>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>>>  					&cookie);
>>> -		}
>>> +		} else if (plug->rq_count > 1)
>>> +			plug->do_sort = true;
>>
>> If plug->rq_count == 2, there's no benefit to sorting, either. The
>> nr_hw_queues == 1 case could also avoid sorting in that case. So maybe
>> this whole patch could just be replaced with:
> 
> Heh yes, good point, it should be 3 at least. But if you look at the
> later mq plug patch, we only sort for that one if we have multiple
> queues. So the logic should be something ala:
> 
> if (plug->rq_count > 2 && plug->has_multiple_queues)
> 
> since that's the only case we want to sort for.

How about something like this?


diff --git a/block/blk-core.c b/block/blk-core.c
index be9233400314..d107d016b92b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
 	INIT_LIST_HEAD(&plug->mq_list);
 	INIT_LIST_HEAD(&plug->cb_list);
 	plug->rq_count = 0;
+	plug->multiple_queues = false;
 
 	/*
 	 * Store ordering should not be needed here, since a potential
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7b7dff85cf6c..02daa32c5d77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1677,7 +1677,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_splice_init(&plug->mq_list, &list);
 	plug->rq_count = 0;
 
-	list_sort(NULL, &list, plug_rq_cmp);
+	if (plug->rq_count > 2 && plug->multiple_queues)
+		list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
@@ -1866,6 +1867,20 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
+static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
+{
+	list_add_tail(&rq->queuelist, &plug->mq_list);
+	plug->rq_count++;
+	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
+		struct request *tmp;
+
+		tmp = list_first_entry(&plug->mq_list, struct request,
+						queuelist);
+		if (tmp->q != rq->q)
+			plug->multiple_queues = true;
+	}
+}
+
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1932,8 +1947,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			trace_block_plug(q);
 		}
 
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		plug->rq_count++;
+		blk_add_rq_to_plug(plug, rq);
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1948,8 +1962,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			same_queue_rq = NULL;
 		if (same_queue_rq)
 			list_del_init(&same_queue_rq->queuelist);
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		plug->rq_count++;
+		blk_add_rq_to_plug(plug, rq);
 
 		blk_mq_put_ctx(data.ctx);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02732cae6080..08d940f85fa0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1131,6 +1131,7 @@ struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
 	struct list_head cb_list; /* md requires an unplug callback */
 	unsigned short rq_count;
+	bool multiple_queues;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)

-- 
Jens Axboe

