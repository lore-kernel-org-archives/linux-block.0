Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B180C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D0A218D8
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eOSFAq41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfBKP7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:59:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56103 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfBKP7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 10:59:34 -0500
Received: by mail-it1-f193.google.com with SMTP id f18so16459665itb.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 07:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F04iFmw5as0JwRGyMGw9f6xTEAeCIzyG3ctTbOKxOhQ=;
        b=eOSFAq41ffwj0VS2QVCR6YByB0twcGu1osYkNYMNUAXGMMgZUN0z5YsarWSxZS2PCk
         VhPfTSKV80bVPU4eqrA0w6HJvy0JPLNAHF+Po/niSLA9xh33STp5vtvD4f6F6VzNCPfz
         LchH3mqVvChh41xr1i6IZWHOjHgD6aEZqWWPUzLgwtwPG9GT6J1khjm+Ov8nx4iMrroG
         izkZP1u0Z/2qEIEohOevhnyvTJ5NGKBSJpvRbefg9wkJnh3hbyCiHOm6rKVmKIlqCYtP
         D70lhEdMHrGLn4tpDbH+TGx0iLSIRlFzigd/YI3IJYPSQU5M1gBb1Ko3XmvT9RKz4Zsv
         Ol6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F04iFmw5as0JwRGyMGw9f6xTEAeCIzyG3ctTbOKxOhQ=;
        b=bS7Sz9IetfEKw/evexXGmZTphF/AjPr+gQ4F8MsEgdQlXpaZuRgdrfNKg98+I0+bTh
         FY5l/dTR8F46wBwg1B/sgf0C/89ZC5uAQm9CibWLFgV+WMRA8Nz8iDpK+rxgNsmRsD1t
         wHu6k6yVOgWMlKaTMWJKRNE0JopOqBTOC6+bysNeQ1bW+X2ZfG67BZ0FGxX+vxzofkaS
         hfK1lQhLebJLZBH6qd739QLcKgYUMgNH9fhHVK+vV0GNpAvZvSc1+vr9M6a/tltsJ2k3
         Hj8JiuOFPmHGknV10YRskb+jIdsCFa0SOd66//8kB6g8MwmiyBE+RionebaR8/jfB5pS
         THtQ==
X-Gm-Message-State: AHQUAuZOV8RTJvDXoiyr1Fe5q5fenhSzVUa1l7uzEpsH48gDnztZ3qaT
        z7ekjtQAmERem9mZvrLS2U7Drw==
X-Google-Smtp-Source: AHgI3IacriPZPD6nqnkoI7fWdojvHgGOsMRdbWNYCsCmwokZ2WG0dnNuz2U+16SMEwnipXtLsDRHoA==
X-Received: by 2002:a5d:9913:: with SMTP id x19mr16828644iol.99.1549900773398;
        Mon, 11 Feb 2019 07:59:33 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e19sm4577174iob.70.2019.02.11.07.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:59:32 -0800 (PST)
Subject: Re: [PATCH] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549863665-1691-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <937e9207-dcf7-dab5-1917-8a10303edc67@kernel.dk>
Date:   Mon, 11 Feb 2019 08:59:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549863665-1691-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/19 10:41 PM, Jianchao Wang wrote:
> When requeue, if RQF_DONTPREP, rq has contained some driver
> specific data, so insert it to hctx dispatch list to avoid any
> merge. Take scsi as example, here is the trace event log (no
> io scheduler, because RQF_STARTED would prevent merging),
> 
>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
> 
> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
> the sdb only contained the part of (32768 + 8), then only that part
> was completed. The lucky thing was that scsi_io_completion detected
> it and requeued the remaining part. So we didn't get corrupted data.
> However, the requeue of (32776 + 8) is not expected.

Good catch, but how about something like this? Makes it more integrated,
I think that's cleaner.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 44d471ff8754..4c26bbb4330f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -737,12 +737,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->rq_flags & RQF_SOFTBARRIER))
+		/*
+		 * If RQF_DONTPREP is set, rq may contain some driver
+		 * specific data. Insert it to hctx dispatch list to avoid
+		 * any merge.
+		 */
+		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
 			continue;
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, true, false, false);
+		if (rq->rq_flags & RQF_SOFTBARRIER)
+			blk_mq_sched_insert_request(rq, true, false, false);
+		else
+			blk_mq_request_bypass_insert(rq, false);
 	}
 
 	while (!list_empty(&rq_list)) {


-- 
Jens Axboe

