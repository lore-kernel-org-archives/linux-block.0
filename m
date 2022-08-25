Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C12C28D13
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbiHYN3u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbiHYN3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 09:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06043AE857
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 06:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08FB61B74
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 13:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77AFC433B5;
        Thu, 25 Aug 2022 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661434183;
        bh=owTt6yti+UqMcH+4Ee4hxN6FFPdx/MtwEilGoiax7U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zc5WUbHTezvaCBMkyl2vrjZ8zRJ7zGzkA8ws76gP4bPDP1gcBJf+XZrI8G9XgMznq
         JLMnYxYEAnkjqpx8csF93ecA0x1f2a5uTMSeASPlWuMkYHZfieRDUGyt43w67F8Ebk
         k8YIhjYU5luUxrXvnn3f6fRjjiz8k7U5q54xdpi0nB9PVzU5H15ttZpc3H9FF53Far
         ffVd6Nu+B2roey95QrnVBh3qkXQCgUp6a3GePHpnzk/aQewZu2fKKD1cD4v6BA6xcH
         KQ41wxYPMzztD0QEP59dO1LWFwRCggOKpZrmQRGy572+PwwE3lKDvr7TMUcU6H/VH2
         am1J8pHTJRkhw==
Date:   Thu, 25 Aug 2022 07:29:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Keith Busch <kbusch@fb.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv2] sbitmap: fix batched wait_cnt accounting
Message-ID: <Ywd5RPCDNLz6RKmu@kbusch-mbp.dhcp.thefacebook.com>
References: <20220824201440.127782-1-kbusch@fb.com>
 <bda24921-8fcb-8e22-6685-2614ce1bec5f@suse.de>
 <YwdyFLxBHDXzbg3P@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdyFLxBHDXzbg3P@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 06:59:00AM -0600, Keith Busch wrote:
> On Thu, Aug 25, 2022 at 08:09:50AM +0200, Hannes Reinecke wrote:
> > > +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> > 
> > Why is '*nr' a pointer? It's always used as a value, so what does promoting
> > it to a point buys you?
> 
> Not quite, see below:
>  
> > >   {
> > >   	struct sbq_wait_state *ws;
> > > -	unsigned int wake_batch;
> > > -	int wait_cnt;
> > > +	int wake_batch, wait_cnt, sub, cur;
> > >   	ws = sbq_wake_ptr(sbq);
> > >   	if (!ws)
> > >   		return false;
> > > -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > > +	wake_batch = READ_ONCE(sbq->wake_batch);
> > > +	do {
> > > +		cur = atomic_read(&ws->wait_cnt);
> > > +		sub = min3(wake_batch, *nr, cur);
> > > +		wait_cnt = cur - sub;
> > > +	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> > > +
> > > +	*nr -= sub;
> 
> Dereferenced here to account for how many bits were considered for this wake
> cycle.

Actually, I think we can just get rid of this accounting. Instead of calling
wake_up_nr() with wake_batch multiple times, we can call wake_up_nr() with
max(wake_batch, nr) just once, then all bits are accounted for in a single go.
The 'wake_batch' value is really just the lowest amount of tags to accumulate
before waking tag waiters; having more should be fine.
