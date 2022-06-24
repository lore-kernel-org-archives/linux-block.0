Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD3C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 05:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiFXFHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFXFHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:07:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D34FC54
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:07:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5594667373; Fri, 24 Jun 2022 07:07:06 +0200 (CEST)
Date:   Fri, 24 Jun 2022 07:07:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/51] Improve static type checking for request flags
Message-ID: <20220624050706.GA4789@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220624050527.GA4716@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624050527.GA4716@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 24, 2022 at 07:05:27AM +0200, Christoph Hellwig wrote:
> Hi Bart,
> 
> I generally like this.  Two thoughs:
> 
>  - I suspect most places that currently pass a enum req_op might really
>    want a blk_opf_t for future extensibility, exceptions are very 
>    low-level helpers like req_op() and bio_op() where the enum is
>    very nice to force switch statements to handle all ops or have
>    a default statements
>  - a lot of the flags printinting is a mess, and introduce the code
>    smell of __force casts.  It migh make sense to introduce a new
>    %psomething format specifier first to print a blk_opf_t using
>    printk/vsprintf/etc and switch everyone to that first instead of
>    hand crafted printing.

Oh, and a third:  there is still various places passing the op
separately from the flags and/or using bio_set_op_attrs.  This
would be a good time to clean the rest of those up (I already did
a lot of that gradually).
