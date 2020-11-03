Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89033C2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A302072D
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKCP0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:26:49 -0500
Received: from verein.lst.de ([213.95.11.211]:37915 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbgKCP0M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 10:26:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF72F6736F; Tue,  3 Nov 2020 16:26:09 +0100 (CET)
Date:   Tue, 3 Nov 2020 16:26:09 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201103152609.GA10928@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com> <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local> <20201102180836.GC20182@lst.de> <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com> <20201102185851.GA21349@lst.de> <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain> <20201103090628.GA15656@lst.de> <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 03, 2020 at 03:10:19PM +0100, Javier Gonzalez wrote:
> One question here is that we are preparing a RFC for a io_uring passthru
> using the block device. Based on this discussion, it seems to me that
> you see this more suitable through the char device.
>
> Does it make sense that we post this RFC using the block device? It
> would be helpful to get early feedback before starting the char device.

If you wan to send the RFC with the block device that is ok.  But I
think the separate character device is pretty trivial, at least for
NVM command set derived command sets like ZNS (for others we'll need
to finish the Command Set Independent Identify Namespace TP first).

> I see that this does not make much sense for the other non-supported
> features in this patch (i.e., !po2 zone size and zoc). Since this is
> very much like PI today, is it OK we add these the same way (capacity 0)
> and then move to the char device when ready?

I'd rath avoid adding more of that capacity 0 mess if we can.  Especially
as the character device should be really easy to do.
