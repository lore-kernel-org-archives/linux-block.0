Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C5C4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0EE207DE
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TF0Sop3q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G9syIl1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgJAKnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:43:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16244 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgJAKnW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601549002; x=1633085002;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OQnrL58vdNnrTERr/oWrQLva4uvW6wOD7Bd6hgeWxPc=;
  b=TF0Sop3qlMzbyUJIu76+PfcEvUEa8j33mITQCVkzIfB7VSRumARjri3L
   UxdyxlyBAd8KNlP7lTzhNSdLj5arTg2rZ/D2ifxDzqt3CQhOsAJBWfALJ
   F9Sse965aSy/6gtnNTwmnw4R/EwCijkOiDWYmZ4lPSxoqSnpPDTeYpYs5
   2dJDnHz0nYo6d1VLWlPgD25ZrQIVRzrkRRC/UoRKPAT52xYhXpwwpP1+J
   PGMTZ9B1MpXvU1zmIze2lkeSvgjo8YJhiYOjgTHTTKx9A4cIy5XohQtqK
   3wIk3nZx7xnFwj5NBMuG+KP1QTHb0jb0FrSMTWpUR7aWZmWW3tU+g97pn
   Q==;
IronPort-SDR: PjrvOsTjpcSJIPmg0Wv/GsFUUAC7oEFrP5cb89s1nZI7jJUWH600aPN8RwAX5AAYUbfaiLKbBk
 mwXg9J8430M6PkW3nLRlvwgu0n1AxdaC8GYG3QkyeCteh0TaeBr4Yti35ilabOgxofCmljkJr7
 QHjX8dKaJnX75/M6PaqqdHItikFQv6lS2Otx/LHTfogr7ohoW7bSvtCi03lAZ76td70BSoVsbu
 XXOES6YdeFE06NAi1THea28pxTIBI80ix27aFbKDl8pK+MkPUMCNYc6MoryoaUqUv5C7I4gdIP
 vn4=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="153158322"
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:43:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOCKxKmYqMMriYk5AujE4nEgj6jmBeZcWw/Y3SpWdz4fw58b2atx1pT3afgPBMPemHSBSDAgKiX251QKpEDyRZCFnhjpcNTQkf83ESC+uEdlL4A46Ugs6zGT+cLbeDo/ENJsIvQYO0Vg9WhXVegJ4mwbe1jlKCddoUK5dEWTSbTBG1qb90UqDf5TwKBd4UtgepWFXvL8PnLaiFqdHDIYwXNlbjHd/jHfVD+979/xHIYlGBrx2Qezh2/oTvhnpMp/jaPgT6OHW4CQya6IWr/ruzkKRVHDy8kAb42Yxr5YgN6oNOumqL9jc+7WDcv3L1CQHtK9ZvNRbzD/qjVVcXLIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQnrL58vdNnrTERr/oWrQLva4uvW6wOD7Bd6hgeWxPc=;
 b=SZ7UkNyaB5foebj4SfsBvC4v+7nd3dxofn6bko/vpYBBvFKh9o2TymSIbWlsbh0+vGW68dy10cMRawDj37c/psHvTSg3LvjNNxrjo9j0kPAqfuO/a/i/SaDQGCFj5kLRvqEjsFB/4IS6GS4UmsuBaruU7Nuok+b/bkW3dGHWCjOPcanc4MRBneapwOWNEN65+UcIHR4DzERsE+R7HfIydvNx5DtKRDNv6AIKYk5lkOzX9vmVHXB3hk+PA/6kcKWFXKhTdeJaAYL2Kap5uQPFr/o4bHRlxfbuPXnK832XB2ixHVq0vaEBkkhdFuQ7S6g8BdSZLItmCiqQq8H/dAyfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQnrL58vdNnrTERr/oWrQLva4uvW6wOD7Bd6hgeWxPc=;
 b=G9syIl1I9ZThs0H/V2LU3wL3aK3jHLNfng6vwECcRw06pwWJ7nA8afFbTyrLPp9ANmlQ1Qo8FhVN9z7azlOykKPWcVYnkbOZ1BchUtlIKynabDicxMtm1mutPWZLG6LMsjPkooM9FPvM6z2ykHIYaupAW+LiNTlnNHIGO5qwJI0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3517.namprd04.prod.outlook.com
 (2603:10b6:803:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Thu, 1 Oct
 2020 10:43:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 10:43:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio
 command
Thread-Topic: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio
 command
Thread-Index: AQHWl9vSwdbuppVm70Sx2ne+wZj2Nw==
Date:   Thu, 1 Oct 2020 10:43:13 +0000
Message-ID: <SN4PR0401MB3598C361CB63B30A104561879B300@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
 <20201001101531.333879-3-shinichiro.kawasaki@wdc.com>
 <SN4PR0401MB3598A42EB801A3797A7B8C799B300@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201001104153.rbedkdqxtogzm52s@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:a4b7:4173:7208:fe59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1dca2b0-fc11-4b6e-a58d-08d865f6cc8a
x-ms-traffictypediagnostic: SN4PR0401MB3517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB351747BF1BB19D202B17186A9B300@SN4PR0401MB3517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6pkXdkyrRAoJpvb2OEXqD116zczfGXj75EDEexROjTfZLfYjCs+pC0QmjZSzFy5LaLGv9S72UYB9jRY5aFET+FkVvctWHOBMnyJ91aGyuWv3KDP3RlY244YqNsMbWLv++STXuG6rV5ABkL1ewK3LSlxp6UKwVOPc8sEqFPdgEmuBRYi1/Ba+dXNgNFsPjDc6b3k1kNnOh50u7X3IWlY6XQHhHpNurkLG4oJGwz7WXanf8Ep3GcXys1sM9S8rlF1kac6Cq1VKnc+d7whQRySWbiN3HPwq3kCQu0LLSh67HI+xv710VVkmk0pZflXVXqwGFi2OXmHderfJrfEQL1ijvfFy38hcZdErV/gPshhmvgcPNT5/xVFY47tqyv1Ngxx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(186003)(66946007)(91956017)(478600001)(66446008)(6862004)(2906002)(66476007)(66556008)(76116006)(52536014)(55016002)(33656002)(6636002)(7696005)(4326008)(6506007)(9686003)(5660300002)(53546011)(86362001)(8676002)(316002)(83380400001)(71200400001)(8936002)(54906003)(4744005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iGZqZhJb4oV25u4h8s6VO6DAZhqUW4HqIEz3K71UpOJsznsS8jHRth4TUkhlr5j/0MbtE5cEau7lL73x6obMNGE5aShGhc8HMV+QoCZ+fDsdvGJeyRglmvv47ATMat4CjZi92uLGHJWueela6RNpoEOvYfiybh2iqq4maLXl8q383mvzNviWGvoZgDxRMz73ZyNhJZPPNVMVJkedBFYik/GI61j7t3n18dVORzfQ3A+t96Rr9mt306kKofGtBmI5xlzYd75UU55hpzzGv5smGGhYOWNPigfxIjp+RzIb/oiAlUq3AtwKdkwnByrFVl44ctCb82YghxDGrzIHTqJwssNCN6454FQLr07jU2xr5gTthLWKFlpduWQotzrrIH34OmSNN3nbxowGKzNYT8EyvNk2YxlcNv8UOcqdTFnW4+Zopjt+O4SbG5fEi2azR21fXGnPlxmtUVTDBRrDkIm76sY5U6EwOZiCZVhaBC+O7UfSqZJ0a5soOfgsErMVGiArsorwwYjMjulCHruxMcGikXVYM/pyDcBSqzWiDGd2arDGP+WNOsxcsSW4VKbeBoN6NmM4OeiPqklOiG08f36pjEq4cCw2NZr646wNh6rwn5F2JgNi9Sff70X41m+0ol1MC671wAill6voad4JYQkunJijyQvQahE0aWwIRb79rOLfVf8FCKTipXTAHf4cH5ioTA36kR/2jCO0D6YTA7JM1w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dca2b0-fc11-4b6e-a58d-08d865f6cc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 10:43:13.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aBJuAheIawwoZVkk4NwlpvGfEDH//fJVyZUYYo3sTCBeWp75GXTuV2pIRWE0m0Y/BDrTZNpHHdqLXkUlRDYWaCWFR3msZPndMWzo5N7ftk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3517
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/10/2020 12:41, Shinichiro Kawasaki wrote:=0A=
> The option --max_open_zones was introduced to fio together with zonemode=
=3Dzbd,=0A=
> since the beginning of fio's zoned block device support. If the test targ=
et=0A=
> device is a zoned block device, the test case block/004 checks that fio=
=0A=
> supports zonemode=3Dzbd. I think this check is valid for --max_open_zones=
 also.=0A=
> =0A=
=0A=
OK thanks for clarifying,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
