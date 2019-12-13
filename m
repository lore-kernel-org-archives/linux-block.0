Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB4BC34961
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14624712
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfLMOdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:33:05 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34295 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLMOdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 09:33:04 -0500
Received: by mail-il1-f194.google.com with SMTP id w13so2248502ilo.1
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2019 06:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZuM0OMnnuVK635Locm2PXONrFxTzuYB2o0guTYaPaU=;
        b=U48AVDMJdIkrxBiVJ3d0UkRp3ySuJmqZDoCq8JLcE51bMSov3EToyzbA6BVKU8R92C
         CQDwDITod/BjE/xVNa9ihLfYv6vmuhylsCnXp/NrciBtQslbtPv4QKodebgk2puDILK8
         C6vY0L/hF0X721+MsRpK3sWk057cvWNJBSPM84b0mLOG+wPjJNcw7FZ6mWOmUby6J4xC
         QGyDQeknC7xS9YeFjvwnnk3zIfBmZ3CLpZBed+zISjjZo0bzzvkp8EHnx1mwZIKryNAb
         hP6cLzWUBiDApCXurVAG1EeSp/m39GYgD42lHkDwH2E/7D4JpFZj5AblHEaWpi02B6gr
         rJ0A==
X-Gm-Message-State: APjAAAWxPvYx418GFA9O0P9wX361KvamEnX74T0G4QABFMSd1BPVR8lN
        fkxXjgxtSwxEM2JBLeucjM8=
X-Google-Smtp-Source: APXvYqyhJkIDxMyAIelzJgxjYiZmQfMp2IOgatJQlSMgHe8VAMchyizAuYYhOKJLJ8gFgBwGvha2xQ==
X-Received: by 2002:a92:8fd2:: with SMTP id r79mr13919838ilk.165.1576247584191;
        Fri, 13 Dec 2019 06:33:04 -0800 (PST)
Received: from bvanassche-glaptop.ka.ltv ([75.104.68.105])
        by smtp.gmail.com with ESMTPSA id i79sm2785026ild.6.2019.12.13.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:33:03 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/4] common/multipath-over-rdma: Rename two functions
Date:   Fri, 13 Dec 2019 09:32:30 -0500
Message-Id: <20191213143232.29899-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213143232.29899-1-bvanassche@acm.org>
References: <20191213143232.29899-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the meaning of this functions will change, make sure that the
function name will match the new meaning.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 15f296ef2ab7..9f645f759d2d 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -409,7 +409,7 @@ has_rdma_rxe() {
 }
 
 # Load the rdma_rxe kernel module and associate it with all network interfaces.
-start_rdma_rxe() {
+start_soft_rdma() {
 	{
 		modprobe rdma_rxe || return $?
 		(
@@ -425,7 +425,7 @@ start_rdma_rxe() {
 
 # Dissociate the rdma_rxe kernel module from all network interfaces and unload
 # the rdma_rxe kernel module.
-stop_rdma_rxe() {
+stop_soft_rdma() {
 	(
 		cd /sys/class/net &&
 			for i in *; do
@@ -608,7 +608,7 @@ unload_null_blk() {
 }
 
 setup_rdma() {
-	start_rdma_rxe
+	start_soft_rdma
 	(
 		echo "RDMA interfaces:"
 		cd /sys/class/infiniband &&
@@ -627,7 +627,7 @@ teardown_uncond() {
 	killall -9 multipathd >&/dev/null
 	rm -f /etc/multipath.conf
 	stop_target
-	stop_rdma_rxe
+	stop_soft_rdma
 	unload_null_blk
 }
 
