Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3FBC48BCD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8FB61406
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFJBfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 21:35:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50608 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBfL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 21:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623288795; x=1654824795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/f8Bm19V5/mcqXAclWPl6QyH7YmCPjeKb2p9RI6rVs=;
  b=hYAvQFCPpB6UaxMYLQ8T7qUWxpGo8n4wzQjuafH/COxh0u6haZ6wj4FH
   GqDazCEsUCkwxA8nclVh93zb1coseeCAp8HVgXUROk1/A0AjXR2m24Iak
   qWhui0wVGE9LaUhclywbFaiQmze5b2kKc2KRNaAwCjU9gu22zBA/pd12F
   nMgohma4qhmP1tFT/Z568W8HDGlcIodkHUVJJtbCly+xpjjvLldmc3QRC
   5VQxius4Jrh6ipuYdpM0lW8g0KULoQx1QdyXQf7SDL3hJYBTKSguZZBkr
   NVXmw1Qa+OFauTo5408uMVMFv4dljQqiEZssUfw3D8CrJE/Cy0JjrTM+v
   Q==;
IronPort-SDR: C3U153oQqJCx7QKcgc8H2Vf9bU70GjajlqMzfFNiyG4Xb7B3awb1E91vBAaYWAbh3scp5EtdEh
 L2/BBiXvmlQX+Hp/4J77AX+OTyESoGav8f1TrlSPFt3QEGAgzR2rmnZGLChROFQcDo7rt/OphN
 RY+tyAJZ6alW/tR8m+qEYqcQ9oCXi/9pA5ihimwDR6BJhMelKUwL6MeogO7/+VXbNU77JGVcNF
 sns4R+JpdKovbpp9KRkOq7w9gilX1myKtSwCZjdOKj61StyVKDclKl9KXXgm083kKFit9jbF6A
 nIs=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="282813640"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:15 +0800
IronPort-SDR: B5enSN1sodIB9c+zHTggaZ++WPRl+HN0WFxbXOSWdB1td0EGUA9DuJ5aqGrRrGQoLSi+kr6obF
 wo3yUARPBObVGS7jfCrfssCbkgxj5mLB6pMI1LXYzSBQQb+mmg0Bo1wcCAGdGc341UfL7mg3zX
 PxEHK84LVMwFsbeMidQe7dCYVIWrtitfJgVjCX1NjYfwl6khhn1y7mhuKmi7p2Fa+D2pC9Gy/U
 /jCAvVA6n5T70BXiNMQJ2ZE84X8TPFfb5lepI65qg/wIG+Iv0egXmE8Q7LDi8yyXBQdds3uq0e
 +6pQGIDWArVNqnff5G7iJ/il
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:12:18 -0700
IronPort-SDR: pMUdnKrfGL394N0ia1FZoMrH7RFL/TsF+svXAgDi0RybBSxoR63R0pmZZGRj4jfSGPbDyAQ03u
 NTGPqEUL+h+4VxV2kvEuqmrqdrJsWED79HhG1DAiT1sGFCmBxjfVbz7/V7Ny2LKwI9SR26H6JC
 F/V6kz372PyZ4v4BrzH181y9DgIkW+nhT/e1ardxDUTuRQy5cyl0dY5Iga5vfy9fnIJnHsMomS
 6of4Wokot8MyTeYkjzEmFV72aRw87TOjqIFqJ+ltD81/cKoycs+Ep6x6JE/f+0w3Xl0p2e/39u
 bnc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:16 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 2/5] nvmet: add req cns error complete helper
Date:   Wed,  9 Jun 2021 18:32:49 -0700
Message-Id: <20210610013252.53874-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We report error and complete the request when identify cns value is not
handled in nvmet_execute_identify(). This error reporting is also needed
for Zone Block Device backend for NVMeOF target.

Add a helper nvmet_req_cns_error_compplete() to report an error and
complete the request when idenitfy command cns not handled value.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +----
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..3de6a6c99b01 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -637,10 +637,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_desclist(req);
 	}
 
-	pr_debug("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_cns_error_complete(req);
 }
 
 /*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bd0a0b91d843..f53ce96df498 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -624,4 +624,12 @@ static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
 	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
 }
 
+static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
+{
+	pr_debug("unhandled identify cns %d on qid %d\n",
+	       req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1

