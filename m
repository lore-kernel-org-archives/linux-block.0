Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDADC433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4142067D
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 11:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q7QCO4gy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PbEfCfHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHDL11 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:27:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDL1F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 07:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596540424; x=1628076424;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=er2tX+a/C6o2afXPdOWETZQnjje7bdeKXh9WHBAZPB0=;
  b=q7QCO4gyK2sOeySOj9qJo3O0oy6LnPM5gk2vT4Lc59uwzNXplG1mRGLM
   A0+bnfRhQIvSLI/83Ntw9WadKLLDqWPqOiQLR592eOsHONf3eulZTvrYk
   73+mWYHq8qnx0d+XliyTdSvlJJcw5gzAUqM/9LNE9t+SKc5HB5kgCZSw6
   vdBiFDIr5keYW5bEtxWg1L8sPEUMhHp2+XnTwzlHBmnUsSA5ZQhH4hkij
   flFNWU9mH/xsEjB58Tg0fAbN5y9Dn6rx4JdVvlq/qZXh5HlREnh1pWHwD
   Nq0hghD463HKV2XEqa8sn43wpehoLmnYa1I7OFTUDw+FWfaclqvkhztNF
   A==;
IronPort-SDR: Regat6NZkolNvItYWV21IJzwRJ1Jmxf6c7jRMZzKwaJ+C2TxYJgMFh1sFdukyqf8sEbFjzLZE1
 aMSixj5CDHpM9TwG771E4+inZT/2OrAVbVm2akFa8J8Ys39YlzoGlZiZEm4NY0LiloLztTyK/+
 fx3U3N2EWZDR7MFKwm5vxwjERN61xGIHleRE+93zkbUDEM2/hSucQqTf1fW7gHGAwUQ7GG0TgB
 KpxgNYT3379LTYfinmMwU5I75o13Hh4b9LRen/b8Aq2REsKzEAV79grYgs6b+B0JxK9nxf0Pol
 Y8I=
X-IronPort-AV: E=Sophos;i="5.75,433,1589212800"; 
   d="scan'208";a="144101717"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 19:26:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXKgKRvQMmxlmV4KaLFIxOBjkKRhAlgNDYlFWUHtpp2Zk4LouAvpkhntcStHz8dhzRLIgLWKmM095KEm5cnDvfPgQm/EoTqDk5ESVbeWtMyeg89YGH6zaXTDkuyFNJvrmg6QJRPzHz08boszyxNC0j+/6pOMg03u14PY71GNV1yC8G9tKRj9bHtlGPuN5V8pj1aGxZmlZ8wgI/YOxAUVqj+pAPV9NIt+M1n6dlf64eyKIYICeuk0pCDIZdjwp1fhQyd3sZdwhIw4EPDIOcPaOD03Y+l9daJyLDvm+o9cLmVtDTnU11BLneSsIuhoHLUblznAlUshnrcOjTKjSBiwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er2tX+a/C6o2afXPdOWETZQnjje7bdeKXh9WHBAZPB0=;
 b=oZDbu3asaWrTzODnF0I/79tEZdcPWu/0wNQY71QGlQieatsQ6xoAQE/YlB/TRZ6ufMDat/QqWrBaYX3abGdHue2eMGF2BHoBmCET9zsL7zs6mY3RJOtDkjbIzQ+1DtQd5q5ExE7uDcjW3WICHnIxCqjdaLgVcqYzLjexlxxVWJPfaTjXIt8dXw19+pp9GhOJrNy5H96JqOZeaStyAAuz37ZeJxid26mdPd7JQTGFZ0/FecFOPrbWCZLy+nWccNlohxkpU6+PAMRUlkA5Uk875XNSPBW9wiY8H3eZ5vjrrRiY9rx1ND7XKIJdSz0pCNaC7ApR8p75iDjBa3MIE2c7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er2tX+a/C6o2afXPdOWETZQnjje7bdeKXh9WHBAZPB0=;
 b=PbEfCfHSqMc4Qz5vu9JbgKfivtk6Fqu/hg12fKNXtSJiEbEICXRwM5eH3nHlcbxGyMFaGcp3VrWxJD8t9juhTHugXBcLpRORulTCxj8Z39jva767wToCHQ2qDoU2FLsZ7tB6aZMFaIfc1c09zkEiLmJeU09FeBHz/syBN0yqWL8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4783.namprd04.prod.outlook.com
 (2603:10b6:805:a5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 11:26:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 11:26:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] dm: don't call report zones for more than the user
 requested
