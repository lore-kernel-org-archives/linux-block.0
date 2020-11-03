Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30710C4742C
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64F820756
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 09:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCJGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:06:37 -0500
Received: from verein.lst.de ([213.95.11.211]:36354 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgKCJGb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 04:06:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7146968B02; Tue,  3 Nov 2020 10:06:28 +0100 (CET)
Date:   Tue, 3 Nov 2020 10:06:28 +0100
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
Message-ID: <20201103090628.GA15656@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com> <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local> <20201102180836.GC20182@lst.de> <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com> <20201102185851.GA21349@lst.de> <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 10:24:05PM +0100, Javier Gonzalez wrote:
> If I understand correctly, the model would be that a namespace will
> always have (i) a character device associated where I/O is always allowed
> through user formed commands, and if the namespace has full support in
> the kernel (ii) a block device where I/O is as it is today. In case of
> (ii) both interfaces can be used for I/O.

Yes.

> While we work on iterations for c), do you believe it is reasonable to
> merge a version of the current path that follows the PI convention for
> unsupported command sets and features? I would assume that we will have
> to convert PI to this model too when it is available.

I'm rather torn.  I think the model of the zero capacity block device
is a really, really bad one and we should haver never added it.  That
being said, for a ZNS namespace that does not support Zone Append I
can think of a model that actually makes sense:  expose it as a read-only
block device, as we can actually read from it perfectly fine, and that
would also allow ioctl access.
