Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F45C04AA5
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiHYNGR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242169AbiHYNFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 09:05:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CBD71BF6
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 06:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E1C3B8294B
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 13:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF2DC433C1;
        Thu, 25 Aug 2022 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661432704;
        bh=0M1quZk8F63BXGBwej3X+aaL9KlFc9FMV8mZlF5l25g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCc0qwzztQpujBr1h8Hxosm91S0jyC9joTkOY7oD2zTQ4sFRWqD5WCvYl4LL5LGYb
         BotSTiN/8ob6FJGn11LbQpbTwmeiOuhVp8OgUd34IdKBnWYrSIxUNW628v/upkluji
         JnxOLYXp7/7NzISbiqwrALa6OUP0SIVYXciMyx5rWa0CsenueyEh0C55/9E+WqvGrQ
         Nfn412HaD+j0ABGjwcH+sjFkHFuO8WmehcJU5PC2nbQbQ4pny0j69rXIgq0xLaJw5D
         0gmXN3jIVV3IEbu3FrCnB07k8Eyu41ellG1ou4GbV/5F2ZMXncS0xewVGM+ns/4rOw
         xJrYYN13ImW/A==
Date:   Thu, 25 Aug 2022 07:05:01 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     Keith Busch <kbusch@fb.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv2] sbitmap: fix batched wait_cnt accounting
Message-ID: <YwdzfW1xJQIxnm82@kbusch-mbp.dhcp.thefacebook.com>
References: <20220824201440.127782-1-kbusch@fb.com>
 <20220825114807.v5pjnkvtfttlsiv4@quentin>
 <20220825115506.nfwycdjkudwrob3q@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825115506.nfwycdjkudwrob3q@quentin>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 01:55:06PM +0200, Pankaj Raghav wrote:
> On Thu, Aug 25, 2022 at 01:48:43PM +0200, Pankaj Raghav wrote:
> > On Wed, Aug 24, 2022 at 01:14:40PM -0700, Keith Busch wrote:
> > >  
> > > -static bool __sbq_wake_up(struct sbitmap_queue *sbq)
> > > +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> > >  {
> > >  	struct sbq_wait_state *ws;
> > > -	unsigned int wake_batch;
> > > -	int wait_cnt;
> > > +	int wake_batch, wait_cnt, sub, cur;
> > >  
> > >  	ws = sbq_wake_ptr(sbq);
> > >  	if (!ws)
> > >  		return false;
> > >  
> > > -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > > +	wake_batch = READ_ONCE(sbq->wake_batch);
> > > +	do {
> > > +		cur = atomic_read(&ws->wait_cnt);
> > 
> > I think the above statement is not needed if we use atomic_try_cmpxchg
> > as the old value is updated in that function itself.
> > https://docs.kernel.org/staging/index.html?highlight=atomic_try_cmpxchg#atomic-types
> 
> I mean after moving the cur = atomic_read(..) above the do statement:
> 
> wake_batch = READ_ONCE(sbq->wake_batch);
> cur = atomic_read(&ws->wait_cnt);
> do {
> 	sub = min3(wake_batch, *nr, cur);
> 	wait_cnt = cur - sub;
> } while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));

Yeah, that's a good change. I'll fix it up.
