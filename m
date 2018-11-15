Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C28C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D27D223CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sionwHPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D27D223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbeKPDZZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388798AbeKPDZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lFZg5KvDAM8kr3mT+0ZZXZJqGIO/GTjEnICrrt2Cnxc=; b=sionwHPfZLAcduFG1UalsFGGs
        cqz2e3DnqNW5sYgl8pn2EusRi5gnzWOR2yqJmhdrR8PWTaZHLn5T+MGxXSZcPXsgwlANA5JVaYSZ7
        WRNNzo0HbW6+1slLlWVg3qxfCvE4AUX7owXs0gjgV2eoyR44kgtQOTZfkRsBOl4x8OivloOdEUPL3
        chYUvXr1PV3Lhi9gVBFn1Cjck7HBk+Zm/tePPkOZM7B6ZMXvyaZi23H1KIn67q9PYsHuF1Lle6auW
        vDGEPeltP9KgQcid8WmleyAVFFPu0Hnm34rGBfMzbItv+OnxISs1E5zJlFCj1yrxUvfhmN5OPy6bN
        yvDcQvjRA==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFu-0002LK-OO; Thu, 15 Nov 2018 17:16:38 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH nvme-cli 14/11] fabrics: add transport header and data digest
Date:   Thu, 15 Nov 2018 09:16:26 -0800
Message-Id: <20181115171626.9306-15-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This setting is enabling header and data digest over NVMe/TCP
controllers.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 fabrics.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 774ea94dc0db..2890e4ef36c8 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -62,6 +62,8 @@ static struct config {
 	int  duplicate_connect;
 	int  disable_sqflow;
 	bool persistent;
+	int  hdr_digest;
+	int  data_digest;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -629,7 +631,9 @@ static int build_options(char *argstr, int max_len)
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
 				cfg.duplicate_connect) ||
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
-				cfg.disable_sqflow))
+				cfg.disable_sqflow) ||
+	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
+	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
 		return -EINVAL;
 
 	return 0;
@@ -706,6 +710,20 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		p += len;
 	}
 
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
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
@@ -947,6 +965,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"persistent",  'p', "LIST", CFG_NONE, &cfg.persistent,  no_argument, "persistent discovery connection" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
@@ -990,6 +1010,8 @@ int connect(const char *desc, int argc, char **argv)
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
 		{"disable_sqflow", 'd', "", CFG_NONE, &cfg.disable_sqflow, no_argument, "disable controller sq flow control (default false)" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
-- 
2.17.1

