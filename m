Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE204C433E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9422177B
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgHFTPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:15:33 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34173 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 15:15:32 -0400
Received: by mail-pf1-f171.google.com with SMTP id u185so25639782pfu.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 12:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtS7GN/DmlJ0+Y1Zkb7lIX2+dO3mjZPVKKexH9jrXr0=;
        b=lhbKOn4NL5lSZ4c6BEg9hZRW0+WUb4O+xmKmgYpCO3IPNf+LWNo3ZI291+TN206Ua2
         7ChcJ2tCHD01im84aN+2f7u5s7Ql+CSI5r3VSTkiUPi+IxJdAaJ/s2YHtoTWZ3i5+UyE
         JcgZ7h7DupPgt3sVDl2Y2Dgb94skPUGr0VXWZ1G/vXiD23lU2Uii9XUYk8tV+7op8EC1
         zIXLpBoNstCrwpOoHvI2eDza/YdTCFKgCEOte7JfKGhrSB+37AWvbHx8aoFUoDOmlkHE
         bSdB5JxPsadGkKSY6gkj+vohl3ko7OkHpFs0kiNSFczr2od2iLies4Tq4SY8Jsg4jlRF
         Xhug==
X-Gm-Message-State: AOAM531SJY1jR17D3uyY/Q907TtwhdYvBTFZ6e7G7p2gaR9UDr9H+t+D
        5T/d92Q/Qv9qhoXusRpGpuk=
X-Google-Smtp-Source: ABdhPJwUfzHJygCkt/ZSQ/NWtPPZ6XqymFrerPVgKv9FB03oB+ePVKrT3K5BtKY/Z6wfaoIjcAZ++g==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr10096870pfm.34.1596741331662;
        Thu, 06 Aug 2020 12:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:15:31 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 7/7] nvme: support rdma transport type
Date:   Thu,  6 Aug 2020 12:15:18 -0700
Message-Id: <20200806191518.593880-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
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

