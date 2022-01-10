Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 03:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiAJDNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 22:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiAJDNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 22:13:17 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922BC06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 19:13:17 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v11so9507267pfu.2
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 19:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eFUx4SMARgZxYwOXEZUnIV5/Uh8OliYT75QyzwhsQAU=;
        b=DXad6ZiuGxNyPxFq5H7NJZFlnamtqfwlz9qnyTUzkkDslbb+zoBxFUmTZLAVrbCmXJ
         dOIdrX+uIeLV2xFxGvizgOFQVVMmUyzYDaNQ/xHMJUrFlSc2jzgi+FxNcuORJJNzHc1z
         6rVdeeZVFrLiYLreuNJD9eCALOjyFRQ+08vmjtmnizJqXXabXi9EoqegaGMyV8jP0MX9
         hLc1FuVuOznRBnu0So6L2nA/twqfp17pVsL6aFYNbS1MM4Kx+9B4HEkZWcMTO60q3fk5
         3hFLc9scvMAmsYziZA3+OMMq3Gxrim8grHka37F+R16PXSKJfc54L5w/V0HhlWlyQhTU
         jG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eFUx4SMARgZxYwOXEZUnIV5/Uh8OliYT75QyzwhsQAU=;
        b=q8YOFfWKa0hs+OeQ1Dn9/VKwiBZe6O9rL3zsVXXFUhaAStoEvOsCjKjNeMp8hxW78k
         v/9JUaAMFsH3YiBq2MSPJlRo7QCdzffswc3o3Rt+ToS4p2JKy8FX9OAp9HmmoRiNegiE
         G+ryNK2GqMkhAW7BMV4ePEbYxls1aqfiU4UAenuTbIwnASzL0Yp0LMQkEjnLXKQnM8Br
         7ONRZinPHw9bqHZzJsLyREH7zXU7gt/ejkGpBGtl++jfwVA0GrHSFtTHBmfF8UwXJIe4
         YRvl29lVM9ehZPOQk9KVAoaa2NrG+YE8uELHrnz2D7LgN4z7BSXO3xiluqOPkWPnAwQK
         37pQ==
X-Gm-Message-State: AOAM5337Y5//rFYGPM58WdjN1z4RF9uCusew10ZT9KfFXpnVFhmfWPKL
        vBiokI9BDWvavy1bRVdmmvv4EQiypbM/oEDRDTM=
X-Google-Smtp-Source: ABdhPJzGH1gy9GtFrzKee5KH5iIYC+EUrL2OM60eEVXcr9ovb2tBDd6D7K/WvlKv1wvEgdqKhySjpg==
X-Received: by 2002:a62:4dc2:0:b0:4bc:d793:1e24 with SMTP id a185-20020a624dc2000000b004bcd7931e24mr23232145pfb.61.1641784397044;
        Sun, 09 Jan 2022 19:13:17 -0800 (PST)
Received: from DIDI-C02G33EXQ05D.xiaojukeji.com ([111.194.51.178])
        by smtp.gmail.com with ESMTPSA id y16sm4889001pfl.179.2022.01.09.19.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 19:13:16 -0800 (PST)
From:   gaoyahu19@gmail.com
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yahu Gao <gaoyahu19@gmail.com>
Subject: [PATCH] block/bfq-wf2q: Fix some typos in comments
Date:   Mon, 10 Jan 2022 11:12:36 +0800
Message-Id: <20220110031236.57199-1-gaoyahu19@gmail.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yahu Gao <gaoyahu19@gmail.com>

Fix some typos in comments

Signed-off-by: Yahu Gao <gaoyahu19@gmail.com>

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 709b901de3ca..2c85d28b6aeb 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -565,7 +565,7 @@ static struct rb_node *bfq_find_deepest(struct rb_node *node)
 
 /**
  * bfq_active_extract - remove an entity from the active tree.
- * @st: the service_tree containing the tree.
+ * @st: the service_tree containing the entity.
  * @entity: the entity being removed.
  */
 static void bfq_active_extract(struct bfq_service_tree *st,
-- 
2.15.0

