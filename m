Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659BC433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A672073B
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G2b4q28W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GZjLpXAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHGDPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:15:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24862 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 23:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596770141; x=1628306141;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=P4nDMVtXYuItrEd33PbZDyvLB6ddOewMMRDAo0JYjfA=;
  b=G2b4q28Wn8K02VU8JDTE19FYJ/mAW5PmwomGFj0J5xfC/J+4k++sRZki
   tsxvK5z+Ys18G8aYNWLNpbxO0Fqbhmsq9uwfzor3xi34mWqmZSTSDhcKo
   TJ9CnN1eqD4eRw9Ec7eDvwEQorxR4G50hLc70dpE+4V9urMG/h2ovRL9P
   WsoKCUBHc4epvQtIIM7/XYh3/6asL8sZJzyHdT2iRz+es/q8qUB5RQNxa
   4rQA2TET2ZX+8/dxPNEPep6r/kYbRl+xLtXLXJQClfonNLoe3G974Axaz
   RplMFdtOqPjaSbAJofqW9Bd0b+DC0cwxsWG72Hy4PuU267H3QuDf879bB
   g==;
IronPort-SDR: EtM+7Uek0xRMaNyO2+w3bAOnrib8d75bCh2oibNnGzLtOLaOPb1gbdDCAVSkNIdg70XN5biCS+
 QgKPRUE3i9B6gOxawRD2FUfrl9V+C791v0UqKTwGWnlrFbOeYELKopK/xDw/S+FeaE8ha63cZh
 noTNeJMdEfXG4gb8fo1eeHGm+OQ5luzW0foIOc9zomrj36tPh1Oej/P8jO+wz1FD3s1XXSBa9G
 w/GVPvyWwp/N+DqM+HiEoUVMZc7h/nrzlSutIqr4Tuup2Kfys+cjJL4Zafi+luWGU8h0VBHNLB
 7/k=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; 
   d="scan'208";a="144420207"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:15:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxkyvT1UVn6oSrEPVa4b2bi7G7oSnGR2K9fYBPpYCGT9bzqybnx95u0sBCgae7OT4GoKrzNIXtbctCbxd8Tc+cpXjJqFBR/MZ+fbbOwMXu/mrSFVcd5kCadX/0CbrOn5EXRnj6RM52Ne7hqJPbqxuTzuPW5gieoO4buObpGno+Y/WCLpw14FQQxu40i3/tkywADC9y57r1Zpu3mu/FCBj2fdjoGg+s66nL9lffdxy10EcUxJ2zzkv957jUxMvPGj/Ylyoja8qGSCsQnUyCJoFsTA1f9FtZ+OfUlEZYgqTyVZDv2B5WCMChgqm92aga9UVHq6NAK1Q3fKY4GvhlWkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB8Xa4kq7U99TUmgzUVYFw8Uib8UUfsTo8QAs74LBJA=;
 b=XORsJQI6FeJ30tGJKxvoRJLvq2pbRgQsb7JbFctRvkVcXD/LnvmrJe+UgNeeQjjwXIB+hgxe3zL5hOjq9qvNCU870YlSk2cwQH6zrcfEduMnjSelB2drVN7xx+/vt5pJIyHSraKAdfdkaAkqD4nTKCQQiMiAFUOYguMvUlgavLZj0ojmE8ZyjuojQC8ZleGP74bk6liG80tLpeUv8+Iwm7ckBEfIPVxv8MvcWun7FlTjb3HA7hkcMsYiSRFGLBclbg6P4hiX6dZqj+FxpvzFpWuILCeChRA4x5AevlO8vzTnfAA6up9ZI7XoYzMc908/ES2LI3htsB5uBiVnd3iYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB8Xa4kq7U99TUmgzUVYFw8Uib8UUfsTo8QAs74LBJA=;
 b=GZjLpXAHiLAGz21GffVq0BBNo4saSLLf2gC87/vcBFWqPRTBl04r8PEYvxbACa+tUZgVWAYPLTnanvCbxogF5RB3P6YhQb8bhXZsXOszCWosPsyWjM0wR6z2wpvSYpNv2MGa6qgzZNlbGZLc0V5ST5yQhp/Xt9zSPi7prlXhsU4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4967.namprd04.prod.outlook.com (2603:10b6:a03:4f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 03:15:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:15:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
Thread-Topic: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
Thread-Index: AQHWbCXzWHmgafZUt0e/II0q4e3grg==
Date:   Fri, 7 Aug 2020 03:15:36 +0000
Message-ID: <BYAPR04MB4965E3767211F0CD3DF7CAF186490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-5-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 683824c5-1796-4fda-0765-08d83a80278d
x-ms-traffictypediagnostic: BYAPR04MB4967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB496791DAA0842B47F35B25FA86490@BYAPR04MB4967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: id6CDNWcNbSHANO0+KP5Ntg60PiZ2T6wJmHTIA6fVmGARL32PpK/RSs9RYiSH/15m63A4QbbPG6CH5qHyRIKZe1aiBOxHOvBO/H1qeELaM+yyxhFtOSbGiKtu4ci/u0JWGCKDejLKgR5+FJwj2Po57L9wmlm6YBBUJcyEJzxI9wWqDKnpACBB4UgduxwOICyF8LXHKXsgYS8zfpOhMe+hWJ2+zqbFhsJHV8zfZfHvQ6hTo5md96dtHF0mrOoWGvfggeMtFpbZc6Re13AhNrMTMdSbv2oLRsFljl+Kb84tW1Dr/pf69PAxSvNhKJsj4Ix
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8936002)(316002)(52536014)(2906002)(66476007)(66556008)(64756008)(66946007)(76116006)(5660300002)(55016002)(66446008)(186003)(9686003)(8676002)(71200400001)(54906003)(110136005)(53546011)(26005)(33656002)(6506007)(7696005)(86362001)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QQtITHo8mcc+KHWN8tkG/Yms5WxvFDzZbhUs31+gusc+4LR1EE+jGvZtD7RfDCKsUaXrgQ3XFXbjastc5LG/hb+kyHA/igvkussaQYqFxMhZ7gfkBvfnjS453wQbaMFMgGOZTnbRzq/h9DWXxUPVH7VgjT1BGrQYxum6Mb/SdGU+tK6h2Xj+kCJWpTNm3Yl1IAr/jgDodyUnBp1IjMd+qXIfjOa6gDPJLzrFLw4e80QwcuoWiUIf52cMwYYCs1rXXY/ZAUnj+RkwQ4GTUEDx0IFA71OKciSQWW6RrXXtibAmAEy9meqA6/2VHv9TNXZkMupNeQP/HtsuphapDo2ozh3hSdLj8s/cfe00Zw/BgpJTr7akj+zSredox6S59cUJRwoKQFWGTpH7ZFVXuR1CL5Tm61CqrxnpKCJ5jZ9D2ChxgEuK5zQPt3zMaGVTxWZm6mzOAmZSozGqPsKXJsOBvr19Stcyktb/KQTZ7gOczDBwJCwlR08w5vqS2ietPyqT53W1Mh+WaBVmpyh/moMuhu8XuFOQosdOOnAYwvzQtZeAM5zvKPtW8T7rbDy5s8Y4zCQCWZEZYFecQIthC87Qp7sxZT2rK+R+P6kNWkDyt0M2zUskrtLDYel05cnLBf2xFZgP6L1sM1M4U6xiemURCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683824c5-1796-4fda-0765-08d83a80278d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:15:36.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hdgfo2eDv2OTvNMMGGJBz9wcTM89gPDqq3Nup8j+fRh+ZB6xt1vLwQ6CYaFs5DVNFd1NJd2Y/3kZ1yS5DB9aJwQkKqnQMelIpVDdPhHVYuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4967
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/20 12:15, Sagi Grimberg wrote:=0A=
> diff --git a/tests/nvme/027 b/tests/nvme/027=0A=
> index 805a3c63eba2..53766775e096 100755=0A=
> --- a/tests/nvme/027=0A=
> +++ b/tests/nvme/027=0A=
> @@ -12,6 +12,7 @@ QUICK=3D1=0A=
>   requires() {=0A=
>   	_nvme_requires=0A=
>   	_have_modules loop=0A=
> +	_require_nvme_trtype_not_pci=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/028 b/tests/nvme/028=0A=
> index c9bd3dde7f20..6fbf0d6d7938 100755=0A=
> --- a/tests/nvme/028=0A=
> +++ b/tests/nvme/028=0A=
> @@ -12,6 +12,7 @@ QUICK=3D1=0A=
>   requires() {=0A=
>   	_nvme_requires=0A=
>   	_have_modules loop=0A=
> +	_require_nvme_trtype_not_pci=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/029 b/tests/nvme/029=0A=
> index 7bf904b16edc..7a4fd8d6d4c5 100755=0A=
> --- a/tests/nvme/029=0A=
> +++ b/tests/nvme/029=0A=
> @@ -13,6 +13,7 @@ QUICK=3D1=0A=
>   requires() {=0A=
>   	_nvme_requires=0A=
>   	_have_modules loop=0A=
> +	_require_nvme_trtype_not_pci=0A=
>   }=0A=
>   =0A=
>   test_user_io()=0A=
> diff --git a/tests/nvme/030 b/tests/nvme/030=0A=
> index 220b29f42962..44f3b56dec4e 100755=0A=
> --- a/tests/nvme/030=0A=
> +++ b/tests/nvme/030=0A=
> @@ -12,6 +12,7 @@ QUICK=3D1=0A=
>   requires() {=0A=
>   	_nvme_requires=0A=
>   	_have_modules loop=0A=
> +	_require_nvme_trtype_not_pci=0A=
>   }=0A=
>   =0A=
>   =0A=
> diff --git a/tests/nvme/031 b/tests/nvme/031=0A=
> index 001f9d2b0b3a..a5714982b5d9 100755=0A=
> --- a/tests/nvme/031=0A=
> +++ b/tests/nvme/031=0A=
> @@ -20,6 +20,7 @@ QUICK=3D1=0A=
>   requires() {=0A=
>   	_nvme_requires=0A=
>   	_have_modules loop=0A=
> +	_require_nvme_trtype_not_pci=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/rc b/tests/nvme/rc=0A=
> index 191f0497416a..a2cb0c0add93 100644=0A=
> --- a/tests/nvme/rc=0A=
> +++ b/tests/nvme/rc=0A=
> @@ -46,6 +46,22 @@ _require_test_dev_is_nvme() {=0A=
>   	return 0=0A=
>   }=0A=
>   =0A=
> +_require_nvme_trtype_is_loop() {=0A=
> +	if [[ "${nvme_trtype}" !=3D "loop" ]]; then=0A=
> +		SKIP_REASON=3D"nvme_trtype=3D${nvme_trtype} is not supported in this t=
est"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	return 0=0A=
> +}=0A=
> +=0A=
> +_require_nvme_trtype_not_pci() {=0A=
> +	if [[ "${nvme_trtype}" =3D=3D "pci" ]]; then=0A=
> +		SKIP_REASON=3D"nvme_trtype=3D${nvme_trtype} is not supported in this t=
est"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	return 0=0A=
> +}=0A=
> +=0A=
how about instead of not_pci  if we can requires_nvme_trtype_fabrics -> =0A=
returns true for loop/rdma/tcp etc ?=0A=
=0A=
It is a same thing, just my preference to void not.=0A=
>   _cleanup_nvmet() {=0A=
>   	local dev=0A=
>   	local port=0A=
> -- 2.25.1=0A=
=0A=
