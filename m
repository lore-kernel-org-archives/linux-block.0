Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438E7C433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2518360FE7
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 08:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhKLIre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 03:47:34 -0500
Received: from verein.lst.de ([213.95.11.211]:60484 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhKLIre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 03:47:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52BA168AA6; Fri, 12 Nov 2021 09:44:41 +0100 (CET)
Date:   Fri, 12 Nov 2021 09:44:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
Message-ID: <20211112084441.GA32120@lst.de>
References: <20211112081137.406930-1-ming.lei@redhat.com> <20211112082140.GA30681@lst.de> <YY4nv5eQUTOF5Wfv@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY4nv5eQUTOF5Wfv@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
> > can only be used for reads, and no fua can be set if the preallocating
> > I/O didn't use fua, etc.
> > 
> > What are the pitfalls of just chanigng cmd_flags?
> 
> Then we need to check cmd_flags carefully, such as hctx->type has to
> be same, flush & passthrough flags has to be same, that said all
> ->cmd_flags used for allocating rqs have to be same with the following
> bio->bi_opf.
> 
> In usual cases, I guess all IOs submitted from same plug batch should be
> same type. If not, we can switch to change cmd_flags.

Jens: is this a limit fitting into your use cases?

I guess as a quick fix this rejecting different flags is probably the
best we can do for now, but I suspect we'll want to eventually relax
them.
