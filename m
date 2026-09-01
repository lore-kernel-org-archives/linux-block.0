Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593E46E01F;
	Tue,  1 Sep 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249396; cv=none; b=PrJDUjFwDqJDKw2yAidVPwyBSUWD+e9IK7/cvPFg+Hre5hCGa41RdAUR7FxMylvOMm+HvcDAaA0aXZ0gumFla/BvSh9likhlLg1Nxq2F0zsTO1ZPlBrwFnZnj4tb4QWHlZEyQ2kHSdYd5jcrGvOhsXthFrQIyrOUgzi1pYc8We0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249396; c=relaxed/simple;
	bh=nnqLushIJ9FXM4IqlhQfEoJBRo1HzMg1fpdsB2/rllk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EyujxxsLahtjZ6TsAGnIXM4oSBHogTDN/hI7+nkcWZXsh419VcYG24QqxIfmBeO3+zbSMhAj0BCkXGyqaYR2k7j02p+qHR6pkV07SlHPFXErBi2yeLEVD1q3Ai9i/Y+XgmaAA64OypcF1GJQUocrRTCu5VC7SHdYZyIw1U+yNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ov+QlCwT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ov+QlCwT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6362014000F5;
	Tue,  1 Sep 2026 03:56:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 03:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788249393; x=1788335793; bh=5DLQz4D4XG1gMTW77CwaiVr/i7cTEkZOBTB
	A8kcXN0E=; b=Ov+QlCwTbSdEqNzkn5ya9/tyEVlQKvIzWd7Qcpx1ia5DK9oa5Io
	MPJLLukvvFoDJiG1d3v3q5hKt/16QjnOq9ORTPjj3Q7wtKlJNVOWfyyv3x3HV5pq
	dZ522h51HPxaCrT1mO2RDfLwy/cCUp2CV6is46VSsqUB70tO2r0emoc+RkE1VqxX
	BRG+VKQ4IGLL5XSTEOCll8cNeynXxLCo2tjqq+5xWvQKX3oTKxn+UGbNV1Hf7wXR
	1wpL8F76aBExo4QVwAsUhaunkspM7SVcmwWoPkQlTUxRVHk9ptalNX+780L8IURp
	bGPEi7MPgh7O0YnH0GtTSsxcu/U85Q35TbA==
X-ME-Sender: <xms:MIWWak8epuKgSxM6YjeSJO4Vd-FIytSon8rmOvjxYiH0IRXhmGiWdw>
    <xme:MIWWamxBF4U8i12hFyY5ARd8ParGNmNkO8Qhxr1VseGBG03z67peXDgwfhtTtTaMl
    JeYE95O2WLve1iIoTRKxha_wttvKfNa2YIRt7jeRFEGaXqz8QRwA9Oi>
X-ME-Received: <xmr:MIWWap4-GPszMmU-Z6T91mrWQ73OODbHky4A0_ImQCCOtC8qY60KG-M3R6Z8ZR_zVmvPQqe64oZyXYsMrs100RSOicLPn-5CJGU>
X-ME-Proxy-Cause: dmFkZTFnHdl46V9iY7mt7ZU14BLrD9dGCxF5Iuya6z2uOhMxwB3MoPfi3YTm050+ngLUP6
    BCml/R3fYt1/eoRGwE5ZHXZ/79FnBk3P5UbU7qx1MhZhsvxctXFz3WF+Vzfomppa4Mjd+q
    VaIa/sNNOj0yDqWSo4BaM74QVhq4HEeNIF9j6sLhNc8W/28PnOFUHetkopaeOX/UNLpWEM
    58+DSSQDGH5qQYW5diunS6aSNjTv1ma5aoJPfbAx9k1L7GmcEzI1g5xp+ohwgD60mzweGW
    8Y+nDI8DWviG7Nuq0uuW+YrWztnnBszqcMLs8hDfe3SICXV8/bj0TzWZ+IaYwQWsHeXxh4
    baMcWyD98PDx7MQxBz3nS/meMRKQjJU79AhF92jPg0X7xColoqxpVKF+gfTya1DyUFxo0b
    5xh9WmaH3P1flpXEpTjOPMMHV30YF5LDUEOYl1zIQsNSOC+ra8evJNhrcrQgJxuxhZEBad
    Cddf+8u3hZq0hEvqg37ArAe1Wwe5TGOa0zf6hNIyo8NLa1OUK+UdNj53NgxevMggBt0U47
    cJcrUEDpRQQvo1Lz5nPgkYkP4XgppG7zP1TTPaiIUMRAq4O2Yp/oy0b7xKtvqYc7WWG4dc
    oHvxLpSzLc0gf3jRKFbDnpn/HgktJnu4FoLStWGZAL2uKwPG+8UyYpLvlCTg
