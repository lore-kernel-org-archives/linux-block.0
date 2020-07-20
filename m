Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDEC433E1
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCEE22B4D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGTNpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:45:52 -0400
Received: from verein.lst.de ([213.95.11.211]:47028 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgGTNpw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:45:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CCBB968BFE; Mon, 20 Jul 2020 15:45:49 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:45:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Message-ID: <20200720134549.GB3342@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720132118.10934-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:
> On a successful completion, the position the data is written to is
> returned via AIO's res2 field to the calling application.

That is a major, and except for this changelog, undocumented ABI
change.  We had the whole discussion about reporting append results
in a few threads and the issues with that in io_uring.  So let's
have that discussion there and don't mix it up with how zonefs
writes data.  Without that a lot of the boilerplate code should
also go away.

> -	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> -	    (ret > 0 || ret == -EIOCBQUEUED)) {
> +
> +	if (ret > 0 || ret == -EIOCBQUEUED) {
>  		if (ret > 0)
>  			count = ret;
>  		mutex_lock(&zi->i_truncate_mutex);

Don't we still need the ZONEFS_ZTYPE_SEQ after updating count, but
before updating i_wpoffset?  Also how is this related to the rest
of the patch?

> @@ -1580,6 +1666,11 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!sb->s_root)
>  		goto cleanup;
>  
> +	sbi->s_dio_done_wq = alloc_workqueue("zonefs-dio/%s", WQ_MEM_RECLAIM,
> +					     0, sb->s_id);
> +	if (!sbi->s_dio_done_wq)
> +		goto cleanup;
> +

Can you reuse the sb->s_dio_done_wq pointer, and maybe even the helper
to initialize it?
