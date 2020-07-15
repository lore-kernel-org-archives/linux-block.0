Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F611C433E1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECEB20658
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=seas-upenn-edu.20150623.gappssmtp.com header.i=@seas-upenn-edu.20150623.gappssmtp.com header.b="CiWkOA92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgGOPuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgGOPuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 11:50:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37BBC061755
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 08:50:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b25so2069477qto.2
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seas-upenn-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=br4dNMr1BfeckqthKTUuXQUh0U9JhhSK+KDy6h7SFt8=;
        b=CiWkOA92iOlSxEKxxYGTq1DY6iAzCOf71aC51LEbdm79guZozMC9Cuenxm++CyGphJ
         VaCEPdRQra8NdjQ91QIcFFBY1bHDtlS81mrKHAo1cZGQd8u43SugAzdOO55LaiYvBFVZ
         4qWotY0+5j8BSgGbDUMxLiG6XaOvKc7QE63mUggfr8bkDw8zxzGA8B+BGxP906yutR0y
         LNGrmyzXS9pAyWAPLELRjRhsITP3YtGehdI+l8DVK4Y9DXFYWhiozkCcOfOMDvgrzlxK
         o0q2gefrT16ptxQgHi2rx9vFV0D2BkXL8rdN27vsf2PurlYIB9TS8/MLwBzk0NR7MzO9
         Yvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=br4dNMr1BfeckqthKTUuXQUh0U9JhhSK+KDy6h7SFt8=;
        b=HBdZavCT4zKf9JAa2R1wmQzR1QzPq+TNKRKCrPaxfzVG4mvYDUM2c5BoVxdicdhPsZ
         05s0ILKdHJv60PfOMjwwi6HTF8OqppOrhGPRmLXcCws3aDZvIJ9vcB70g7zLEIh3aWHU
         V8OzN3oUVrQ9By8oRQc95ZeGHrxMb+yl2u0PF8OgtGJj6yky5bak5LKlL1k3z00bjBd2
         QuNeRnGxTItEEd/JSfJXiCHCJ61cQ6QpqSBXjZkazoyTLz3qn2z5Nf6uz9f6DAEGp21q
         RUZrdeWZhEnbalHSC5Hw84oUj/aA+HA3VgONilUBNQsMkxo1koG4H1y3Oe5RGakYVm5p
         UToQ==
X-Gm-Message-State: AOAM531aKPqLa4NVcjY8H8LpyveojKVgPJ2L4iy7Pw9Wd0FFXupjjPJa
        zQ1gpJRt2jAMjEU3T/EMNEIrNg==
X-Google-Smtp-Source: ABdhPJxq4PE6FT0NlCMxmJyniDV9V4j6/G7aCgY6zqYO+GUkGnW8qYwZuW22CLCPzeE/v4Jx1kqyag==
X-Received: by 2002:ac8:87d:: with SMTP id x58mr440306qth.28.1594828249646;
        Wed, 15 Jul 2020 08:50:49 -0700 (PDT)
Received: from tsukihi.fios-router.home (pool-98-114-65-2.phlapa.fios.verizon.net. [98.114.65.2])
        by smtp.gmail.com with ESMTPSA id m20sm2681644qkk.104.2020.07.15.08.50.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:50:49 -0700 (PDT)
From:   Ziyang Li <liby99@seas.upenn.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3645.0.6.2.4\))
Subject: Possible bug in block/bounce.c
Message-Id: <1CEFBFC5-7B0D-4F92-BE37-013CFDEC9F5B@seas.upenn.edu>
Date:   Wed, 15 Jul 2020 11:50:46 -0400
To:     axboe@kernel.dk, linux-block@vger.kernel.org
X-Mailer: Apple Mail (2.3645.0.6.2.4)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all:

I hope this is the right place to ask about a potential bug in bounce.c. =
So on line 329 we assign the result of `mempool_alloc` to `to->bv_page` =
but we never check if `to->bv_page` is a valid pointer, also given that =
this variable is dereferenced in inc_zone_page_state. I wonder if we =
should add something like `if (to->bv_page =3D=3D null)` here?

329: to->bv_page =3D mempool_alloc(pool, q->bounce_gfp);
330: inc_zone_page_state(to->bv_page, NR_BOUNCE);

Best,
Ziyang=
