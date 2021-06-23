Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6713AC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB016112D
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFWObp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFWObp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 10:31:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2592C061574;
        Wed, 23 Jun 2021 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ieDdiT+cXnudy2hbSqWAlqdZ9AqoFLDbGiLjJtl0z+k=; b=IfuozOkc+1XSuEugMOC8GRdMVH
        gDDh3l4GzQvnjGpr60DReCardwRJoeWVVcH0ILI7WUAgVPKDtY0cG79Qjg3sQy+Y7YvS/g7dx1KAb
        gDHn6bXFVxNq4wFpK0VnA3t3t8dCnhDo+S/dKEasnkiBBtGYeppFFnHP785U/kEPvdBRTeFWX4mtZ
        8bf7IEZt1GbBaKqkJmckjefsWeW0XO+KThOAK/CEgUhN8R2mxLjqBRlYSqKuXRvdSNQAbQQGIqs9Y
        k9acsCzUb+LcWgIgahctY+o9Oeva4ViK+vIug45xOLE7PjTYVO6pPW+PwJW2sXJmshIrEYwH1iEQF
        6aNl3WGg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw3rv-00FWMS-N2; Wed, 23 Jun 2021 14:28:51 +0000
Date:   Wed, 23 Jun 2021 15:28:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
Message-ID: <YNNFGx8Su8rjhRUL@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 23, 2021 at 03:10:21PM +0200, Matteo Croce wrote:
> I just didn't want to clobber that file namespace, as that is the only
> point where it's used.

It doesn't really clobber the file namespace.  Declaring it normally
at the top of the file makes it very clear we have global state.
Hiding it in a function just causes obsfucation.

> > Can you explain a little more why we need a global sequence count vs
> > a per-disk one here?
> 
> The point of the whole series is to have an unique sequence number for
> all the disks.
> Events can arrive to the userspace delayed or out-of-order, so this
> helps to correlate events to the disk.
> It might seem strange, but there isn't a way to do this yet, so I come
> up with a global, monotonically incrementing number.

Maybe add a comment to explain that?
