Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB2AC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C4B20658
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAZV5i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:57:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14292 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395061AbhAZTEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 14:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611688471; x=1643224471;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5v4xiP0nqWto44zxQCDGO6ZsEwYk6UcIuD6FeOJ6LRY=;
  b=SqEBNBjzt6nGMBqd3ZuFXNC3KV4KSvQDBbxmQ9LAEJmgr0p4mJeLbLGy
   1CbII2IuKfFUqjpqgC0qlsOkyyuzqkFs1e6p0ClrV5GEq3o2yv4eUgNT3
   Bl1EBfzPcj8KbeP41cT3vK1p1vEPF3Ds533oydFFcJNnKbW+Jmd53fwYL
   84L/UG6Jqds8SwsSwZf/BoBj+Ed20sV17o/YL3SWjAt3eWK1VOPWLCMyF
   ZFBqSjO+KQHT6NP7rtAgn/o01wOyfl11itIxGvney2HU1cRmez5ov8mGb
   jkqyfTK7bNQYQyWy/PchgBA0VksQWCy242DCnLCHsxan1P5ZtYJpt+SWj
   w==;
IronPort-SDR: UEIt5diac6qw2QZQkSmD7w/xhlVnevpM7QRWWQYM07CZw3cR5BLCfco7zeeKdOOuUPRvQELloZ
 MeoNUeUdDjZ+erwxKXVvI32FNQhXYX/2nF/+GC0d0BL7+Hpo/SHr1Fv8wR5mXgCqL63gZ3Z0Ns
 e2r71aangvWVspTyy6xFJANbZYBDQEh9jvh7fdzSzBRblVXDBRbBHBIcrzS/dsMDn2lS2fswMq
 J4pVGc4eFYhBQF4IyzNE8wkvI1Ofsgd6bPu4yW7pxhQF0EHw29YV7BWXsgfb2pZ1LBwx169vdv
 3XY=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="262397219"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:12:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdrAHCosKo3ONKP+L/Esgi71LtwZdvtcPbKPYkJ9avR7nGieiI7gc9O0yjZwWZiXiQzGUmd3GYU4zttTlmPNuU5+uDB9efQE0uSV42PDO2Km/CvaOVAzdayG4rU5eZbiY5ULU6fEeRzO4pg1Jpcl3m1x7I8jTOvqVEQ8eVNeiEmEo2dqoDIy2PtAh7cWX/bgpxPLAf0ZwyN9Cn4QMcLfYcfYehua5AtW9xZsHMtD8iVzMPO714PdBmw9lcGiRxIhm3FfkP7QP7cN7ds8zkZ9cuhFOkRB7PTRgk6XCa5sVSUimhCdp8KW/GGNPouTOxGr/Ii8il/5ts86JIIAJ+Miyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Q0o5xaowgz4ADQW1R6qr1ddC46G4jCInvodNedYPc=;
 b=kdPH9NBJTXD9Rj2g37gH0xG+R/PaCpDboMspFMYPDLEoyRuV9o54luKIrTLAPygDewjOP3drRDKoodPSiA0RW8OKnMRnDj467hocpnVuA5qB3oIPYvlj10zcoU7iYweC8CzL5fpGS3AcBlbbzsdHW93qbCpWEt+vMQxnmcx6YEmNJSHKSmazdlsJi32xhZ9VeA3zZM/X84jZ/7k1yyblXA7mIvsZzgzzScEKBgi6esBlmupXSOMKOqxd+iGa951DtryKATpV6DyGjwDYjYFZRT5bL0m793NSa916WUkxiWcU0SyDwZwYkY6MB6kKObLFX6Xu2iThpHinHZD163EV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Q0o5xaowgz4ADQW1R6qr1ddC46G4jCInvodNedYPc=;
 b=W/6GjLmEYfs16JAgkMr33nAyrzt+LTmB+jGCdvZdO0cqHKyK595+gNDab8gzDIwK+D6hpxR6c5lbNM9pRaE8tLX2HQ2ggx9wUo6lZiXSv6Vr6sgqou9VA78qCIMeumYW1sMiiTk1MLhc9NwdS1hxjlxw2impVfyooYyxps5XwSQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5686.namprd04.prod.outlook.com (2603:10b6:a03:103::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 19:03:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:03:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "hch@lst.de" <hch@lst.de>, "pvorel@suse.cz" <pvorel@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "zhengbin13@huawei.com" <zhengbin13@huawei.com>,
        "maco@android.com" <maco@android.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>
Subject: Re: [PATCH v4 0/1] scale loop device lock
Thread-Topic: [PATCH v4 0/1] scale loop device lock
Thread-Index: AQHW8/JIIIHDNUtlWkWFeAE/Qm/2oQ==
Date:   Tue, 26 Jan 2021 19:03:39 +0000
Message-ID: <BYAPR04MB4965C4E9FB75135F317CF34F86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210126144630.230714-1-pasha.tatashin@soleen.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 276a3f69-62b1-4359-192e-08d8c22d17aa
x-ms-traffictypediagnostic: BYAPR04MB5686:
x-microsoft-antispam-prvs: <BYAPR04MB56861967946A3C58E2B7F91F86BC9@BYAPR04MB5686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jew8pSHcoq4RW86koniqbPQzbasj6vSP03MwUnhaRgjl1aBy6UnL396tAXVr/JKvJcjSTlBtZf/yKvNZN60/ub3vFX4saxS3Ii/51AKHglPiM3SyN7NTbJFonO/im1UfrgJvqstv5kuHQEmFWepnxO+HDfoIIa2zONPEKJ+TnnzWZxSzncQjLV/9PaC3FWwsIdRDBSTiti22G5v4DKsBJAOXIn5akY2e7yCZKcfPeL2rvmfM5Ggtl5S+fGn1jeISYCY4cG2zkJZSj5gMSLBh1/fXKWC4zd1j9oF8+O5CnzETwsUGiQYkKobPYM87v8Pa9/4aN/+G2BXLV1BS9D+yjxt/ZMk/eCn/vbvZNK9kyxyEYoXHK8GnX/cxtuVhlkkQbsN2dSyIIkktS+KlZw8C2u28js6YdcCU55LTeVtTnuDkT/ESO+xD92V2OkhFwlFHQK+wrI275f1KyL1iqkmjsVDpMQOhg3t3qIc9WjoXDoFqdVhqE5+BCaYvkuQ9j2CozOvLYNvR85R18AXZVRyKcL8JD7x8okuRjfuXICdTG/nSrdzkxcCKYdgBkIDUxBS0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(7696005)(8936002)(921005)(76116006)(33656002)(64756008)(86362001)(71200400001)(558084003)(66946007)(316002)(186003)(5660300002)(9686003)(2906002)(52536014)(6506007)(53546011)(55016002)(8676002)(66446008)(66476007)(66556008)(110136005)(7416002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aQJcADvIM/hY4e7lqdVocD6rnk43lMgDO27x2A4tYrDpAImj0cIiDNaobEM/?=
 =?us-ascii?Q?yNreS443wuOrt1inwdjQD9xhfBEZPYpDvu6fISwVEYNa9jZEcHOjAv1XKFHO?=
 =?us-ascii?Q?jgnvcI+RhgZhgXABye+MDWvxHK75Y9z5Tzo3FO+BOOSEyKAan2Sm3iIZT66P?=
 =?us-ascii?Q?6/Q1FRGYpv+OCQnqGCSLP1hP205HYFT0QdVGJOv1w41HKMMMFwc73alLdNLd?=
 =?us-ascii?Q?dXCcKyZoN5oHHaTB2JZevevQ6oA6GHgMX8Zfe14GFSh+7hw+BAwop8ImopPy?=
 =?us-ascii?Q?1nYSXzdDKpvKCI9Dbn0uktM7cvALNHHWsI43q1UskCij6ltdVhaI7MDHoqbP?=
 =?us-ascii?Q?7r9E1RC+LFjBAPIGGIfDNJclkD+LIv+Y0drUkTsdZDj/zrTOu+m49uW+xhrP?=
 =?us-ascii?Q?O5fTXrSAem8chHfajp16bVvEPwyHvBfC6JkueBTaxMavV3ErRK5z3N0cMq3V?=
 =?us-ascii?Q?uShpgyFrB6JYroNpN6LrAzjHQIrINVkPihw603N/hNL7zYZk5NvMBsI7cUMm?=
 =?us-ascii?Q?AXNhcSUEmaTXJRXt5wv4RO4TJw457ForOdduuQw3mnNoSy5GG9oMYtVifjte?=
 =?us-ascii?Q?M4aNOfzuJS9IbA0VInlX9zP4VuxMXPnDJSdjSygCve68g0H9u8K09pFaJLzy?=
 =?us-ascii?Q?L63vTqeiU6+h5eugHH7YKS1WSwMpbzzM+KbO7Nn8AYp5s/DC+SDPt3aXfZjs?=
 =?us-ascii?Q?LYjFlxNg3q4WAq5RUW6hnP3i5UmpqDSy9AJCxuDjIvwnTH+zBn5vGt7PUsgR?=
 =?us-ascii?Q?UHSvH0E0jMX027+LEKW+3BBnlH/zXFQ7/7qYNUXE3DJovu/GJ+0Zk/S4iyO4?=
 =?us-ascii?Q?5jD2WwDh7GgjR76P8qSUHGw1Q2M8OPZszcyWCTn4Rb112QWp6Uk7yCh7/n8M?=
 =?us-ascii?Q?cJIpi2HGpWhmaKY1qUbuLO12nnj9R/NU8VwzLwUVl2flDwyLTjGlA5Lf6Ly9?=
 =?us-ascii?Q?13G4SBBzn59Oea9eZekpm4HrFyWjFzDTssAJ6enwPxPWQCM/Qa9kAmabtFId?=
 =?us-ascii?Q?O5x+i+21MemymI525pNcFf5o730NZfZcvgh/ghs0kYzYpq92J3pRA1mPFAXf?=
 =?us-ascii?Q?l+jCiz/tTNHel31VeYGLgBFDsSVORY6cPeUyAyzfLBHZPqhIVBrsnFroH/xu?=
 =?us-ascii?Q?381Z85EbZqPbDyF1A7Gu/OuMkuYjNP5sVw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a3f69-62b1-4359-192e-08d8c22d17aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:03:39.8076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBr2nres1yJKfxvSaER/ihZP/dSCCS3CvCHf+D3zqfVI2Iuhf1KTBU7EpO13VzjbJBD9GQZ/C2nvJa1taEVUozf+5rYVdCt0sL4X35mp0I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5686
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pavel,=0A=
=0A=
On 1/26/21 6:48 AM, Pavel Tatashin wrote:=0A=
> Changelog=0A=
> v4=0A=
>   - Added review-by Petr Vorel=0A=
>   - Addressed comments from Chaitanya Kulkarni=0A=
=0A=
=0A=
Thanks a lot for making these changes, detail commit log helps everyone=0A=
in the community and not just to the owner.=0A=
