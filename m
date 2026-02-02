Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F013644D4
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033872; cv=none; b=okr/BxAuH2jQTYTz70uSqIM28beDmruk/l5lGv00kQ3IbCyqcTcE9lVOAqf1ZMzL+Ez6hwt9bF1NlM7g2lWNYgc//cAMlx3o4RU07jFxhMazFQdDvv2Mfxr/z2mELwPIV8hD3/CvRywM2FWMdxYsjmfHqgY6mHmpZG3Z4Zj2SxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033872; c=relaxed/simple;
	bh=K+1M+tjOm8I30ri2kpWc1LrQdBc5qBFrUeFbxolUqq0=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=bF6sZnPgnmWhTMvO2N/eYUMUf1ynzg/dJpXRluv+EXCjKNIgO4Exi0a66+0NFh6ceQi9BCYeKod0Hzhgaio3tsjLPsoqawhyoTPlhiM88sjhMqO9EsYQudW2gkA9Fz+ZiPySdurhFcmi7gkuOmxSDBAezRSCYwpc7WgHV8rSfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BNMC6m8Q; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BNMC6m8Q"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260202120428epoutp03b666fb481be74e628e5149f7e20fc43b~QbGzLMJZq0608806088epoutp03T
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 12:04:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260202120428epoutp03b666fb481be74e628e5149f7e20fc43b~QbGzLMJZq0608806088epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770033868;
	bh=K+1M+tjOm8I30ri2kpWc1LrQdBc5qBFrUeFbxolUqq0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=BNMC6m8Q1iP0yyuv8rF5xmQ8h4e9DNwpm9hSSHX0w/1NcQgzXIjoyzQcx4dn0Nkb0
	 4XnjzIO+VDipbe42R004iiZK7KX2Ts2Q0SRQVMV16muvxHQ6N/BKRV2rm86+0EySQt
	 RCofpIzqlwIZV52GLK5v7lenY9Rcd6o6QXXISWms=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20260202120426epcas2p42899f3fdce022b1530a73d3e671d7406~QbGyAhCJw0524305243epcas2p4W;
	Mon,  2 Feb 2026 12:04:26 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.208]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f4QJp3gFyz6B9m5; Mon,  2 Feb
	2026 12:04:26 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [Samsung] bsg-lib.c patch for double-free error fix.
Reply-To: jonghwi.rha@samsung.com
Sender: =?UTF-8?B?65287KKF7ZyY?= <jonghwi.rha@samsung.com>
From: =?UTF-8?B?65287KKF7ZyY?= <jonghwi.rha@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?= <jt1217.kim@samsung.com>,
	=?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
Date: Mon, 02 Feb 2026 21:04:25 +0900
X-CMS-MailID: 20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260130091020epcms2p2d85af8781639a17ab517208feb270dbd
References: <CGME20260130091020epcms2p2d85af8781639a17ab517208feb270dbd@epcms2p4>

Dear Jens,

