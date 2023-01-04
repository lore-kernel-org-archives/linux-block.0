Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC44C63705
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 16:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbjADQKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbjADQKA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 11:10:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CE40855
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 08:09:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r72so18227734iod.5
        for <linux-block@vger.kernel.org>; Wed, 04 Jan 2023 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NceN64ihHFquTuLGhD5Npe0nXgiqifj2CJk94Zzl6z0=;
        b=NociWIKXuyQ8xwB3tKzZisCoZQOrmK59v7IkBn4zBEMkLQG2X/rUm5T0yboMfW+26m
         DOIHblpZ2TGhKukqMJKeHqtvOCQEjFnBhD6xOGlgKv7PTA02GS/JarbtVL6svrDodEUM
         jWLhF4FLV9kT4LreSgP19QhkyOfba18OCN8p+KlQKRBUq3BQC16ojY/XObu4tFrOL+NK
         e4K79iWSCpvNx54wP/vfqGLgIWtVARG1n52G0IK3vrAXfHKR6ebkyr0nsNhocPYI7sXQ
         KSFlN5uNmvIS3ieEF3fcDWedMKHnYAm6kBKnFtXJfBG+hMbYtSS+Egrv4HZNYEtRi+gX
         LKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NceN64ihHFquTuLGhD5Npe0nXgiqifj2CJk94Zzl6z0=;
        b=reNTeGJYqqYkmSJNk5/M02nDLc1wknf3Xv7hsxaMgPzEfh7u5deZ2xpeMoT1ukQHNX
         g2A+xk6KpVBEM+B6gi8UmNXUbWoPREV96Y+FPdPHbk0Teo480D0qPSW4IABvtx5TY2Ji
         qvakz1i1a3vff8qP+zA4p7dmjX+xlJVZsjE8JRiCZQUpvrJJ7vmyBfzsIs0wKumIRWrV
         bHxpIy9Y+ZM3QLeYg8EOf6E8exiQ6oUQIJ8qomJsabWSyg1bLvNld7h92lQ+SdOFZR7A
         a1jjsiiIoBVMmp3YJ3+zD3z+DytaE1n/ExrPaSOEcKdprcelyzOYkGxq/8PQRIUTTq31
         t6OA==
X-Gm-Message-State: AFqh2krsFPDsHittrWxjHKrOr/8nxqTQSg44nY3IBAWJ78tu+Zk9W9r4
        5FGG/fiLPq6WpuLrRsevuKKzHD0ad0OyjUCA
X-Google-Smtp-Source: AMrXdXuAbUuaXYHlaQnr1bXlr6i2H3IR4Kv8gJ4kOtCPepAxuAwlJOy6+WPgC7DcPdBWChQJ8HSBJw==
X-Received: by 2002:a6b:e812:0:b0:6f3:fed4:aa36 with SMTP id f18-20020a6be812000000b006f3fed4aa36mr5079162ioh.1.1672848583815;
        Wed, 04 Jan 2023 08:09:43 -0800 (PST)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t24-20020a02b198000000b0038a41eb1ba3sm10955243jah.177.2023.01.04.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:09:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     mikelley@microsoft.com, Jens Axboe <axboe@kernel.dk>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] block: don't allow splitting of a REQ_NOWAIT bio
Date:   Wed,  4 Jan 2023 09:09:38 -0700
Message-Id: <20230104160938.62636-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104160938.62636-1-axboe@kernel.dk>
References: <20230104160938.62636-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we split a bio marked with REQ_NOWAIT, then we can trigger spurious
EAGAIN if constituent parts of that split bio end up failing request
allocations. Parts will complete just fine, but just a single failure
in one of the chained bios will yield an EAGAIN final result for the
parent bio.

Return EAGAIN early if we end up needing to split such a bio, which
allows for saner recovery handling.

Cc: stable@vger.kernel.org # 5.15+
Link: https://github.com/axboe/liburing/issues/766
Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 071c5f8cf0cf..b7c193d67185 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -309,6 +309,16 @@ static struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	*segs = nsegs;
 	return NULL;
 split:
+	/*
+	 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
+	 * with EAGAIN if splitting is required and return an error pointer.
+	 */
+	if (bio->bi_opf & REQ_NOWAIT) {
+		bio->bi_status = BLK_STS_AGAIN;
+		bio_endio(bio);
+		return ERR_PTR(-EAGAIN);
+	}
+
 	*segs = nsegs;
 
 	/*
-- 
2.39.0

