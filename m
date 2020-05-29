Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D68C433E1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EB3207F5
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763069;
	bh=H5Holb5ECxic2kwSWoJ+5oUahBN+4rFGAhnvcBXaHvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BD0xKKx/vzffWm0x0tVPbAu93GdWMKm1Omi1xJySeHDaxgWTZfcucF3VRWbENE59h
	 DtMfxf44XhPonQLFVJhtWwkSTnIcGKN54RErpo0vzhZAzRBI1Z7HV+n2xcPUpZgD0t
	 Y/1vWsTaLs70OXAHonHkt9ZW3zNhjPbZyXOP5xa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2Ohs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 10:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgE2Ohs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:37:48 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6CA20814;
        Fri, 29 May 2020 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763068;
        bh=H5Holb5ECxic2kwSWoJ+5oUahBN+4rFGAhnvcBXaHvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzAHDExdSDIn4DtjuZbGQNoSF7cuYcJOGHDABqhYY54ZK+D8yS64S/rlhGcrjs84v
         UxAe3kCc54StPfnEuWtDELee0Yjrpv1ZIxtiD/aV+KbopzgkXot11ISztdDZr91M1z
         BszKZJL4rMLre+5ws4Sx8DIHYaZCglCFLnta4GsQ=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alan.adamson@oracle.com, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCHv3 2/2] nvme: force complete cancelled requests
Date:   Fri, 29 May 2020 07:37:44 -0700
Message-Id: <20200529143744.3545429-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200529143744.3545429-1-kbusch@kernel.org>
References: <20200529143744.3545429-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blk_mq_foce_complete_rq() to bypass fake timeout error injection so
that request reclaim may proceed.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba860efd250d..891e9461bfae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	blk_mq_complete_request(req);
+	blk_mq_force_complete_rq(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.24.1

