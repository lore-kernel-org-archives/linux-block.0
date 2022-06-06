Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EECCA473
	for <linux-block@archiver.kernel.org>; Mon,  6 Jun 2022 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiFFKl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiFFKlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2022 06:41:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B337AA3
        for <linux-block@vger.kernel.org>; Mon,  6 Jun 2022 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654512082; x=1686048082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kN4e1yQ6Bc0MA2qoSFyg83AdiAY4at8ckHT1PyaZW2Y=;
  b=QFe0U8w4bxAr3GM3F98U9v1Dt72e4gfLTIwI0Zn3cvjv9QQxfwDIB/fi
   jFhKPcdvocfKXkEdFbk/YsO4sil+VRrqrix0vI4WQnaPI1xpGS8IbGhFt
   nqubMd+pvxpJQr9IWeh+CkGCjbR/hDtaIq4XV0MaJ2r9JCg1LatVwN7B8
   p/pnec4vH+d+Cq7L9qGPaXmymS9X1tFKvzak+NWRCYO94n1UsVO1YUr+F
   2fUfarxKw1OvX94XNVmzK2Xy8JwGiZAe62x1M03lPGkrXAhlv2f1Lxj6N
   V+RS4ciZ0WQpPTIQ5bKCLQxR1/ZEbLmJkUvLkRlhwXft//kgPut1Rax3x
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647273600"; 
   d="scan'208";a="314412807"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2022 18:41:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLcdMEa/X23IQmWRZds0O0nt+ZS9Zq6v5C6D1mPjK2YtItPMn7yuTyojw5BACdM6/DIddYRDE/m9hdkaGcTMJsQBchnTPGtckYOOfWuQwFj8LW66A/N+gww2IPxBP1CVnTYNYDiflNuHLxmg5ZmQW5vVP7c6ogPjbipNxoWZqhDukNW+ncwV4fsDHhOIM8fiO4fWj3LaFGBZBR32Tk0EJJRBQ2w7gfwR67ArbTukzuxSDXKZiZhbTYOp9YDvSvlaUqOlK64KNrfQitQQ9MT2Uku4mqLOTJAd/tyZKaz4kEC7mMZgF4e6TJDWJ115nrSJvwELEdlSdEP4wxqnLatmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiCbRx1C0SnqlV10JxX4iUPGSo2QiElGgHu3xlRt6oA=;
 b=aaMDps8EuduektA9ovUX8GJvYL5poFZs4WNDX/Qf6yq+1y9uwzCmANPc1+tvzom3KtaxGoIHp7cPCk0IjhQQfsF3sZ0g+/0peSVbvDIbFOelE2/4Z146kq1QLJED2K5sTDX8elshadsvumOYaqW8hxVDL4PbUmAKNNKSxdohga4EER65YZ7jycIUzmRQdD3m1CwDXe6hP5X+xAYl3bY+rAmbotAXV20c743LGIHF7VElw9xypvQdFo/5hc4bTkJAl5h7NHFEXUOmyzTLKWgQ+GWqYDVsdoznZ73rEkQpkBL+zRWkGvLsuKmrQ4kfAn8ekcgCByLJpc7K6OHcdmgThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiCbRx1C0SnqlV10JxX4iUPGSo2QiElGgHu3xlRt6oA=;
 b=tYTGh/K92B4UphEVBucmKNDXNVz0UuSuhZD8ZD1mxh7E2S4UbRVq4qw20I6eGvpW4osiLkTMqvx+sMa8Yc6U6x4z91lDTMizKI+Nau2ms99pFIM5MvG5MkOVV13sT5mkmMQCY4fFlLXGzDBkC8j2H4zj5bC6Oe/RZF45tpW9Ceg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7493.namprd04.prod.outlook.com (2603:10b6:510:51::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 10:41:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5314.015; Mon, 6 Jun 2022
 10:41:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 13/13] zbd: allow falling back to builtin
 null_blk
Thread-Topic: [PATCH blktests 13/13] zbd: allow falling back to builtin
 null_blk
Thread-Index: AQHYdwZPzfPdwbjrjUyXxR5OKIDgra1CNdqA
Date:   Mon, 6 Jun 2022 10:41:18 +0000
Message-ID: <20220606104117.vinbfvotdcqvvgof@shindev>
References: <20220603045558.466760-1-hch@lst.de>
 <20220603045558.466760-14-hch@lst.de>
