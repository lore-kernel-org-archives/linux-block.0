Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815F31F99D
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829236; cv=none; b=FA6LqD82/i6+CzeK2ahYg+o2FEOa+Z++HjoZcdfFEaUwX7hhIZoDxQDMv2iJIQGrzVDTxYNp9F2ViuRL6gP6wxpfYplAThQS8hiyXPkKwMx6CQ5gYRqGlv/FV0hYD6D2ctEV0o3H84a8f1yEgiaKoPJnJwZgcelsqnCm2xvfkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829236; c=relaxed/simple;
	bh=dyOkNJ4Nbad9i4bIu0guYia4nY2KDIPMmS+XAhPeTCs=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=EZapZRbhWXI7F5nlIuF1PP9QyhMYpWepcCFJ4cPGcAWmo5OQV54Oj0ABbo8GopPgw/Tgj0DF8zNmwDXS0TXYOlevf1rSMWmakbIL1tKgBTuh6BejpwbuBIZ64+Y0ftf91AOKD3CS5jEbCJZInc2pzFAyO+ifHQIk8CHJv3vs49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=u8wqJjMC; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u8wqJjMC"
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260318102031epoutp0184817139afd202262c3aaa5e9160c335~d6EnE2y5w1532715327epoutp01f
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 10:20:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260318102031epoutp0184817139afd202262c3aaa5e9160c335~d6EnE2y5w1532715327epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773829231;
	bh=M4GpLeR4/GIJU22PeUtOSiX54JqVu6Wop5N4lE7Ie38=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=u8wqJjMCUbFC6ATwhUeByAD4WKr1nc9gojMADGmwDP/PZlZoR5a1HJmAkNXTZ3hb0
	 x81lP9Lxm6C0W38riBA5E+8+DvBKOosbmCwWoWGwAeAoVfyZLwvaJjYmIGvNpeeuA6
	 PdPqhn09E01ZUTf5BvtYHG6+AzbTDHgyoRvabUec=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20260318102031epcas2p451759fa78fb72729416d78a046bf6194~d6EmtTWzE2730327303epcas2p4L;
	Wed, 18 Mar 2026 10:20:31 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.204]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fbPwb0S37z2SSKZ; Wed, 18 Mar
	2026 10:20:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Re: Re: [Patch] bsg: initialize request and reply payloads in
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
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e@epcms2p7>
Date: Wed, 18 Mar 2026 19:20:30 +0900
X-CMS-MailID: 20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e
References: <CGME20260318102030epcms2p7b2daaab73032a6a26eca9c8307a7322e@epcms2p7>

On 2/6/26 13:58 PM, ??? wrote:
> On 2/6/26 00:45, Hannes Reinecke wrote:
>> On 2/5/26 14:42, Jens Axboe wrote:
>>> On 2/4/26 10:32 PM, ??? wrote:
>>>> bsg: initialize request and reply payloads in bsg_prepare_job
>>>>
>>>> struct bsg_job payloads contain fields that are only populated by
>>>> certain commands, such as sg_list pointers.
>>>>
>>>> Because struct bsg_job is allocated with kmalloc(), memory may be
>>>> reused across requests. If a command does not populate all payload
>>>> fields, stale state from a previous job may remain and later be
>>>> misinterpreted during cleanup, potentially leading to use-after-free
>>>> or double-free issues.
>>>>
>>>> Initialize both request and reply payloads at the beginning of job
>>>> preparation to ensure a clean state for all commands.
>>>>
>>>> Signed-off-by: Jonghwi Rha=20
>>>>
>>>> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
>>>> index 32da4a4429ce..0fbf8e311c03 100644
>>>> --- a/block/bsg-lib.c
>>>> +++ b/block/bsg-lib.c
>>>> =40=40 -234,6 +234,12 =40=40 static bool bsg_prepare_job(struct device=
 *dev, struct request *req)
