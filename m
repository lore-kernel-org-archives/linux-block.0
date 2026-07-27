Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496481DDC2B;
	Mon, 27 Jul 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112193; cv=none; b=ShcRs0JBuVPlUgE+LBoO49PjoDkT4teQWIddmu0sQievuMUllOVsyG0Kt6/tJuUHwEakFA9N35WSkWiQW0tokQJOMQUzaoPt87OXRdTBKTevO57gLDlaoY2Hkdo7YTUIhP22wLyhFdxjK+jC6bE089lRixgiKyGw0xX1Lp6FSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112193; c=relaxed/simple;
	bh=d3aLd2e1hu6klT2+8+/tT4xJrR8Y67BauQMMELIkhcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nch1o1xRtyRDTqdexaImCXo63g6H+gE/tAGTs69sR2+k6rwDEQgc+DEmRvD4B8XkoYtce8nIWnsNs7R0ztsIlrP6SOFSpxOb+X/CNFGSmOQ/e687lQWCW+4jpcdtUTtGLagmxYihSzHkL7e9YD1cr1stpoRLLh6q4NERyn4k1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S0ynm5JJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0ynm5JJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 76AEE1D000E6;
	Sun, 26 Jul 2026 20:29:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 26 Jul 2026 20:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785112190; x=1785198590; bh=F+SnelrTMU3bHo/TLv6ikqMlxzEuzwB/P/m
	d9GJlbxA=; b=S0ynm5JJIm3NOSoh8xNXD3TeTMlw+OkbkEPjCh+W7UjV1a/VATd
	7gPpPehj0D2j/Pu+nq9YAcRLOPttIfWM6PgR0e8dQ2KpXfMkeVXVnIPmYYlYMvTf
	xNOLkTOxlLFcGriJCCkMGU4Rb/rt2YK8bA3iUvPuq1WcyIU3mtkTErCc4d4V0BkP
	7m6ug1laNFgIfYT/Lka8M1keQnLHCyAJQqNfWLg6EvnlyII9NSUiHveAUVnT2L2w
	+DnFmx966IgapULvagNv51KooSYWTEMGFVt0SQ9kORH7bzE6dG+Yym5Zvkk5/AJS
	2puMxPG1bwad2OLM++KZlSOcENj/lbjtNZg==
X-ME-Sender: <xms:faZmak5edH3hrT1jJcKTy7DS2k5xWoVwm5zhTjs9UnRK16hH4NIHCQ>
    <xme:faZmav-ae93nGYFCO6p4Jkk23fkBsCGAKSpdXd3Z4vTAE8HC4OLb0wFLNa3-xseZc
    z8N4jjgEfTsjV2Cb0zlE9Zaoh8VBRAKy6egKMaDgNG7NgdniEZ1mw>
X-ME-Received: <xmr:faZmajV00NMLY2NviJHWLIiyo6Zvzu-MvAtISjTucYHzwBKoGzeA3cccE2hT>
X-ME-Proxy-Cause: dmFkZTEOfa8u3QkVny6+TSQ1cVtGrCqeoPpgYAAmbUuyaUuQShhb1QnLegzPY/+0tw+tFP
    0uQ2HzUFo4uZyUz7oLR/1Ug9lNCiBzetK3d/FdyV6FL66qePSK9bc/NuoPizjf3w3MKaDd
    fpXmbPVchP0ejyEr8+haLI8aEclLHyKKaCLRxT6cuxeaFF8KjCIqGMnh2F0oI2FUcK78Ab
    W5S9HRXzJwQ/QLvuVlqpipZ7X+juF1/hqwu6bh6D+qMuUXxuCUde9cOi/qRJ4xsEqaJ3jN
    9XxacdF1A5eU+wPIt6wMCZrXODS4aPEp2MSc+c/ELF1SbP096LBv3fwiQshctNDZI/lmsc
    OAw+W1mf+RFw7KUNcqx87zl8xEblJA8SI0lVax9aRdUD0/NstQZ1Oc2168ZVespz+LEe/+
    a9zJw/7YrKjJWygqq32Nozr3udu3E8bb8+RGGbzAruvgVqIvfhx1UOFJ2twEa6QvYVB7Jr
    cWo1Vni+lL29fT7V3XZZH+s8cXA+XjyKuZvwTf7Ck2TLcJVRPPvq2/+6iavBpZW4ttL02x
    Qj2f/v9POiAA39SHMxgl+9kYHssqpWPnsTEe/zFVkCXfR64h17Ut8My90yq7OxILJvK76X
    mIV4E+Xoq49Xx6tZyIDjG1T3aIt1sRdJOvSHkMEj03GSn8C5csZg+5KReveQ
