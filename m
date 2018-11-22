Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209D1C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D748420821
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LtrQWaJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D748420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbeKVMd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404074AbeKVMd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xyq05VEzUy2CFgYKuFJjAg2sJLBADmk7XaQQLmPzKeI=; b=LtrQWaJA3+d+vgbJsToJu3RUS
        K9AY3tk34w43nftqqW157GYyX65lklaMdIzcAZxkGKwmhQ9XCru4Xz2UN7H1sPHMK8f2ljpKnSSUz
        BUTRBqtnAaZNhMGgcqDjYrDp9n/2kImeQlY/3MhK14KYlMA6sKjwPbD9nYkdo0X/5r/uxSG5F2F7G
        knulQ1EQHqPPXAs6kIXOA4sF+/cJrF9o1PdBTujrRIYN8F3yL7l9aClJ2KITk4mJiPssTnSRYaQKN
        vTEtc5VkaoszY+evbFaEwZrbVZTVSgIqRJgLMm79P1oeWA8MFTmZXcJ5fB8L3FK2x5eicdGymlc6D
        mL0rnLvGA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE9-0006v0-UI; Thu, 22 Nov 2018 01:56:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH nvme-cli v3 17/13] fabrics: add transport header and data digest
Date:   Wed, 21 Nov 2018 17:56:15 -0800
Message-Id: <20181122015615.15763-18-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

This setting is enabling header and data digest over NVMe/TCP
controllers.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index f8e03de46632..394cba406a88 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -61,6 +61,8 @@ static struct config {
 	char *device;
 	int  duplicate_connect;
 	int  disable_sqflow;
+	int  hdr_digest;
+	int  data_digest;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -615,7 +617,9 @@ static int build_options(char *argstr, int max_len)
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
 				cfg.duplicate_connect) ||
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
-				cfg.disable_sqflow))
+				cfg.disable_sqflow) ||
+	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
+	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
 		return -EINVAL;
 
 	return 0;
@@ -709,6 +713,20 @@ retry:
 		return -EINVAL;
 	p += len;
 
+	if (cfg.hdr_digest) {
+		len = sprintf(p, ",hdr_digest");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
+	if (cfg.data_digest) {
+		len = sprintf(p, ",data_digest");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_RDMA:
 	case NVMF_TRTYPE_TCP:
@@ -929,6 +947,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
@@ -970,6 +990,8 @@ int connect(const char *desc, int argc, char **argv)
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
 		{"disable_sqflow", 'd', "", CFG_NONE, &cfg.disable_sqflow, no_argument, "disable controller sq flow control (default false)" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
-- 
2.17.1

