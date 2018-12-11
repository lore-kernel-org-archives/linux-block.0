Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0244C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C7920851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FA5N60oC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C7920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLKXf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kspA0YSoLOcngjQAnQgM+xxzcscHJNp2K0o69qKJtb4=; b=FA5N60oC0ZM+S39D1w1D/I7xb
        5wRm6ZqxKsr0Gf3pWxE5FsDRqXJlJPegRa6bD26xZ3kk5c+QhxC3KqpS5smpw6QVb3866aehIzUKu
        HC46355swJaQ8EGrhrzIIFB0FWjcn5CxN8l1OsURZDNovJndVct65CxXOzSb3moxqG6Jw8277ajN2
        5KwciwUxw4TEsFznoBFa/NjxS2fGfx/t2GYJo5pZ3US5RYWuiQpnAyCFi6WkZYsUplEKvJg5+XLpW
        XKc1bmKtNyiIJtXzsmbijKy6YrNOfPNOTjsuX6JdEXmkW/sLWXF7nqtLzlFPvN+UlMjQHG/xjV0t8
        q8GGr6/ow==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYh-0002L4-AW; Tue, 11 Dec 2018 23:35:23 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 2/5] nvme-fabrics: add missing nvmf_ctrl_options documentation
Date:   Tue, 11 Dec 2018 15:35:15 -0800
Message-Id: <20181211233519.9350-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

