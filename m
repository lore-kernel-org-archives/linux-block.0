Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897E332606
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174892; cv=fail; b=Tpde0OLpYVGB3AE8aXXekABYD5zsFrh1bNOkBQQZPCWJ5nhVhy49RhXTlKnwXVdV0U88qfq23nkHDh6h2e1Vd0x0K02+HHrh/xVdrLDsq6A57MwjljRCJIE2i0UOJvD04Jla6/N8UOXRd0uveDTx1e3o/dvTvAoZ7HGGgsAbjR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174892; c=relaxed/simple;
	bh=zELI9SlV83IdEwwEv6PZqYFF2TnqcKTJtbdTGXgu2hM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F937/N7PQtqJjidO+ZiIUOdJBW31qhJbitvYeVwqcQkh2puEGIwNn336sesmkdWnojysGyraFnlnWTZRaSiXCzJquDpFH9GmecLE9/xFqFDw7MnH/XzD/gkVe2Tsoxt1zEQmszVMHmMHBd5C74i+R+3lrJn59qHD9DSHw0WWCLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j6UMF6gh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TjZdDmlZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j6UMF6gh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TjZdDmlZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772174891; x=1803710891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zELI9SlV83IdEwwEv6PZqYFF2TnqcKTJtbdTGXgu2hM=;
  b=j6UMF6ghWuCy/wwTX4bUByGMlco7LkbWRBMy8NrmKA+YgNeG/fuHC4Mx
   5IMQZCU+CukSIzouYaCQvioYpwii7pcdwVSdabClqai61PEYtOuVIXQL7
   au8DYCqWDWFQbO9LB6i3hq7uWnl4yUFrQRzBbnwgxDF+4PrDZTYNKwDDh
   22YwrhwnwzoJxd/YWAoSQSvAkJvFDZDs8aDVXCTGLNk0nqG+fBi8gvSed
   roMJGiw7G01X/IboorKIRsfHQXgJkgp1iGDHWxbPyXRHKwvelU76g+Hai
   6r5ZfeMBvf2ikbxnIHK6qecujH0OZzeZ43V5Tzi1XVfHJH7t7BQPlBzPO
   g==;
