Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EEC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC692184E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eHXvgq8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfBKXU4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:20:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38169 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfBKXU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 18:20:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so285930pgc.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 15:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IU35FZblKisC1x8c74hdM2cTiZFCC/VL4KGQrcjNgfk=;
        b=eHXvgq8GiDCxiCji9K/5o9V2iYTpiDKehG21UbSQvYfs2+CpOUfUMd0OhfdtxAhxLd
         CsVmWvTpQR4OjzoAJWQtnBPipawH1+6oPjLk4dzC7yDxpAvijaxfMbVE3yywu96kQqhj
         qQ+YkWcDMRXQH10hPsH3iWWKRMGfJPzODj4R0KYe287VolxW4Sc0zmiVZQZZEtxRzOLh
         z1ZK8Ja3gmwWGEx4Z/Z+mVNyH3KC8HuMQKV+/ZTKrzLtEdBC5PH6LQ8Y54EeZhZZZUFK
         tleiGyMf47JXI6evaSDZs185tt1RtFsAxuqurDQu3D5eSv5eyKvBaZPxdm7zTJcw+o5t
         qaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IU35FZblKisC1x8c74hdM2cTiZFCC/VL4KGQrcjNgfk=;
        b=VmnzC7A5n+netBzeYa3NPiYO5yKm8mRv/szDERndOz9zl+p3lntSM8uRrLX6iAODDw
         3MQnnDk1LmNhMjmBzLKYBXV60r/6bTFJAlaj3bR1Ssxg5S1l48QZ6Cs9kDFP2ncYrNUP
         af6hGrNXGDBMuvN5bSE5R17tcJt4ZzJdG5aojzdq2AglQW6H9pa9Sv/HoUIijclx2TjB
         cXM2egnqlZxshcHwhkM5G+gEMKxtDx0bWaPe8Hyp7CM9bcT8AHM3B/bAc0RwxXacdlnY
         2fYEB7Xldm4H0pYEzPE5X/OjuVLKjAHIauu7Xk1SaQOh0N7zJb87Cj5hYI6JUzxBz7OE
         3Jwg==
X-Gm-Message-State: AHQUAubR7/qlUeKM4Hi6EVVou9QZvTN2HrDlF4L+EyCxjW3d+JcuDFBX
        m1C32fIrpbg2u1fWF0MmeYAHG5dyNfNgmQ==
X-Google-Smtp-Source: AHgI3IYPx+DoVpGpGxz6yHuPjp0Me+rbAaJWVdLhYj+nsf9LIEQ/Az0JtUW3aqlb979vGSeM38lMqA==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr766988pfn.93.1549927255241;
        Mon, 11 Feb 2019 15:20:55 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o4sm41243784pgs.12.2019.02.11.15.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:20:54 -0800 (PST)
Subject: Re: [PATCH] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
From:   Jens Axboe <axboe@kernel.dk>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549863665-1691-1-git-send-email-jianchao.w.wang@oracle.com>
 <937e9207-dcf7-dab5-1917-8a10303edc67@kernel.dk>
 <82deee13-a4ff-9bf5-5e01-0e4df01b7ff7@kernel.dk>
Message-ID: <e68f8017-2f56-6305-1c08-2368435b274b@kernel.dk>
Date:   Mon, 11 Feb 2019 16:20:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <82deee13-a4ff-9bf5-5e01-0e4df01b7ff7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 4:15 PM, Jens Axboe wrote:
> On 2/11/19 8:59 AM, Jens Axboe wrote:
>> On 2/10/19 10:41 PM, Jianchao Wang wrote:
>>> When requeue, if RQF_DONTPREP, rq has contained some driver
>>> specific data, so insert it to hctx dispatch list to avoid any
>>> merge. Take scsi as example, here is the trace event log (no
>>> io scheduler, because RQF_STARTED would prevent merging),
>>>
>>>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
>>> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
>>> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>>>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
>>> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
>>> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>>>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>>>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>>> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
>>>
>>> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
>>> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
>>> the sdb only contained the part of (32768 + 8), then only that part
>>> was completed. The lucky thing was that scsi_io_completion detected
>>> it and requeued the remaining part. So we didn't get corrupted data.
>>> However, the requeue of (32776 + 8) is not expected.
>>
>> Good catch, but how about something like this? Makes it more integrated,
>> I think that's cleaner.
> 
> This is probably better (and safer):

Here's the one I wanted to send, not a half done one. Maybe I'll be
luckier this time around?


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f5b533764ca..35e6aba52808 100644
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
+			blk_mq_request_bypass_insert(rq, false);
+		else
+			blk_mq_sched_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {

-- 
Jens Axboe

