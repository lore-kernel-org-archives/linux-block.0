Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F45C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjEQSNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEQSNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 14:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A057DA8
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 11:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A68625F1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 18:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BD2C433D2;
        Wed, 17 May 2023 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684347187;
        bh=eBAyirUwlRgIAL9iChS9uD3rZqvK5LYHJbZQLto3eaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ockVkU9RiGB31BkatNqh/IWuQ/JwctVsu3hYVFnr/JulgBzM8JFzBVHqP2+gyUpAQ
         kzXrWLmll0RW+ShDIspfV9gApxqUXlSqh71GrlrLGh8o6GIRAgZtQ1Zv4/WC6zGYLg
         fzi4ysU8OQ8hM1aYHx2HA+6jcLTW/x24YvKUwLSxCvpWpoKB4jc7HX9SSIVPhFmijV
         tSZw/BsPUVkDd5YZuh0PUNnfx6eG6+5cknRHGR/t4en3JXMDwHN9PwnUpDeyjkyP25
         ChzSfR2sL75MSepsuCTG7EtJsXrqwgnZUShE3M4u7dfPAMSx6eRxBJXj+o3DZisC40
         eTgml6Qn8WU9A==
Date:   Wed, 17 May 2023 12:13:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGUZMATdnt8hFM+A@kbusch-mbp>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
 <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
 <ZGOXkhzPplCfK6kc@kbusch-mbp>
 <ZGRJaLSx6hToubQ7@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGRJaLSx6hToubQ7@ovpn-8-19.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 17, 2023 at 11:26:32AM +0800, Ming Lei wrote:
> On Tue, May 16, 2023 at 08:47:46AM -0600, Keith Busch wrote:
> 
> > And the passthrough case is special with users of that interface taking
> > on a greater responsibility and generally want the kernel out of the
> > way. I don't think anyone would purposefully run a tag intense workload
> > through that engine at the same time as using a generic one with the
> > scheduler. It definitely should still work, but it doesn't need to be
> > fair, right?
> 
> I guess it may work, but question is that what we can get from this kind
> of big change? And I think this approach may be one following work if it is
> proved as useful.

I'm just trying to remove any need for side channels to bypass block
layer functionality, like this one:

  http://lists.infradead.org/pipermail/linux-nvme/2023-April/039522.html
