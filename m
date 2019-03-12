Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F4C4360F
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CA32147C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrDaoIOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCLJAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43748 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfCLJAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so1719752wre.10
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uB6F8nkcc+jXPBDeIaz78K4jgn2LvnmUlQ+OCREpF+E=;
        b=rrDaoIOHvvi1Hid8Z/1X9MJv6gwLoS8LoXZbdj6oUdt7UFvECfEJ4m+nd7XmpWb3YE
         lXm+YDALDH3MtZ+vzNGBMFG0m2ZY8j8uDlf+jmxHpp0Nr9AOXi2P2uy3+wn83FrcedIz
         3H/7SMt8j3yGMXKQBns/Oan2hMEiW4J+A8jZiH78kvm+zaHdUZG/OVDPEG/eaQC6ct88
         N9iPEdgAYVjW0D/wWQ3bH83ieHgR4LbYBtq+zEiGn2XCozM68fPT9c3zL9JwC90l5j+Z
         MjKJfOWGV//Oepcv8HhCU+H1rhg98ZqtVBhc/vLWO/DN/YlMYOP5kIQyK8pjJwQJaR73
         mu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uB6F8nkcc+jXPBDeIaz78K4jgn2LvnmUlQ+OCREpF+E=;
        b=pGD1+AixtMRPB4OlCYu1d7dEPiWrBPbc2z2PW0tq4Ptd2cL26+j3DCbea+24b0QjeL
         J3YFisjjsHp3mEXiamdXUCAucuYg25QWh9liJiQKZifqd0AS3bXIm8EqpBCKnndIuW5Q
         27XOmgTQbAQbDXY6NPnDgfbPpXv0zlEuTPdhAmtRZmvF5Y6Xi7sj49IZzmJBlhPiTrkK
         AoMpeg4ATQabq4LOwsyp+U18H5Ih9+wlcCD1QEllfEkwqwbq7ac8jtU8iHggjYOg3aEh
         IrhQCMo/SBkqnkvI9rW3Ohki1yion3MY/g7gQiUDiQ4Z1KP9rE7kQsp9GlNJ8sG6LOrk
         tfJQ==
X-Gm-Message-State: APjAAAXPmYwbGf3213lkzi0BLzPTRvpaingZjhJHolnSi72RkcsN6fUt
        h+zo+GgK/1YBbgECllRnGJUePWEy0Cw=
X-Google-Smtp-Source: APXvYqwtuDkW8vwYjQJx9QJeLRpVimDrPGoeFfYyOMEUoWVuvouT9okOK3TDWF25e4FO2e0evztqVg==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr2267713wrn.259.1552381216921;
        Tue, 12 Mar 2019 02:00:16 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:16 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 8/9] block, bfq: save & resume weight on a queue merge/split
Date:   Tue, 12 Mar 2019 09:59:34 +0100
Message-Id: <20190312085935.11340-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Francesco Pollicino <fra.fra.800@gmail.com>

bfq saves the state of a queue each time a merge occurs, to be
able to resume such a state when the queue is associated again
with its original process, on a split.

Unfortunately bfq does not save & restore also the weight of the
queue. If the weight is not correctly resumed when the queue is
recycled, then the weight of the recycled queue could differ
from the weight of the original queue.

This commit adds the missing save & resume of the weight.

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Francesco Pollicino <fra.fra.800@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 block/bfq-iosched.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7d95d9c01036..1712d12340c0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1028,6 +1028,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
+	bfqq->entity.new_weight = bic->saved_weight;
 	bfqq->ttime = bic->saved_ttime;
 	bfqq->wr_coeff = bic->saved_wr_coeff;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
@@ -2502,6 +2503,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
+	bic->saved_weight = bfqq->entity.orig_weight;
 	bic->saved_ttime = bfqq->ttime;
 	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
 	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 67e63c276c7a..60c148728cc5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -404,6 +404,15 @@ struct bfq_io_cq {
 	 */
 	bool was_in_burst_list;
 
+	/*
+	 * Save the weight when a merge occurs, to be able
+	 * to restore it in case of split. If the weight is not
+	 * correctly resumed when the queue is recycled,
+	 * then the weight of the recycled queue could differ
+	 * from the weight of the original queue.
+	 */
+	unsigned int saved_weight;
+
 	/*
 	 * Similar to previous fields: save wr information.
 	 */
-- 
2.20.1

