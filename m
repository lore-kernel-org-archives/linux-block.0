Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20A190696
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329524; cv=none; b=PFYyitAffpvo8BGQma5dfKpxs9ZfidE40cA3RhHBb/MO9/XIucC/W7feDvQhmToejvZo0yDnehRfgzvg1TE9FY1mqufn3NdNpLQPAQgHNS5VKXnBCnqKgqIKP8KEvtyj16Yk8/9QU+hL9fHSRv5Wtwd2bOIVohYFm4oKJbQdzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329524; c=relaxed/simple;
	bh=+4Cgkm93qXhWO5pvvIuSvZG932XAbFn188OykHY5wyM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=kX/yLBXAjK2+B/2g8sqwP/flrLstdLWNoRzWS1xF+TO/NNBqsZDUbClnnFFa+W9KiiXbGhYljfXaYDcFl/oGl4B2FSssc7zCR3yyhhsVjhAYGqRcV/MYhvA9L+nuHWBXX4BllZQD0As5qCiGgph7//IffsspKKEZX/OLCcYszhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OstJA1nb; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OstJA1nb"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250307063839epoutp0272481b2c11c7a91d485d7db214ca68d5~qcfjKHdof2378723787epoutp02K
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 06:38:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250307063839epoutp0272481b2c11c7a91d485d7db214ca68d5~qcfjKHdof2378723787epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741329519;
	bh=+4Cgkm93qXhWO5pvvIuSvZG932XAbFn188OykHY5wyM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=OstJA1nbvqK2cmF8lXr2i6WD8+CVP00FtgHNYSgqIADiYR+VFRNZFw2dK9yBOlg4q
	 yxcL0y4L2na+9SVj5MoJVy+GT8rrGfxxtWl26pMrLm0JKsWPd1b9m0+W/ToV3t6Ftz
	 WCu2uVjR+QbSMDmnqi2BGJRaLVP/qsX1eGJwzUMY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20250307063838epcas1p3aa66134685a24861b3ec68ade318bbb6~qcfiwMEX70571005710epcas1p3U;
	Fri,  7 Mar 2025 06:38:38 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z8Gp62xj0z4x9QG; Fri,  7 Mar
	2025 06:38:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.49.23869.E649AC76; Fri,  7 Mar 2025 15:38:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250307063838epcas1p1268f73a290a61a9bcea14adbfa70b915~qcfiDPwSd0738807388epcas1p1T;
	Fri,  7 Mar 2025 06:38:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250307063838epsmtrp1600a851da224cba095613b17fc3c2741~qcfiCfFED2610126101epsmtrp1m;
	Fri,  7 Mar 2025 06:38:38 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-7c-67ca946ea10d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.7E.18729.D649AC76; Fri,  7 Mar 2025 15:38:38 +0900 (KST)
