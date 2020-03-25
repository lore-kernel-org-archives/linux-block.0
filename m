Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2580C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C478320775
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJMjuKIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCYLGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:06:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCYLGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EkHoDcsZdb3+NNm3P9VHHz4Mkfwg7iMQl/Gfq2O/6E8=; b=RJMjuKIC6trIUEu4k4lHbz+/Sz
        k9XRJZ0N+obCxSWid13xOFLXsvdxjW75eV2dE2SnwVr67Ha5kxuWHeUQAkP/JBvRy/vFK4L9B2w9u
        nukmi3Kyx/dcr5uLyH24nirR9mCCds8VyM2wxzlaPyuyV6c225Icm55ubqFk18gBMsCo3cvSKqRyp
        aOvcqoJSQ9k99SKulqNB8hG7/Xe4uc193FHk5PKcNuVA73zYxkUIOU8w22yiN5zaG/ZDZzj83EKKP
        sKod/6fyQme78Qzyviovb+eq1oDkcfE8Pru30KHHCvhlpFMjw7heXq6KVk3Q8YNi5VI4W9woPbsA3
        VuF7hlDg==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rG-0001vA-Pm; Wed, 25 Mar 2020 11:06:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] block: unexport disk_map_sector_rcu
Date:   Wed, 25 Mar 2020 12:03:34 +0100
Message-Id: <20200325110338.1029232-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_map_sector_rcu is not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 48ed042d7f26..144cb50e8eb3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,7 +345,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	}
 	return &disk->part0;
 }
-EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
 
 /*
  * Can be deleted altogether. Later.
-- 
2.25.1