In-Reply-To: <20220603045558.466760-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25375632-f7a5-4201-566e-08da47a916d7
x-ms-traffictypediagnostic: PH0PR04MB7493:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7493E3D312D2FFB9F6CD6D2EEDA29@PH0PR04MB7493.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpIRLOEMRsk+YJGoFwxDst8lKOi0/C81qufQ6cmlG/iRSjwriPf+dciENblM6BgR24Ucq19VfnYmJL3DZur6N6TaAJUmZYhcUGndek9pmxgU9ItjILDrnaB4o+7rnhRbwwM/fdnQB7x98SpQZert6t0njWZMUsO+RjXARUYxgpiOgIXls57RB6DkI6D/+FDMa0O8iWzc0rO0bW7hELAeJGTcmQ5UvpiwLwhtcWKl9q4QWG75phcGih5a5hdf8OYix2M/wNVAsauz+DFoR8ItoADWon6358sRHg8VCVxcYBcFW0QoX124AXVNyXKIQOvsfRgAh6zz8mk9o8UIqGJD7gzeDhzrDd64a33yeqLKqVgFJbigabjtk2SY/e0/YEC9YYYnv2x/htQ/bqyb0vnXqaO0r/9T/m6DUAjk295sYIwEbwMw7pXHb6ckaNdFWQhBAofup4NkPGOsVaMo6L29QD1RoesicFA7BKkbuVA4JtpSb/68XOSa8XdJGoJaQAsN/ECXRWcveTsKOyu2MFxo+rthZn7mx6E2hnwO6StKieRvWcLHL3oiNYNhTgX7ehKh7Lb8uQjozNQpC+DTYUxQ0edBmA4NgbYN3bi61dWMR7GA2omh2dLnuZQRdU1sXayUaB1sVfsZVojZTiIs/q9RYCTNFWduIgbb0uJb8PCIO/j0rRNL8cRvtQNdgfIvzPPXjvAn8ouDKNnsYylIh03dUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(83380400001)(2906002)(66946007)(38070700005)(33716001)(71200400001)(9686003)(26005)(1076003)(6916009)(316002)(6512007)(6506007)(186003)(3716004)(4326008)(508600001)(82960400001)(91956017)(76116006)(5660300002)(38100700002)(66476007)(66446008)(8676002)(64756008)(122000001)(44832011)(66556008)(6486002)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R1KEdvnf+ji6u4BwzJVpNpujB4hQJWyIitTIfZCMwUzhVFDeK6OaYtj6PA12?=
 =?us-ascii?Q?MQK5g1wEbo9uSDT1Fnr+mBfc7cYwabInLqcukcDVS1OT/oI1XP08Mc1/eyk8?=
 =?us-ascii?Q?ow+Dg3ijNTq/cMylLHKXyuacywmAFBH6Lyy1QeB1VDdq/w8uvD93I4frf8xH?=
 =?us-ascii?Q?KJILFUfGzjYY8t5bI0Qj90UWvSiLyuSKft2cTpeSIzRy6XObO/p/ifktPXEl?=
 =?us-ascii?Q?Hr6Ty1UQDN1UbHXsBw2Etg7NjY+Ocz5Q0kHO5UDb8Q2WV01qJVSVmZSqY9AW?=
 =?us-ascii?Q?/edYTMfnAHR+6slLqm2ClAaoXAHNhkxYA6ASJngJsWMQHXj3Zu4y4882bxpq?=
 =?us-ascii?Q?GseRZbYxct/5YbkJZFHZKk7Zi1wDOMK24ByrsfbYPY1lf6/RB1+32PRdcULy?=
 =?us-ascii?Q?UVKVNWo7vIb25jQLOndXgaYK99O1h3qS74iNu3SnvFCPy/r4L91e5DMH2MgM?=
 =?us-ascii?Q?nbDpki1aC+yKBqNdq1tw+AahMQpToT1W3DWS+AmXcDG/SVnwpO7J8q3t2kVu?=
 =?us-ascii?Q?uUTh9KwM3aSfUZfxxd50FBhYh3M1LhI4RTF17ne1KhwOzZAxc9tG6xvcJzV8?=
 =?us-ascii?Q?RtP9LmDQ33js8+TFWMaqTxdunvLm40jKb+pJgqSQt/ccCJcSveLdYiavLrnl?=
 =?us-ascii?Q?1cL+vUFlC4G1b8XQBU3QnVqBwL+U3cv3qRNaV6tpbAIXq2bgf6NCZjhBdIBW?=
 =?us-ascii?Q?Cu7H9CqtAVeD/fGmXpIeFHCdXmRixQt9tcPdx3ExnRVq6YjVZH8ikhuCw8Nw?=
 =?us-ascii?Q?hbWr/Q6RPvOQspn33vcsqBGkuobX0Zflrm7/KxcJTPLkkwJfEMA3iNmakKQH?=
 =?us-ascii?Q?88MvqihhpW4KKWstvHC2HGA1Ggp0YrJXicR7AFz+G3kvWHn/eCzz11cwqPgI?=
 =?us-ascii?Q?22MlrN6ZLu8WzFYAavD6lpjU4/yhEX6odvckpErMJevLxViycgeKxFHJJQAr?=
 =?us-ascii?Q?M6qtZgfJXJ/6qcp+gkD5uy0NWWzQ+9O9quFUr9DtA7UB7BjyGWwHl+oasx76?=
 =?us-ascii?Q?4CjwPiif5apelsl3tSaJ+SesQ5ICHGYWl+JsMBXXrQOHdsB3jV4W6vwEMkO0?=
 =?us-ascii?Q?klSxg7RFpeqBsSOwq586MyvPCXPO5bMmZf4nmvtPcpW6S3kbZEUHOtfsitch?=
 =?us-ascii?Q?JgRkBdwLTO1xcJarEbk0rMEnHosmB0GQJxGVXqDsxU2Ry/qHOwcgZQxLE2Pt?=
 =?us-ascii?Q?zAERnhqHoKz6XW1HGRxJtCMxu4784r2Pwj6zRPXDLOFtIkXWzXkfjgzylm6I?=
 =?us-ascii?Q?cpsMyG46A55aQZgQVgBb5FlOXNlxwkW8CA+YW5fElsrp9wEKh4EHxjqRian6?=
 =?us-ascii?Q?C/f2s0KfDhYsS2o5VrVZxlVfOGsUwALqpd9DC7z75Ov3Ht66w09tzrILB91X?=
 =?us-ascii?Q?b1ViQb44Bk0mfNpOL0k65CNFb59eQsRniCR3kzS9lVF5BW9C6V12KL6Cc9IK?=
 =?us-ascii?Q?/Fr1KpwChiC+EVB3kWPVSwezpXEaKmQtRT6B8yEthiboGFMfYGQxOg/x+EK6?=
 =?us-ascii?Q?8kYnySEVtGoMU1BjxuOTPt0/E6D1o784OX2f9vWNjQfrYQqUTNgvwkTlLRc0?=
 =?us-ascii?Q?Kc/3zcr0cxg1YMkpVLn+aft+DKBHHHJcjwxMZcu2t7JTXE+Wcdm2ytaUX2Nd?=
 =?us-ascii?Q?Ym9Eh82QNP2+lakgxyUm2rhFgJBhLAI80bgwqB8IhokfyBolZ3LRcInhDiJP?=
 =?us-ascii?Q?Wj9qMpGpqOtTaiO0ZgZfyv5DeAViOufA97ABTW5cFHrTOcE2tORMd8/Wo5Og?=
 =?us-ascii?Q?Mh/VXVFjwp+2RQeR77rcQgHAoRBeidDDpreQ0JyjcO86dKkxh4fZ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E94CB851A4191949B2D1E251F2A2DEB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25375632-f7a5-4201-566e-08da47a916d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 10:41:18.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0WZGzfO7XccI/lRvY0q6JsgxmG+DmJ3i8Lihqfp6v4E4/Mb9FR1oV3btQV8ay5m/Sh7Itp1czD0ttEkVZe4x3LigA7uCbZ7/VF3ax57I6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7493
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The word "builtin" in the commit title would be "built-in".

