Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC94EC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8840A61920
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCWLtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:49:39 -0400
Received: from mx4.veeam.com ([104.41.138.86]:34984 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCWLtI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:49:08 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 5A68C114A89;
        Tue, 23 Mar 2021 14:49:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1616500145; bh=Npv76KkPJw9jO4Ft8/M9YyDbnr+j3tl96yB10yNzbfM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QtXYXdUD6Z4oZ0WlqJ18CJYfFgKn2ciVKdlg4PXNK0sl8g2oxVzIkogP3jzgi8oaj
         +7k2r6mL77S+/UWWJhKDgs6MQYN3NlmC3flQAx8uVoQV05clLlnwaYhYflTH5Ra2D9
         rn9N31tk2nUwH7BzezovCCPCfT/+A4TYBBySKhFA=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 23 Mar 2021 12:49:03 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH 1/1] block: fix potential infinite loop in the negative branch in __submit_bio_noacct_mq()
Date:   Tue, 23 Mar 2021 14:48:36 +0300
Message-ID: <1616500116-3411-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616500116-3411-1-git-send-email-sergei.shtepa@veeam.com>
References: <1616500116-3411-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B586D7D62
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the blk_crypto_bio_prep() function returns false, the processing
of the bio request must end. Repeated access to blk_crypto_bio_prep()
for this same bio may lead to access to already released data, since in
this case the bio_endio() function was already called for bio.

The changes allow to leave the processing of the failed bio and
go to the next one from the bio_list.

The error can only occur when using inline encryption on
request-based blk-mq devices and something went wrong in the
__blk_crypto_bio_prep().

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/blk-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..825df223b01d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1005,13 +1005,12 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 		if (unlikely(bio_queue_enter(bio) != 0))
 			continue;
 
-		if (!blk_crypto_bio_prep(&bio)) {
+		if (blk_crypto_bio_prep(&bio))
+			ret = blk_mq_submit_bio(bio);
+		else {
 			blk_queue_exit(disk->queue);
 			ret = BLK_QC_T_NONE;
-			continue;
 		}
-
-		ret = blk_mq_submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
 	current->bio_list = NULL;
-- 
2.20.1

