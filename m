Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC49CA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F381E214B2
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ld/JXI5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfJ2LE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:04:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2LE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 07:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ZbSp1CPL1cN9bi6Y9K+vpaW0lBwJnmkUNhvWg9tzjs=; b=Ld/JXI5ZJayM4AljENdLIke5G
        OOfKWI2qFEGEdflRVLCCx4tigevR6zkw3gco5hLBdqx2sIENBwvy/Rmtx1JF/3/mtz1XH7ba4fQEv
        +BpJMN6MW/X3vjjfEwX1xsmHv1YV7+pM7Ts2/NDKK4tmGZYJHmRoKK8SoMT6U9pvZnP/2zhkaDHU9
        noC1Ph/Yjm0je2aVrwgobtEyV5N5Ftrz6bN5tVT9hzJh+CYyvtEFAQObGJw8UNSdYI00PGNN36kJi
        LswI1+rIyTMOg6OqPppO8DGTlepaAeuftobg8zua6a0eP+doVsegGD04NOuG2Ng2GqByOW7l3Ah3A
        1AxTQAT+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPPIX-0004jT-PL; Tue, 29 Oct 2019 11:04:25 +0000
Date:   Tue, 29 Oct 2019 04:04:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-bcache@vger.kernel.org
Subject: Re: [PATCH V3] block: optimize for small block size IO
Message-ID: <20191029110425.GA4382@infradead.org>
References: <20191029105125.12928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029105125.12928-1-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I still haven't seen an explanation why this simple thing doesn't work
just as well:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 48e6725b32ee..f3073700166f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -309,6 +309,11 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 				nr_segs);
 		break;
 	default:
+		if ((*bio)->bi_vcnt == 1 &&
+		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
+			*nr_segs = 1;
+			return;
+		}
 		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	}
