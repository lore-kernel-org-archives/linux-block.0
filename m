Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8AA947
	for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 05:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726026; cv=fail; b=HgB+j2Be65CsCcBCjMzXpsLnBCEIm29yNJt9qXSo9ACTZXwyIlPHVEID4vKnuBj/MqV05k2+ynei4aug36CTzyxpJ12E0NBU97LFCgL0CPXWF1LE8dFza8jjjPz3XrvQP+PXeoayoMSHTMZEv4Ovkscpy11AxVy6gt6xuOAvgtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726026; c=relaxed/simple;
	bh=vhmim6qZNhFBWdIc56TCgTz2Np1yo0RKrm+uQO5uJqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJ5XjIR2BJ6EI+rYXx7AGFJYdqvhrwHwOoffnbIkTn5FGg5gxn27uO7y4EaiAlgUCJwfs70qwgav/dC1IWFimpL+4RrEDK/vxON5o4QYa07RyEpq2SXUYU7qOc13MERPT0ZQ/h5xGjDk1NRHhZS1+JAr8Gq15Z0e32N9Tdm03zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gf6oGqtB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=R/irWdMU; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gf6oGqtB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R/irWdMU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712726023; x=1744262023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vhmim6qZNhFBWdIc56TCgTz2Np1yo0RKrm+uQO5uJqA=;
  b=gf6oGqtBcjV/LRMTxCAmck08chZ0bCRqrwVYXNIbXDUGynC9AaNUWMqF
   v/AdECAbC7jSU+VqnQuMsd8CB4BX8AJrrK5ibSQwQSLAMXZrOVbC5XLqm
   pPQYd5wjMGTvJ6M4iax+YOZiPG10H4t80p9PQYpdBc7ocsxeiWpkUy7H4
   QN5oLKojK3xy5sROjqd4fxYPX0cjtYYldMFjl5EdgxWoShOlun3InaouP
   iVuHVXkwIEWa7o9CNiOnUgtGLCR59Vkp4OkKlgFgaQG5d8GN3cSMww6X2
   Q4A4/CxvKCf8VN3WfgchgPKMVLcyKoqnTCa3mWp35/2+LtcrlHNM1DP/b
   Q==;
X-CSE-ConnectionGUID: O8g/lNBXS5aayotf6Flrrg==
X-CSE-MsgGUID: XoMYsDYWQk6DFDDGy1RXJQ==
X-IronPort-AV: E=Sophos;i="6.07,190,1708358400"; 
   d="scan'208";a="13899505"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2024 13:13:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu36WAIRAm8fzYoVFDCNGXll0psFjkVoC7WjyWuFHyQ8vbhWdKAu/BRaUg59UpEcpGhHdFesThrNRcgxCbKYbxdPEDK6V5XpnIGp3JjLoCKy5ftQbYqKbSvBrg6ri4aWZiOpbD9mMyZCagZxDN6NeVHFAoEpnC+E+NflQOKb0ZQsX/EoPfyRtiuyCRXx84Vhn0fCWE8b5rU7IxJGT486G+VMEu5P1yZWx3qirW01giwgFReI/nRI6eV+PQDk8UHn/zw/sIfk4F3FQrDQHzVlkOH2kOKozVSH+V+ld4fzGwtHNoUCOpQQaIlXFhXv2gJsGluA1TwW6J71ngAF1VRsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhJX61no9DMFw5+hsAdqHNjhXoRcVGEzVhQAVPFk8Gs=;
 b=VsYqZBR+3bpncrPjzJM+ttUO+LteQ/aZtI71CnhAhQOi6r7esbYTDI1airwF2QAbpx4CjvzG6Hl+sZU27SLBLTTh+KN2ae0bCqvLfm09vT6MDCaOgG28RRFninYGUFuw6IEubotJrM83NwU44k8WJtU8Mh+LZFuH73nl0LM8pY2Qhco5nAiDVEJoAWxA9U9U7hT1eQyhjbmwhXsja834DNKKp12Em6/yOaREBQpdlvmLkKgOMHNeLd/1x8SGIrcAMTGRPkR3RSWYT5nDvqa5XhsWLEcvmD+0y2XYRF+0yijtE5ocHm53yj3bHF56dRQRv837s+JFlBAQUMPkaQRI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhJX61no9DMFw5+hsAdqHNjhXoRcVGEzVhQAVPFk8Gs=;
 b=R/irWdMUfiPnKBiXkk6WMMWRnYvnpv4nB0t+ZxqKoKViJjcd0dGrraR2nTdKXO7rjBtd+tYE31vTKu2d4jbGtXnNeYoZum6PfkI4L5ZKTM/vtMP2+p96Yh/fCcgJpm21pYZ9zDc44fQ57jOOdPg3NeWq3QeH4oqd2smheEJJl4E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 05:13:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 05:13:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "hch@lst.de"
	<hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Topic: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Index: AQHahvyWiheVndYbAU2CjNmML0/vjLFZTnqAgAFeVoCAA0XkgIACt8UAgABTNwA=
