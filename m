Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B9C04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 07:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiI2HUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiI2HUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 03:20:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D4DF3E
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 00:19:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0C8168BFE; Thu, 29 Sep 2022 09:19:50 +0200 (CEST)
Date:   Thu, 29 Sep 2022 09:19:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [PATCH v2 2/2] block: use blk_mq_plug() wrapper consistently
 in the block layer
Message-ID: <20220929071950.GA821@lst.de>
References: <20220929062425.91254-1-p.raghav@samsung.com> <CGME20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e@eucas1p2.samsung.com> <20220929062425.91254-3-p.raghav@samsung.com> <20220929065641.GB31325@lst.de> <72d2f463-a0b1-db96-acb4-28617893407b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d2f463-a0b1-db96-acb4-28617893407b@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 09:15:12AM +0200, Pankaj Raghav wrote:
> I mentioned it in the commit header: to use this wrapper consistently
> across block layer because I am not sure if either of the changes would
> have led to a bug in zoned devices.

The only thing that goes into source control is the commit message,
so the rationale needs to go into that.
