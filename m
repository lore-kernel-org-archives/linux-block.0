Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382BC43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F12089F
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/9JioRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2F12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeKTN1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:27:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKTN1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 08:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TWDxaQR2eUd5mD3abmM5xNRqaj8Bg8U4vaZAI2iLQMA=; b=B/9JioRfmNI2kS038jK8V7FtL
        rquqqFdTZ1WWc3c3vNn2MeIfcyovV629659dUXhPaZAduZvBNib8x4WqFgBvi5PuVCWl6RwDU/W6E
        2KCAoboXe68gSJ1qUxvS0vWMFzVZZN6cG0ebUsMCa1wcxCHYUjZrLYqDWkcDtCp4qTr98NuoSItOQ
        S6XvqDcwLfaYF770epe9/GFTLyOYt7ejZEvdYGC8S7+PJ/2BMY+dLfny6Jnoa1Roxfu8RGEYmCr7X
        MBN/FF3apOb4LCKvOYBRCB9UqTK6tP2J4fc4yZoT/1FbaHWIeUFkF9P8Cm2huX+IzuaWB7HslzL9o
        /ZUkqLIoA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOwH6-0000FW-Fu; Tue, 20 Nov 2018 03:00:28 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/14] nvme-fabrics: allow user passing data digest
Date:   Mon, 19 Nov 2018 19:00:13 -0800
Message-Id: <20181120030019.31738-13-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Data digest is a nvme-tcp specific feature, but nothing prevents other
transports reusing the concept so do not associate with tcp transport
solely.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 drivers/nvme/host/fabrics.c | 5 +++++
 drivers/nvme/host/fabrics.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4272f8a95db3..9c62c6838b76 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -615,6 +615,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
+	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -635,6 +636,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
 	opts->hdr_digest = false;
+	opts->data_digest = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -832,6 +834,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_HDR_DIGEST:
 			opts->hdr_digest = true;
 			break;
+		case NVMF_OPT_DATA_DIGEST:
+			opts->data_digest = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6127f1a9e8e..524a02a67817 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -60,6 +60,7 @@ enum {
 	NVMF_OPT_DUP_CONNECT	= 1 << 13,
 	NVMF_OPT_DISABLE_SQFLOW = 1 << 14,
 	NVMF_OPT_HDR_DIGEST	= 1 << 15,
+	NVMF_OPT_DATA_DIGEST	= 1 << 16,
 };
 
 /**
@@ -105,6 +106,7 @@ struct nvmf_ctrl_options {
 	int			max_reconnects;
 	bool			disable_sqflow;
 	bool			hdr_digest;
+	bool			data_digest;
 };
 
 /*
-- 
2.17.1

