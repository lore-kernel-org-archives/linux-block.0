Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE0CC28D13
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 11:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiHYLzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiHYLzM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 07:55:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D192A260F
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 04:55:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so22194194lfg.10
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FfcOGEitlO1+VQU3Fkt40mgpPYh0aS/XS4OzrarjZWY=;
        b=YP8BXqIDz4FHk5I/P6OFRmLfnmAxmjh2ANz/mu2x1jmfIMQTmLpPcYxpNjq01ttb+E
         p0z+bpOQDg0GBKssTxzJLqaK8oyIcnZEHUad9X2NE1jnECS88d2SfIbK8HHHDCq8bo27
         7kOMwba1NR/pBl/1VFnEcj1oNeM3djw4aiOdDV/8xcj2h5YoxyjI0BcTNduzkrNBrCMx
         xkflIuU93XGansAaaJgBHh6qVGGXJgkVowx3SB4/QbFqxt6ZKBh2gmpqqyXHY1PYaJ0O
         BDo1IhdCumtsP37ZO6h7vzmN+3FqhG3GHQEzOMgzN4O6NGE9enb5cWmhVoV2s7COJRYt
         p9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FfcOGEitlO1+VQU3Fkt40mgpPYh0aS/XS4OzrarjZWY=;
        b=zCu03kVFhZHS17W3RBiQAQe0VBHGHfn2NQh/1V3Va5FHRGmLCQtnV8aDPsL7SmGJ3N
         dxofBFknmyP6mrBi+pDJg4M0+fpUnjes1fWusAk+/+W2qaCfmzPkBkbppxb5DokuRrac
         KGCKDVp4qVAxj20bKXg37YHhaXN2b1Hd/wrLROGc64s1Q2QMMYlnb3pgF8l2IEp39EGO
         XkqgYe9OH56rZToxfT3PGbM7MblOOYC6XjDQJggzrclbMMEQCXmrwYITnzgQdxu2Lwsi
         014ByGs1Do81mdm5Qy304OU4F4BlH1FI5YF8AyDoxKzykcdZ1Ubyx8WtkwkhYVGXigeZ
         kaOQ==
X-Gm-Message-State: ACgBeo3N7MtHFaWqRXAsplfBYrQ0GoTwntaDgXz6jKvsD+eHHcxZTtaq
        xfl+u5k2Rj3S3BGlZh4FppQ=
X-Google-Smtp-Source: AA6agR411kAkwEh29lG75CfMR95XCZoSa1SwdvQdBzbfRaR2acdWrqx3gpkMNciNmoF7qM1hHLfoVQ==
X-Received: by 2002:a05:6512:3fa9:b0:492:d799:1038 with SMTP id x41-20020a0565123fa900b00492d7991038mr1066058lfa.574.1661428508894;
        Thu, 25 Aug 2022 04:55:08 -0700 (PDT)
Received: from localhost (87-49-45-210-mobile.dk.customer.tdc.net. [87.49.45.210])
        by smtp.gmail.com with ESMTPSA id o13-20020ac25b8d000000b0048af4dc964asm464973lfn.73.2022.08.25.04.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:55:08 -0700 (PDT)
Date:   Thu, 25 Aug 2022 13:55:06 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv2] sbitmap: fix batched wait_cnt accounting
Message-ID: <20220825115506.nfwycdjkudwrob3q@quentin>
References: <20220824201440.127782-1-kbusch@fb.com>
 <20220825114807.v5pjnkvtfttlsiv4@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825114807.v5pjnkvtfttlsiv4@quentin>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 01:48:43PM +0200, Pankaj Raghav wrote:
> On Wed, Aug 24, 2022 at 01:14:40PM -0700, Keith Busch wrote:
> >  
> > -static bool __sbq_wake_up(struct sbitmap_queue *sbq)
> > +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> >  {
> >  	struct sbq_wait_state *ws;
> > -	unsigned int wake_batch;
> > -	int wait_cnt;
> > +	int wake_batch, wait_cnt, sub, cur;
> >  
> >  	ws = sbq_wake_ptr(sbq);
> >  	if (!ws)
> >  		return false;
> >  
> > -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > +	wake_batch = READ_ONCE(sbq->wake_batch);
> > +	do {
> > +		cur = atomic_read(&ws->wait_cnt);
> 
> I think the above statement is not needed if we use atomic_try_cmpxchg
> as the old value is updated in that function itself.
> https://docs.kernel.org/staging/index.html?highlight=atomic_try_cmpxchg#atomic-types

I mean after moving the cur = atomic_read(..) above the do statement:

wake_batch = READ_ONCE(sbq->wake_batch);
cur = atomic_read(&ws->wait_cnt);
do {
	sub = min3(wake_batch, *nr, cur);
	wait_cnt = cur - sub;
} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));

-- 
Pankaj Raghav
