Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308F4343F6;
	Tue, 21 Jul 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619412; cv=none; b=NPOZwxvjWpoOvF9JxKHxcrp+Bf/iRDzIsWqMJNGFPOE2A7kT9pmaIGaIVbML5KsliF0XZowQ9RcLvwuZkVf2faNwGQdRpi39tObxswuyXX6At+7iCBlp1HaL3mgcsfhm0D58hNuhZFbvbqVxSx1IIokciY+kzUI9oazJZvGsuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619412; c=relaxed/simple;
	bh=F47weG6e1BxbQ/dVQCjF6IARUH+uXf6FzCwg9QpWJHI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TS6/N/0+ng4IC/0V+Berp1deig9knn7j/W+LQR2Yk6BwsKj7EwccbtX8TPd+S/LO5QefzUaw3WvgfVf6FFiSvc5/C5Xv9MnqHynD0GnOLLC0CerZoupjH4Hjh3GdTqEymdbTMzrb5n9+exvR6XMfH3mplm7z6+EBjjv+QxgxsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjnA8X2a; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjnA8X2a"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 578EB1D000A7;
	Tue, 21 Jul 2026 03:36:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 03:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784619410; x=1784705810; bh=lSwJZMiSKbqpzvpo5wfNjkMKW8EYzp/fzyp
	SgJRZbqg=; b=CjnA8X2a6wkL7skZY4Bo9zAugOFX7uIN81SiOOvIBeFvPSbET14
	vqKZVPSQRWtBO4odUBdgFOej8G5bayIC7ew5efrhuh9K3B5m1jXsQ1uHxqs/IkUX
	MBphUsIRJRrwpJmB6PWDnNjY3Wn2YcgOPoRGg2ZtjV0OvVG2YV2lka7UhE+3aaTp
	zjyI/G8E6IkcTMeayJTAsWclljlXOD64B/QXoLkclGzWADGqAAThEmLwy0UUW40O
	tH0l3dDL2i7TaIaV9w7MLGIJnVrQJkkXKC+YgflmCdPt/lnLR0/mrTSyWSgLOgBg
	l9lheGuHWO9NV8+zRcO3t+PrmAiop7Mt+rg==
X-ME-Sender: <xms:kSFfajeCS_B58f197yYrtaQuHNJ8dZpvaSUT3a027JAnNgnegfcRng>
    <xme:kSFfajQ7JTYjeSiEgC-qYNfZy50eMsq3LmMzNmCPVzIwFV_rsf7x2ccS6zjFwhycG
    _VaqmH20ZhRvv2pr6Uc_XSyaFIhrBduMuX1DYau9TthfErF-RhLPg>
X-ME-Received: <xmr:kSFfasZI1aDq6Zfw7O5P3arWSrJDqqPELBB5a6iO9ZjvyJlB6CE1hm-aZpOg7FG8F6Sv5_rBCrZ3t1s1gWHxKTe8Lk5vKAlNeic>
X-ME-Proxy-Cause: dmFkZTGgfcY6chZznXL3B8kv5/pX5z9JdlAiM+ZdIrJqtjqbvJYVZD0BGQ7Vt1nGtnCXo4
    DM0jeF4uHS5nBjsXb0F0yanVcalOhcc1hLLlYlyAk0dssmLwXi5/zrR1J5T6WROmTZsuFQ
    /5TlB8Ah/X7paAlVzpUbJZxc1aCH5MunHErW9JAKlBLKs/coItLlqVlGJXu/n7cz7ifKiP
    FQCAjA3z/+RM5Ns9dT7J6yEmReo456/Poxk2c9I0mLI6BkW3vHEUKklfONdq3RHap9CPxL
    rU4nyZfBIIblwUHD61OD5YZ1dCOwTUto5BeolSw9FX6QpT81TmXRVOFH0i/SUBl8upKXVD
    zOz7MvzuG2G669rDzLQstryKhPAJE1elSvL3QZX4lK1stVYrQaKuiuSy/D4PLvLEj7GmIu
    7Iv/wP+5roRlgIwN2B5fREPLZzoFCK5UPuY8m938AvufUKgzIK0NHRwQ/Do9Xr/5o3CQMe
    ZRm2X2QIhWGHpWZXoJshT/W0NXov3PA1sbj+gs7BxGPjcELdbnbVyhnQthqW/WYCNBobCb
    UkCcSgJ+wE07PWKyDGyq1LP4RfSd0kmE9v04JT6e7TuC2Ps9JXH/NbdYCK+ORti9pxl5KU
    OQ/fyuBzsGU7W0ehiadBWw4RzDDIHRM3Q8RAdIFk/sg5wMTaTFm12SxwW+BA
X-ME-Proxy: <xmx:kSFfamfbInN__kl6C1WAll8mudW6Yi-2HDERWSx8GflOkpEXDtiFIA>
    <xmx:kSFfatKydn83u9_k-ukf05nC_0qODHmaV4R_Bx9_pgr7UxBzKecPzw>
    <xmx:kSFfajLts1R742mm4Ui4IDa0RVzfbmXavGPrQYfCiVnNj2y1d-3dLA>
    <xmx:kSFfasV4DeYyeXkl2bMcs0CU5m9ALXxv_YnB7lnHRJmPQ3G_x32s2w>
    <xmx:kiFfaiNeb_tLX1D3rZV2oiQ_zUR8skBH6MZ7NMFz2lj_ClmDLdmH4u5p>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:36:48 -0400 (EDT)
Date: Tue, 21 Jul 2026 17:37:04 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Laurent Vivier <laurent@vivier.eu>
cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/31] swim: Assert strobe with stable outputs
In-Reply-To: <e4544f42-df6d-49b7-96ab-f0235ff67f7c@vivier.eu>
Message-ID: <d4e1e9c9-5649-d27a-8893-87a22c4f81e1@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org> <998aeb6ae4536503516df34ae38709835c61c8cb.1784196135.git.fthain@linux-m68k.org> <c71fd9de-6379-4d45-9443-b3036aab889b@vivier.eu> <cd820359-cdd4-de54-d397-54094f6571ca@linux-m68k.org>
 <e4544f42-df6d-49b7-96ab-f0235ff67f7c@vivier.eu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=83233281352656579178461942438

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--83233281352656579178461942438
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Tue, 21 Jul 2026, Laurent Vivier wrote:

> Le 21/07/2026 =C3=A0 07:41, Finn Thain a =C3=A9crit=C2=A0:
> >=20
> > On Mon, 20 Jul 2026, Laurent Vivier wrote:
> >=20
> >> Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> >>
> >>> Keep the four phase pin directions set to output and hold their level=
s
> >>> constant during LSTRB signalling.
> >>
> >> Perhaps you can also add a short comment to describe the changes you
> >> made to the defines.
> >>
> >=20
> > Can you clarify please? I think what you're asking is, shouldn't the PH=
3
> > pin be an input when it's not being used for LSTRB signalling?
>=20
> My question is simpler:
> You added the directions bits in the defines and it's not clear in the co=
mmit
> message.
> For instance, I can see you update all the defines, but at first glance I
> didn't understand why.
>=20

OK -- I see what you mean. It might be more idiomatic and more readable if=
=20
the the pin direction nybble were defined in a separate macro rather than=
=20
baked into every macro definition. E.g. #define PHASE_PIN_DIRECTION 0xF0
The writes to the phase register would then get a bitwise OR with this new=
=20
macro. Would that work for you?
--83233281352656579178461942438--
