Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05769C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FE92184A
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uNBGCnxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfBAIWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:22:44 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59668 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfBAIWn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 03:22:43 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190201082240epoutp04abcd93da790806d7aa505b8327d68699~-L859jS_t0647506475epoutp042
        for <linux-block@vger.kernel.org>; Fri,  1 Feb 2019 08:22:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190201082240epoutp04abcd93da790806d7aa505b8327d68699~-L859jS_t0647506475epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549009360;
        bh=ZVGjKcuEOHK3meo3LF73hm7WWFj5PuQ85mMWZ/W2PQU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uNBGCnxoiIf2wQwYctQULLxy4uA/VdKuYUghn4MrZz/0kDPUfT4SO8makqOPUs8Vf
         IuYQMkk8YbWz+4AjpNTHZe0+1zcA2u5JsKwFmjbCrVTdKsL747JwvES+qnBurtpO2n
         RhJSjs8qNtn1k3WA6hW4XIPXFxE/wBVKZror38LE=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.187]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190201082238epcas2p4b84acf39f0f4ea8e45bc09f276300a79~-L83r4vlP2446424464epcas2p4c;
        Fri,  1 Feb 2019 08:22:38 +0000 (GMT)
X-AuditID: b6c32a48-5e1469c000000ffd-00-5c5401cdeeae
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.34.04093.DC1045C5; Fri,  1 Feb 2019 17:22:37 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] lightnvm: pblk: fix bio leak on large sized io
Reply-To: chansol.kim@samsung.com
From:   Chansol Kim <chansol.kim@samsung.com>
To:     =?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "javier@javigon.com" <javier@javigon.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <0fd83092-515e-7e59-bc38-66e1d3b5d9c1@lightnvm.io>
X-Drm-Type: Y,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190201082237epcms2p1b58a31cca3f4c130d92f61b5dcf1ca6b@epcms2p1>
Date:   Fri, 01 Feb 2019 17:22:37 +0900
X-CMS-MailID: 20190201082237epcms2p1b58a31cca3f4c130d92f61b5dcf1ca6b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmme5ZxpAYgyv7zSw6T19gsth7S9ti
        QttXZosV24+wOLB4NC+4w+LRffUHo8fnTXIe7Qe6mQJYonJsMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4A2KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslVILUnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjImHHrOXDDFrOLz7i3MDYy3TboY
        OTkkBEwkZh2czAJiCwnsYJTofR/excjBwSsgKPF3hzBIWFjAWeLOrJ3sECWKEj2L5rBAxHUl
        nt3uB4uzCWhLbNg4gRnEFhGokHj7pAmshlkgReLftS5miFW8EjPan7JA2NIS25dvZQSxOQXs
        Ja7OOcUIEReVaG16zAxjvz82HyouItF67yxUXFDiwc/dUHFJiR0LjjOCnCwhUC+x+apEFyMX
        kNnDKPFq2Rx2iBp9iWsdG8H28gr4SvR032YFsVkEVCX6v1xmg6hxkdh0vo0J4mZtiWULXzOD
        zGQW0JRYv0sfIswn0XH4LzvMKzvmPWGCsFUl3t6dwgrzVlP/LqiRHhJz931nAblHSOAUo8TK
        nr1MExjlZyFCdxaSbbMQti1gZF7FKJZaUJybnlpsVGCCHJ+bGMEJTstjB+OBcz6HGAU4GJV4
        eDf8CooRYk0sK67MPcQowcGsJMIr+y84Rog3JbGyKrUoP76oNCe1+BCjKdDTE5mlRJPzgck3
        ryTe0NTIzMzA0tTC1MzIQkmc96H03GghgfTEktTs1NSC1CKYPiYOTqkGxn1Fkstcsq5dXXBw
        zt6ceT9vOKVksyWeXLzsXiHfoahIoVMNHOvkCz9Z5dZPUZ4WslTDTs3gsv31Cc9vnLCyrjU4
        +MJof4mvW1Xr/9kf8zUuxG6Zx3pKVqlMWf+j341ymUv70rPO68/geSMy9+bEvfHTrrFFJyx0
        Tv5R+OqkVHGq4P8Q0biHh5VYijMSDbWYi4oTASD82laGAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a
