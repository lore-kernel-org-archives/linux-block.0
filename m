Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A75DC07E95
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B7A61186
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbhGSRsJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379192AbhGSRfb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 13:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20A6B610FB;
        Mon, 19 Jul 2021 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626718571;
        bh=3if5psrMgcS5ntuhboErJR2PdkvwudAjGSgamgfGbIM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VEbV/PoB7BD+IXyi27bnqiIBsOCfdREnckZmHqQ3uHYWhvcwPNmsKv/kuziXzJDir
         l/czml19dBW3Hd7ZCgjDxnwWxln2HEAy+ty+pOV9n6wjkwvPyc9nM8JQv+n4fO6FDo
         se+V8WSoftjPlwx6dt/2IMG6tCrLXNADXhKkuHXwx3YW/v70efFTP7wupR/pRtZO6W
         1zH94nic3llEnVkps0SlgkISRkC0TylzbI0cBGF3qJ+ld88NRRlqkyO1kiffGf04yr
         LcpVyXxCxavbc7WHYAA8TkNWZckZeBZvocadxBkZwucMZQAfC/cmbEF0MBGJgRRw55
         s5LpfrJJc4WUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD6645C2BE5; Mon, 19 Jul 2021 11:16:10 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:16:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hou Tao <houtao1@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com, will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH] block: ensure the memory order between bi_private and
 bi_status
Message-ID: <20210719181610.GA4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210701113537.582120-1-houtao1@huawei.com>
 <20210715070148.GA8088@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715070148.GA8088@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 09:01:48AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 01, 2021 at 07:35:37PM +0800, Hou Tao wrote:

[ . . . ]

> > Fixing it by using smp_load_acquire() & smp_store_release() to guarantee
> > the order between {bio->bi_private|dio->waiter} and {bi_status|bi_blkg}.
> > 
> > Fixes: 189ce2b9dcc3 ("block: fast-path for small and simple direct I/O requests")
> 
> This obviously does not look broken, but smp_load_acquire /
> smp_store_release is way beyond my paygrade.  Adding some CCs.

Huh.

I think that it was back in 2006 when I first told Linus that my goal was
to make memory ordering routine.  I clearly have not yet achieved that
goal, even given a lot of help from a lot of people over a lot of years.

Oh well, what is life without an ongoing challenge?  ;-)

							Thanx, Paul
