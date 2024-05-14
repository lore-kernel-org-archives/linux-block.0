Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830314A96
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676267; cv=none; b=tM2cZhV/io9cXUOBNYMQd8IPlrsQfYGkQ+3sL75s4asQ7queRWvQPV9jBsbJTW0ZVjN1vh41irhiHee1b5wdUES6eE5SZSEMZuRkfa1NCHZEsKCIVhw+Pfga6EBKR367znhvWAkVjkCeX2CcDt+zJvgmIwz8ZYw2nZ2Udyq6G6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676267; c=relaxed/simple;
	bh=uT3DctWTAw1DQAFIWiuTmR9CsyxGsUHSupEWhd96uoU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=SeyljhSrQCD88KJdXHLFCbkzizMQY3XFi7bv1VNV3C+5ZrK+FeM+OqTfGj2NVmNLKslCXOvt+w3ZE/RmhEDFRoNBSJgkZC6PnNSYJVsxQXZxtFxJkXk/FMsWBKniVstgKuKCff7nsxOv0lZFHvkq4Vrh7/LjjkEj2mFU6GtdWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ba8e08/l; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ba8e08/l"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240514084417euoutp02f71c7d963c2679ca3b00884d7b5d0c8b~PTnc5A8t11354413544euoutp02w;
	Tue, 14 May 2024 08:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240514084417euoutp02f71c7d963c2679ca3b00884d7b5d0c8b~PTnc5A8t11354413544euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715676257;
	bh=yrabYPSB/GlpwNhu44SEF5V4DX84bfaaz8h7aTavhoE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ba8e08/lAvdfIwt5lVs8WjGyYMr/DHH9+4TJNmHtHWBZfABFwAs+3OqTt1OBFSnxE
	 tk86Z7m69kK8Gd4DXR4rKyJTzvsZMjZLD/MtMHNIjOtDvAOVXJ7GU9b3+ga11IYgG9
	 ptHOVHhn3/XXP8wRyuN0JBrSm/HcRAkZa0vwCJX8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240514084416eucas1p274f6b1db82f0a003a13581894aa710dd~PTncsUfSM3012530125eucas1p2y;
	Tue, 14 May 2024 08:44:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AD.F7.09875.06423466; Tue, 14
	May 2024 09:44:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240514084416eucas1p1d8da9eb5c30eed0e1091fa2cc51a5f30~PTncLylVS2630626306eucas1p14;
	Tue, 14 May 2024 08:44:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240514084416eusmtrp26b4fefe03ccf679ceb677bb2b87e7bdc~PTncK-KqI2904129041eusmtrp2I;
	Tue, 14 May 2024 08:44:16 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-d8-664324608478
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.84.09010.06423466; Tue, 14
	May 2024 09:44:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240514084416eusmtip1be7d03814ed1231c73f3d6dae2995cad~PTnb-1SYh1687616876eusmtip1x;
	Tue, 14 May 2024 08:44:16 +0000 (GMT)
Received: from localhost (106.210.248.52) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 14 May 2024 09:44:14 +0100
Date: Tue, 14 May 2024 10:44:10 +0200
From: Joel Granados <j.granados@samsung.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	"Keith Busch" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, Javier
	=?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>, Bart Van Assche
	<bvanassche@acm.org>, <david@fromorbit.com>, <gost.dev@samsung.com>, Hui Qi
	<hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH] nvme: enable FDP support
