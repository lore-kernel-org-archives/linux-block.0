Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22C379C55;
	Tue, 21 Jul 2026 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612490; cv=none; b=poYMm5m1V7Ch5zikg5lGttOYkLSbgaQWZR+MoUI3woOTWBVgGKOK3bgJErcvRzpVwQtVWaJ5/F3+OErhhh+Ay7QiNvIhPSrNb4qnL4zgm2Dlbob+4RYzzNdCXA4f1Yp4GDJRXAM+h5IwHKG5XjkDLRvrU/47gqqtT/Ti5snt0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612490; c=relaxed/simple;
	bh=Vh+U6JLSvtEdR8WATfUbuB+HHgdDf1CQDsLw9THJWbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OcJ/GfC8+P6mpYc5FkGAzjFcnFa8seREe/m0VGUScYPKJkGzUcLzSVGQ1LIh8AxbGcQO+4OrkIsNwNEbGJ2Mgsuo4AQa46odpMvylpI8XNasvzO8kfk4zc1bYBXGgeAATUQATst8cV2u5I8D7AUH1jRzD6T4gFsYlsTvBUP2FKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ikV6X/NM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ikV6X/NM"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 88685EC018D;
	Tue, 21 Jul 2026 01:41:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 21 Jul 2026 01:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784612486; x=1784698886; bh=VLCB2DVP9ByWy2L8v0TkNg7rwkRF4Ihf98h
	D2z56m/Y=; b=ikV6X/NM5p+Tep/coX/4NIdG2NI6wDsDIQICscM3rHvR7XiqJe0
	u6UaaE7FpHZf5a72/LEazEenaz4TMqhlWsomxTI/UGUtOEN/V7TQI8bYy7vQ29kZ
	WOBKVrP0TxNhgcw4JGX/tCluoH4FxMY05NEbkTSEteREOs20DqT/vW3IRA53wHhR
	98qbL8DdUoY7KOAg8Yt0ThGwk77SDomGx0+DSBkXF1tiYQAn6qMUB8LDt0nVS17C
	Lkm+DD9mOXeM9FnhG6J677gojtQaGpAIJkskVNaBnPh34abpoYJ/VcL7v3MBsMqY
	+HteuTuT+XDFtQ5zBM/FkMwko6pLCe1WXVg==
X-ME-Sender: <xms:hQZfatCqVVoXwDZNRUtztMjtcR4Imu5PKB_lHFNKpa60LcxndJgLaA>
    <xme:hQZfaln6_ZdYUuMv-UL2M1PhRX_TiGx0qcm5gEXM07f-cGdX9RN9nZj12VnFbQVt7
    ZPgokTs6l9eSaxRAEZ4xN1a1TtQ0_2v40A_pBXZ3NnxRiPXKRzNncE>
X-ME-Received: <xmr:hQZfaofp9VFtA0XWXcUp4-b4YBqrNjduwRcZS692n6FdmAgHrJ52yukouvT18lA11BNmeerTBiQ-_spQDvAf5Kokwmaz8Qa0ge0>
X-ME-Proxy-Cause: dmFkZTFFciaP0ZRRztuGf6MZJnolj8rNJ/UrnbkRDtJ6bNBWVnZKVBntNDlEuKNPdjS7CF
    ZGEu8CVAHKDd/L115XOt9GdlBGzMQNemVt+t3rPzSRqcKlCyWR7xdbTUChfZsVTHnBI5RW
    fLCeK4paByH6z5hNbeNSYhu3ka5c3L31HGaZBVZsWVjbL+vFGJFzyuvUE/rbRsiT4qR3No
    DbrW5Od6q1OzVWQHKm7XtlIh75NvoSKpsGak3tBijFv+WMOLp1FgZX6Rh7abfmcer3wWUj
    pnFLRE/s4L2QdXfW18zVtc/xKA/9Hd87JEujnoHtZoBSlbHEsOmDIT09MXkop4RWLn7UWO
    dAG1aKP8tz/juXetVMGdPiPyQq7k6zLfOT/8w/JH7jMSgQ4lsev+pcTcwmSeHWZpOV2AX6
    avMn2u/0SGcM3a/OBp1Ofh91kWw27BZxQBjRrWh103A2ZhGbMQbIoPQ1kgMDg9SggcPfiW
    rsdFs69mluZeAmVMK7KXw5UA6vz2oijjZzVORwCIqqUHm90GYIidDuuCLTEIro9m75gUpK
    X7dLlD+wVFGVefK1tsnSlEusFZYx4zVbroi1YqA3MI8rnbwnuF9OYCDURc7ZPP9CNuayfO
    I/YnlkV0lFkyKCeruxH7B/EP+JH2Co/tvKCipI6nY3jKdBMCukvkLUiItnQg
X-ME-Proxy: <xmx:hQZfapSzYL4d5xtQ83fgFigx8aTzdI0VMg5fmdzH-D5R12PfgWIw3A>
    <xmx:hQZfavsrgGh1ExbKPchbF5Mh-FWC7z6svq5unl8S2mCV5oBdwNvB6Q>
    <xmx:hQZfaqdZY1AQ0aiwtcN6wzfacposmek-RMh7bATgc565T_C6r9IsJA>
    <xmx:hQZfapbECx2K8hFWxnB5O3a07UqT9Fim7tN11pyTOBB-YhKj6hmiag>
    <xmx:hgZfalzSH5cAuic7lzwVHNbcpVl7Jk3_370HdVPD2KK2IAevuOT-u2cM>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 01:41:22 -0400 (EDT)
Date: Tue, 21 Jul 2026 15:41:36 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Laurent Vivier <laurent@vivier.eu>
cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/31] swim: Assert strobe with stable outputs
In-Reply-To: <c71fd9de-6379-4d45-9443-b3036aab889b@vivier.eu>
Message-ID: <cd820359-cdd4-de54-d397-54094f6571ca@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org> <998aeb6ae4536503516df34ae38709835c61c8cb.1784196135.git.fthain@linux-m68k.org> <c71fd9de-6379-4d45-9443-b3036aab889b@vivier.eu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=83233281301483187178461245638

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--83233281301483187178461245638
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Mon, 20 Jul 2026, Laurent Vivier wrote:

> Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
>=20
> > Keep the four phase pin directions set to output and hold their levels=
=20
> > constant during LSTRB signalling.
>=20
> Perhaps you can also add a short comment to describe the changes you=20
> made to the defines.
>=20

Can you clarify please? I think what you're asking is, shouldn't the PH3=20
pin be an input when it's not being used for LSTRB signalling?

It would be nice if we had specs for the relevant FDD models, to show that=
=20
no FDD ever drives the phase lines. Then I could write something more=20
authoritative. I don't have that information but I do have the chip specs.

The swim3.c driver never sets phase pin direction because the SWIM3 chip=20
doesn't implement that i.e. the four phase pins are permanently outputs.=20
Similary, the programming model for the IWM chip offers no way to use=20
phase lines as inputs, AFAICT. Same for the uPD72070 FDC chip.

I will add some of these observations to the commit log or the commentary=
=20
in the source code if you think it would help.

Thanks for your review.
--83233281301483187178461245638--
