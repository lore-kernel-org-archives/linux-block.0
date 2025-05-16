Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BA1E871
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398752; cv=fail; b=DBssjgLQ+lBqrYehX4qXv98ZUiMYxA2IX1ufSggIjDl1JUusZ0jzUKBwTktGseGVnZ03xSFezvF0bK2fes6xlREosG65RaEkLo6hpX9H/gPQiFKiLrR59nrxtTvmVqoug2bIg50XpVCiADv5g24HAyCAknCL35uRNvSUFnV4Qds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398752; c=relaxed/simple;
	bh=FgEEPJDbZaVBqW/TYtrL2pnH9VRMLTRgSsy65Y9RyeY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ikxb7LjsgDr1Gvh22FXPr1zlYf51o771HLbt/CZ++pE4mmZutqN+tRl9Pl2mVeospQkeDovQ0XckbiV7urQlb1F5htjkP6jIDdBe/6tQrtBBe/itFUhgNj6k3b0Jq9uOMsN3UJ2ZyGh4E6JA5cDKCuigkcSjiOW389rt0xYNbcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O1TNLH3z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WaR8MJxO; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O1TNLH3z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WaR8MJxO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747398750; x=1778934750;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=FgEEPJDbZaVBqW/TYtrL2pnH9VRMLTRgSsy65Y9RyeY=;
  b=O1TNLH3zfys0sNBvxrKTb++4tv7Yz7oB3d7v8O7WtWDX02oA3bKHQovT
   9sKaMut43YSjl9+bBvCj6TN1URerJ25tjKti7h8FBBO5NS9Xwfk179Nv/
   xcHlyNx9CvRqu8WVy9QkCMBTVaWFBFsj4CB1dhNTXajT7Kw2Qi56ku3W0
   sotTKYadkiBfcIWYlyZlsDEExThXXNvb3YVHMSRFkjZTR2eUT0hbqxe0I
   f8c0EfWMQAdp0KXGQxn2VaLMB49bDDkxxNw3m2kXpgFnKqqWX8vBZbLze
   ZOxhBer1WCHnY1XjhkZy2ZwRm+cs0PGUGPxEBNPP750TxnxcrYmh/eDPI
   g==;
