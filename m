Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E3C0015E
	for <linux-block@archiver.kernel.org>; Wed, 12 Jul 2023 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGLQic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjGLQia (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 12:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D51FC7
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 09:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA8B16181E
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 16:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC06BC433C7;
        Wed, 12 Jul 2023 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179907;
        bh=yoZl52pqq/xcmMqzWfpmUaMVskUhx3cJbfxJe6IdPe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1oW4GzwhopR8dvLjCn4xYBw0GtX2aafGRzudg4kvbTaecuhZg1FstTJbTvS0skC8
         aEKPu0j6s62g+HsRMvWCaqOxBQDZfe5SIhHdKzpzj7I1ftE7P9/v6pYBrJdvKxAIhW
         LOgFcBIjQ9cHegD31IvPWFH8dizja7jXuMxr6OTOKaHzA3Qv1PH3hnaAswdhlRccDo
         TtAuX5xaOge1L2WjcTv8LA6n5Qm4B2ma+LjN0ebloFM6N46/XZLTK5V/+dCucKtIdU
         E1hCOsRgo8q25n4GYDSBPMX5HBzLFCnw8lAdvei0id9Z3gMUO7rTwFs90WxTN+Ex8u
         gPrpZ8CGwXsNw==
Date:   Wed, 12 Jul 2023 10:38:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Message-ID: <ZK7XAGnwU2CLbXiB@kbusch-mbp.dhcp.thefacebook.com>
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
 <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
 <20230712162310.GA29557@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712162310.GA29557@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 12, 2023 at 06:23:10PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 06:42:36PM +0800, Ming Lei wrote:
> > Userspace may write 0 to discard_max_bytes, and this patch still can
> > override user setting.
> 
> True.  Maybe the right thing is to have a user_limit field, and just
> looks at the min of that and the hw limit everywhere.  These hardware
> vs user limits are a pain, and we'll probably need some proper
> infrastructure for them :P

Yeah, I had to do something very similiar for the max_sectors limit too:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=c9c77418a98273fe96835c42666f7427b3883f48
