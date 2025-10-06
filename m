Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4411287263;
	Mon,  6 Oct 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755789; cv=none; b=myVOuaKOjjMaBJxBfwBISseFlVJXj8menTqGFitznmBVUf6dosDZDwfYwJY7NV3esR++PN+AVmXmkjydYrlFHawRBD3nR3GQkvFnr+MAaKtNIVQXIQm5RthB800HnqkIf3eleCFlzuJsN4TVFpqOvMfRgsPYrdpq0zUHKWSpa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755789; c=relaxed/simple;
	bh=5TktbhUkLEsLDT4e1fFFS/V+VMcgDpsIlUMAXftgLB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWjA2L4xH7aySRH2ap9CMUCssqRaCnPIceUI1jajAc5Etyc+z30X3MlVO5pBE+pTNfzocLW15Jr76I9/46Tso2vL8kjo5/PqPlsiDG6UxLpCQBFZT78vdPtmnf6Q3HO0LJq6vs4/Asna5VvJSHX/KneeePuDPmgQ3gtEWPe81Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=F/m4/Z6j; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="F/m4/Z6j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CfHsi8A3J0D9gR3E0PqAq8z3w4edAZkkHh+11SELL1k=; t=1759755787;
	x=1760360587; b=F/m4/Z6jseX9aF+ZpMKZgfBGjGcODQNzvUQqKbj/D25qBr6B6DpFnZq1IcJBY
	Rr/7kovlN1GVAjsJaEy+kwLjxeht3s0+pTElMlEwc2mtqK6oatP1bl2Uh0YPtAxLctZ5f069QxFNL
	fexpTR/BKa5MejatrbrIgiWaGR/BhV/362SdKel6fKXRhNAFMbk8Y4MnivDqtyeVDeECaPihYJH+9
	fcWGh2b5Jq9mZ8JbRJ1Bcl3wIyV3wveJ5cXQD7iUyGobzMeQIB8z8jJcUgc5boeWETbGrEtFmfhGT
	sXLiErEMKVlAf+TKsKah/WyG/lFGN94xzxH/FIS/2remn6E6gg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5krm-000000003QM-29oT; Mon, 06 Oct 2025 15:03:02 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5krm-0000000353S-183j; Mon, 06 Oct 2025 15:03:02 +0200
Message-ID: <b3f942fc09c3e233a0af624063ccc9e07e63d204.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, "David S . Miller"
	 <davem@davemloft.net>, Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>, 	sparclinux@vger.kernel.org
Date: Mon, 06 Oct 2025 15:03:01 +0200
In-Reply-To: <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
		 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
	 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
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

On Mon, 2025-10-06 at 15:00 +0200, John Paul Adrian Glaubitz wrote:
> The problem is that giving up can lead to filesystem corruption which
> is problem that was never observed before the change from what I know.
>=20
> We have deployed a kernel with the change reverted on several LDOMs that
> are seeing heavy use such as cfarm202.cfarm.net and we have seen any syst=
em
> lock ups or similar.

We have not* seen any lock ups, so far with the patch reverted. Sorry.

>=20
--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
