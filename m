Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BB8C433E1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4973120776
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590680089;
	bh=p0It6KcgwqXdzFK5z/GOqB/MgJZBocn6srgvvK8X0TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvoZuztjumjFyEQIdZZNW6219vq0K57uMrhP9Q9dAa9mHNUV+vMzYgijYaWJFLA6i
	 8WYa4ebclCFqmbJmW+tdNJEc0Zuj7s1OtxoUPr2Z/a0j7nrYEkCdFi2CFo2RnQ5yoO
	 G26RRhpZBhtpQNn3I4yUMortYO8jQtNuxUA7uVcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404400AbgE1Pes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 11:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404455AbgE1Pes (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 11:34:48 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332C120897;
        Thu, 28 May 2020 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590680087;
        bh=p0It6KcgwqXdzFK5z/GOqB/MgJZBocn6srgvvK8X0TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wo9FOKsL/wGIvGdSCTARkRNwRvJ5QiYJmucNDzMuCJmmDsDw+82kgnk+VEENcWvFC
         oEX/NVF3c81EIpWcIRq/uKwejy7CXzCpEPE9ytXqx6FYr/whvjy7wZwnVr2++Y3xzh
         Fj+FkGhngSDOY+krqKxSCeQh8TnqWUe5h6FYhHys=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv3 2/2] nvme: cancel requests for real
Date:   Thu, 28 May 2020 08:34:41 -0700
Message-Id: <20200528153441.3501777-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200528153441.3501777-1-kbusch@kernel.org>
References: <20200528153441.3501777-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once the driver decides to cancel requests, the concept of those
requests timing out ceases to exist. Use __blk_mq_complete_request() to
bypass fake timeout error injection so that request reclaim may
proceed.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba860efd250d..f65a0b6cd988 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	blk_mq_complete_request(req);
+	__blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.24.1

