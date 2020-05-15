Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A40C433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980C2206F1
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uP0kdW5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgEOEHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 00:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgEOEHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 00:07:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C267C061A0C;
        Thu, 14 May 2020 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5PwB/9JSdMfY5nBxzWW07ajXI/9xxScbdH3I41S0bUQ=; b=uP0kdW5N0sgVFf0t9LYyPg7+md
        SebAjT9iphzheJMd77jFgS5a6+kfWSVXR0scfu2ahFIsIDrf8ysSznN/jH6WpEvk21W2p2kNEzkY1
        D1fvCfaB8yehGnBKN9c46Y96JKkxI8F0KQGtGnit3fYaaeXAuN2PvTr+WUd5Tk/He+gqAr4ypsrV5
        Oh8GFCWYk6Hfl831KzJU3VBKjavRxxbCEWsfW2pMkN8wAoiI1plB/WYtyVtDinwDJT8T6U78d9cz9
        aLAyOSxU9vlMhqWOAwnfSz1Hzw36/gUEbutRc11m99ZvOeuQOiKLJ+yc4JAqR0hA/X1Xs2MDVML+/
        If4Hvqjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZRcV-0008AQ-A6; Fri, 15 May 2020 04:06:47 +0000
Date:   Thu, 14 May 2020 21:06:47 -0700
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
Message-ID: <20200515040647.GC16070@bombadil.infradead.org>
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
> @@ -266,7 +266,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  
>  static sector_t swap_page_sector(struct page *page)
>  {
> -	return (sector_t)__page_file_index(page) << (PAGE_SHIFT - 9);
> +	return npage_to_sectors((sector_t)__page_file_index(page));

If you make npage_to_sectors() a proper function instead of a macro,
you can do the casting inside the function instead of in the callers
(which is prone to bugs).

Also, this is a great example of why page_to_sector() was a better name
than npage_to_sectors().  This function doesn't return a count of sectors,
it returns a sector number within the swap device.

