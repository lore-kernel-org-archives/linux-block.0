Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640FAC6783C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBCD2084C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TOXz0S1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBCD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLKKuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:50:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLKKuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 05:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DZnGGEQEW+ELH9ziWAnOxRUmjXA/uLxYrXCAK1/zhFc=; b=TOXz0S1a1DFM+/Q/AFvaZ7yI5
        +830dvZqvw7jZBOFM9PAOf9gjvvbvz4iwddc82uPejrfPUT2MBwN5DF5MyS2Wz8FkDOSjYuRDXlyf
        nuZZlfamdhDBoNuYPHOjWYWBW3/Sp071l1+Fgz4FjFhUxyhedVmbsvc1Gp0FQ2f9C46uY2aNc045f
        kn5FrCbXyA2/b+d0OWo98DxT0eOtyJ9qEBoYcbtSYx3t/+19EJtj8zEflJ8yWEYeFPoi3X+r/cuRG
        UyMMRSejOvRWJ/4i9kvom52plWYNviL9ifY/LQf/vr6WpadUrhuYME/2WMc8s8hibs594pgEAIQ3G
        KT6Aa7m3Q==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWfbd-0004p6-RT; Tue, 11 Dec 2018 10:49:37 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] nvme-fabrics: add missing nvmf_ctrl_options documentation
Date:   Tue, 11 Dec 2018 02:49:32 -0800
Message-Id: <20181211104936.25333-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 524a02a67817..28dc916ef26b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -88,6 +88,9 @@ enum {
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
  *              the controller, (-1) means reconnect forever, zero means remove
  *              immediately;
+ * @disable_sqflow: disable controller sq flow control
+ * @hdr_digest: generate/verify header digest (TCP)
+ * @data_digest: generate/verify data digest (TCP)
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
-- 
2.17.1

