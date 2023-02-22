Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD31C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 22:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBVWyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVWyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 17:54:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00BF23326
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 14:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ytUasLMzcwQ+k5qTZ5mq/qRkk86wgI5irmVywI/s21k=; b=r+2nfqCzn2A6xxnsPA99KhvDTp
        Uoeckp4DHCaFwl67jVwnm2kdBp6TZnN51k9LHhelfl7MfUrCjweeSaSj9vQ6VlNb0F4iHNVMj/Bgg
        VOpojyIybJpl1YQn9Yhh/9nkd21LL2PD5I5Ci7uCdenQqgI2ztQM2Cbt8RGC1fVwG0CeoH2KzkC0x
        Rz41GHDAfsnmziuyVeRL0uAP5SIbzoTGONQ5UX3sdWCzEtEvEOn7JINKGVd0J1NI6xw+gn0p4JJsZ
        ZDD7Id2MQahh9ikvk/dR4JAUyLdd4FjVaXuFXOSCf1yUgUaOZAXsDXC2mxRuQBfanU328ac2W1RpR
        KXWwWsKA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUy0U-00EMgT-Ub; Wed, 22 Feb 2023 22:54:38 +0000
Date:   Wed, 22 Feb 2023 14:54:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Message-ID: <Y/adLpGkWikUVgvd@bombadil.infradead.org>
References: <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
 <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
 <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
 <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
 <Y/U+sxv6s09s/AyX@bombadil.infradead.org>
 <339e527b-2f2f-8b6f-6de4-84d7b5e3f96d@kernel.dk>
 <Y/aaSsNGLhXyJ2+t@bombadil.infradead.org>
 <1b3b5d37-ff2c-6a0a-87c0-3de33ea254e1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3b5d37-ff2c-6a0a-87c0-3de33ea254e1@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 22, 2023 at 03:47:43PM -0700, Jens Axboe wrote:
> On 2/22/23 3:42?PM, Luis Chamberlain wrote:
> > On Tue, Feb 21, 2023 at 04:51:21PM -0700, Jens Axboe wrote:
> >> On 2/21/23 2:59?PM, Luis Chamberlain wrote:
> >>> On Fri, Feb 17, 2023 at 08:22:15PM +0530, Pankaj Raghav wrote:
> >>>> I will park this effort as blk-mq doesn't improve the performance for brd,
> >>>> and we can retain the submit_bio interface.
> >>>
> >>> I am not sure if the feedback was intended to suggest we shouldn't do
> >>> the blk-mq conversion, but rather explain why in some workloads it
> >>> may not be as good as the old submit_bio() interface. Probably low
> >>> hanging fruit, if we *really* wanted to provide parity for the odd
> >>> workloads.
> >>>
> >>> If we *mostly*  we see better performance with blk-mq it would seem
> >>> likely reasonable to merge. Dozens of drivers were converted to blk-mq
> >>> and *most* without *any* performance justification on them. I think
> >>> ming's was the commit log that had the most elaborate performacne
> >>> metrics and I think it also showed some *minor* slowdown on some
> >>> workloads, but the dramatic gains made it worthwhile.
> >>>
> >>> Most of the conversions to blk-mq didn't even have *any* metrics posted.
> >>
> >> You're comparing apples and oranges. I don't want to get into (fairly)
> >> ancient history at this point, but the original implementation was honed
> >> with the nvme conversion - which is the most performant driver/hardware
> >> we have available.
> >>
> >> Converting something that doesn't need a scheduler, doesn't need
> >> timeouts, doesn't benefit from merging, doesn't need tagging etc doesn't
> >> make a lot of sense. If you need none of that, *of course* you're going
> >> to see a slowdown from doing all of these extra things by default.
> >> That's pretty obvious.
> >>
> >> This isn't about workloads at all.
> > 
> > I'm not arguing mq design over-architecture for simple devices. It is a
> > given that if one doesn't need some of those things surely they can
> > create a minor delta loss in performance. I'm asking and suggesting that
> > despite a few workloads being affected with a *minor delta* for brd for mq
> > conversion if the huge gains possible on some *other* workloads suffice for
> > it to be converted over.
> > 
> > We're talking about + ~125% performance boost benefit for randreads.
> 
> Please actually read the whole thread. The boost there was due to brd
> not supporting nowait, that has since been corrected.

Ah, that's what happens when reading patches over the phone while *on
vacation*, coming back and thinking you *don't* have to re-read the
threads.

> And the latest
> numbers reflect that and how the expected outcome (bio > blk-mq for brd,
> io_uring > aio for both).

Got it thanks!

  Luis
