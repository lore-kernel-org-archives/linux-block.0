Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C0C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D70921848
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UtqpNt4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfBZOEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:04:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBZOEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 09:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FTKp8mQxcps8RZ7UOhvwpjyGKEofEGAsn6bznwSBBmM=; b=UtqpNt4AvDE3O8Z6UPaYE5K5u
        kqvFQeo/6Krb28+aAtR0hCftwfnappsTJkN6EFrZZ2F89QcWqvNX9wWYTQF/RnYa9WJkUE1z5md7o
        cEZHoMOBZB/hUD21jDomuvEMXmLuCmRwmxsaWxO38TuxTreN6tGa/ry7ta6YbScEo7ZXroKpOiOKu
        53xQTaN3Q2mNsK6P0qzNXurrfU/PhENlHCVDy5ASAkDdG+27egMwCSbEqqEFqx4BnlWhxFHyxaUTp
        5E08MepKwzTkI5VbacrPTlnn27nWxB6IXBnQ4sJBgec7m/bhLezhoRxE/nxvEwpQLH5hbAG35/6SQ
        CGyfvPthg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gydLc-0003S3-Hw; Tue, 26 Feb 2019 14:04:40 +0000
Date:   Tue, 26 Feb 2019 06:04:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190226140440.GF11592@bombadil.infradead.org>
References: <20190226030214.GI23020@dastard>
 <20190226032737.GA11592@bombadil.infradead.org>
 <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p>
 <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
 <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
 <20190226121209.GC11592@bombadil.infradead.org>
 <20190226123545.GA6163@ming.t460p>
 <20190226130230.GD11592@bombadil.infradead.org>
 <20190226134247.GA30942@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226134247.GA30942@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 09:42:48PM +0800, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 05:02:30AM -0800, Matthew Wilcox wrote:
> > Wait, we're imposing a ridiculous amount of complexity on XFS for no
> > reason at all?  We should just change this to 512-byte alignment.  Tying
> > it to the blocksize of the device never made any sense.
> 
> OK, that is fine since we can fallback to buffered IO for loop in case of
> unaligned dio.
> 
> Then something like the following patch should work for all fs, could
> anyone comment on this approach?

That's not even close to what I meant.

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ec2fb6fe6d37..dee1fc47a7fc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1185,18 +1185,20 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	struct dio_submit sdio = { 0, };
 	struct buffer_head map_bh = { 0, };
 	struct blk_plug plug;
-	unsigned long align = offset | iov_iter_alignment(iter);
 
 	/*
 	 * Avoid references to bdev if not absolutely needed to give
 	 * the early prefetch in the caller enough time.
 	 */
 
-	if (align & blocksize_mask) {
+	if (iov_iter_alignment(iter) & 511)
+		goto out;
+
+	if (offset & blocksize_mask) {
 		if (bdev)
 			blkbits = blksize_bits(bdev_logical_block_size(bdev));
 		blocksize_mask = (1 << blkbits) - 1;
-		if (align & blocksize_mask)
+		if (offset & blocksize_mask)
 			goto out;
 	}
 
