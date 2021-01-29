Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5203C433E9
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE764E02
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhA2Ez4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 23:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2Ezz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 23:55:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F8FC061574;
        Thu, 28 Jan 2021 20:55:14 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id l9so11148010ejx.3;
        Thu, 28 Jan 2021 20:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LFbmYzoW/dOJ4Ds9GuxLWzJiVIPVogsncjpBRDxZzqE=;
        b=G6b6hHEZQolaoYujMThrCKsmeO318Q0jyKSCNGH2d2SfQQtyNLnDWuvidfyOAs4g5j
         FUPrXpcsDl83Vjl8JUIZMNiYyy8LdcvAJXhi+ptk2E0mpZXTuiTYF8cPCtUhVIx1xRve
         yDAszQxrLEw94kyi+ymJlrh3VE/3xstSQEa/Icf1ob5CI/L4O8PpDbtxGdjP6mi7xvYU
         BsHkXsUpjHbrbvLYesJuNE/0wdDxLxITddXN2Kz3Vd8o4lN2X5+h6H5zEwhcsXJsG0mA
         PWr3dGI4f/IxGiXf1lzLWU0OCLrUT/JMvG0z3Uz5q2bNKo1xpWAtyqw6+kHoV8PagUyv
         S8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LFbmYzoW/dOJ4Ds9GuxLWzJiVIPVogsncjpBRDxZzqE=;
        b=ChaD/Yrn8moFyGqlHJ7Hyl+7eMJSX459wJUwdm8rxK07NVFMvfK44KS3YOCiBafki0
         1XgC89gwC9JXKvw5g/i4NCLNVGYKyqDdounCis3DJu00C3IbCNPkV1hbwuTr569/biRE
         SO+7Z62FovNY54ufjwUZICLd73lIv2MiqRU1SiRo5TDMr2LwzeUp4q7q/xRJd4eFZ6mJ
         cPC5GvNBlGBSN5J+sj42ejr7hsLLkrrGeh9WxuJLoZYz0gjOB1uXugc7Uyad1eTqNJOO
         0izRTBh8bWGOlPWHmKFKXWglGcRfpQtrOcJItiBZ3RnzJEmj4PXzW5tk0ZD0DbrNE1mK
         MO3Q==
X-Gm-Message-State: AOAM533DnJP+vzzZve3HpnKNghEQLJRsFMlt0Y84vgOD+NJXzyaQtXxI
        1r6KOyi8MoJvltwrwlW/E5U=
X-Google-Smtp-Source: ABdhPJwNS6rwahyR633e4Gd8I9bZfMcKgs0PMLK9XcLNmGucYcJzYw7VCH3ZwhfsqauuYNUVEEGEHA==
X-Received: by 2002:a17:906:259a:: with SMTP id m26mr2846528ejb.399.1611896113320;
        Thu, 28 Jan 2021 20:55:13 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d91:2600:859e:aee:ff42:2cc6])
        by smtp.gmail.com with ESMTPSA id b26sm3981366edy.57.2021.01.28.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 20:55:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] block: remove typo in kernel-doc of set_disk_ro()
Date:   Fri, 29 Jan 2021 05:55:05 +0100
Message-Id: <20210129045505.22743-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 52f019d43c22 ("block: add a hard-readonly flag to struct gendisk")
provides some kernel-doc for set_disk_ro(), but introduces a small typo.

Hence, make htmldocs warns on ./block/genhd.c:1441:

  warning: Function parameter or member 'read_only' not described in 'set_disk_ro'
  warning: Excess function parameter 'ready_only' description in 'set_disk_ro'

Remove that typo in the kernel-doc for set_disk_ro().

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jens, please pick this minor fix on your block-next tree.

 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index d3ef29fbc536..304f8dcc9a9b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1431,7 +1431,7 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 /**
  * set_disk_ro - set a gendisk read-only
  * @disk:	gendisk to operate on
- * @ready_only:	%true to set the disk read-only, %false set the disk read/write
+ * @read_only:	%true to set the disk read-only, %false set the disk read/write
  *
  * This function is used to indicate whether a given disk device should have its
  * read-only flag set. set_disk_ro() is typically used by device drivers to
-- 
2.17.1

