Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCACC25B0D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 15:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiHFPUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiHFPUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 11:20:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679BE27C
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 08:20:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so5043927ply.2
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x+rg3l5+RTbusQB0ppV1F1CJZjLcHIeSUkGmaVShyQg=;
        b=amXbFbvlCtFJUaDcAuJ9wxOjQ5Rgd0ElkRczUWjoM1lTm/eFGGlqeypxjX83hfOSrv
         Sl5J83BI2sirvZ/oZJaGksPo/x4airPZYQnnROQEloWoG/GEvOhjJmCWdUZqKG94XXHm
         no9wLiwAqTh/W0q84w+QtEifEYC0TcvuSPKjXpjbOwQ9Fum6wDrKUOKvqs6pnUEG6vRi
         pUQAXF+rY23fEDMnjfndYc5bzRs3qZ7sXrOZ1Y8iStKb56ctkdnPH2hVLlllpu+i0DD5
         ivg5pie76Go1U14B9+J+EQYoO9Po2v18+qHPRStzTmguz2cgd/9DlBbX+OVbeavJ3C6x
         SHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x+rg3l5+RTbusQB0ppV1F1CJZjLcHIeSUkGmaVShyQg=;
        b=I4kwyygvY5TI3NdqA53xlclA5tcWIOCOzKwCF0Z7787IFHiZXjO7xcJaN8Po0l5cQt
         9mW9lQgRx4DHcq8UijxwNbt/CiVZaTP7fhqVpNr1e+xq7mry44Py2bGqrR/Z3oVnQGau
         OiL26fddPMK6yXkTrl8xqC4PA+k3Wg5gFxPzKtrsFyC19MdtOyf53yat6fs1XckkZiNQ
         MDTezP9xfSJBXeymSHmLD7wPFx15i66mBKJKwk1OLEelf243Kca/LHYnCyveljyuf9T0
         dJVGG/XLarnNL4/wJNiTCGs+fzJG0lfeJk7rsQQXtxlyfluKjpUmM+9C2eDuq4YDyjf5
         mXEA==
X-Gm-Message-State: ACgBeo0pRiM26vbpQjJuanQ8n4QgJIqnNjHkIpuymAo+u0kEIH/fwY6W
        WYzf0IwNSwddhx+ZpEJTN6RXp2XJtoQG0A==
X-Google-Smtp-Source: AA6agR69ElA9pX1wqKT3t6N3Lg0yicQ9k3YjsVneHyXjDvCfRO5ANknujnzjjMIf/E0sb3ZFV6WM9g==
X-Received: by 2002:a17:90a:150:b0:1f3:1dc7:c9f0 with SMTP id z16-20020a17090a015000b001f31dc7c9f0mr12773936pje.237.1659799210813;
        Sat, 06 Aug 2022 08:20:10 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b0016d1f6d1b99sm5158661plw.49.2022.08.06.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:20:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     joshi.k@samsung.com, kbusch@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] block: use on-stack page vec for <= UIO_FASTIOV
Date:   Sat,  6 Aug 2022 09:20:04 -0600
Message-Id: <20220806152004.382170-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806152004.382170-1-axboe@kernel.dk>
References: <20220806152004.382170-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid a kmalloc+kfree for each page array, if we only have a few pages
that are mapped. An alloc+free for each IO is quite expensive, and
it's pretty pointless if we're only dealing with 1 or a few vecs.

Use UIO_FASTIOV like we do in other spots to set a sane limit for how
big of an IO we want to avoid allocations for.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-map.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 5da03f2614eb..d0ff80a9902e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -268,12 +268,19 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	}
 
 	while (iov_iter_count(iter)) {
-		struct page **pages;
+		struct page **pages, *stack_pages[UIO_FASTIOV];
 		ssize_t bytes;
 		size_t offs, added = 0;
 		int npages;
 
-		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		if (nr_vecs < ARRAY_SIZE(stack_pages)) {
+			pages = stack_pages;
+			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
+							nr_vecs, &offs);
+		} else {
+			bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX,
+							&offs);
+		}
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -310,7 +317,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 */
 		while (j < npages)
 			put_page(pages[j++]);
-		kvfree(pages);
+		if (pages != stack_pages)
+			kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes)
 			break;
-- 
2.35.1

