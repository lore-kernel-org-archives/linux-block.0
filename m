Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF56AC77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjESGaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:30:16 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A91B7
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:30:13 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230519063012epoutp04852b85d12c4a730f8c4c62adf1460a94~gd6U_ip_h1851518515epoutp04J
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:30:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230519063012epoutp04852b85d12c4a730f8c4c62adf1460a94~gd6U_ip_h1851518515epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684477812;
        bh=o4da9PMV9sUyhXIbhCsgBkHjgdgCeAZD7VCu0g/Q6k4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ikWbhSaAMkQdB06qZrGFZMxp0ud0HbmBA+YWyLmsHOK3tK/938/Zwp/fUWoqcOypB
         GgAy7qZkyHSLJClR6KU7zSwE4aGPaYsphnP3Z3ql5zINr3qGZHlUecuZTKx1HFa3ES
         PqjsTqqKYgDFnNViiAsnqqgEJlBoRjeedJmcN95Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230519063011epcas2p4dacebd8d5a378bd6a254c4b309f9d6a7~gd6UjRunz0816108161epcas2p4D;
        Fri, 19 May 2023 06:30:11 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QMxm31SKVz4x9QG; Fri, 19 May
        2023 06:30:11 +0000 (GMT)
X-AuditID: b6c32a48-2735aa800000acbc-9d-64671773ca3a
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.A3.44220.37717646; Fri, 19 May 2023 15:30:11 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 8/8] block: don't pass a bio to bio_try_merge_hw_seg
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-9-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519063010epcms2p8f12b2da130d8d9e872d848d1b1a7608e@epcms2p8>
Date:   Fri, 19 May 2023 15:30:10 +0900
X-CMS-MailID: 20230519063010epcms2p8f12b2da130d8d9e872d848d1b1a7608e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmmW6xeHqKwZ/pHBar7/azWbw8pGmx
        cvVRJou9t7QdWDwuny312H2zgc2jb8sqRo/Pm+QCWKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjNmXHjDVnCTp+L2x7XsDYwLeboYOTkk
        BEwkTi9dxNbFyMUhJLCDUWL50j9MXYwcHLwCghJ/dwiD1AgLeEjM+vuHBcQWElCSOLdmFiNI
        ibCAgcStXnOQMJuAnsTPJTPYQGwRAQeJ2RuWgtnMAvYSe2+3MkKs4pWY0f6UBcKWlti+fCtY
        nFPASGJ122FmiLiGxI9lvVC2qMTN1W/ZYez3x+ZDzRGRaL13FqpGUOLBz91QcUmJQ4e+soGc
        JiGQL7HhQCBEuEbi7fIDUCX6Etc6NoKdwCvgK/Hs6nSwMSwCqhJf3h1nhahxkbjzfSYjxPna
        EssWvmYGGcksoCmxfpc+xHRliSO3WCAq+CQ6Dv9lh3mwYeNvrOwd854wQbSqSSxqMprAqDwL
        EcizkKyahbBqASPzKkax1ILi3PTUYqMCE3i8JufnbmIEpzotjx2Ms99+0DvEyMTBeIhRgoNZ
        SYQ3sC85RYg3JbGyKrUoP76oNCe1+BCjKdCTE5mlRJPzgck2ryTe0MTSwMTMzNDcyNTAXEmc
        92OHcoqQQHpiSWp2ampBahFMHxMHp1QD05qIxz7fv/Ef/Kh7me9hskbAbKtVgb3ZW3h//3ii
        OmmS+T3rfc3+e6c+YVBKVust1/70vP5B6+QyWe2eJm4ZTr7mXS4T8npfZd79m5mx9aCXceP2
        wjbmAy/nxYjLvr7Es4D78Zac9trKYJeL/H9mLRMN66o2CWJ48W1D3KemExsUc12PKRq+3rqH
        aYPd5G06iQaL5MSdr23YnOoy/5CHt/ObSm3VXW9+KL36Y//7+vJAAf7cyGv7TzZEz3SUtans
        OPpEtNXLtflz55S3bgc5Kk/IeZQ5zdVROH/0m4TPcf7T05Xv//Gt0hO74avTzbQk3M/Vy3bO
        fK9azTtZf1lEZG0m8zBvfNL74McuUQMBJZbijERDLeai4kQAewizsP4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133934epcas2p37a7ab3dc1dc86e85415995a142512f60
References: <20230512133901.1053543-9-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133934epcas2p37a7ab3dc1dc86e85415995a142512f60@epcms2p8>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>=40=40 -934,11 +934,10 =40=40 static bool bvec_try_merge_page(struct bio_v=
ec *bv, struct page *page,
> =C2=A0*=20size=20limit.=20=C2=A0This=20is=20not=20for=20normal=20read/wri=
te=20bios,=20but=20for=20passthrough=0D=0A>=20=C2=A0*=20or=20Zone=20Append=
=20operations=20that=20we=20can't=20split.=0D=0A>=20=C2=A0*/=0D=0A>-static=
=20bool=20bio_try_merge_hw_seg(struct=20request_queue=20*q,=20struct=20bio=
=20*bio,=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20struct=20page=20*page,=20unsigned=20len,=0D=0A>-=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20offs=
et,=20bool=20*same_page)=0D=0A>+static=20bool=20bvec_try_merge_hw_page(stru=
ct=20request_queue=20*q,=20struct=20bio_vec=20*bv,=0D=0A>+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20page=20*p=
age,=20unsigned=20len,=20unsigned=20offset,=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bool=20*same_page)=0D=0A>=
=20=7B=0D=0A=0D=0AThere=20is=20a=20static=20because=20there=20is=20no=20ext=
ernal=20call=20based=20on=20the=20current=20change=20point.=0D=0ASo,=20I=20=
will=20modify=20it=20when=20using=20this=20function=20later.=0D=0AThank=20y=
ou=20for=20organizing=20the=20functions=20that=20can=20be=20used=20for=20co=
mmon=20use.=0D=0A=0D=0ALooks=20good=20to=20me,=0D=0A=0D=0AReviewed-by:=20Ji=
nyoung=20Choi=20<j-young.choi=40samsung.com>
