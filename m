Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC9C433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB39220728
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDLkBDdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgEOEPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgEOEPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 00:15:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6DC061A0C;
        Thu, 14 May 2020 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X0Z48Rv8s1lVOVaxdtrrAK36OYWeizTWUjplkBWBKZE=; b=FDLkBDdigNBe08XC3J1ZaLvRUC
        IcnS9Plfrb89bsrZyk/AAjhzKOt6ASneJ//8gSzPavNh5BTLwLLjj5Rx11odiT0ex7yWk0hZAbQk7
        oeU5firlyoHinAD/2ePtB8AjB4IBD8VKyBwJxf05aEUEk1KBSq3DIIMVxwTrAEyblYyWJQH13emcl
        3CivSH36Wf1ljrSM0Egslmn5yexwt1Tly2fntdSkHayCBexJG+grsXIe17jmo4ZdijgI+nVHc8eAe
        4xR6U0JcZ+N26WuPUfW3YNfLZjm5nCm4M6Cq7gA7tHGWT3WShbq6a8bIIA/H8Qd04+DrFwWcioQkc
        5Xwnq05Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZRkO-0003X9-II; Fri, 15 May 2020 04:14:56 +0000
Date:   Thu, 14 May 2020 21:14:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] mm/swap: use npage_to_sectors() and
 PAGE_SECTORS to clean up code
Message-ID: <20200515041456.GD16070@bombadil.infradead.org>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
 <20200507075100.1779-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507075100.1779-7-thunder.leizhen@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 03:50:56PM +0800, Zhen Lei wrote:
> +++ b/mm/page_io.c
> @@ -38,7 +38,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>  
>  		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
>  		bio_set_dev(bio, bdev);
> -		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
> +		bio->bi_iter.bi_sector *= PAGE_SECTORS;
>  		bio->bi_end_io = end_io;

This just doesn't look right.  Why is map_swap_page() returning a sector_t
which isn't actually a sector_t?

