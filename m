Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD7C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D6E61477
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 13:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFONQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFONQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 09:16:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D4C061574;
        Tue, 15 Jun 2021 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zmrviQMw+JlPdB4kdVftou4OSnT6/3UW41m9IYLR5zc=; b=HHWcpVUgybsgwyZf3vYZ4pDRo3
        y8sJAE2WnqN3VIQKEfdevA8GjOs4XihI/lVEAyDHzgbn1QVWDDMwA49w4rljFpkjJv0/N9YeSY1Re
        e4FGWNm2GjWUZU1Cie+Ns61iNuw6pOgb3K97CBQKwE16w0EgED/0VQQq+I1171FhkSzpGsyKC+xoh
        7DSuiu6NrP+Dvq6oXC5ziXL/BU3nFthgNEfircN1iqU+554+oOWjF/zEKXF9LLOjxH+Y4dBroqHCO
        fWDQ2mit2W3Si25+ZCnRzSPHvsJXs87wrPaMo+gUH0SVHD+5/L0Rx7Z3pKc2Pae53wNP8gKTbMTtb
        rYpzNlUw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8tC-006nOY-DJ; Tue, 15 Jun 2021 13:14:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/16] block: define 'struct bvec_iter' as packed
Date:   Tue, 15 Jun 2021 15:10:30 +0200
Message-Id: <20210615131034.752623-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

'struct bvec_iter' is embedded into 'struct bio', define it as packed
so that we can get one extra 4bytes for other uses without expanding
bio.

'struct bvec_iter' is often allocated on stack, so making it packed
doesn't affect performance. Also I have run io_uring on both
nvme/null_blk, and not observe performance effect in this way.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..a0c4f41dfc83 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,7 +43,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-};
+} __packed;
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
-- 
2.30.2

