Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577ADC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 09:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiCRJNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiCRJNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 05:13:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2C2C5437;
        Fri, 18 Mar 2022 02:11:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2A9D68AFE; Fri, 18 Mar 2022 10:11:52 +0100 (CET)
Date:   Fri, 18 Mar 2022 10:11:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        jaegeuk@kernel.org, chao@kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH alternative 2] block: fix the REQ_OP_SECURE_ERASE
 handling to not leak erased data
Message-ID: <20220318091152.GB31758@lst.de>
References: <20220316093740.GA7714@lst.de> <20220316093855.GC7714@lst.de> <CAPDyKFrH4L2Y2TOFyWPJ+_rrgvJPixR05XX_HWUU99h0MZhLuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrH4L2Y2TOFyWPJ+_rrgvJPixR05XX_HWUU99h0MZhLuA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 17, 2022 at 10:44:01AM +0100, Ulf Hansson wrote:
> Stating that it can't work is probably not a correct statement.
> Certainly it can, but it depends on how "secure" (or clever) the
> implementation of the FTL is in the flash media. I mean, nothing
> prevents the FTL from doing a real erase on erase block level and
> simply let the "secure erase" request wait on that operation to be
> completed.

Well, that assumes it can find all the previous copied of the data.
Having worked with various higher end SSDs FTLs I know they can't,
so if an eMMC device could that would very much surpise me given
the overhead.
