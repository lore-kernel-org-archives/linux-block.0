Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ECCC65BB0
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDF720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="npOfMIGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDF720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeLDBw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:52:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLDBw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bz6sLONTcyPgDmr4XJ8yBuUx/MYIx+rF6T9SSJ6KLhs=; b=npOfMIGTfqufHNMjknQOfju1Q
        vniZflsDT9rqn5OScoOzpQSD8hdkxpCDz6emP+FXnfgKC4y2fcrxDivImuAUAei2Vl5XJFFmSr4rF
        IOpu0uBCdaItD10lnSlYS6eXdwHNfgC5n4N5fFgcYDHMYuUQbG4GMsnkef2y2TtTbMeIH8THDln8W
        kOPBMMiwk6I6Camd6PCwIfu7wlBMDYpJT4wYvQm1kV+VwF7nBqqhjTMzcg3vhpQRLFOPWPs0GH4IA
        I8ojadxKPaMsSWyF6LvB9wwp5n3HkFlrNPAoXQhN7GArPWvj0IgNnG52dpuRf7Y63D826hbK8nipd
        R/Y68Xerw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTzss-0003Zq-Ty; Tue, 04 Dec 2018 01:52:22 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v5 12/13] nvmet: allow configfs tcp trtype configuration
Date:   Mon,  3 Dec 2018 17:52:16 -0800
Message-Id: <20181204015217.16613-13-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204015217.16613-1-sagi@grimberg.me>
References: <20181204015217.16613-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 drivers/nvme/target/configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index db2cb64be7ba..618bbd006544 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -34,6 +34,7 @@ static const struct nvmet_transport_name {
 } nvmet_transport_names[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
+	{ NVMF_TRTYPE_TCP,	"tcp" },
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
 
-- 
2.17.1

