Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Dec 2021 15:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhL3PaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Dec 2021 10:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhL3PaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Dec 2021 10:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261DC061574
        for <linux-block@vger.kernel.org>; Thu, 30 Dec 2021 07:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E91616F6
        for <linux-block@vger.kernel.org>; Thu, 30 Dec 2021 15:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213E1C36AE9;
        Thu, 30 Dec 2021 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640878220;
        bh=cdkNcLIu5HbBEb98Iw88Io7o1FiwtkTBpgHZjg8KW7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4mp47E+Mg5LAHRDskrreikNbW6jZ+noEMwyTvd6kJW0M7Uov4VD7kWiIFIsyyYlu
         N5HZUYPMzuVG8OWhZqW23EbkemVhzu3UFA17PqtF71STuuodfKlNAPEAAowBa+aiTc
         92RbG91YvI+EcYimpDblIcKTS2F/JuN7v/beOPAIXbij8LfkMF3RVLBslZk0GDHU+3
         32InlCiFIt/E/0+LGp9wYrYL2Yy4VlZdy7CkFpeksUuZCUCwLw/Ep+SH95NZZAmlPi
         tgsswFva7iBSLTwRbQmLWlE/NLS9Bxes3VZlKrA+Fvx9FmtpbF/B6UIyDpJNeuAMtY
         eKJ4WhxuKKwMA==
Date:   Thu, 30 Dec 2021 07:30:18 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 30, 2021 at 04:38:57PM +0200, Max Gurtovoy wrote:
> 
> On 12/29/2021 10:57 PM, Keith Busch wrote:
> > On Wed, Dec 29, 2021 at 06:39:02PM +0100, Christoph Hellwig wrote:
> > > (except for the fact that it, just like the other rq_list helpers
> > > really should go into blk-mq.h, where all request related bits moved
> > > early in this cycle)
> > Agreed, I just put it here because it's where the other macros live. But
> > 'struct request' doesn't exist in this header, so it does seem out of
> > place.  For v3, I'll add a preceding patch to move them all to blk-mq.h.
> 
> Did you see the discussion I had with Jens ?

I did, yes. That's when I noticed the error handling wasn't right, and
doing it correctly was a bit clunky. This series was supposed to make it
easier for drivers to use the new interface.
 
> Seems it works only for non-shared tagsets and it means that it will work
> only for NVMe devices that have 1 namespace and will not work for NVMf
> drivers.

I am aware shared tags don't get to use the batched queueing, but that's
orthogonal to this series.

Most PCIe NVMe SSDs only have 1 namespace, so it generally works out for
those. 

> Unless, we'll do some changes in the block layer and/or remove this
> condition.

I think it just may work if we export blk_mq_get_driver_tag().
