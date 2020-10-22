Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA6CC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA612244C
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lwml0aQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442638AbgJVBCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:02:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3921 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603328567; x=1634864567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Qu06twpDWdtgyaEYknFhF6JbcU21xCqovBDAlsLidY=;
  b=lwml0aQWpo6ajS2Tb9fu3l6zqst4LGf4h2tPhOETBwe+2cXtpJDUGKJe
   xPCH+cvi1Iy3ptilXyR3uQ2CHijVNtnmmhCQ+ar3Bz4r3qF8cXw77F3Vx
   egMF61f0McNBTieuvQP1v7BMgHMDWWLqIjBLjLbw7UkOytUSBBPKHdn6O
   9SgCiAY7EvWxrWTDnXUmVGLu9gFmFg+r9Zvvv0UzvqQ2lclHIEGP0Ed+v
   Hi7XJ2I36+XDnOmOKHExfgVR65CCGdjm7y3CNMgx/g2diu06Vtyd9YNuC
   HIETtp7VfxcgPaFZdB2hA+7GgmJ9n+0M38aLyY4M7V9XBDKYp0yKW3sMt
   Q==;
IronPort-SDR: GgKHO7krZjdpklh7E1bqDneDuRE6YpLSXEF+CvRX1Qm25iqWp0jWa3ppLZQ3vrAXE0SXxly9MM
 EOKjfByE3TfxKgfzv+lMLRfUhK9kDbVX1vxaVHoKlJxTnnk8dJWn0GspMWdlPErVjkk3ya8hQx
 oUfrI3cl4j2ipdZmo2duxv/Pa7MbroPvIczmCb0Ip9XWMy4KWl670ObtYJ8hIIC6pku8HkE2HR
 /IaCN6RccqlLJtdsJdLbhf2X21z2UIzVrMwdCQOUC00F8cMEJ4tfrwRd3UV7KFCN3wwSOjbMPw
 QI8=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="155006294"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:02:47 +0800
IronPort-SDR: hhEpJIhmaMvdkZt5D5vmwSyaH9X28VDbtiQ+9yrj+ho24+uxIrTTF5FiJceZepKlhPhgFLkehD
 xNWRfmtNDn7RchedCyufoNaFj5jfXUwcPelb83PHXrM6pYVd3P5pVHWC62xh9wGxLQObifNdlx
 YPkSG7xa9lZAYnqC/rGADP1PJab9rmfAptYSERFQZo1IruZOWEQ4He6dub2Y0q46cKcghQ9/Xb
 yW9fFZg5oRh/d5D1crdy2V0bUqFsrTXkhCvwvqkWqgBNpwjNWIluuSIHfxKC+Jvn2GWpdiSYUm
 VoSchYUcsOP3VN0BE/Sn+eOe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:49:10 -0700
IronPort-SDR: Lmfm8H8beSCgrYyPjwizv4+CTO+vvNtMMd56nRYSxBxHr8A9WM7b7PKHELXms/4+7QjVpZUBfr
 epGCZKz1Dw4pTuCmo74lQTlwd+wGsl3+IvkM7yN1qxErbxOaUS8Rj+wOzvGHfsyXxnpEf2TO4R
 7mxzyp7FFS6tivVFOOGNR3HBxWF+vx/tpV6tqt1WItH35gyEAH/4xby2cw0liI04e6STpOmER8
 WTTdR1OIIZOvD0M5XjdBogzWh3aEXWGIDtRX/XJbJI97VNeMf7SFuKt3UY5Ot66+W8dN8I4Bpm
 +gM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:02:46 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 1/6] nvme-core: add a helper to init req from nvme cmd
Date:   Wed, 21 Oct 2020 18:02:29 -0700
Message-Id: <20201022010234.8304-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch which adds a helper that we use in the next
patch that splits the nvme_alloc_request() into
nvme_alloc_request_qid_any() and nvme_alloc_request_qid(). The new
functions shares the code to initialize the allocated request from NVMe
cmd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 56e2a22e8a02..5bc52594fe63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -514,6 +514,14 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	}
 }
 
+static inline void nvme_init_req_from_cmd(struct request *req,
+		struct nvme_command *cmd)
+{
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	nvme_clear_nvme_request(req);
+	nvme_req(req)->cmd = cmd;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
@@ -529,9 +537,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	nvme_clear_nvme_request(req);
-	nvme_req(req)->cmd = cmd;
+	nvme_init_req_from_cmd(req, cmd);
 
 	return req;
 }
-- 
2.22.1

