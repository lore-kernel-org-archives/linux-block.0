Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7368C433EC
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901CF22BF3
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGTMHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:07:39 -0400
Received: from verein.lst.de ([213.95.11.211]:46623 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgGTMHi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 08:07:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 18CA168BFE; Mon, 20 Jul 2020 14:07:35 +0200 (CEST)
Date:   Mon, 20 Jul 2020 14:07:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        device-mapper development <dm-devel@redhat.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, cgroups mailinglist <cgroups@vger.kernel.org>
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
Message-ID: <20200720120734.GA29061@lst.de>
References: <20200720075148.172156-1-hch@lst.de> <20200720075148.172156-5-hch@lst.de> <CAFLxGvxNHGEOrj6nKTtDeiU+Rx4xv_6asjSQYcFWXhk5m=1cBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvxNHGEOrj6nKTtDeiU+Rx4xv_6asjSQYcFWXhk5m=1cBA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 20, 2020 at 01:58:22PM +0200, Richard Weinberger wrote:
> Hello Chrstoph,
> 
> On Mon, Jul 20, 2020 at 9:53 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Set up a readahead size by default.  This changes behavior for mtd,
> > ubifs, and vboxsf to actually enabled readahead, the lack of which
> > very much looks like an oversight.
> 
> UBIFS doesn't enable readahead on purpose, please see:
> http://www.linux-mtd.infradead.org/doc/ubifs.html#L_readahead

What about jffs2 and blk2mtd raw block devices?
