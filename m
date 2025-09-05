Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88A4C9D
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044257; cv=fail; b=d4OQtsy9FcQ4sPmol6MAYYJUw1sgrCgyga30KXrPAZbmILFTTgWyburYrmFbL0sNEEjthxS2TC/+a8Y33JkYaCaZXkR3aC/xLwqortDFW5+ibVBzZsfepADxRn5sAFq10a0dCZID6vIlKnHXG7OKOsto1IDfkBnwtJP3wfVQ5oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044257; c=relaxed/simple;
	bh=4movfrHqr1+GnaA2E1fSDZEb5nnCBaPj6ewpTjgHJYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/LP03S3XhxGXcc1jmnMDesdzapOz7beCS9GmAfB+fc3VNE5THpQvIoyHv61CEIGCWfK1oxCaihU4W+56cXQ//q9aYGe8umhvAo+IRHKeQn3HpyK+s9PkqgOUToMTo++roMu3YV5TV1fSBnatJklhtlbtsWEM0NAYogpbP9VaAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ebs779vS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Qkc+JrH9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ebs779vS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qkc+JrH9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757044255; x=1788580255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4movfrHqr1+GnaA2E1fSDZEb5nnCBaPj6ewpTjgHJYE=;
  b=Ebs779vS728Dz61XuLfIehvSCi0Vboajfn+RGJpDjQbwaCLwiKXScp6E
   TOYgZwKDPnDpK7t26sxXnlcAudRHxAphb3C17rl9mIMx7xFAOJ+PzBBhT
   YetIzd1sdlULO7LXoOf2Dkqyjwd3O6ENV7xlSo35auK8uS8kfxVG5FLk6
   UuRVjYLOq4YiMwKXNhHNMUVItfXwteHtxfLj2usJuBjtcTnl4U0H0Ivd5
   NGb3xi9l2MSd+VHV3zaHlCedBIF+hPE1+L2Al/J4upPdd3gXPzKVX0DZa
   U7FNeHAe+20KJH0xNGyeLo7t4maGMvLh7tGDcs8PuU4QWkfv0A2+BPTkQ
   A==;
