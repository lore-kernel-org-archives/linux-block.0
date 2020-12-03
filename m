Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C8C64E7B
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D0F21527
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgLCJvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:51:25 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22142 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgLCJvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 04:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606989085; x=1638525085;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FHfmqpirijhhVnX6knhgRdZuXE/Tn2eGcjK/GChOqHI=;
  b=OEsrx2IDqOZBayP5UfluoVsAkVyS3MxdLMT9xMAnWDbxkYnpLuj+kdKG
   8xM975j837N5nIIsFZvX6CbqYzB6TvXcggONnebTYw5xj5yWrxgv6tqp1
   gtbKkcVXivOz5KuG/v3z+14PqgVhi13CR1VeHqJZumMKyMJtALC9gKpAt
   XUM4I4aWLjQvE5L5fLG7irRaLIyIF9qPoHwQvPuRxozl9FDGGRy0HCwYt
   Xkp02KakTpBq9z42BBRBkf8Ypy7LtRd0FE6tdFJv5JXUo4m0NBA5LfWbN
   opizNXFC3obF0E81A1909WrEcldaK4V1NLcOF6syuYNWSKV7JLH/YGqzR
   A==;
IronPort-SDR: 7m2uilTwROzSfeU2rHgBLW9MnYO1bDA+yUEtmKLBtW9zIXLDcBeDp4X7Dop0pT03dFGgCKxpom
 dY/RNUWV4qXNebxQI12fChWMvAQVfyDKs43ZiQOkNRar9iaTNbUnFPm8rW/H70b9dRuvcYvGCn
 xRazwB3SNdo+TWFASX1VhGkRaSrMbf1Kim9zDxHGX/IGO+HtzcbIfUC34P3Fh+V0nclS1zxlx4
 GmugJnwyFrNbEtggdmak++ZwhMecMpk8xVAqPSk9v/l5oLNqO4Gmp6XT9rCk6m3HUFRd/DJt3F
 Vg8=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="155448420"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 17:50:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4NYWCDtp41IpjvbCIi6vuW/2Wu+v8aFljnLaMqKrVqIdL1KJBfmSJ4HA+D7+dBXndDyrj/K6B433ucGIykczXg7QMPjWIo6W2ChnYGwbaKNYWqFb4XiBJe8IPDjRFIZr9hz/DseXH3vhf8XnyeJ/0BLpkZ39ihGgnVVxmcXX/blVtO+8ZQtfUTI3gQjJsFh2RMUYdsmEBOwht78VTPmyfdrKTlyYhareGq1AspzsjBVH/aep1SBcyR2juULM4tY56crJoMShUoRCMdsdSKtnDD+hMtHprIGCBAC9DRYWBkK4KZ50asV1SJ14/2QQJlAMg4fyEVNFKjXRbysPXKn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGjf5dLzLBRQly+twYQpqH97h8cUztYgbxjYrH/9axE=;
 b=IIZ9e6kWs7mFMed4t03dHmM03IvC9RO4lZJUE3rV2JGEBIDCMD/DNci0To3j7luUPffH25wZKCUKKNcIRlfo4CydjX1z7OY3T8EeCzajawdAiZxvVm3Y7BS/Ez2sD0Lwkqmfrt/b09xf0PpKvVDxC1LEWymT11tDSpWAd8UteFFpI+PVgnOkLbgGvf9Ca+8d3cK0V0qk+Lwb2547R28kiE1CxFMoeULLxcQBAb+ubGtkIypQ3tP3MGSF36znMxt/XYMBh9x8xpED2RxfjSTUVdqEuIbkbSZ3CoQxLGCILACtk/1ET1k7xRsbfQxmCCumVqJ1RbTWJXHILXaV2Fu+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGjf5dLzLBRQly+twYQpqH97h8cUztYgbxjYrH/9axE=;
 b=cuPB9HluxYSXSu9JstoJWGWiUe4j78bnfUvFBGFM67XsHnc8lGpVCSq8nqGd255yEmdCkELTtf7GPgDISoF9ypD1g+oRgQCBukHre5fqYItJyYO4yihPouhBqXGMNkqnuKoCX8ujU3NTRrQ4XxlMBWLQ88q6BjIqHFlwBAaWrxM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5005.namprd04.prod.outlook.com
 (2603:10b6:805:92::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 3 Dec
 2020 09:50:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 09:50:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 1/2] common/rc: Check both max_active_zones and
 max_open_zones
Thread-Topic: [PATCH blktests 1/2] common/rc: Check both max_active_zones and
 max_open_zones
Thread-Index: AQHWyU2A6JB6bz4uhEa/jIp4XRS4Eg==
Date:   Thu, 3 Dec 2020 09:50:15 +0000
Message-ID: <SN4PR0401MB35985D9A6A9D57B38A06DBA39BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
 <20201203082244.268632-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cff97f62-f47d-4e21-f9c1-08d89770d637
