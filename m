Return-Path: <SRS0=xSfi=W4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E5C3A5A4
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8698D21874
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRDps5ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfIAX2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Sep 2019 19:28:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36630 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfIAX2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Sep 2019 19:28:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id s18so58686qkj.3;
        Sun, 01 Sep 2019 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnYjM6GZssuueZ87B4ymwNdvp16pDjOs/JnCxKRULvw=;
        b=rRDps5ngK3X+8LqdigPtBvIsgSFL1bvMoOVVQ3XSHSGpftMMRmgTx1t9c8FjjMJMYK
         gwFMCKSoPjt/bKnmj7ycw0K1/4KAqT5l2kcNJ6kD3QhTOd3wE+nILQyUSvfjUVnt9Fjy
         YF8V4hhiK1eGZX+MSlxxbXb9Bd0pvYdd34VG0Fpud+AWay/gWRc8Kw6V5s3HkPQqfmdk
         Df4+cs+6CKS25WcczykJ/YJz/pN7EO0zH9vxIdoo0FjwEi46CbsjqHgmJsrBYwxqdQiL
         vNjq0q+1TRaWJIYoSah1976MkY+lRSzD4944i1Xar47ydUzA3qzY4G+tPyfxwiMQQtUP
         IWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnYjM6GZssuueZ87B4ymwNdvp16pDjOs/JnCxKRULvw=;
        b=Sv/uwH47Q/vL0zvVjVgKNrcgc5ze/3M1EQGiTHWsjwbPJqYwBfEt/LJAmugUMkZo2d
         dDz9jugyDsQu8fwmdAmDImHzfeAPQGQSfi3AIG2XXCzsMaGNqzvFlpxarO2eUzoaMhxH
         yiujZJBzg6y4nwFmtCM4/U9wqzaxv3iEpOo7OSVvvEuh/mHyvPubh1jQga3KCbwi1ast
         JiCOImiWwxB/a8gk/CMRZmWDRJ+IwGo3ql9ULg3mbNJICRLXbeLdEb7FjL8ui6DZtB1P
         jPK0HB/LXJKGc1q6btF3tV6cScrFBbCfWJ5hzwhA7USijlTzxdr+hnk7QD0DDFxg03eD
         2v8w==
X-Gm-Message-State: APjAAAVUS8yuIwiwt4NfhhKYtl7JNKbMvoqITx2CKOCXSt1wnQM3VLx1
        EAFGt3fIc1/pdxjVdsPaEvVI+ygc
X-Google-Smtp-Source: APXvYqxo4DtEatatw0isBlUbrGE/nto4jLYhE8KKg86xVupKgHjKxDF4/GAzJXAaXf3G98nXQlIntg==
X-Received: by 2002:ae9:e842:: with SMTP id a63mr12386084qkg.447.1567380484339;
        Sun, 01 Sep 2019 16:28:04 -0700 (PDT)
Received: from localhost.localdomain (200.146.53.87.dynamic.dialup.gvt.net.br. [200.146.53.87])
        by smtp.gmail.com with ESMTPSA id p59sm5684085qtd.75.2019.09.01.16.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 16:28:03 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 2/4] kernel-parameters.txt: Remove elevator argument
Date:   Sun,  1 Sep 2019 20:29:14 -0300
Message-Id: <20190901232916.4692-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901232916.4692-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was not being used since the legacy IO path was removed,
when blk-mq was enabled by default. So removed it from the kernel
parameters documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4c1971960afa..6f2bc0e02421 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1197,12 +1197,6 @@
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
 
-	elevator=	[IOSCHED]
-			Format: { "mq-deadline" | "kyber" | "bfq" }
-			See Documentation/block/deadline-iosched.rst,
-			Documentation/block/kyber-iosched.rst and
-			Documentation/block/bfq-iosched.rst for details.
-
 	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
 			image elf header and optionally the size. Generally
-- 
2.22.0

