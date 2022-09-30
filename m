Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F6C433F5
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiI3PQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiI3PQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 11:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FA130BD5
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 08:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5536862383
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 15:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD10C433D6;
        Fri, 30 Sep 2022 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664550972;
        bh=ivbMMPx0EIBUlLwHU3p53chkbIAEt6dlqzQqe+SbtnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6E++ATP+ikY3/hEwW7knO0JNWDL39kWA84nMeRTFeyIWYIuJ1WHgMs+zECY/v3nc
         CtQ4lFModWKWf7u5ddwgbqTLwV8wlybjyyIBTc4MljG8riW79tlhMYt6SqMVHiqjuO
         cOXih0t2YsMTUTkPLivfkyNjFzWKeIrF1X9vXSnLOOwkGV82azg+rC+TYalh4uOFGZ
         N4JrInxUuzOOEqtfSiJZA1K7pPejZ0lU0gsmpSxoxpH7RCuOChFV/oW+TwxPSaKgpk
         lqjdOjOmpwVqP5Od89E7wR38g0ET9HAgbC/PumcwyIin5/vTpqtQ13yyP+ivXsSgOf
         S3KIQR6uvuu2w==
Date:   Fri, 30 Sep 2022 09:16:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 07:32:39PM +0300, Sagi Grimberg wrote:
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
> 
> But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
> You mean disable IO stats in runtime?

Yes, the user can disable it at any time. That actually makes things a bit
tricky since it can be enabled at the start of an IO and disabled by the time
it completes.
