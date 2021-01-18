Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19835C433E6
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E643822CA2
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407615AbhARS3K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:29:10 -0500
Received: from verein.lst.de ([213.95.11.211]:49167 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407593AbhARS2q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:28:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 379AF67373; Mon, 18 Jan 2021 19:28:04 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:28:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Message-ID: <20210118182803.GE11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-6-chaitanya.kulkarni@wdc.com> <20210112073315.GA24288@lst.de> <BYAPR04MB4965361DC74566BD26E3DC7B86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965361DC74566BD26E3DC7B86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 05:03:05AM +0000, Chaitanya Kulkarni wrote:
> On 1/11/21 23:33, Christoph Hellwig wrote:
> > I'm not a huge fan of this helper, especially as it sets an end_io
> > callback only for the allocated case, which is a weird calling
> > convention.
> >
> 
> The patch has a right documentation and that end_io is needed
> for passthru case. To get rid of the weirdness I can remove
> passthru case and make itend_io assign to inline and non-inline bio
> to make it non-weired.
> 
> Since this eliminates exactly identical lines of the code in atleast two
> backend which we should try to use the helper in non-wried way.

I really do not like helper that just eliminate "duplicate lines" vs
encapsulating logic that makes sense one its own.
