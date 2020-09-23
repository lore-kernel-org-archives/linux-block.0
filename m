Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE8C4727F
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB413235FC
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="bMOj5Tth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIWLou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgIWLou (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD84CC0613D1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so14860123pfn.8
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGilIYrCbh50kTGRwzjJvVfohhOd0dHq1F9Kut44y9I=;
        b=bMOj5TthhClhPZZn3/SIzkBPxHYOZH75lTH2CcXUdw8UR/J+FzMyQ/KBz7hKRaA18E
         ZlSjrcfBhq5erVyx0j6CD66VdAJrqX0HfmM/0D3rabD6dkiKizTu6ztq1OKYtWN+y/75
         hQj5pqVDvtbI5d65Og1ytt+GcllEe4wiB2FwEeV7M4suASAr+87Mnpsg8jCUvIhHLba/
         2rB2qF1Ho22sboU++zkzxz4bDO7QX1CKYUDkQ7WSU+5By9kHHdnQOGTW9zbUZWHsyNT1
         2xPMaiq9HaTEvNN1xERZNOYTOplzVwhhoOw9R1DTo/979p3PKQjEeRPE5rznAiGDmRLW
         jO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGilIYrCbh50kTGRwzjJvVfohhOd0dHq1F9Kut44y9I=;
        b=ipj+pK0OMR9bnQZhI2lrHRf14IqSBLshvII5gMS3R6+4ce8vvsSevdN34IKyVW/iGs
         AUoiEex7Nl5/vj3Tn6Qtg+gBnjHWaQ1E6Qs/eLeKrm1sSciR7/ixNst4wmDIGX4CCv7X
         J6qeyd6qLGcDIBEQMog90oQ1g15yFR9wx3mwt3+7iiEDGfaLBz/BFkofXNSpR5OmHBvI
         Zf4o3gO34fixPIhx8iieOebsYVCY+lCylmLZYGIi995O2nhYY83/HZ7ugJzUogpIhPNM
         2OmcOLfIiBjxlrRwwkW58ONQ1o8z9CDnnk4d/hM+1cELEzNWiQgh6osovmqqC8q7vL1X
         rcjA==
X-Gm-Message-State: AOAM532z+tenw3ggNrLMgBCbIW+WRdSzk3i5W8UnrrHQChpR2RDVShSC
        LH0aeDGoG0FbRH+EWYwvIezOWA==
X-Google-Smtp-Source: ABdhPJwPQPmp9mJ3CwnGnJmncLyVBkzdNV9o4SqscJ/GohWXP7zYQ0odT2RerJw29I0rw87VsNdsHw==
X-Received: by 2002:a63:4d02:: with SMTP id a2mr7108482pgb.38.1600861489363;
        Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/5] io_uring: Fix missing smp_mb() in io_cancel_async_work()
Date:   Wed, 23 Sep 2020 19:44:16 +0800
Message-Id: <20200923114419.71218-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The store to req->flags and load req->work_task should not be
reordering in io_cancel_async_work(). We should make sure that
either we store REQ_F_CANCE flag to req->flags or we see the
req->work_task setted in io_sq_wq_submit_work().

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a1350c7c50055..c80c37ef38513 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2252,6 +2252,12 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 
 		if (!ret) {
 			req->work_task = current;
+
+			/*
+			 * Pairs with the smp_store_mb() (B) in
+			 * io_cancel_async_work().
+			 */
+			smp_mb(); /* A */
 			if (req->flags & REQ_F_CANCEL) {
 				ret = -ECANCELED;
 				goto end_req;
@@ -3728,7 +3734,15 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 
 		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
 		list_del_init(&req->task_list);
-		req->flags |= REQ_F_CANCEL;
+
+		/*
+		 * The below executes an smp_mb(), which matches with the
+		 * smp_mb() (A) in io_sq_wq_submit_work() such that either
+		 * we store REQ_F_CANCEL flag to req->flags or we see the
+		 * req->work_task setted in io_sq_wq_submit_work().
+		 */
+		smp_store_mb(req->flags, req->flags | REQ_F_CANCEL); /* B */
+
 		if (req->work_task && (!files || req->files == files))
 			send_sig(SIGINT, req->work_task, 1);
 	}
-- 
2.11.0

