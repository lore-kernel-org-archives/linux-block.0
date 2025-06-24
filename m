Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883582522B1
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749086; cv=fail; b=V+FjoyZ13+t70V/3TKTmDtEqRTT46oug0+Yn7PcESMVZdSBOcrCXeXdRGLaZ0Fv2iqQtFlgHgVGf1JwrgiGHNr4Wn0bHHaCzycWEx4Z8b3pWYHqpR3Xb362ADN9H0yT8ehezWofhYCrl6qrIKlj7PFsYElyL3MClhqjB3Lx5YJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749086; c=relaxed/simple;
	bh=aG4sRnZ6RMaercsicCYs9lvNyEWBzlBzncaOZPKyO88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GlS07hWrQcdIlQvE31LtkReq5Ghor+gdFUFXWEBKcBoLQo9i5MEZ3sZX9uKoPsheTIKV0MX0Rlwb8/BzB3xQj3P9cY21/9+Eq+duQ3dSdQ/mkeXtdW9QtWmtCKdFQYPhZ9uaD3aKlY12Zn4p7yuDTSAI4Gbwd2YmcMZEAnkU0/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kgsjz3Kg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xoXgR62E; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kgsjz3Kg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xoXgR62E"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750749084; x=1782285084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aG4sRnZ6RMaercsicCYs9lvNyEWBzlBzncaOZPKyO88=;
  b=Kgsjz3KgnXdUrikWQhkoSgtN33yGsBX5GTNQeoUADf7UfHocez8kXpss
   +0wYM7TTDjU0/RTEjF4Np1OQ00YevaxVMtBtySG4eTu/p0ELJHpWXE06f
   LnpOCvaN254whL+/xBNSdPsdF6+gwgStjgux6Xmqtf9mL3IH8Ret5PVRv
   +5czwOBIt291nCBviVogbC1B/aqhC+LM6wXQr05zllcTchxMBw7eGWNIr
   4ZUB13Z2vK/WYnoX9GgCSmFOzEXjzXT4jQA4h0qHvhHDUiwhaBZpHl7b7
   rW93SZKssyHyhNK31IyYIXVoTamlNOCHoYqQrFbXh0qzzYJBoc3C9yM9f
   g==;
X-CSE-ConnectionGUID: EPodMacDQXO2B5fLr9pOhg==
X-CSE-MsgGUID: tdVKcRZtTh2s1/8wjvcmHg==
X-IronPort-AV: E=Sophos;i="6.16,261,1744041600"; 
   d="scan'208";a="84608798"
Received: from mail-westusazon11012018.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.18])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2025 15:11:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAq53R6IFzyrnGXrHuO7gRsbC7aNSVaMx4KN2+Q6lRXArfpXDFgC/yyOhFIx/jHjIIeIUzpFGDWldsH72PhjadBFMTlxhyHLbaR7HgWvYoOC+q0BKIsR3VJwjkwUWyd90Nhian0O7qw0Zdow0rlS//+7M9Vq1TZaYvqKYaWEKa1DfXD2p1dgLnxdeky2V5+8h5TnSnr4M7mR67DxfNcHRWl+SuPb29jNo5uhFh3s5D+O/clLWgL3qSp4xsTLNtFAZ2fT6WAXt47uJ7lzIS+rc25hlo4vZ/BRR8ASLE+m4au7MHPCbTS1Joht8s+FTGPtwtZ/SiaaVLGPNEUQwMq5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG4sRnZ6RMaercsicCYs9lvNyEWBzlBzncaOZPKyO88=;
 b=mH8OuDFCOupVR/8UZw0CfFKPEtZzbel+hz5R5zz9NKkOZsjwiSqgk9cslbZtK7MgGEe5YqNvCigLKp+Fa6UmeGmyRe0mSyuaSR60Xs1WjgiR0UmW9ZUgCpoyF7uIXSFkOpvPyCebytRFk0kunBd/t6C3j/tIsW//UtkH5A0qBmM4a5WGkMdmjKOdKloh8jXKFV5GEd8+qWIi5cHuuw++T1LIarmmNO5M/YT9cTxdXgFL9z8M9CfQikfqMvyJMdXIRc/ri3wmakpE+EeYEX1wtmlsp/kovOx9EZE8s5nMDCJpiIAHwus2DIE2DMXa2W2Pjpplo5Rva0ny0Ad6GOrQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG4sRnZ6RMaercsicCYs9lvNyEWBzlBzncaOZPKyO88=;
 b=xoXgR62E6iYDW/KOoWPZhpuxj6YycsqYVhmh0X2H3rvpwFN8cbkl9IG6Toe50jSUDH+32CcISwT9nBIxYhOghLV3QiSkNKsF/fbftL8O6dL+0VxQ1h0LWOMyfFFZf/XBWdjBPqgTzdswndUUBSf4o0/iI9nkx9qWmOPAbYvpXTA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB8567.namprd04.prod.outlook.com (2603:10b6:a03:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 07:11:16 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 07:11:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests 0/2] nvme: add nvme metadata passthrough test
