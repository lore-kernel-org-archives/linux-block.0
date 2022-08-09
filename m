Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE9FC19F2D
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 19:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345476AbiHITE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbiHITD1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 15:03:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48B2BB3A;
        Tue,  9 Aug 2022 11:39:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5466B68AA6; Tue,  9 Aug 2022 20:39:14 +0200 (CEST)
Date:   Tue, 9 Aug 2022 20:39:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <20220809183913.GA15107@lst.de>
References: <20220805162444.3985535-1-kbusch@fb.com> <20220809064613.GA9040@lst.de> <YvJsxZucjbQmEZP8@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvJsxZucjbQmEZP8@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 09, 2022 at 08:18:45AM -0600, Keith Busch wrote:
> On Tue, Aug 09, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
> >  - the design seems to ignore DMA ownership.  Every time data in
> >    transfered data needs to be transferred to and from the device,
> >    take a look at Documentation/core-api/dma-api.rst and
> >    Documentation/core-api/dma-api-howto.rst.
> 
> I have this doing appropriate dma_sync_single_for_{device,cpu} if we aren't
> using coherent memory. Is there more to ownership beyond that?

As long as we only every support a single device that is fine, but
if we want to support that it gets complicated.  Sorry, this should
have been integrated with the mumblings on the multiple device mappings
as the statement iѕ false without that.