>>>>          struct bsg_job *job =3D blk_mq_rq_to_pdu(req);
>>>>          int ret;
>>>>
>>>> +      /* Clear stale SG state since bsg_job is reused as a request PD=
U */
>>>> +      job->request_payload.sg_list =3D NULL;
>>>> +      job->request_payload.sg_cnt =3D 0;
>>>> +      job->reply_payload.sg_list =3D NULL;
>>>> +      job->reply_payload.sg_cnt =3D 0;
>>>> +
>>>>          job->timeout =3D req->timeout;
>>>>
>>>>          if (req->bio) =7B
>>>
>>> The patch is white-space damaged, tabs are spaces. But I can fix that
>>> up. Do we just want to do a memset(job, 0, sizeof(*job)) here to avoid
>>> any oddities like this in the future?
>>>
>>
>> That might indeed be better.
>
> The suggested method impairs normal operation. If bsg_prepare_job perform=
s
> a zero=E2=80=91memset=20for=20the=20job=20structure,=20all=20request=E2=
=80=91related=20information=20set=20on=0D=0A>=20the=20driver=20side=20befor=
e=20the=20call=20will=20be=20lost.=20Therefore,=20if=20it=20runs=20as=20is,=
=0D=0A>=20it=20will=20go=20to=20ufs_bsg_request=20and=20cause=20a=20null=E2=
=80=91pointer=20access.=0D=0A>=0D=0A>=20Currently,=20the=20original=20patch=
=20has=20no=20functional=20impact.=0D=0A>=0D=0A>=20The=20blank=20problem=20=
seems=20to=20be=20due=20to=20a=20mistake=20I=20made=20while=20copying=20and=
=20pasting=0D=0A>=20the=20patch.=20I=20am=20reattaching=20the=20patch=20bel=
ow.=20If=20needed,=20I=20can=20attach=20the=20patch=0D=0A>=20and=20resend=
=20the=20new=20email.=0D=0A>=0D=0A>=0D=0A>=20=5BPATCH=5D=20bsg:=20initializ=
e=20request=20and=20reply=20payloads=20in=20bsg_prepare_job=0D=0A>=0D=0A>=
=20struct=20bsg_job=20payloads=20contain=20fields=20that=20are=20only=20pop=
ulated=20by=0D=0A>=20certain=20commands,=20such=20as=20sg_list=20pointers.=
=0D=0A>=0D=0A>=20Because=20struct=20bsg_job=20is=20allocated=20with=20kmall=
oc(),=20memory=20may=20be=0D=0A>=20reused=20across=20requests.=20If=20a=20c=
ommand=20does=20not=20populate=20all=20payload=0D=0A>=20fields,=20stale=20s=
tate=20from=20a=20previous=20job=20may=20remain=20and=20later=20be=0D=0A>=
=20misinterpreted=20during=20cleanup,=20potentially=20leading=20to=20use-af=
ter-free=0D=0A>=20or=20double-free=20issues.=0D=0A>=0D=0A>=20Initialize=20b=
oth=20request=20and=20reply=20payloads=20at=20the=20beginning=20of=20job=0D=
=0A>=20preparation=20to=20ensure=20a=20clean=20state=20for=20all=20commands=
.=0D=0A>=0D=0A>=20Signed-off-by:=20Jonghwi=20Rha=20=0D=0A>=20---=0D=0A>=20=
=20block/bsg-lib.c=20=7C=206=20++++++=0D=0A>=20=201=20file=20changed,=206=
=20insertions(+)=0D=0A>=0D=0A>=20diff=20--git=20a/block/bsg-lib.c=20b/block=
/bsg-lib.c=0D=0A>=20index=2032da4a4429ce..0fbf8e311c03=20100644=0D=0A>=20--=
-=20a/block/bsg-lib.c=0D=0A>=20+++=20b/block/bsg-lib.c=0D=0A>=20=40=40=20-2=
34,6=20+234,12=20=40=40=20static=20bool=20bsg_prepare_job(struct=20device=
=20*dev,=20struct=20request=20*req)=0D=0A>=20=20=09struct=20bsg_job=20*job=
=20=3D=20blk_mq_rq_to_pdu(req);=0D=0A>=20=20=09int=20ret;=0D=0A>=20=20=0D=
=0A>=20+=09/*=20Clear=20stale=20SG=20state=20since=20bsg_job=20is=20reused=
=20as=20a=20request=20PDU=20*/=0D=0A>=20+=09job->request_payload.sg_list=20=
=3D=20NULL;=0D=0A>=20+=09job->request_payload.sg_cnt=20=3D=200;=0D=0A>=20+=
=09job->reply_payload.sg_list=20=3D=20NULL;=0D=0A>=20+=09job->reply_payload=
.sg_cnt=20=3D=200;=0D=0A>=20+=0D=0A>=20=09job->timeout=20=3D=20req->timeout=
;=0D=0A>=20=0D=0A>=20=09if=20(req->bio)=20=7B=0D=0A>=20--=20=0D=0A=0D=0A>=
=20Regards,=0D=0A>=20Jonghwi,=0D=0A=0D=0A--=0D=0A=0D=0ASince=20there=20was=
=20no=20reply,=20I=20am=20resending=20the=20email=20as=20a=20reminder.=20Fi=
rst,=0D=0AI=20have=20confirmed=20in=20my=20environment=20that,=20as=20you=
=20suggested,=20memset=E2=80=AFas=200=20for=0D=0Aall=20'job'=20struct=20ele=
ments=20eventually=20results=20an=20error.=20The=20reason=20is,=20as=20I=20=
=0D=0Amentioned=20above,=20that=20the=20request/reply=20gets=20lost=20befor=
e=20re-using.=0D=0A=0D=0AAlso,=20since=20other=20elements=20in=20the=20stru=
cture=20are=20reused,=20so=20they=20are=20not=20=0D=0Arelevant=20to=20the=
=20current=20issue.=0D=0A=0D=0AIf=20the=20code=20execution=20point=20is=20n=
ot=20ideal,=20there=20is=20also=20the=20option=20of=20zeroising=0D=0Aafter=
=20freeing=20the=20memory=20allocation.=0D=0A=0D=0AJonghwi,
