Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC718C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7720844
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 11:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kcUhYpi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfBKLOe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:14:34 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42274 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKLOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 06:14:34 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190211111429epoutp04b219e861c32dc032ff9a073b66c6c42f~CSvxzTxtU2731327313epoutp04L
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:14:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190211111429epoutp04b219e861c32dc032ff9a073b66c6c42f~CSvxzTxtU2731327313epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549883669;
        bh=cL/nG2LOxGmZHX7nl5Usqp9NojLLUGhHMBH2+wLTMjI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=kcUhYpi62LtHThBS/j4C7WhDMIKnOjBUdHkYMdfsigJ56eoqYScIfiwGWRTNCeAq4
         XirY3H+dpjV21cXoYvLyqn8K9pz2nc1XWsdVsFTF1Yx1S3XRa9EfBrFu72yqc7lNJO
         dnuCmXGMCKwsmMXYNQyL0gv/lX31G4Q+YiWns5Jw=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.190]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190211111427epcas2p344844ef23ed3a24c7c1d56024bf1c1ad~CSvvlMeKq2250622506epcas2p3L;
        Mon, 11 Feb 2019 11:14:27 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-bc-5c6159134db5
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.AF.04136.319516C5; Mon, 11 Feb 2019 20:14:27 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] lightnvm: pblk: fix bio leak on large sized io
Reply-To: chansol.kim@samsung.com
From:   Chansol Kim <chansol.kim@samsung.com>
To:     =?UTF-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        =?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <0205AB4D-7055-45E4-935D-E858EA2CA9AD@javigon.com>
X-Drm-Type: Y,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190211111427epcms2p7e2f59a094414ec713dd98edf6ccfe9a0@epcms2p7>
Date:   Mon, 11 Feb 2019 20:14:27 +0900
X-CMS-MailID: 20190211111427epcms2p7e2f59a094414ec713dd98edf6ccfe9a0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmqa5wZGKMwfsVshadpy8wWey9pW2x
        YvsRFgdmj+YFd1g8uq/+YPT4vEkugDkqxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQ
        sECvODG3uDQvXS85P9fK0MDAyBSoMiEnY1LrLtaC5dYV699cYWlgvGfZxcjJISFgIrGqYTFL
        FyMXh5DADkaJqbMXMXYxcnDwCghK/N0hDFIjLOAscWfWTnYQW0hAUaJn0RwWiLiuxLPb/WBx
        NgFtiQ0bJzCD2CICZRIHNx4Cs5kF7CX23m5lhNjFKzGj/SkLhC0tsX35VrA4J1BN76vdUHFR
        idamx8ww9vtj86F6RSRa752FigtKPPi5GyouKbFjwXGwkyUE6iU2X5UAeUVCoIdR4tWyOewQ
        NfoS1zo2gs3nFfCVaH+9gBXEZhFQlXh0bhHUXheJ67+3sEDcrC2xbOFrZpCZzAKaEut36UOE
        +SQ6Dv9lh3llx7wnTBC2qsTbu1NYYd5q6t/FBmF7SMzd950FEmw/mCQ+H1eewCg/CxG4s5As
        m4WwbAEj8ypGsdSC4tz01GKjAiPk+NzECE5mWm47GJec8znEKMDBqMTD+yExIUaINbGsuDL3
        EKMEB7OSCG+ob2KMEG9KYmVValF+fFFpTmrxIUZToJ8nMkuJJucDE21eSbyhqZGZmYGlqYWp
        mZGFkjjvQ+m50UIC6YklqdmpqQWpRTB9TBycUg2MrTIXnZuq7Sf82jIzSYExWMlpRYiw1LqL
        cYGlhZ52874biS37lhr4xjF0wsZQH3Gmrx28ezmELzY/ryni+8p4//5Kjtc3pEufJe3RvmDO
        zcci9CIvpND69rRerlyG9S6y3vy5DMJspmsPbrvi4dz3O9b1YsOTWX4OeorL9riHPb5ySlhg
        ubUSS3FGoqEWc1FxIgCoZHrYfAMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a
