Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621B3C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242FD20826
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgIBW3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:29:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46764 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIBW3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id b124so515656pfg.13
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gx1q12zVJNIhyAVIp+ZmJmpBKVYh7KRaZMgKyvq5X5w=;
        b=HVkiUzg9Z5lCCDdwhpFeAzVs4XBy0t8Tph29EQGkVqtMqzAzmRgdqAZjsZWkWCL5UP
         VQjuSvkm5mQgwiDX/bZ2+2pw2GEQzOCTKOcwaZlK3zKqEPBlE0NeVD4Ehei44TdSwaig
         ZXyuQvEWnoUpCkMFvsosf7ZuDExs9aYaxq0UIYfV0uVRkANT1+jW7Tqb/a77tn6UzJPl
         ltjxw/9QJcbDVjn8CzStGTerNmX841yflZBYB4VPCOxeAKmqBdN2n1VIWlBKRgwhVxep
         GDkygYc97xmBOPH/ckpJ+X8BmhRYayzngU5rT9g4uxXl1J7MuhIRuV0+ZE3Iw0IFkVo2
         mS6g==
X-Gm-Message-State: AOAM532ZFmGmHsU6UsTHEEe1d2n2ncuSdi+Y+bZgDn0uKEGR2ai24+m+
        GN6F20MObGXURGEypFr46E4IRTsAF0Ze4A==
X-Google-Smtp-Source: ABdhPJwT3Ui4SNRE/Oj7hBRG6z2Uc68C4MK0oB66V43D1gvmLHsGTpy+42p1vBy2HePa1mJVZgCV3g==
X-Received: by 2002:a62:7ec2:0:b029:138:8cbc:ebd4 with SMTP id z185-20020a627ec20000b02901388cbcebd4mr586786pfc.2.1599085754389;
        Wed, 02 Sep 2020 15:29:14 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:13 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 7/7] nvme: support rdma transport type
Date:   Wed,  2 Sep 2020 15:29:01 -0700
Message-Id: <20200902222901.408217-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
References: <20200902222901.408217-1-sagi@grimberg.me>
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
index 972bd0019ec4..5f877321565e 100644
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
 		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
 	fi
 	modprobe -r nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
 }
 
 _setup_nvmet() {
@@ -124,6 +134,16 @@ _setup_nvmet() {
 		modprobe nvmet-${nvme_trtype}
 	fi
 	modprobe nvme-${nvme_trtype}
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

