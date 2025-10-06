Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDA136672;
	Mon,  6 Oct 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755619; cv=none; b=lFgrK4VIkt2c/43bkmcqh+nooA1HWenfMwGJcupm1/KCNacVvJhQNDRTFlG/V6s6krwPnCxQGmA7xsxvy6+RhRC0KpHGqwuoRnQqDLX3QUO6rUiEHB56uHLfBYqJ3V64pkBMLdbmm9IRK0Qy2fo2jXSD7iEnudUek/8OyGhsBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755619; c=relaxed/simple;
	bh=O/0kdz6mh+GcVV2YvujWW3xiUtAfBi6ba5b8CMqtmsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6mnPXucGyo7dKTTD+0Ge4L32slNtQwZwTJ+acuJzzUB5YXPOgAwQpPPOQR3yppJUxXHUHbphWZ3eT0TrKCh+rA7bgIumGqiWZdAGGnctV8mhfpUd+gDDBuqy9L1GFyfQeLKX/x8ixPh+beL7WDEw6FoJl2zP45Ng7IxqY29xCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=j4iEMoTi; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="j4iEMoTi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=G7q8r7WVvz33AjjsS5wsY3k65LW9EjBm5kkIJSq5+cs=; t=1759755615;
	x=1760360415; b=j4iEMoTicsoTGcfjARepXalORStOWR9JxTa4apGrBx9kdULOFYpN0YLh41lzh
	h6aYG3FbkNEZA+JAHqLOVXCBhfdokgtrrQZy4zQbHWn4WdxG4gjQlivTgApO2ut5id+0wwitVsmdJ
	FA/+wRolntMbBXrCyIDwOXe12z4toAkCA0Ry4el5hwOe1xp9blPWO/T+vpET+GEvXUMN9e5q7v/fl
	4u6tRL7ZH0mVkmwdQnT3l+fvvMtGzqDv4ja1R7MgySIo6+iYY8NJkTCSurrTXk9QjH7gDg2x1lh8k
	gN5MSM4nCIZLTJvyG2QdDUqAhofzVAyvQbYjcZqT6gKqXDiRVg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5kp1-0000000022M-3dyF; Mon, 06 Oct 2025 15:00:11 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5kp1-000000034jx-2VsR; Mon, 06 Oct 2025 15:00:11 +0200
Message-ID: <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, "David S . Miller"
	 <davem@davemloft.net>, Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>, 	sparclinux@vger.kernel.org
Date: Mon, 06 Oct 2025 15:00:10 +0200
In-Reply-To: <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
	 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Jens,

On Mon, 2025-10-06 at 06:48 -0600, Jens Axboe wrote:
> When you apply this patch and things work, how many times does it
> generally spin where it would've failed before? It's a bit unnerving to
> have a never ending spin loop for this, with udelay spinning in between
> as well. Looking at vio_ldc_send() as well, that spins for potentially
> 1000 loops of 1usec each, which would be 1ms. With the current limit of
> 10 retries, the driver would end up doing udelays of:
>=20
> 1
> 2
> 4
> 8
> 16
> 32
> 64
> 128
> 128
> 128
>=20
> which is 511 usec on top, for 10.5ms in total spinning time before
> giving up. That is kind of mind boggling, that's an eternity.

The problem is that giving up can lead to filesystem corruption which
is problem that was never observed before the change from what I know.

We have deployed a kernel with the change reverted on several LDOMs that
are seeing heavy use such as cfarm202.cfarm.net and we have seen any system
lock ups or similar.

> Not that it's _really_ that important as this is a pretty niche driver,
> but still pretty ugly... Does it work reliably with a limit of 100
> spins? If things get truly stuck, spinning forever in that loop is not
> going to help. In any case, your patch should have

Isn't it possible that the call to vio_ldc_send() will eventually succeed
which is why there is no need to abort in __vdc_tx_trigger()?

And unlike the change in adddc32d6fde ("sunvnet: Do not spin in an infinite
loop when vio_ldc_send() returns EAGAIN"), we can't just drop data as this
driver concerns a block device while the other driver concerns a network
device. Dropping network packages is expected, dropping bytes from a block
device driver is not.

> Cc: stable@vger.kernel.org
> Fixes: a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop when vio_ld=
c_send() returns EAGAIN")
>=20
> tags added.

Will do.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
