Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D12C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8375208E7
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZxN+VEkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8375208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeK2Ahi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44281 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Ahh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so9508995pgr.11
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRTFqAfZzMy54ETYHJv9npYHxDHo1DRDaYI/HKA/zr0=;
        b=ZxN+VEkTtYIsd7ggq7Y+6rwA87HHRR6CAfAKvjCEKTjurCp/TXBYnhhBnkck51din0
         DieWx1OeHNshwbeCUrx2IxL5BgHdGzAq19C9H1C+mTvf8YVRo99PHGTGGErZYR732rr1
         qxT0JJscB/2w0DGsS0ljpTt54EKWyjpC+moDycbCupkU1OnRHZnZ8qfNaZ1sSexFIyPx
         OIaQK3fDZ6ir4+uEi7iFNtM49p9rkWGpQO8v4X8ISFuBeQCltEWvqU8x8T4VJVc0tPc2
         Z8jSGu6hEwlsf+boQxgd9gl5Pu5mdfQhSKWspRDVV2a2G1vbR2cWBVQT23zuNoiy3IeV
         Utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRTFqAfZzMy54ETYHJv9npYHxDHo1DRDaYI/HKA/zr0=;
        b=KCllMdO6kB+6w8CasPdl4ct2Zvqc9RwUkXPfbL/HX33AAGGzMgMuaz6MhghdC7PATO
         rLEDTRs+gSga4J9gzjRSPhG7+IlrZqwvmRpAijAoMFBazvLpv3sVDsKEnQXhZKBYQucM
         jaQtebvJx/1e8rr1/seETN0S7flLY5MeQiEhVmfAv9Rss7Fho92mD2lCDeycAFH4y1JP
         rOlQhSfow20MNOBO7zKdQvmiZvyHSZMIjdlAIndFSIDa3xqwLTGpP7Yx4Xk3Ih0PBBtP
         8mlrs6vTCIkmxeumXGUtdL3g8jYYSx3+oc0As4qbQrli4xQXedYxQzeTd7aouZGDv8Or
         EPQg==
X-Gm-Message-State: AGRZ1gKoXfGbxakCURGILKcrmX+3D30ezRyZu75wnTUzT8pVnHr+WxcQ
        fw/y97Ve7Ou7pzxdMk+EJ51w7oZ+cEk=
X-Google-Smtp-Source: AJdET5eBG6xDcXZp1DMd8mAZMCOwAiclCoyoSiwaBv0FoKMIIhsXqNB36dgOPAhcSwRzrS7N9O6lKg==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr37152643pfg.74.1543412156264;
        Wed, 28 Nov 2018 05:35:56 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] blk-mq: use plug for devices that implement ->commits_rqs()
Date:   Wed, 28 Nov 2018 06:35:38 -0700
Message-Id: <20181128133538.20329-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have that hook, we know the driver handles bd->last == true in
a smart fashion. If it does, even for multiple hardware queues, it's
a good idea to flush batches of requests to the device, if we have
batches of requests from the submitter.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9e1045152e45..091557a43d53 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1945,7 +1945,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		/* bypass scheduler for flush rq */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
-	} else if (plug && q->nr_hw_queues == 1) {
+	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs)) {
+		/*
+		 * Use plugging if we have a ->commit_rqs() hook as well,
+		 * as we know the driver uses bd->last in a smart
+		 * fashion.
+		 */
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-- 
2.17.1

