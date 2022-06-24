Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5680C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 08:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiFXIUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiFXIUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 04:20:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C06F78A
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656058844; x=1687594844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BBOtcaT3J2hZbRO9ebM0lA1e54V+og/GJ1AOJeasnng=;
  b=cr0geePNdNbp++B1JWtGy29YzG35isKl0E+V11E4kdkZlyP0c9WzVr0h
   cBBD5CLkfwUTa7gIoJCKEU6+q34HChR+j8LSDe88A5mmRMZFtfXPBM+94
   OMfkhT+tDDuhcc/3WdI2gyUila00bYpQiL1JnPI7m/H6DAuAl2rTjly68
   BeDYVhIhbkIG7vAB+GkIIf9ux9y2zXuQAEfkZmehl1c8xDrugF2PkPVCk
   dcuj+2YMqI1301aO6/UW7YFljqV02AbqPC8/QDtjMk3OqZz0vSIfv+GkR
   49FwwaKR5HShsomPIovJWYJX4ucOW+E1lz1mhxGXtbT3KbCuTQtTujr6R
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,218,1650902400"; 
   d="scan'208";a="308324578"
Received: from mail-bn1nam07lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 16:20:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNhUCl/uthFesxtsWhYe+ytk3vm2momXNcCaAFzSlFZNDohJZIMBrF1QceAZJ89nEVestui5bpkrCzZZTa54y2DPlHUqzxvPNekg1RbwhN+7kE1A9ug43JwsfBuzIKHFrw2zOAcVqiIHu4VjivkQetI/SALMaackQ9m+ogtxNZIJBreKwzvjtX4NQFwc4Lm7rTeiKAMpNpCvLxlmW559jZYlqMMRFZGePDqLBM9SN54dZD/1SmqUPmkdvnQkKOjktnvMvkQRa9jwafzYS+vW61WRPR+zMcX4E7JEdqoboGdXwqgWvATaq6HDV+D+HgTkuCdQHUTEqn3L+3QRvUkSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fONsUTL2qXtCobMQwkZUR8MlV/lK848nVu8X79CD4OQ=;
 b=bqm09D4i77zZ5qL/+lEZEHbQDeZqr8QuJ3OAYclRiETxKosM+wGvveDC+HiSC9VkOOFT7g2CqM06QCmoeyPi3CzUPs/GC5PRDEnAcYErvNJu90jH3mIG/AlprAP8sGsmere+alI6g6P2YqCa279cFGHFGcEELZk7+FRwFshlScai54512ptst5ZVloxz0hYMNWeh2LwKI9AGUiRy9lcD0a61RQT7BBoeLcYkhvRYP7ArFR46OmMe82lrbFmBE3sV88s3JNjXrgPsmbpuZwd88+DmD/5rjSupqoYvldhKGBvvZRh66hVwjtClpdQDzZERLbwJQAIoR8UQrWUNuOsYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fONsUTL2qXtCobMQwkZUR8MlV/lK848nVu8X79CD4OQ=;
 b=w0P0o0w8T7nTytAhB5dUNjxjlUMgEblKPrROYPpbIaFCfbtP+yBEiMpuRgmYYRNxgeMTvAsNgK9BYVRsNUks/RVZs2Tz/GDSbkm02eQ/n4cJBupIFBnuZ51S4hppyopXXADXGnMcsLq/d24p1Yy2Ogh9fkHwkrGjnOJFac6HfgA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5926.namprd04.prod.outlook.com (2603:10b6:a03:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Fri, 24 Jun
 2022 08:20:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 08:20:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Topic: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Index: AQHYh58XRETCr2SsZE2RADrDB0f1D61eN1SA
Date:   Fri, 24 Jun 2022 08:20:39 +0000
Message-ID: <20220624082039.5x2cl26q7v6rnm5n@shindev>
References: <20220624075023.23104-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220624075023.23104-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3389628-0e99-438c-e908-08da55ba6c51
x-ms-traffictypediagnostic: BYAPR04MB5926:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osunu52uEoypAtvYhmrj1E+/hdit6RUXQ8c1TSnZkH8tBnqxN1L4pybUUESalTUP/x+E1XBQKCcvF0gM9mhnYrEi71VdEhvfvkrXd7LUVAzP8dJ/XXPOl+moZKXgWgXbaVMUdRPArb+t6D+p83ua/7MNE41NPpd91oP5HdVBXefAYGLHgpak+nR24osWWOu6ymaeKAfsjioEbKr4mTQkgXF5RY+cofkdQHgI4+YEpta7o/8mBMUyE1mr2MYS9naSb2e2vzBr/ZiB5j1gIEh/QsNNCxm+aCJEQymMjNBje7TjANxrGEQKpNpt3KJ4ok7YSn8guBFMK4+2TETdL4KwxlHxyzsWyvMyEy/YJ0aY0HYC2MP7oXJdk1Uo3+UojgFa7Pn9XOxTA2MryXC3Gw5WMfzfh9Z0pNP9svbb67RK0kb7LeNDu0GyLYanVDomxFvAPDaYtp+kh+6hjVg6yUFr7AXBR6k6Np2dBPkpnFRxB5ZP7hmUqiKI2rMr+8dijonV6wtxd4wAsOqB9B5jXcgKISMSrHPgEJSuCRCqM+8a1wf/VQWV/QDsq/ujQkCOEBbXVPvDPSzm2PuvMT1TkhSP1yETVaq764xujhefbdATUTqo5Szwrcsg1aUSD7NMnQb9NifglG2rRH4rYzscICe7m6QAWySz28b2KBYv+wJUU1oqduhATEI+iiPGJji4o7Jqzwnyf47pe3ah8bJWJEnFka9AZIIlc2lgS01kHSqVVgokfCfcY4Q4NgSHriTsO4tsNOM88VwFHVZSQRvyDembQNg2toyqaT29Id7vlujkBJE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(2906002)(41300700001)(122000001)(38100700002)(38070700005)(33716001)(186003)(82960400001)(5660300002)(66446008)(316002)(64756008)(6512007)(44832011)(76116006)(8936002)(6486002)(9686003)(83380400001)(4326008)(8676002)(91956017)(6916009)(71200400001)(1076003)(86362001)(478600001)(66556008)(66476007)(6506007)(26005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKsmm7cRE5JI05WLYnrl5gPEI7WOa3aC4D2JcZlSg07d4KaeTxGOpOP+QR+8?=
 =?us-ascii?Q?uF+PIe0KV9ijspQ6rKloXdhJMg8RReZebUqBjNju05lO1+cpzLYKxN6zrnNM?=
 =?us-ascii?Q?YFPsl77oz8VXWOZjk5H2GZHJ5+5rjzr8Xc2S5pZBUSgv4a8xZvz9ROgnMlSy?=
 =?us-ascii?Q?ymaCzPMQMJxMmYdOuVDKGA0KnQsi+o8j3eWvVzwBYKdfoYNEN1gw/3KfbVlj?=
 =?us-ascii?Q?HHR3Ai9M5kDDkNZuw4GoQSaqvCO/uhU/UL2ySVEIIMBZpmximOAtkUYDF4Gt?=
 =?us-ascii?Q?ZPMkj3to53aaD/k7OyPZK+fl3ZgtqoXGUMeTZN5GxNAN8vWB9narwoKnjjR8?=
 =?us-ascii?Q?7JxsCLF1RYDHLkDbm2+U4kwgObklwkXd5wZZSSfi9WcxHNACsGEaajGozb84?=
 =?us-ascii?Q?TwwpQ81tYrD9FUbIZVqXsrv8Jun2QAt8qJy0U2nn+toNwRAvDjoZfB2WPA9k?=
 =?us-ascii?Q?H7ooUX/sBbr+9QsbZZWSIVmCEiDLD38AvLorDpqzM15Xbvg1K9K29QpNl9wk?=
 =?us-ascii?Q?bogyOfFtwSW7QZILQ1LFmqIhwIZoO+YXTzTiPcpxE1scHc52bvTYr0YN8S9y?=
 =?us-ascii?Q?mcYtyEWjrxgZTYs/gzTnQ1Qf7oOXKoD2IuzHDlJECoQh9AYFvJvKpsnqDlvz?=
 =?us-ascii?Q?kJWJZlR5MR3cLyK8BBADSH+Cw5FcYCoXJeAn1eZj7cfuVpyWgwR/gkFxbegW?=
 =?us-ascii?Q?AvipiHW+H0pX8JkVz1LdXrUeML0Qz1RnDVKgdktwIkHlIZI23phhJWPGKXLs?=
 =?us-ascii?Q?xZpSS6mmjqBYEwCdaTJLpX4lzDkshhnJ3+aTYubtiQpj+ZTgNmgaB0DpEsWI?=
 =?us-ascii?Q?R0zmVhP19P4diTB4z0GSL4D28PEKRZDKA7o5KPYg5f4gEduhM549rVL1XAah?=
 =?us-ascii?Q?o5VTF5OgXYGR7Rzyb42cGMicJ149gDIlmnho+0MrmG4qCsROOusWCEvzv8o7?=
 =?us-ascii?Q?U+q3iLjrWRorTwXZLwLatyxdjfIXvSe8tKyKjM4V+kKpcYdmEo2HA5wS3f5K?=
 =?us-ascii?Q?8V2m0KtyUiXB14A0AGfMlGWZfSVVLKp98lFfchKS/pgrSwqVXMHsArE6c6AH?=
 =?us-ascii?Q?DkoCSGLhLqItajSDcXKmkaHIYdS01CIaaLRGz6dclVzqtC/GpasORLIwh81S?=
 =?us-ascii?Q?H6hHBn7l//b3hy3h481YTvF+ZrtfsbULl/v7R1wd45lkd0QZRbhQ/GRsrm2Z?=
 =?us-ascii?Q?gdxqQWQ7xTS59+YvlRnyaghLNwW9nzL1VwRno1NSFxXfIz7ULtMRGU0BdUyM?=
 =?us-ascii?Q?JZpIM4rEPWToLTbVZsf8wE2tcsIWX+ubZnNcCZ530mzbPNd+Q8jsGd4wR4QQ?=
 =?us-ascii?Q?B3wg2cdbqDjZxqUxafxl+qzrzQNW+JDuJtzOJgSldtPMcMY0ORde1+cjx30z?=
 =?us-ascii?Q?M3mzA942Km4VpGFvMyo0ZcgCb8QsHUjNf43LoE707d8VDcccl4d+ugBn+GM3?=
 =?us-ascii?Q?4qXkuQdhTlOEAXxAOqsxHnI5BkjW/2OZVZNMDigBrSzhWFiBo5c5vJ7wXoIn?=
 =?us-ascii?Q?dN7dStzYE9KD1gB3QmMgZfmk/3E6m/SBQAc1bAXREM1ECodU/OZAetUT9sb9?=
 =?us-ascii?Q?fuINJwULWf12c3SO/gafXmeIqQTm92DLsIaoyuJSNqZIlLWeGIgUkXCaGa4W?=
 =?us-ascii?Q?E3Mud/W4tGrZCZmiuZGw0+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5CB074353A1DA488583C8F3BD08298B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3389628-0e99-438c-e908-08da55ba6c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 08:20:39.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWHl7pVPNSBAs462CAxKDNpRkvIGs/nD1thSmbX0BtFOPB3UJm0OfOQlSmJ+Hgp5kl5vE+V8h3vkfCkJWhc5H+eR4mcHHNbsVZDcqLOCmCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5926
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 24, 2022 / 15:50, Xiao Yang wrote:
> In _have_kernel_option(), SKIP_REASON =3D "kernel option NVME_MULTIPATH
> has not been enabled" is expected but all nvmeof-mp tests are skipped
> due to the SKIP_REASON. For example:
> -----------------------------------------------------
> ./check nvmeof-mp/001
> nvmeof-mp/***                                                [not run]
>     kernel option NVME_MULTIPATH has not been enabled
> -----------------------------------------------------
>=20
> Avoid the issue by unsetting the SKIP_REASON.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Good catch. Thanks!

This issue was triggered by the commit 7ae143852f6c ("common/rc: don't unse=
t
previous SKIP_REASON in _have_kernel_option()"). So let's add a "Fixes" tag=
 to
note it.

> ---
>  tests/nvmeof-mp/rc | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index dcb2e3c..9c91f8c 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -24,6 +24,11 @@ and multipathing has been enabled in the nvme_core ker=
nel module"
>  		return
>  	fi
> =20
> +	# In _have_kernel_option(), SKIP_REASON =3D "kernel option
> +	# NVME_MULTIPATH has not been enabled" is expected so
> +	# avoid skipping tests by unsetting the SKIP_REASON

Can we have shorter comment? Like:

        # Avoid test skip due to SKIP_REASON set by _have_kernel_option().

> +	unset SKIP_REASON
> +

The change above looks good to me, and I confirmed it fixies the issue.

--=20
Shin'ichiro Kawasaki=
