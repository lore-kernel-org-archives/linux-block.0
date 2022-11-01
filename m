Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C8FA373D
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 10:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKAKCM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKAKCL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 06:02:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19318E03
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 03:02:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B9CDA68AA6; Tue,  1 Nov 2022 11:02:07 +0100 (CET)
Date:   Tue, 1 Nov 2022 11:02:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/7] block: drop the duplicate check in elv_register
Message-ID: <20221101100207.GA13209@lst.de>
References: <20221030100714.876891-1-hch@lst.de> <20221030100714.876891-2-hch@lst.de> <17887101-31f3-fc60-0971-4718c9f6f3b3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17887101-31f3-fc60-0971-4718c9f6f3b3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 07:50:02AM -0600, Jens Axboe wrote:
> >  	list_add_tail(&e->list, &elv_list);
> >  	spin_unlock(&elv_list_lock);
> 
> What's the idea behind this? Yes it'll be harmless and list ordering
> will dictate which one will be found, leaving the other(s) dead, but why
> not catch this upfront? I agree likelihood of this ever happening to be
> tiny, but seems like a good idea to catch and return BUSY for this case.

Because it's just not very useful code bloat here that I stumbled upon.
But I can just drop it if you prefer.
