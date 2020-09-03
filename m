Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B505C433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471B820797
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgICXyI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:54:08 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53402 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 19:54:07 -0400
Received: by mail-wm1-f54.google.com with SMTP id u18so4454523wmc.3
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 16:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltrSPPPBq2iV3S6trqwPo1lDRT0G76ooyJTQrnxziqc=;
        b=e65dQfYxVDYKxJE9D5CriK1+ONvQ7mDPn4lDbSw8kqIqr220Zki+wlQnAKZor8kapT
         /Xefq/4hwp52wRcX1uavC6cUpmF3KpTEl9z1RHpo/rAg88G7MFBTu4gsCG/cCkTBRA6s
         iMiy/laqtXkIqt5IELpAnVFraxkS43V2uyrNHge0V5oVh7kS1NG3WbqPA2tfok7pN4fs
         zScCi5veoB+Avzp7LSrCyYwguxuJdRpOcBAcNb5GHorsMmNeP18akw2kowjv7Q6BqxEv
         uztq/ic0iQL0a0A5gqC9Ix11M+R6RiJVpxmHjVAIf7orO+IvFoRHy4u/naIX/pZwTHiH
         Nmnw==
X-Gm-Message-State: AOAM530P49ZgtYbzfRcyo1aZB1QR5OsXnOuBLHzt1utX3kG+vXRgXIAF
        Y3O18xmZh5B/yOFpF5+Tk7EIa9ny8vFOqA==
X-Google-Smtp-Source: ABdhPJw7v5uApg6WNJrp3X9k/6FVzz/5nWXQhmx8P+LLD2jwXHGIQXfpMI2sU8EKSHH3jyWD2nu7pw==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr4881341wmb.11.1599177245452;
        Thu, 03 Sep 2020 16:54:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:54:05 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 7/7] nvme: support rdma transport type
Date:   Thu,  3 Sep 2020 16:53:37 -0700
Message-Id: <20200903235337.527880-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8df00e7d15d0..4c5b2e8edf0d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -5,6 +5,7 @@
 # Test specific to NVMe devices
 
 . common/rc
+. common/multipath-over-rdma
 
 def_traddr="127.0.0.1"
 def_adrfam="ipv4"
@@ -25,6 +26,12 @@ _nvme_requires() {
 		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
 		_have_configfs
 		;;
+	rdma)
+		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
+		_have_configfs
+		_have_program rdma
+		_have_modules rdma_rxe || _have_modules siw
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
@@ -115,6 +122,9 @@ _cleanup_nvmet() {
 		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
 	fi
 	modprobe -r nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
 }
 
 _setup_nvmet() {
@@ -124,6 +134,16 @@ _setup_nvmet() {
 		modprobe nvmet-"${nvme_trtype}"
 	fi
 	modprobe nvme-"${nvme_trtype}"
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		start_soft_rdma
+		for i in $(rdma_network_interfaces)
+		do
+			ipv4_addr=$(get_ipv4_addr "$i")
+			if [ -n "${ipv4_addr}" ]; then
+				def_traddr=${ipv4_addr}
+			fi
+		done
+	fi
 }
 
 _nvme_disconnect_ctrl() {
-- 
2.25.1