Thread-Topic: [PATCH blktests 0/2] nvme: add nvme metadata passthrough test
Thread-Index: AQHb3mNoBbX7lFUPTUSj2kZ9aB/OSLQR8ZAA
Date: Tue, 24 Jun 2025 07:11:15 +0000
Message-ID: <hyiefxhvm475gcfl6u3fou52yrokjynqvuteegnc4b6ijrqxbb@xsvmdg7bx2bg>
References: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB8567:EE_
x-ms-office365-filtering-correlation-id: 13cf9f24-56bc-4836-2bee-08ddb2ee4f3e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yWFhrDulIhcdMhre8D7ryHd+rNo3SBCiw7UMP99rk6iRBIMZxRPP+X5cbPz2?=
 =?us-ascii?Q?4XDsnHRoJE5EEYM+EDcAtqxMfUWFUM0vtq5fTc6ig+9IUoMVkUwqk2vDDqfk?=
 =?us-ascii?Q?u3aP5/nzz6LpxVyWSYqIpRQRRb1g00fQ+2QEx8Zl8JM4R+Fki4EU+fJ5AAXG?=
 =?us-ascii?Q?RgXmYUtieVYhh0N8E+VARSEGZx+V/Md9MuLyUC9T1ysjt4qvy7mt8atq0n+T?=
 =?us-ascii?Q?6X4EKeRqpsQ2E6Tz4/EgYKwtBRuKnyrqjCB32pop1LwLB2+OrIcCLoEx7jC4?=
 =?us-ascii?Q?+jG/YAQ842PTidlmSGFkUONPfrcmMPwj2f3Oex6nxLtlMVShXurOmVhw2wkr?=
 =?us-ascii?Q?+nKzKKFU7ev00qvPZIjpn3rbYgdLc4uqxIz4daP9Ykmt4f5CyamB6xyY2k29?=
 =?us-ascii?Q?gOGhyXaNPJH4g1ybnj4gk94FIAxaRrlLOe1I8uZpOgke5LeWmc4o7VFxuxRn?=
 =?us-ascii?Q?74IL3xPV3ANFOzxFitz+BjEj6+pQK20kqHnvN6EPf+ldLkl6pR0zIQR1TENE?=
 =?us-ascii?Q?H/p5OB7C3To1MAjGzflIch41EAfA6Nbt7kfnvdU3a8c17yO03Vp3m25PHjSm?=
 =?us-ascii?Q?dq4OoQpOE+sV4j7udI4n12y7CpBaLKfpM4DecJgHDWXHQKRF/9Jtv6juhMgB?=
 =?us-ascii?Q?g0j4XX3cKhf5cFrHnzPO9GcOOvEACia4abUzFPEEuxm1PrlsRYTcLL6oxRsk?=
 =?us-ascii?Q?xp/h68RbeNMV8V2AxFpiKEovaX/dHhp5hr69lbugAJsxmE/A4WpUseGKgWAm?=
 =?us-ascii?Q?9R4BOqTNoP5B2RMGMUNC81LrbkbkpSUp0R3cFHIKnEjODH65knjfyBkEldyw?=
 =?us-ascii?Q?ng+LgzuKsg/wy0hL0pGUDDfAB5Cai72+EElI+ChvmA7WLZkv0Lt/DOvNKsxi?=
 =?us-ascii?Q?SAOXh3gz5U5SHLQhzSP37GBFUJU8q34uxP6cKwfG3K6Kw5jn2wsDT1WZjq6q?=
 =?us-ascii?Q?3gv3rjF/X+Bvp4ndkO5hOBnOwkEYnOelZfwMii7iP1SqN6KORHuZrLSwMWWq?=
 =?us-ascii?Q?4R6qoyWNDMRjUjVDhbp2dRAfHO5ukv9YbB29Jw1lNT+jQlWveHA4oWzfjALg?=
 =?us-ascii?Q?eveTA3+DVST0Wta4i4zi4N1pLHtOBQxbMAmSZuoVybQMWrXqmVK6KXRo9BH6?=
 =?us-ascii?Q?q0LQDhPGB10f45bR4FYZOAjvqJ2mQ9aEWZz6Re7ymGaTLB5HcqPHlQAcYv2Z?=
 =?us-ascii?Q?iBd9J3EZWnRrN/sCGtdVBaFaQ1qUo6qDo7usvhZnKpwjrhaP/5D4veTazCA3?=
 =?us-ascii?Q?0L5mtYv3cVP9eN/zqIJ+Qk6B9HENyGEj0lvmYduD+Shj1YF95XuFzmP6VqAM?=
 =?us-ascii?Q?KsjS72uvXDn21LmlIBXG0/r8pXAfNuW6W6WPqjwN1IUbBs+r7dSD2DcWzIaW?=
 =?us-ascii?Q?DPnwySsq557c4wxz7oXONk72MzCs6lSZSzIFIYQ2xVtKT2oTgyB7/lsM63dU?=
 =?us-ascii?Q?DqjgoRXZPM1HCiu+0oVLOK0eq180P0+9ybq/msqxFmvlFTtWI+zIxmN7AxS2?=
 =?us-ascii?Q?QNo5dGgVo2oE0xY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B/TEnimRvDG3qcMwIpTEk9NBW5H1+sn/3IIHWHUHFxS1QebdUw7WZvTaoxU6?=
 =?us-ascii?Q?fhkUKIOUCgOxcIcms7DX3ri8FSZ7QZzmk3xeWsH2JJwMj9GTEbleVAmmHnj6?=
 =?us-ascii?Q?Xa5p2kqglFf3PdI3Uyo7X0fG/gkegEtrLcmpDL0i1Mnc5Eqi2BEnENE9YoMM?=
 =?us-ascii?Q?iWbiddXaI1f5umfMk68dgkJSdmRWDV6xu/q63mJruIj5EU/cJCT5EIpOTX57?=
 =?us-ascii?Q?ZptwgvLHvjCtygAAd3oTay9kj9VdjrS+M9AEaAwK3W7kW8PMoA2+Ew5TMHv7?=
 =?us-ascii?Q?tbSNi3Va73Unqfy/kcQPY6U7WOuYL173yD983RVU7spwxNMeEJ83BeoVllh6?=
 =?us-ascii?Q?1Ql1eXWMjL0PNBszVhvRckPkftajzRI8jpwjh+6CR5qbNpfRLRWTxchHX3+Z?=
 =?us-ascii?Q?yeKsTAQZ0fk9D4SJG4tVMbqhWNQ/2knffhCNT7C6VZ5ItIQvKjxN8SZ9TTFe?=
 =?us-ascii?Q?GDBPKcuIytxz68i0jpDODW/j4PvIVC8UNx0StB410oZ3iSSXvtIbDzuH2c+c?=
 =?us-ascii?Q?Ghli96Ga9wQh6SryIaI3x7hUMJs47zm/2Bk453/3RG8TKvrE3lFsrLZsBc/p?=
 =?us-ascii?Q?pjXRugFLxhXta2nLZKvVTlt0fUxWwdTomnMmaAPhoDeAGghDBPK4R+gCAQz7?=
 =?us-ascii?Q?Q8pfSs8/EyjHl+EaAsZYuPJn0kyFsn8QuSK7rrwWg8WDNeBPNd+hI9vN+3Ey?=
 =?us-ascii?Q?hDZrLgWU05kIO4JTGYN87hJxv1DkK9tTZv+X7Z5zUcbmIUYM/G6BpFVnsD18?=
 =?us-ascii?Q?jOVLfHdsY5mji/1f47d+Zblxe/Lg3TmfD9kLGzCQ+WRx1sKWlw1gym/H76Ht?=
 =?us-ascii?Q?UZFiiBu4lmbe3QSWvGvOgleG4nrsk8exjVRGANF3S4ao6/VmBNMjR0mrYyo4?=
 =?us-ascii?Q?Q16V6cUP4w9pVYQxN7bdpkKuMRQmY1B4utz/U4gVnMs9bjtZoU+ZrwCcrzhV?=
 =?us-ascii?Q?9rcAzv7+nD2LXhsjh+3Xkypf+Xd8R4o7Dl0TmkGAJAgHC3rrrr298gXMBNRl?=
 =?us-ascii?Q?G94q9B0bcyhU50wB/WgQonGo7W4Kb1QbOhkSdivx13iumrC+geCtmNs/8kVU?=
 =?us-ascii?Q?r+2v79OO8H8GHUbE6ZjP1OhlsrDdob6TTFcT8Y67dtZylJJovvRIRg6N5MO6?=
 =?us-ascii?Q?f1zm4X9TevJpy8Kxf4W1v35yt+Q8CkeiuWYowbZUQPGtzO1SVqHmw3l3020V?=
 =?us-ascii?Q?OMydxXJ/8bVvk3EEM+k+XRvl9obqu37b0j0+wy2tcoL1mlnPZQah3bviCnMP?=
 =?us-ascii?Q?A1KMJGk4dwBtf0zUmPjY/oRZ+N3MLBYeln7dbtiRroH6IW8/R2YdST0Lff22?=
 =?us-ascii?Q?rbhYD74lZouD9Wth5xe3UAYa5LSWaBnWNYMcSSMyj41ghGCDfrN4pcIefPDK?=
 =?us-ascii?Q?CAvsnVC9hOFQQRT4pNgZVa6vXRoUzmBgLM5XopFsFjv/g311pjuhm1mq2QsI?=
 =?us-ascii?Q?RRS1CYE0dAxtZzcVtzbEFXmgZXcaBdE6C5mixfyiL+oSv2AOQzMHdCcL7hZd?=
 =?us-ascii?Q?FIH4n4F7E/GbqEBtN+ogN4PuII8FdYs75vgE3Tfqod+tIXd1MBknxsXV3UAg?=
 =?us-ascii?Q?TmVWWc2Vhd5xy/MqDLT9CkM4AYm0o3NhnrjplvfqzMPXheORnr3kh52GLxdK?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D28C1D1B157A1458DD82F4FCCF9656B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J484voDye6slIgOoahEdmIbQIxm1qtp+nNirrNTQ0msj+RSDHprVAQPSZM/SuMDG2LawzDjB5LYPJAPwqV6Q09XfL3mazmla/GE7bukUxQfVQtRXjp5QNxtzyfJJyzJlUh1oaCIBPHXtI9KTA3RbHoxwkNCq4n3pG+xogHBmuuRIX9YAPYPsLT+86isjJAlJ2HIZbecEXGn/VZdR+DrPQ8di2Ivmmc+z5+7vgKQk91XhVY8bJaxrv/RwBoa9empnIiAshkPwPh+UpAirrA1nfrNZIXuLBN5g4lI1j0Qspgg9et02P5UGz+/1cJeAtjnp3o+/5Mj9ZDmpwjGsrg4Q/w9uc4eqXrU5UCOQ+5V5Z3AIeAYQrsUtZCrPh2kPAefDqMU+fMFtlxdMAHQXC8Njt9VIjzddduRUlN8bkeZPNw0i05NP7yBz6umG/ki5hd0v5CZn9GDZdwmEkRyaJBVBOk7c0/jyJ36gPHvZczrqk0YrBPaeS+bT0pWHEuyfjsqFjyHvI9VBBPrAUyS4GzpSWqeFVDVMwNTUSx8Vsk6wcLpRrn1F6+PS/bjUfNDBuw0tTiNNAhjaeLThEdaXe9Ry+XKmuEQBMH81pnxfEQo6HNlEOwCehQ/Y/VbXgVO7VPWL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cf9f24-56bc-4836-2bee-08ddb2ee4f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 07:11:15.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XStySsPsElqcfLIwHmwvR6DgmnqWenyrahVVk5MS+fbou/FTjKhSAi2aopliITt2lhJC00/gBWciTBXxaj3kBihuNjQ7sBO+tFgfNffmU6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8567

On Jun 16, 2025 / 11:07, Shin'ichiro Kawasaki wrote:
> Keith contributed a test case to cover nvme metadata passthrough [1],
> which confirms a kernel fix by the commit 43a67dd812c5 ("block: flip iter
> directions in blk_rq_integrity_map_user()"). I made some slight
> improvements on it and repost as this series. The first patch introduces
> two helper functions to check requirements of the test target
> namespaces. The second patch adds the test case.
>=20
> [1] https://lore.kernel.org/linux-nvme/20250609154122.2119007-1-kbusch@me=
ta.com/

FYI, I have applied this series. Thanks!=
