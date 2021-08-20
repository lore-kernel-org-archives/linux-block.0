Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12BBC4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 01:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D0A610A1
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 01:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhHTBzw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 21:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhHTBzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 21:55:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA86C061575;
        Thu, 19 Aug 2021 18:55:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so6178259pjl.4;
        Thu, 19 Aug 2021 18:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mhQIHJeB9xPs8YShRp+asvR80V4gca3+V4gFFdJVimE=;
        b=p4bv3qSEaxTKVs2nFH71QWnikszGoFM/yogLwoJswANAKwaq3N23m4n4+oyUmxn95W
         iP6AtGLnFP+JBLVGuC3JrmHSJ/RoSSH01AMLe41TRNchYyETUXV1KMfGgWbDJGHG4yox
         EMR+vGqIBY2CGHlDbuEHWigbWC6vU9E5XArV88GUfu4ifue5ftsuZZ4Phw1trSnRm0aZ
         PICRxVhg3/14qAZ6rBMeSDvizrn+X5L4z+v8kat5qKYv8ceRtK48T7pOhVMOlMmoJHpZ
         juMZbccIzWyXIRdcE2AktRWwijYx0aBQAjCksbN+cqTIIfsF+Vp9rfJe6bz5b7x1ef9v
         ZfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mhQIHJeB9xPs8YShRp+asvR80V4gca3+V4gFFdJVimE=;
        b=WNKezSU1TaQg2X4134otJ8lR8+R2Dqhgd2DtQPUwkg1ZGRvMqQU6SmQIvNmT5012EL
         /gS/dQ4Z6IvG0hsIAeNZ13o5qt81ADqmLrY4VO4SzmRy5WwUFC3aNUsKxWQIU+76gGFm
         CmgYPDvR6wA+zp+jiYU4yjU3VmgGFvCU1quzHJogsvjaDTyFNb5DRO1EejLU6bA0R5If
         C7b5KVaStOJCJaBvxm/ctI6mTaejtN+8XSKVa9UNSCw67aR6ASYHiQ7MXBduZGjwe3en
         q29d9nXPKCc/U8Qmzkc2ErUr5zmvU9dmm/ILT0kZkpBZNU8azawshNVORm11QYisFCYZ
         IQsw==
X-Gm-Message-State: AOAM5323lmpEMC/z+jpm3BH7N4CwPlVTApUh5ScV4AAxsnu3aJ7SutC1
        +4prMT03/17VrhnQOpO2Uzc=
X-Google-Smtp-Source: ABdhPJwJSCCcAld0QvkFJRBIlhEEInIOOMLKmUv+QzKVUt3cpG34TGTi1tKuGLSa3Otw5s3EqLNjyg==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr1944327pjs.57.1629424514945;
        Thu, 19 Aug 2021 18:55:14 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x13sm4552671pjh.30.2021.08.19.18.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 18:55:14 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: use enumerate instead of integer in op_is_write()
Date:   Fri, 20 Aug 2021 09:55:12 +0800
Message-Id: <1629424512-29553-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

For mask operation, using enumerate may be safer than integer.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fd3860d1..b0411dc 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -447,7 +447,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
 
 static inline bool op_is_write(unsigned int op)
 {
-	return (op & 1);
+	return (op & REQ_OP_WRITE);
 }
 
 /*
-- 
1.8.3.1