On Jun 03, 2022 / 06:55, Christoph Hellwig wrote:
> Use _configure_null_blk to configure the fallback device and thus allow
> for a built-in null_blk driver.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/zbd/rc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/zbd/rc b/tests/zbd/rc
> index 9deadc1..e56d607 100644
> --- a/tests/zbd/rc
> +++ b/tests/zbd/rc
> @@ -13,7 +13,7 @@
> =20
>  group_requires() {
>  	_have_root && _have_program blkzone && _have_program dd &&
> -		_have_kernel_option BLK_DEV_ZONED && _have_modules null_blk &&
> +		_have_kernel_option BLK_DEV_ZONED && _have_null_blk &&
>  		_have_module_param null_blk zoned
>  }
> =20
> @@ -25,10 +25,11 @@ group_device_requires() {
>  }
> =20
>  _fallback_null_blk_zoned() {
> -	if ! _init_null_blk zone_size=3D4 gb=3D1 zoned=3D1 ; then
> +	if ! _configure_null_blk nullb1 zone_size=3D4 size=3D1048576 zoned=3D1 =
\

The unit of null_blk sysfs size attribute is MB. 1048576 MB =3D 1 TB null_b=
lk
is too big and triggers failure of zbd/006. The value should be size=3D1024=
 to
keep the same size 1 GB as before.

> +			power=3D1; then
>  		return 1
>  	fi
> -	echo /dev/nullb0
> +	echo /dev/nullb1
>  }
> =20
>  #
> --=20
> 2.30.2
>=20

--=20
Shin'ichiro Kawasaki=
