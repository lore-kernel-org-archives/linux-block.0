Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD4111A8
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558733; cv=fail; b=kIy4mTl7njxJzKlTmAFtXJ0/KALIsfTr6wxjQqFbyQTZCJ7jIsVCuZt/gDVJvmkrFYLCAdH2AE2+taR/DD74MU7gsjgmTYxG9GT+czwkYBfzIYrjxEvOAGj71fYqTLpELMeMrr/y5izYmmOKfW+TtyIIYzr4p67CLS0Ak/k3yKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558733; c=relaxed/simple;
	bh=vWD7askQePqNRKBQveeA8p259UBLj7Iyr56G9vmcNzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lhfwMiz8nrsazBn+L9OYhpL9oU3DC+/HQ4UMw3mZ4T5/wdajzhhDfzcgRYcBZzA/jsl2imaX1ec7naGWIXBRhrecSunVYUiu4jixkVe5bQaEQk3d5L8NSh3qjdTPbTOIzWk50a0kEA4ngvd3RbO/6odJRLEJS60V4vYs5VNb/Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ng4VItnq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cusUQaIX; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ng4VItnq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cusUQaIX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712558731; x=1744094731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vWD7askQePqNRKBQveeA8p259UBLj7Iyr56G9vmcNzM=;
  b=Ng4VItnqAb9Jfp8kHxsJj+AsQ3MnCNk23vZ0bnCWyMVMPG74JyA3/kQ3
   bD2RwKwn0CZ+8Icbd9zuSTcnZpYMIWWqQQ5xcNb2QLt6N8xQl8ks5PJNA
   AvpM3VlIh5eaUuPBOAfdofGaM7We+qk3OHOC08gm1zmK7GMRkg4GJ0rE3
   5IejQUb3c51DMr51MxK3c3YUJfCpC+DQpeGoo2mXD3c4VjVydlTIpgFuZ
   FvTR7mGbh48AKQve7GW9QcenYVDMbH19g5QhAjNtL5SnlF0WxKJZ0BOt4
   nAyoNihi70d+Y35OoKuRqE3/l9IcqHouZSlqN7pSsn7etrMixOzIjdV8v
   g==;
