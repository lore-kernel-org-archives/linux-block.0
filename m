Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABCEB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 14:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFVOf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjFVOfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 10:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D875E10F6
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 07:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59E196187C
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 14:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB7AC433C8;
        Thu, 22 Jun 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687444552;
        bh=weFsU4zPpYK20MvEp/VVpzz319RtkhdC+B9H6oPzuRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0H7yzCw/63R68axdM9Qp/Lmw2cvzovj9piH6Gwz9L51wqkt3oGUIMbunTxS1liBG
         B85oQqwH7YwDtpvnfePXdsO04pvOAWfpJxzJ6hbWy5KG7D+zbGf3biLo/CuUaQUtNo
         nQxUz4vlYbgCAppu/CtFc7z1YfWn1Tc7ttkQERaC9ip8fdBjnQLElNK8l/NW0nd4yv
         7G8BIsKVC1NoAqz3/yxYksj5XhpkMbTCX4uRUExhNAKzZG29d1wvEyXS5U2H3V2/Dn
         bg/1FgK4lWhqlae9KATJPVyjq0eKsn20gRYRRigdEKgQzuXRb8L98YwUaKJTLtrpaz
         Xanf+7uz/LeoA==
Date:   Thu, 22 Jun 2023 08:35:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 22, 2023 at 09:51:12PM +0800, Ming Lei wrote:
> On Wed, Jun 21, 2023 at 09:48:49AM -0600, Keith Busch wrote:
> > The point was to contain requests from entering while the hctx's are
> > being reconfigured. If you're going to pair up the freezes as you've
> > suggested, we might as well just not call freeze at all.
> 
> blk_mq_update_nr_hw_queues() requires queue to be frozen.

It's too late at that point. Let's work through a real example. You'll
need a system that has more CPU's than your nvme has IO queues.

Boot without any special nvme parameters. Every possible nvme IO queue
will be assigned "default" hctx type. Now start IO to every queue, then
run:

  # echo 8 > /sys/modules/nvme/parameters/poll_queues && echo 1 > /sys/class/nvme/nvme0/reset_controller

Today, we freeze prior to tearing down the "default" IO queues, so
there's nothing entered into them while the driver reconfigures the
queues.

What you're suggesting will allow IO to queue up in a queisced "default"
queue, which will become "polled" without an interrupt hanlder on the
other side of the reset. The application doesn't know that, so the IO
you're allowing to queue up will time out.