Date: Wed, 10 Apr 2024 05:13:33 +0000
Message-ID: <lfv2rqcpyyeqv7efpc4ozru7daycx4nv5nmc2xh4luzgtk3tjf@oq33dghcnt3j>
References: <pbhs6izmwy5sfn3u7ldd6egwi3m4xadmvdgjh2qzy3houvwzyt@v2auexg4hkke>
 <20240410001542.4036191-1-saranyamohan@google.com>
In-Reply-To: <20240410001542.4036191-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8330:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AQ9sDJ6M2+sY1yFhqHsBzxAzn08SNbliTb31PxUTAE3eM3DHjxDQVpSjfI4SW4g4fWx7dvk5dteGrAH3OBEA12sAXcLuBadWhUPjcC3ePZ5jIpvgHVXZAQcFR1apmx/QkByLEP6SrzpGzwapgT6HQv9bikuqBQGyzXOfEkOdS8Y7ujH670vLO6WMClyQEzS4/pjr5FVqfNEiT4shAfuvwyeHcTVA3U8ue3utjM4EsFsuE5AswSgMJVEZmNYHCvrT58obm4f1OOjcMVipk8D24z8i4Q6CX4nKgRW8Gbe+BBP1WjUtYsBCLs9nmD3WDHuznAzkLrG5Ircy3T8OOYIzqSy7Cmn6lFoJksu+vL2tn7jwUpxvNwRVDQVPlpGeaq7H5lFElEVDJI64gETWP0mrssP462y+95LuU7R7m0uV0d5YGfNctqH9m2cjpntySjdgQRn+izWE/0WYboylgtF1buLO2/RQulAnJcJTyufsD6Nt69qjP13WfTT297KVUSUxmCOfHKowCuaAB2wd4HERbHuY21WhnLbaG3ZyOIX8XIHfgKBCC2m6VvKcPW6axZ/JLLtarP6FaBZiFFWvDaQsCzhOotzV8wxcsDm+9Tdd5e8fBx9fkZdcj87HDGXCU2BgE8ky6LibQGZezow5U+AqVw5vkfPcCQ5IYs56geWPczw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oaVMABgvAzR5RE74bwY5PVAjxqXDgPYqdyJ4b/aEOFiJRhmnafV00OE/IDOZ?=
 =?us-ascii?Q?RPb6wo8YDi6cObsvnqPTiqU4wQ7fEEPHivxXpIvRpfqgkEMVQcpeIgRMmop1?=
 =?us-ascii?Q?TLWY632twFv2Bn1ogBiRaGkRX5f8n55ojVZfDDg7oJ/4UZ/hDDuQN8Exp5sb?=
 =?us-ascii?Q?CpDWWwX4xVEP8uE7ho75LhCHaBv7JDtfQAPzd4IJTPf86pPbdpzSrUTSDuyb?=
 =?us-ascii?Q?B3OnbJ+r/IN5mDSnTyn7VsSVGCQuptPoXRv67aOV3HpOHCmOhbtliJUQHMWX?=
 =?us-ascii?Q?xwwML8LLb62n3GlKxciIGz/NZyHS5fyn1t3U4J5hlWKd00wmC5ie9zATVXpm?=
 =?us-ascii?Q?SHUXAzErC7cF2IHO/PBhW8qU4ahkF4CZPgTWx777yXZn/6JNJy0h36BFLFLQ?=
 =?us-ascii?Q?D25hKPsGtN4rxGHcw8ca2H+qsgVtJClQD9ZQ/3cik3sMrBsiOmJobDryxuaW?=
 =?us-ascii?Q?wInegRYvFPffqO7Xntsw4yCACNmVIpeYd2qpivS2M7MeCxWZELKVhTDFFxGR?=
 =?us-ascii?Q?G+/jK7sGA6owGkP7tDprLq/GsGpUIwJC5nLZUZenSuP7V8OI30dbzE4Av8Vi?=
 =?us-ascii?Q?A07q/zqxCmrgFWw2VKjJXia3extmUsLjaNFF/e0ILHWR5YPN7zvL477gmYEe?=
 =?us-ascii?Q?vM+ULTPd9xoUZGY/rlHRjw/Y8LC8kZP4RaVgXaABFEpOEtZNgVo+1+Zbg1Vq?=
 =?us-ascii?Q?aGtTTV8cvX2Hk3rwvRxCRj+x/hArKVQui3vjuRnqdg9UqfDfhuAz3aUy+ZiJ?=
 =?us-ascii?Q?CN46j2vx4aLWRO7VShnQ0CTAajhhTdNrn0DoisVe9bm5+QlXiswVkswZA4SB?=
 =?us-ascii?Q?Ie0xim6vAKDvNuT067xkNb574Nx4mvd+OfUKHo1GhvfsivJ2oazBYj2i0qYj?=
 =?us-ascii?Q?deuepjQzkvqili0MVYYclo0dJe02RjWzJ0zc4wwLvMTEzHzMdkNQ2Yzdb4sT?=
 =?us-ascii?Q?u/avWbVrSROdYtKvTD+BteDWun2RQqigxIAkj17El+EWVjZC5zmXkLR2SG/M?=
 =?us-ascii?Q?LDLiMrDOxgG2BVLjBNAeIO/5TfLjd69VFIRNPjnL8NuFFM+jXt6IqrBhBdu1?=
 =?us-ascii?Q?Ac15S/mXZSfSmiAHd03QZ/tXLyBrfJVYpPY07VKMS2m3dT1WRvIOAoxu62B7?=
 =?us-ascii?Q?pJWlOzDrPtnXc2iZiUgOajqddh+cPn6HWL0N79jk08W6DIJKp0b19A5msGjv?=
 =?us-ascii?Q?Vk7Gq8TFoZ98Wo2+xiR+nMpl/E+q/SPQQkmk6FLpURSQTPAen6jQL55aQkju?=
 =?us-ascii?Q?4S/rJnODhppCZ22jrLEvd1IKmyu0kPlglVdJgVlJuivxmKp4SsOiOj1EvHyD?=
 =?us-ascii?Q?NEfJUFnRvygTxL1UK1D22GbzDE1VnrzSNCRwhZoZvUcD6DOFGczqW3xeqKVv?=
 =?us-ascii?Q?jtHQiZO91VDluULSpSLMMlZdrUzXYOd/bKgfUdnF1Kv4E86FUUVE8RIuBbif?=
 =?us-ascii?Q?Tm5JMNsazUhjRlG21lmgMXXGo+uqOZriszySRfOXfwy8Vn+okVi2MfdphiP4?=
 =?us-ascii?Q?OtZOh0bL6WzLLk4Xjzth2+EPKVLyeIqR8u9h3qtrhDl+e0Rqo0AnX58rL1ub?=
 =?us-ascii?Q?tc7+IsFlDld9jXnlXrehKr+iemHi10bkUgePSUosReuTjrrvNU9hi1jgSJtN?=
 =?us-ascii?Q?2xi9oL61lo3CVBTfOE9PiU4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41425EF38FB05341AB7DB57DA1C250FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c1AUYq0SPNoH0Tx6HsKFTP7L12YtLZ+pqOKpU8BaclpxX0jJDtdjaipBlJsYGcJcWTxSh+Xoc7MMz86/OIefBeYTOue06BjrFwtPoKfqX90b9wNhvcdlrK45hRgTCzl/I7jGWKs9/nk5Ann4dEmK3zvcSheixQlM0C4hzg9JTrUCfctFh4gQDdpkryTB6bNAGIk5Wl1FuwaUc/WUzu8tdOwkZG4tEDG4Fng+kvy6Ya0wEpd5eKwJc4VDAvmoqD8grleuIQAQ4syx3gGIqdqsg4kGui0+MxKcd/RIwAHS3tqChRQL9dcNbjs6BZwYR/NS0vXzuUY0gRazFtaN5TOSNZKiWkIGq4Gt+90UgP8h9Hgx1egAzONjiW+smsoyEursgDjnfLPJOsBglce3HSEyNNVeJUmHVhTwOezBQgV6WzE2sJriBJHBl88pfF6x/SfRoK1h92JTulNzSXYTAdfLtOTyoOi1fe+N3PX84qMKqOK7Vtpbygg1+6IBu2dt4JQnsLf1/B0XYTUy2Yk0GnYCDd7LkuETqJuXiHigigowzeMa6w82b4QspEnDFuIPd9CKhRb4afoCbsnQK9jafdKizAhhE/5ADTN4LcXdtG+GWyQ444VMwm0pAvTJlsdHFWXp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33766661-ccae-4cdd-8f74-08dc591cf828
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 05:13:33.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elGpxV8TQNgs6LVStOPIgCNWfBAZlyUvhz2VGJjO6GRDoFG+q89tEzNVjK5E1D9pCiX4fYfKWK4HF4EQYYgAz7tOhe6g3pZHkWTC28MY2ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330

