Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB932C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 22:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBVWm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjBVWmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 17:42:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA32457D9
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=czS/peAV7DtwS8oX5LBV+TW1FXaqZrZ11My4DdRNSXM=; b=2AbXpQU/cenjzNfAoAgwSXeJ45
        On2XOlN4rCgMFkqKbc9kuahvtS3ddLvXQFGepsJ3uHBiE4J8Rh92UWMqhOJC0Z9NlNW2Kwr3aU+m8
        vKcQ0sou07IMmqu3CQFGSwaE08kAEw7hMjV2HGw7nS6qzTr/Wbg4nD+1T7DzsW4cx2akf6ssbt2tj
        7si51PYtBHytr0Kg4H1MMKS2IPCNbnxBQj7x0d5Be79CoEiecC96i66EVQsTt/nex+CZfZh33fWgW
        3nDYtxi4eAwpABKizOs35NwwOQ2nr1c8pR86bHF0YZG5oW5r1k3mGBRH2iBMsYnyrajQCsjoj2sPy
        LNr0M9UA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUxoY-00EKse-Ui; Wed, 22 Feb 2023 22:42:18 +0000
Date:   Wed, 22 Feb 2023 14:42:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Message-ID: <Y/aaSsNGLhXyJ2+t@bombadil.infradead.org>
References: <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com>
 <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
 <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
 <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
 <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
 <Y/U+sxv6s09s/AyX@bombadil.infradead.org>
 <339e527b-2f2f-8b6f-6de4-84d7b5e3f96d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339e527b-2f2f-8b6f-6de4-84d7b5e3f96d@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 21, 2023 at 04:51:21PM -0700, Jens Axboe wrote:
> On 2/21/23 2:59?PM, Luis Chamberlain wrote:
> > On Fri, Feb 17, 2023 at 08:22:15PM +0530, Pankaj Raghav wrote:
> >> I will park this effort as blk-mq doesn't improve the performance for brd,
> >> and we can retain the submit_bio interface.
> > 
> > I am not sure if the feedback was intended to suggest we shouldn't do
> > the blk-mq conversion, but rather explain why in some workloads it
> > may not be as good as the old submit_bio() interface. Probably low
> > hanging fruit, if we *really* wanted to provide parity for the odd
> > workloads.
> > 
> > If we *mostly*  we see better performance with blk-mq it would seem
> > likely reasonable to merge. Dozens of drivers were converted to blk-mq
> > and *most* without *any* performance justification on them. I think
> > ming's was the commit log that had the most elaborate performacne
> > metrics and I think it also showed some *minor* slowdown on some
> > workloads, but the dramatic gains made it worthwhile.
> > 
> > Most of the conversions to blk-mq didn't even have *any* metrics posted.
> 
> You're comparing apples and oranges. I don't want to get into (fairly)
> ancient history at this point, but the original implementation was honed
> with the nvme conversion - which is the most performant driver/hardware
> we have available.
> 
> Converting something that doesn't need a scheduler, doesn't need
> timeouts, doesn't benefit from merging, doesn't need tagging etc doesn't
> make a lot of sense. If you need none of that, *of course* you're going
> to see a slowdown from doing all of these extra things by default.
> That's pretty obvious.
> 
> This isn't about workloads at all.

I'm not arguing mq design over-architecture for simple devices. It is a
given that if one doesn't need some of those things surely they can
create a minor delta loss in performance. I'm asking and suggesting that
despite a few workloads being affected with a *minor delta* for brd for mq
conversion if the huge gains possible on some *other* workloads suffice for
it to be converted over.

We're talking about + ~125% performance boost benefit for randreads.

  Luis
