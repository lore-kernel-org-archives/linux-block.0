Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A5C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC142072A
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKORHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:07:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46959 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKORHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 12:07:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id l4so5054223plt.13
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 09:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZuM0OMnnuVK635Locm2PXONrFxTzuYB2o0guTYaPaU=;
        b=fwV4fxa5exluNqZ/+IxCLBA6kvTPOH9cpYZ7sENx32GgolOZ7i+2bUOun2TgHWGeDw
         Q0rFAr6qbI202OmoUIUOPZCEMeaaVMrNBKFgZzPTAg8zc52i8Et9DP/4xTwtwnnmSeiP
         1bMC88qW+U+3H8qZRZZwk8cECQBTlJZOJxAW45B/f0ZwZSVUco9BY2cKVsdKklckC6oG
         u88NrsykB2e/1a9mLxQRqjrecW1Lg+q/f3zXfl/Lbn0uT9Dr/kt9THJHPht5g10kgrWB
         amemVrycUKmN/60Os22Uo9NOOd6umEU/5L4MndtV9Qgq/yGEpLTnsF5RMruI0T9Ump7u
         y1ww==
X-Gm-Message-State: APjAAAVoDv7IzrekRXPPRIg90a9/G5a82e+ISXAUunUmxAMTspc18+Ao
        /iww5YPDZxpYvWvKolXChu4ATPt4
X-Google-Smtp-Source: APXvYqw/qC1jbnkzdA4Qr/DOwC47G7nZBAbl1YDb90u8B3mMRSIF2oOaEV/RjFOTKp03Y+ETBFJSuw==
X-Received: by 2002:a17:902:be14:: with SMTP id r20mr15543734pls.297.1573837642930;
        Fri, 15 Nov 2019 09:07:22 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m7sm2364793pfb.153.2019.11.15.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 09:07:21 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 2/4] common/multipath-over-rdma: Rename two functions
Date:   Fri, 15 Nov 2019 09:07:09 -0800
Message-Id: <20191115170711.232741-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115170711.232741-1-bvanassche@acm.org>
References: <20191115170711.232741-1-bvanassche@acm.org>
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
 
