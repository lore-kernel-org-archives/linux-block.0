Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB1C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 05:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A7D207D5
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 05:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL1Qey9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFDFoy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDFoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 01:44:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02450C05BD43
        for <linux-block@vger.kernel.org>; Wed,  3 Jun 2020 22:44:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so653282pjs.3
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2020 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuw0brNF5+UZ3iQiuiN1PZ4Ni31+Jvagz30/knY5EJI=;
        b=tL1Qey9QJLuYxzJsU5zJaRwXR42OzL8mf6Xo36We9lJZtN6rWyJnGBrB3BGAS32BHc
         FKMnJtE8S3JxOjYq4rVrxLD0zpdkzl7ttsQilPKRdsoUD1BPvcsOA1neI1+gyL8yl0IA
         QSpSVMdmUVTG0XMP3ZokFiUicwOrDBF9mauBm/Vv692hWbxtHiXH2yagjXpanbysX00N
         nXqBddQaZyBroY+1Nx6th/DV4xTq1EwoDh0tVC8PKF6AHqq6UAd2UB1HrXG8nAPbNm6B
         llgLXvrHHjuVDOKsDviIGB3PljDPlJu1xrtH5Y2ZkovX4D7isSIu17wQ2/IR50sCHgzd
         /KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuw0brNF5+UZ3iQiuiN1PZ4Ni31+Jvagz30/knY5EJI=;
        b=LtlDfNvki3MPGNWsf87QZ999qShdKOfrT2nxyLnAgvg/QjcTkKDMOub2SQ9RCDwJIi
         NJJiZPqjB+kzkDZri0JdIK8Z5EOGXhdq5P+6VcimNdLvAlL9gFxQwEpeRRMxmaOGwbyZ
         iwuTpZtLgSf+i1Ms5cGNVSE/BX1+CteuRK43NoLiWtcejbr2HdrcymuMjuYfwDvMFhMf
         YSfuJ4bAjyVoMM7FHhubb+DC3Yu2YkHSiNRiX+XYXnncZ92ITXHeQSBt9WWUBJIDFgEL
         kjPXfmvBCHBNqlbqJTgapKTBDdilI2a/IqSv/aL5H4bt5cvuQ8glDT/MEsrosaKtN+1N
         f+uA==
X-Gm-Message-State: AOAM531E1UlNNU61ZwmK+BS+y2z4tsgf5k1wV8S2t5C+jJMHHot5ZxtO
        N+n8NeFQU4Y5rDXQdrfnbRbr0vCx
X-Google-Smtp-Source: ABdhPJw25qHVrry5/8W7s05zxrS9wRlMf8aqYRBLHsro+eL1sv2/qOrTTAqYnRJ13OQtP6hDVRhjNw==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr3307396plb.217.1591249493055;
        Wed, 03 Jun 2020 22:44:53 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id m22sm4229743pjv.30.2020.06.03.22.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 22:44:52 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Date:   Wed,  3 Jun 2020 22:44:34 -0700
Message-Id: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that user requested memory via BLKTRACESETUP is within
bounds. This can be easily exploited by setting really large values
for buf_size and buf_nr in BLKTRACESETUP ioctl.

blktrace program has following hardcoded values for bufsize and bufnr:
BUF_SIZE=(512 * 1024)
BUF_NR=(4)

We add buffer to this and define the upper bound to be as follows:
BUF_SIZE=(1024 * 1024)
BUF_NR=(16)

This is very easy to exploit. Setting buf_size / buf_nr in userspace
program to big values make kernel go oom.  Verified that the fix makes
BLKTRACESETUP return -E2BIG if the buf_size * buf_nr crosses the upper
bound.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 include/uapi/linux/blktrace_api.h | 3 +++
 kernel/trace/blktrace.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 690621b610e5..4d9dc44a83f9 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -129,6 +129,9 @@ enum {
 };
 
 #define BLKTRACE_BDEV_SIZE	32
+#define BLKTRACE_MAX_BUFSIZ	(1024 * 1024)
+#define BLKTRACE_MAX_BUFNR	16
+#define BLKTRACE_MAX_ALLOC	((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))
 
 /*
  * User setup structure passed with BLKTRACESETUP
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f2084087..b3b0a8164c05 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -482,6 +482,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
+	if (buts->buf_size * buts->buf_nr > BLKTRACE_MAX_ALLOC)
+		return -E2BIG;
+
 	if (!blk_debugfs_root)
 		return -ENOENT;
 
-- 
2.27.0.rc2.251.g90737beb825-goog