X-CSE-ConnectionGUID: XCKtIWINQaOb2GfPHlA1UA==
X-CSE-MsgGUID: zfysvMpsS/yIIY7kNorp2g==
X-IronPort-AV: E=Sophos;i="6.15,293,1739808000"; 
   d="scan'208";a="82685077"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2025 20:31:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcInmTkY7k7DDLvMtw47PmEToGdZfnOQ43pwjtN6XofvwdPbr5BlYzACWg8TsFwRvpgfJbFVfBflu0i43Gbp30fjjUNAkR3X93+XRQLT62xH1QP1p+oUoPk/ZE0GmLst7+m8hKWj89SbBsBkMvYhoTI3IyUP2eH8FsKJaBmcRhnMBG/6SsvouLu9wWwWtWgJzy6Tfi38j5q4qIkMF4/yW9kPAlTImYhsd4jNVoCIf/vIeBwos1tpIMzCFs5jDauIz7Q9FokYiIZT2G90bg27RkVkLHdBvMns+w0ycAF7RiY0hH+q+vFRiH/rL/eTWnKEHGqcvqZsyxaWRVVouxIG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGeqHEUnAOkkLkq8a2OUkIE4vjQgiNcX5NdtdXSAEfs=;
 b=t6FT3YeYXW5VUNw5ubcKSyGhPQHt9zx1ZAf9nCqj0+8Wdhra48pgU2L4K73C1FRrvaBSdeD6i5/RqXEDTAoQpRBXqQ55vCt0gpwFFuMvtvq040whBcCobZdC5XJMzNGo/Iaeud8p5bAV/4Wc/24TD9lm9b7bCUE7gnSk2qXuYZkBTB3moVx49SCmpqSqmbqSDKKAz0dDCXy3H1fdvhH1YF0viDBuGYpeJUduTjf80hsMME8+Zb+hrnV7ZthA9g0NShrpEufnHmU0V733LoWbFwBqyGmL2lRIPzceQx8jYJg0dF8AWxp+6EaGKCjjoZZbBG7Yr/F576/ROc2y8u2mBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGeqHEUnAOkkLkq8a2OUkIE4vjQgiNcX5NdtdXSAEfs=;
 b=WaR8MJxOVU0FRlaEgWs04g6qGu99txIaRJ3mZPYwYE+X38Xw9ihU95KP81zj4V643FIbDzAk1xIQZNaCJfUvHgYzsZ5dWdx5Jx8PtCpPVLHOjHxK3viwNKeKoJU6isExo4WI0++UhrAq3uQvesTikiLwI6q7Q7KVMBAlfMrd3IU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM8PR04MB8134.namprd04.prod.outlook.com (2603:10b6:5:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 12:31:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 12:31:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [bug report] nvme/063 failure (tcp transport)
Thread-Topic: [bug report] nvme/063 failure (tcp transport)
Thread-Index: AQHbxl5rVv9Lmn0H9k2g6oqO9vi3LQ==
Date: Fri, 16 May 2025 12:31:16 +0000
Message-ID: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM8PR04MB8134:EE_
x-ms-office365-filtering-correlation-id: 75fb02f9-b65c-46c0-79c8-08dd94758dd4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5dDevwSNnuOLqjovpaLliO63d30nFEsNJzSnHRkNHnG8zAgcKq60C+tdgh74?=
 =?us-ascii?Q?4ymub+Ysfz0mkx4paFnT7zlk11jY96P1xPI4MHbK4lh5oTVxso0eeDcBoewl?=
 =?us-ascii?Q?g6ZT5P1PxJ8/b4yPIXmeFuDZAPZqGhtw+9idrSVL9+I15QXV9U92taGXue8C?=
 =?us-ascii?Q?sSdCMeCccve2LJT4iw87Zxn8UzdK8r6RiviAT8klW2jJRHtzMsk1tOq+YGpg?=
 =?us-ascii?Q?U8YhfqHhsDX1zbmCv2RsTbHW7shYh3YLjO09FGsIElaCcoLvkLPnevcB5vyX?=
 =?us-ascii?Q?og79dNKG6W8H69PYQ9pZQgFcVspUXoFvTqtWAUSw5J9iNjChZjS2kIuPh6Ob?=
 =?us-ascii?Q?JkoWP4OPkFrKARtxAt+GOIS/l5ic1T8R0r6Q3+GFjdlX7eFPX6WfALNzWmX1?=
 =?us-ascii?Q?mGJ3v7uRjO1MbfqS/GXBFdQWJKXWz4btaJss2V+ZAg1IVAOpQ5JAuTSZ0/iZ?=
 =?us-ascii?Q?qXRA4dVAazAt0ahSw7AxQS/bBf1FKZbWZpiTAfBYbZplSr9GVMOqf8oOLjMl?=
 =?us-ascii?Q?FEaZN3tCjJUQqsRN2qEAF9ovutfs45uuw2iiDcWhGSwhcetqu5UfOxDLsoFI?=
 =?us-ascii?Q?GcGPIOwLdksATW4Qr2oL1Ol4x2jmPP/3fsWRpduBetflqag6/icILH/eDAcL?=
 =?us-ascii?Q?1Cl8XVuw0QMYKAKrACJ2t8YOE6QvyU4BdxHhTeF4gPM+TUs5w4MOFQLshfen?=
 =?us-ascii?Q?ldBTfgK6ZIBnF+8lCWhVO0lW8NTASfsy+BDrM5oo3Dlxa+QJEV7Y2UZcZDiL?=
 =?us-ascii?Q?nipdd1Cwt3Us4uGZX0OJ7JthvFkeOTiidsCYFIEW+Gu+x+eSyYdxsw8xQx3F?=
 =?us-ascii?Q?TSgOHBd6EmlIGptQSCbepChjzQvaJlhrOXfF8AHOjpTYiMxgd4b54S3uNlu4?=
 =?us-ascii?Q?pDkIXA11iUjLcgdrGkD3AqlHfvoTDR/jLAY+rZVVQW8lh0jk0RBXHq1Gfh6Z?=
 =?us-ascii?Q?DVqZRTTvOy+7vjO+xvQ+cJ/7ijCzQaQ0D8lPIqT4FZTWS2f6IOJnFzvnSo+x?=
 =?us-ascii?Q?sNgvWfbAPfvwUHvQ1Ye4iUogIPPNTKdulh/Q6UBUs7SeI7Yyda2xYWv0zJmp?=
 =?us-ascii?Q?X36vN5gjKFtQvtk9+/1gZ1Ff3Dp0e1jxDPorYiNq/ofsKhYYPh0i4+anKg0k?=
 =?us-ascii?Q?QJfka/b4XX3zJ5bqBWYzToWuN5iPUnJOcZmQ4Keg1k3jiuRVDpAj06awRHBT?=
 =?us-ascii?Q?vHy7VXU61zQvgkomsD0k3fA1J4iHodeMmwSn+QgMey9Emirmz4yFx0e5WNvb?=
 =?us-ascii?Q?iGMjlGB2jE5ABxYLLTil7zSca5ZiZFXD7W8xLhyC3uBJe+5efZdY4dskmbv4?=
 =?us-ascii?Q?wGHYFa3GvWM0BS+Md+NWcO35lq0RGvtlnP0Lxew1n8ZOs+4KnPewPYPy9JgY?=
 =?us-ascii?Q?LaOi5IngN4s3/wIGzqPJo+VWdiwGRoUfFqB1JJo+avAHCf0etZ7kjTBvwUwS?=
 =?us-ascii?Q?oJ8NW0YoFQ6LW2iN5Sp03SAUsgyGdF5KDoAc/aE+GL310I8tx2rVsA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T8vADcofrGr6V4KG6f1xO7a9sK8suGyfFei9HaqX8gIrXjYmPw93sa5zFmYV?=
 =?us-ascii?Q?yiHLgxU9z3aHY9U3dIJRKx3wX/aVa06kUUUL2Qy+4FqSexlDPVc61h643bw+?=
 =?us-ascii?Q?BE26lV2rJhdSEuV8m7s7N9lb3KHVe+U6QV8POWebXB9TfxuzJMeVOa3Cento?=
 =?us-ascii?Q?RdVDTcWpozsllLGIg9APud1mRZcDjQiNButx9SAehIX22nyH3o0tYDUjhc4g?=
 =?us-ascii?Q?YKdXMCs5W6+uN0y5NtVZnyE/8QZNL2VPUG0tMpStZGQlgvDzVEUCMOplSj8P?=
 =?us-ascii?Q?pD/zNemvfDfv7kRP4tzReb5kVfSd2x+aKM6+JFTl2sn4LYB2PfGfi0gVNy3N?=
 =?us-ascii?Q?MAWT6bQOe6lA9lG0Z9qOb9xmraZGVi6xoBwPiKi2Rd5Q4CwZm6JM9iCwePGU?=
 =?us-ascii?Q?qA/oAY0vJ1Spj6rc7tP0LlBkDI7pxdEmbjWI05relf5CSdBQAN2mUGHhmw4I?=
 =?us-ascii?Q?KeBazlW2pdtL14VBgTra/m+10KgQ20bK6F2t4dnHcjm5a4Jaht2DFMYmhl6l?=
 =?us-ascii?Q?UUOjz1+m4myUDSuEHjDlv5/1VLdHY8685F3gs2PuyKIWRPaMBfA5fCCspwp/?=
 =?us-ascii?Q?VZfNn63eGCjsEVW/2DRZtmElFLfhM9HTOT4Fpk2+Uu+jCjVarJgfOMK9qP5R?=
 =?us-ascii?Q?kWOlBETlNKFiebRCfccSSBPrY4zUDHJ/RqC5Sxzwso5FNE5u/qop/f34buzq?=
 =?us-ascii?Q?deDN3MPIcuscbhsunHFHF/nXrOmsRgxc/yOYQrIMOpR9EsFkWIMTI4EZ9cmS?=
 =?us-ascii?Q?izOF+WD0lzGFBL9WnrhKbFBuiOnXP2vsWtSzayAJgIgpZI1ndeiNCPC0GNqO?=
 =?us-ascii?Q?P7zJcuAtv6BxNbiXtpiI8xX285WyuUHYmyxFu6icI53sh2ZDB62VrdmHObg1?=
 =?us-ascii?Q?+iRgklGgsjTozdV4txLBjJGRC7B5R/nNRwt4jwJV70CWwDmpuZaAiZgZ163A?=
 =?us-ascii?Q?cFD16ChMqU+z0k5YnMTW9wKSgnVwfURZJjM4fXXLlBFUIc4m5+3ki+RVv9BO?=
 =?us-ascii?Q?sPjGJ2knOi5rZsZcOwaOJwrZ6kDlUl8wTnsWhYAAJR7ibpwxxkRJshTI/wYx?=
 =?us-ascii?Q?ev0sDPvd9RSlwhbs4pSGqGEjUohXYLpuFWBrNSk/aQraZ6SgnYyArYtiWDKo?=
 =?us-ascii?Q?AqOvjhNnA5Ahfr/F9Ud64HhPYOJhW5gmcJ1cs8zisOZkrq8KJV7qwtu6q6d4?=
 =?us-ascii?Q?U1lcQga1ea2Nj6vB4kvorz9cXxXfU+Zd4bgcw7Njj5nqepjjVdtIY9mcEj5T?=
 =?us-ascii?Q?ViYVhl8Rg6NKkciaIfoBaxmXPJvO8anegsj1id00NpL4Y87lvta134LUaYxJ?=
 =?us-ascii?Q?jskwYddjcP9dInan7k2ejjJXObMswwludRiD2p1DTeBzxYzsdjSV0ON9uL/Q?=
 =?us-ascii?Q?sqC/9RpSo/P/ia8d+8cXzdouVPkZwKT9Co7o0JAtV/TlZj6zJ4Lpf54lm27o?=
 =?us-ascii?Q?HYmp8MC6joV/Z+DhZ4WLAZwgTeES5+iMAREsWoqwg5kfx2eNa5PiuxTYYuuC?=
 =?us-ascii?Q?/zqcrhE03GvAIfHgcALPCaGgBHRRMjFfu/vJjCUlaRZZd4GoMQlm2DBRjjpI?=
 =?us-ascii?Q?srld9vMmyA0272MnbRYwtLMHtKcJnCe/1HgouTWBSnBVsMbShE69TBfLbe41?=
 =?us-ascii?Q?mnpqMm40dNypzuW2dTaF/sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EBA514B154A404D87619DEBD217D75F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vAyHGBzIIukCz1U5Wvib90am3spLyHfQ3akPVju5ZkTwWaqwdo48nAPC0wm8qXkxpAE7q62jaIcVAk006ViCpX3DzXpaZ8BPzM6o8VOnwS789DCWNG79Cuc2BeqeJ607HC1onE1rxUjpCLwT5D/KXlEhlNgMvGxtaUK8ngRZb8w0Gl8z3TsoSPHyBaEel7NHeyTWsOMYbYazY6yPsvKW8na3AhPAJ7tBj6TM90YaWn9bdU1BinwqSBX7H1AxXxHKGDeLsQkaNxxZEXXJX8BeGcoIY3FEFbNyBovxiFtP8l6cbO1coaaWCMnfRhH2y5YB4mauGdlJR//x/+D8dzgC42XIExEojY8FKB37nAgdqDhub9/H+9kTQ0JhcqCqj56fW6Uri0fRf22aPSs3X1MHID9rlBpd64mUCDkHmmwobuXHZOrDfPXHuDELZHNqv+2hZgt31t/mVXtGgIDqT5jMENpuM86GlZg4mN9nJSDqd/jA093aHaFGsgD6KGCw36URXY0wp2WpYl0nEHmpetkwuMNiw0agYLBEmOXBE7hoHnEajyeMFy9SOsqc9bwcmt3hCLsnT3Pf2S2pfUd7wJlC93OCsEFrp/hClX1If/NMdooeY6NG5mHJy61tJ3JtM9uE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fb02f9-b65c-46c0-79c8-08dd94758dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 12:31:16.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /o485rfH6Flb90hNmu3Otfz55aM7ionSmm/+SCCQUEIOGE74lrdFe/C79yBvEZ1Sx7M0/j6Iaw2Yd2sUpKs4KJ1aceVnmDUgRv35DbMbeGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8134

Hello all,

Using the kernel v6.15-rc6 and the latest blktests (git hash 613b8377e4d3),=
 I
observe the test case nvme/063 fails with tcp transport. Kernel reported WA=
RN in
blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter [1]. Th=
e
failure is recreated in stable manner on my test nodes.

The test case script had a bug then this failure was not found until the bu=
g get
fixed. I tried the kernel v6.15-rc1, and observed the same failure symptom.=
 This
test case cannot be run with the kernel v6.14, since it does not have secur=
e
concatenation feature.

Actions for fix will be appreciated.


[1]

[  488.383002] [   T1083] run blktests nvme/063 at 2025-05-16 21:22:03
[  488.470839] [   T1194] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[  488.479069] [   T1195] nvmet: Allow non-TLS connections while TLS1.3 is =
enabled
[  488.485222] [   T1198] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  488.607352] [   T1209] nvme nvme1: failed to connect socket: -512
[  488.616211] [    T111] nvmet_tcp: failed to allocate queue, error -107
[  488.623181] [     T98] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  488.639788] [     T48] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha256) dhgroup ffdhe2048
[  488.640943] [   T1209] nvme nvme1: qid 0: authenticated
[  488.643129] [   T1209] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  488.707387] [    T117] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[  488.710650] [   T1209] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  488.711363] [   T1209] nvme nvme1: creating 4 I/O queues.
[  488.727670] [   T1209] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[  488.730042] [   T1209] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=
 addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[  488.794602] [   T1246] nvme nvme1: resetting controller
