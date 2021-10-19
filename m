Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAF360F46
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhJSV05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJSV04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4029C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v127so14528226wme.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jm6YiXYaSKf1Zqt9LVojCcnO0QnTkC8Ut2wu+PHwNzo=;
        b=N5333q8jkDCaio8OP6MbDVBhyPmfg1CXghnBRdZ/UP/9ijugLHMfFnVaOzgpeihel8
         TYpu6EFsHP/npokzhzqiPmmNUUIEi2XqMwgLmk01+vNbWEQK3ikA85wrCP3TYy1FM6sk
         5HWLu6M85n6U/HQCQMd25iAoKjmk62qUglI38kJzikBObIZBLb+MJZc/KIu4VlojzISO
         odObSjLTVoMv4rI3jpYG/0wO59RtAAfqzCmdpnkOJJf/Of7Xa+jplOFovHnMJtxWlmWL
         MpjiekbVYoCNpGww0mTlWG0Z2PiVqOtXd6s0LoSK7UjWvTsZ1RPMUkmZmUBPuUlXNzKS
         2qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jm6YiXYaSKf1Zqt9LVojCcnO0QnTkC8Ut2wu+PHwNzo=;
        b=noVwGzZaf2Adr1hLWBGS7PhbkNMbLX2rHoz42F/0ZKcqxgsZLHo6lr59+sD215Lnos
         ZMvyl7OaJGOGyVu/n05jDqfYYH3IEZp9vl4/4DnBNHXQ5m12tTWz6otmP1zNa3JVOvV2
         jD12mQqmCZEIut4IDKqzg8HBhlOE1F22p8KsFalt0g0YqCtaprboGLlxofvRdQ7L8586
         OjMBySHzZpmLn1RFKNIGsrg5Ke24apPKXg7IAfh4//mKp75nPzetTjYnDt2/fVU/Da+v
         qGiXox7Hkl8N9D8+uZesz0tRUBG2Lp571pAl8fcYK0+myA3ui/kzPOeuK0okvlgnm1gp
         vB2w==
X-Gm-Message-State: AOAM5327WjtJ20VIw5g47gTZl5Vl0dDJrO6eAoGt9yMccGejeGCLba8W
        baqQjcaNPGdpRRpa08vg9OaHbkPz9PE9tA==
X-Google-Smtp-Source: ABdhPJyyoBc5eMgSOhDaT3ui6bWSu+Pjv942dGMhfA3WyvDAwEQqRyJ/3L7JvaUWWjQmRE4hNJNaGQ==
X-Received: by 2002:a05:6000:10c7:: with SMTP id b7mr46705416wrx.36.1634678680977;
        Tue, 19 Oct 2021 14:24:40 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:40 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 10/16] block: optimise blkdev_bio_end_io()
Date:   Tue, 19 Oct 2021 22:24:19 +0100
Message-Id: <8e6003932f65ecd9ada5d6296c6eb9d1b946a1eb.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Save dio->flags in a variable, so it doesn't reload it a bunch of times.
Also use cached in a var iocb for the same reason.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8f733c919ed1..8e3790faafb8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -145,13 +145,13 @@ static struct bio_set blkdev_dio_pool;
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
-	bool should_dirty = dio->flags & DIO_SHOULD_DIRTY;
+	unsigned int flags = dio->flags;
 
 	if (bio->bi_status && !dio->bio.bi_status)
 		dio->bio.bi_status = bio->bi_status;
 
-	if (!(dio->flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
-		if (!(dio->flags & DIO_IS_SYNC)) {
+	if (!(flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
+		if (!(flags & DIO_IS_SYNC)) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
@@ -164,8 +164,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 				ret = blk_status_to_errno(dio->bio.bi_status);
 			}
 
-			dio->iocb->ki_complete(iocb, ret, 0);
-			if (dio->flags & DIO_MULTI_BIO)
+			iocb->ki_complete(iocb, ret, 0);
+			if (flags & DIO_MULTI_BIO)
 				bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
@@ -175,7 +175,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 		}
 	}
 
-	if (should_dirty) {
+	if (flags & DIO_SHOULD_DIRTY) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
-- 
2.33.1

