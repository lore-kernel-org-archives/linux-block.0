Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E003C433DF
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0450120855
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgHNGS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:18:59 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38017 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNGS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:18:59 -0400
Received: by mail-wr1-f49.google.com with SMTP id a14so7332312wra.5
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzAZ2SXXLc7iNppHmhrxi1E4xPI3+ZrsxT2yh+SoN/c=;
        b=lQCcJopu5Yo45uOOnmJWrwkhtOpxZWdmqnQj32cz7dowfr4dS0/ZR0zzGxpUWlsc/5
         L7XMR+JqGIok1jnG29JAFsjIDjkuRbHJI+WFV4dw7y+crdaA7a3AYwnDjbRo1xQTxcON
         bffaxBsWgdgXLCF6lXKAkQrsZe8uficdr7HbETURH2Ui5vZnQaYwxOny5sf8o0ik4XH6
         EeVrSpHIWKNhwiQTZ7aEJhB/A6XPDNjGdwUEfQr3FjauOzCBgANogu3GnKJy4+vU3kOV
         88GLTcSNgXqX/T2zTwBlP4NzYKuT0M14l/Vq/9r3Cz9xv6VVl75EfLO+7xB9/LtLzbS+
         l3MA==
X-Gm-Message-State: AOAM533r/M7B7uTy1Ph8WakLGSBHPh/9AqA2RWa2b6xQ5iz+2JC0kJiI
        7jYhJdQeKuO1wQP2/cgSQtU=
X-Google-Smtp-Source: ABdhPJwvevobFTXZKCncDxkecs7/zrYPqWEQIV4UrRGbv7S4JgR4CgFY/JcVrtSe8e8OH7ZAIwKxNg==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr1367225wrn.0.1597385937091;
        Thu, 13 Aug 2020 23:18:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id l21sm12278131wmj.25.2020.08.13.23.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:18:56 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 7/7] nvme: support rdma transport type
Date:   Thu, 13 Aug 2020 23:18:15 -0700
Message-Id: <20200814061815.536540-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3e97801bbb30..675acbfa7012 100644
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
+		_have_modules rdma_rxe siw
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
@@ -115,6 +122,9 @@ _cleanup_nvmet() {
 		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
 	fi
 	modprobe -r nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
 }
 
 _setup_nvmet() {
@@ -124,6 +134,11 @@ _setup_nvmet() {
 		modprobe nvmet-${nvme_trtype}
 	fi
 	modprobe nvme-${nvme_trtype}
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		start_soft_rdma
+		rdma_intfs=$(rdma_network_interfaces)
+		def_traddr=$(get_ipv4_addr ${rdma_intfs[0]})
+	fi
 }
 
 _nvme_disconnect_ctrl() {
-- 
2.25.1

