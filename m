Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7207BC433E7
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6FD22365
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 19:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV0dH50V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgJSTCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgJSTCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 15:02:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A1C0613D0;
        Mon, 19 Oct 2020 12:02:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so1373942ilh.3;
        Mon, 19 Oct 2020 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6Qfl4RzyoYY0xyHHaaWegNhMwUCPvOxxsKja+GGhbE=;
        b=cV0dH50VnNBVTXcBxLxMghFXtg7JtA+rxtgwFt1dzbeEykFAZUtQw9xYlC0vwf+Vt2
         kZJ1DxdS26/tLjI4ixPg+6R2TJCmg75V071Siq0v/qkP4rzkBOicTKTbUe0aHc73uaR+
         MCXG4cYKzWbeHaFxsAZrXoo0iuUpHzqKqg+X7QXfYrl87006QOSdHHNedxdnu/2Bw0hG
         75+fpk+fmBCG7eRRMcqkIulR9XW42zYM4qwpJGkYfzc7By77LPS8WrpnT8WtWjznIczo
         0imQZ6U1GbaEAO1iMHOcXmvST/VmphwVUu3E3/ammtqW2X/hWDWFqK57miVqm0X6FhYU
         yIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6Qfl4RzyoYY0xyHHaaWegNhMwUCPvOxxsKja+GGhbE=;
        b=DZT5Ug43cyVpcOiN5PLuD5G2PgcCDTAf4Bq17pzlBDdKwHS3IUYljDz6JWK0DUrmEU
         tadPjGFZ9c3tChtN+Idt8tpcNadMoyLrxIcDov7y6L7Jeoyjg3FzsHhL7P4hqX+2nxmu
         ZvB2RC+mGwHMrCD1T6G9uXlQ58hu+ULPMmcrIWO+KRBrBWYmZi1lLKrnTkWceWRPkuJU
         o1N1b9ovA/d9DFS6Sj3gTmrhv36qm4+kfk+XZZ+YX0EB95vB+jFZyncgZSHMRES43Lr8
         HHL+507NKm1g46sV33ZM/n7eMJrYUaU8Zg5rrNeh4RYYk7wCiY9/Xkrvn2bN8tsWOTMy
         ON3w==
X-Gm-Message-State: AOAM5320cal4S5eoFji9olFmhtIs7cfuMO0GWDdGkHqEmma2D5cm72mc
        ezR7yUGPI4iBBeA1LpVerya50HUfGg==
X-Google-Smtp-Source: ABdhPJyLxOJViQionbY2RerrIKWmU3A/9JjljQkcLLnr1+x76pgvUpnOiWM9TgoLpafx2IZne5gEHA==
X-Received: by 2002:a92:aa0e:: with SMTP id j14mr1244286ili.120.1603134170696;
        Mon, 19 Oct 2020 12:02:50 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id q16sm580359ilj.22.2020.10.19.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:02:50 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 2/2] block: Add blk_status_to_str()
Date:   Mon, 19 Oct 2020 15:02:41 -0400
Message-Id: <20201019190241.2910492-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019190241.2910492-1-kent.overstreet@gmail.com>
References: <20201019190241.2910492-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're going to the trouble of having these nice error strings, let's
make them available.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/blk-core.c       | 13 +++++++++----
 include/linux/blkdev.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac506..d68f24a7ee 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -213,18 +213,23 @@ int blk_status_to_errno(blk_status_t status)
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
-static void print_req_error(struct request *req, blk_status_t status,
-		const char *caller)
+const char *blk_status_to_str(blk_status_t status)
 {
 	int idx = (__force int)status;
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
-		return;
+		return "(invalid error)";
+	return blk_errors[idx].name;
+}
+EXPORT_SYMBOL_GPL(blk_status_to_str);
 
+static void print_req_error(struct request *req, blk_status_t status,
+		const char *caller)
+{
 	printk_ratelimited(KERN_ERR
 		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
 		"phys_seg %u prio class %u\n",
-		caller, blk_errors[idx].name,
+		caller, blk_status_to_str(status),
 		req->rq_disk ? req->rq_disk->disk_name : "?",
 		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
 		req->cmd_flags & ~REQ_OP_MASK,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 868e11face..d9e3b7b017 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -936,6 +936,7 @@ extern const char *blk_op_str(unsigned int op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
+const char *blk_status_to_str(blk_status_t status);
 
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 
-- 
2.28.0