Sorry for the excuse, also thank you for the response.=C2=A0=0D=0A=0D=0AIt=
=20was=20my=20first=20time=20with=20the=20procedure,=20so=20there=20was=20a=
=20mistake.=20I=20apologize=20for=20the=20inconvenience.=0D=0AAs=20you=20me=
ntioned,=20in=20the=20case=20of=20the=20previous=20patch,=20there=20was=20d=
uplicate=20code,=20so=20changing=20it=20to=20kzalloc=20would=20indeed=20be=
=20meaningless.=0D=0A=0D=0AWe=20have=20prepared=20a=20new=20patch=20and=20c=
ompleted=20internal=20testing=20on=20our=20side.=C2=A0Without=20this=20patc=
h,=20issues=20occur=20when=20using=20ufs-bsg.=0D=0A=0D=0AStarting=20from=20=
Linux=20kernel=20version=205.x,=20advanced=20RPMB=20code=20was=20included=
=20to=20the=20ufs-bsg=20path.=C2=A0In=20the=20advanced=20RPMB=20code=20path=
,=20the=20payload=E2=80=99s=20sg_list=20is=20not=20used.=C2=A0=0D=0ASo,=20a=
fter=20other=20BSG=20operations,=20the=20previous=20value=20remains=20in=20=
payload.sg_list,=20which=20results=20in=20a=20double-free=20issue.=0D=0A=0D=
=0AAuthor:=20Jonghwi=20Rha=20<jonghwi.rha=40samsung.com>=0D=0ADate:=C2=A0=
=20=C2=A0Tue=20Jan=2013=2014:42:39=202026=20+0900=0D=0A=0D=0A=C2=A0=20=C2=
=A0=20bsg:=20initialize=20request=20and=20reply=20payloads=20in=20bsg_prepa=
re_job=0D=0A=0D=0A=C2=A0=20=C2=A0=20struct=20bsg_job=20payloads=20contain=
=20fields=20that=20are=20only=20populated=20by=0D=0A=C2=A0=20=C2=A0=20certa=
in=20commands,=20such=20as=20sg_list=20pointers.=0D=0A=0D=0A=C2=A0=20=C2=A0=
=20Because=20struct=20bsg_job=20is=20allocated=20with=20kmalloc(),=20memory=
=20may=20be=0D=0A=C2=A0=20=C2=A0=20reused=20across=20requests.=20If=20a=20c=
ommand=20does=20not=20populate=20all=20payload=0D=0A=C2=A0=20=C2=A0=20field=
s,=20stale=20state=20from=20a=20previous=20job=20may=20remain=20and=20later=
=20be=0D=0A=C2=A0=20=C2=A0=20misinterpreted=20during=20cleanup,=20potential=
ly=20leading=20to=20use-after-free=0D=0A=C2=A0=20=C2=A0=20or=20double-free=
=20issues.=0D=0A=0D=0A=C2=A0=20=C2=A0=20Initialize=20both=20request=20and=
=20reply=20payloads=20at=20the=20beginning=20of=20job=0D=0A=C2=A0=20=C2=A0=
=20preparation=20to=20ensure=20a=20clean=20state=20for=20all=20commands.=0D=
=0A=0D=0A=C2=A0=20=C2=A0=20Signed-off-by:=20Jonghwi=20Rha=20<jonghwi.rha=40=
samsung.com>=0D=0A=0D=0Adiff=20--git=20a/block/bsg-lib.c=20b/block/bsg-lib.=
c=0D=0Aindex=2032da4a4429ce..0fbf8e311c03=20100644=0D=0A---=20a/block/bsg-l=
ib.c=0D=0A+++=20b/block/bsg-lib.c=0D=0A=40=40=20-234,6=20+234,12=20=40=40=
=20static=20bool=20bsg_prepare_job(struct=20device=20*dev,=20struct=20reque=
st=20*req)=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20bsg_job=20*job=
=20=3D=20blk_mq_rq_to_pdu(req);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20in=
t=20ret;=0D=0A=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20Clear=20stale=20=
SG=20state=20since=20bsg_job=20is=20reused=20as=20a=20request=20PDU=20*/=0D=
=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0job->request_payload.sg_list=20=3D=20N=
ULL;=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0job->request_payload.sg_cnt=20=
=3D=200;=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0job->reply_payload.sg_list=
=20=3D=20NULL;=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0job->reply_payload.sg=
_cnt=20=3D=200;=0D=0A+=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20job->timeou=
t=20=3D=20req->timeout;=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=20(req->bio)=20=7B=0D=0A=0D=0AP.S.=20Change-Id=20was=20for=20our=20gerrit=
=20system.=20Plz=20ignore=20it.=0D=0A=0D=0ARegards,=0D=0AJonghwi,=0D=0A=0D=
=0A---------Original=20Message---------=0D=0ASender:=20Jens=20Axboe=20<axbo=
e=40kernel.dk>=0D=0ADate:=202026-01-13=2000:36=20(GMT+09:00)=0D=0ATitle:=20=
Re:=20=5BSamsung=5D=20bsg-lib.c=20patch=20for=20double-free=20error=20fix.=
=0D=0A=C2=A0=0D=0APlease=20don't=20send=20patches=20as=20attachments,=20and=
=20particularly=20with=20html=0D=0Aemails=20as=20they=20will=20just=20get=
=20dropped=20from=20the=20list.=20And=20it=20makes=20it=0D=0Aimpossible=20t=
o=20reply=20to=20as=20well,=20as=20you=20then=20need=20to=20save=20and=20re=
ad=20the=0D=0Apatch=20separately=20and=20import=20it=20into=20an=20email...=
=0D=0A=0D=0A>=20Change-Id:=20Iadb96f8736f8d9d9aae7b4a831c2a286ff59c520=0D=
=0A=0D=0AWhat=20is=20this?=0D=0A=0D=0Adiff=20--git=20a/block/bsg-lib.c=20b/=
block/bsg-lib.c=0D=0Aindex=209ceb5d0832f5..635b3b988f92=20100644=0D=0A---=
=20a/block/bsg-lib.c=0D=0A+++=20b/block/bsg-lib.c=0D=0A=40=40=20-215,7=20+2=
15,7=20=40=40=20static=20int=20bsg_map_buffer(struct=20bsg_buffer=20*buf,=
=20struct=20request=20*req)=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0BUG_ON(=21req->nr_phys_segments);=0D=0A=0D=0A-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0buf->sg_list=20=3D=20kmalloc(sz,=20GFP_KERNEL);=0D=0A+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0buf->sg_list=20=3D=20kzalloc(sz,=20GFP_KERNEL=
);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21buf->sg_list)=0D=
=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=20-ENOMEM;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0sg_i=
nit_table(buf->sg_list,=20req->nr_phys_segments);=0D=0A=0D=0AHow=20does=20t=
his=20make=20a=20difference,=20when=20sg_init_table()=20explicitly=20sets=
=20it=0D=0Aall=20to=200?=0D=0A=0D=0A--=0D=0AJens=20Axboe
