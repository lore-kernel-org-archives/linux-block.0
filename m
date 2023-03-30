Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D410C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 10:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjC3K1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjC3K1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788E868D
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d17so18510098wrb.11
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1680172068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxuugpcQ76BXjko3+ER6Q6ni4tgUxDBWpukRzkNP/mE=;
        b=7oMlBfhkg3pXtjNkNKYK6xQ5A2jpHJggTmkgMODtT7kSBNGVCxmeCyo3f8bPkJOPn4
         0PXmt7Nn2UD3UwmgD8kZExkVBgJmLw9oTCueb6virrw+Uo6A4SmCbAP9tZRdahLOn87m
         egOdqioJ5oC3ulBwib1UMyYTtdGcbR31ydt3Ck+hVsuvTwdajoJH02gNY34f6NLHVNNC
         c6T/5JrRMykYICRQLEHdj+Q2fxG1k8lxg9K+KHeh4uxgrpJgdnwzwh8oCBRUdhtO/Qca
         TCZxFaEaqvNeFDwrcs48ZxSGos0pKgSFF791YP5ZBgnkfkiVMyUoU62gpy9hpg25dbN2
         GFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxuugpcQ76BXjko3+ER6Q6ni4tgUxDBWpukRzkNP/mE=;
        b=VTU6ehR9V8dAhMnymUJtK+o9zeL4cGU9onqe6obPAjyiB3juvJG7BRmeh50wPllduW
         bFkksnYTe8srfhuIlpGCfuc45Hq8bv2G2X4MKMTGBfItYqCEyhYoM/Drq0MWskldAjXf
         3iy0AykZpzyMF9NHo+Gxh1L93oO5lTcTr3/D8srPHZyi2BSuMylpgEvrcLoaKhuWqW72
         YwmxoVj3EswovH5YOGP50jNJqQXLVS6pBcq/nFoSusvI1p2kQtdbbaogmq+MHb5nlywB
         Osc/qDFjrfMX4DNdild33udxcOMiNkod2Tn5sCwXDeB31j4Fm2gesXEYmikkNSTc5qeE
         cXdw==
X-Gm-Message-State: AAQBX9clHH3EzPWIwksT7qgwzn7pUKwczLU1mS4OaqW6d9dKcf9Y6HhQ
        QD6YYqt8aidMZyhwU91nBcAA0w==
X-Google-Smtp-Source: AKy350bXSIQSFZjlrygoaqORkCmoTaW/pnX4rfr6TDOOG/AZ6erorXitgDUp/xfzRz63wfamI/Gf0g==
X-Received: by 2002:a5d:4688:0:b0:2c8:b9cb:885e with SMTP id u8-20020a5d4688000000b002c8b9cb885emr16950780wrq.24.1680172068590;
        Thu, 30 Mar 2023 03:27:48 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s11-20020adff80b000000b002d6f285c0a2sm26352514wrp.42.2023.03.30.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:27:48 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 1/7] genetlink: make _genl_cmd_to_str static
Date:   Thu, 30 Mar 2023 12:27:38 +0200
Message-Id: <20230330102744.2128122-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Primarily to silence warnings like:
warning: no previous prototype for 'xxx_genl_cmd_to_str' [-Wmissing-prototypes]

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/linux/genl_magic_func.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 4a4b387181ad..2984b0cb24b1 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -209,7 +209,7 @@ static int s_name ## _from_attrs_for_change(struct s_name *s,		\
  * Magic: define op number to op name mapping				{{{1
  *									{{{2
  */
-const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
+static const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
 {
 	switch (cmd) {
 #undef GENL_op
-- 
2.39.2