Received: from ssuk04 (unknown [10.253.104.229]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250307063837epsmtip254c2c03f8b28fbc89cfc22cd9dcd77fc~qcfh4zB4i1228212282epsmtip2K;
	Fri,  7 Mar 2025 06:38:37 +0000 (GMT)
From: "Sooyong Suk" <s.suk@samsung.com>
To: "'Suren Baghdasaryan'" <surenb@google.com>
Cc: "'Jaewon Kim'" <jaewon31.kim@gmail.com>, "'Christoph Hellwig'"
	<hch@infradead.org>, <viro@zeniv.linux.org.uk>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <spssyr@gmail.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <dhavale@google.com>
In-Reply-To: <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
Subject: RE: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for
 direct IO
Date: Fri, 7 Mar 2025 15:38:37 +0900
Message-ID: <014b01db8f2b$8ed1c740$ac7555c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHaiiw9LXrMK4mioaI0ilN2PEwZlQJfPoLQAkXgmoQCszXN9gK7/P/rAlKPAlqzBgrv8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmvm7elFPpBqdfCVvMWb+GzWL13X42
	i0PzkyxOT1jEZNG9eSajxd5b2haXd81hs7i35j+rxb27DewWky8tYLM4//c4qwO3x85Zd9k9
	Fmwq9di8Qsvj8tlSj02fJrF7nJjxm8Xj8yY5j01P3jIFcERl22SkJqakFimk5iXnp2Tmpdsq
	eQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHamkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
	yC8usVVKLUjJKTAr0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64tVOs4IZGxd4fh5gbGE+qdzFy
	ckgImEh8Pf+YvYuRi0NIYAejRO/JNmYI5xOjxMY5HSwgVUIC3xgldm/Vgelo276aDaJoL1BR
	9xEmCOcpo8SrH43sIFVsAuoS79/cBusWEdCT6DjfxAxiMwusYJKY/40LxOYUCJRYNr+FEcQW
	FgiS6N44H6ieg4NFQEXi/CJJkDCvgKXEluZbTBC2oMTJmU9YIMZoSyxb+JoZ4iAFiZ9Pl7FC
	rAqTmL/0AhtEjYjE7E6IbyQEjnBI7Nq0hRWiwUVi1t8pTBC2sMSr41vYIWwpiZf9bVB2scSv
	vo+sEM0NjBL9x5ZAbbOXWLG/kxXkUGYBTYn1u/QhlvFJvPvaAxaWEOCV6GgTgqiWl/i96QIL
	RFhUYtsbBwjTQ+LaHP8JjIqzkDw2C8ljs5A8MAth1QJGllWMYqkFxbnpqcWGBUbwmE7Oz93E
	CE68WmY7GCe9/aB3iJGJg/EQowQHs5IIr+Dmk+lCvCmJlVWpRfnxRaU5qcWHGE2BIT2RWUo0
	OR+Y+vNK4g1NLA1MzIxMLIwtjc2UxHkvbGtJFxJITyxJzU5NLUgtgulj4uCUamAyXanvYB07
	8/c3N+8Df/Iu7D1bkJU3vSMoQOS55LoVC0+VLVpssLvd+dDR9B3hxSHTDfwl1j07sfDAkZxU
	86Vf7/Tkn1ull3SuW0DizB2etUemLG3wyey7p/Ty97X3r1e9PijMbfR4e7Y418uD5yyNvpdt
	MGup8tulJ714t5DnxNMdxxoT4y5HMH5Z9bGC+/vPbRMfdrZGFcU7vH1z88syxlUdG9fWNYTo
	8c5LbBWu2cdbETuvKNs+0iJSKyZ+4lwvrfme7Lve5093XKhgdq0zPqSPw5S/pafM99sEaf4f
	fyUtt7099kLH5eBU5ZXMyoe8/0TOy7dRVXOtMKheJxM7b4XLPVZpiakZxtckp3UpsRRnJBpq
	MRcVJwIAHgXIL0UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvG7elFPpBg9fMlrMWb+GzWL13X42
	i0PzkyxOT1jEZNG9eSajxd5b2haXd81hs7i35j+rxb27DewWky8tYLM4//c4qwO3x85Zd9k9
	Fmwq9di8Qsvj8tlSj02fJrF7nJjxm8Xj8yY5j01P3jIFcERx2aSk5mSWpRbp2yVwZVzs2s9a
	cEiyYvGCa2wNjAeFuhg5OSQETCTatq9mA7GFBHYzSnRfDoaIi0o8+/2NpYuRA8gWljh8uLiL
	kQuo5DGjxMR3R1hAatgE1CXev7kNZosI6El0nG9iBiliFtjEJDFp109miI5HTBJzb79iBqni
	FAiUWDa/hRFkqrBAgETD9SgQk0VAReL8IkmQCl4BS4ktzbeYIGxBiZMzn4DNZxbQluh92MoI
	Yy9b+JoZ4k4FiZ9Pl7FC3BAmMX/pBTaIGhGJ2Z1tzBMYhWchGTULyahZSEbNQtKygJFlFaNk
	akFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcBxqae5g3L7qg94hRiYOxkOMEhzMSiK8gptP
	pgvxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpguvTlsVbv
	VFOG23rv/vPdnucx5X1ah4DskmWLY9LlhGbd2S2yz0CBR2p6RpV0/bdJP73SftXtz1ln9ORU
	bsVJn7pG4U5bLYUv3AK/9JawfDAVeBqfnXek+REn25rECj6NGwXKyZNYvqzslf/eF3d3/ZKz
	XAtEX9zfLhMparPmk5/OSpPG9eJvarocFOzTC77Mb7o/s2YGm9vllTpH1+zf4f92/5XMuD8Z
	uU+CHQXef4p4flrHqHW20HWr/m9suyr9H2TYVFzbabfoLU/y5teiMaaTnAp9vet2bLjeez2m
	qnUy03Fpny/sbApV9VPbt2jMXr3eMEv670/ra9cKli0q3qh+S/b1xaSjv2YoZ1zUV2Ipzkg0
	1GIuKk4EADiQcJsyAwAA
X-CMS-MailID: 20250307063838epcas1p1268f73a290a61a9bcea14adbfa70b915
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
	<20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
	<CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
	<848301db8f05$a1d79430$e586bc90$@samsung.com>
	<CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>

> On Thu, Mar 6, 2025 at 6:07=E2=80=AFPM=20Sooyong=20Suk=20<s.suk=40samsung=
.com>=20wrote:=0D=0A>=20>=0D=0A>=20>=20>=20On=20Fri,=20Mar=207,=202025=20at=
=2012:26=E2=80=AFAM=20Christoph=20Hellwig=0D=0A>=20>=20>=20<hch=40infradead=
.org>=0D=0A>=20>=20>=20wrote:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20On=20=
Thu,=20Mar=2006,=202025=20at=2004:40:56PM=20+0900,=20Sooyong=20Suk=20wrote:=
=0D=0A>=20>=20>=20>=20>=20There=20are=20GUP=20references=20to=20pages=20tha=
t=20are=20serving=20as=20direct=20IO=0D=0A>=20>=20>=20buffers.=0D=0A>=20>=
=20>=20>=20>=20Those=20pages=20can=20be=20allocated=20from=20CMA=20pagebloc=
ks=20despite=20they=0D=0A>=20>=20>=20>=20>=20can=20be=20pinned=20until=20th=
e=20DIO=20is=20completed.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20direct=20=
I/O=20is=20eactly=20the=20case=20that=20is=20not=20FOLL_LONGTERM=20and=20on=
e=20of=0D=0A>=20>=20>=20>=20the=20reasons=20to=20even=20have=20the=20flag.=
=20=20So=20big=20fat=20no=20to=20this.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=0D=
=0A>=20>=0D=0A>=20>=20Understood.=0D=0A>=20>=0D=0A>=20>=20>=20Hello,=20than=
k=20you=20for=20your=20comment.=0D=0A>=20>=20>=20We,=20Sooyong=20and=20I,=
=20wanted=20to=20get=20some=20opinions=20about=20this=0D=0A>=20>=20>=20FOLL=
_LONGTERM=20for=20direct=20I/O=20as=20CMA=20memory=20got=20pinned=20pages=
=20which=0D=0A>=20>=20>=20had=20been=20pinned=20from=20direct=20io.=0D=0A>=
=20>=20>=0D=0A>=20>=20>=20>=20You=20also=20completely=20failed=20to=20addre=
ss=20the=20relevant=20mailinglist=20and=0D=0A>=20>=20>=20>=20maintainers.=
=0D=0A>=20>=20>=0D=0A>=20>=20>=20I=20added=20block=20maintainer=20Jens=20Ax=
boe=20and=20the=20block=20layer=20maillinst=0D=0A>=20>=20>=20here,=20and=20=
added=20Suren=20and=20Sandeep,=20too.=0D=0A>=20=0D=0A>=20I'm=20very=20far=
=20from=20being=20a=20block=20layer=20expert=20:)=0D=0A>=20=0D=0A>=20>=0D=
=0A>=20>=20Then,=20what=20do=20you=20think=20of=20using=20PF_MEMALLOC_PIN=
=20for=20this=20context=20as=0D=0A>=20below?=0D=0A>=20>=20This=20will=20onl=
y=20remove=20__GFP_MOVABLE=20from=20its=20allocation=20flag.=0D=0A>=20>=20S=
ince=20__bio_iov_iter_get_pages()=20indicates=20that=20it=20will=20pin=20us=
er=20or=0D=0A>=20>=20kernel=20pages,=20there=20seems=20to=20be=20no=20reaso=
n=20not=20to=20use=20this=20process=20flag.=0D=0A>=20=0D=0A>=20I=20think=20=
this=20will=20help=20you=20only=20when=20the=20pages=20are=20faulted=20in=
=20but=20if=0D=0A>=20__get_user_pages()=20finds=20an=20already=20mapped=20p=
age=20which=20happens=20to=20be=0D=0A>=20allocated=20from=20CMA,=20it=20wil=
l=20not=20migrate=20it.=20So,=20you=20might=20still=20end=20up=0D=0A>=20wit=
h=20unmovable=20pages=20inside=20CMA.=0D=0A>=20=0D=0A=0D=0AYes,=20you're=20=
right.=0D=0AHowever,=20we=20can=20at=20least=20prevent=20issues=20from=20fa=
ult-in=20cases=20and=20mitigate=0D=0Athe=20overall=20probability=20of=20CMA=
=20allocation=20failure.=20And=20the=20pinned=20pages=20that=0D=0Awe=20obse=
rved=20from=20snapuserd=20was=20also=20allocated=20by=20fault-in.=0D=0A=0D=
=0A>=20>=0D=0A>=20>=20block/bio.c=20=7C=203=20+++=0D=0A>=20>=20=201=20file=
=20changed,=203=20insertions(+)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/bl=
ock/bio.c=20b/block/bio.c=20index=2065c796ecb..671e28966=0D=0A>=20>=2010064=
4=0D=0A>=20>=20---=20a/block/bio.c=0D=0A>=20>=20+++=20b/block/bio.c=0D=0A>=
=20>=20=40=40=20-1248,6=20+1248,7=20=40=40=20static=20int=20__bio_iov_iter_=
get_pages(struct=20bio=0D=0A>=20*bio,=20struct=20iov_iter=20*iter)=0D=0A>=
=20>=20=20=20=20=20=20=20=20=20unsigned=20len,=20i=20=3D=200;=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20size_t=20offset;=0D=0A>=20>=20=20=20=20=20=20=20=20=
=20int=20ret=20=3D=200;=0D=0A>=20>=20+=20=20=20=20=20=20=20unsigned=20int=
=20flags;=0D=0A>=20>=0D=0A>=20>=20=20=20=20=20=20=20=20=20/*=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20=20*=20Move=20page=20array=20up=20in=20the=20alloca=
ted=20memory=20for=20the=20bio=20vecs=0D=0A>=20>=20as=20far=20as=20=40=40=
=20-1267,9=20+1268,11=20=40=40=20static=20int=0D=0A>=20__bio_iov_iter_get_p=
ages(struct=20bio=20*bio,=20struct=20iov_iter=20*iter)=0D=0A>=20>=20=20=20=
=20=20=20=20=20=20=20*=20result=20to=20ensure=20the=20bio's=20total=20size=
=20is=20correct.=20The=20remainder=0D=0A>=20of=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20=20*=20the=20iov=20data=20will=20be=20picked=20up=20in=20the=20nex=
t=20bio=20iteration.=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20*/=0D=0A>=20>=
=20+=20=20=20=20=20=20=20flags=20=3D=20memalloc_pin_save();=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20size=20=3D=20iov_iter_extract_pages(iter,=20&pages,=
=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20UINT_MAX=20-=20bio->b=
i_iter.bi_size,=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20nr_pag=
es,=20extraction_flags,=0D=0A>=20>=20&offset);=0D=0A>=20>=20+=20=20=20=20=
=20=20=20memalloc_pin_restore(flags);=0D=0A>=20>=20=20=20=20=20=20=20=20=20=
if=20(unlikely(size=20<=3D=200))=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20return=20size=20?=20size=20:=20-EFAULT;=0D=0A>=20>=0D=
=0A>=20>=0D=0A=0D=0A
