Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DDC0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B65F21743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfHHUFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:05:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42968 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbfHHUFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 16:05:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so44026941plb.9
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 13:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLkRSmrn41W++1njDG0plghfflSWM76SF0ZekFVoOoA=;
        b=W0lTbLI9Abn7VdmuXgk+9pdVsxLjcKJKgbhjaDGSjS18N3A7m191efUCrZsmo51MKr
         4gqa3pCNuN2LQGpt5YfbAs8SD/HsNRqUxaKvXga3/RzVIOMQZDdNd6+ymTZqO034XWfp
         uQFWK4JvEjUfusedJnlAMlDvaElbi5PEkizV+iI+Kik3JGPnNMvNosm8xv1NW2A5lhQK
         1jrhe2AhIoMOUfWaVk+fxo0m1Y4QAEKq2TQxNngYFcZBQVw3S3pCHwIxlLxVrEXXNdke
         pWq8b1RWxuh4v56zhftH9wsH7nr6863efV/p8ocWVMHAtKMRQmL8WqcovGLJAbCmTmik
         9d4Q==
X-Gm-Message-State: APjAAAWJrEaAj4VelrdxGdF9hTQg307I4FYI1EsmsFreEDvEIbzTq+PJ
        8aQMj1+GYoG8PMOPFmrCB68=
X-Google-Smtp-Source: APXvYqyT0ujooYRUe+4LgLRsVNwnzlmU63fgIXwRMfSXaZAEsU0z9kYLgkgB85WG6kOfxb3gMKxNTQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr15950672plb.30.1565294715831;
        Thu, 08 Aug 2019 13:05:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b6sm83307093pgq.26.2019.08.08.13.05.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:05:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 1/4] tests/nvme/rc: Modify the approach for disabling and re-enabling Ctrl-C
Date:   Thu,  8 Aug 2019 13:05:03 -0700
Message-Id: <20190808200506.186137-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190808200506.186137-1-bvanassche@acm.org>
References: <20190808200506.186137-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid that the following error messages are reported when redirecting stdin:

stty: 'standard input': Inappropriate ioctl for device
stty: 'standard input': Inappropriate ioctl for device

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: a987b10bc179 ("nvme: Ensure all ports and subsystems are removed on cleanup")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index d4e18e635dea..40f0413d32d2 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -36,7 +36,7 @@ _cleanup_nvmet() {
 	fi
 
 	# Don't let successive Ctrl-Cs interrupt the cleanup processes
-	stty -isig
+	trap '' SIGINT
 
 	shopt -s nullglob
 
@@ -66,7 +66,7 @@ _cleanup_nvmet() {
 	done
 
 	shopt -u nullglob
-	stty isig
+	trap SIGINT
 
 	modprobe -r nvme-loop 2>/dev/null
 	modprobe -r nvmet 2>/dev/null
-- 
2.22.0.770.g0f2c4a37fd-goog

