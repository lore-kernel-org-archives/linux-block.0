Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5CCCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiFWHsw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiFWHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882AF2CE23
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 62B081FD45;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2Sf7t6tr6gpY3pUYOUhrmZUuO5cAJPXkgwkxm4e2cc=;
        b=nodMkB9cY8JUQ+V7ikiIC6X/XhXT1emA2uptBTOWFdUmA172OyZlyRzlAoDiyPO3XDUfz6
        xDg4ktHVYuYJ3CleuvxgO8k3SlZP7cBL11SLV7PSBKdka8zDUCze/Ta7Not0E+iJ1xWmHC
        k2DogR2p9qxC1Zle7gW1mU8tRXd0P2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2Sf7t6tr6gpY3pUYOUhrmZUuO5cAJPXkgwkxm4e2cc=;
        b=7ZaMRAUlcHDhdFRYt/H3IxW20+dCRWFiYOHBvgLryOAaqBfT5Ji9RsnET5C67nryRraTyY
        YpQYe2+r1g08GxAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BB4F32C171;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1632A063F; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] block: Initialize bio priority earlier
Date:   Thu, 23 Jun 2022 09:48:33 +0200
Message-Id: <20220623074840.5960-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; h=from:subject; bh=tx/JE6SidyE6A6hUsnIpuHZJkxSzADvNTRDi+mddbwk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrQ8LHuUj4Ws0qvjsTLv9XDhybQ958TCOnJKMmm ah32u1iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQa0AAKCRCcnaoHP2RA2RpGB/ 4rvTp7yOtuxUJLXFwk8+drTwKMWv/dtHf14E7zeFNiwwS+5jRDAVUiyu/vpbIfq4nqF8jQ/v9KAPqT VvwTHzGDAE15GcPsR23JX+y5sTshFW6XDeOHd4hG6gWac4leTuvTQpSZzGk9w+rDQfXvto6OeCG/SB Kucm0MrmxI9pzUOIADC++NA1QRo83SugCGBNszidLeMAAffpVrAlmtbIubSyJ6nCYrQGEzzTUwU7GC nfd/QrmlyM1dcKkbfpNaR/ssuiRNZW7nsGibkzsYrgV6TbOq+7OUmmK624ytcchCsPEILhi+2R5C7F HYv/Sx76xuHeOFuLuw4J99Oy761XeQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bio's IO priority needs to be initialized before we try to merge the bio
with other bios. Otherwise we could merge bios which would otherwise
receive different IO priorities leading to possible QoS issues.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 67a7bfa58b7c..e17d822e6051 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2825,6 +2825,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
+	bio_set_ioprio(bio);
+
 	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
 		if (!bio)
@@ -2836,8 +2838,6 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	trace_block_getrq(bio);
 
-	bio_set_ioprio(bio);
-
 	rq_qos_track(q, rq, bio);
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
-- 
2.35.3

