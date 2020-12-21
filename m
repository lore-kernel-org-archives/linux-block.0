Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3539C433E6
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 11:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7B20757
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 11:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgLULEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 06:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgLULEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 06:04:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAEC061285;
        Mon, 21 Dec 2020 03:04:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c79so6271239pfc.2;
        Mon, 21 Dec 2020 03:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m4RXLnH7YBILbODpuDyfo9E1AOFVv93WhdclcHi3eRM=;
        b=mA4rkZ2mW5ilVtJlHTLxyUJbz4DtMizPCLvCnvGrHm7XoPsPZE3HcUISa+DINhe1cX
         VnYcPtgRrVmlD6iNUktCM9CvhFg9hFAd2+NL7spFpNLgaisQkXQoLUa7nGIHVPR+fLpN
         2I17vlr0JuScYxcSiGi7rInpQQyijOiIzaxI1+JQAQKmHHDxFUhD5SvuVRafD4MnaZjZ
         t+INoEhNht+H8bbDqe5ZGkOUwFQsAaOgVpDusW+3UvbbW2dXhteuIdvNxb1BJcVLbT9p
         vjMw8oeCMmbo4M6zu3eUhnpqj05Y8DMRrEtXs18/xyx62faIELK50YvCt56IRRchkFkj
         VxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4RXLnH7YBILbODpuDyfo9E1AOFVv93WhdclcHi3eRM=;
        b=WnlMOqHLZ6C8jQ/pOjT4lqV2GNqdcfx9quoEABklUrqcSSCn+aw7PEngGsrClxGlyE
         ZBVbak6RBHqWJyKBSlBGJiPV1o7GJHwUok1PJ9ynWv9sCt1e0y83UNAnl4DelNoT24uf
         FYbiwIXJ3ca2kXrdB4VedY1v9QoWX/8fNXjLpDPn2ScQAutXJlS8lIdi/OEuSR6mXFW+
         QReYFc3G8Jr3n2SrbDt561Axe/QVVVkMq2vwE2GMHFqQVRFl/ejAbbvbF1uDtCeqHEMc
         a31rRtMXCavPiG9axJJNnt6fz0ukIqotocxWoifX/E9MnN5MKAeZja0xH78nzo1wkqfk
         mTGw==
X-Gm-Message-State: AOAM530IWm/qifT1tRWRUQ3yPAzGcP28SI47LkmPF4nn/ZZziZHCoCCR
        DmCTHPuJnDIOx9bdqEfM2TjcKqEz6Y5fOw==
X-Google-Smtp-Source: ABdhPJxfsK/TKyeT0KVqf2ULDbwG5cq5edfGnp7+WRd1iwL7NlFlagqlJMZ9LY5DQLObCcAUtGM3gQ==
X-Received: by 2002:a62:1ccb:0:b029:1ad:8138:dc42 with SMTP id c194-20020a621ccb0000b02901ad8138dc42mr6727056pfc.0.1608548645079;
        Mon, 21 Dec 2020 03:04:05 -0800 (PST)
Received: from localhost ([103.248.31.152])
        by smtp.gmail.com with ESMTPSA id 84sm16889194pfy.9.2020.12.21.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:04:04 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:33:56 +0530
From:   'Amey Narkhede' <ameynarkhede03@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: aoe: replace use of __constant_htons to htons
Message-ID: <20201221110356.6x2h2ip6o3hlwztd@archlinux>
References: <20201220164625.94105-1-ameynarkhede03@gmail.com>
 <d708db73308747feb0484287a09c443e@AcuMS.aculab.com>
 <20201220202019.j7x64yahapgilr7u@archlinux>
 <c5df63bdc5a94ebdac9505a64f2cece5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pglt4qwsfzwfhuk6"
Content-Disposition: inline
In-Reply-To: <c5df63bdc5a94ebdac9505a64f2cece5@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--pglt4qwsfzwfhuk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20/12/21 09:23AM, David Laight wrote:
> From: 'Amey Narkhede' <ameynarkhede03@gmail.com>
> > Sent: 20 December 2020 20:20
> > To: David Laight <David.Laight@ACULAB.COM>
> > Subject: Re: [PATCH] block: aoe: replace use of __constant_htons to htons
> >
> > On 20/12/20 07:35PM, David Laight wrote:
> > > From: Amey Narkhede
> > > > Sent: 20 December 2020 16:46
> > > >
> > > > The macro htons expands to __swab16 which has special
> > > > case for constants in little endian case. In big
> > > > endian case both __constant_htons and htons macros
> > > > expand to the same code. So, replace __constant_htons
> > > > with htons to get rid of the definition of __constant_htons
> > > > completely.
> > > >
> > > ...
> > > >  static struct packet_type aoe_pt __read_mostly = {
> > > > -	.type = __constant_htons(ETH_P_AOE),
> > > > +	.type = htons(ETH_P_AOE),
> > > >  	.func = aoenet_rcv,
> > >
> > > Does this cause grief if someone is doing a COMPILE_TEST on LE?
> > >
> > > 	David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> > >
> > I did COMPILE_TEST on my x86_64 machine and it compiled
> > without any problems.
> > I assume that was the point or am I missing
> > something? I'm a beginner contributor so please
> > let me know if there any mistakes.
>
> It depends on exactly how the bswap functions are defined.
>
> You can't have anything that contains a function call (or asm) for a
> static initialiser or case label.
> The bswap functions have used the builtin_constant() check to switch
> between an asm block and C expression.
> So the C expression is used for constants - so evaluated by the compiler,
> and the asm for variables.
> Last I looked this wasn't valid for initialisers - so the __constant_bswap()
> exists for these cases.
>
> Now, it might be that, on more recent gcc __builtin_bswap() is used.
> This might be valid for constants in initialisers.
> Whether the same is true for CLANG is another issue.
>
> Basically it is all complex and partially historic.
>
> So you may need to use __constant_htons() for initialisers
> and case labels.
> For constants in code it doesn't matter whether you use the __constant form.
> For variables in code the __constant form is likely to generate horrid code.
>
> FWIW you'll get more credit for finding real bugs than stylistic changes.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
Thanks for thee detail explanation.
Actually I was submitting stylistic changes to get
familiar with email and patch based workflows

Amey

--pglt4qwsfzwfhuk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAl/ggRwACgkQBBTsy/Z3
yzYPmAgAj9feO9UUbbeCG7DTkaIBhNMpNLZKvL43vcz3WGtDjxYzYPtobHwJWPAE
bbMcHYGtAgulWogYVNHW5YDHufc1C/0I/mvtobDOyuaVzw8dC8h8VA7kVwnZV+uZ
2mHoEa4dQZlPjo4JcfV0OO1RGqGGO5GRQ5fke+QzELm75DIx2/1qAIUz1lXvLsMQ
yCTOIk0Brrce1o9tRvoXzwha+c3QXVxjsQyN3K5296v01FgTkk0DOkvNl/X4lDWJ
+rwaH0XJu8Gz5i0dGNa+gcl3IlhezAQXVq98sKMrx/0zZgBaiGZDZCRg43UWJnWD
0SxEi4heFn70eTAh+ESp2l/FUa4lTA==
=HrGu
-----END PGP SIGNATURE-----

--pglt4qwsfzwfhuk6--
