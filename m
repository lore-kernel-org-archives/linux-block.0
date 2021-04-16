Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5D7C433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99A86117A
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhDPIgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:36:02 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:45686 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbhDPIgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 04:36:01 -0400
Received: by mail-qv1-f42.google.com with SMTP id bs7so12553769qvb.12;
        Fri, 16 Apr 2021 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hw31C33PILT3DamWMHDgiiU6OjaR9sNFohiSgOeE+jE=;
        b=ozEtyBG3Phl6/wQE87UCOyHyzQHL9VRexGmg6ly4iNAUWgCJUmF2XOSJhJI98gSGGG
         5MRGy7N+pLvj4uf1gYWjDYP6fZjnlxxohnIpyUyHcBNi2wOHFw5iCXc7Ha+lOunJoqxI
         7erPW6KtNusZN3qKybhi4E03C+l1iaarlsjICLVIECGmbon6K/993joniEhlZcfOAkgA
         a0YYOo7cLfpg8pWSobq2ic+WxTVEAAwdihsH5GdRrqNUJFz4gepsPDhUYjivEJupM26Q
         Do/LhshPjeio4SfJR/TDiTQkBidn1W4txs0smrI6XnyaGMo9NyVbXW9BUdICUHL2WgHC
         7A8w==
X-Gm-Message-State: AOAM530BpNtNsRAHrWBJnOIQu6MFX7WXNtATo0Dlr6iXqclSsGaSZ/5I
        FhexyBi2oEbG5SthebaWQu6qrQoDsLea+g==
X-Google-Smtp-Source: ABdhPJxRjSNka1nHBJAG5Ilk39BekLvA8FURwLp7GDLBxBmAS6hbvbK9p7BYEXeabZ+VHaR0jEi/KQ==
X-Received: by 2002:a0c:a045:: with SMTP id b63mr1251841qva.19.1618562136393;
        Fri, 16 Apr 2021 01:35:36 -0700 (PDT)
Received: from black.ru.oracle.com (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id k17sm3363778qtp.26.2021.04.16.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:35:36 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] floppy: cleanups: use ST0 as reply_buffer index 0
Date:   Fri, 16 Apr 2021 11:34:46 +0300
Message-Id: <20210416083449.72700-3-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
References: <20210416083449.72700-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use ST0 as 0 index for reply_buffer array. get_fdc_version() is the only
function that uses index 0 directly instead of the ST0 define.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 960e5791d6f5..df5c32900539 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4232,7 +4232,7 @@ static char __init get_fdc_version(int fdc)
 	r = result(fdc);
 	if (r <= 0x00)
 		return FDC_NONE;	/* No FDC present ??? */
-	if ((r == 1) && (reply_buffer[0] == 0x80)) {
+	if ((r == 1) && (reply_buffer[ST0] == 0x80)) {
 		pr_info("FDC %d is an 8272A\n", fdc);
 		return FDC_8272A;	/* 8272a/765 don't know DUMPREGS */
 	}
@@ -4257,12 +4257,12 @@ static char __init get_fdc_version(int fdc)
 
 	output_byte(fdc, FD_UNLOCK);
 	r = result(fdc);
-	if ((r == 1) && (reply_buffer[0] == 0x80)) {
+	if ((r == 1) && (reply_buffer[ST0] == 0x80)) {
 		pr_info("FDC %d is a pre-1991 82077\n", fdc);
 		return FDC_82077_ORIG;	/* Pre-1991 82077, doesn't know
 					 * LOCK/UNLOCK */
 	}
-	if ((r != 1) || (reply_buffer[0] != 0x00)) {
+	if ((r != 1) || (reply_buffer[ST0] != 0x00)) {
 		pr_info("FDC %d init: UNLOCK: unexpected return of %d bytes.\n",
 			fdc, r);
 		return FDC_UNKNOWN;
@@ -4274,11 +4274,11 @@ static char __init get_fdc_version(int fdc)
 			fdc, r);
 		return FDC_UNKNOWN;
 	}
-	if (reply_buffer[0] == 0x80) {
+	if (reply_buffer[ST0] == 0x80) {
 		pr_info("FDC %d is a post-1991 82077\n", fdc);
 		return FDC_82077;	/* Revised 82077AA passes all the tests */
 	}
-	switch (reply_buffer[0] >> 5) {
+	switch (reply_buffer[ST0] >> 5) {
 	case 0x0:
 		/* Either a 82078-1 or a 82078SL running at 5Volt */
 		pr_info("FDC %d is an 82078.\n", fdc);
@@ -4294,7 +4294,7 @@ static char __init get_fdc_version(int fdc)
 		return FDC_87306;
 	default:
 		pr_info("FDC %d init: 82078 variant with unknown PARTID=%d.\n",
-			fdc, reply_buffer[0] >> 5);
+			fdc, reply_buffer[ST0] >> 5);
 		return FDC_82078_UNKN;
 	}
 }				/* get_fdc_version */
-- 
2.30.2

