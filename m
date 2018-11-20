Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27FC43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34D120870
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+ST77JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34D120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbeKTN1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:27:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbeKTN1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 08:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fjHMyjBm/HhxvTtv46Isz8YJdSQL1eiv9o6pgCZJ+6M=; b=L+ST77JDitJh+muiVPpTOlOft
        YtQTRS0mizRb4X365I0tzExFyaV9gZcysGn86FxOYuzYBT4SvkkL7VuOljz714iXxQPetxo6FCTV+
        qeqzvVLopqG3m97ga5bNHXCskSicw9TydN6y7q2N3uM7SAYDZB8iJC7+Q+3xiAB0tRGDFxnS5Jlm6
        VlrCLrjf754VKEK0VacAUOAQJItpC8rGz07YZkNyS8mgHAw8u8uiCB4dAcgkt3LTo++Wvg86+err2
        RNX/2fLB6GqZ9w0//anbjo2vM+RP0pYNoMc0ohE6PdiPBp8u0mYj0mDBzF2A2oQCHlbXnx6hocySW
        pm19GuotQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOwH5-0000FW-UJ; Tue, 20 Nov 2018 03:00:27 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/14] nvmet: allow configfs tcp trtype configuration
Date:   Mon, 19 Nov 2018 19:00:11 -0800
Message-Id: <20181120030019.31738-11-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
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

