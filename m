Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16493C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A51224FE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv2pXOlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfI3Uxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:53:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40497 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3Uxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:53:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so12871572wru.7;
        Mon, 30 Sep 2019 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bu9cH1o0BJVB5OrcwUaFnQDN3/Qtc1RkyhexAVVqx4=;
        b=kv2pXOlpBCugCOp5kxNT6RU4VJx+nuADmtSd3uIY9Tq/kk0a9OGH6UofFKYovMfMj0
         zePnSFNrBHEOtmetNUOFxvHMQW+2WHAvlSk6o6gV9Ag1apQD3hybdfzs2J5VgTAWszT4
         kG/D4wglRiLRUmcnP9n8KYXoYxB9UMGElJLhdcILGwmYi3qNrg+vFT1UxlnX0CeOO+bo
         x9gOdXmNNKgVOsgDKjq/KnlY0rhZX7cryVc28OGZUIzTKZ9CXvTGwcUOfdNhGeICmART
         CP4pntQ2lYOTe3vvtBa50KYLAMXKw5ZLscyfBIOtD970bSMg0aB42khvPG14sqIfvLlV
         wcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bu9cH1o0BJVB5OrcwUaFnQDN3/Qtc1RkyhexAVVqx4=;
        b=OYoqx648SsI1ZLfP4b8qItU7BPMgdySgKHSFzq0e7YajXvTSfTbuA9mtQJl6e100Si
         EblmvYqYtQ0c5twfZlhO95XPfzvLLIDyB2hcjI6wWdEBmD9PUokDDQn7kngsYWtbgGBQ
         GkhrcLf9G6/8Ma/fqv16mso5mlhvybjGlEoBUXW8TCVSs8H1gSSNFxdTnnVtap627Ncg
         fJLevg7YWJJoXkirpErbLNaW1TApAPaetbfgPJwS6fz5Jm2lTg9jT93l/kPKbzukyIq1
         k06gjojclJp0prEpr9XqjtlyyxY3SvknFQUBIjKJH1jeJSkk30yMYMiSDtL7N4KI36in
         /pwA==
X-Gm-Message-State: APjAAAUarCoZ4IcGNCIqRGUGDPRqQEdJtni6zCmhkYJz+To1KmeXK6WB
        FuM8QV2RUDVqZyYRucz3mIB/sLcbo7I=
X-Google-Smtp-Source: APXvYqwaVxrPgUfy7StzNR3apPF8IB6CDqSnpQNMobiPcxZb4DsGDLK7k/zF4nLBjsKYQzSSNFlRjw==
X-Received: by 2002:adf:e791:: with SMTP id n17mr10943405wrm.388.1569869743740;
        Mon, 30 Sep 2019 11:55:43 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id u83sm1131184wme.0.2019.09.30.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:55:43 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 2/2] blk-mq: Embed counters into struct mq_inflight
Date:   Mon, 30 Sep 2019 21:55:34 +0300
Message-Id: <6f3392cd20e00cc1d6060bada86ca3db540de585.1569868094.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569868094.git.asml.silence@gmail.com>
References: <cover.1569868094.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Store inflight counters immediately in struct mq_inflight.
That's type-safer and removes extra indirection.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3359a0b6c398..d97181d9a3ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -93,7 +93,7 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 
 struct mq_inflight {
 	struct hd_struct *part;
-	unsigned int *inflight;
+	unsigned int inflight[2];
 };
 
 static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
@@ -110,22 +110,21 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 
 unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 {
-	unsigned inflight[2];
-	struct mq_inflight mi = { .part = part, .inflight = inflight, };
+	struct mq_inflight mi = { .part = part };
 
-	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 
-	return inflight[0] + inflight[1];
+	return mi.inflight[0] + mi.inflight[1];
 }
 
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2])
 {
-	struct mq_inflight mi = { .part = part, .inflight = inflight, };
+	struct mq_inflight mi = { .part = part };
 
-	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	inflight[0] = mi.inflight[0];
+	inflight[1] = mi.inflight[1];
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
-- 
2.23.0

