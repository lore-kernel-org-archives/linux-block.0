Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C23C43459
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4998D61A3A
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCYPaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhCYPaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F56C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jy13so3623171ejc.2
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvJ5MzPF8I45JiDjPGx6l81wa3gYMJbbWHVkqSrx3qs=;
        b=JYtzoB9rbYVNaiTwK56FA2ykWu4P9cfGTM0wRR01Fx5K6xNYDiKGN+7TCrPgZfRQ5T
         FWAyFOrfKQRFr3d5C3lmAszhTe7OKCA9vznaItItMnlJuUVSvNWc+iOVuxxhdhniOKCx
         DINhXgkAGoMcfaIURlkWFrKxfhJ7yh4kVoh52DCY0Pv8tB+h68rlIjAbdnGgoyuRgx2b
         Yu5Re0eFmaPaBZglk2yGaxi8pOQB6UlRIf2XbhisnhDncwVDg7B+leroIa9GOMvopIp5
         PCTlhJ4moJkVbrPMEzLUf9dsM3oo7yBAqoMl4TpCLFhoHZJArBfq40PFWXycO1WxG24b
         /Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvJ5MzPF8I45JiDjPGx6l81wa3gYMJbbWHVkqSrx3qs=;
        b=D2X1JCqhDcQU8zwxz0W6E/Jg2IDWEvE85kPsdVnGgMIsCZOJmhHbj3cjVdfp5EYGxR
         mLg600NRWtwrqULhvzGMb/j8561AFvLaNsLesa+KicAKdko+MNFbG2Dd+vh/d2jTNEQW
         /GGdXOwDnFCi/X07U6bVEt90guw5lcb3HcXnVPe3t5ME5+8n6FiIkSeH5VJhL8ft1vwh
         /nd8dCDklWEhNN8u+cf05iui9cb6TUVjddw35uJUprjc650hBLm2vpkWlnx3IQtctuED
         ZVxfRd9FVp2EKRfVCHe8Fl3Im6Rk6+RKfv0fJ8coMHnZ5okehcIOxcjEg7rOo77llFvE
         ixMQ==
X-Gm-Message-State: AOAM530Ex+jMETDcnieLsV7tMNZQmGujPtUfArDWKifY6hH4rBuEOTXg
        ZDJC0f8K+1XSlrailKNtWruphOAXXvkAEJBF
X-Google-Smtp-Source: ABdhPJwZeelBh9bHov0qCZ2G/7YSuLHYnmKQ6fFpr7cZk4e3o6iOeif6Jet6JE9s033Vazb3mO0oIg==
X-Received: by 2002:a17:906:8583:: with SMTP id v3mr10286417ejx.361.1616686208481;
        Thu, 25 Mar 2021 08:30:08 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:08 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH for-rc 23/24] block/rnbd-clt-sysfs: Remove copy buffer overlap in rnbd_clt_get_path_name
Date:   Thu, 25 Mar 2021 16:29:10 +0100
Message-Id: <20210325152911.1213627-24-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>

cppcheck report the following error:
  rnbd/rnbd-clt-sysfs.c:522:36: error: The variable 'buf' is used both
  as a parameter and as destination in snprintf(). The origin and
  destination buffers overlap. Quote from glibc (C-library)
  documentation
  (http://www.gnu.org/software/libc/manual/html_mono/libc.html#Formatted-Output-Functions):
  "If copying takes place between objects that overlap as a result of a
  call to sprintf() or snprintf(), the results are undefined."
  [sprintfOverlappingData]
Fix it by initializing the buf variable in the first snprintf call.

Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices")
Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 630351574d1b..b1d04115e049 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -515,11 +515,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	while ((s = strchr(pathname, '/')))
 		s[0] = '!';
 
-	ret = snprintf(buf, len, "%s", pathname);
-	if (ret >= len)
-		return -ENAMETOOLONG;
-
-	ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
+	ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
 	if (ret >= len)
 		return -ENAMETOOLONG;
 
-- 
2.25.1

