Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DEC4360F
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1117B20854
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQ4/460q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCGQ0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:26:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36043 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfCGQ0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 11:26:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so9905170wmj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rb+YsYLv5aeFW93p5pLsMf9umO1yuPDktu059+duwqc=;
        b=WQ4/460qM6FlUjNVkIEygVfdwtdGU0MVo3dAb9opKQ4YIY+njZ/t3bSyeLXDABk5Bm
         nabD9ZMJiJFyhcTjSRHDdvjJpzNmWPy1WmpctU3uppNVE3JMHQqfNuShfsyur5AqYxe0
         HtKf0IZCMtqqJqF7sNB0rZ9yiO8n7Gy1fEK7JKQteAE97aNYyBwK62roCArXJ118L609
         I3YJTpKmTs1imbEnclKCPdcIgMAD830znJpyFATC2ijZGG64rE3RcWWEI3w9VIwa4YdC
         GdGi4tUt4Voqynhw+88B2wyjZwVYXm3vTDix5O9xgG31dP+kOuX5mSykwsdzKW6ZcWrp
         bcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rb+YsYLv5aeFW93p5pLsMf9umO1yuPDktu059+duwqc=;
        b=ZgGbzVT6cDhEpDD9KnRbSJOwu7tcNt2Fj968sEn5mWNC3YUo7H6mOt5x5riTTjU3wD
         DM7fMpIwI8sjYvVyPuUIc/JR8DkLYvUzB5whjeSEDFIDDpKwpeIx2hON/OCAp2UiiwR8
         js8PzzowN5AkN2hx0voh6fuCespLOdFB0gKYncPwMvgZFBlAgf9Hgr0YBtBkNW3HLPJE
         HcmqRwwtTUEK+2OFMt6Tb9gnmAGXQzDH1rkhjwUDj+UvbAF62xjR3562rzyO8ITQ7fxW
         fQHC36OHUrZsJvqifqfQIV7nX/EEy//GUwLg/FJIX1U7gwD+xD2RF1JWCH+bRbxLZHRg
         DjUw==
X-Gm-Message-State: APjAAAWLW1tyVodpbeBFXuhZiN/owkOlo6R4w5lt3+qEB1oFc8yZdkmZ
        76Ug0fHWKpjkj42DMYTBeLKeVjhfsa8=
X-Google-Smtp-Source: APXvYqyLJ6BG63rxLyS0DfhUNnHhXMvveuGbX/88kf5WLxSFBtSPMtxpBGxpiH7g7qeoI9M8eWpebQ==
X-Received: by 2002:a1c:c644:: with SMTP id w65mr6170078wmf.19.1551975981462;
        Thu, 07 Mar 2019 08:26:21 -0800 (PST)
Received: from localhost.localdomain (146-241-117-61.dyn.eolo.it. [146.241.117.61])
        by smtp.gmail.com with ESMTPSA id o127sm5801797wmo.20.2019.03.07.08.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:26:20 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 8/8] block, bfq: save & resume weight on a queue merge/split
Date:   Thu,  7 Mar 2019 17:25:54 +0100
Message-Id: <20190307162554.77205-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307162554.77205-1-paolo.valente@linaro.org>
References: <20190307162554.77205-1-paolo.valente@linaro.org>
MIME-Version: 1.0
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
index 21ddb19cc322..18cc0e996abf 100644
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

