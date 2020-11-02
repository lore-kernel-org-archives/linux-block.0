Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C03C00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F30922245
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 18:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgKBSIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:08:41 -0500
Received: from verein.lst.de ([213.95.11.211]:34229 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgKBSIk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 13:08:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7881868B05; Mon,  2 Nov 2020 19:08:37 +0100 (CET)
Date:   Mon, 2 Nov 2020 19:08:37 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Javier Gonzalez <javier.gonz@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102180836.GC20182@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com> <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 04:15:01PM +0000, Javier Gonzalez wrote:
> That said, I don't mind the concept, though I recall Christoph had
> concerns about the existing 0-capacity namespace used for invalid
> formats, so I'd like to hear more on that if he has some spare time to
> comment.

Yes, I really don't think 0 sized block devices are the right interface
for namespaces we can't access.  I think the proper fix is to ensure that
we have a character device that allows submitting I/O commands for each
namespaces including those where we don't understand the I/O command set
or parts of it.  That should also really help to have a proper access
model for the KV command set.  Initially we only need NVME_IOCTL_IO64_CMD,
but eventually we'll need some support for async submissions, be
that through io_uring or other ways.