References: <0205AB4D-7055-45E4-935D-E858EA2CA9AD@javigon.com>
        <0fd83092-515e-7e59-bc38-66e1d3b5d9c1@lightnvm.io>
        <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
        <20190201082237epcms2p1b58a31cca3f4c130d92f61b5dcf1ca6b@epcms2p1>
        <8d8bae48-be1f-a211-0a62-a5421c77d818@lightnvm.io>
        <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p7>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/05/19 11:20 AM, Javier Gonz=C3=A1lez=20wrote:=0D=0A>=0D=0A>>=20On=205=
=20Feb=202019,=20at=2010.23,=20Matias=20Bj=C3=B8rling=20<mb=40lightnvm.io>=
=20wrote:=0D=0A>>=20=0D=0A>>=20On=202/1/19=209:22=20AM,=20Chansol=20Kim=20w=
rote:=0D=0A>>>=20On=2001/31/19=2022:14=20PM,=20Matias=20Bj=C3=B8rling=20wro=
te:=0D=0A>>>>=20On=201/30/19=202:53=20AM,=20=EA=B9=80=EC=B0=AC=EC=86=94=20w=
rote:=0D=0A>>>>>=20Changes:=0D=0A>>>>>=20=20=201.=20Function=20pblk_rw_io=
=20to=20get=20bio*=20as=20a=20reference=0D=0A>>>>>=20=20=202.=20In=20pblk_r=
w_io=20bio_put=20call=20on=20read=20case=20removed=0D=0A>>>>>=20=0D=0A>>>>>=
=20A=20fix=20to=20address=20issue=20where=0D=0A>>>>>=20=20=201.=20pblk_make=
_rq=20calls=20pblk_rw_io=20passes=20bio*=20pointer=20as=20a=20value=20(0xA)=
=0D=0A>>>>>=20=20=202.=20pblk_rw_io=20calls=20blk_queue_split=20passing=20b=
io*=20pointer=20as=20reference=0D=0A>>>>>=20=20=203.=20In=20blk_queue_split=
,=20when=20there=20is=20a=20split,=20the=20original=20bio*=20(0xA)=0D=0A>>>=
>>=20=20=20=20=20=20is=20passed=20to=20generic_make_requests,=20and=20the=
=20newly=20allocated=20bio=20is=0D=0A>>>>>=20=20=20=20=20=20returned=0D=0A>=
>>>>=20=20=204.=20If=20NVM_IO_DONE=20returned,=20pblk_make_rq=20calls=20bio=
_endio=20on=20the=20bio*,=0D=0A>>>>>=20=20=20=20=20=20that=20is=20not=20the=
=20one=20returned=20by=20blk_queue_split=0D=0A>>>>>=20=20=205.=20As=20a=20r=
esult=20bio_endio=20is=20not=20called=20on=20the=20newly=20allocated=20bio.=
=0D=0A>>>>>=20=0D=0A>>>>>=20Signed-off-by:=20chansol.kim=20<chansol.kim=40s=
amsung.com>=0D=0A>>>>>=20---=0D=0A>>>>>=20=20=20drivers/lightnvm/pblk-init.=
c=20=7C=2022=20++++++++--------------=0D=0A>>>>>=20=20=201=20file=20changed=
,=208=20insertions(+),=2014=20deletions(-)=0D=0A>>>>>=20=0D=0A>>>>>=20diff=
=20--git=20a/drivers/lightnvm/pblk-init.c=20b/drivers/lightnvm/pblk-init.c=
=0D=0A>>>>>=20index=20b57f764d..4efc929=20100644=0D=0A>>>>>=20---=20a/drive=
rs/lightnvm/pblk-init.c=0D=0A>>>>>=20+++=20b/drivers/lightnvm/pblk-init.c=
=0D=0A>>>>>=20=40=40=20-31,30=20+31,24=20=40=40=20static=20DECLARE_RWSEM(pb=
lk_lock);=0D=0A>>>>>=20=20=20struct=20bio_set=20pblk_bio_set;=0D=0A>>>>>=20=
=20=20=20=20=20static=20int=20pblk_rw_io(struct=20request_queue=20*q,=20str=
uct=20pblk=20*pblk,=0D=0A>>>>>=20-=09=09=09=20=20struct=20bio=20*bio)=0D=0A=
>>>>>=20+=09=09=09=20=20struct=20bio=20**bio)=0D=0A>>>>>=20=20=20=7B=0D=0A>=
>>>>=20-=09int=20ret;=0D=0A>>>>>=20-=0D=0A>>>>>=20=20=20=09/*=20Read=20requ=
ests=20must=20be=20<=3D=20256kb=20due=20to=20NVMe's=2064=20bit=20completion=
=20bitmap=0D=0A>>>>>=20=20=20=09=20*=20constraint.=20Writes=20can=20be=20of=
=20arbitrary=20size.=0D=0A>>>>>=20=20=20=09=20*/=0D=0A>>>>>=20-=09if=20(bio=
_data_dir(bio)=20=3D=3D=20READ)=20=7B=0D=0A>>>>>=20-=09=09blk_queue_split(q=
,=20&bio);=0D=0A>>>>>=20-=09=09ret=20=3D=20pblk_submit_read(pblk,=20bio);=
=0D=0A>>>>>=20-=09=09if=20(ret=20=3D=3D=20NVM_IO_DONE=20&&=20bio_flagged(bi=
o,=20BIO_CLONED))=0D=0A>>>>>=20-=09=09=09bio_put(bio);=0D=0A>>>>=20=0D=0A>>=
>>=20Could=20we=20kill=20the=20NVM_DONE_IO=20check=20in=20the=20pblk_rw_io,=
=20that=20should=0D=0A>>>>=20achieve=20the=20same?=0D=0A>>>=20I=20think=20i=
t=20is=20possible=20to=20remove=20NVM_DONE_IO=20check=20here.=20And=20in=20=
that=0D=0A>>>=20case=20perhaps=20it=20is=20necessary=20to=20change=20bio_en=
dio=20call=20to=20somewhere=20other=0D=0A>>>=20than=20pblk_make_rq,=20other=
wise=20endio=20call=20would=20not=20be=20made=20to=20the=20new=0D=0A>>>=20b=
io*.=0D=0A>>>=20Assuming=20pblk_rw_io's=20second=20parameter=20is=20to=20be=
=20remained=20as=20bio*,=20There=0D=0A>>>=20are=20three=20cases=20I=20think=
=20needs=20consideration.=20NVM_IO_ERROR=20return=20case,=0D=0A>>>=20the=20=
read=20case=20and=20the=20write=20case.=0D=0A>>>=20In=20NVM_IO_ERROR=20retu=
rn=20case,=20for=20both=20read=20and=20write.=20NVM_IO_ERROR=0D=0A>>>=20rec=
eived=20by=20pblk_make_rq=20and=20bio_io_error=20called=20on=20bio,=20since=
=20this=20bio*=0D=0A>>>=20that=20pblk_submit_read=20and=20pblk_write_to_cac=
he=20function=20tried=20and=20failed=0D=0A>>>=20might=20be=20a=20new=20one,=
=20so=20bio_io_error=20call=20needs=20to=20be=20made=20inside=0D=0A>>>=20pb=
lk_rw_io.=0D=0A>>>=20In=20read=20case,=20there=20are=20three=20sub-cases.=
=20The=20first=20is=20All=20data=20is=20available=0D=0A>>>=20in=20ring=20bu=
ffer=20and=20NVM_IO_DONE=20is=20returned.=20The=20second=20is=20all=20to=20=
be=20read=0D=0A>>>=20from=20the=20device,=20which=20currently=20NVM_IO_OK=
=20is=20returned=20and=20endio=20is=0D=0A>>>=20called=20after=20read=20comp=
letion=20from=20the=20device.=20The=20third=20is=20partial=20read,=0D=0A>>>=
=20where=20the=20data=20that=20needs=20to=20be=20read=20from=20the=20device=
=20is=20read=0D=0A>>>=20synchronously=20and=20pblk_rw_io=20returns=20NVM_IO=
_DONE.=0D=0A>>>=20In=20write=20case,=20there=20are=20two=20sub-cases.=20Fir=
stly,=20non=20REQ_PRE_FLUSH=20case,=0D=0A>>>=20pblk_write_cache=20wil=20ret=
urn=20either=20NVM_IO_DONE=20or=20NVM_IO_ERROR.=20A=20endio=0D=0A>>>=20call=
=20is=20required=20in=20place=20somewhere=20NVM_IO_DONE=20is=20decided.=0D=
=0A>>>=20For=20REQ_PREFLUSH=20case=20bio=20(new=20bio*=20if=20split)=20is=
=20added=20to=20w_ctx.bios,=0D=0A>>>=20pblk_write_to_cache=20will=20return=
=20either=20NVM_IO_OK=20or=20NVM_IO_ERROR.=20bio*=0D=0A>>>=20added=20to=20w=
_ctx.bios=20will=20be=20called=20by=20bio_endio=20on=20write=20completion=
=20to=0D=0A>>>=20the=20disk.=20So=20it=20is=20already=20taken=20care=20of.=
=0D=0A>>>=20In=20summary=20my=20feeling=20is=20that=20having=20pblk_rw_io=
=20receive=20bio*=20as=20a=0D=0A>>>=20reference=20and=20removing=20bio_put=
=20in=20pblk_rw_io=20would=20be=20the=20minimum=0D=0A>>>=20change.=20Please=
=20share=20your=20insight,=20I=20will=20try=20experimenting=20alternatives.=
=0D=0A>>=20=0D=0A>>=20What=20rubs=20me=20the=20wrong=20way=20is=20that=20th=
at=20pattern=20isn't=20used=20in=20the=20rest=0D=0A>>=20of=20kernel.=20I=20=
would=20rather=20move=20the=20calls=20to=20bio_io_error=20and=20bio_endio=
=0D=0A>>=20into=20the=20pblk_rw_io()=20function.=20The=20implementation=20o=
f=20pblk_rw_io()=0D=0A>>=20leaks=20out=20to=20pblk_make_rq().=20The=20code=
=20is=20a=20mismatch=20of=20some=20bio_endio=0D=0A>>=20calls=20inside=20the=
=20pblk_rw_io,=20and=20others=20outside.=20It's=20not=20coherent.=0D=0A>=0D=
=0A>=20I=20agree=20that=20NVM_IO_DONE=20is=20now=20more=20confusing=20than=
=20anything=20-=20this=0D=0A>=20comes=20from=20the=20rrpc=20days...=20Remov=
ing=20it=20here=20will=20require=20some=0D=0A>=20refactoring=20on=20the=20p=
artial=20read=20path,=20but=20nothing=20too=20dramatic.=0D=0A>=0D=0A>=20I'm=
=20also=20OK=20with=20unfolding=20pblk_rw_io()=20into=20pblk_make_rq().=0D=
=0A>=0D=0A>=20Chansol:=20do=20you=20want=20to=20give=20it=20a=20go?=0D=0A>=
=0D=0A>=20Javier=0D=0A>=0D=0A=0D=0AMatias,=20like=20you=20mentioned=20and=
=20Javier=20suggested,=20unfolding=20pblk_rw_io=0D=0Awould=20make=20it=20mo=
re=20coherent=20with=20regards=20to=20call=20sites=20of=20bio_endio,=0D=0Ai=
ncluding=20REQ_OP_DISCARD=20with=20REQ_PREFLUSH=20unset=20case.=20pblk_make=
_rq=0D=0Awould=20be=20the=20place=20to=20call=20bio_io_error=20in=20case=20=
of=20NVM_IO_ERR,=20and=20to=0D=0Acall=20bio_endio=20for=20NVM_IO_DONE.=0D=
=0A=0D=0AJavier:=20I=20am=20very=20up=20for=20it.=20Unfolding=20pblk_rw_io=
=20into=20pblk_make_rq=0D=0Afunction.=20I=20will=20make=20the=20change,=20t=
est=20etc,=20and=20submit=20the=20patch=20(with=0D=0Abetter=20comment=20thi=
s=20time).=0D=0A=0D=0AThank=20you.=0D=0A=0D=0AChansol=20Kim
