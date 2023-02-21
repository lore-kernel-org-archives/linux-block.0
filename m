Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1295C61DA3
	for <linux-block@archiver.kernel.org>; Tue, 21 Feb 2023 21:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBUV7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBUV7V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 16:59:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3B828D0D
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OJ0UCI1COb+qd/Mec8MGsIjB7CuyFTJ96U+rJGd9LV4=; b=bxD0+fh68SGFl/u6agZD2LzaDk
        PHkd0UnLN57BDamZE+1T3LlObkkzsH/+VZlqvB6Sm8ok6UYyicGU78zG575uoPhcz6L+HieTf567l
        /DxGr1J5zORE7aWViQW0W3Ei1+8TliTGKr39bbpum0+cuf0Mq3Fw4sc7FuB4dIqriZGNvi5ZausMa
        FhhEAd9PPM6Lm+CQJe2IUzJKR4dnzsLUiVRm9pxsDRs3/heM11qOAOOxEV1UArMvxjx+LqMG/guO4
        AWdaICzXy9PeEkav2iGoJPLgb+C3ainHcsQnHfRHEc7ZVLmC8v3wZV7CWJM54uNisIgJJuF6GnYTJ
        LD6e5+Eg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUafL-009tzj-MI; Tue, 21 Feb 2023 21:59:15 +0000
Date:   Tue, 21 Feb 2023 13:59:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, gost.dev@samsung.com,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Message-ID: <Y/U+sxv6s09s/AyX@bombadil.infradead.org>
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com>
 <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com>
 <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
 <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
 <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
 <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17, 2023 at 08:22:15PM +0530, Pankaj Raghav wrote:
> I will park this effort as blk-mq doesn't improve the performance for brd,
> and we can retain the submit_bio interface.

I am not sure if the feedback was intended to suggest we shouldn't do
the blk-mq conversion, but rather explain why in some workloads it
may not be as good as the old submit_bio() interface. Probably low
hanging fruit, if we *really* wanted to provide parity for the odd
workloads.

If we *mostly*  we see better performance with blk-mq it would seem
likely reasonable to merge. Dozens of drivers were converted to blk-mq
and *most* without *any* performance justification on them. I think
ming's was the commit log that had the most elaborate performacne
metrics and I think it also showed some *minor* slowdown on some
workloads, but the dramatic gains made it worthwhile.

Most of the conversions to blk-mq didn't even have *any* metrics posted.

  Luis
