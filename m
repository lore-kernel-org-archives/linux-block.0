Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B492C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C88720821
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hvdQ8Kk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C88720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbeKVMd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404059AbeKVMd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4VCgSIAngRhs9S219+f1FTloJbv2iSmhHPj8lxFcQBc=; b=hvdQ8Kk9ZOzu42RJusBqqzaKn
        X2HvjdOYNnNj33vnj9i0nU/Lkdr3pjQ7inX2DRYS2WQwc/It6LjjjF5EAF/j7drfGQdA5NkbkUS3B
        BphpasvGj0qb8xa/Ab7ZHEw4SSHvdqrfvT8iIbFcOfW9x5ohnHqU0a83XxDyvuymGTOctNJccO97z
        PZLXdsD7a1NGC24WDzE2iqbkhcjuWmi1vQxd4hcwuXudEQsF51g5Pn4MHf0dYdpPQhw9DMoHmefBs
        U7khIZOhbtuzK+RV50oXgn/xerL0fg0n6wlJfBcSGI5erGIamkQCoR62dvNdfloY3k1I22go6xzEZ
        7GXVtC0Jw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE9-0006v0-71; Thu, 22 Nov 2018 01:56:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH nvme-cli v3 14/13] fabrics: use trtype_str when parsing a discovery log entry
Date:   Wed, 21 Nov 2018 17:56:12 -0800
Message-Id: <20181122015615.15763-15-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reduce some code duplication.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 99793f8beef8..e7c2021b0c70 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -609,6 +609,7 @@ static int build_options(char *argstr, int max_len)
 static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 {
 	char argstr[BUF_SIZE], *p;
+	const char *transport;
 	bool discover, disable_sqflow = true;
 	int len, ret;
 
@@ -681,24 +682,24 @@ retry:
 		p += len;
 	}
 
+	transport = trtype_str(e->trtype);
+	if (!strcmp(transport, "unrecognized")) {
+		fprintf(stderr, "skipping unsupported transport %d\n",
+				 e->trtype);
+		return -EINVAL;
+	}
+
+	len = sprintf(p, ",transport=%s", transport);
+	if (len < 0)
+		return -EINVAL;
+	p += len;
+
 	switch (e->trtype) {
-	case NVMF_TRTYPE_LOOP: /* loop */
-		len = sprintf(p, ",transport=loop");
-		if (len < 0)
-			return -EINVAL;
-		p += len;
-		/* we can safely ignore the rest of the entries */
-		break;
 	case NVMF_TRTYPE_RDMA:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
 			/* FALLTHRU */
-			len = sprintf(p, ",transport=rdma");
-			if (len < 0)
-				return -EINVAL;
-			p += len;
-
 			len = sprintf(p, ",traddr=%.*s",
 				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
 				      e->traddr);
@@ -718,14 +719,10 @@ retry:
 			return -EINVAL;
 		}
 		break;
+	default:
 	case NVMF_TRTYPE_FC:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_FC:
-			len = sprintf(p, ",transport=fc");
-			if (len < 0)
-				return -EINVAL;
-			p += len;
-
 			len = sprintf(p, ",traddr=%.*s",
 				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
 				      e->traddr);
@@ -738,10 +735,6 @@ retry:
 			return -EINVAL;
 		}
 		break;
-	default:
-		fprintf(stderr, "skipping unsupported transport %d\n",
-				 e->trtype);
-		return -EINVAL;
 	}
 
 	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && disable_sqflow) {
-- 
2.17.1

