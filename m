Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF4C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 05:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E276218AC
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 05:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uOrfW/ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfAaFzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:55:11 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38644 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAaFzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 00:55:11 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190131055508epoutp03280a8a0915f076877b4a7f3194884473~_2SzUWyUw0076400764epoutp03D
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 05:55:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190131055508epoutp03280a8a0915f076877b4a7f3194884473~_2SzUWyUw0076400764epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548914108;
        bh=kI+wsXSpy1+MoILTzWtvHjLCoB4Ph4QXDqQu5KV+vDQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uOrfW/ESqWNK0Dgn1XA+IpTWXllZGXK5tNS9eRrUoDCF5kCbbVVanviKGPsQE6Ews
         z8+SpFGmJa9inSzinYoS5lJ/gnGiaB6fWLf3BOD7+FRAZfY0bH172wJFMCFkjHNxa9
         /kzGQpI/exM49DUsZLUDUMLX9A0Gnv3kq/W9z6zE=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.187]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190131055506epcas2p23396476c8db01c48b762f607a3963d2a~_2SxKRAJH1149011490epcas2p20;
        Thu, 31 Jan 2019 05:55:06 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-fc-5c528db95c0a
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.F4.04138.9BD825C5; Thu, 31 Jan 2019 14:55:06 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] lightnvm: pblk: fix bio leak on large sized io
Reply-To: chansol.kim@samsung.com
From:   Chansol Kim <chansol.kim@samsung.com>
To:     =?UTF-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        =?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Chansol Kim <chansol.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matias Bjorling <matias.bjorling@wdc.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1EBBDBD0-E316-4585-A481-51942C75E484@javigon.com>
X-Drm-Type: Y,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190131055505epcms2p2cb0eca76a399ea7213ad949a3b1fac31@epcms2p2>
Date:   Thu, 31 Jan 2019 14:55:05 +0900
X-CMS-MailID: 20190131055505epcms2p2cb0eca76a399ea7213ad949a3b1fac31
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmqe6u3qAYgzMzmCwuHXrLbNF5+gKT
        xd5b2hYT2r4yW6zYfoTFgdWjecEdFo/uqz8YPfq2rGL0+LxJzqP9QDdTAGtUjk1GamJKapFC
        al5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0G4lhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToGhYYFecWJucWleul5yfq6VoYGBkSlQZUJOxqMDHSwF32Qr
        blzaxdTAOEm2i5GTQ0LAROLD/C7WLkYuDiGBHYwSi0/MZOli5ODgFRCU+LtDGKRGWMBZ4s6s
        newgtpCAokTPojksEHFdiWe3+8HibALaEhs2TmAGsUUEyiQObjzEDDKTWWAyo8Sq733MEMt4
        JWa0P2WBsKUlti/fyghicwrYSzTPesgOEReVaG16zAxjvz82nxHCFpFovXcWKi4o8eDnbqi4
        pMSOBccZQW6WEKiX2HxVAmSvhEAPo8SrZXOgZupLXOvYCLaXV8BXYsHOR2wgNouAqsSkN01M
        EDUuEosmPmEFsZmBnlm28DUzyExmAU2J9bv0IcJ8Eh2H/7LDvLJj3hOoVlWJt3ensMK81dS/
        iw3C9pCYu+87CyRs/zNK9B4/yjyBUX4WInhnIdk2C2HbAkbmVYxiqQXFuempxUYFhsgxuokR
        nPi0XHcwzjjnc4hRgINRiYf3wdrAGCHWxLLiytxDjBIczEoivIa//WOEeFMSK6tSi/Lji0pz
        UosPMZoCPT2RWUo0OR+YlPNK4g1NjczMDCxNLUzNjCyUxHkfSc+NFhJITyxJzU5NLUgtgulj
        4uCUamCMnqDd7MIufefOQuHJa6ctDLhWFLCsWCCuWEGQ1/5KmKPS3GOZqjKqS2vvPNloHTLJ
        VbBqVtbTXd2mpup9E5Y9OvI+rmeZ+pLCSepMR76ILJ5+4KpW/NUjF0rXzZZ8sYPXeI5o1cZK
        18cPuS80tbY0p7Xr5i/gUf2fYjpdSjLX8s7ZhBgG5Z1KLMUZiYZazEXFiQAA6D14kgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a
References: <1EBBDBD0-E316-4585-A481-51942C75E484@javigon.com>
        <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
        <5aa5596b-6394-0d09-533b-0365bc064152@lightnvm.io>
        <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p2>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=C2=A0=0D=0A=0D=0A>=20-----Original=20Message-----=0D=0A>=20From:=20Javier=
