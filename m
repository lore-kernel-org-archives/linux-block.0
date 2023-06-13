Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62895EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjFMWnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjFMWni (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 18:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2DF107
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 15:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B653F63BBD
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 22:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6683C433C8;
        Tue, 13 Jun 2023 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686696217;
        bh=oaJ8Dk+btvIQUD+1MOdrsiFVZcI9MAkfOVLSTizDgac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4eWEMSLFCgL0X5HVd6w/2qPJpQY6ivOx0ydxvRSyL03vngIFoObwJTZX2MDlsO9W
         3V02EAv2ZiZ4JncCMjc74z1zGD9TlXhsU+xVWxq5RXNkL1ogp1njsntBy9kMekEVqV
         eOQq0U8t5naN2nPd3mBqaNeh+ETy6shtzgHBuAf91XL7um6KtxUCiRvXSGNlRIatLQ
         cnMOqzRjUh6LJVypnpvLgoAubvQgyA8sJryZWoDCiunI4JnST25/ocdrF892fT7bzf
         4LQpqSzCQJXcyD4w5DxM6OArD8A4Hpf1IOQrVuh1GBoE4RRs15VA7G6sAvB9sRKkOw
         D1DF1MUR3U8JA==
Date:   Tue, 13 Jun 2023 16:43:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIjxFhaV5nikG71S@kbusch-mbp.dhcp.thefacebook.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
 <4c40b502-4309-d601-d8bc-18042c3f490c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c40b502-4309-d601-d8bc-18042c3f490c@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 13, 2023 at 11:34:05PM +0300, Sagi Grimberg wrote:
> 
> > > And this way is correct because quiesce is enough for driver to handle
> > > error recovery. The only difference is where to wait during error recovery.
> > > With this way, IO is just queued in block layer queue instead of
> > > __bio_queue_enter(), finally waiting for completion is done in upper
> > > layer. Either way, IO can't move on during error recovery.
> > 
> > The point was to contain the fallout from modifying the hctx mappings.
> > If you allow IO to queue in the blk-mq layer while a reset is in
> > progress, they may be entering a context that won't be as expected on
> > the other side of the reset.
> 
> That still happens to *some* commands though right?

That is possible only for commands that were already dispatched and
subsequently failed with retry disposition. At the point of reset today,
nothing new enters a queue till we know what the mapping looks like.
