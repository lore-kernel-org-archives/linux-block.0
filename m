Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966FAC433DF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7704620771
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbgGVOxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:53:03 -0400
Received: from verein.lst.de ([213.95.11.211]:56617 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgGVOxD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 10:53:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5C8F68B05; Wed, 22 Jul 2020 16:53:01 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:53:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Message-ID: <20200722145301.GB20266@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-3-johannes.thumshirn@wdc.com> <20200720134549.GB3342@lst.de> <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com> <20200721055410.GA18032@infradead.org> <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com> <CY4PR04MB375139CC436B04DDE02B8560E7790@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375139CC436B04DDE02B8560E7790@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 01:02:14PM +0000, Damien Le Moal wrote:
> That is the general idea. But Christoph point was that reporting the effective
> write offset back to user space can be done not only for zone append, but also
> for regular FS/files that are open with O_APPEND and being written with AIOs,
> legacy or io_uring. Since for this case, the aio->aio_offset field is ignored
> and the kiocb pos is initialized with the file size, then incremented with size
> for the next AIO, the user never actually sees the actual write offset of its
> AIOs. Reporting that back for regular files too can be useful, even though
> current application can do without this (or do not use O_APPEND because it is
> lacking).
> 
> Christoph, please loudly shout at me if I misunderstood you :)

I'd never shout at you :)  But yes, this is correct.