[  488.801319] [    T224] nvmet: Created nvm controller 2 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  488.817111] [   T1247] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha256) dhgroup ffdhe2048
[  488.817872] [    T111] nvme nvme1: qid 0: authenticated
[  488.819541] [    T111] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  488.827162] [     T98] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[  488.830619] [    T111] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  488.831632] [    T111] nvme nvme1: creating 4 I/O queues.
[  488.853083] [    T111] ------------[ cut here ]------------
[  488.853350] [    T111] WARNING: CPU: 3 PID: 111 at block/blk-mq.c:330 bl=
k_mq_unquiesce_queue+0x8f/0xb0
[  488.853752] [    T111] Modules linked in: tls nvmet_tcp nvmet nvme_tcp n=
vme_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet =
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc 9pnet_vir=
tio ppdev 9pnet netfs parport_pc e1000 parport i2c_piix4 i2c_smbus pcspkr f=
use loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_c=
ommon vmw_vsock_vmci_transport vsock vmw_vmci zram bochs drm_client_lib drm=
_shmem_helper drm_kms_helper xfs drm sym53c8xx nvme scsi_transport_spi nvme=
_core nvme_keyring floppy nvme_auth serio_raw ata_generic pata_acpi qemu_fw=
_cfg
[  488.856850] [    T111] CPU: 3 UID: 0 PID: 111 Comm: kworker/u16:4 Not ta=
inted 6.15.0-rc6+ #27 PREEMPT(voluntary)=20
[  488.857366] [    T111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[  488.857832] [    T111] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nv=
me_tcp]
[  488.858253] [    T111] RIP: 0010:blk_mq_unquiesce_queue+0x8f/0xb0
[  488.858536] [    T111] Code: 01 48 89 de bf 09 00 00 00 e8 3d 92 fc ff 4=
8 89 ee 4c 89 e7 e8 e2 d7 81 01 48 89 df be 01 00 00 00 5b 5d 41 5c e9 b1 f=
b ff ff <0f> 0b 5b 48 89 ee 4c 89 e7 5d 41 5c e9 c0 d7 81 01 e8 eb 1f 83 ff
[  488.859493] [    T111] RSP: 0018:ffff88812090fb58 EFLAGS: 00010046
[  488.859791] [    T111] RAX: 0000000000000000 RBX: ffff8881249b4e00 RCX: =
ffffffff8a6b8369
[  488.860197] [    T111] RDX: 0000000000000000 RSI: 0000000000000004 RDI: =
ffff8881249b4f50
[  488.861504] [    T111] RBP: 0000000000000246 R08: 0000000000000001 R09: =
ffffed1024121f59
[  488.862741] [    T111] R10: 0000000000000003 R11: 0000000000000000 R12: =
ffff8881249b4f10
[  488.864004] [    T111] R13: ffff888105178108 R14: ffff888105178348 R15: =
ffff888105178450
[  488.866593] [    T111] FS:  0000000000000000(0000) GS:ffff88840f9bf000(0=
000) knlGS:0000000000000000
[  488.867757] [    T111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  488.868787] [    T111] CR2: 000056091c302598 CR3: 000000013a27a000 CR4: =
00000000000006f0
[  488.869883] [    T111] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  488.871019] [    T111] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[  488.872141] [    T111] Call Trace:
[  488.872974] [    T111]  <TASK>
[  488.873852] [    T111]  blk_mq_unquiesce_tagset+0xaf/0xe0
[  488.874869] [    T111]  nvme_tcp_setup_ctrl.cold+0x6f2/0xc89 [nvme_tcp]
[  488.876002] [    T111]  ? __pfx_nvme_tcp_setup_ctrl+0x10/0x10 [nvme_tcp]
[  488.877077] [    T111]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  488.878130] [    T111]  ? nvme_change_ctrl_state+0x196/0x2e0 [nvme_core]
[  488.879169] [    T111]  nvme_reset_ctrl_work+0x1a1/0x250 [nvme_tcp]
[  488.880128] [    T111]  process_one_work+0x84f/0x1460
[  488.882033] [    T111]  ? __pfx_process_one_work+0x10/0x10
[  488.883129] [    T111]  ? assign_work+0x16c/0x240
[  488.884118] [    T111]  worker_thread+0x5ef/0xfd0
[  488.885099] [    T111]  ? __kthread_parkme+0xb4/0x200
[  488.886073] [    T111]  ? __pfx_worker_thread+0x10/0x10
[  488.886960] [    T111]  kthread+0x3b0/0x770
[  488.887836] [    T111]  ? __pfx_kthread+0x10/0x10
[  488.888698] [    T111]  ? ret_from_fork+0x17/0x70
[  488.889579] [    T111]  ? ret_from_fork+0x17/0x70
[  488.890395] [    T111]  ? _raw_spin_unlock_irq+0x24/0x50
[  488.891199] [    T111]  ? __pfx_kthread+0x10/0x10
[  488.891979] [    T111]  ret_from_fork+0x30/0x70
[  488.892714] [    T111]  ? __pfx_kthread+0x10/0x10
[  488.893486] [    T111]  ret_from_fork_asm+0x1a/0x30
[  488.894207] [    T111]  </TASK>
[  488.894902] [    T111] irq event stamp: 3320
[  488.895644] [    T111] hardirqs last  enabled at (3319): [<ffffffff8ce96=
9c4>] _raw_spin_unlock_irq+0x24/0x50
[  488.896485] [    T111] hardirqs last disabled at (3320): [<ffffffff8ce77=
f6d>] __schedule+0x2fad/0x5fa0
[  488.897480] [    T111] softirqs last  enabled at (2838): [<ffffffff8a516=
d99>] __irq_exit_rcu+0x109/0x210
[  488.899945] [    T111] softirqs last disabled at (2833): [<ffffffff8a516=
d99>] __irq_exit_rcu+0x109/0x210
[  488.900981] [    T111] ---[ end trace 0000000000000000 ]---
[  488.906709] [    T111] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[  488.926409] [   T1265] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"
[  489.195387] [     T67] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  489.212205] [   T1247] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha384) dhgroup ffdhe3072
[  489.214003] [   T1278] nvme nvme1: qid 0: authenticated
[  489.216353] [   T1278] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  489.218537] [   T1278] nvme nvme1: failed to connect socket: -512
[  489.226758] [    T111] nvmet_tcp: failed to allocate queue, error -107
[  489.232297] [   T1262] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  489.254966] [    T111] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha384) dhgroup ffdhe3072
[  489.256783] [   T1278] nvme nvme1: qid 0: authenticated
[  489.258606] [   T1278] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  489.309468] [    T224] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[  489.313302] [   T1278] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[  489.315374] [   T1278] nvme nvme1: creating 4 I/O queues.
[  489.337242] [   T1278] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[  489.341639] [   T1278] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=
 addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[  489.421601] [   T1317] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"
