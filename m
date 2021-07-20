Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE8C636C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4D061242
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhGTGJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbhGTGId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:08:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8FC061574;
        Mon, 19 Jul 2021 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/4u42N+bgLyjyYnCcK7X5ppsglLctvCl+CPJXfYei58=; b=T6p9WRpsT2sceU6/eswXmmiyrW
        CHRIkEriIUZ1vJcy2tCpb3xiJmLamDhh2gY74DbDCGGuenm+kN8onjQDsvaVtU9PbqL0LWnIMBe54
        eLDxHtinW6Q09BbFD4H8+xfG0K9cm/IAPLOI1yUfLMzM7p3q7BfH9bPEO3/9PDvLefn4knMSwDMbp
        Afn77CHYoEUkCBv9DyLG8Ml/V7Q5JOFgVpJQ+A4Z9BBWzU5a3SMA1AMzttltGgXIBK3t5qxi3DzV3
        M6c+3UbHLbtHZtWkg7riZkwYTPwpoFljxFBKhWh9MsI+burOFIlKPJWy/iRtdugeglmKeLCu5+U26
        2nj3Ht4A==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jY0-007q6H-Nl; Tue, 20 Jul 2021 06:48:15 +0000
Date:   Tue, 20 Jul 2021 08:48:07 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 02/17] block: Add bio_for_each_folio_all()
Message-ID: <YPZxp6ZbRGYYBnYK@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:46PM +0100, Matthew Wilcox (Oracle) wrote:
>  #define bio_for_each_bvec_all(bvl, bio, i)		\
>  	for (i = 0, bvl = bio_first_bvec_all(bio);	\
> -	     i < (bio)->bi_vcnt; i++, bvl++)		\
> +	     i < (bio)->bi_vcnt; i++, bvl++)

Pleae split out this unrelated fixup.

> +static inline
> +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)

Please fix the strange formatting.

> +{
> +	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
> +
> +	fi->folio = page_folio(bvec->bv_page);
> +	fi->offset = bvec->bv_offset +
> +			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);

Can we have a little helper for the offset in folio calculation, like:

static inline size_t offset_of_page_in_folio(struct page *page)
{
	return (bvec->bv_page - &page_folio(page)->page) * PAGE;
}

as that makes the callers a lot easier to read.
