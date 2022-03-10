Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E913C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 20:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiCJUgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCJUgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 15:36:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB7136861
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 12:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HYl7HLa06XTzSBAzIC7meEiGYtTOJ6AeMHykAerkVEs=; b=Iyz8sAbvXcAkmVRuwKso8RUfZv
        0nlMOQmgUlG6Z7DCjqtLlhcebNENoZz3XJH5jysGT8o5IcAXAwA7sxL5B3Uzy32jC75tCetbrDr5X
        q9Xw3VFzpxXSTstk+9m7tRJk0vnnDQSMSHTuGHPEDE9kRYkepl908lmvUN3asMLH5NNBZf3stnTnS
        4vdSvRRECJnk84z0p3dwv5fWepVnyQe9u/PvGvVlzUO95hcBKwV5IgUsqYYmgA55NCkNVcJB736CX
        axPvg2sN7AoHdomZbCSNIFfTICIL9mgVmIeANt3CZMtZkMP3AZmsgyCtcwaR4ykQaQtZTN9xseUPp
        7nS3ckHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSPVH-00DzAa-RX; Thu, 10 Mar 2022 20:35:19 +0000
Date:   Thu, 10 Mar 2022 12:35:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com, Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Message-ID: <YiphB2Me63kD7T5t@bombadil.infradead.org>
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
 <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
 <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
 <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 06:43:47AM +0900, Damien Le Moal wrote:
> On 3/9/22 23:33, Pankaj Raghav wrote:
> > On 2022-03-09 05:04, Damien Le Moal wrote:
> >> So for a power of 2 zone sized device, you are forcing an indirect call,
> >> always. Not acceptable. What is the point of that po2_zone_emu boolean
> >> you added to the queue ?
> > This is a good point and we had a discussion about this internally.
> > Initially I had something like this:
> > if (!blk_queue_is_po2_zone_emu(disk))
> > 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> > else
> > 	return __nvme_sect_to_lba_po2(ns, sec);
> 
> No need for the else.

If true then great.

> > But @Luis indicated that it was better to set an op which comes at a cost of indirection
> > instead of having a runtime check with a if/else in the **hot path**. The code also looks
> > more clear with having an op.
> 
> The indirect call using a function pointer makes the code obscure. And
> the cost of that call is far greater and always present compared to the
> CPU branch prediction which will luckily avoid most of the time taking
> the wrong branch of an if.

The goal was to ensure no performance impact, and given a hot path
was involved and we simply cannot microbench append as there is no
way / API to do that, we can't be sure. But if you are certain that
there is no perf impact, it would be wonderful to live without it.

Thanks for the suggestion and push!

  Luis
