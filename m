Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE08FC43215
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49D72073F
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="dSWQiZIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLCJtx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:49:53 -0500
Received: from mail-eopbgr740070.outbound.protection.outlook.com ([40.107.74.70]:7427
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfLCJtx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 04:49:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/540CQYG4H1C4ZNvFH9w70ar8SaJWSeELHUyzt7dwgE8ABQV+Gm0Pz65/Rd1MNu5WKV4VPe/f8So16w8ZPM63ibzRVGEfxb9uFbqomy+WCu15JjATNQp3zvyp55NdfDfqhZLTUtkZvFr5rv9Oqik/+mwr8YXSXlMyoZ5iYHputrG5Q+MnF+EnEwrGqjtbA2nyZSxi9dHuvXsBdH9dnL7IfYfhE7DGXJyJ3pKvLzOaLvT5LgJfk8T7jjcKAimHJQmIEKBXLHilUeWChWz+nSbg/ZZmFPavoNU1y0KXzPV01mDKW1Tc+KiBhh/1cfQfg4mRXIckUbmdnzzX+NtWUi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grsJrMwxndfBjGm8unuhhp1/Z35T+n+cHpMf9QgE6I8=;
 b=afULWsdVx+DGFsMWZVP36YGvEFxpMDawztxNUl2EspbTZ0cHAQd09HTAUqV4fYkofX8zvYfO8c4pnnJuE9rDdj3FUt72Vhisu531UHpfWLryp+oWXtxgv6SCtczLBghjct2wPQ9bBOUh3wv/RVtrb/W+qP0JGfqHAwmWhx9lB6zKF2l7hmsiCWul7bW/UepZJz4r2wYeP5JCYSIqTM9ucF1x2Ky/XxXtuOy8RvxApJVQOhrRW1ZYOGxz2dI01wvw5TA6iaJNW0c4mAg26fbtV4UrcUgx4QShjm6Qr+nrqfhLo5t11JwRJTQ2dQ42J0rAM1AKoLgWV/u7L/3/uw3INA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grsJrMwxndfBjGm8unuhhp1/Z35T+n+cHpMf9QgE6I8=;
 b=dSWQiZIwfsJEPja7jGxBc4ucqNKc1eK3PBKAXNJKemJ21pneSPhEIancMDajdfjdhurQFZqFyPvzqd79aeU8IuaENq3kFSbLs+g0mrdRVOSkXXx7iy+fRc1vbFcRczzKrmmvwHidwWHjE4E46lrCDD4whUsiuHhblqiRbIZFGZY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB3669.namprd03.prod.outlook.com (52.135.214.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 09:49:50 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:49:49 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Jun Nie <jun.nie@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Topic: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Index: AQHVqR6bSNy8xcyAyESfm+a1vx+I5KensdkAgAAQtICAAFjjgIAAB4wAgAAE9QA=
Date:   Tue, 3 Dec 2019 09:49:49 +0000
Message-ID: <20191203172434.39b2c2c2@xhacker.debian>
References: <20191202144104.5069-1-jun.nie@linaro.org>
        <20191202144104.5069-5-jun.nie@linaro.org>
        <20191203103320.273a7309@xhacker.debian>
        <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
        <20191203165123.4e6f9e28@xhacker.debian>
        <20191203091824.GA4685@infradead.org>
In-Reply-To: <20191203091824.GA4685@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR0101CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::34) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77c6f793-56d7-4d69-d26a-08d777d6235b
x-ms-traffictypediagnostic: BYAPR03MB3669:
x-microsoft-antispam-prvs: <BYAPR03MB366957E03D020E28B9384D89ED420@BYAPR03MB3669.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(346002)(376002)(136003)(199004)(189003)(51914003)(186003)(6116002)(2906002)(66556008)(50226002)(25786009)(26005)(99286004)(81156014)(8676002)(8936002)(6486002)(54906003)(14454004)(316002)(7416002)(305945005)(7736002)(6436002)(6916009)(5660300002)(71200400001)(256004)(102836004)(76176011)(11346002)(446003)(81166006)(4326008)(229853002)(478600001)(3846002)(71190400001)(6246003)(6512007)(9686003)(86362001)(52116002)(1076003)(66476007)(66446008)(64756008)(66946007)(6506007)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3669;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxMvhSXpKjRvFqTwGE6XFMcCTriKQ3XzExRRYHc81J4Y6cWVHTqkD4GSzsafW/3OHia680Xx9b3V/zY4fenwyD79xu1qKlA7vJDbMehhMDSRimSyPdK/nPSoZUCCOSaU2O4MyvwcNdc2yLviUaRezzIYFPbf2ugaH4a5m4h2BJ/kSfkUK2Y4Le3JhL8DvcRTdvvTyjwyKuLhPV5uQJBEHNdfoppMWBYc+TR1kjpIX2PpxQcP3WwsYHSuZGqVg5nP3FBtQud27a21ZHBiiQ5cZIP5qQcPsDT2OPv+3pUrLD6gaRZKXSpgKZNYJqCvcsnBvqt8ziUoBWs7gJaMkXQQYUIN2uAeFGwL8aq1AL2+CHkRD+ZqV/SN4CNFN00h2dZN3I3b4/ORJOyUHZT462sXMjzBhLNW/MrX4XF/Wiy5ijQ8+LMZpHsBYAyXUlOgQvvo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09136BA606CBC941B11F720DEA16DA6C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c6f793-56d7-4d69-d26a-08d777d6235b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 09:49:49.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OWl1QVdoJTpRe7vmDL3sclqJf2rVADDvdQ9+gFpDy/bmYy4bSZftr9BqcHbHtD8l+QV6iKagaGsOLYc136qjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3669
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 3 Dec 2019 01:18:24 -0800 Christoph Hellwig <hch@infradead.org> wro=
te:


>=20
>=20
> On Tue, Dec 03, 2019 at 09:05:23AM +0000, Jisheng Zhang wrote:
> > > >
> > > > eg. drivers/mmc/host/sdhci-of-dwcmshc.c
> > > > =20
> > > Thanks for the suggestion! Christoph's suggestion can prevent the the=
 issue
> > > from the block layer, thus the code can be shared across all =20
> >
> > To be honest, I did consider similar solution from block layer, I.E set
> > the seg_boundary_mask, when submitting the workaround last year, but pe=
r
> > my understanding, SDHCI limitation is the physical DMA addr can't span =
one
> > specific boundary, =20
>=20
> As in exactly one boundary and not an alignment?  Where the one
> boundary is not a power of two and thus can't be expressed?

Take drivers/mmc/host/sdhci-of-dwcmshc.c for example, target physical DMA a=
ddr
can't span 128MB, 256MB, 128*3MB, ...128*nMB

I'm not sure whether blk_queue_segment_boundary could solve this limitation=
.

>=20
>=20
> > so setting seg_boundary_mask w/ blk_queue_segment_boundary
> > can't work. I'm not sure I understand blk_queue_segment_boundary() prop=
erly.
> > May Christoph help to clarify?
> >
> > From another side, drivers/ata/libata-sff.c also workaround the 64K phy=
 DMA
> > boundary limitation itself rather than from block layer. =20
>=20
> As far as I can tell that workaround should use the segment boundary
> setting as well.

