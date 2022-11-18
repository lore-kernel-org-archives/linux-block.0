Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD87C4332F
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 02:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiKRC7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKRC7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 21:59:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC554AF0F
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 18:59:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB3C622BC
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 02:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA422C433D6;
        Fri, 18 Nov 2022 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668740374;
        bh=CPrZZ6dIFVSDtW5fc1nYDVygkxJOYilG3ohe7Mp3Jjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oc+778//oBklxIXzoHPDjxQEvX0Hd1+rMF9kdilgtb/u8I4jlf+w167iLopykKxpR
         1ZNSyNkAAJDmgvvjiPQ4dC9bySb8oVuwTblU5XZEHxRiPJk/9rNk74WRMhNZvkHHvA
         3fWffiHgyXIyQrqtUY1mRoLUINaWsJTLR5LzWzXhqEbkop8rKUSc4CjWMF8uALWA1b
         EV7p9hz4JuP4k8rExwDIr/1kHScOFqKYHnPVu2Gtt8OU1iRVo6y7oJoSY+rPGHyuFz
         9YZzPeP6/U4jmYdXC0TwMh3qUeOYKYeNJKhDGAZs3Pgu1F3JTJn9YzLzofdGvtxlNz
         BUBa5bQOflqHA==
Date:   Thu, 17 Nov 2022 18:59:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-crypto: pass a gendisk to
 blk_crypto_sysfs_{,un}register
Message-ID: <Y3b1FDhjTQ+JFiBB@sol.localdomain>
References: <20221114042637.1009333-1-hch@lst.de>
 <20221114042637.1009333-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114042637.1009333-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 14, 2022 at 05:26:33AM +0100, Christoph Hellwig wrote:
> Prepare for changes to the block layer sysfs handling by passing the
> readily available gendisk to blk_crypto_sysfs_{,un}register.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-internal.h | 10 ++++++----
>  block/blk-crypto-sysfs.c    |  7 ++++---
>  block/blk-sysfs.c           |  4 ++--
>  3 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
