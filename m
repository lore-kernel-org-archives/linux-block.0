Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC3C433E6
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F79B60234
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 15:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhBWPOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:14:17 -0500
Received: from verein.lst.de ([213.95.11.211]:34207 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232775AbhBWPNS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 10:13:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E5A9168D0A; Tue, 23 Feb 2021 16:12:33 +0100 (CET)
Date:   Tue, 23 Feb 2021 16:12:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Message-ID: <20210223151233.GA19143@lst.de>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com> <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com> <20210223071040.GB16980@lst.de> <BYAPR04MB496574519941459FE83C437D86809@BYAPR04MB4965.namprd04.prod.outlook.com> <20210223150852.GA17662@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223150852.GA17662@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 04:08:52PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 23, 2021 at 07:37:52AM +0000, Chaitanya Kulkarni wrote:
> > On 2/22/21 23:10, Christoph Hellwig wrote:
> > > On Tue, Feb 23, 2021 at 03:51:23AM +0000, Chaitanya Kulkarni wrote:
> > >> Looking at the other call sites do we need something like following ?
> > >> Since __blk_queue_bounce() passes the NULL for the passthru case as a
> > >> bio_set value ?
> > > Well, that is a somewhat odd calling convention.  What about the patch below
> > > instead?  That being we really need to kill this bouncing code off..
> > I assume you are sending this patch, let me know otherwise.
> > If you do please add, looks good.
> 
> I'll split the gfp_mask cleanup out, and will submit it with your as
> the author if that is ok.  I'll need a signoff, though.

Actually, I ended up reworking it once more as there is no point for
the parameter either.
