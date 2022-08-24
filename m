Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D3C00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 19:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiHXTbV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbiHXTa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 15:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE946CF52
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 12:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C759E617D1
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0964C433D6;
        Wed, 24 Aug 2022 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661369425;
        bh=EjEkceTcDMRPq7SE+IFmrDf/ElAQgezgcCxdFFNM18c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fj+mI9u25lE9Qu+YzLrLkc+rwBnXKNnfuVktUXSR6oB2aWW/uN6Jxr/uQpNyoep4i
         7+wloadK2fYAKfUSOGRuQBPc+Fje8TLwj375DgToUp6oSlHVH+dMu5npnSvo532vIM
         sOEQmoJxwrWvzIbjh8H8pq8Dz7BGuxC9mmIa0gqADDAmhx6wNP5QrMOOL4KYJQ5TLJ
         7Pww2i2I6TBJzvuvIY6spOFLxMDQbepWKWf2ZRe6FVoJUg5Yr9mHiuMNYPW8Ly9NQt
         8Alp5Gz2xd8dLLXRGJKl7sTIv0Q2mFYPPAHwWOi4YHPCPqTdvB+JWrjtzVIXQJx8wy
         5es2/4bg75dtw==
Date:   Wed, 24 Aug 2022 13:30:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] sbitmap: fix batched wait_cnt accounting
Message-ID: <YwZ8Tgz/UE6mkbC1@kbusch-mbp.dhcp.thefacebook.com>
References: <20220824170023.3241858-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824170023.3241858-1-kbusch@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 24, 2022 at 10:00:23AM -0700, Keith Busch wrote:
> +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>  {
>  	struct sbq_wait_state *ws;
> -	unsigned int wake_batch;
> -	int wait_cnt;
> +	int wake_batch, wait_cnt, sub;
>  
>  	ws = sbq_wake_ptr(sbq);
> -	if (!ws)
> +	if (!ws || !(*nr))
>  		return false;
>  
> -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> +	wake_batch = READ_ONCE(sbq->wake_batch);
> +	sub = min3(wake_batch, *nr, atomic_read(&ws->wait_cnt));
> +	wait_cnt = atomic_sub_return(sub, &ws->wait_cnt);
> +	*nr -= sub;
> +
>  	/*
>  	 * For concurrent callers of this, callers should call this function
>  	 * again to wakeup a new batch on a different 'ws'.

I'll need to send a new version. The code expects 'wait_cnt' to be 0 in order
to wake up waiters, but if two batched completions have different amounts of
cleared bits, one thread may see > 0, the other may see < 0, and no one will
make progress. 

I think we may need to do atomic_dec_return() in a loop so that a completer is
guaranteed to eventually see '0'.
