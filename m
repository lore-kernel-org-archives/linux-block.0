Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D788EEB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 06:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGJGj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 02:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGJGj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 02:39:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDE186
        for <linux-block@vger.kernel.org>; Sun,  9 Jul 2023 23:39:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF1D26732D; Mon, 10 Jul 2023 08:39:48 +0200 (CEST)
Date:   Mon, 10 Jul 2023 08:39:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Message-ID: <20230710063948.GA24519@lst.de>
References: <20230707094616.108430-1-hch@lst.de> <20230707094616.108430-4-hch@lst.de> <06da81f9-dbdd-f706-0e26-afcfb89cfe32@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06da81f9-dbdd-f706-0e26-afcfb89cfe32@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 10, 2023 at 12:57:56PM +0900, Damien Le Moal wrote:
> On 7/7/23 18:46, Christoph Hellwig wrote:
> > ctrl->max_discard_sectors stores a value that is potentially based of
> > the DMRSL field in Identify Controller, which is in units of LBAs and
> > thus dependent on the Format of a namespace.
> > 
> > Fix this by moving the calculation of max_discard_sectors entirely
> > into nvme_config_discard and replacing the ctrl->max_discard_sectors
> > value with a local variable so that the calculation is always
> 
> I do not see a local variable replacement... May be you meant direct calls to
> blk_queue_max_discard_sectors() ?

Yeah, I used a local variable first, but then noticed they are
pointless as we can just call blk_queue_max_discard_sectors directly
and didn't update the commit log.
