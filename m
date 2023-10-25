Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE89C07545
	for <linux-block@archiver.kernel.org>; Wed, 25 Oct 2023 14:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjJYOmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjJYOmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Oct 2023 10:42:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26364B0;
        Wed, 25 Oct 2023 07:42:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB5C433C7;
        Wed, 25 Oct 2023 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698244971;
        bh=mLkOdv4b8i2eFv8X9BAoS+Y8GxKrlJPAVyrio6dKXsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNCl4OydQlz7ER2rwKCubLGIZ3l6bw4RfTfDTHRwG8h8gTk5uAEHNCOW8nJkh8/tm
         v5IfrECbzJ87hTFtOria90MP+xZ4DZbIsQ5XcbF26nSne5s5gsICe9I6JXeuoS1rfW
         CsYzCE84HAr/8BSLezYABVL1m12erLdFWL1gzO5alf2Jd7bkzGlMewwilXEWFuNsgu
         ttJFQI5GaWOUmjfDPOCvkxO/hlR1MWe3F3gJPM/HStqJimqpQRj7dvjC3TF0qnADq2
         b37MkX7iKEpEA3T7MGAnMy0g9kprK4eUquTYUPpkHxbfcYwPlm3+/uYujolQMiMXOQ
         9U3YEHdaoWIqA==
Date:   Wed, 25 Oct 2023 08:42:48 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] block: bio-integrity: add support for user buffers
Message-ID: <ZTkpaHa8fM4xhLz4@kbusch-mbp.dhcp.thefacebook.com>
References: <20231018151843.3542335-1-kbusch@meta.com>
 <CGME20231018152817epcas5p454a337b03087ccaf8935a022884b7cd2@epcas5p4.samsung.com>
 <20231018151843.3542335-2-kbusch@meta.com>
 <1ca15dc4-6192-c557-2871-d2afbf19dd97@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca15dc4-6192-c557-2871-d2afbf19dd97@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 25, 2023 at 06:21:55PM +0530, Kanchan Joshi wrote:
> On 10/18/2023 8:48 PM, Keith Busch wrote:
> >   }
> >   EXPORT_SYMBOL(bio_integrity_add_page);
> >   
> > +int bio_integrity_map_user(struct bio *bio, void __user *ubuf, unsigned int len,
> > +			   u32 seed, u32 maxvecs)
> > +{
> > +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> > +	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
> > +	struct page *stack_pages[UIO_FASTIOV];
> > +	size_t offset = offset_in_page(ubuf);
> > +	unsigned long ptr = (uintptr_t)ubuf;
> > +	struct page **pages = stack_pages;
> > +	struct bio_integrity_payload *bip;
> > +	int npages, ret, i;
> > +
> > +	if (bio_integrity(bio) || ptr & align || maxvecs > UIO_FASTIOV)
> > +		return -EINVAL;
> > +
> > +	bip = bio_integrity_alloc(bio, GFP_KERNEL, maxvecs);
> > +	if (IS_ERR(bip))
> > +		return PTR_ERR(bip);
> > +
> > +	ret = pin_user_pages_fast(ptr, UIO_FASTIOV, FOLL_WRITE, pages);
> 
> Why not pass maxvecs here? If you pass UIO_FASTIOV, it will map those 
> many pages here. And will result into a leak (missed unpin) eventually 
> (see below).

The 'maxvecs' is for the number of bvecs, and UIO_FASTIOV is for the
number of pages. A single bvec can contain multiple pages, so the idea
was to attempt merging if multiple pages were required.

This patch though didn't calculate the pages right. Next version I'm
working on uses iov_iter instead. V2 also retains a kernel copy
fallback.
