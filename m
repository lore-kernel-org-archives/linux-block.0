Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E4EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 15:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjFUPsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFUPsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 11:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C901C3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 08:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A88615A2
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 15:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F5EC433C0;
        Wed, 21 Jun 2023 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687362532;
        bh=3ecOROWs9egSZZbh2wZ/UisF+dbux5QiNUS2zoVoLnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QySUIVj8tUHHXYFtG8jtyqWJXHAlRppj2l3NUi6rpN8j6iGnkKfM+v8gz6xL7yUhS
         63KjohGL5kN1nQF8iY6tFCcXUAi9yt+EuZI7Bpk47ajccQb4rR9uIAVHAzri0JvwlW
         NJqsDwdVNC+a/ZUzhwd2iz9iLOttuI1FNiXFSabUm7SqZEFcq1DTRbKjkSjNHBgRRT
         DnRjEPL/2xFEC9vK3x7iqGoa7Vhrw+yxyvcCoJ0WPHLMGDgMDAqWuNA6JfystND7o5
         6RkQ7lSCb7FY/No8ZpVGyxHKDNpgBaPAgC6eaAw1JQVz1ZaL8C4tZPaghMvXn3qluF
         0Fr1Pf5OaocFg==
Date:   Wed, 21 Jun 2023 09:48:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 09:27:31PM +0800, Ming Lei wrote:
> On Wed, Jun 21, 2023 at 01:13:05PM +0300, Sagi Grimberg wrote:
> > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > The 1st three patch fixes io hang when controller removal interrupts error
> > > > > > > recovery, then queue is left as frozen.
> > > > > > > 
> > > > > > > The 4th patch fixes io hang when controller is left as unquiesce.
> > > > > > 
> > > > > > Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> > > > > > connect patches?
> > > > > 
> > > > > I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> > > > > extra maintain burden wrt. error handling, but looks Keith worries about the
> > > > > delay freezing may cause too many requests queued during error handling, and
> > > > > that might cause user report.
> > > > 
> > > > For nvme-tcp/rdma your patch also addresses IO not failing over because
> > > > they block on queue enter. So I definitely want this for fabrics.
> > > 
> > > The patch in the following link should fix these issues too:
> > > 
> > > https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u
> > > 
> > > I guess you still want the paired freeze patch because it makes freeze &
> > > unfreeze more reliable in error handling. If yes, I can make one fabric
> > > only change for you.
> > 
> > Not sure exactly what reliability is referred here.
> 
> freeze and unfreeze have to be called strictly in pair, but nvme calls
> the two from different contexts, so unfreeze may easily be missed, and
> causes mismatched freeze count. There has many such reports so far.
> 
> > I agree that there
> > is an issue with controller delete during error recovery. The patch
> > was a way to side-step it, great. But it addressed I/O blocked on enter
> > and not failing over.
> > 
> > So yes, for fabrics we should have it. I would argue that it would be
> > the right thing to do for pci as well. But I won't argue if Keith feels
> > otherwise.
> 
> Keith, can you update with us if you are fine with moving
> nvme_start_freeze() into nvme_reset_work() for nvme pci driver?

The point was to contain requests from entering while the hctx's are
being reconfigured. If you're going to pair up the freezes as you've
suggested, we might as well just not call freeze at all.
