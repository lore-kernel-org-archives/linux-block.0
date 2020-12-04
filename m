Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B5C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1405E227BF
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 08:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgLDIrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 03:47:17 -0500
Received: from verein.lst.de ([213.95.11.211]:33743 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbgLDIrR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 03:47:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 907636736F; Fri,  4 Dec 2020 09:46:34 +0100 (CET)
Date:   Fri, 4 Dec 2020 09:46:34 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 1/9] block: allow bvec for zone append get pages
Message-ID: <20201204084634.GA5845@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com> <20201202062227.9826-2-chaitanya.kulkarni@wdc.com> <20201202085531.GA2050258@infradead.org> <BYAPR04MB49652F70D16357D420E616AE86F10@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49652F70D16357D420E616AE86F10@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04, 2020 at 02:43:10AM +0000, Chaitanya Kulkarni wrote:
> >> Remove the bvec check in the bio_iov_iter_get_pages() for
> >> REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
> >> bvec.
> > We should do the same optimization for bvec pages that the normal path
> > does.  That being said using bio_iov_iter_get_pages in nvmet does not
> > 	make any sense to me whatsover.
> >
> Are you referring to the inline bvec ? then yes, I'll add it in next
> version.
> 
> I did not understand bio_iov_iter_get_pages() comment though.
> 
> Reimplementing the bio loop over sg with the use of bio_add_hw_page() seems
> 
> repetition of the code which we already have in bio_iov_iter_get_pages().
> 
> 
> Can you please explain why bio_iov_iter_get_pages() not the right way ?

bio_iov_iter_get_pages is highly inefficient for this use case, as we'll
need to allocate two sets of bio_vecs.  It also is rather redundant as
Zone Append should be able to just largely reuse the write path.