X-CSE-ConnectionGUID: J6X1f55OTbCh5oUzpzc1kQ==
X-CSE-MsgGUID: vNiQaNGxQiqkkQmPMznHiA==
X-IronPort-AV: E=Sophos;i="6.07,186,1708358400"; 
   d="scan'208";a="13308788"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2024 14:45:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOJL5LK+n85Ypl3FHEtIMeOFhSioSdeuzNHvyB1l712uJ9AW+S2Ihxrl6uF3XX4GrJbNZ/i+71LkusPZq7bkqNdtMj2qonjIE0Z7kPfuErwPX9XJ6k+B3uyP7JeQjHgvfrXGXzdIyNWp1saGie0MKNkPrw7MIAYNSVaMS8IpICtywBZU4BS+BudZP480qdm/CfghL0I/xv9aUuQMaOa5hRCXvZTrSEyyZnK0IUbDeXNM3p2vjTSpOU3sS/rxnSEfu/oylh951KkK9dhXwbPt3sqNhBWOaHMhnWf3OuNwAncCE4SwHR4KT64+swrTyKGOW79OwbxwOJmg2DT7hdCoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZVbQZmBFBgiIvPxb9sxO+lvqk6WRqdJNS0iU69hMN0=;
 b=OzGLj1v5RnCAhlXw57vgKLdhYPagAOBa+rSYnryjAcFvU3ixzCpdMFouBy1PVznTz3BRNb6HFsQBVQtuw8nOagWWeDnnc/0tCRegsvazCwp07NywnOt0QV8xEt+ZeCdfjNxK/BEtUl0+IBoDtEtYs+IFM7dsOq392LwnYUi68KSTRYAbm42hfbexzF4OPjdIwhDKIJ9zJ8Z89ac5B1v84y0i458BRFPtReeZADdB0u1+pqHzC4ZICML8elyheKGQJ/7c30Ma5qIqbbBf8mWyDG3OtoQhsclks1xXOAC9FJaSOyMlYNZJFH/hXhKk+69b4ktjg1AShCQ5fk2WcI/QrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZVbQZmBFBgiIvPxb9sxO+lvqk6WRqdJNS0iU69hMN0=;
 b=cusUQaIXh79xiqg3WG7X+VVsbSL07WGKoTyq+kFZLTdhg52m9UIiHQ1bP1+XCOFGsfCgawyLgMxcOuqx4cUEZOtNSlGeD6xn6O8uxvaEduRZjrb6j5R4qUSmw9EETi3rO5WUTRqgkh9qbNUHy1riFp0IwlR++aSz93RE4ff/XdU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7585.namprd04.prod.outlook.com (2603:10b6:303:b3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 8 Apr 2024 06:45:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 06:45:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "hch@lst.de"
	<hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Topic: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Index: AQHahvyWiheVndYbAU2CjNmML0/vjLFZTnqAgAFeVoCAA0XkgA==
Date: Mon, 8 Apr 2024 06:45:28 +0000
Message-ID: <pbhs6izmwy5sfn3u7ldd6egwi3m4xadmvdgjh2qzy3houvwzyt@v2auexg4hkke>
References: <2ac46686-5fec-42c7-b267-128cedcc73eb@nvidia.com>
 <20240406044631.2474947-1-saranyamohan@google.com>
In-Reply-To: <20240406044631.2474947-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7585:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EMvQUlhl5oy19dWuJuV0VYYtDy0Hk1+k91zv6p/ksqZy4uSHOdw/GbuxAtDL+pB4i55tLjbgvDxX6DJiNDycLrhdgvXDKHJhf+J2HbwXQ/NqTNLBeAUmf4TfmIijzyhgajZks1TzrK6TuEMM4m0pNosl8zyK7nzJ+ERlWPfK0h9L2D6jqGT+atxf7ypb4VrK86O+whUgQniRdKUlwJ9Wh4VgXcZmGnxlYWAn769BrgGOxEUpIDgK7D0byx3v96pulwEUGIsfnqP3tjMhsUN0hRrI7dg3gNRopNv4Hf3SrENNZKB/CY6d8qYXGpsFcWRUYOeDFQaDkEheEyunQZR6rSjay9Yui3HwLPC0Eapzy89U9GOFoVEy8pCI/O4iY1fuiLnbti3B0ABBUrVCEv2QExoBJ3VJjOfRuXxxJek2TxfDtEYjudMwIohUXhN+UXIK7sCNNa4GfE0YqmJe3w2eZ5/+08rwLG7lIv6JAmvgoobxk5SqnDOREimZHiWGJKjEOo2NgA4m8MtnrCTcpR0DLi9proRXohIzFnbvX1PqFJjd429jsD5nhPeS7DU6e7XxA2RBzbNfw5ioplx0FD/nsoKqYZBKq5R2J5/ppYZGVUM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bwam1OL0TJzu6KBVin9aHSJWJ10UrNc6C99UjUViSEGNQ28zgXS5KnZ6+k9x?=
 =?us-ascii?Q?m/YpWeaoUhxaRA/j5d6uug0rdndzwYn0T3KNc4U+Y0CtGlQ0M9ewDUZ6+oPj?=
 =?us-ascii?Q?MER2cWGaaBRYhX4P30QQ6AkuzCfAGryJQ1ar5c4IMBeawlwogbdmZOdRmuj8?=
 =?us-ascii?Q?KSC1KJ4mEjbunDTZL1NEtouplxbP8Wf459Xk+y4gJgbS8HRLAs0c/sDdRfi7?=
 =?us-ascii?Q?u22F3beKkBuDQbuhGGcQO6HhWsqK2QX3WTxYHKbYq05d5fbTvkTsgCUUIEc2?=
 =?us-ascii?Q?C9cKyNep+IrOsx1tV7C0WPQf6/m9ypT4fwaSgdjMisq7K4EFHGeY5NL/WPKt?=
 =?us-ascii?Q?5g/4wzN3hw5em7hBXRp79G/5OsUyHxLEcc6olHT7HhWAOrNcNfVin1jpOuze?=
 =?us-ascii?Q?gJP9m+j9zQ29vebXieRa4tZb/shNvAAEYGVSVM44M1Qb7WdQTcvG+aeOUYty?=
 =?us-ascii?Q?wvfd+uhUkHyuJgORXfP/F2DeUtQq/ZDCWB8RoRY2sz6YLgMkzv1HFMEwJO4F?=
 =?us-ascii?Q?J/SoQgKOs8cYL2ohL54qmnbSwKYKhdccg6KipMBZpPIZ6ixluC1R8DhxlaAK?=
 =?us-ascii?Q?uEByLdR979rj7YZquWM7CW/N5tDUApr9SDDJzw6ClLsuUAozGgB7DfCGszGU?=
 =?us-ascii?Q?5OOjP68fY8iDIiUUsFADRQVena+VwnhVpyRdrCxH+gCZotdAmCQxf2XtJObg?=
 =?us-ascii?Q?eEQMpKJYeMbk0/6t5NTufVBtis3KVQjxiAiS5H1fliHZLfcuUX72Xf3uPctv?=
 =?us-ascii?Q?BkRBYEHtgvkJqpFffFyFpBx6es0ye6VLYlSBYg5xvBiU2J8LmeBsBsryxxcQ?=
 =?us-ascii?Q?22+kCxQI0cP+EyfCUKee/JWfXk9DetpdwisdxurtgxSWQ8SskmsGb+u69QsP?=
 =?us-ascii?Q?0T+Wl21YlLi4kOHqqJYy6zCN1cKeNu5BW1ADk793x5QDDjDm06rfa6y1T4Xs?=
 =?us-ascii?Q?ViMsB/dNomUQxOgWM+juVzoddYlfWB+5TnOoZBtD6czaaZykWOrjpuqvoJ+J?=
 =?us-ascii?Q?jVM58gHSVy/rA0yeOTutuRXg+5sHLBYAhwy95T20BjXz6bgEVgPE3q/BStnM?=
 =?us-ascii?Q?9e7Y0Sr43c5cjrkqXRpwxDiZPpFyB/2fBwl8moK4hXlRfOA7OxPrLcOfDiee?=
 =?us-ascii?Q?KmGyAFdF+uTZi9nQKMoOKrhP08OzApZpmWnPb2soC1RR6z3E8uqYI7uP0Umg?=
 =?us-ascii?Q?IHRj//OY39rGWaOtVn6A5hThX47IzHr+nLoEfwq6U9IdUFfpQN87cBFjDzPl?=
 =?us-ascii?Q?Bl0A/BBgVqdeqkYksFIzQCFZth8bbc0MSfo9XW2EXLgBOa1RwbW7CwfS+gkU?=
 =?us-ascii?Q?+Dneccj/2FQkl0Viq/ytvf0HVypUofPXoOwTj0Hped7mjfMcbiOxZFe+wObG?=
 =?us-ascii?Q?+CofGVt71KlpaMbpDgd37CSX2yLhdDqfKky2M7WDSQvipSnwJk+glaQJ58rl?=
 =?us-ascii?Q?EPTgt92lifBExZITiQK1MXtrhd4vV5a0p3aW3Q9kLSwOfufr4PL9xjo+mZjw?=
 =?us-ascii?Q?LEdqbNrDz9g9Z+mSBdBz0WgZg+S0OmbksKCw/9FI20IKb2SvEc0Dx/70AvMx?=
 =?us-ascii?Q?UKazIwalZUNxvXCoGnpk0F/PBCci21pyqFIkSCs6rmZiwhYtKf1LRszCHqU5?=
 =?us-ascii?Q?7q1NqvrDwnsVfaqzssZzZ5w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1C8D858B4478E4BBDDF37B48F5DF064@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1H9bhtjKdGlvGwDomPRd5B7YIx/3x5P3AlZ9ulTxxsmJN6vQWquSB1rvymPJ6PzyIoL1vG++Z0jLuMAfh/BtSOQXSTLw9dCnKeI6Vgm30FyFBN7slsJsotaY+W7vKTis/8YFuLtvKDso56LSacXKRb08MGuBlCkNgDrk2lle04PgJmcXOHZCbHPEMMbhx3NVyASQwqq4oS9L3WmW8Ag7nuLMb/JoSkYm5OIkyVLSxcNahylzyZQ9fE47tacxxE8LraBMHt1/n9Apeia4G4GS04SIRKb7l78TrIY+Fen0Jn3EaMXnu9J3isYnPjo02t9is4ybeUsp/CmhhGAYzCiDpOQNV3BdIPFbgy4eh9tPIqjRPJ+Vpl+GJmizHoXrUm8PhwZcjKyYKK4V/smeNO6ok+8xRSTigitiA2Kg9psh8oSyPLWp58nYDeYQWoeAxZy6Va782O7eV+gbjHIkpAImO5KbGmZBSJ9bew1TKlrn7in8yk5oRxfK3DM+rp70bQ21AVtRYLLoCkc44n2nhQHe5t+4GcmWDW7tmid8832wvVCNF25jFri6azB8Sva0+C7tEGqym2CaqhuAhl4vShNm6JPLnCAtILkMuLm3/d6xAoUfj3OdMjvO36QuwWk13wkd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46e02f9-db96-4e20-0364-08dc57977a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:45:28.1062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxmBsHbcxJZrMMWPbwRRxlhjLO+IvHld2gsQwNGG4m0sMvxBlItU1+etKgDccV6SLQaO8LE3OHEIKajySEiLKQyzOdjyob3iipZdqbJ5L2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7585

On Apr 06, 2024 / 04:46, Saranya Muruganandam wrote:
> When we fail to reread the partition superblock from the disk, due to
> bad sector or bad disk etc, BLKRRPART should fail with EIO.
> Simulate failure for the entire block device and run
> "blockdev --rereadpt" and expect it to fail and return EIO instead of
> pass.
>=20
> Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@go=
ogle.com/
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

Hello Saranya, thank you for the patch.

I ran the test case with the kernel version v6.9-rc2, and observed the test
case passes. This is unexpected. My expectation is that the test case fails=
 and
reports that the BLKRRPART does not fail with EIO. If I misunderstanding
anything, please let me know. I made comments about this in line based on m=
y
understanding.

I saw the number of shellcheck warnings has got reduced (thanks!). Still I =
see
a few warnings and commented on them in line.

Also I made some nit comments, which I don't care much. If they are reasona=
ble,
please reflect to v3.

> ---
>  tests/block/035     | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/035.out |  3 ++
>  2 files changed, 96 insertions(+)
>  create mode 100755 tests/block/035
>  create mode 100644 tests/block/035.out
>=20
> diff --git a/tests/block/035 b/tests/block/035
> new file mode 100755
> index 0000000..67896ea
> --- /dev/null
> +++ b/tests/block/035
> @@ -0,0 +1,93 @@
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

Nit: I would put a blank line here, since the global variables above are
configurations passed to blktests framework, and the global variable below
is a definition for this test case.

> +DEBUGFS_MNT=3D"/sys/kernel/debug/fail_make_request"
> +
> +PROBABILITY=3D0
> +TIMES=3D0
> +VERBOSE=3D0
> +MAKE_FAIL=3D0
> +
> +_have_debugfs() {
> +

Nit: Useless blank line?

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
> +	MAKE_FAIL=3D$(cat /sys/block/$(basename "${TEST_DEV}")/make-it-fail)

Blktests provides "${TEST_DEV_SYSFS}" which can be used in place of
"/sys/block/$(basename "${TEST_DEV}")".

        MAKE_FAIL=3D$(cat "${TEST_DEV_SYSFS}"/make-it-fail)

It will avoid the shellcheck warn SC2046 for $(basename ...).

> +

Nit: Useless blank line?

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
> +	echo 1 > /sys/block/$(basename "${TEST_DEV}")/make-it-fail

Same comment as above for TEST_DEV_SYSFS.

> +

Nit: Useless blank line?

> +}
> +
> +restore_fail_make_request()
> +{
> +	echo "${MAKE_FAIL}" > /sys/block/$(basename "${TEST_DEV}")/make-it-fail

Same comment as above for TEST_DEV_SYSFS.

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
> +	local out=3D$(blockdev --rereadpt "${TEST_DEV}" 2>&1)

On the kernel v6.9-rc2, the blockdev command above succeeds. I think this i=
s
unexpected, and test case should fail in that case, like,

     if blockdev --rereadpt "${TEST_DEV}" &> "$FULL"; then
          echo "blockdev --rereadpt command succeeded"
     fi

Also, to avoid the shellcheck warn about the local variable "out", let's no=
t use
it. The content of the variable is written to $FULL anyway.

> +	if [[ $(echo "${out}" | grep -q "Input/output error") -eq 0 ]]; then
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This line looks wrong to me. $(command) runs the command and handles its ou=
tput
as a variable. "grep -q" writes nothing to output, then the marked part in =
the
line is always an empty variable. [[ X -eq Y ]] evaluates the empty variabl=
e as
0, then the condition check above is always true.

I guess you wanted to check that the exit status of "grep -q" is 0 or not. =
It
can be checked as follows:

       if grep -q "Input/output error" "$FULL"; then

If you keep the "$out" variable, it will be as follows:

       if grep -q "Input/output error" <<< "$out"; then

> +		echo "Return EIO for BLKRRPART on bad disk"
> +	else
> +		echo "Did not return EIO for BLKRRPART on bad disk"
> +	fi
> +
> +	echo "${out}" >> "$FULL"
> +
> +	# Restore TEST_DEV device to original state
> +	restore_fail_make_request
> +
> +	echo "Test complete"
> +}
> +

Nit: this blank line is not needed, and the git apply command warns about i=
t.

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
