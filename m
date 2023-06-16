Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A6EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbjFPHEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbjFPHEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:04:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964943A8F
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 00:02:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D7276732D; Fri, 16 Jun 2023 09:02:38 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:02:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Message-ID: <20230616070237.GC29500@lst.de>
References: <20230612203314.17820-1-bvanassche@acm.org> <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk> <20230615041537.GB4281@lst.de> <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 06:55:36AM -0700, Bart Van Assche wrote:
> On 6/14/23 21:15, Christoph Hellwig wrote:
>> I really hate having this core complexity, but I suspect trying to driver
>> hacks would be even worse than that, especially as this goes through
>> the SCSI midlayer.  I think the answer is simply that if Google keeps
>> buying broken hardware for their products from Samsung they just need
>> to stick to a 4k page size instead of moving to a larger one.
>
> Although I do not like it that the Exynos UFS controller does not follow 
> the UFS standard, this UFS controller is used much more widely than only in 
> devices produced by my employer. See e.g. the output of the following grep 
> command:

But it seems like no one is insisting on using it with larger than 4k
page sizes.  I think we should just prohibit using the driver for those
kernel configs and be done with it.
