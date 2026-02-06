Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE852E1EE7
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 04:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770353940; cv=none; b=kVckCHSDd1CiiZfaAXzDTLN4c5BG9MlxW2JvleELdFmt384FhHRsTm3iMsM235s5QoPinhAVdUt1lFd4sw4QwCKjn4IxoO/khT2to5+gEV56IN3/PK5miYaQvTzaz06Cq7mfAMI7rnkSCj3HtRoKQxJTE/puetyG52NS/walDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770353940; c=relaxed/simple;
	bh=J23+jR3q5ICI1iZgzyE+oTtmEwbs6qRivgnG6QUfnBk=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=qa7gTzXXI7HFUwXDkb87IRlRXd7gPZ3GedOldBl94/KpjMZlQm41I/JPWDxv/JlwiScNGavLcA1ctkwiSEwwj2P64WL+byZTOriCMk4negW4hlGhDlNFEexM1oLm9xDTCJVWW9J8KXTFffks9w0TCZ1S19TvkEwSDwo26ZCDXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YqY+jkZq; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YqY+jkZq"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260206045851epoutp02cee148eef900a92b6a17841a82bbf227~Rj4VnCVlt2024320243epoutp02P
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 04:58:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260206045851epoutp02cee148eef900a92b6a17841a82bbf227~Rj4VnCVlt2024320243epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770353931;
	bh=J23+jR3q5ICI1iZgzyE+oTtmEwbs6qRivgnG6QUfnBk=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=YqY+jkZqfxckNtZCONTI1pt1Ner3l7ftRGsju1miu+mdojL8Vw8A1lEg/JqxLOGB/
	 +TsxvZAqIcdi0gKg9JOzEF4eObKhUsx0vxxrzszKwa+hvUC6Wzq21nwNeCuRipsoBu
	 JHPUpfyx9KGycLxOw7SO6tEM5vc0gXW57SnTVJbM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20260206045851epcas2p25cf0336d81fabf38e14014b38cbff616~Rj4VUlKEj2317423174epcas2p2j;
	Fri,  6 Feb 2026 04:58:51 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.209]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f6hgt6yTHz2SSKd; Fri,  6 Feb
	2026 04:58:50 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Re: [Patch] bsg: initialize request and reply payloads in
 bsg_prepare_job
Reply-To: jonghwi.rha@samsung.com
Sender: =?UTF-8?B?65287KKF7ZyY?= <jonghwi.rha@samsung.com>
From: =?UTF-8?B?65287KKF7ZyY?= <jonghwi.rha@samsung.com>
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?= <jt1217.kim@samsung.com>,
	=?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <dcc9dfc7-fda0-4d25-80ab-48a722c984bf@suse.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260206045850epcms2p2b10bcfd30a1c768fb35b2994b29454de@epcms2p2>
Date: Fri, 06 Feb 2026 13:58:50 +0900
X-CMS-MailID: 20260206045850epcms2p2b10bcfd30a1c768fb35b2994b29454de
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260130091020epcms2p2d85af8781639a17ab517208feb270dbd
References: <dcc9dfc7-fda0-4d25-80ab-48a722c984bf@suse.de>
	<8c7399bf-76b3-4902-b257-b85c95543f6f@kernel.dk>
	<20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
	<20260205053219epcms2p20a936a2fa681d19d3386fd480c283447@epcms2p2>
	<f8e86beb-5025-4d33-9ee4-0b9e8155c345@kernel.dk>
	<CGME20260130091020epcms2p2d85af8781639a17ab517208feb270dbd@epcms2p2>