X-ME-Proxy: <xmx:MIWWal-Ypf1GNruhgG4x7vln1933lPr4vzFjeQWxxhE6qJ0kMyUvtQ>
    <xmx:MIWWamr4hzOgwhfuh7xBtzpVZD200i7JF7Wmp6RKmln6Y__VfCUvHw>
    <xmx:MIWWauoetXxIq_c70ANdceJRHvDuBsw0MKuIjU9d6RHO2QGxHjPIlA>
    <xmx:MIWWah302mbwG5G4OSWcigSuct-wM_Cy8RNZNq0DGGkdvO_JHmnytw>
    <xmx:MYWWajup1qBfVR8Uv2pbFUIfSO9oMOzTyhouYSXxBgV1_PA9Knm_Nci9>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 03:56:29 -0400 (EDT)
Date: Tue, 1 Sep 2026 17:56:52 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <laurent@vivier.eu>, 
    Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/32] swim: Enable clock divider only where
 appropriate
In-Reply-To: <CAMuHMdXgtstGtcbRkrtKtQ+d1c=mCe5zgYZCx4dyUQ_YnVhbbw@mail.gmail.com>
Message-ID: <b0f20a10-78d4-e8e6-4001-99f076b99a8a@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org> <1e349506a7cc6aa574aacbd4c69c240b5a1e3eb8.1786929430.git.fthain@linux-m68k.org> <CAMuHMdXgtstGtcbRkrtKtQ+d1c=mCe5zgYZCx4dyUQ_YnVhbbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 31 Aug 2026, Geert Uytterhoeven wrote:

> On Mon, 17 Aug 2026 at 03:55, Finn Thain <fthain@linux-m68k.org> wrote:
> > Some models have a 16 MHz FCLK oscillator and others 32 MHz. Put this
> > information into the swim device platform_data so that the driver can
> > correctly enable the clock divider. When this is enabled incorrectly,
> > nothing can be read and failures from the Error Correction Machine are
> > flagged in the error register.
> >
> > This is chip initialization, so do this in swim_floppy_init() rather
> > than floppy_open(). Drop the udelay() which was apparently copied and
> > pasted from swim3.c, where it relates to interrupts (of which this chip
> > has none).
> 
> This move should be a separate patch.
> 

OK.

> > Cc: Joshua Thompson <funaho@jurai.org>
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> >  arch/m68k/mac/config.c | 31 ++++++++++++++++++++++++++++++-
> 
> For the m68k part:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > --- a/arch/m68k/mac/config.c
> > +++ b/arch/m68k/mac/config.c
> > @@ -984,8 +984,37 @@ static int __init mac_platform_init(void)
> >                         .start = swim_base,
> >                         .end   = swim_base + 0x1FFF,
> >                 };
> > +               unsigned int data = 0;
> 
> Nit: in the absence of a real platform_data structure, please use a
> more explanatory name.
> 
> Perhaps s/data/s_fclk/, and store S_FCLK_DIV2 or zero?
> Or s/data/setup/, and store the full register value?
> 

I looked again at this but I still can't see any uses for the other bits. 
So perhaps I should change it to:

+		bool fast_fclk = false;

> > --- a/drivers/block/swim.c
> > +++ b/drivers/block/swim.c
> 
> > @@ -807,8 +806,10 @@ static void swim_set_parameters(struct swim __iomem *base)
> >                 swim_write(base, parameter, mem[i]);
> >  }
> >
> > -static int swim_floppy_init(struct swim_priv *swd)
> > +static int swim_floppy_init(struct platform_device *pdev)
> >  {
> > +       struct swim_priv *swd = platform_get_drvdata(pdev);
> > +       unsigned int *data = pdev->dev.platform_data;
> 
> Likewise.
> 

... and change that to:

	bool *data = pdev->dev.platform_data;
	bool fast_fclk = data && *data;

I am unsure whether a NULL check is desirable here (?)

Interestingly, that NULL check itself is sufficient and so we don't really 
need the flag at all. Allocating memory for this bool is a completely 
pointless kmalloc.

> >         struct queue_limits lim = {
> >                 .features               = BLK_FEAT_ROTATIONAL,
> >         };
> > @@ -816,6 +817,8 @@ static int swim_floppy_init(struct swim_priv *swd)
> >         int drive;
> >         struct swim __iomem *base = swd->base;
> >
> > +       swim_write(base, setup, S_IBM_DRIVE | (*data ? S_FCLK_DIV2 : 0));
> > +

	swim_write(base, setup, S_IBM_DRIVE | (fast_fclk ? S_FCLK_DIV2 : 0));

Would the bool be more acceptable? TBH, I'm not sure it's an improvement.

Thanks for your review.

> >         swim_set_parameters(base);
> >
> >         /* scan floppy drives */
> 
