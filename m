Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B7C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE88F22EBF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbhASGXp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:23:45 -0500
Received: from verein.lst.de ([213.95.11.211]:50685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbhASGNk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 01:13:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D30B6736F; Tue, 19 Jan 2021 07:12:54 +0100 (CET)
Date:   Tue, 19 Jan 2021 07:12:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        'Jens Axboe ' <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] block: Add bio_limit
Message-ID: <20210119061253.GA21250@lst.de>
References: <20210114194706.1905866-1-willy@infradead.org> <20210118181338.GA11002@lst.de> <20210118181712.GC2260413@casper.infradead.org> <20210118183113.GA11473@lst.de> <20210118192048.GF2260413@casper.infradead.org> <BL0PR04MB6514A4BFE2EA5AE59795E586E7A40@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514A4BFE2EA5AE59795E586E7A40@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 18, 2021 at 11:52:10PM +0000, Damien Le Moal wrote:
> What about calling it bio_max_bvecs() or bio_max_segs() ? Together with renaming
> BIO_MAX_PAGES to BIO_MAX_SEGS or BIO_MAX_BVECS, things would be clear on what
> this is referring to. Since these days one bvec is one seg, but segment is more
> struct request layer while bvec is more BIO layer, I would lean toward using
> bvec for naming this one, but either way would be fine I think.

That's probably the least bad of the options for now.
