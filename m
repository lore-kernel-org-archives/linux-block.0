Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B58AC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B73218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ql5zrRR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfCOOzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:55:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40162 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfCOOzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:55:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so6636746pgo.7
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PsoNd4sOAZ3OGvoiEniWe7TzVWmF8MVo9Y93Xa4kZvU=;
        b=Ql5zrRR2FgjjDkjfMLlEH1Z7V3LsZ+jB6ocFhoLlZWhv4w40FQUd0hBURJSCWPsS1C
         Xyb1qUdaiSt5LKrFtTcUN6vCOeJOP9tgKihDGV7sLpkEOxNMUhbGq0im5GCA1hiWL3nT
         OSVK6x2piqSboEBOG6HbRVaqWdYM7Hyq42PuaIIDcWUtFfWcdAHTySkkqTs/SueQVKGe
         eM0ld7JBceO/Dy3U/CVVbUdsc+s8kSbtTqNKiTNrqmdO1KujN5E8cPg6Ebj+z3kq1j3V
         /CAkcIyuDJgM/pCv84CgEnfHb4HbdhWOTpSYUaGoWjhydxf1iMIx7QLmVk4r3Pp8+eZp
         AEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PsoNd4sOAZ3OGvoiEniWe7TzVWmF8MVo9Y93Xa4kZvU=;
        b=BEptkS1CCXK7A1Ob/upQcHm5ly50C9f297UKffefx8kdyzLVjZ6fIBbkwXp/WYyWPy
         4g5d95MUNWQTsyoVRkvClmDn/gAxMg3CuqzG7hUgr9aLSgY9qakuvJvMYOaelU9swcah
         RVpWmryzO8L5otYu7Y/W/nhKaYsUVtGuT5IVHqrqRG4hxVRzn6IWZceUjX8ApjbBPISX
         O7lovCO76c8WGzxGTZaTRDRk8Bo3RNm5ioAYuIlo2N5sYolOiTeK1qo9Yts9ZqiE2VUj
         yQ9ZHcEvbc9mGTdedCyN2Ur5HitFvku14VGm2zXeOWDWqgd/VLWonHfA5fzdXeRdETft
         CF3g==
X-Gm-Message-State: APjAAAXFGJbyCiITamSNqBg8rSGTFcX74vyQYkQrYEVu3rnU/Vitymay
        arUiL3BdrUGTmmXMbQDj2BfdOw==
X-Google-Smtp-Source: APXvYqzIRSCyAzhwwzW8n5vrnZpJ8MgzO9AEiwQNaubTrxdyzC2D5/KKS1Xt6aoj/gaQCQM92jMdsg==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr4650665plb.63.1552661700028;
        Fri, 15 Mar 2019 07:55:00 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t10sm3192272pgo.27.2019.03.15.07.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:54:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] io_uring: mark me as the maintainer
Date:   Fri, 15 Mar 2019 08:54:42 -0600
Message-Id: <20190315145442.21127-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145442.21127-1-axboe@kernel.dk>
References: <20190315145442.21127-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

And io_uring as maintained in general.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17b59b66474b..a90137af48c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8091,6 +8091,16 @@ F:	include/linux/iommu.h
 F:	include/linux/of_iommu.h
 F:	include/linux/iova.h
 
+IO_URING
+M:	Jens Axboe <axboe@kernel.dk>
+L:	linux-block@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
+T:	git git://git.kernel.dk/linux-block
+T:	git git://git.kernel.dk/liburing
+S:	Maintained
+F:	fs/io_uring.c
+F:	include/uapi/linux/io_uring.h
+
 IP MASQUERADING
 M:	Juanjo Ciarlante <jjciarla@raiz.uncu.edu.ar>
 S:	Maintained
-- 
2.17.1