Thread-Topic: [PATCH] dm: don't call report zones for more than the user
 requested
Thread-Index: AQHWakEnQ7EK6Gzd+EWB5zzIARuZYA==
Date:   Tue, 4 Aug 2020 11:26:57 +0000
Message-ID: <SN4PR0401MB3598A9D49399D70697DCEC789B4A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200804092501.7938-1-johannes.thumshirn@wdc.com>
 <CY4PR04MB3751EB538B7F29FBDBB4EBA4E74A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 421107f8-bf52-49cb-72e8-08d838694ca7
x-ms-traffictypediagnostic: SN6PR04MB4783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4783CA51A57E957D67372D509B4A0@SN6PR04MB4783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oDtbBh7TJcS/ol0er8KOAlTbjS6pju/jcSGTpxc3SEPeJYNqXL6rY64qIo8gn/9dJ8EGKgbEypMWua6SRasnYg74CVc/zM4R70oUGTjMgSSyYMm7FkrSIp+53fTqb7Hy1mBvUMQExV5J3Q4PDYFIuBVVRrxdJUmMg/PfCzEtLS+hPaiU2X78LNr7Fh64oeqML1li6OQ7EbbCev2/S2lZ+FWu9fOsAzAYhDEpOramH+ep7SSDXAct1wZ/dxHOrmA0QVU1g0o1ZYOvujL1ur+0WHJTcXhNEjTQiI+HyMadD+t730zcnYCUHeQLMwgysAoDUPEcDGMkQuXnynZXzXio+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(52536014)(316002)(186003)(7696005)(66556008)(66446008)(4326008)(9686003)(66476007)(64756008)(91956017)(76116006)(66946007)(83380400001)(55016002)(26005)(53546011)(6506007)(2906002)(54906003)(110136005)(5660300002)(478600001)(86362001)(8676002)(33656002)(8936002)(558084003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 09QB86hFm4gw2hSTJBlRzniiGChQIa6+oHSAsrYmL7zgi9g2QuBRDsDKoG+vqji4ybaMbBNXeCRLl6qB4LInZGh9sGx9uzPk+DAiRTWZh+T65KrqX0CVDB5KbFhFPwyjWRW2A38sTHlAGrUgP6fr78OeodZ4zZJmaBo4WSx7p3jrlhqTFtwCt2DpWU2nELh2WKwNGg+LwVSGd0micVzX9MPei8OsPs9vMvT50mCgRgdlZHCEGOaDH31G1h8gPSPE1G/TPWsubTzMOXve1MUzwWi+A+jpKdRboBZLgb08kTzdfMqUOxeiJTccSmhD9EZsJVabF/88sbp9C0C33L1IU1cVMbaCixu+T5BagXRXOrkkfXGVH+75OxIIUQInEPFj832t+NcXAil2BpXkDEkjSc+MJWJc7hM+SFf6QEfxCTiZtzcY5t1dIlFSHKHIECvc4EoDV9aqZwqSDAFCrjECIAIDJgi00qpgxNNQCDmu6nI6w7LedYIjHNtK/9PSjBevvshi2VzrbyCXKXsqUOhZAwggFSyNmAXi532qT8d6FXvNtR6T8F4zWy82EGIAxwBnqdHqxt8SgVeDfQ5xWgJ56Ph8N32kkG6xO7NoS1ZBH65bq7tgu7V3z95z/uEvsr0m7nVorJAn4ptg1/bVGfOmJA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421107f8-bf52-49cb-72e8-08d838694ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 11:26:57.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIRrFnym4PtvWpFxqnpNC5vzhd7S9xGcyhX/7TiLCGu0kUQDKIt79Mao/rBXmbHO57sx0m9GqMo+DBfB5xeD/7AuxO2WFA030de3Bv4k7dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4783
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/08/2020 12:17, Damien Le Moal wrote:=0A=
> =0A=
> Looks good. I think this needs a Cc: stable.=0A=
=0A=
Indeed, Mike can you add these two when applying or do you want me to resen=
d?=0A=
=0A=
Fixes: d41003513e61 ("block: rework zone reporting")=0A=
Cc: stable@vger.kernel.org # v5.5+=0A=