X-CSE-ConnectionGUID: K3iA2DwQT2OsbgcSg/VNJw==
X-CSE-MsgGUID: 2HutXLzSS7WlI+kSFA7S0g==
X-IronPort-AV: E=Sophos;i="6.18,240,1751212800"; 
   d="scan'208";a="107954082"
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.59])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2025 11:50:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9MU8HLXtrqQijtDSO1awBV+XDT3/82QudFLnny0iINrv9OEdHuhp71afEsi8dHHB7touTt467EMYqP8M5/JHBoaBQ1sF6T4jhiL0bgQjptgj3v3ZNG19QOLHkYs3zMJwR17cvoa+gclodwzFylv3pYEgRT1AF7gZ28B1A3YltxsK10v7NyDzY9qL3lNrGPE3vPgc0naDMXaXPBA0vqAOiskVnYGR+cEv+cXTF67SN2tAniAih2fxMGejWphkdPmajCkox02Ml7Ni1eUuhagAtEMip/RtBY+T7iUDhvCEjRkGH2KpSD3pFHNvrKRd1/JszciPyfEf1PeRqSu5fuKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4movfrHqr1+GnaA2E1fSDZEb5nnCBaPj6ewpTjgHJYE=;
 b=Jl1QIuO6sLc8Kuyr2g+slifzNOLfnsqgIiN63EcTvooqLuTipQyipxhVbxjOQvfVka4TXUSFedA5cAuzUrPppnn4Fxx6y88xj0HSEZULfmQUNDrRRuiwNgM4XWichG0BMLB6GfZMenWIUXiWRu6T5z53uSoR38Jblfty5hXrNBleSY9Bc0Pv7b4Bmqe0Vpf2oj828Yqyk+AMRzd+60zs7QtRikOCDLjJc+04gkr6HeXwQ9si9QYltH8N1aou9no3KnVEvPBJGaCI0AoTh73D6pGTRYxNrUsQJvckNkN27siDgPsOc8QmOi+05JS2yAJbteyDZN+Q7oyson8/dTP88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4movfrHqr1+GnaA2E1fSDZEb5nnCBaPj6ewpTjgHJYE=;
 b=Qkc+JrH98XoOZItg2AnxeM67Xn+mOY2b4O9hBXMOINu6ZfIi2NVNOCYNB6clmJ5TfqhCvkmyZkRM1W2NN6HZEdUkbLVgaTKD3M9etLLeLSMsP9LuTwLvVcG8SSe5ujbC1qG4MALyCxhbgxTvKfeJvPQn19j6EIM150NtfZQuhaE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH7PR04MB8507.namprd04.prod.outlook.com (2603:10b6:510:2a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 03:50:45 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 03:50:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: fix run_xfs_io_xstat for max atomics
Thread-Topic: [PATCH blktests] common/xfs: fix run_xfs_io_xstat for max
 atomics
Thread-Index: AQHcHOH0ncCe4ibkrUi2AKkRGpaz6bSD9r2A
Date: Fri, 5 Sep 2025 03:50:44 +0000
Message-ID: <fvz6df4zy3jfirpddywjyeqt4rk2qowyz5kx3ni2r4gzpyrcqr@5e7yjn7n6kzt>
References: <20250903144908.3303325-1-john.g.garry@oracle.com>
In-Reply-To: <20250903144908.3303325-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH7PR04MB8507:EE_
x-ms-office365-filtering-correlation-id: 03f50af2-d29b-4671-d89b-08ddec2f6485
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rjRZXzfNnmftg0xBnNMaPKEeXEpDXqooH+8CHBwpBff2yLLVPNJJHekVlDfa?=
 =?us-ascii?Q?rZlWchLFzdOFQsL2+GZ38BQKOBPFI3TrXvluP/GXyWL8SSS9EpWb5x2ZhM8z?=
 =?us-ascii?Q?cgKs7zU3t/f2ehScyfFKQDz5LmWul7UsGR7Rcl/FJpGLjQexTXc8BpuKT+xx?=
 =?us-ascii?Q?OvDuL0cb25Dfm7gVYnEKJK/b71l+j1teear0lPxCAb/kHqRS21TTI3vgXhm2?=
 =?us-ascii?Q?vnZ6JKI7Vb/lrRcoZcN2Yvn4JU8CMUmphoor5TZ5eHMQ/n+gXZOEopM3s6Re?=
 =?us-ascii?Q?nJolIwp36ZF7qzEAH8qzCywpHjjRJoG9iJciJilDUF1Xyn/nkgMRaw+S0TMd?=
 =?us-ascii?Q?zvZOdMO44+kgH0/gcEAsa2fHqc0NF4bh4sZgzSXJCrDleI+AxaxFLD17Dw57?=
 =?us-ascii?Q?JOu4XR67kDjaNx08wEVAiVx/gCkRvdKwJo9aBxlz1Zj1AI6n+Rq9ZbTbeQjt?=
 =?us-ascii?Q?1AV0E1aSErLZ9unMvaIHyHGA9du5nBSDUwE9BoFTWyadm9olGVr2gKY1CCH4?=
 =?us-ascii?Q?5Ir5NuaMB5W1z8KjZ/SJ8ou3dqXU8oxUupjlAdjzW5KS4lCMZx26yAy5ZSGO?=
 =?us-ascii?Q?I6NerIOFJwzKkyxOPHQ5IHt6bvAps5WL2jPOO4802LwgFMN9uRLE0e5q8ydP?=
 =?us-ascii?Q?fmGrUvVOYajvN64Iqa2oqDKVbz9RnrgPvNv53qKG1CUPWwqNnGSpXBgaemTV?=
 =?us-ascii?Q?FOAOXcn28bpb8zuF6p/i/TcpYgCj0SHzhOdQRPD0vc8CEFK/MHVK1RERgisn?=
 =?us-ascii?Q?+p1SFyqA2mrYcx397NY0f2YQpbSS+nFuAcPQWxfOMVXSCHSCTwX8jIhTKCCM?=
 =?us-ascii?Q?AJ5k81D9VXXa/8IbdrpmuAg2lezcYWNhnzlBgsCAFsAq3465FU0fif4xSHhy?=
 =?us-ascii?Q?MBp7SyQKkTttZfrdshd/0m8PY3EkFUZ7BJMl7IrUQCAYd7Ss35RwTIuEahPP?=
 =?us-ascii?Q?n42Z1anFNlO9ff00JjBYhdhh0I3lUgQwcrTPq7US6M8zV04F39+Pn47vvD6n?=
 =?us-ascii?Q?nOuPVp5gsf482Ruz/CMKfWKouAyrbzQdOD+LLYlBAAsm9JDiQnv/MImb+LSU?=
 =?us-ascii?Q?ZGVgDrmRRjlpGCLVI/0Q8/psJXps4T7yU4xy1lrdda2MctlYV+TrgMm2ZTWC?=
 =?us-ascii?Q?u4oZbG5aa3mRyG/nFjKh50CEtK4Ax2/z6ivZfrWIvQj6YRgVZ1WUpvGlFRGp?=
 =?us-ascii?Q?6qrOUY8qH/WWeAXZ47CA0WZns84CjrfrPsLvrzbQNWMLI/vudswsUAKydPHQ?=
 =?us-ascii?Q?IhT5LgfAH6q/koVH6CVq2oHb4kKUFNfiTz4HLtniyRAJ5H4i+j4Zw00Qr3Hs?=
 =?us-ascii?Q?qzvTV65g68HZzc0psBaJJnX/09bDilY3BRyxBmqlp+4wLjG2W9f9zvpwl3Zs?=
 =?us-ascii?Q?mfxPBjR4kEQw+HYL3F3prZxVx55jRZgYQ94zBDTN3PLewr1sMxnT1bsHbYhU?=
 =?us-ascii?Q?Keid5GI5Jw8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rGDzLI6PutJdLIe+JYbbZX+9Cuquf0pD83cNgc0E/QQd8TzxrhRExgurU0+I?=
 =?us-ascii?Q?zmdQ44OIsXiojeweTerImpabs99lVYkomRufFBSKpNEzaHikALYOR/Nj1T8S?=
 =?us-ascii?Q?1WDCGJ6iwm+qBCmFUUnvY0E68olyWtMqlvXtHyiVYsPTnfovMIesWDpZk0pK?=
 =?us-ascii?Q?HgTYNsTuur7h3x96qICP/lne8mETdfBTGTKwmPufpkRShXYFv8dyqUFa7ONt?=
 =?us-ascii?Q?QZzNwKjjXOmCvOf5oVvmIILktIyWZmqx5cYIEv5WKaLW1SQNQCI/GQN2Msy0?=
 =?us-ascii?Q?mYtfR4AYhkioymQWNUKSoZZXFWEeovm1OBPwoFsBp7liy6nRefVGbYqllP1r?=
 =?us-ascii?Q?ECtOEkyddbUuBlJMy/a9dtkziNO7L7qRbgiLlqVxOQlTKo8h2sMf1SOGhs9a?=
 =?us-ascii?Q?pqnMZ/DuB2OF/2sYvf4DjO/N9pl/hfrZvrsb/lmc9wApiOo598IWiJSCg/sl?=
 =?us-ascii?Q?Q2pkT65d8xHpp6nrLcGnpTrBOo8aPxDBjiPz3RG5o5WiesD3tB6kh3/sj4W0?=
 =?us-ascii?Q?n9Pck+UoYxvZ8ny9sDpA1njSdZrN+PicZlqOhUhELS8scbZjPG+WhDmfONsv?=
 =?us-ascii?Q?0WcWvh1a5FBJgjtYeAXTcvAOKuN1viKHHmffiALozbH2OxefcaxBEopafvTU?=
 =?us-ascii?Q?2DKODt1DHIdHy6FWy33x3aJTQK95nooDZ7Wh0xcqQgmNQDE5qhgCrHdi4AVf?=
 =?us-ascii?Q?4V7TSBd8/+hFGu9RprIOYb5l2JZwgdGu890o3U6N+aJ864Xjq8yhsmD+7hNU?=
 =?us-ascii?Q?9ERjdyBf566tfS17GTV0l1/Zk5B1J9RBKPwzd37CR6euSqjfpOo9jO5XGMKB?=
 =?us-ascii?Q?cpI0rmx3lYvyAPhFAZH4/4uJRVOzEcS+vM2qoYEMNWCKWdOBSsPtHeZNq4T8?=
 =?us-ascii?Q?HBugmB/rIgqYZyBJBa/qokM5vwNhp166pD5lcac8yOSsk4aLr8loc5vYQ9eR?=
 =?us-ascii?Q?fceIXWLLZ6NtOys0lYnbAAyceCMAqvZWgaCTTrPDvU8fAReZ5jBgq2GgiwiN?=
 =?us-ascii?Q?UHFmxPiMAG1AKSDUX8oJbmHRHxZxBZaPH3jHfBdL3INf9YmkU5wut/A6N8/B?=
 =?us-ascii?Q?1UlS0GEccpukjDMN/8KYF7x9g0LR6ql6+XXFBUTy0qRk+9YROKw0FSvtLc1s?=
 =?us-ascii?Q?PRtEd4ffXcwMgBCiKPfMJxFmCWpuaNRDAhl+1hox35J0GNVpSeO9BkuhaSFN?=
 =?us-ascii?Q?7BibVKyApzQc/HGob+JvXqOygmBCzaL9uXp7DBVE/T+SFhNilKu0CIFINb5b?=
 =?us-ascii?Q?NKOelaNT7/2/tQHmB2/YE3ZJ8yYNXLSdkp5E1ufSokUb+tqSsqqdvLoINxUd?=
 =?us-ascii?Q?gkUxu5UziK03jbsh3jfQ3qEF0jypr4ae1hjChugTVGGOWZ7+tdNw+B4+iGsq?=
 =?us-ascii?Q?zyNngMDnaAh7BSf/bm0/tzcZwn6jCsDxvMXRdY5SvS8tzf3K3Ego20E+vxWK?=
 =?us-ascii?Q?gJ4s6bsDAAgRFtBOZ5KgREmNqGvMCnIY/dZMxhsFKa6TpqbRTlbswgQTgVJ2?=
 =?us-ascii?Q?lXJZnw32QMgROczQm+Jm249iqw7aQsEpeH2clj88zzPn8PFdU0UWzPUwIkmK?=
 =?us-ascii?Q?qMY8KzYtxUV7+sIIFXSV8KnZbbUrsP7sYrndAHR0bF9Ssw8OLrfSKRrkrMMd?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DAA67AF085A4545AD20E5C989B98FA8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DvX8KqKoil8IZ+XflBPSb2cd8DNp7sOaaHKrBPls0QlrRltmFfV23LW3FKsAloVjFf1cPNGjsQffmH1vgRradx7HHTb9mWNprk+uFglomzpcOcNucHW+jSF0irMT3O0gYc5CJmThFL8enssfFeOV2EjFqKOvXAicM299EFHpCs4rekbpb9jiJ9vgr6j9AD3jPeQ/NOzwJkIeYE7RFn3bEINdKinVdVkyQrJdsWx9PDZf1LGO+1VPq8fv1F8ifnu/OaXmGBJP63bdvq0WIMgtwj1EWQ2HqeCWQWaFZBw/lLQVPQ3o+QjfRc9swQWTvfggdTXujv5U7DXuMupthPGsP5VRQw/FBzLLt5eElxtaDPk6Pln0VXL4STO332Bn5EZuSOjB+PvKB97zC58G3m1yykyxZf6Y8mNzOJKdlfKlLQUp/z9rrCxRr2CFDPSBtZ+s9nDaP82WjXJb5P2bbSmyLeMrCZUX9lO3gqwecm6t1jEsCMjwMFn4cqE9WlfdZKHNKMQ/NkvTJE0CBalmuMMndhVwq4G+HNoLL8F8VxZnzf8zFZFe7hcoEXStQBsc5wpChYejH9knzh2BiES3vjl7dQHFJ8DPaxwUm7Og64nyUk0H6IvspDab2DWQlXy0Yl/Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f50af2-d29b-4671-d89b-08ddec2f6485
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 03:50:45.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1R3yynamnNo4URI2JYrCOlZL7VXFOg2muS+LVOKWM9kdGy7mkkGiXWhPypj6YDS4yUBhXv91TdD50iKp3t3o1jCTkjKOgxi+As/3ee9XGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8507

On Sep 03, 2025 / 14:49, John Garry wrote:
> When trying to find the value for max atomic write size, a user of
> run_xfs_io_xstat calls something like the following:
>=20
> statx_atomic_min=3D$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_u=
nit_max")
>=20
> And run_xfs_io_xstat will grep for "stat.atomic_write_unit_max" in the ra=
w
> statx output. However, since new field "stat.atomic_write_unit_max_opt" w=
as
> added for statx, the grep returns 2x values (which is wrong).
>=20
> Fix by changing the grep to cover the full field name.
>=20
> This fixes md/002, nvme/059, and scsi/009.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I applied it. Thanks!

FYI, Yi Zhang found the failure and reported with a GitHub issue [1].

[1] https://github.com/linux-blktests/blktests/issues/201=