Message-ID: <20240514084410.64dk4scblcby2a3o@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="c3xofsjwrasvkfo6"
Content-Disposition: inline
In-Reply-To: <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7oJKs5pBns6dS1W3+1ns5j24Sez
	xZZj9xgtVq4+ymQx6dA1Rou9t7Qt5i97ym7xactsJgcOj8tXvD0Orn/D4nFqkYTH5bOlHptW
	dbJ5bF5S77H7ZgObx+dNcgEcUVw2Kak5mWWpRfp2CVwZj25eYS9oFqg43P6IuYHxFm8XIyeH
	hICJxJIrH5i6GLk4hARWMEqsev6IBcL5wigx5eoGVgjnM6PEjBNXWGFajn+dDJVYzijx/tEU
	NriqD5sOskM4WxglJlxfzw7SwiKgKvHi5xZmEJtNQEfi/Js7YLaIgJbE7H1TwLYzC6xklljw
	dTITSEJYQFfi9tXfYM28Ag4S27sesELYghInZz5hAbGZBSokthx6A1TDAWRLSyz/xwES5hSw
	l2jddRLqVCWJ63PPMUPYtRKnttwC2yUhsJpT4vevi0wQCReJB8tOQRUJS7w6voUdwpaR+L9z
	PlTDZEaJ/f8+sEN1M0osa/wK1W0t0XLlCVSHo8SLT9+ZQS6SEOCTuPFWEOJQPolJ26ZDhXkl
	OtqEIKrVJFbfe8MygVF5FpLXZiF5bRbCaxBhHYkFuz+xYQhrSyxb+JoZwraVWLfuPcsCRvZV
	jOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgenu9L/jX3YwLn/1Ue8QIxMH4yFGFaDmRxtW
	X2CUYsnLz0tVEuF1KLRPE+JNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQnliSmp2aWpBa
	BJNl4uCUamCqkuczl6pr3mfP4cGlwWogfmvKf/ldP+xe+ye4TljXpM5QcLjzVI+VhN6Mt67J
	dx8sPMH8fNGGuNMiiVs/3TVNUNtx12T7VlZRR2WH5dvWTys++bPbvXnW8XkxX9q3+UsaTe4X
	e+b+i/vn57Ys5qa9Rwp/vY72DdZLWmgwRacrIt27bYXLKr6pLD1fYpfO/P7Q6o7llzOJjsx/
	/q1VCTlVa9cp8i//6okHQlf2pEXsdowN3JLyfMNVNb/JE55wia7dxaMo9bLJRvPxm1ApqVUL
	+bdL251+1KF95uXk1f/Slr6wipRLrau57yFiF/eb8ZPuxbO60+el7Fiy9d0s/qP6lTYbM5bt
	3ynNMEmqqshAiaU4I9FQi7moOBEAUIS60PIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7oJKs5pBl8uclqsvtvPZjHtw09m
	iy3H7jFarFx9lMli0qFrjBZ7b2lbzF/2lN3i05bZTA4cHpeveHscXP+GxePUIgmPy2dLPTat
	6mTz2Lyk3mP3zQY2j8+b5AI4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
	9O1sUlJzMstSi/TtEvQyrlz/ylLQKFBx+ut7lgbGG7xdjJwcEgImEse/TmbtYuTiEBJYyihx
	98NhVoiEjMTGL1ehbGGJP9e62CCKPjJKrGzpgXK2MEpcXXmOHaSKRUBV4sXPLcwgNpuAjsT5
	N3fAbBEBLYnZ+6YwgTQwC6xklpiz7hnYWGEBXYnbV3+DNfMKOEhs73oAdcdBRomuNetZIRKC
	EidnPmEBsZkFyiSu3dzO2MXIAWRLSyz/xwES5hSwl2jddRLqVCWJ63PPMUPYtRKf/z5jnMAo
	PAvJpFlIJs1CmAQR1pK48e8lE4awtsSyha+ZIWxbiXXr3rMsYGRfxSiSWlqcm55bbKRXnJhb
	XJqXrpecn7uJERjz24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6qkgivQ6F9mhBv
	SmJlVWpRfnxRaU5q8SFGU2AwTmSWEk3OByajvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTE
	ktTs1NSC1CKYPiYOTqkGJv5fLVL1eel7YqeIJqctvvjumL7v58CPx4+5zlovICG0ak6u6vz1
	76v+5P54qheRUX7IQ+DGNd3C07UanDls7V6KLipThKUv3AyKUlFN9UptL4tz9JzecmgJ4+5P
	p9i3rPwoJmEm88K5LtVmxv1PHNM3BJ2X3BCuP6HA790b8+aEBQ1zpBgznS9OdWoTMWSYOm3W
	EvG6hucP3UzEsmOswtc1uN36qh94eIeu/Vn7tx+3P5LIush4Mrnzl4nErCfu/Ou1losHWyl2
	tDQZ638ry9z3mnPOrA0haz8KnfJq86070hKoW5r1Lz1vft43llVX6h+77oi0r+lvYDV9vnvj
	x95ahvBHmfKaU/hXuQYpsRRnJBpqMRcVJwIAcUGeZI4DAAA=
X-CMS-MailID: 20240514084416eucas1p1d8da9eb5c30eed0e1091fa2cc51a5f30
X-Msg-Generator: CA
X-RootMTR: 20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
	<20240510134015.29717-1-joshi.k@samsung.com>
	<CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>

--c3xofsjwrasvkfo6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:56:00AM +0300, Viacheslav Dubeyko wrote:
>=20
>=20
> > On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> >=20
> > Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> > to control the placement of logical blocks so as to reduce the SSD WAF.
> >=20
> > Userspace can send the data lifetime information using the write hints.
> > The SCSI driver (sd) can already pass this information to the SCSI
> > devices. This patch does the same for NVMe.
> >=20
> > Fetches the placement-identifiers (plids) if the device supports FDP.
> > And map the incoming write-hints to plids.
> >=20
>=20
>=20
> Great! Thanks for sharing  the patch.
>=20
> Do  we have documentation that explains how, for example, kernel-space
> file system can work with block layer to employ FDP?
>=20
> Do  we have FDP support in QEMU already if there is no access to real
> device for testing?
I believe FDP has been in qemu for some time. Look for 73064edfb8
("hw/nvme: flexible data placement emulation  [Jesper Devantier]")

best

--=20

Joel Granados

--c3xofsjwrasvkfo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZDJFkACgkQupfNUreW
QU+QYgv+OHNMrwXT68JyCUMBcKPlhkW3ExyS02Bz9YBaQgFmcntpRE3GyJc59zYT
fAM8TattQZ4qtONPKj6crV8+H5KGwrIf0hWb16JqnnxW/05BgtMR+DigtawQKdqR
dPD3w/G1fLBbLcsB6nvc5XoXxTwtH7zsx3ioPogsE01YtshpKmsUI63Km2tCz//L
ijPXKuSXPy1owIZU2iyuiW/6K4QtXsu94tawTSBWnISHoeQg4UKLWiF5FJ1qcDcK
zxZioWHjdwuZYhF5czaLHvcrpLza3ufy09Ql3F+rnbimC+Bx/82Hc5yFOMWh9sNr
ouzz28lzTAsDMzjJrsxaAAfwwh27zDOeH1LerR6rRlauugdFGOEb7/ARIoeaVVdJ
d5DnxwL9yq4dIyc6dw+LHs5nd94j9SobJJsUJuRYWsB06L5o2oaNGmAia4TzWeUQ
EET7WkLAiZOUNsv4VqftFzn7xXbjKvCb/RmGGjJVt3B6TEX6fntZn7K0xbKYrVGj
VmxC6hmT
=DKjM
-----END PGP SIGNATURE-----

--c3xofsjwrasvkfo6--
