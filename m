Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF4BC43217
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF936136A
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhJSV07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJSV06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18AC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g39so10393320wmp.3
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAAEHR7unTmV3lAE/H9zviB08MujT1fS/ufxdxgv4h8=;
        b=jS4Ny2KcMg5TTsdHrVrjpQsbCJYujbQRK7VWCVU9Z2x2Le+rpboNkMGPxFD/bdPTu0
         eb2ZFYncBA5VehpLjpMEqD6jgzlv/SluF18hmrj/TzlfkoKcyWxdduE7ZlYiL7x9Q7XE
         DvEYAJUIQ4yKXiu8i/qBbKRVu9m9eY+Aa/i3yQRN0l0Yzb/hIa/4oJdewduUNqkTMMsk
         MZjm4azcsZUgmRUCURmb3y3T2ewXeYvY1bT+skdPm5sWKB6dmz5hkFbYMMhSROe+h1wC
         uEGUYuZFJcPlBgx3XY4/Ugn9X0/YCG7lZdz5wcJgrOZB6R2w3pkNY+UPRChvHJ6Irovh
         7AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAAEHR7unTmV3lAE/H9zviB08MujT1fS/ufxdxgv4h8=;
        b=TEtzBMjLu/HwxbjBDzwK0OGfljMWZi3IKmvgk4W98TgeupPxCw1MdpO8yEMZmbA/f5
         hWDErNf+tVJP4XfzUyTlLCNaklsqQFpDqDtyqFLG4JXgb42f6YfwZPleqcC6KjaqTkFk
         s/Jm2RxsqbweLe/B8Ux5G/OmkxDm1tXtdeBo4KDMDFrIgTQJieAd+91rzjX6dwWxdGLl
         TRds4y7E0EuIs/E/xgZxhG7tRvYuZFjTmSTmzw3V/2knp8VwRW54Yct6w06Rt+3VFIjf
         qKz4RgjcKWktqM1Srb6UhVuHezB2RPTRRL6VL0TOiQySQ8Iz3eTemG2sMYcGGXs+/KLj
         QnMg==
X-Gm-Message-State: AOAM531pcPNaKH8l9dmTAvjwmTd/OcbUfEQRJzj8+43Okzht5H4RpRDk
        K+s7val/mn8+0l+futdCXBSG7MwqHFBvCQ==
X-Google-Smtp-Source: ABdhPJytfxRGDCCGKdewe7Vi6WWDSlCavAi5rb0Vz9G9NCfat5PYXJupGhmZfIWoBDnDb2os108dBA==
X-Received: by 2002:a5d:6442:: with SMTP id d2mr3543633wrw.356.1634678683415;
        Tue, 19 Oct 2021 14:24:43 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:43 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 13/16] block: add async version of bio_set_polled
Date:   Tue, 19 Oct 2021 22:24:22 +0100
Message-Id: <673fc6ca8f2e761586d21c709348642113f13f86.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we know that a iocb is async we can optimise bio_set_polled() a bit,
add a new helper bio_set_polled_async().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c        | 6 +++---
 include/linux/bio.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0f1332374756..ee27ffbdd018 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -371,17 +371,17 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		bio->bi_opf |= REQ_NOWAIT;
 	/*
 	 * Don't plug for HIPRI/polled IO, as those should go straight
 	 * to issue
 	 */
 	if (iocb->ki_flags & IOCB_HIPRI) {
-		bio_set_polled(bio, iocb);
+		bio_set_polled_async(bio, iocb);
 		submit_bio(bio);
 		WRITE_ONCE(iocb->private, bio);
 	} else {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			bio->bi_opf |= REQ_NOWAIT;
 		submit_bio(bio);
 	}
 	return -EIOCBQUEUED;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0ab4fa2c89c3..4043e0774b89 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -743,6 +743,11 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline void bio_set_polled_async(struct bio *bio, struct kiocb *kiocb)
+{
+	bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
+}
+
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #endif /* __LINUX_BIO_H */
-- 
2.33.1

