Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2067FC0044D
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF09F2084F
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="LG8g+Sey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfLDHLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:11:09 -0500
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:23361
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfLDHLI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Dec 2019 02:11:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK8ADGoMo20vUXHIQI4NBiobnJWOkoR6qZEDZdA7uxb7sI9rbEvAoicFfHYhkza4nEtdv+3FHlBdOJeyWNM/vVKymz9A2To9EYN58wnQcPpvlHXIdIwCNJKYEvR/ep66ihqaD9PrpbIZ5MX71LJGT6t5K0UYM/7Inj94VJmLcGjpv1DXmBRwGLth53yf6RsicbPj7EZvGtBcYWqoLXlOMFuS2Tl6cilzFH725glUQb3ZDrRUuucTpLR29SJcS134Nk+fJbuBBSxCHVVeMYFvyhDJOMyyaPPq7liDVB+k6QuDa+XYikGw5rffEGtdhXRHu7L6AhMNSdzuDGw9Ds2TsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/L1s+6Zyyh0icNiqHibaC1USTb6zbT6Bd3LIiulJjQ=;
 b=Ou3wRTr2r/f5uc+DKSB9DuvSoC5kgMOafeCTpoMW5CsUiuankY5qJlzYzdDMoROnZmkRR+Hc0x/w9TW7SYQQXTQ2CtlT71cpydx2KmQ8zCoqbKWDAJhZ3JXZ1zZfZcS3M1Sp0dSkXlRqQMHgX8CpcTVqGmv0K2JkgrXy0aZT/pyC4NzN+gOhYOvYVF6jItzKAxTli5S8AV+dBKLFVGuUcpu3/REcgsq4W4L2yFbeBu/i8cucoeN58uNisDwr6v98nN2lTThRFE3DdWxKBmcgTpeeQ3ek9oSV6Yhms4/nAjlIGSiIOedJk6eVCgAe671pz1BchZMFYP5sxBQpOT45fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/L1s+6Zyyh0icNiqHibaC1USTb6zbT6Bd3LIiulJjQ=;
 b=LG8g+SeyHIKJwd9AjIwXqZvdBWubqdwvvP562uzAfDwM80HrBkhskA9ccpyVJ9dxaJ7x0HFSYbp/TiKA1c5CWwpkVo/WT+etmPkWATHfiQKL7T8aLiqdoq6qKVktGBd+br1BbA/Qjg3VRQTZMe4FeUTyIa86DE+/ltybp4/akrU=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB3719.namprd03.prod.outlook.com (52.135.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 07:11:05 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:11:04 +0000
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
Thread-Index: AQHVqR6bSNy8xcyAyESfm+a1vx+I5KensdkAgAAQtICAAFjjgIAAB4wAgAAE9QCAADqtgIABKzyA
Date:   Wed, 4 Dec 2019 07:11:04 +0000
Message-ID: <20191204145709.34e42f56@xhacker.debian>
References: <20191202144104.5069-1-jun.nie@linaro.org>
        <20191202144104.5069-5-jun.nie@linaro.org>
        <20191203103320.273a7309@xhacker.debian>
        <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
        <20191203165123.4e6f9e28@xhacker.debian>
        <20191203091824.GA4685@infradead.org>
        <20191203172434.39b2c2c2@xhacker.debian>
        <20191203130609.GA2144@infradead.org>
In-Reply-To: <20191203130609.GA2144@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::32) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e162b7c2-71dd-4716-09af-08d778892041
x-ms-traffictypediagnostic: BYAPR03MB3719:
x-microsoft-antispam-prvs: <BYAPR03MB3719361EB266BCBE601EC981ED5D0@BYAPR03MB3719.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(51874003)(189003)(199004)(6436002)(9686003)(2906002)(6246003)(54906003)(6486002)(6116002)(4326008)(102836004)(256004)(66946007)(76176011)(3846002)(6512007)(71190400001)(5660300002)(71200400001)(66446008)(64756008)(66556008)(66476007)(52116002)(478600001)(50226002)(14454004)(316002)(6916009)(25786009)(186003)(4744005)(99286004)(305945005)(386003)(7736002)(6506007)(8676002)(8936002)(81166006)(7416002)(446003)(86362001)(11346002)(229853002)(81156014)(26005)(1076003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3719;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ds3v3pX44hgUC+rJoBiMgpgpR1Jwhgfqa8KE1yOYw0cM+739bR8ROdQh5V1q6bAQOlJ2XuMpR+1qS90mLljT+STmjCP8C28pfUVTpwqM5w1Aug+ns5+yJMMumAAz0YrX7ZXyU5arykqBOSj7mtL/rv3d6ibtmOpdvI2rOXQ95RPSj4X76J+pVogrlSB5e83qzCdP7SVTNk9QKy8PN2COFB7e1freP8Sv+/KSlIf9SLnKtCUh+SG5M44Rle5IBDP4Nguhb6nuNxq17O64huY6eRDZZ0tn92DVugQMmvbO1w22mzKa67GZGP3aVh1nZ3ugMXZw0zlyjfdPzgtHbHOzYuulu+gxdCj4hL4qEEkWSuoVpAf6s4p/8zuK4LZ+gtTGODU7qhupftxiy2h2JpEVXC3s/SQkeOG1EVh7RaWMPg1EzNYo2h89dK8dnE7JSe/KRyK3LTW0rAq1mE/C555lDnk/MNyTfJFPbGH7lVPebHwbIu+8nQMS2BIoOb+JSFJeE12TCsfbrh2mie1HEf8Ng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E328B430D6EEBE469FC9141252210664@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e162b7c2-71dd-4716-09af-08d778892041
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:11:04.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uChLndwhnd1rnS2jyMw19g9LhW43/p84TMgBC+m80kYLBb9248nLrt7qujY2kv6RJIqp6N/o5Acfr3+aSStIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3719
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph

On Tue, 3 Dec 2019 05:06:09 -0800 Christoph Hellwig wrote:


>=20
> On Tue, Dec 03, 2019 at 09:49:49AM +0000, Jisheng Zhang wrote:
> > > As in exactly one boundary and not an alignment?  Where the one
> > > boundary is not a power of two and thus can't be expressed? =20
> >
> > Take drivers/mmc/host/sdhci-of-dwcmshc.c for example, target physical D=
MA addr
> > can't span 128MB, 256MB, 128*3MB, ...128*nMB
> >
> > I'm not sure whether blk_queue_segment_boundary could solve this limita=
tion. =20
>=20
> That is exaxtly the kind of limitation blk_queue_segment_boundary is
> intended for.

Until after dma_map_sg(), we can't know the physical DMA address range, so
how does block layer know and check the DMA range beforehand? I'm a newbie =
on
block layer, could you please teach me? At the same time
I'm reading the code as well.

Thanks in advance