=20Gonz=C3=A1lez=20=5Bmailto:javier=40javigon.com=5D=0D=0A>=20Sent:=20Thurs=
day,=20January=2031,=202019=2012:02=20AM=0D=0A>=20To:=20Matias=20Bj=C3=B8rl=
ing=20<mb=40lightnvm.io>=0D=0A>=20Cc:=20chansol.kim=40samsung.com;=20linux-=
block=40vger.kernel.org;=20Matias=20Bjorling=20<matias.bjorling=40wdc.com>=
=0D=0A>=20Subject:=20Re:=20=5BPATCH=5D=20lightnvm:=20pblk:=20fix=20bio=20le=
ak=20on=20large=20sized=20io=0D=0A>=20=0D=0A>=20=0D=0A>=20>=20On=2030=20Jan=
=202019,=20at=2015.06,=20Matias=20Bj=C3=B8rling=20<mb=40lightnvm.io>=20wrot=
e:=0D=0A>=20>=0D=0A>=20>=20On=201/30/19=202:53=20AM,=20=EA=B9=80=EC=B0=AC=
=EC=86=94=20wrote:=0D=0A>=20>>=20Changes:=0D=0A>=20>>=20=201.=20Function=20=
pblk_rw_io=20to=20get=20bio*=20as=20a=20reference=20=202.=20In=20pblk_rw_io=
=0D=0A>=20>>=20bio_put=20call=20on=20read=20case=20removed=20A=20fix=20to=
=20address=20issue=20where=20=201.=0D=0A>=20>>=20pblk_make_rq=20calls=20pbl=
k_rw_io=20passes=20bio*=20pointer=20as=20a=20value=20(0xA)=0D=0A>=20>>=202.=
=20pblk_rw_io=20calls=20blk_queue_split=20passing=20bio*=20pointer=20as=20r=
eference=0D=0A>=20>>=203.=20In=20blk_queue_split,=20when=20there=20is=20a=
=20split,=20the=20original=20bio*=20(0xA)=0D=0A>=20>>=20=20=20=20=20is=20pa=
ssed=20to=20generic_make_requests,=20and=20the=20newly=20allocated=20bio=20=
is=0D=0A>=20>>=20=20=20=20=20returned=0D=0A>=20>>=20=204.=20If=20NVM_IO_DON=
E=20returned,=20pblk_make_rq=20calls=20bio_endio=20on=20the=20bio*,=0D=0A>=
=20>>=20=20=20=20=20that=20is=20not=20the=20one=20returned=20by=20blk_queue=
_split=20=205.=20As=20a=20result=0D=0A>=20>>=20bio_endio=20is=20not=20calle=
d=20on=20the=20newly=20allocated=20bio.=0D=0A>=20>=0D=0A>=20>=20The=20commi=
t=20message=20needs=20a=20bit=20of=20massaging.=20The=20Changes:=20paragrap=
h=20is=20not=20needed=20(that=20is=20what=20the=0D=0A>=20patch=20is=20for).=
=20Also,=20please=20redo=20the=20second=20paragraph=20in=20without=20the=20=
bullets.=0D=0A>=20>=0D=0A=0D=0AThank=20you=20for=20comment,=20I=20will=20fo=
rmat=20it=20better.=0D=0A=0D=0A>=20>>=20Signed-off-by:=20chansol.kim=20<cha=
nsol.kim=40samsung.com>=0D=0A>=20>>=20---=0D=0A>=20>>=20=20drivers/lightnvm=
/pblk-init.c=20=7C=2022=20++++++++--------------=0D=0A>=20>>=20=201=20file=
=20changed,=208=20insertions(+),=2014=20deletions(-)=20diff=20--git=0D=0A>=
=20>>=20a/drivers/lightnvm/pblk-init.c=20b/drivers/lightnvm/pblk-init.c=20i=
ndex=0D=0A>=20>>=20b57f764d..4efc929=20100644=0D=0A>=20>>=20---=20a/drivers=
/lightnvm/pblk-init.c=0D=0A>=20>>=20+++=20b/drivers/lightnvm/pblk-init.c=0D=
=0A>=20>>=20=40=40=20-31,30=20+31,24=20=40=40=20static=20DECLARE_RWSEM(pblk=
_lock);=20=20struct=20bio_set=0D=0A>=20>>=20pblk_bio_set;=0D=0A>=20>>=20=20=
=20=20static=20int=20pblk_rw_io(struct=20request_queue=20*q,=20struct=20pbl=
k=20*pblk,=0D=0A>=20>>=20-=09=09=09=20=20struct=20bio=20*bio)=0D=0A>=20>>=
=20+=09=09=09=20=20struct=20bio=20**bio)=0D=0A>=20>=0D=0A>=20>=20I=20am=20n=
ot=20sure=20why=20the=20**bio=20change=20is=20needed.=20Can=20you=20elabora=
te?=0D=0A>=20=0D=0A>=20bio_split=20creates=20a=20new=20bio=20and=20queues=
=20the=20original=20one=20again.=20If=20the=20reference=20is=20not=20update=
d=20then=0D=0A>=20the=20newly=20created=20bio=20is=20never=20freed=20when=
=20NVM_IO_DONE=20is=20returned=20to=20pblk_make_rq(),=20thus=20resulting=20=
on=0D=0A>=20a=20leak.=0D=0A>=20=0D=0A>=20Javier=0D=0A=0D=0AThank=20you=20Ja=
vier=20for=20the=20explanation.=0D=0ADear=20Matias,=20please=20review=20whe=
ther=20the=20above=20change=20is=20acceptabl.=20If=20further=20change=20is=
=20required,=20I=20will=20address=20that=20and=20include=20the=20above=20co=
mmit=20log=20amend=20along=20with=20it.=20Thank=20you.=0D=0A=0D=0ARegards,=
=0D=0AChansol=20Kim=0D=0A