x-ms-traffictypediagnostic: SN6PR04MB5005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB500520820C4B5C896CA6EC149BF20@SN6PR04MB5005.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2/Cq1E0iytTjvUKgm3WSwnIIG0i9dYy9SQntNIouthlcpzbIf192Lbji5wAg2hb1tf+y+tKHGlgw/+cIM4mF8eBni4z6SOAFU0FCv7DsR9wWmq9/Mlj0DpskXrwpsZ15bXs85OeYL0u8HOqiWX8q+HlyX8iHNP8Ux8/96kILfb/76gfC61AaTobDL69MqENEJCcVV9jHMAbO+uXSeoQA7+7Ed9SB59dECsdYC3QSmnjcyoDuJka7Zi3KMropmRcdMo17niyLvNhvm1hfSQuVWwRCJj2bvAmj1ctzNtpngO7ftgMoK60s02lkR0WzSIrQPbbPCa8HkkjpYrmJfaMPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(71200400001)(86362001)(52536014)(478600001)(8936002)(2906002)(8676002)(186003)(76116006)(4744005)(5660300002)(110136005)(33656002)(7696005)(4326008)(316002)(6506007)(66556008)(91956017)(9686003)(66946007)(66476007)(66446008)(54906003)(64756008)(53546011)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ewZB6bWcdr6tj0dOPwNuFsDe7J62u+9GTKlIarTeJHb8HLuTrlhBatwk9VmE?=
 =?us-ascii?Q?1BD0exxLZnxollnolTSzEwbLm3CYn0yMLnHKL8JGus2nrAYLNisxlDOVY0MK?=
 =?us-ascii?Q?xucE/kExgY+mHj5JEN5ZhJasIk8JYG9cXPDvKWNlXRNQZnm6mquiXr4ejunV?=
 =?us-ascii?Q?tMlVLYCpP4iNXXKoO9xSQSKSPxWrXw38wjTrVV9/YUhOkW1wWL6eTAUbYmLa?=
 =?us-ascii?Q?Fw6OuwtQRTIVVUsOapfifiDQaOWWWsVip29gukhiDIOtITVWQ+OX/QJNrHJk?=
 =?us-ascii?Q?u7kP2gOyphaghn1OFhLZKE5D16c5IvBEvzyj3WICbzmDQ77g+yxGMQ05zqtd?=
 =?us-ascii?Q?q9BDcn+yGjO579GU7Q26NTJPs9+zRkJWufu8HpkQb1OqAZzfi73w6/o9GKIY?=
 =?us-ascii?Q?QEBJ2swXHODzn9KIA2xjjRynkrUtL6xRHi8Y1J0NjlXjf85L99b945MdpvxG?=
 =?us-ascii?Q?lyMVeharWyHo5uG3Hl5ncvSdUk/KvrZZ7ZF6O8mt0b9T5Cq8rBHALaNl2hr1?=
 =?us-ascii?Q?ycL5PwDzuhHdP9uHne3GOyIwzkq770pURvmOpeiOEKqXG/WQmdbgdbrNp1g7?=
 =?us-ascii?Q?z20r0lhRAANVwDyTLmXz8Y+t0ndQnQNQZmtVvMr/2U7YLSzWMXZaHWluCVAK?=
 =?us-ascii?Q?JJthSOz8n5IHH50fugDOEQLn8DoKcdWeAye23mR9FqAnTvK0D+UZEbV98cXN?=
 =?us-ascii?Q?1EK+hu0V4ylmUn3Ey4yeBlF6MGMhjpbyXBrl5SvqWJoFShVb40fpHm79nhM1?=
 =?us-ascii?Q?8hPs6iku9/XtH/YaDPfHwSMN9kvswCbm2gWXdeDxQIWU3AKDJSdwmDBBX49i?=
 =?us-ascii?Q?mdG8BsPKGD9N7biImtYXrVMvd0/0TOZ2RUIgtIraIHGPmWeXj6IX2a1RHGw7?=
 =?us-ascii?Q?zEXnen8jonhU5Tke1OjPbHb7Xa/3w5RkiyjwC9EIvgh6JNMVdeOGEKy5XvPC?=
 =?us-ascii?Q?kRoXC3vCYjDbPTENeoNXOE3qqANjaeePZPUOvcJMfMS7ySRPEhOSmeAvdfVc?=
 =?us-ascii?Q?k1adNoYcHeD61WrX4Hpq7dKTcxJbpd8widcuu8J5+gb3ttKkuU7b70KvLc+n?=
 =?us-ascii?Q?LDTzWrJw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff97f62-f47d-4e21-f9c1-08d89770d637
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 09:50:15.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tc5RAfNBoONVr0Bamrsv5Qel8VeoqZ6zn42SX8o2i2FHtXEGLdBGoc2ginyVeYD5vPwFrYJniLeql4YUxbFSD2sj2zSePADqlw3YYJ7jbhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/12/2020 09:22, Shin'ichiro Kawasaki wrote:=0A=
> -_test_dev_max_active_zones() {=0A=
> +# Return max open zones or max active zones of the test target device.=
=0A=
> +# If the device has both, return smaller value.=0A=
> +_test_dev_max_open_active_zones() {=0A=
> +	local -i ret=3D0=0A=
> +	local -i maz=3D0=0A=
> +=0A=
> +	if [[ -r "${TEST_DEV_SYSFS}/queue/max_open_zones" ]]; then=0A=
> +		ret=3D$(_test_dev_queue_get max_open_zones)=0A=
> +	fi=0A=
> +=0A=
>  	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then=0A=
> -		_test_dev_queue_get max_active_zones=0A=
> -	else=0A=
> -		echo 0=0A=
> +		maz=3D$(_test_dev_queue_get max_active_zones)=0A=
>  	fi=0A=
> +=0A=
> +	if ((!ret)) || ((maz && maz < ret)); then=0A=
> +		ret=3D"${maz}"=0A=
> +	fi=0A=
> +=0A=
> +	echo "${ret}"=0A=
>  }=0A=
=0A=
Maybe change $ret to $moz and then=0A=
=0A=
if ((!moz)) || ((maz && maz < moz)); then=0A=
	echo ${maz}=0A=
else=0A=
	echo ${moz}=0A=
fi=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
