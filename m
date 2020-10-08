Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FAAC433E7
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 06:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F012087D
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 06:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qK+U2oOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgJHGkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 02:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 02:40:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE1CC061755
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3U/56A6qijhKddpIJfcEZtHPxkuiX6C2loHkRD85i1Y=; b=qK+U2oOO6fNpjOOeWHfnVAsbyb
        WPhSVcdPs7hTw3+i23HmDpcKjTCpfpIOsIhj9Naj2a0xPQ/Kcp0JyIKLrGovSWdqo0ReZRTweMzw9
        AqJCWzU/YV42+iSGPPVUw4tCWk9apJKiCSNBnmOkQVDXVKhMYWycMjFEuK+NDopq5Z0j0BiQ4WpC4
        eqV7LpVObSGR+KjwalKYC+pVYCANnnZPiFu/XKjHJP035C7ivMnYxgMdjrriEw9SfjsT75qGjqOYS
        PEkQ/15lQabvMaoo/AnCmkilCMKOsPhBDlhYbhFTU9Czl9nqofai25stuVlItbVH8wYHjbPPcGnJb
        zg2el0gg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQPbd-0008Af-CC; Thu, 08 Oct 2020 06:40:49 +0000
Date:   Thu, 8 Oct 2020 07:40:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: ratelimit handle_bad_sector() message
Message-ID: <20201008064049.GA29599@infradead.org>
References: <20201008002344.6759-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008002344.6759-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 08, 2020 at 09:23:44AM +0900, Tetsuo Handa wrote:
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -803,8 +803,8 @@ static void handle_bad_sector(struct bio *bio, sector_t maxsector)
>  {
>  	char b[BDEVNAME_SIZE];
>  
> -	printk(KERN_INFO "attempt to access beyond end of device\n");
> -	printk(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
> +	printk_ratelimited(KERN_INFO "attempt to access beyond end of device\n");
> +	printk_ratelimited(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
>  			bio_devname(bio, b), bio->bi_opf,
>  			(unsigned long long)bio_end_sector(bio),
>  			(long long)maxsector);

Please use pr_info_ratelimited, and also remove the casts now that
sector_t is guranteed to be an unsigned long long.