X-ME-Proxy: <xmx:faZmaqoTbh12p9AVBIMfvWxigg07ohYw5rEC47wXg7vBS3n4wkM5VQ>
    <xmx:faZmalnZzY2PjPGy1G-45ay__AosW-aR0dj6a5NOnGyavEebbRI1mQ>
    <xmx:faZmaq2e4FJUybDcS8JCmH9l17TD8NL0jEbhJCTPiPlPH3kmMevNGw>
    <xmx:faZmaiSM7Y1_HxWNdgq2CNZGEghyiqbU5yS2zg6dXJW1572pdrrVRQ>
    <xmx:fqZmavnQ7bmXJ_Ath2_Jm1Wd4AJSz9Fy_ZxynxXQt-QB5YpI6slpC4zq>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 20:29:47 -0400 (EDT)
Date: Mon, 27 Jul 2026 10:30:06 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Laurent Vivier <laurent@vivier.eu>
cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/31] swim: Don't needlessly re-read sectors
In-Reply-To: <34364739-9153-4538-aed3-7c71860bdf08@vivier.eu>
Message-ID: <b5bf2f3f-d332-8d3f-1d73-ba40e411044b@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org> <740e314f4ff30796afa466c6a3d8cfa42e9b1af8.1784196135.git.fthain@linux-m68k.org> <34364739-9153-4538-aed3-7c71860bdf08@vivier.eu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sun, 26 Jul 2026, Laurent Vivier wrote:

> >    swim_drive(base, fs->location);
> >    swim_READY_timeout(base);
> >   -	for (i = req_sector; i < req_sector + sectors_nb; i++) {
> > -		int x;
> > -		track = i / fs->secpercyl;
> > -		x = i % fs->secpercyl;
> > -		side = x / fs->secpertrack;
> > -		sector = x % fs->secpertrack + 1;
> > -
> > -		try = 5;
> > -		do {
> > -			ret = swim_read_sector(fs, side, track, sector,
> > -						buffer);
> > -			if (try-- == 0)
> > -				return BLK_STS_IOERR;
> > -		} while (ret != 512);
> > -
> > -		buffer += ret;
> > +	while (sectors_nb) {
> > +		unsigned int cyl, x, head, sector, n, ret;
> > +
> > +		cyl = req_sector / fs->secpercyl;
> > +		x = req_sector % fs->secpercyl;
> > +		head = (x >= fs->secpertrack) ? 1 : 0;
> > +		sector = x % fs->secpertrack;
> > +		n = min(sectors_nb, fs->secpertrack - sector);
> > +
> > +		swim_track(fs, cyl);
> > +		swim_head(base, head);
> > +
> > +		ret = swim_read_sector_range(fs, head, cyl, sector + 1, n,
> > buffer);
> > +		if (ret != n)
> > +			++failures;
> > +		if (failures >= 5)
> > +			return BLK_STS_IOERR;
> 
> Old code failed after 5 retries on the same sector, new code fails after 
> 5 incomplete ranges anywhere in it, even if earlier errors were 
> recovered and request made progress.
> 
> Is this what you want?
> 

No, it was an oversight. I've since revised this so that the failure 
counter is only incremented when there is no progress and gets reset when 
we proceeed to the next sector range on the next track.
