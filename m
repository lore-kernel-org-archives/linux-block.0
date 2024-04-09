Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F01C0DE5
	for <linux-block@vger.kernel.org>; Tue,  9 Apr 2024 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624196; cv=fail; b=dFz8EilV2wGrOL2ElCYQ51ISPKEhzgUCMR45OZV2HNgrpu5WfVCzbHEhdc/mrwO3IzUoKT6rBlvJPDo6N6hFmr8JcgyK3Qtbi0FPxsUT8vKDlxIjB+L8b0eM5Aer0TAhLHrfIwpnTCjbz6EEr1GI3NJKsGy2Gg5hy1UEINFjP94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624196; c=relaxed/simple;
	bh=Yrm7iVAzgtVW23culc91w2OHbYVxWcJXXRBFYRsOuyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6WGYBUUDOSOrGfbkkOd69xmgoxjL+CO3XWRweUEyB4p/aOxgI5Cx6oe+28fQiqOtCf1UA3jBj/Btc/3meK5uzTTlFfyJhNFP2H3lW3Td20tY4sDa3VDQ2MvJDEJIRi9C07WcbtkTLcmbdQTyfiIVHoOX1PQEGUZGe6Pe1ZoCCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TrCfwSFg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xfenSAUd; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TrCfwSFg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xfenSAUd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712624194; x=1744160194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Yrm7iVAzgtVW23culc91w2OHbYVxWcJXXRBFYRsOuyQ=;
  b=TrCfwSFg8G/KJkhSpAphMSBuoGNkqomm4EGdQWjYGbt3dY90wX6/hrZc
   zoP4nWTe6eyH5FpMxOJfRoNHDj1UPO2vc39aYfYgx8CnRl+5M9/3M4+dN
   ax5eRJPpKJqwSYY2mGfvYv5ch7O7AqPjaz+tFCwcTlF7bf5/9mHKowL4u
   99P2UWBLluYJ/JhzVrRSgaamZvAjteE21Jzk1s8poX+DZy02gtTyZO8RS
   h3hKY8rIiAK3lgxOXzIK4kJizGHteaGrPMEIha8WIo3etjUk4/h0OhAEW
   Whg/6Xwye+3R5ujPIKRN3TLDqfk5i95rjiabFm5+iheg8jOpGAFuWlAw9
   Q==;
