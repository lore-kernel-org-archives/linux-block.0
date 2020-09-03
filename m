Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61704C07548
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2E6206D4
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgICV1F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:27:05 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36571 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICV1E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:27:04 -0400
Received: by mail-wr1-f49.google.com with SMTP id z1so4736153wrt.3
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGRHXecKyEwJ0IWVPv7h1H7Pqf9T7gYv3gOTweg7S7M=;
        b=kwRrtOqpBLYPLQGAgEfQeBfy3SeFWF8sa3Q1L4VU4S1jM+WxRknMieM3qBdTvwdgVR
         xmA9M2wgi8dn5138cjlRJ8tLDqnuBO3TF/zVWF/uyPPh32o1x6Qb29ccngBmFPTumUV3
         7jt4akVD+ylN6a2tQ4uWeQjMAekAodB0HsCxKJy8LvP4QsDSuODy2M7x/CtMZTd/iJoO
         niHtM5fj2squWiDTXB03J3gLvrrTxbaUQiVSLSk1+dqLjVH9mmDJSNA+z7F4Rn5Nzdl/
         kjVUFbxrDMvtKIFx4Dq0sVZ2LmLXCV33milUf/W8qZEJ95f/yKWFVQlPoFwdZ+EbrKI9
         82yg==
X-Gm-Message-State: AOAM531szImw46POB+9wm9fOWj1uOjCewBB75jOO0P/Au9IdBAis5FnX
        v1l4Wrho8eO0aRW1X4hvMpUtBqEcG4aBWw==
X-Google-Smtp-Source: ABdhPJxinPpGoWsLe2zb2myMj8nVc+8JdhOke0PrCJPRy4WkxwnKGhX/oAF1zjom+G5P/vC6vfwQxQ==
X-Received: by 2002:adf:db48:: with SMTP id f8mr3269083wrj.144.1599168422212;
        Thu, 03 Sep 2020 14:27:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:27:01 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 7/7] nvme: support rdma transport type
Date:   Thu,  3 Sep 2020 14:26:34 -0700
Message-Id: <20200903212634.503227-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
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
index 2b267f1d6ae6..009621eee634 100644
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

