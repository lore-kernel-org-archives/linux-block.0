Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C568AC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B55B2184E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PjyK/zne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBKXPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:15:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39519 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfBKXPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 18:15:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so289743pld.6
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oTcqWST6FEXJ74L2S+lCuUw15fC4Ilj/dXbcjgcG3xM=;
        b=PjyK/zne0r0uU0KjFb2MjfOUEgPt4FBbq3g29lo58TfUVF2glXRcTZCtb9vd6WmgLW
         V/oLi72B6NcncK39FwgcumOXs/P5vaX7Gqc3B7aJMVq7ysq9xG9aMRfJXG3gbOHxCF0Y
         rhDtp8UUsWci5fnsHx3/GkswWqP3/dn3dzz6cljCzP4wA59DRlZZhSzNIbQfMO8x2ECD
         0trsoIO23nue9tiKe4o2Jl06J+ytaT0oKfXWJcRzToVA8pB3mfkNPEp0nTnyhsokrSK8
         fHMix1/jCQCqE1pNWP0YL1t6uwcR1/DNHMBL9GaKFRVAFbtVFoKBi+vLZDLpoIEtDxJ9
         CfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTcqWST6FEXJ74L2S+lCuUw15fC4Ilj/dXbcjgcG3xM=;
        b=YQWPpyiS/f+QbdQTPqw7mq3OzpIdABXq6w4IE5+3cZ1eklnJYVEZhcYm1paTXErwP2
         7yGJhiBZ+qq2sYeJXjf7FUR8U8Btuj3yGJmlusOLg/rODJVnY9ih4ZXxvxDc/FZtiBpw
         ybApTbXkagi4YF/zMSttq/gqprGFymRjtjgVsKymAoo6bT9j+b4Okbt4ixRn+idAzk61
         YTVNo3cL3qlBhYxOza+aw2/HHuLODZwRa2IK5SxLB4IXuQbr9Kakj8go3qo4l1SMnk9A
         w87bZnxCbga15CGv2Xheh4nzq6RymqTZHJcjzj8izHIz/q4V0Kj1kRZeR1NOiGxAM72a
         G1Yw==
X-Gm-Message-State: AHQUAuaT0j+epDLdD49Bvc1/yoZ3iKbNiK2GJVDUUrldBu6Ct//+hY5v
        TAqBoJO52BCdcNd/yPzEGsffkw==
X-Google-Smtp-Source: AHgI3Iagtg+Ski2iLOlXUjAqdPa1pJyiBEQeMB1JSHNWwnBSeRq5wHwfVbSvAV4dYsdoGN5C8k1Qvg==
X-Received: by 2002:a17:902:b214:: with SMTP id t20mr762524plr.248.1549926947026;
        Mon, 11 Feb 2019 15:15:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g128sm8693659pfb.121.2019.02.11.15.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:15:46 -0800 (PST)
Subject: Re: [PATCH] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
From:   Jens Axboe <axboe@kernel.dk>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549863665-1691-1-git-send-email-jianchao.w.wang@oracle.com>
 <937e9207-dcf7-dab5-1917-8a10303edc67@kernel.dk>
Message-ID: <82deee13-a4ff-9bf5-5e01-0e4df01b7ff7@kernel.dk>
Date:   Mon, 11 Feb 2019 16:15:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <937e9207-dcf7-dab5-1917-8a10303edc67@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 8:59 AM, Jens Axboe wrote:
> On 2/10/19 10:41 PM, Jianchao Wang wrote:
>> When requeue, if RQF_DONTPREP, rq has contained some driver
>> specific data, so insert it to hctx dispatch list to avoid any
>> merge. Take scsi as example, here is the trace event log (no
>> io scheduler, because RQF_STARTED would prevent merging),
>>
>>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
>> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
>> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
>> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
>> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
>>
>> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
>> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
>> the sdb only contained the part of (32768 + 8), then only that part
>> was completed. The lucky thing was that scsi_io_completion detected
>> it and requeued the remaining part. So we didn't get corrupted data.
>> However, the requeue of (32776 + 8) is not expected.
> 
> Good catch, but how about something like this? Makes it more integrated,
> I think that's cleaner.

This is probably better (and safer):


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f5b533764ca..b3908eb3881c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -737,12 +737,21 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->rq_flags & RQF_SOFTBARRIER))
+		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
 			continue;
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, true, false, false);
+
+		/*
+		 * If RQF_DONTPREP is set, rq may contain some driver
+		 * specific data. Insert it to hctx dispatch list to avoid
+		 * any merge.
+		 */
+		if (rq->rq_flags & RQF_DONTPREP)
+			blk_mq_sched_insert_request(rq, true, false, false);
+		else
+			blk_mq_request_bypass_insert(rq, false);
 	}
 
 	while (!list_empty(&rq_list)) {

-- 
Jens Axboe