On 2/6/26=C2=A000:45,=20Hannes=20Reinecke=20wrote:=0D=0A>=20On=202/5/26=201=
4:42,=20Jens=20Axboe=20wrote:=0D=0A>>=20On=202/4/26=2010:32=20PM,=20???=20w=
rote:=0D=0A>>>=20bsg:=20initialize=20request=20and=20reply=20payloads=20in=
=20bsg_prepare_job=0D=0A>>>=0D=0A>>>=20struct=20bsg_job=20payloads=20contai=
n=20fields=20that=20are=20only=20populated=20by=0D=0A>>>=20certain=20comman=
ds,=20such=20as=20sg_list=20pointers.=0D=0A>>>=0D=0A>>>=20Because=20struct=
=20bsg_job=20is=20allocated=20with=20kmalloc(),=20memory=20may=20be=0D=0A>>=
>=20reused=20across=20requests.=20If=20a=20command=20does=20not=20populate=
=20all=20payload=0D=0A>>>=20fields,=20stale=20state=20from=20a=20previous=
=20job=20may=20remain=20and=20later=20be=0D=0A>>>=20misinterpreted=20during=
=20cleanup,=20potentially=20leading=20to=20use-after-free=0D=0A>>>=20or=20d=
ouble-free=20issues.=0D=0A>>>=0D=0A>>>=20Initialize=20both=20request=20and=
=20reply=20payloads=20at=20the=20beginning=20of=20job=0D=0A>>>=20preparatio=
n=20to=20ensure=20a=20clean=20state=20for=20all=20commands.=0D=0A>>>=0D=0A>=
>>=20Signed-off-by:=20Jonghwi=20Rha=20<jonghwi.rha=40samsung.com>=0D=0A>>>=
=0D=0A>>>=20diff=20--git=20a/block/bsg-lib.c=20b/block/bsg-lib.c=0D=0A>>>=
=20index=2032da4a4429ce..0fbf8e311c03=20100644=0D=0A>>>=20---=20a/block/bsg=
-lib.c=0D=0A>>>=20+++=20b/block/bsg-lib.c=0D=0A>>>=20=40=40=20-234,6=20+234=
,12=20=40=40=20static=20bool=20bsg_prepare_job(struct=20device=20*dev,=20st=
ruct=20request=20*req)=0D=0A>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20struct=20bsg_job=20*job=20=3D=20blk_mq_rq_to_pdu(req);=0D=0A>>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20ret;=0D=0A>>>=0D=0A>>>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20/*=20Clear=20stale=20SG=20state=20since=20bsg_job=20is=
=20reused=20as=20a=20request=20PDU=20*/=0D=0A>>>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20job->request_payload.sg_list=20=3D=20NULL;=0D=0A>>>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20job->request_payload.sg_cnt=20=3D=200;=0D=0A>>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20job->reply_payload.sg_list=20=3D=20NULL;=0D=0A>>>=20+=C2=
=A0=20=C2=A0=20=C2=A0=20job->reply_payload.sg_cnt=20=3D=200;=0D=0A>>>=20+=
=0D=0A>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20job->timeout=20=3D=20=
req->timeout;=0D=0A>>>=0D=0A>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20if=20(req->bio)=20=7B=0D=0A>>=0D=0A>>=20The=20patch=20is=20white-space=
=20damaged,=20tabs=20are=20spaces.=20But=20I=20can=20fix=20that=0D=0A>>=20u=
p.=20Do=20we=20just=20want=20to=20do=20a=20memset(job,=200,=20sizeof(*job))=
=20here=20to=20avoid=0D=0A>>=20any=20oddities=20like=20this=20in=20the=20fu=
ture?=0D=0A>>=0D=0A>=0D=0A>=C2=A0That=20might=20indeed=20be=20better.=0D=0A=
=0D=0AThe=20suggested=20method=20impairs=20normal=20operation.=20If=20bsg_p=
repare_job=20performs=20a=20zero=E2=80=91memset=20for=20the=20job=20structu=
re,=20all=20request=E2=80=91related=20information=20set=20on=20the=20driver=
=20side=20before=20the=20call=20will=20be=20lost.=20Therefore,=20if=20it=20=
runs=20as=20is,=20it=20will=20go=20to=20ufs_bsg_request=20and=20cause=20a=
=20null=E2=80=91pointer=20access.=0D=0A=0D=0ACurrently,=20the=20original=20=
patch=20has=20no=20functional=20impact.=0D=0A=0D=0AThe=20blank=20problem=20=
seems=20to=20be=20due=20to=20a=20mistake=20I=20made=20while=20copying=20and=
=20pasting=20the=20patch.=20I=20am=20reattaching=20the=20patch=20below.=20I=
f=20needed,=20I=20can=20attach=20the=20patch=20and=20resend=20the=20new=20e=
mail.=0D=0A=0D=0A=0D=0A=5BPATCH=5D=20bsg:=20initialize=20request=20and=20re=
ply=20payloads=20in=20bsg_prepare_job=0D=0A=0D=0Astruct=20bsg_job=20payload=
s=20contain=20fields=20that=20are=20only=20populated=20by=0D=0Acertain=20co=
mmands,=20such=20as=20sg_list=20pointers.=0D=0A=0D=0ABecause=20struct=20bsg=
_job=20is=20allocated=20with=20kmalloc(),=20memory=20may=20be=0D=0Areused=
=20across=20requests.=20If=20a=20command=20does=20not=20populate=20all=20pa=
yload=0D=0Afields,=20stale=20state=20from=20a=20previous=20job=20may=20rema=
in=20and=20later=20be=0D=0Amisinterpreted=20during=20cleanup,=20potentially=
=20leading=20to=20use-after-free=0D=0Aor=20double-free=20issues.=0D=0A=0D=
=0AInitialize=20both=20request=20and=20reply=20payloads=20at=20the=20beginn=
ing=20of=20job=0D=0Apreparation=20to=20ensure=20a=20clean=20state=20for=20a=
ll=20commands.=0D=0A=0D=0ASigned-off-by:=20Jonghwi=20Rha=20<jonghwi.rha=40s=
amsung.com>=0D=0A---=0D=0A=20block/bsg-lib.c=20=7C=206=20++++++=0D=0A=201=
=20file=20changed,=206=20insertions(+)=0D=0A=0D=0Adiff=20--git=20a/block/bs=
g-lib.c=20b/block/bsg-lib.c=0D=0Aindex=2032da4a4429ce..0fbf8e311c03=2010064=
4=0D=0A---=20a/block/bsg-lib.c=0D=0A+++=20b/block/bsg-lib.c=0D=0A=40=40=20-=
234,6=20+234,12=20=40=40=20static=20bool=20bsg_prepare_job(struct=20device=
=20*dev,=20struct=20request=20*req)=0D=0A=20=09struct=20bsg_job=20*job=20=
=3D=20blk_mq_rq_to_pdu(req);=0D=0A=20=09int=20ret;=0D=0A=20=0D=0A+=09/*=20C=
lear=20stale=20SG=20state=20since=20bsg_job=20is=20reused=20as=20a=20reques=
t=20PDU=20*/=0D=0A+=09job->request_payload.sg_list=20=3D=20NULL;=0D=0A+=09j=
ob->request_payload.sg_cnt=20=3D=200;=0D=0A+=09job->reply_payload.sg_list=
=20=3D=20NULL;=0D=0A+=09job->reply_payload.sg_cnt=20=3D=200;=0D=0A+=0D=0A=
=20=09job->timeout=20=3D=20req->timeout;=0D=0A=20=0D=0A=20=09if=20(req->bio=
)=20=7B=0D=0A--=20=0D=0A=0D=0ARegards,=0D=0AJonghwi,=0D=0A=0D=0A=0D=0A