[  495.597732] [     T67] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  495.598765] [     T67] BUG: KASAN: slab-use-after-free in blk_mq_queue_t=
ag_busy_iter+0x1287/0x13a0
[  495.599885] [     T67] Read of size 4 at addr ffff888127a0c184 by task k=
worker/3:1H/67

[  495.601693] [     T67] CPU: 3 UID: 0 PID: 67 Comm: kworker/3:1H Tainted:=
 G        W           6.15.0-rc6+ #27 PREEMPT(voluntary)=20
[  495.601698] [     T67] Tainted: [W]=3DWARN
[  495.601699] [     T67] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[  495.601708] [     T67] Workqueue: kblockd blk_mq_timeout_work
[  495.601715] [     T67] Call Trace:
[  495.601718] [     T67]  <TASK>
[  495.601720] [     T67]  dump_stack_lvl+0x6a/0x90
[  495.601724] [     T67]  print_report+0x174/0x554
[  495.601733] [     T67]  ? __virt_addr_valid+0x208/0x420
[  495.601743] [     T67]  ? blk_mq_queue_tag_busy_iter+0x1287/0x13a0
[  495.601745] [     T67]  kasan_report+0xae/0x170
[  495.601751] [     T67]  ? blk_mq_queue_tag_busy_iter+0x1287/0x13a0
[  495.601754] [     T67]  blk_mq_queue_tag_busy_iter+0x1287/0x13a0
[  495.601757] [     T67]  ? __pfx_blk_mq_check_expired+0x10/0x10
[  495.601759] [     T67]  ? update_load_avg+0x240/0x2170
[  495.601767] [     T67]  ? kvm_sched_clock_read+0xd/0x20
[  495.601770] [     T67]  ? sched_clock+0xc/0x30
[  495.601775] [     T67]  ? sched_clock_cpu+0x68/0x540
[  495.601779] [     T67]  ? __pfx_blk_mq_queue_tag_busy_iter+0x10/0x10
[  495.601780] [     T67]  ? __pfx_sched_clock_cpu+0x10/0x10
[  495.601782] [     T67]  ? psi_task_switch+0x2c1/0x8a0
[  495.601784] [     T67]  ? rcu_is_watching+0x11/0xb0
[  495.601787] [     T67]  ? lock_release+0x217/0x2c0
[  495.601793] [     T67]  ? rcu_is_watching+0x11/0xb0
[  495.601795] [     T67]  ? blk_mq_timeout_work+0x137/0x550
[  495.601797] [     T67]  ? rcu_is_watching+0x11/0xb0
[  495.601799] [     T67]  ? lock_release+0x217/0x2c0
[  495.601802] [     T67]  blk_mq_timeout_work+0x15f/0x550
[  495.601804] [     T67]  ? __pfx_blk_mq_timeout_work+0x10/0x10
[  495.601807] [     T67]  ? lock_acquire+0x2b2/0x310
[  495.601809] [     T67]  ? rcu_is_watching+0x11/0xb0
[  495.601811] [     T67]  ? _raw_spin_unlock_irq+0x24/0x50
[  495.601814] [     T67]  process_one_work+0x84f/0x1460
[  495.601818] [     T67]  ? __pfx_process_one_work+0x10/0x10
[  495.601822] [     T67]  ? assign_work+0x16c/0x240
[  495.601825] [     T67]  worker_thread+0x5ef/0xfd0
[  495.601828] [     T67]  ? __kthread_parkme+0xb4/0x200
[  495.601831] [     T67]  ? __pfx_worker_thread+0x10/0x10
[  495.601833] [     T67]  kthread+0x3b0/0x770
[  495.601836] [     T67]  ? __pfx_kthread+0x10/0x10
[  495.601838] [     T67]  ? ret_from_fork+0x17/0x70
[  495.601839] [     T67]  ? ret_from_fork+0x17/0x70
[  495.601841] [     T67]  ? _raw_spin_unlock_irq+0x24/0x50
[  495.601843] [     T67]  ? __pfx_kthread+0x10/0x10
[  495.601845] [     T67]  ret_from_fork+0x30/0x70
[  495.601847] [     T67]  ? __pfx_kthread+0x10/0x10
[  495.601849] [     T67]  ret_from_fork_asm+0x1a/0x30
[  495.601853] [     T67]  </TASK>

