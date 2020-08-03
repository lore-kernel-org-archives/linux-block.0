Return-Path: <SRS0=nSht=BN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC969C433E1
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 06:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE32F20775
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 06:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgHCGtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:49:01 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:43585 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHCGtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Aug 2020 02:49:00 -0400
Received: by mail-wr1-f45.google.com with SMTP id a15so33066981wrh.10
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2020 23:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtS7GN/DmlJ0+Y1Zkb7lIX2+dO3mjZPVKKexH9jrXr0=;
        b=es96kfrhlmHg0MWwyE7+BOA74N7mRmT8eqN6fIPj+ruQOks2KgwiwIFWLE3vQmcpmZ
         rqb0mhtC3cTuKYcLKXaQGsjRbuuI86VSr1X95cxUA/mWESqyEDuLUAXh84Ll1De+iELA
         BVSx6BjIgmSH/v/j1XeNKFSdGThc1zdf0JfWILfKo42ZRuxAtyBnYLeqhjOKDjISkNfN
         dgnU1nNUkQ6hcOFbcsvAjuFweKnLH1bdlK27Z/EBLrESU5mDCHnoU6ELXL11iwBeULob
         o7J+35HNoZwFxVMDJzxNjZk2Gv6RXgCTdgQu/W1mUN+Iovp3zPMVTTBvTPgSzU4Ji7JH
         JpJQ==
X-Gm-Message-State: AOAM532dkyv+HBbHuqAhPEijTvFCOLSaNCZI/Ufz5g4k4JtdIeo6bFdJ
        ilJLdHz05MzGwBqq4kmXGWg=
X-Google-Smtp-Source: ABdhPJypqA/h8Mho0nbJ2LD2zxCA6+EjXKvj08IlOjpKbpVi8B6BCN1ES5tR9xGTeJywKsCOPJzLlQ==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr13598497wrs.384.1596437338648;
        Sun, 02 Aug 2020 23:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
        by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 23:48:58 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 6/6] nvme: support rdma transport type
Date:   Sun,  2 Aug 2020 23:48:35 -0700
Message-Id: <20200803064835.67927-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803064835.67927-1-sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
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
index 69ab7d2f3964..31d02fefa70e 100644
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

