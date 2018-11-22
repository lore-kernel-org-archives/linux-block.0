Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6805CC43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF6520645
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmA/Cbft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF6520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbeKVMd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404043AbeKVMd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3OFad/l3eHeQ1KGKIJaiF5PyGPpcPkFRKEQGBw2nd9E=; b=gmA/Cbftd3u4MZdZlwtErB6K0
        Q2CTQnpoaxUoKy3DIN36bZn6sm8Zts/SDbjhKZddpc2Bo7B33GvkV5rqdWSfts30VkEEvlyLDxeJH
        L/DixnfvOGVoTxESD+g8DvYeHpz2g/c707x/fPqRv+G55ykddcOErPKQDbi7pwLA951rKFFRt5tCt
        3gAAFVw8Z5CsuCzHGiAU5sziixwbTAozZgdxzFjzTm+8Y2C7OHUF+D4FqVwZ7pEUPSqogyyfHuwuA
        Z2+co/+7Wpze6fo0ux8bNxnhj0ljw1OoLAdAHTtgmd7tdLWdH/0K3P0vG1QgLB2J9RPCHX9nHrm1T
        iPzl0xjyw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE9-0006v0-Eo; Thu, 22 Nov 2018 01:56:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH nvme-cli v3 15/13] nvme: Add TCP transport
Date:   Wed, 21 Nov 2018 17:56:13 -0800
Message-Id: <20181122015615.15763-16-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c    | 2 ++
 linux/nvme.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index e7c2021b0c70..86f6f992b14f 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -95,6 +95,7 @@ static const char *arg_str(const char * const *strings,
 static const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_TCP]	= "tcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
 
@@ -696,6 +697,7 @@ retry:
 
 	switch (e->trtype) {
 	case NVMF_TRTYPE_RDMA:
+	case NVMF_TRTYPE_TCP:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
diff --git a/linux/nvme.h b/linux/nvme.h
index a6a44b066267..7a600c791877 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -52,6 +52,7 @@ enum {
 enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_TCP		= 3,	/* TCP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.17.1

