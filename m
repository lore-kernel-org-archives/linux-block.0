Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C1C433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA47020787
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 04:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+hdZiy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgEOET2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 00:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgEOET1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 00:19:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89797C061A0C;
        Thu, 14 May 2020 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sEV2Dcb/vxjuVh6b2+vt3K/ZxF+r4H+loOY/Rcz7Jfs=; b=B+hdZiy3fTXn2Mq/d0DoC+/mOU
        O7aStKnfUbQOLviXcQAC1xrirMK/uwB39WFmDo6picuEgYmTQnVmUuZ0qd+ATNk8Ub9VtzaevKA8S
        AlqLvhorITqZJxUgDvRru+uRCk2j/rq3sFKAt3lJYCiM6Mtzleodx+LGlLL9FYrEh7yTFzAk/USVu
        oKizsjcZPJmBV6EEqOODHagdmMRMMc+pX7Q9xMcRpg9puDRmNx6DJAQ57vRz41Q6bXAawywEeqx0U
        ORQwc7NJ+AHpY5tIt0VCfmpRxpMRzYYA6L9uxji4uekEAN5RXxZwP2+7psdx2ejVJ1Yy/NufRZqQ/
        dSkO3VcA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZRoa-0006Is-Ic; Fri, 15 May 2020 04:19:16 +0000
Date:   Thu, 14 May 2020 21:19:16 -0700
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
Subject: Re: [PATCH v2 07/10] block: use sectors_to_npage() and PAGE_SECTORS
 to clean up code
Message-ID: <20200515041916.GE16070@bombadil.infradead.org>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
 <20200507075100.1779-8-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507075100.1779-8-thunder.leizhen@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 03:50:57PM +0800, Zhen Lei wrote:
> +++ b/block/blk-settings.c
> @@ -150,7 +150,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  	unsigned int max_sectors;
>  
>  	if ((max_hw_sectors << 9) < PAGE_SIZE) {
> -		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
> +		max_hw_sectors = PAGE_SECTORS;

Surely this should be:

	if (max_hw_sectors < PAGE_SECTORS) {
		max_hw_sectors = PAGE_SECTORS;

... no?

> -	page = read_mapping_page(mapping,
> -			(pgoff_t)(n >> (PAGE_SHIFT - 9)), NULL);
> +	page = read_mapping_page(mapping, (pgoff_t)sectors_to_npage(n), NULL);

... again, get the type right, and you won't need the cast.

