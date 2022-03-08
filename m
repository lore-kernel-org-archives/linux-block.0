Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F655C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 06:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiCHGzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 01:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbiCHGzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 01:55:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C22B251;
        Mon,  7 Mar 2022 22:54:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4147068AFE; Tue,  8 Mar 2022 07:54:44 +0100 (CET)
Date:   Tue, 8 Mar 2022 07:54:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pata_parport: paride replacement
Message-ID: <20220308065443.GA24269@lst.de>
References: <20220305201411.501-1-linux@zary.sk> <20220306085825.GA22425@lst.de> <202203061136.36700.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203061136.36700.linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 06, 2022 at 11:36:36AM +0100, Ondrej Zary wrote:
> On Sunday 06 March 2022 09:58:25 Christoph Hellwig wrote:
> > Hi Ondrej,
> > 
> > I just took a quick glance and it seems like the actual protocol
> > modules still are basically almost exactly the same ones as the
> > paride ones.  Is there a way to just keep the existing modules?
> > 
> > The only big thing I noticed is the host template, but at least
> > for the transitional periode we could probably allocate that
> > dynamically in the core.  I think would reduce the amount of code
> > churn nicely and make review much easier.
> 
> Yes, only small changes in the protocol modules regarding (un)registration.
> 
> Getting the original modules work with pata_parport (like in 1st preview) required some hacks that break paride (disabling EXPORT_SYMBOLs in paride).
> 
> Maybe the protocol modules can be moved (git mv) from paride and then patched? A copy would be better but there's no "git cp".

Hmm, how would be break the old PARIDE code?  You'd need the new libata
support exlusive to the old PARIDE code so that only one of them can
export the registration symbols at a time.  The git-mv can happen
once the old paride code is removed after a release or two.

> 
> -- 
> Ondrej Zary
---end quoted text---
