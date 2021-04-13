Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2548CC433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065C9613C4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhDMKxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbhDMKxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE643C06175F
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w3so25209730ejc.4
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obEac+9Zc6bGKd4KfPkTZdxJfUx2XdIM7kC/FXrC9/c=;
        b=KonNN35cLh4+Zo8yZ5ceNhasSLNlDw3TZ0JBNLtKjP1q6+1WiAd4RBRxXKGb0HZZ9i
         Y4OeWPK3U5dItjY+b9WG+LyQMZSWbVvgniMFNsiev5Es/xoe7hAfEmQRZ4jc+rhia1jP
         u+JbrzjIoN9TXHl0Anfk38VrtbLkWxGBPsV40fZD4POEwweehx73YqXRJcpl6ozqryrE
         PMp/Tcsl46ceKICeLCxLBN8Aqdn9NRZyYu4LPs4vkYwZBd5VuW24LT8cFfc+2gKjWpyf
         WivCUx6CKsY0As0BNFTj9+TGsNsc+iiRrsAJ4Za80W6nAnWQnAObv5ZtOe4q7Qwy9C+r
         fXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obEac+9Zc6bGKd4KfPkTZdxJfUx2XdIM7kC/FXrC9/c=;
        b=iRsjUID8JRv1k7YS8ChYFcUiZs6/b6wgfxuJdkSQp15lFRk5Dnm9FGGv5F2ZHzND+Y
         pXm5Gi3r8PAs0qTUDOXjsymm089gv7dVj3dYY/B91SszWD+xVBeyUch6sI/gSidkKqYu
         WUG/ww2WIVZs2NQRKcPKvL2mitd/6RqExI+Gb3PqwUV/W6CZ+cIYALj1OR3RTZAYDlp5
         6D1EPCqoGVjFHPKVH+UGGDhSYxmPQHrVilT3ET0MfDFZ94GzGQSD9YucxjDTGMXz8vW2
         gzhxAOagfw7aMnmjHiVXN3ilf2DjUNYgOUjrrxrcoX5kAslUeAiYIl9BF9dotfkpCmZI
         a8Ew==
X-Gm-Message-State: AOAM5315vc9FoUg1J/xJTHFc8Y6ylLGQbM/e5ZstLVlUpY4kKPWjbfIk
        To61zUKfze0NewxgkCeHMznkPw==
X-Google-Smtp-Source: ABdhPJxpWFashQBS2gy90LyOD7Nv7Bo5FOPIVjCP8QbDdfuimCoh+C6KBmBg6FBuKFYLfS87x3LLFA==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr31722634ejz.318.1618311189604;
        Tue, 13 Apr 2021 03:53:09 -0700 (PDT)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id m5sm9140064edi.52.2021.04.13.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:53:09 -0700 (PDT)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 3/4] lightnvm: remove duplicate include in lightnvm.h
Date:   Tue, 13 Apr 2021 10:52:56 +0000
Message-Id: <20210413105257.159260-4-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413105257.159260-1-matias.bjorling@wdc.com>
References: <20210413105257.159260-1-matias.bjorling@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/blkdev.h' and 'uapi/linux/lightnvm.h' included in 'lightnvm.h'
is duplicated.It is also included in the 5th and 7th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 include/linux/lightnvm.h      | 2 --
 include/uapi/linux/lightnvm.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 1db223710b28..0908abda9c1b 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -112,10 +112,8 @@ struct nvm_dev_ops {
 
 #ifdef CONFIG_NVM
 
-#include <linux/blkdev.h>
 #include <linux/file.h>
 #include <linux/dmapool.h>
-#include <uapi/linux/lightnvm.h>
 
 enum {
 	/* HW Responsibilities */
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
index ead2e72e5c88..2745afd9b8fa 100644
--- a/include/uapi/linux/lightnvm.h
+++ b/include/uapi/linux/lightnvm.h
@@ -22,7 +22,6 @@
 
 #ifdef __KERNEL__
 #include <linux/const.h>
-#include <linux/ioctl.h>
 #else /* __KERNEL__ */
 #include <stdio.h>
 #include <sys/ioctl.h>
-- 
2.25.1

