Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CFCC04EBA
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DCE208E3
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWFK/9Hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DCE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbeKTN1Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:27:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbeKTN1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 08:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YKJxJ7wbTkHEXnfAq31iblnVipr6AM0nJWJcUA8vJXE=; b=jWFK/9HkAdVK8deQ7PoesDyBF
        6G263Pzn0hpliMEkJFwJy3MTK+Eak5oehOLCHL0UJm8IP6mpJLh8VnBsODN7gQdKS239MS9uvduCV
        bzhUOKXSnIPT6CNNk7M+yWOuWf66gTz8vhA1o6vDSFuxn8/ljxVIY29cw6d+TqkP79492snM2WNGc
        VNhxZxe4LV2zZEs6Q12AnYy0hQjbihPLZJ490/jBHmMLdoOdQ7bLlnAEj8RQh1zfuh4G8TW6/t9Os
        P/SSLzFGtj2ZBz5aXDBQAJejUbWRUE1MFK/wwardYMzTjjovYyQl1pyus1+qX2d/lHlrYFVwfkRLz
        WPE/UPHMw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOwH7-0000FW-SH; Tue, 20 Nov 2018 03:00:29 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH nvme-cli v2 15/14] nvme: Add TCP transport
Date:   Mon, 19 Nov 2018 19:00:17 -0800
Message-Id: <20181120030019.31738-17-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c    | 5 ++++-
 linux/nvme.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index be6a18cd4787..b4fac97253ba 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -96,6 +96,7 @@ static const char *arg_str(const char * const *strings,
 static const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_TCP]	= "tcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
 
@@ -703,11 +704,13 @@ retry:
 		/* we can safely ignore the rest of the entries */
 		break;
 	case NVMF_TRTYPE_RDMA:
+	case NVMF_TRTYPE_TCP:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
 			/* FALLTHRU */
-			len = sprintf(p, ",transport=rdma");
+			len = sprintf(p, ",transport=%s",
+				e->trtype == NVMF_TRTYPE_RDMA ? "rdma" : "tcp");
 			if (len < 0)
 				return -EINVAL;
 			p += len;
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

