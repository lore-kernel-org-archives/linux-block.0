Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFB3C433DB
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D1122D2C
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406699AbhARSev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:34:51 -0500
Received: from verein.lst.de ([213.95.11.211]:49195 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407651AbhARSeh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:34:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FAFE6736F; Mon, 18 Jan 2021 19:33:53 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:33:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different
 backends
Message-ID: <20210118183353.GA11556@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-7-chaitanya.kulkarni@wdc.com> <20210112073358.GB24288@lst.de> <BYAPR04MB4965824B7DB93A26C625AAD586A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965824B7DB93A26C625AAD586A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 05:04:49AM +0000, Chaitanya Kulkarni wrote:
> On 1/11/21 23:34, Christoph Hellwig wrote:
> > Nothing NVMe specific about this.  The helper also doesn't relaly contain
> > any logic either.
> >
> What is the preferable name ? just bio_init_fields() ?

We'll eventually need to replace bio_alloc with something initializing
the additional fields.  For now I'd just do nothing and skip the helper
for now.