References: <0fd83092-515e-7e59-bc38-66e1d3b5d9c1@lightnvm.io>
        <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
        <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 01/31/19 22:14 PM, Matias Bj=C3=B8rling=20wrote:=0D=0A>=20On=201/30/19=
=202:53=20AM,=20=EA=B9=80=EC=B0=AC=EC=86=94=20wrote:=0D=0A>>=20=0D=0A>>=20C=
hanges:=0D=0A>>=20=20=201.=20Function=20pblk_rw_io=20to=20get=20bio*=20as=
=20a=20reference=0D=0A>>=20=20=202.=20In=20pblk_rw_io=20bio_put=20call=20on=
=20read=20case=20removed=0D=0A>>=20=0D=0A>>=20A=20fix=20to=20address=20issu=
e=20where=0D=0A>>=20=20=201.=20pblk_make_rq=20calls=20pblk_rw_io=20passes=
=20bio*=20pointer=20as=20a=20value=20(0xA)=0D=0A>>=20=20=202.=20pblk_rw_io=
=20calls=20blk_queue_split=20passing=20bio*=20pointer=20as=20reference=0D=
=0A>>=20=20=203.=20In=20blk_queue_split,=20when=20there=20is=20a=20split,=
=20the=20original=20bio*=20(0xA)=0D=0A>>=20=20=20=20=20=20is=20passed=20to=
=20generic_make_requests,=20and=20the=20newly=20allocated=20bio=20is=0D=0A>=
>=20=20=20=20=20=20returned=0D=0A>>=20=20=204.=20If=20NVM_IO_DONE=20returne=
d,=20pblk_make_rq=20calls=20bio_endio=20on=20the=20bio*,=0D=0A>>=20=20=20=
=20=20=20that=20is=20not=20the=20one=20returned=20by=20blk_queue_split=0D=
=0A>>=20=20=205.=20As=20a=20result=20bio_endio=20is=20not=20called=20on=20t=
he=20newly=20allocated=20bio.=0D=0A>>=20=0D=0A>>=20Signed-off-by:=20chansol=
.kim=20<chansol.kim=40samsung.com>=0D=0A>>=20---=0D=0A>>=20=20=20drivers/li=
ghtnvm/pblk-init.c=20=7C=2022=20++++++++--------------=0D=0A>>=20=20=201=20=
file=20changed,=208=20insertions(+),=2014=20deletions(-)=0D=0A>>=20=0D=0A>>=
=20diff=20--git=20a/drivers/lightnvm/pblk-init.c=20b/drivers/lightnvm/pblk-=
init.c=0D=0A>>=20index=20b57f764d..4efc929=20100644=0D=0A>>=20---=20a/drive=
rs/lightnvm/pblk-init.c=0D=0A>>=20+++=20b/drivers/lightnvm/pblk-init.c=0D=
=0A>>=20=40=40=20-31,30=20+31,24=20=40=40=20static=20DECLARE_RWSEM(pblk_loc=
k);=0D=0A>>=20=20=20struct=20bio_set=20pblk_bio_set;=0D=0A>>=20=20=20=0D=0A=
>>=20=20=20static=20int=20pblk_rw_io(struct=20request_queue=20*q,=20struct=
=20pblk=20*pblk,=0D=0A>>=20-=09=09=09=20=20struct=20bio=20*bio)=0D=0A>>=20+=
=09=09=09=20=20struct=20bio=20**bio)=0D=0A>>=20=20=20=7B=0D=0A>>=20-=09int=
=20ret;=0D=0A>>=20-=0D=0A>>=20=20=20=09/*=20Read=20requests=20must=20be=20<=
=3D=20256kb=20due=20to=20NVMe's=2064=20bit=20completion=20bitmap=0D=0A>>=20=
=20=20=09=20*=20constraint.=20Writes=20can=20be=20of=20arbitrary=20size.=0D=
=0A>>=20=20=20=09=20*/=0D=0A>>=20-=09if=20(bio_data_dir(bio)=20=3D=3D=20REA=
D)=20=7B=0D=0A>>=20-=09=09blk_queue_split(q,=20&bio);=0D=0A>>=20-=09=09ret=
=20=3D=20pblk_submit_read(pblk,=20bio);=0D=0A>>=20-=09=09if=20(ret=20=3D=3D=
=20NVM_IO_DONE=20&&=20bio_flagged(bio,=20BIO_CLONED))=0D=0A>>=20-=09=09=09b=
io_put(bio);=0D=0A>=0D=0A>=20Could=20we=20kill=20the=20NVM_DONE_IO=20check=
=20in=20the=20pblk_rw_io,=20that=20should=20=0D=0A>=20achieve=20the=20same?=
=0D=0A=0D=0AI=20think=20it=20is=20possible=20to=20remove=20NVM_DONE_IO=20ch=
eck=20here.=20And=20in=20that=0D=0Acase=20perhaps=20it=20is=20necessary=20t=
o=20change=20bio_endio=20call=20to=20somewhere=20other=0D=0Athan=20pblk_mak=
e_rq,=20otherwise=20endio=20call=20would=20not=20be=20made=20to=20the=20new=
=0D=0Abio*.=0D=0A=0D=0AAssuming=20pblk_rw_io's=20second=20parameter=20is=20=
to=20be=20remained=20as=20bio*,=20There=0D=0Aare=20three=20cases=20I=20thin=
k=20needs=20consideration.=20NVM_IO_ERROR=20return=20case,=0D=0Athe=20read=
=20case=20and=20the=20write=20case.=0D=0A=0D=0AIn=20NVM_IO_ERROR=20return=
=20case,=20for=20both=20read=20and=20write.=20NVM_IO_ERROR=0D=0Areceived=20=
by=20pblk_make_rq=20and=20bio_io_error=20called=20on=20bio,=20since=20this=
=20bio*=0D=0Athat=20pblk_submit_read=20and=20pblk_write_to_cache=20function=
=20tried=20and=20failed=0D=0Amight=20be=20a=20new=20one,=20so=20bio_io_erro=
r=20call=20needs=20to=20be=20made=20inside=0D=0Apblk_rw_io.=0D=0A=0D=0AIn=
=20read=20case,=20there=20are=20three=20sub-cases.=20The=20first=20is=20All=
=20data=20is=20available=0D=0Ain=20ring=20buffer=20and=20NVM_IO_DONE=20is=
=20returned.=20The=20second=20is=20all=20to=20be=20read=0D=0Afrom=20the=20d=
evice,=20which=20currently=20NVM_IO_OK=20is=20returned=20and=20endio=20is=
=0D=0Acalled=20after=20read=20completion=20from=20the=20device.=20The=20thi=
rd=20is=20partial=20read,=0D=0Awhere=20the=20data=20that=20needs=20to=20be=
=20read=20from=20the=20device=20is=20read=0D=0Asynchronously=20and=20pblk_r=
w_io=20returns=20NVM_IO_DONE.=0D=0A=0D=0AIn=20write=20case,=20there=20are=
=20two=20sub-cases.=20Firstly,=20non=20REQ_PRE_FLUSH=20case,=0D=0Apblk_writ=
e_cache=20wil=20return=20either=20NVM_IO_DONE=20or=20NVM_IO_ERROR.=20A=20en=
dio=0D=0Acall=20is=20required=20in=20place=20somewhere=20NVM_IO_DONE=20is=
=20decided.=20=0D=0A=0D=0AFor=20REQ_PREFLUSH=20case=20bio=20(new=20bio*=20i=
f=20split)=20is=20added=20to=20w_ctx.bios,=0D=0Apblk_write_to_cache=20will=
=20return=20either=20NVM_IO_OK=20or=20NVM_IO_ERROR.=20bio*=0D=0Aadded=20to=
=20w_ctx.bios=20will=20be=20called=20by=20bio_endio=20on=20write=20completi=
on=20to=0D=0Athe=20disk.=20So=20it=20is=20already=20taken=20care=20of.=0D=
=0A=0D=0AIn=20summary=20my=20feeling=20is=20that=20having=20pblk_rw_io=20re=
ceive=20bio*=20as=20a=0D=0Areference=20and=20removing=20bio_put=20in=20pblk=
_rw_io=20would=20be=20the=20minimum=0D=0Achange.=20Please=20share=20your=20=
insight,=20I=20will=20try=20experimenting=20alternatives.=0D=0A>=0D=0A>>=20=
-=0D=0A>>=20-=09=09return=20ret;=0D=0A>>=20+=09if=20(bio_data_dir(*bio)=20=
=3D=3D=20READ)=20=7B=0D=0A>>=20+=09=09blk_queue_split(q,=20bio);=0D=0A>>=20=
+=09=09return=20pblk_submit_read(pblk,=20*bio);=0D=0A>>=20=20=20=09=7D=0D=
=0A>>=20=20=20=0D=0A>>=20=20=20=09/*=20Prevent=20deadlock=20in=20the=20case=
=20of=20a=20modest=20LUN=20configuration=20and=20large=0D=0A>>=20=20=20=09=
=20*=20user=20I/Os.=20Unless=20stalled,=20the=20rate=20limiter=20leaves=20a=
t=20least=20256KB=0D=0A>>=20=20=20=09=20*=20available=20for=20user=20I/O.=
=0D=0A>>=20=20=20=09=20*/=0D=0A>>=20-=09if=20(pblk_get_secs(bio)=20>=20pblk=
_rl_max_io(&pblk->rl))=0D=0A>>=20-=09=09blk_queue_split(q,=20&bio);=0D=0A>>=
=20+=09if=20(pblk_get_secs(*bio)=20>=20pblk_rl_max_io(&pblk->rl))=0D=0A>>=
=20+=09=09blk_queue_split(q,=20bio);=0D=0A>>=20=20=20=0D=0A>>=20-=09return=
=20pblk_write_to_cache(pblk,=20bio,=20PBLK_IOTYPE_USER);=0D=0A>>=20+=09retu=
rn=20pblk_write_to_cache(pblk,=20*bio,=20PBLK_IOTYPE_USER);=0D=0A>>=20=20=
=20=7D=0D=0A>>=20=20=20=0D=0A>>=20=20=20static=20blk_qc_t=20pblk_make_rq(st=
ruct=20request_queue=20*q,=20struct=20bio=20*bio)=0D=0A>>=20=40=40=20-69,7=
=20+63,7=20=40=40=20static=20blk_qc_t=20pblk_make_rq(struct=20request_queue=
=20*q,=20struct=20bio=20*bio)=0D=0A>>=20=20=20=09=09=7D=0D=0A>>=20=20=20=09=
=7D=0D=0A>>=20=20=20=0D=0A>>=20-=09switch=20(pblk_rw_io(q,=20pblk,=20bio))=
=20=7B=0D=0A>>=20+=09switch=20(pblk_rw_io(q,=20pblk,=20&bio))=20=7B=0D=0A>>=
=20=20=20=09case=20NVM_IO_ERR:=0D=0A>>=20=20=20=09=09bio_io_error(bio);=0D=
=0A>>=20=20=20=09=09break;=0D=0A>>=20=0D=0A
