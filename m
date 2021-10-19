Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85527C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4C360F46
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJSV1D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhJSV1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:27:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98366C061769
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so5646918wma.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLzdRAYlFpXAuyX/ejQgU4JIAricFq29j5NgCWLoWFQ=;
        b=jjJCSe2kc5Nxnbqf80nrfoRN1PFPXQLedsRyVRDlsuJ7lU1+l+EFjyO59Y7DjbDFil
         pGziT2Bw9/pPEdhVL6U+ZlGC55Nd9cmLNNJBoRh+hxYcsnfgVruOJPL2LSstHJJYJMOg
         8dknfy+mSbQvnCeJqtSoeWUteCp/iFLY980E8KGFhCVwhA2xY8yoA1O2n4t51MzJe43X
         vPnJnkPC9xdO2tO35FYu1KgJ2vs4tfF1xxsj+8s1vgxaB896+WU1Ta80h68CdUrOdwmK
         atHfE7mJidQ5EE6cl0OrAmQLjw+uxFF086tTE+GgFWsg+h8YJIyQj3idZim7/k40yhgL
         TS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLzdRAYlFpXAuyX/ejQgU4JIAricFq29j5NgCWLoWFQ=;
        b=zDZFwWvVBZj7FdZpH9UgFyPsU98O/uGAOjdON3YoeITZM9dHRIqwKUdNrMCTlY5JNI
         DqO4Q/PSYXyIRua0vzWVsrhdKp/pk9+TNeMAIPU1BBpmzs1Wvfj5ibAgnf4wxk0f+6wD
         nZlBQ/MQQozowMyGwnrL+vcIB6C1+5Le22pu3k22qyO9Tp/lSSoNMCUhW1VchFUfWI9y
         cDQYwxXw4sVFBoZtUNaTOu0BOAMAbkuAI5mOuTqT18vkhU8dI06XG70LF/vULhNEvuec
         5wKAZpfp2hwNty3E7FxF/cMlhMncuVnm7epY2qBeC6m9C3D2njpQYFKZKmRCgZ/gl2Bo
         A0Fg==
X-Gm-Message-State: AOAM531+p+Uum46c8Nj+lMSCxlQ99FFx5but9sjnH4vS/PFlVaYMqvtZ
        mpbPMUioZCgWGlVCKm1GgroWIdWbVuZuNw==
X-Google-Smtp-Source: ABdhPJzOMbQsmR3Nnhi+3GI8AsYibqfLuk3p3LpTSDiMuZJ+1+G/t4Veplwijaqpo5VJJMzf6yG4HA==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr45665720wry.273.1634678685041;
        Tue, 19 Oct 2021 14:24:45 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:44 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 15/16] block: optimise blk_may_split for normal rw
Date:   Tue, 19 Oct 2021 22:24:24 +0100
Message-Id: <9ded7cf6a3af7e6e577d12a835a385657da4a69e.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Read/write/flush are the most common operations, optimise switch in
blk_may_split() for these cases. All three added conditions are compiled
into a single comparison as the corresponding REQ_OP_* take 0-2.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 6a039e6c7d07..0bf00e96e1f0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -269,14 +269,18 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
 
 static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 {
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE_SAME:
-		return true; /* non-trivial splitting decisions */
-	default:
-		break;
+	unsigned int op = bio_op(bio);
+
+	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
+		switch (op) {
+		case REQ_OP_DISCARD:
+		case REQ_OP_SECURE_ERASE:
+		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_WRITE_SAME:
+			return true; /* non-trivial splitting decisions */
+		default:
+			break;
+		}
 	}
 
 	/*
-- 
2.33.1