[  495.637098] [     T67] Allocated by task 1278:
[  495.637607] [     T67]  kasan_save_stack+0x2c/0x50
[  495.638142] [     T67]  kasan_save_track+0x10/0x30
[  495.638660] [     T67]  __kasan_kmalloc+0xa6/0xb0
[  495.639163] [     T67]  0xffffffffc17c6fce
[  495.639630] [     T67]  0xffffffffc0ff389b
[  495.640099] [     T67]  vfs_write+0x218/0xe90
[  495.640576] [     T67]  ksys_write+0xf5/0x1c0
[  495.641053] [     T67]  do_syscall_64+0x93/0x190
[  495.641551] [     T67]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  495.642492] [     T67] Freed by task 1278:
[  495.642956] [     T67]  kasan_save_stack+0x2c/0x50
[  495.643464] [     T67]  kasan_save_track+0x10/0x30
[  495.643973] [     T67]  kasan_save_free_info+0x37/0x60
[  495.644495] [     T67]  __kasan_slab_free+0x4b/0x70
[  495.645004] [     T67]  kfree+0x13a/0x4b0
[  495.645456] [     T67]  nvme_free_ctrl+0x3bc/0x5c0 [nvme_core]
[  495.646041] [     T67]  device_release+0x9b/0x210
[  495.646525] [     T67]  kobject_put+0x17b/0x4a0
[  495.646994] [     T67]  0xffffffffc17c77fd
[  495.647457] [     T67]  0xffffffffc0ff389b
[  495.647908] [     T67]  vfs_write+0x218/0xe90
[  495.648383] [     T67]  ksys_write+0xf5/0x1c0
[  495.648848] [     T67]  do_syscall_64+0x93/0x190
[  495.649341] [     T67]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  495.650274] [     T67] The buggy address belongs to the object at ffff88=
8127a0c000
                           which belongs to the cache kmalloc-8k of size 81=
