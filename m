Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C171AC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiF2Goi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiF2Goh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:44:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4A275C2
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:44:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 36DFA67373; Wed, 29 Jun 2022 08:44:34 +0200 (CEST)
Date:   Wed, 29 Jun 2022 08:44:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org
Subject: Re: clean up the blk-ia-ranges.c code a bit
Message-ID: <20220629064433.GA17552@lst.de>
References: <20220629062013.1331068-1-hch@lst.de> <7cc69dfd-0078-dd2a-794c-a5c5a9073f0d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc69dfd-0078-dd2a-794c-a5c5a9073f0d@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 03:32:36PM +0900, Damien Le Moal wrote:
> On 6/29/22 15:20, Christoph Hellwig wrote:
> > Hi Jens, hi Damien,
> > 
> > this is a little drive by cleanup for the ia-ranges code, including
> > moving the data structure to the gendisk as it is only used for
> > non-passthrough access.
> > 
> > I don't have hardware to test this on, so it would be good to make this
> > go through Damien's rig.
> 
> What branch is this based on ?

for-5.20/block
