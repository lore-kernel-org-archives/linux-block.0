Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3332C2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C41820786
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCSZu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:25:50 -0500
Received: from verein.lst.de ([213.95.11.211]:38575 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgKCSZu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 13:25:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B2886736F; Tue,  3 Nov 2020 19:25:48 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:25:47 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Message-ID: <20201103182547.GB23300@lst.de>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com> <20201022010234.8304-7-chaitanya.kulkarni@wdc.com> <9ba9c9ba-7caf-e24c-1471-62c199cfcd4a@deltatee.com> <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 29, 2020 at 07:02:27PM +0000, Chaitanya Kulkarni wrote:
> > I still think it's cleaner to change bi_endio for the inline/alloc'd
> > cases by simply setting bi_endi_io to bio_put() only in the bio_alloc
> > case. This should also be more efficient as it's one less indirect call
> > and condition for the inline case.
> >
> > Besides that, the entire series looks good to me.
> >
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >
> > Logan
> >
> Sagi/Christoph, any comments on this one ?
> 
> This series been sitting out for a while now.

I think the suggestion from Logan makes sense.