92
[  495.651564] [     T67] The buggy address is located 388 bytes inside of
                           freed 8192-byte region [ffff888127a0c000, ffff88=
8127a0e000)

[  495.653224] [     T67] The buggy address belongs to the physical page:
[  495.653849] [     T67] page: refcount:0 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x127a08
[  495.654646] [     T67] head: order:3 mapcount:0 entire_mapcount:0 nr_pag=
es_mapped:0 pincount:0
[  495.655416] [     T67] flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|la=
stcpupid=3D0x1fffff)
[  495.656150] [     T67] page_type: f5(slab)
[  495.656624] [     T67] raw: 0017ffffc0000040 ffff888100043180 ffffea0004=
b1d200 0000000000000006
[  495.657407] [     T67] raw: 0000000000000000 0000000080020002 00000000f5=
000000 0000000000000000
[  495.658193] [     T67] head: 0017ffffc0000040 ffff888100043180 ffffea000=
4b1d200 0000000000000006
[  495.658994] [     T67] head: 0000000000000000 0000000080020002 00000000f=
5000000 0000000000000000
[  495.659789] [     T67] head: 0017ffffc0000003 ffffea00049e8201 00000000f=
fffffff 00000000ffffffff
[  495.660597] [     T67] head: ffffffffffffffff 0000000000000000 00000000f=
fffffff 0000000000000008
[  495.661417] [     T67] page dumped because: kasan: bad access detected

[  495.662501] [     T67] Memory state around the buggy address:
[  495.663108] [     T67]  ffff888127a0c080: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  495.663871] [     T67]  ffff888127a0c100: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  495.664649] [     T67] >ffff888127a0c180: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  495.665430] [     T67]                    ^
[  495.665964] [     T67]  ffff888127a0c200: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  495.666747] [     T67]  ffff888127a0c280: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  495.667570] [     T67] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
