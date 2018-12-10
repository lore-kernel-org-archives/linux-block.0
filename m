Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3AFC65BB3
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2D920821
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2D920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeLJPrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:47:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:28821 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbeLJPrR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 10:47:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 07:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; 
   d="scan'208";a="126652699"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2018 07:47:15 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block/bio: Do not zero user pages
Date:   Mon, 10 Dec 2018 08:44:42 -0700
Message-Id: <20181210154442.7772-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't need to zero fill the bio if not using kernel allocated pages.

Fixes: f3587d76da05 ("block: Clear kernel memory before copying to user") # v4.20-rc2
Reported-by: Todd Aiken <taiken@mvtech.ca>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index c4ef8aa46452..55a5386fd431 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1262,7 +1262,8 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (ret)
 			goto cleanup;
 	} else {
-		zero_fill_bio(bio);
+		if (bmd->is_our_pages)
+			zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 
-- 
2.13.6

