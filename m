Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E7C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 14:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCVOay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCVOax (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 10:30:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832535FA4C
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 07:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37436B81D08
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 14:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7513FC433D2;
        Wed, 22 Mar 2023 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679495450;
        bh=wKeBG+Ixle96ci/1iogQ3xq7f2RG9f52S0T8Z8IffII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdKFixtAcS8OGWyW255UStfpYAXjuSYDtwRQCpQgXGOHc+AGr3F5sIwzgWpY8ADfj
         jVjEoR42FDgElVLJioNITIsjc5XLWXum1i5LT67IkPbezsJ6zmLJC+hGvhc4HDl+T+
         QRwgHxp+1Yu4BY/bsakeL0p1J6NjL78BQLjopsNUmUARNYEIY6TshZuWJN4Kv8WsCD
         K9mLkW0f8+8H2to4xoA8CR3UvFp72F3kKP7KmwSA/vUOnk7pMD8r2+UIeGCJcbia0y
         9YsEVr+KxqiifUxhNuk+yRDkNmnJtUMoiJClGnCzEZKgcIlw6q7UU/sq+d3DEn4KZK
         2oDWhtXVjBkDA==
Date:   Wed, 22 Mar 2023 08:30:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <ZBsRFgMkK7qf0Lsx@kbusch-mbp.dhcp.thefacebook.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
 <20230322082310.GA22782@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322082310.GA22782@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 09:23:10AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 05:23:49PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This is for mostly for testing purposes.
> 
> I have to admit I'd rather not merge this upstream.  Any good reason
> why we'd absolutely would want to have it?

The only value is that it's the easiest fabric to exercise some of these
generic code paths, and it's how I validated the fix in patch 3. Otherwise this
is has no other practical use case, so I don't mind dropping it.

Let's just go with patch 3 only from this series. I'll rework patch 1 atop
Sagi's rdma affinity removal since it's a nice cleanup.
