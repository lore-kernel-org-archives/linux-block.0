Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F76DC43334
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiFYJZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiFYJZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 05:25:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043012D1A
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 02:25:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C690668AA6; Sat, 25 Jun 2022 11:25:01 +0200 (CEST)
Date:   Sat, 25 Jun 2022 11:25:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 6/6] block/null_blk: Add support for pipelining
 zoned writes
Message-ID: <20220625092501.GA23615@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org> <20220623232603.3751912-7-bvanassche@acm.org> <20220624060659.GA6494@lst.de> <31602226-611f-223e-ddd3-0c8ab780cb0b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31602226-611f-223e-ddd3-0c8ab780cb0b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 24, 2022 at 09:45:54AM -0700, Bart Van Assche wrote:
> I have not yet seen any UFSHCI 4.0 implementation. The upstream UFSHCI 
> driver does not yet support it either.
>
> Hence the choice to add support to the null_blk driver for setting the 
> QUEUE_FLAG_PIPELINE_ZONED_WRITES flag.

Also I don't think UFS even supports zoned devices as is?  Either way
without an in-tree driver for actually useful and existing hardware
we should not add extra code to the block layer.
