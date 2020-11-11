Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD75C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 07:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E24620795
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 07:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KOhccdm4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P/AHIXh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgKKHwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:52:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37581 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKHwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 02:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605081133; x=1636617133;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KOhccdm4VuxeTnHrzdybSta3ykLHEQhzUnQDwyxUI8AZ3wF3owDCDAnv
   n3blb4yhaNl4wfnF5DIXP5sUtgb9EH+t6woa7JTPHv6HH3awWkBrKr3Bt
   1JrRVAPkuZOGYKabXSe+3IzKcfC/tQQbOQw6mx2oUh0bKVZgs/VYPp+7L
   E1AMCQJ1U7MgTJ1Y/Yma3xHtU0BHQW+VxyZOWr6YspoT03UwoyYArFDZH
   +qYXKhpc2hEyWr/zkGYmPiDaGFosNINktjHFFaebQa13Ovf3jcfhkhMO2
   lv9+smDMH0m/Z1D2toQX6Fe0/Y/cS8fducLVxo1wEnRGCv8HbcupZ5KKW
   Q==;
IronPort-SDR: zs1VSFkckBGsgrcd+q5jY2kTc1yMhAFscxbEZuM/dTAVHonltjD2bhH/Dn8jJhjxxrOSN5cvHn
 REF5qMDjyoBklDZUdaIXJtAfjFINc1UQqVwtPUIqdVDPLsN6S/eZ6g/vs1Ssb4txq2HF2sGMDE
 /avDtviHeLdsbaEhVGLPratcN5J5bVXHorM01cBVyVRBJJmrfbAIlAJT5C0GNyfnjS7MVBFi6K
 rv7Y74Uwt0b2WkYMDpnY/spnXauzShhl/3cFTSnfrQD4UUNk1r5SojYCKqPyuO3zTvXDdMTxtl
 chU=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="156848980"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 15:52:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax46znwknkwsdAHWWYnRE7Q9Zkc/VTbwqaJf1uz8tJOY6oIqGnFy0tBWHL+NKp2NCPhyXOxWoyxypyJm3IcrJGwY7Hav3v+dZD+gTNW1jgD+eTNhDfhxeFIrat1CLBqUWUmhErwADD3hvb1bPb0CW1J3KOM+OHAdY/w1f/sBWlImeW7k7sicoRbIq0NAS+SLLzgu442/Hew04cCRed8q6x/QquAoTnJ2VSZxLWxjREb76cgMWakiUIc6KzFEIOzF2y4P3cqs6pZGupRPQqmkRENdPxc8CRLKebOfnVfsDgAWSGAThxK1cPPkt00y7Uc7t1HS4n4T/FPvhIufQo59dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NQ3g4yuKALQvBz85JfLsz6rcaPg/xFlfBPW+/qJnbqXdR4bEp5RSYminrDtyFDUnwbfytU43LB2OwiFEwrrwU0k8Sbr8sydUxLdAEmZcjjhSevj1NjGbOb2PkkvHOvEGk85pFK3Si3YudbM8/qU3tt2LFiKGVunqwl8Cckmu0Mbe2qqgHUhGLv7qHDSfozABxSZOuzPHuV4mOWAAg1SbR8IUOrQiLsb44hkhh+Iog7T62doGqo+8B0Q5Ira2htOTsNquabMlWlEGwaxUovvvfJmwJj5Tbt+3bxpQNEuVhc2O8gTTfgqz/nGs3pzjnHq0nYzZ/Xs1EjmCx7Hfr9TzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=P/AHIXh3my0Oqc/zS/F6hVUK4J9PvzXJUnvjM5q85JYgLmaB1/zlMp8TrCZH1O8A6+dltVDByiQXQfUovrhow6qSD7vWo4n/PHygO7ZFEWsoRvZyFBmlvUBjxoFf812POa4Ycix+GXYD+BHZ9JamaDiJkXekBv6demL5RWrgpc0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5327.namprd04.prod.outlook.com
 (2603:10b6:805:103::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Wed, 11 Nov
 2020 07:52:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 07:52:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 9/9] null_blk: Move driver into its own directory
