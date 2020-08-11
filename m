Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E084C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606F8206DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKVBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:01:20 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:34366 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgHKVBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 17:01:20 -0400
Received: by mail-pj1-f48.google.com with SMTP id c10so1988847pjn.1
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzAZ2SXXLc7iNppHmhrxi1E4xPI3+ZrsxT2yh+SoN/c=;
        b=VJVkjHdoufmvxwKaVf5ikHp+I9QPqjKsFiQ+GnJtvGISgkXCt1nGpGZY2YOgVTovqm
         +rTd3x5RKP8y7nPJqTO3G7GSwAKv5y3DkvpA/VuYsLH7fu/q9k1eFFOuqMwbPRFVytRH
         TizeGGN0xMKoViNOYYQFRn1q1gu7ahE8FXvaMUzLKr3ThGfO/pARgYj7Rxh5kpfw63Z8
         aIa8zMZc1sCchMxYEeh/jEDrevoR9cScLQYrTSArFmtuP3xOY3Q5WAobirzVWs54SyqY
         M6NEPvs4dzpXJ2DpOWHMyHTMWcRR2tlyYyCxeKfnAopdumHgkhCByhoA/mn6LevEM3hJ
         TAlQ==
X-Gm-Message-State: AOAM530q/OIX6iIn/xIDKuJ7owzXxNvM+4GCykwIvCNXGgEGYV+nl24m
        aIZgvliVuulJCpaKVoHUm8Q=
X-Google-Smtp-Source: ABdhPJxY9sueg5kzkDkt4NCP10V5sw8acM0u87BVwAs9ESkt4Ym5QoHUmynh+dofgCRrexyUD1okyA==
X-Received: by 2002:a17:90a:b986:: with SMTP id q6mr3009212pjr.54.1597179679649;
        Tue, 11 Aug 2020 14:01:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
        by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:01:18 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 7/7] nvme: support rdma transport type
Date:   Tue, 11 Aug 2020 14:01:02 -0700
Message-Id: <20200811210102.194287-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
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

