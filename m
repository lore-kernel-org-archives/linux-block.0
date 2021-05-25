Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F112C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3C1613F9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhEYIOv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhEYIOf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:14:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36855C06138F
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uhspF60nprT1d6EKunDseiTKNLP39Bm1pppvT/QF7yo=; b=wW0Div6zaeC0OFFECq3At407BV
        Z/DrXQ66+NJKt5gs2zgUoewJmTWW6V8ikj2pLpW7BkGt4XNt8JiW9gCJgVwtiCyOfJoPZw6+fGwAH
        7xBel5OvV6CxYziPHQXjzPnEPeuxDyY/38p+2TY/xi+30/d4FAXzRk3EWXsneKZtAw01yUZz98PI+
        lxXnicw6U1wIN8vFfYvYQ3+KrQ9obcSw0QYlR077QI0vflpmWvvo767XNYEy7JmH/m2QxojcXzDnz
        KOTbbYAibBF5JTx0sfE9lHtqnBBBZ2IVcAGdw7mFBPZOYMwzwiEGtvV4Pl7I+IqUXr6Hg01xTqHXB
        ofKEqsaw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llSAz-003Gek-47; Tue, 25 May 2021 08:12:38 +0000
Date:   Tue, 25 May 2021 09:12:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 04/11] dm: Fix dm_accept_partial_bio()
Message-ID: <YKyxcW3hBFbzMALV@infradead.org>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525022539.119661-5-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 11:25:32AM +0900, Damien Le Moal wrote:
> Fix dm_accept_partial_bio() to actually check that zone management
> commands are not passed as explained in the function documentation
> comment. Also, since a zone append operation cannot be split, add
> REQ_OP_ZONE_APPEND as a forbidden command.
> 
> White lines are added around the group of BUG_ON() calls to make the
> code more legible.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/md/dm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index ca2aedd8ee7d..a9211575bfed 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1237,8 +1237,9 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  
>  /*
>   * A target may call dm_accept_partial_bio only from the map routine.  It is
> - * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
> - * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.
> + * allowed for all bio types except REQ_PREFLUSH, zone management operations
> + * (REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and
> + * REQ_OP_ZONE_FINISH) and zone append writes.

Maybe shorten the REQ_OP_ZONE_* list to just say REQ_OP_ZONE_* ?