X-CSE-ConnectionGUID: XquguSqhQFCqVVvZjDpwiw==
X-CSE-MsgGUID: 37yRYumrRsmtEbefFoasbg==
X-IronPort-AV: E=Sophos;i="6.07,188,1708358400"; 
   d="scan'208";a="13372195"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2024 08:56:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQcaOZLe4kU3kXg+BaoFyXvN5CV7UZwAD6VrTfm8rtBfMqfSkWGNniSFucVhD9q7PeQAeN/ZbV/bqCIqKT/qLeHWXeOMMC/c/mFCaW72wv0VhWEerO8E12dn8jZUTZYVugTY7sZMUP4enTpN2x2EXGoR8N2IF8iOQfSUuUzhLazE6tVz1GDNMOU7zp6q59wMNS0QAdLANJvZ9ojzH2+y8WvFJy1R+QZgCADuLHq5hr45bhp2q1J21sMfFWGlp4kduqU8xANp10GJ1qInU+o1b6egTiCrLhevp33T3IRrM6GdfS8Mug8cqCPFoDYTFsXsvsj/sB1qYp2TqVag/vjm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxUr7o2Ay0oy5PDpzgizSA/NjT1G0TQgWFUpxiU3peA=;
 b=a6zy4veBCJWRWPal/yjUTu/X694DjSQEWz4BKsE6ef0EuGxzWfE9rtZqsNlsetJhh2z+yWNPToNOjtqbxyeKQIBj5VssWEJkOnAmQVmzbtH6N3OgoABajiuaWTVV9C9x7tybGZWGkTGrH6zhi4qVtaBIu8f1vB4QSEYgatBlgMTaBtnt5+Rtmyqrd8eV2ZFPTkdfaTTVorFtFPlXtFhKkPbVYAf/zdm4wuuLQFjYn0UPnDm2fwRd+ieYpit1qfcLF2X6TRriZgXLWAxlVONpxuKGm8i4lErqgZWPlnMq5JKSb7iXN2Fji36+6eZ6zraYque2tbfY7bo5xEIsY7Vcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxUr7o2Ay0oy5PDpzgizSA/NjT1G0TQgWFUpxiU3peA=;
 b=xfenSAUdEmJq3la1Yv2tYKtLMiCrGkjcjtOZVxEldGVIg3cRZ5HMZqhcBTBHnEn5Vj92SDrajsE/6cT6ITijxv25sriga+NDbEWAFKO9sHLryJ6EKaH1dgdsPFUhtAjIykzwDbzlapEgSC5ICnQ2nYSnS/kGpYNwEtCrP1yaxpI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7531.namprd04.prod.outlook.com (2603:10b6:806:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Tue, 9 Apr
 2024 00:56:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:56:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Changhui
 Zhong <czhong@redhat.com>
Subject: Re: [PATCH] block/035: add test to cover blk-cgroup vs. disk rebind
Thread-Topic: [PATCH] block/035: add test to cover blk-cgroup vs. disk rebind
Thread-Index: AQHaiOspDHzPtxRW60ySXdFP/g0zzLFfH6yA
Date: Tue, 9 Apr 2024 00:56:30 +0000
Message-ID: <xskkrvbacbubmcbc2tamt5aa7hepvt37y6kl7mz2lqvgswumb5@6hqkngrepouo>
References: <20240407125717.4052964-1-ming.lei@redhat.com>
In-Reply-To: <20240407125717.4052964-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7531:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eUBcA06gwbZvZVdMD/nT1poalLj0IVDhmztx9rgeOxOVhNBiCkmB7DHrjCfF3Ah3HWV/cpvfQ+2kz2VeaNCRUmnNJafLMX4t3El2c+7E2hAoaX/1RqY7K4kkvWHgNCYfgeTqPJvgLdwqYzKm0MKqkdIcMTCyt87FB2z0SfYOLnVFXRVgl5V/g7tCGiukOk/t34eJohQFR1bdcpH9KhS1Yz0nNPCVGUtDi/Kq/cm1KBeYNYV8cYcrmfqAcC5XDepkleTl/O5HFLa07HJriyCDidjzF6r1fRN+j9Y6u/D5oxhInVyJrMFnisQhA7ZblRlBgyWfimgGT7piEZokQ3V8go291bWiqT5x0qf46vhHck1G3YXQXFcO82Z2E2fpGrIa2nH02qFOBZqBskNF3HTGE01dIjgBmkr5SfFr93cNduvtFYmaJ2YU9cyFqRZvQe6cIS+1RCxTd5wj7TTZRjjtJ0PC5ka/TVC48wo+c956CjuFgSQUlHa9Ytib1Sxt0PxwERdWsZszulVRYALuDRkuJzLVPCnjM81eIU59JUK6lhij6aksfRkj4ehfbH1fsTmQti70A6Ur8pASe06ihvWeg75upbMtfvsXuEAKbj/L1qQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ln81WV+9TZLBnyBgQGgrXyuR85IrqtXPvKKAmWwfstLPDFSLapQqDTGu0+bu?=
 =?us-ascii?Q?oYzBrwy7AUAHEFl4y2dLkFFxof0ESeBp6a6gKqtz/ka+2+21chjOfjzqO9wT?=
 =?us-ascii?Q?06otn0DGlSX1qrhJEkHfbPjmauB2XkSoPIZBK7dIw3oKrTkTXNyGoGnZHBrP?=
 =?us-ascii?Q?80ADIlO306DlRce1VgA0/50IJR5Bw8F1fxaEcTQMni5srfR3wS4pQaGbSZoP?=
 =?us-ascii?Q?qldrPK8RN/olEjRocRNh9zZ+aHXpN6oi3jNeP2jKMEY4+PwphtO2MdMB0bcw?=
 =?us-ascii?Q?SmK+I5WAGnrTxHDqC6ecR93shDPAer5dCne5K9kvIW3wZB8xJ1yXukgUjYb9?=
 =?us-ascii?Q?akd7ZjvEQM8bDNdTgcXiTvHK4VP5TyyfxcwW5FGgHEcc0G9hzj4QPKn7Yazh?=
 =?us-ascii?Q?zl/YnEQd3OXOmHdqOz+spREB5Z/CUpLAoFIO/oYapANM71nMbJp25vxMFsza?=
 =?us-ascii?Q?OIr/3bckZws+EVTrGagYJ+Ki7sqLZScLh3lIIgzJpsNJiJlvgx8m7I9Me7y5?=
 =?us-ascii?Q?rtlXzs/CG/mURpVJf3G7w7IElFnh5XaEIDvOed0hJKw696VLZbnb1aPcvvTu?=
 =?us-ascii?Q?yx6Jh/4ry5/6fKm+BVLjoynwWlLDgxbetRph0JaH124ojOWV6OmvNTdeWajF?=
 =?us-ascii?Q?bc/CiE5hf4DKK1KipSv3CqPreXxHTpz7g9aXaE+zK9pKdENlXqd66D8lgLDW?=
 =?us-ascii?Q?SQkjuvk4ao/qCDhoU0up1JVFFR6RhiRx5u5vUkCzL/4h11bQNjOk5fluPyJ3?=
 =?us-ascii?Q?C+5iUkRmLavBC09Q2B/i7fe6e5QG16y+MUZj18mGFkhqtwRZxcqPBGl5+QMl?=
 =?us-ascii?Q?G+HAiC9nJQQHoKi8uX8VZgPKk7C9PbOShoc3A75AGWqMZqIk8Y21pbqhtfF4?=
 =?us-ascii?Q?Pf7NhL236hBrlO4yPPQH11UPOZlQUu01lokpg5K2CmdJ/P9xuTHxcEEPqAYS?=
 =?us-ascii?Q?uQu30PamoEC3lILMfuMUNXIYITlXdMIROy0lHYtPWr+pZfozxlsO2HRoiF16?=
 =?us-ascii?Q?T/TLi0UsaSXk4/k4JwmR7Fk86lSoQK6CWyXwEQ/iNnzaBvmXDkN+kcFpNkMu?=
 =?us-ascii?Q?KYyKfnmymOurDCJckKo6QxQ70mGR2/5GDZY3qucej3a9EnqsWa8/aDxDuAaI?=
 =?us-ascii?Q?sEgu16Qj6XPKGRCrDHHmciuIzliUHTXlKdkG/zF2xlcoXVEaSwXF37FaPx3n?=
 =?us-ascii?Q?fh9Bt0jDIVeSKsrs95y+Y+lMkYxmKTPb1rzhe2JlxkJp1TWP7hxOWQnOHPjC?=
 =?us-ascii?Q?kebRLfbPrDZkF7i44ZLDRCOPIqpI3GXsNVJMRUDlSdYI4fDrnXpuRQCTMwDV?=
 =?us-ascii?Q?TMjlEOZ5rDgoi3Y+JR+MGMtyzDHWdZfKaufxlMnN2aXVAYP7vKL83uDRF8aW?=
 =?us-ascii?Q?bEIyOy/ZAqWVM2odgN6H2MKGGnC9+3K3XaBM3tGDXtxALytN9999Vsuf5MTw?=
 =?us-ascii?Q?OgFUYU9BDqGnfUvB0n8hDRITCEPeJ3nP+JveDDJ14AAX3xzJ7FvkngCvqoUX?=
 =?us-ascii?Q?Me9lmYZuBSfz7D5dDF6J0J+VjNLb9v+/FCXkxzouz/+wGq4ZEwFaTN13+wBg?=
 =?us-ascii?Q?L4DNTAVdM2QCpCifcUZOt5uK6MvOfHflO1OjIp9M7N90uU/BcY3tcXvsxx8I?=
 =?us-ascii?Q?iczxX3q3vUUxelCggpbtXAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A334F21ED628E546B585CAEF4F99DDFD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7pxgqdhbxXGnwISvWYiJKjKKCCzs+3XHAYzfua3hcOTjupldJZH+Eu6TxQewFK4fhyRhKQpr1aZVWBaZaPswI9gRrAFVYKPXWAiYSmXW1H1Z2VX14NKglGkQc7RgmTjAt0Xm9gokBYEMqLx5ksby9B0TLSeYSghTVVlTevV3X6B3wXcJgXlacMlfN/7iHV0sSe6j6g93YzliN744PXTmfr8dF0jXb8C5Lp5PitY8basCko3GNT+EMLgwVG01cP8wLu/70QxFmuzSF8iKILunyMtFvYcKfpE8X1aOry7zOAxuVSyo5aNCSJ44IcN7OvH1IKgn6UulvrDr/T+IqH7MQyfg3WmVV4sEUv/rmFu3TdbmlwkEh9dymchJQKz7rd/x52mVzNanvQ1ow1HaipxziEKV+1uV2H/99tOQtYDIjBsklM6EUC26SciApHFa5tNxbCJoXDa4JMGSxD+WIpuRcFPKYqNnj8ENsBZpgBduJvMkGaPPWs1FCxHXvz1lhT6sOEeuMgeqhbJRYfG1j1OYbFT8ONSIVi/Sd7qXA33t+e0vyYxkqOjcZByLcF3MJIzScLewUN17kBEJ30vjfb9N8xj+imi+aI0tphPiEvCX7pNv317lAluKlcUrmzKFZD2k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e979f9-ca6f-4111-81b0-08dc582fe526
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 00:56:31.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D03CxyP2NPjFELLoBoVh8r9eBRCWLKKiYOJTax9sng8iKJFgycclyuut2jn0sTEnRgWiWlDOSkXVXp9BNFOBA+se07w9UtdNdG0kjAyv6j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7531

On Apr 07, 2024 / 20:57, Ming Lei wrote:
> Recently it is observed that list corruption is triggered when running
> scsi disk rebind in case of blk-cgroup.
>=20
> Add one such test case for covering this unusual operation.
>=20
> Cc: Changhui Zhong <czhong@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks for the patch. Overall it looks good to me. I confirmed that this te=
st
case causes the system hang with v6.9-rc2 kernel and your fix patch [1] avo=
ids
it.

[1] https://lore.kernel.org/linux-block/20240407125910.4053377-1-ming.lei@r=
edhat.com/

As I commented in line, I will do an edit when I apply this patch. No need =
to
respin this patch unless someone makes other comments.

Before I apply this patch, I will wait until the kernel side fix gets
upstreamed and then downstreamed to the stable kernels, so that blktests us=
ers
won't be upset with the hang. Until then, I expect other new test cases wil=
l get
the test case number block/035. In that case, I will modify this test case
number to block/036 or 037.

> ---
>  tests/block/035     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/035.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/block/035
>  create mode 100644 tests/block/035.out
>=20
> diff --git a/tests/block/035 b/tests/block/035
> new file mode 100755
> index 0000000..a1057a3
> --- /dev/null
> +++ b/tests/block/035
> @@ -0,0 +1,54 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ming Lei
> +#
> +# blk-cgroup is usually initialized in disk allocation code, and
> +# de-initialized in disk release code. And scsi disk rebind needs
> +# to re-allocate/re-add disk, meantime request queue is kept as
> +# live during the whole cycle.
> +#
> +# Add this test for covering blk-cgroup & disk rebind.
> +
> +. tests/block/rc
> +. common/scsi_debug
> +. common/cgroup
> +
> +DESCRIPTION=3D"test cgroup vs. scsi_debug rebind"
> +QUICK=3D1
> +
> +requires() {
> +	_have_cgroup2_controller io
> +	_have_scsi_debug
> +	_have_fio

Nit: this check for fio is not needed. I will remove it when I merge this p=
atch.=