On Apr 10, 2024 / 00:15, Saranya Muruganandam wrote:
> When we fail to reread the partition superblock from the disk, due to
> bad sector or bad disk etc, BLKRRPART should fail with EIO.
> Simulate failure for the entire block device and run
> "blockdev --rereadpt" and expect it to fail and return EIO instead of
> pass.
>=20
> Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@go=
ogle.com/
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

Thanks for the update. Looks cleaner. Still I have two more comments in lin=
e.

> ---
>  tests/block/035     | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/035.out |  3 ++
>  2 files changed, 89 insertions(+)
>  create mode 100755 tests/block/035
>  create mode 100644 tests/block/035.out
>=20
> diff --git a/tests/block/035 b/tests/block/035
> new file mode 100755
> index 0000000..e15f115
> --- /dev/null
> +++ b/tests/block/035
> @@ -0,0 +1,86 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Google LLC
> +#
> +# Regression test for BLKRRPART.
> +#
> +# If we fail to read the partition table due to bad sector or other IO
> +# failures, running "blockdev --rereadpt" should fail and return
> +# -EIO.  On a buggy kernel, it passes unexpectedly.
> +
> +. tests/block/rc
> +
> +DESCRIPTION=3D"test return EIO from BLKRRPART for whole-dev"
> +QUICK=3D1
> +
> +DEBUGFS_MNT=3D"/sys/kernel/debug/fail_make_request"
> +PROBABILITY=3D0
> +TIMES=3D0
> +VERBOSE=3D0
> +MAKE_FAIL=3D0
> +
> +_have_debugfs() {
> +	if [[ ! -d "${DEBUGFS_MNT}" ]]; then
> +		SKIP_REASONS+=3D("debugfs does not exist")
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +requires() {
> +	_have_debugfs
> +}
> +
> +save_fail_make_request()
> +{
> +	# Save existing global fail_make_request settings
> +	PROBABILITY=3D$(cat "${DEBUGFS_MNT}"/probability)
> +	TIMES=3D$(cat "${DEBUGFS_MNT}"/times)
> +	VERBOSE=3D$(cat "${DEBUGFS_MNT}"/verbose)
> +
> +	# Save TEST_DEV make-it-fail setting
> +	MAKE_FAIL=3D$(cat "${TEST_DEV_SYSFS}"/make-it-fail)
> +}
> +
> +allow_fail_make_request()
> +{
> +	# Allow global fail_make_request feature
> +	echo 100 > "${DEBUGFS_MNT}"/probability
> +	echo 9999999 > "${DEBUGFS_MNT}"/times
> +	echo 0 > "${DEBUGFS_MNT}"/verbose
> +
> +	# Force TEST_DEV device failure
> +	echo 1 > "${TEST_DEV_SYSFS}"/make-it-fail
> +}
> +
> +restore_fail_make_request()
> +{
> +	echo "${MAKE_FAIL}" > "${TEST_DEV_SYSFS}"/make-it-fail
> +
> +	# Disallow global fail_make_request feature
> +	echo "${PROBABILITY}" > "${DEBUGFS_MNT}"/probability
> +	echo "${TIMES}" > "${DEBUGFS_MNT}"/times
> +	echo "${VERBOSE}" > "${DEBUGFS_MNT}"/verbose
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# Save configuration
> +	save_fail_make_request
> +
> +	# set up device for failure
> +	allow_fail_make_request
> +
> +	# Check rereading partitions on bad disk cannot open /dev/sdc: Input/ou=
tput error

Nit: /dev/sdc is not valid here. TEST_DEV is the appropriate word, I think.

> +	if blockdev --rereadpt "${TEST_DEV}" &> "$FULL"; then
> +		echo "Did not return EIO for BLKRRPART on bad disk"
> +	else

Why did you remove the grep for "Input/output error" in "$FULL" here? Witho=
ut
this check, this test case allows other errors than EIO. This is inconsiste=
nt
with the commit message and the comments in this test case.

As I commented on the kernel side patch, "blockdev --rereadpt" returned
unexpected EINVAL. I think this case should catch it.

> +		echo "Return EIO for BLKRRPART on bad disk"
> +	fi
> +
> +	# Restore TEST_DEV device to original state
> +	restore_fail_make_request
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/035.out b/tests/block/035.out
> new file mode 100644
> index 0000000..0f97f6b
> --- /dev/null
> +++ b/tests/block/035.out
> @@ -0,0 +1,3 @@
> +Running block/035
> +Return EIO for BLKRRPART on bad disk
> +Test complete
> --=20
> 2.44.0.478.gd926399ef9-goog
> =