X-CSE-ConnectionGUID: 00FMu6BLQoyG4i3ZTWq08Q==
X-CSE-MsgGUID: sy6xIAP+Q0CcrlM6GoUJlA==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="142124215"
Received: from mail-southcentralusazon11012006.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 14:48:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+RLERTWN7AL+ARSNyN+X1fISXdtg6iBIAvX86VkIL4TLWaMw3mNCNU0ovMv488WcPbkjN9XYsBogeMV3D4Pbz6U4A6AGZjg8H0lgMUMZt+yetqSP0eLjUBBbnJR2MnYF/9qydOk5yZ6ogVI1r9i5VjLksb/v8C4mAAF02s0UfryO4WiSu0HFepHXPxxRv4Xj81deKmaDeLM2YqoRlZc/Cc0uDsRori7jP+ocuruttDw8UtyffaleBmRUdmy+Ndxp7o7hnnwbsMiG3fX+qm8gNROMKWMni1Eqhv/5c6jmegaVzzZI79JIQvLwtX7fEB+/rLAwCV7j52vpW4LGw7IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zELI9SlV83IdEwwEv6PZqYFF2TnqcKTJtbdTGXgu2hM=;
 b=g6pLpsSDBDJ9i0qkmwGbxv1NzZtA+B0m4cItVf4IAtgW1g+/4m4SmwqhfxS39Ha1BltoXBMQeizPl0m28OgEzVPkhwCpGTMk1EVBw2V1OCR79x3ywC0aNLmvn0CMYQbIyaSJF6E9WkRssj21zKLZ0GG/9JXC+DiujWno3vBPSHOJCa4JR3P8T8sdgo8X6tWsOMer9f62C39QzdqZz926N+cS3PGN5+HJzTEPuvD+R+/7PcAV2WNNps6TZOSTbT1UfTRZGheyugNVM6Pc6qyPd9RQgP0CxKwIwGYlyOpR5pTYxyrke9WQxcdirY93TYtygZu205zBuRQ8JALdhRmJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zELI9SlV83IdEwwEv6PZqYFF2TnqcKTJtbdTGXgu2hM=;
 b=TjZdDmlZl9Czt3uuWWGg62X1A3wNXUMAe5U2gpVKBtlQge3G8i9DpNiaZaSFUeYdXUviTgqWmFaqFGyttRsBj2V5LmzCBSWaUbYybD4ZI7kTX7C81p3zz4LtWe4I+o+kqaZN1jdnw3kliRZrhgPfZa0TtDq5hEw8pKkAUYiUCg4=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA3PR04MB9109.namprd04.prod.outlook.com (2603:10b6:208:51e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 06:48:03 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9632.015; Fri, 27 Feb 2026
 06:48:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>
Subject: Re: [PATCH blktests v2 0/2] zbd: adjust to recent blkzone change
Thread-Topic: [PATCH blktests v2 0/2] zbd: adjust to recent blkzone change
Thread-Index: AQHcomwrgnibqxl6T0SDcBfnaRzmsbWWJS2A
Date: Fri, 27 Feb 2026 06:48:00 +0000
Message-ID: <aaE9xHGzie-Pim6y@shinmob>
References: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA3PR04MB9109:EE_
x-ms-office365-filtering-correlation-id: 64392bd4-5d0f-4edd-2675-08de75cc26a2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 ScPFiP+phMYkJs9zx9MzT1inDDoECBhI0ta5WKOAYjHhAjMY86qsAnoyp7bVDoga5ashgA95txwOaLdYOOkvPc5rXiEG318pFg2qQoJ+Yf3VvO/G8JGZubfeDtIGJEySNg1WFxw1dC1yOyCWuULIE9XkxsDOE5t1Uf13sOYKoC0oGQXVKlgoBwLr2rNfSXhIsMzCkBYkJR1Zdg2qSGVMEFKc5YvKDcYV+JKxQZcQ13U/Up7eJtJjg2wCakHhpOFn8iaxXbbKBRx9JyvDDuKat7UnGKeifePtcY4srNAE/u3q+sJHrSgJKqGhnKPdyHUngpXO4AgPZ61Yi0RmTaqDploU5QJfhfAlhcdW24YVmRRRl1j/EEUk5jIbCaMrP/55vRyXOw7JnOTsUwNCsq1SRgTkgRD4UpPL69skh0HyGicFKsRUb/XNLnklWmO3pPQGXXAS4zfS0gWeYUk8Whifrye2LT9FdJYKcjwiTMOWXD4H1RPQzMxpBtf7XVB+HkIDkHAf8Qh3q7vwMV7D4NXGqZHzxQdamtgADvaoEJA+ZWGlxG5ZPU8oWHHVN0q6o9tzTtsthIGnOLT/vTA/0tm8/EPsd34UM4kBnrQmi2xWldN3xAQ9S/elO/UvUkhVMxj/vErrWhU13JzzPiJhmtI3t8Aioe52dGrudEqpN1T2wOYUfDbxotqSFjR2v567+Og9zOplR5oRKO+A0Me/eOpzgGBmfKhzboJElLwIF37NC9RH8o1qJhVLlKL6WYjzYCLJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j07TsB9S7AMsB4lerwLSTINrCMArN9Ju78Is1zHi6nF+ZcfZz2dBHvES5FBP?=
 =?us-ascii?Q?1A8SnxnKY6Bx44JpUQfZ/l7bBTyMHorpxvkHJG20puES5dK2x/9Cpq8CpyqS?=
 =?us-ascii?Q?Waq3jduS4AKTEIQ2GqiUMOk9c1G8LiSWST4KFIDwht+ANokZTGmhOZ1W5Aze?=
 =?us-ascii?Q?WkeLv1cKc7xZVBX7qhOGFMdaXAt4J2UcSHsq707Y+5e0sFkP9/71O2qpZiLu?=
 =?us-ascii?Q?ldM8H8Sc6roYBV53OV379D9/rpiPUYPMO7vAu9Mi1f9JcgChp13hUbskSBmk?=
 =?us-ascii?Q?pYNl9+djmkCpGugDDh3xV0SKS2PGk3YesiGeJjemPrDHvgO9WE/j7kGpRuDb?=
 =?us-ascii?Q?Zn8pdxrorRIysuf5cwce8eYYbLzsCTfRbAo+8gRO1WT4d/VIDQzy7npBOY0c?=
 =?us-ascii?Q?/LGoqf7rtkaubydqXSSgEMORclU6nXKQqscpd6wcyK9x+eF2OGmVGaGUPniT?=
 =?us-ascii?Q?AX4dwzhClyNb43xob2uNaAw7dOP6cUIrjBYI1G5CMFHYOJ7RHELBqOSFP3jU?=
 =?us-ascii?Q?gYdq3YNEDN579vCLzaWGtKoUuS4SJUX/tc2ae9S+gD9pz+eRR9vo+Qjgk67Z?=
 =?us-ascii?Q?K29KL6HeRVRLGvn1yzELsftNDP7sxE1UJXMOtRmkLRY5jo6tyLdNxBd2F6F6?=
 =?us-ascii?Q?4bpqDUKjwi3nhPwIbShIYTb15kDsTqLfYhf25Fm7iKdu6lG0Aw1WApUqogsa?=
 =?us-ascii?Q?ZLhArndR4D/wzjg0x7YIAYyoitXKBxKVRgRokg4R/QWGuuiEXU0mfaydXL0R?=
 =?us-ascii?Q?yLIC+YmZPGGKSJKhcVRiqdsQ+Kq5WQRYU3Y18NMzyvykJRfEiQybj4gFaawo?=
 =?us-ascii?Q?FfN5Lov2pE6n+sV2ez+FeMOjNqT8TPdXlEfafb7DJCc3zlAc1dOIOkxDZU3b?=
 =?us-ascii?Q?Yj09jhPfE1RtkHNVMpdl2/Kui43j6pH+01DbZ5+jGJ8BduloPvVne2jBMBN+?=
 =?us-ascii?Q?rCb3i+prnnMwPSEduLDo4lU32DNwF5WsYEEn1/9Z8dxsgNc6obRYiQziljlj?=
 =?us-ascii?Q?/LBLAqQkq2eYRL3UZ/APCbzQ3dsjqBliBJuCjyoLvblsGLeU/XDbsm/Fu7Xe?=
 =?us-ascii?Q?JrLvlN/huJ705ZF5VqeUAhpukr4B1Xu4FDppIEMBte0bfyn+0LG1oNs22Zbg?=
 =?us-ascii?Q?aOv3825XHRBabm1QBQSCLdYae2LjCDnFtb+MtfVNgn4SoJiflte+Qy33KN+7?=
 =?us-ascii?Q?HNVP8upvZIocopt9IvaNPsZFtZEeOkxLBvrjhvq5QjFbYa7JEe0wTj+d82Sa?=
 =?us-ascii?Q?CdqzjUhV0v1z9dkaxivSo/hxCSPOFbuQ1YY5vaCAEKnvfodrMC2mU8ktZWOb?=
 =?us-ascii?Q?r2ZBhSkJrCkFKl/viIyfaOLkOIHzPxX5pT+1lIILJgUhurTkP+9ojZX+zmyE?=
 =?us-ascii?Q?aXyAZxGcXbPLYRM4zJunVyhR/l64WAA8/I0WeU8bKWGrqyej8cuGYl1TjbdM?=
 =?us-ascii?Q?uK5FI1y0bws8d2ikeAo7s3063rLuelAIUty3ySgr3x5zSocZYRzWHpq0D2Vp?=
 =?us-ascii?Q?cHzYSi4P+bxfort9XHW4D8VbFJ4ukEzNFZWoN81k2yH+8PhkXZHu53nc1vCB?=
 =?us-ascii?Q?5FEO1qJRq7Jdb8R1Rt0g4etCDO4F+I8u6zpjDHAkPWP4QPVFssL/+suRRhye?=
 =?us-ascii?Q?3T1telN1I7DiBOEEaGFMkufwQvOFktgNvi/3vJ0OUFjQ7YB6lEnkaNAjMwmx?=
 =?us-ascii?Q?Gf9eIU2B8Zhwvb95FhrBCemkA+/mXc+hmsb3lu1yXyWpZrfM7mdbYn7yipV2?=
 =?us-ascii?Q?dyiMbLH1oAag4Zjpz6UE3eJdU6OG/fU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8309918AAB433A49BC1D5ECDABAF70DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U2SbIeR8WWiS++gsnl8wWpqsEh9yrOFn0Lim3B0zyUJZVH/IFvP7Txtft3eMXblvlaWFBcEvIgqW5cVyfKf+EiSBEZI75MuatfK/U4XtWuVFu2aP2EX5ZbtFl5v3SCpcFrIyR8uw67NHu44ZIXmNAccpxakS8oNe+huGCW7GWjk/FbuEozxz5515BMkXq0cMsjJg1925M/DORoQY4z8+t0m/fxxO0mWDkB0fDIDwV17SeBoIcfAFbJwTa7celx4/aOEjmRDSgi/ryiytvlpEGY2AXeRpSmkgcuZgh3H5mUTXSh1GVPMp2QhdMTkVOThHRDp2TceLfy2h6yPw6Sv70hrC0sHxoTgk39DrFBTVvwdOds44wPW+lkflYW/vFymRYB9szY7mzhzUh023+NfpX9DhGc/Fsqd/54TXyK7JcPlXW9TvSBS5ESPZUfMUXFDz/US7aDCSczXMhQv36/w2+DS3qG0U5THCr1K12qbMiQS+0Zv0m8qDoEG+szV3tGPBfFiWH1LPXJwHO2aykw6Tvlr7JaOKXUbM8Xw3NnNQcjWxW6J3o+5IvzO5ky4u1Ff83EVRJNNJpSjFM+EankkvnSIEML6gGSayqTKneE+yuM70+hjPzCI3/d514ooD52Xp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64392bd4-5d0f-4edd-2675-08de75cc26a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 06:48:01.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIIXu8hw03KQ+CsTj5PCERYrZ/PlVE809DdHh2DyKXzpUvTmhEv/+nvw/cziRxNFhiWqD3d6m7sJ7EVSv5EJuPF8pTIolK5N5WhrNUTRc0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9109

On Feb 20, 2026 / 22:23, Shin'ichiro Kawasaki wrote:
> After the recent change in util-linux [1], 'blkzone report' command no
> longer reports numeric values for write pointers when the write pointers
> are invalid. This change caused two failure symptoms in the zbd test
> group. The first failure symptom is arithmetic failures by evaluating
> the string 'N/A' as a numeric value. The second failure symptom is
> write pointer validity check failure for conventional zones. The two
> patches in this series address the two failure symptoms respectively.
>=20
> Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a=
13bf8541eb663c779e448f568

FYI, I applied the patches. Of note is that I made a slight change to the
block comment in the first patch when I applied it.=
