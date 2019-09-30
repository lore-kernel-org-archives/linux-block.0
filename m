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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7215AC388F3
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4424F224FE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB7DFAoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfI3UoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:44:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35265 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfI3UoB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:44:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so12886189wrt.2;
        Mon, 30 Sep 2019 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teXekHXkibElMjuy/I4VdYi2D9nfW8tq92NFzmNTwQc=;
        b=dB7DFAoqTLYrUnIIMb7jp+RTLeMJmYC5aUWm96aflXizeCGha84H1r77ZG7+sNyqEw
         kwzDMIk69s0PN+8YLv24mpGt9jPF0mxOx+iaaxbmBfbLewg3WeIEf5SN3hZrCNQNFPvE
         SO+3XzcqY8TksKpLIkf0/7TsuQCl9+mG9eMSWIYvZPv+hy540djXZBxcgThmivm8xDse
         KW5lUswog/g8eSPOKKDHC6YOVCjKJxgXwTrUvCeVahJ1FMTuPdaD58yhFht00bnEJAH9
         UhANQtm+w0kMbkOkrp8ipG/PIZbQooW240UXPbRhKE/grVT43kkc9lKnPZKrtRdF1fcv
         QKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=teXekHXkibElMjuy/I4VdYi2D9nfW8tq92NFzmNTwQc=;
        b=cHPi/aAglO9iRcwjWq2zEuT0svZ5wknHa2Ku+N5EKh8arf/hbiU3bVVbjMUaqqtv6X
         o72NfQroq/pBhve9pXxQhfwq0qGiy6T+guMuo6GqCesmt9kZsCxQ+6DQb7gNouV3UZZR
         svXCzNLG9IR4kQqo5LCHKHEOOP/kYWdo6OOTkH6Ye9PjwVQGrhos3ISXQsmf8L+0Otiy
         R2Ivxo2JBwfM+czmOZqzRby6Wc3QJSmjtBrdnDlZAvFZTykgVhCZXMvvu6oBKlYz9/8F
         +AhuATqWEk0gDYA1EpNSJTVhM6oorfuHqcrtX3iFu7uHBu+TrpsKNHnYw7R8SyXkcGb6
         K7Mg==
X-Gm-Message-State: APjAAAWa6hZ8/sLZYFzoOU8k+uf3CmvDtnLYzL3m8Z2z/8AADoVOPzpU
        bFW4LkzxJuJvpc5USIEn1jsoIMCCG5I=
X-Google-Smtp-Source: APXvYqwqIZ5Y/V3nEsG58ppwE8WBexsMiSXHJ1gmDkZYpMXgTo2mPIGEnNWUFvkELYAUw5iJZ790aA==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr15261599wrt.213.1569869742513;
        Mon, 30 Sep 2019 11:55:42 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id u83sm1131184wme.0.2019.09.30.11.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:55:42 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/2] blk-mq: Reuse callback in blk_mq_in_flight*()
Date:   Mon, 30 Sep 2019 21:55:33 +0300
Message-Id: <5ad78089aff5387a81e7655296ae326d4d96183d.1569868094.git.asml.silence@gmail.com>
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

Reuse a more generic callback in both blk_mq_in_flight() and
blk_mq_in_flight_rw().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c4e5070c2ecd..3359a0b6c398 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -102,11 +102,8 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	/*
-	 * index[0] counts the specific partition that was asked for.
-	 */
 	if (rq->part == mi->part)
-		mi->inflight[0]++;
+		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
 }
@@ -119,19 +116,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 
-	return inflight[0];
-}
-
-static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
-				     struct request *rq, void *priv,
-				     bool reserved)
-{
-	struct mq_inflight *mi = priv;
-
-	if (rq->part == mi->part)
-		mi->inflight[rq_data_dir(rq)]++;
-
-	return true;
+	return inflight[0] + inflight[1];
 }
 
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
@@ -140,7 +125,7 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
-- 
2.23.0