Thread-Topic: [PATCH v2 9/9] null_blk: Move driver into its own directory
Thread-Index: AQHWt+nm35IysEGiaE26bIPGd9u5zw==
Date:   Wed, 11 Nov 2020 07:52:12 +0000
Message-ID: <SN4PR0401MB3598DD32EB39611ADF7F66179BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-10-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33056b7c-c4c2-484e-fb74-08d88616b33b
x-ms-traffictypediagnostic: SN6PR04MB5327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5327D2CB73F64C53AC5C4D919BE80@SN6PR04MB5327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wu0J4MRE62/Apz64kjswalI9EDmP9r1INW6s6a8FdX7kEgjAX5cf7yBIbigtiz143CZ1MUo1855Eu6+C9WthYHeOxV6uA/YKZwPbt/xXVCjGCXAkbK6E7ZIBjmuOliNdTDJbk4cuyEJN/Hq3AHFZcYNe+AwGhqMtuwzL9nCVOuYmCkGVQE+gTRr4HiXit/y3kMy7d3ev5DxxgMdMIvaI2gSdspjpStmRH+fI9VS4BzijS7inYMM8wFdCgM9ohKwR5HVWvAIoyQdYab3OSBjwGE4OHW7Phzrq46PlT1JfLWwMS3Y03+yFkJxqxInmun/PxgVPqgTgs5CblH5/sb3krA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(66446008)(52536014)(66946007)(19618925003)(316002)(66556008)(66476007)(9686003)(5660300002)(76116006)(91956017)(110136005)(558084003)(6506007)(26005)(86362001)(186003)(8936002)(4270600006)(478600001)(8676002)(33656002)(55016002)(7696005)(64756008)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bjlzAW1lvWTo+PZsqLAOXSJG5DfJGWNv/gO2+OY0X1GWGAq+Vl/FTJZ/AsiOcjBOJQAl6qOB7dJBaX7IzDwc+jNRlC+qv1mlrgHsv/T/sB0zdtdktaOUCkeF2Hly2kT8k/77VdOVYvw2Vx9nqaqiw0UEeuSPzPhm8bKRS0ssU1RxQFgoWP4kRtGVLsjMk/cfXvBVeNAopgZMSH4k9NZUaHUcdM48cshAJ7+u/9QWmsiHSODjaeeqNUFcHkPRpET1BIPZAfH0dgy2+HbtpNoDkx32cLqC5RNSp74rU7URpWIq8O9UsyVbdhXGZEXPse49o2jBZ1k2GwLPIq0nF7uT3CfPcgsGSaFeu8nRvQOGpukV6AIszoiYTjnX2R4mOc1RuePIBFEaV7Jrjgt2RR586LCtv77CY1KlP/TcdhcSC9XN1flPI1tetOxSJj/wHQUVtxAj9IKUTPWRsVmXw9Hb5W5rDdnLQ/LEcUQXt123GDBPLtaovxtVRReF1LW/HQcZprfSZgpIEcZC0nOqz2VqAyJwYYMA/7RuGZgXE6xz+NQ/SXrsQl6fVqAMjaopYMwu4w3x/rGAaM4Malt2pgjtFOns/ibpU95eN7m8vcapP/yevHI5Z3IL6Hd0YMu4SQhBBCfs7XqqNhumQZpM/26fDQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33056b7c-c4c2-484e-fb74-08d88616b33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 07:52:12.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HApwo0cTJjnqdfZrqykcfV/s8Z7u6HmnScITGVcZHuPONAyumykV1OiFvTQN1gb2aSiXSx3TyDSrEJLLRz5bHPLI2kTBzhcHn9+DXIb/l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5327
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
