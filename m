Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 15:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiI3PVc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiI3PVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 11:21:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0E16EAA8
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 08:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A224CB828A1
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 15:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D4BC433C1;
        Fri, 30 Sep 2022 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664551288;
        bh=BoSmbyb3Mqyn2qYpFLDiWbbafCJvBTmYuFHyW7vbeBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrXFH7AIqeW2fdIU4MJl1+rc4siW2AfNPVhJ5KjdBTWtsEIY90q9KV8qcaCDhJkd/
         gOartcgsytYGpDmKpRk/lFf1/ru2HlMfFS4gxVi1qQapFAugTqSD8yvhhQRlx4vnIa
         NjmHbQYuEOWfe59O0PfiC3CU0uLCFShpnnK8Emq0kla+3boyXvKmrAGB3JsoZkxiwZ
         XJf3rKCfdgqkO7WpobcVIRqjGw0BUsxestkOra5ZiZlx3p0SZMcFmhhp0pNiADQHj5
         CV9v2K0O02tDEGjk+GHjmauGQ79epR41BRNUldaV4KsRGHV3QobIbLNHMg+p8CITwu
         rMFT5vuI1IwqQ==
Date:   Fri, 30 Sep 2022 09:21:25 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 07:14:23PM +0300, Sagi Grimberg wrote:
> 
> > > > 3. Do you have some performance numbers (we're touching the fast path
> > > > here) ?
> > > 
> > > This is pretty light-weight, accounting is per-cpu and only wrapped by
> > > preemption disable. This is a very small price to pay for what we gain.
> > 
> > It does add up, though, and some environments disable stats to skip the
> > overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> > assuming you need to account for stats.
> > 
> > Instead of duplicating the accounting, could you just have the stats file report
> > the sum of its hidden devices?
> 
> Interesting...
> 
> How do you suggest we do that? .collect_stats() callout in fops?

Maybe, yeah. I think we'd need something to enumerate the HIDDEN disks that
make up the multipath device. Only the low-level driver can do that right now,
so perhaps either call into the driver to get all the block_device parts, or
the gendisk needs to maintain a list of those parts itself.
