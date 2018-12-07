Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437DC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 05:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA6C20882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 05:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ayGVd4vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA6C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGFRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:17:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGFRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 00:17:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so1198898pgg.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 21:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=O01kHKuF7uC/rp1h0z2S7QStYwcQIS/S6iFB5OoW2qo=;
        b=ayGVd4vxv39NFIbBSNiuZ3c59YdfmNvU5OZd+M0wOd/GXdZJde9fOMDFJbfqQ3PHLM
         DE4ddhU4zxPADE4V3qQwT/JleFHm95sODs3k+VzYp6fZpr99S4RnIS+kB2/yKo6LdUxq
         AvEaodOxNwQxntu8RuTsJRCGew4X8dIsqVU6WT4eNUa0z6NYu648R5YDK7oaPljH/M5r
         fUf7H1MDers/i1eJQlRVegqyMtcn5FE9yAk0cdPE3EmvXXuPaV31PfgwN/gY/6PBDq1m
         nvzN78hi5ylqFM3ha7iJKOXOeTwEgBR2hfezwxDnXB7SYlt4/vQkDGX6jRWyOh3Dvw3+
         YaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=O01kHKuF7uC/rp1h0z2S7QStYwcQIS/S6iFB5OoW2qo=;
        b=eQkAcgDooitPBcKPkUlSME3CBiqogIWTu4n8tkVK2k6Q6DJlfuhK71Yv/pYo4H3rUN
         f+xgEnNIP7rik7DqGsbbhGcQ0ShhsH+ht+9DdfALimsadvQ8xhfJyb1Tz67YerQTViTL
         0szQpS/T/c/PBUZhxV5fbMwIHIKQGGsSBh6C84IesLzNU5cNkJ/55u96MnH1yuWBK/Aw
         meyJEhhxnvdEOvbVCy7Tm6TqPYedcGkF4TJiLpkcpD3JwzqsVm7hHCJKiFjH4b7Ft2fy
         tLkcfOYtwj2k3R4UUCKXZmJXMV6hLa/8ERNPH+dwNSj+t/mGyCvnYHJcgCMtriKcVknX
         rmKw==
X-Gm-Message-State: AA+aEWa5bdRiz7Kxo/eoppg+didLG6KPXyWA5ZpcNqBwopFHFnoP7K6J
        fqdfSp5sFIM3h/uDJNE6eD1vryxYB98=
X-Google-Smtp-Source: AFSGD/VyOsrald8vUf9cry7pc7b3XDhiiENSgzUVAPLLRrvJWdZTeU8oJYMG7vqD1+pHahnUcmYbsg==
X-Received: by 2002:a63:bd1a:: with SMTP id a26mr743565pgf.121.1544159869352;
        Thu, 06 Dec 2018 21:17:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a90sm4105137pfj.109.2018.12.06.21.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 21:17:47 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Message-ID: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
Date:   Thu, 6 Dec 2018 22:17:44 -0700
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
and no amount of retrying will make that succeed. This results in a
livelock.

Instead of making special cases for what we can direct issue, and now
having to deal with DM solving the livelock while still retaining a BUSY
condition feedback loop, always just add a request that has been through
->queue_rq() to the hardware queue dispatch list. These are safe to use
as no merging can take place there. Additionally, if requests do have
prepped data from drivers, we aren't dependent on them not sharing space
in the request structure to safely add them to the IO scheduler lists.

This basically reverts ffe81d45322c and is based on a patch from Ming,
but with the list insert case covered as well.

Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
Cc: stable@vger.kernel.org
Suggested-by: Ming Lei <ming.lei@redhat.com>
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

I've thrown the initial hang test reported by Bart at it, works fine.
My reproducer for the corruption case is also happy, as expected.

I'm running blktests and xfstests on it overnight. If that passes as
expected, this qualms my initial worries on using ->dispatch as a
holding place for these types of requests.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3262d83b9e07..6a7566244de3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1715,15 +1715,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		/*
-		 * If direct dispatch fails, we cannot allow any merging on
-		 * this IO. Drivers (like SCSI) may have set up permanent state
-		 * for this request, like SG tables and mappings, and if we
-		 * merge to it later on then we'll still only do IO to the
-		 * original part.
-		 */
-		rq->cmd_flags |= REQ_NOMERGE;
-
 		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
 		break;
@@ -1736,18 +1727,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-/*
- * Don't allow direct dispatch of anything but regular reads/writes,
- * as some of the other commands can potentially share request space
- * with data we need for the IO scheduler. If we attempt a direct dispatch
- * on those and fail, we can't safely add it to the scheduler afterwards
- * without potentially overwriting data that the driver has already written.
- */
-static bool blk_rq_can_direct_dispatch(struct request *rq)
-{
-	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
-}
-
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
@@ -1769,7 +1748,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
+	if (q->elevator && !bypass_insert)
 		goto insert;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
@@ -1785,7 +1764,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
+	blk_mq_request_bypass_insert(rq, run_queue);
 	return BLK_STS_OK;
 }
 
@@ -1801,7 +1780,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
+		blk_mq_request_bypass_insert(rq, true);
 	else if (ret != BLK_STS_OK)
 		blk_mq_end_request(rq, ret);
 
@@ -1831,15 +1810,13 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
-		if (!blk_rq_can_direct_dispatch(rq))
-			break;
-
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq);
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
+				blk_mq_request_bypass_insert(rq,
+							list_empty(list));
 				break;
 			}
 			blk_mq_end_request(rq, ret);


-- 
Jens Axboe
