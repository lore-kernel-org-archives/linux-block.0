Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8259C48BE8
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB2961465
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFOQI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:08:27 -0400
Received: from verein.lst.de ([213.95.11.211]:50106 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOQI1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 12:08:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB5D067373; Tue, 15 Jun 2021 18:06:19 +0200 (CEST)
Date:   Tue, 15 Jun 2021 18:06:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20210615160619.GA32435@lst.de>
References: <20210615131034.752623-1-hch@lst.de> <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 07:37:06AM -0700, Keith Busch wrote:
> On Tue, Jun 15, 2021 at 03:10:18PM +0200, Christoph Hellwig wrote:
> > Chances since v3:
> >  - rebased to the latests for-5.14/block tree
> >  - fix the refcount logic in __blkdev_direct_IO
> >  - split up a patch to make it easier to review
> >  - grab a queue reference in bio_poll
> >  - better document the RCU assumptions in bio_poll
> 
> It still doesn't look like a failover will work when polling through
> pvsync2. We previously discussed that here:
> 
>   https://marc.info/?l=linux-block&m=162100971816071&w=2

Yes, sorry for losing this.  I'll resend with that added after a short
delay to see if anything else needs attention.
