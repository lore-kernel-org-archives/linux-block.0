Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D8C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7121C20867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vZv5bicj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7121C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLADGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:06:15 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33941 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLADGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:06:14 -0500
Received: by mail-io1-f67.google.com with SMTP id f6so4931258iob.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RkiKJ2ttPoC/20l1LrLXJsnA2fN5nBdpH8PCZoolnWk=;
        b=vZv5bicjfLQq1CKj6sIg6HRSlP3rAfOchWp8kJadFiB9vEfiELKO4M5YIfQFu4GqGP
         NF+ZngjBgMjiar6Kbr4vKuQZdBRxFWyG/WvUW/9qt7DDLH8K26jFOwkPxpPazL8U9qDq
         ANe+2vQFgh6WaXJFJtlhfCacW3MRn/ijYxYWRt2dZlcLmLkqdPgxpln/OuTWhrOcoJNm
         pMEhDl4eJDxVq+c8CrXXImiv/Kye2tgsD3c9IyVgq3jCn8KUrV8JFqN2VYZ06N8yBfI8
         OoIj6v/+xU/Mu67l5RUcalg9BTXcuw1qjTkuDM9CMYQYDLa3SUyRNHwDUnyrt2WBKa7e
         BLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RkiKJ2ttPoC/20l1LrLXJsnA2fN5nBdpH8PCZoolnWk=;
        b=By4ovg8e/8NJDmURB1AmDLWzjkILcx7IHm9KTWzenLBwiFKLTHD/TY65dvgtjUEAmz
         19M1x7koVysq9WO8YALHm0nZql6mUUBS5cddqNPt3M/4kGOFhRmTXSf4qakFzDZJCQtY
         LZVal0/2JyvldRkmZV8DnPtqksPIQi9ZgSpZX+nday6QjdN+znW/9QfBY3C2odSftIdH
         mtdrYFuZJwrjFDjo8ZCZD1AnNtTeVv8Iyi+T/BBk1admP8VJWw/3Vbpm6B8efBmEoVj9
         Hi8i1ZBfcTYx8x9SsEtmAzQA6mfjVSL/HjWCL4WWg13OrXnG2H1eZgOY8yYH988F0U8W
         FStQ==
X-Gm-Message-State: AA+aEWb9MdlB80c0Ee4Y2ehgpJTDkdRNwZvKw2JPbRjiZsrrQt4ZET/v
        L10qjOsbjwQhFEVhJCspntKLpnvPVFE=
X-Google-Smtp-Source: AFSGD/UX1mGwSKdK1zEi2DGNcsVAkznvt33WLA5Rm8sfkH080APkUhrcVbTKIwiNTAolOI+zWBE2uw==
X-Received: by 2002:a5d:834f:: with SMTP id q15mr4748718ior.181.1543593387250;
        Fri, 30 Nov 2018 07:56:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j4sm2015173iok.42.2018.11.30.07.56.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:56:26 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: don't call ktime_get_ns() if we don't need it
Message-ID: <51a1cb7b-6136-a220-6cac-9bccd2262ca3@kernel.dk>
Date:   Fri, 30 Nov 2018 08:56:25 -0700
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

We only need the request fields and the end_io time if we have stats
enabled, or if we have a scheduler attached as those may use it for
completion time stats.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7dcef565dc0f..2b458e9da946 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -316,7 +316,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
 	rq->part = NULL;
-	rq->start_time_ns = ktime_get_ns();
+	if (data->q->elevator)
+		rq->start_time_ns = ktime_get_ns();
 	rq->io_start_time_ns = 0;
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
@@ -522,12 +523,18 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	u64 now = ktime_get_ns();
+	u64 now = 0;
 
+	/*
+	 * Only read ktime if we need it, which is if stats are enabled
+	 * or we have a scheduler attached that may use it.
+	 */
 	if (rq->rq_flags & RQF_STATS) {
 		blk_mq_poll_stats_start(rq->q);
+		now = ktime_get_ns();
 		blk_stat_add(rq, now);
-	}
+	} else if (rq->q->elevator)
+		now = ktime_get_ns();
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq, now);
-- 
2.17.1

-- 
Jens Axboe

