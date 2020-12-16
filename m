Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42109C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0529B20721
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 22:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgLPWXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgLPWXQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 17:23:16 -0500
Date:   Thu, 17 Dec 2020 07:22:29 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608157355;
        bh=EonpH88w41zgV/GNFcze3iCUSZYiSm3hlXNNN022oCU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDUeYU02Mv8z/5pTlzKHRrxHe9XKlqlSZDJxzOHJH/I/0qu/cCW8U/ahyFEo5zXft
         5+FzlbPVnBT4S4eUcdOX22OIRVDivxSHUZNYjfp5SbE6wg4FWN/vX6gFQ9kpi5wHav
         n0LH/WR/tRY3enUIZIVIhxtMzNv2Rdu6wcABdPV8IyO7nlyo3t3/fF7shNyfhyXIlC
         3E4QUgDmxp2KhMYMEYKbtlp1q1d06FNu+iTq5EfIm5PSOjhPPUtGNAal0lreC/Vd8Z
         AUgBGpo4zaB7ji7WHdtbScODdogQZQ1w7cU9FCGmOh9i9UbKJbuT9W9SmR4IpheDbW
         eQa4/TrZg7F1Q==
From:   Keith Busch <kbusch@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201216222229.GB31311@redsun51.ssa.fujisawa.hgst.com>
References: <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
 <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
 <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
 <20201213181927.GA3909519@dhcp-10-100-145-180.wdc.com>
 <55ec2183-2b3a-7660-a7fa-3f063872845e@gmail.com>
 <20201214182310.GA22725@redsun51.ssa.fujisawa.hgst.com>
 <1859cc60-eaa2-9a3a-6d99-6363de449332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1859cc60-eaa2-9a3a-6d99-6363de449332@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 14, 2020 at 07:01:31PM +0000, Pavel Begunkov wrote:
> On 14/12/2020 18:23, Keith Busch wrote:
> > The existing block layer polling semantics doesn't poll for a specific
> > request. Please see the blk_mq_ops driver API for the 'poll' function.
> > It takes a hardware context, which does not indicate a specific request.
> > See also the blk_poll() function, which doesn't consider any specific
> > request in order to break out of the polling loop.
> 
> Yeah, thanks for pointing out, it's just the users do it that way --
> block layer dio and somewhat true for io_uring, and also hybrid part is
> per request based (and sleeps once per request), that stands out.
> If would go with coml-to-compl it should be changed. And not to forget
> that subm-to-compl sometimes is more desirable.

Right, so coming full circle to my initial reply: the block polling
thread may be responsible for multiple requests when it wakes up, yet
the hybrid sleep timer considers only one; therefore, the sleep criteria
is not always accurate and is worse than interrupt driven at high q
depth.

The current sleep calculation works fine for QD1, but I don't see a
clear way to calculate an accurate sleep time for higher q-depths within
a reasonable CPU cost. My only suggestion is just don't sleep at all as
long as the polling thread continues to reap completions on its first
poll.
