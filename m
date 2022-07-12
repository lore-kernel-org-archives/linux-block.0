Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D21C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 20:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGLU0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGLU0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 16:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E722CC9239
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657657581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uitgsVWXbdrv8zFt2LqySt7cam5rPIej+nIiQV98pw0=;
        b=C7lNcKdTIO/4t1o2w+QipgLIS+tgXICwbZa4beRgCa3ofpm/Thvl/MpY1jDnDqbZf6eqOD
        pTYNI55BAq8WGCSdthDABJit6sAsBRKCxFgYsXBgpDpmF40sYs8NOzcw8G7CX5kNmTnbot
        iR2p+1SmXQr1b/wZWx+HIgNF6GLz0uE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-L_e_yzs8OciyTreOy7mcCw-1; Tue, 12 Jul 2022 16:26:19 -0400
X-MC-Unique: L_e_yzs8OciyTreOy7mcCw-1
Received: by mail-ot1-f70.google.com with SMTP id cd25-20020a056830621900b00618ff1dd900so3462463otb.13
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uitgsVWXbdrv8zFt2LqySt7cam5rPIej+nIiQV98pw0=;
        b=QDpL387Px5CPeyoUnGrsbY+OGRzK/1LpnF0ysw/tvnLUKcmP5jwafaBon3XvhmUr1+
         naLjiJ5o3SC7tTV07xEqi3JfY3Jh+x1vcY/nbfYDC/uzOR1ddyGwIOu6qbUK682B7FTN
         w6CzjSpfBJpb72Jo5ZfbdRmy6sQq4VIVcSsT9cD8Wgk7J+vd1earGaZq8u2dQVq0A/Y1
         uweAQIHKbNn/modoUkvt+0cbXFsnmnQyuljxFkg8lskjFXcRRLTpGfkvdFn/AS6LdNyV
         ZjbPWuKBqh7ZUOTdtDTVabzX85PTVvEsctpoL0sDMf8AW3afVRDhxQFBURWEsLSlqs4C
         aa6A==
X-Gm-Message-State: AJIora8L9S3/P5Nu8O/FmgqZPUe3X+pz1BmyLgrnqaZB+LX/QFYjt1eH
        VUMbWEVsPphVFEwavcyuuMOHmJinLE3K7tfhaYd+mpUO24zdKeRfKDpHC0JCtArw1u/cgN/s72Z
        DV8OnRQiYbqaA6g0Nm5ddQOs=
X-Received: by 2002:a05:6830:608d:b0:616:ecd7:de2 with SMTP id by13-20020a056830608d00b00616ecd70de2mr9966415otb.119.1657657578770;
        Tue, 12 Jul 2022 13:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9ZClxcrqJht1T6mxLG+napIslBEJNktJNzhxGbv3GvFDTtH6eVOCwyrB0kLgCN4MgD4pEBw==
X-Received: by 2002:a05:6830:608d:b0:616:ecd7:de2 with SMTP id by13-20020a056830608d00b00616ecd70de2mr9966403otb.119.1657657578577;
        Tue, 12 Jul 2022 13:26:18 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k26-20020a056830151a00b006168bc4caacsm3992119otp.67.2022.07.12.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:26:18 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     axboe@kernel.dk, nathan@kernel.org, ndesaulniers@google.com,
        viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] block: move initialization of i to its definition
Date:   Tue, 12 Jul 2022 16:26:08 -0400
Message-Id: <20220712202608.630259-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

clang build fails with
block/bio.c:1232:6: error: variable 'i' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (unlikely(!size)) {

In this check, the code jumps to 'end:' over the loop that initializes 'i'.
Move the initialization of i to its definition.

Fixes: 9a6469060316 ("block: convert to advancing variants of iov_iter_get_pages{,_alloc}()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/bio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a98b90489ae0..aff36ca7cabb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1199,7 +1199,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
-	unsigned len, i;
+	unsigned len, i = 0;
 	size_t offset, trim;
 	int ret = 0;
 
@@ -1234,7 +1234,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		goto out;
 	}
 
-	for (left = size, i = 0; left > 0; left -= len, i++) {
+	for (left = size; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
-- 
2.27.0

