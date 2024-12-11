Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EF236FB0
	for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913071; cv=fail; b=WBTXjRoYcUYdRgI5F2Mfdp/QKpl00Hz4adO4NylPwX5agl+CW7xzaaKjic28CA6QhyAo4fBuGkqO+O57IwQYx5gL+B+5NrZ/P4+buumsSf0n10njmscGBrPTdI0mSkCeKX1aDSAyBH5/4Hhz1FG/raHNp+Q3Abz6EVo9dduqr8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913071; c=relaxed/simple;
	bh=kG1O2Z4jkGQAwUor3jIyWn+KFstOg2JYriENIlq1bsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NO8hBg+ViDkrmc80jp8GZd38oeoFROkSSE4UhxfyNPkZM65LeTl6b1IVV9/QC4/ZYajDex9FBZXPM+LZTJG082VvvHOTzaU3+JDK9soHAHVh5BVMKMA+JIeb6Z+tF55JmKpPTpc+rJGzd1OWdhiQKtCRSRMXkMxB79BPGDrVego=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dYCA75TE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SY+ocvnc; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dYCA75TE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SY+ocvnc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733913067; x=1765449067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kG1O2Z4jkGQAwUor3jIyWn+KFstOg2JYriENIlq1bsE=;
  b=dYCA75TE7TJneBAyddNSU6tshXlh0i6LMW+rY0LHWjOLbPZRnTExK9xy
   s8IGrfPI7MSo0ZD02dZ5IMpYp28KdvOFunmqIK8SAIDqM4QfuX79I9vv+
   Svyq8pTovhU5fwdqH3Y2X4QiBZuy6715+ZauKZSmDZu8fYQe5vA3SWA4x
   LuRBRhX9JEc3/NXNerfjF7KGQF8dFccvz1yakh9+5cck2X2teyvWra+MR
   deI6sW1PjJ7esvU6nRE5bhMOStJrMvynjSjSYWGVjE0/oHhh0izq0+GJE
   XjJ5vkOckj5cdM6Xyit47Rra6Li3OGPtbrk8auHmZZlasdO8UiP556D45
   w==;
X-CSE-ConnectionGUID: I/vLj3oGRTas5f9sCnOBZw==
X-CSE-MsgGUID: jcA+S2vbToORgxi7JKSocQ==
X-IronPort-AV: E=Sophos;i="6.12,225,1728921600"; 
   d="scan'208";a="32900248"
Received: from mail-southcentralusazlp17011028.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.28])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2024 18:31:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLwQiD5xdqlq0ESqhvpodi0vvJb+IK7+5o+8dEXfy49JRCbJeobN8g21qLJdTHlQKSeKJHZCceDlFIxyGWxZ4WLeZHJPWW07OfVM0j0bK28gRc4I/VnY0t+MBacuLv1RQJJvLkSW2MokPej9e19GLO8gVLtGxnhLfvd/QMQETYPZlVTRUaAJ8f8XVuwWDSlvbr0EFMZ5bfwgsgnkxRXkVqUCaykSnxXgQvS/0Tn8IytN5ekNiML5J9kvvJfM90Jc1dj1wieOPqBLnOIjV6fxLzwZCG+Ypxs01WkEEc867eAPOviRh0gkPJZrSa1VrlC6sX8mbjoP2fw99B5kLt16lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG1O2Z4jkGQAwUor3jIyWn+KFstOg2JYriENIlq1bsE=;
 b=bgsR46b9o4Iy01ixlau/nakLTeJ5V90UUQ1BVX3VMpYjhW3kZXWoOaZ5lht+yl7kvXwYnBwvGBXczpLKGu29CYCxnXzeVT2iWSj9xGmkaSoKBjq45GJ7O4xNp4RFs5nbK+sunnFYV4y1DjK3+wuBLeMJJZ7kszgzmd0U229Y/5OF5feAP8D2e0wtqQLQBBTv6xLdp+kWgD8u7xOLRD2uIMmwriU9yR4hcZGBN5KG+fxe1s98uNCpCEC1KkP6tNmWwP0DxEDQ/xcWfo0MeuFoDmiTuDiV/qT3R3AIysL/HVV5nIa0wwMOcagqYbB7fLBTUZkGXQRNWWYtb+ZIfd6JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG1O2Z4jkGQAwUor3jIyWn+KFstOg2JYriENIlq1bsE=;
 b=SY+ocvncrJZfnQrQ8CT1919MQXJhmAAF4OFVl32TlsScFMLYJjR8k9RPb9PgW8szrL9xwCOtSzt/maTX2v0ywb+fn8tsBBeXj5MSEZ+GfIxE490MrQt08yqRYw8kITignUQc/zuIXtMkUb2pE1RS1bdQP0iMKuSsA8ZgMll69b0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6495.namprd04.prod.outlook.com (2603:10b6:5:20e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.17; Wed, 11 Dec 2024 10:30:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 10:30:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: src/miniublk.c: fix unaligned mmap offset for
 64K page size
Thread-Topic: [PATCH] blktests: src/miniublk.c: fix unaligned mmap offset for
 64K page size
Thread-Index: AQHbR86qBrpz2hCXpkGZ5xustJHiXLLg3+mA
Date: Wed, 11 Dec 2024 10:30:58 +0000
Message-ID: <rya4337bmypuxovqrckfrdy25vvshwy554bwjfccgvtgp2ggqa@z3n6eqxwl47j>
References: <20241206110427.976391-1-ming.lei@redhat.com>
In-Reply-To: <20241206110427.976391-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6495:EE_
x-ms-office365-filtering-correlation-id: e6be3656-4d35-4327-571b-08dd19cee6cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZGxI/UlpYC1dqbWMWq8LLTGHOpDonc/o+/FFFARAZmZioKZKumKJpZNVMKEb?=
 =?us-ascii?Q?zCNJHB26X49Bo8l5QN8/L3TM1JD0LiZznir12Itg0JRZqnSUpmPwoeKOqiSG?=
 =?us-ascii?Q?mIP4C8SIIVgLRMouRfY2XiXPGGHITJAPGgce9eg761xDxz84Eg6jAVXNsKvr?=
 =?us-ascii?Q?MVcnMR538amBit5hSo80DU2Iq+RH/IXEiFHPZuc1qcpKAEaaozhxv+K5CK2g?=
 =?us-ascii?Q?qyd/eJZi5Bg8eVtxmKnyZZdlgYcUKqopPD6sBFzs6lW1OPMyKcfX4IrlJ7PE?=
 =?us-ascii?Q?GQaNoabc+Q6/Pqlkyjo6kNzNMAVxvtG5mfkiMzU1RTa5VnSMn9Lk6Wq3blYx?=
 =?us-ascii?Q?OVPEMBcVyx9E0aArpCmyWN5tUe8t3klBOjQyekJcr2oMJhnwCkKBzsRrB5zD?=
 =?us-ascii?Q?cnseX5p9rfrXoKXL10NwPFrG8u4DANJWU474nRabtxieD3eTfD1vS1W/p37/?=
 =?us-ascii?Q?pPyrDfiBF92djDh6NbD1c91uDD7Ywr7nYNDKO0MFi1BVA6EJMAj2CSKSJKaN?=
 =?us-ascii?Q?iHv4mB2zsUafUT/V1JZo1zOvy4qd0gcXDvIukNm5tWs9M2GGeVYR4+hawlvb?=
 =?us-ascii?Q?izDa/6gQWLwd38uTw8aIPMtV4zFBeYrm7HA9WwhiWCzSrXWLUBJ2Z1G50YDp?=
 =?us-ascii?Q?5CvMXGTvdTYQ/GHzU85waXWVejElueAB1owbLWZvKWoou9MJ5i7kZXaYiGb8?=
 =?us-ascii?Q?Ca1hbS8WfZBOyIUlHi2eOJc3rDBq58wAJmoZAvrIbEXcOr4KY2jOca0jqcEL?=
 =?us-ascii?Q?FGrm0eEakn/QVgLg3PA794Zg2UkPpf06G2f26R9o/kc/QDI8Jk+wojsKxZ8K?=
 =?us-ascii?Q?cK7TykBNviUYakotmcw6YjHnNpyGqN1P5Gtnlc53HL7qH4KPByJ+FcacvZsi?=
 =?us-ascii?Q?Zl3I6JdBGPXCjgBXRtHjASz16E283dWvnb5QE4Suoc82ayHxN9XjwsVZFUiL?=
 =?us-ascii?Q?VGLM77eLhA+eY+1JJUKoxo/kLGHxaKlzyQrmJU+HgXJl4K8b3p9lg7koRP10?=
 =?us-ascii?Q?OmGyUzBg/EnEHj3eLTEwMfRAylCcFGPLm0tHYkfVXwPUeYrqkLSemM/jf1hd?=
 =?us-ascii?Q?FUmMjHdPIscqCgZwTFj+PLVvsXyXt/8RpwKfhfljqxq09p89qqOHX31u8B18?=
 =?us-ascii?Q?Ag2JvhMfkU2vNypFlUAgL13HvMQl9bThK2/5ln7hHr1JeFVE3sJaAYUCN2Yw?=
 =?us-ascii?Q?8ER1FHaI5nnC/YA+j1UofP291ZvihM36o24htfMkd3zZa6nWFQc23pOq9L3s?=
 =?us-ascii?Q?4vjjjLcmXRgZg0xYpliFbanV8NelaI+P499WlCm27k/Yu7tg0Gjt/bysuEZW?=
 =?us-ascii?Q?qDAkIPEqNhUkUQJC1ly+RBAm3Shh1KlsSXtBFGMrA5nHAJBCNPGZj8fRVGi7?=
 =?us-ascii?Q?RvkdeqBdKUbTXzYkCmLiX2hhbZXNqvDQroC9e8EML8OwrYyMzg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?URzCCXI4eC33h0+EfBAc0xv4iBQi6x/s3O3cv3QMoNFQwcfNBc6tBfz3LHfH?=
 =?us-ascii?Q?fjZFmFGywKAp2B68vIUiRKsxQD5F7rf3DoIrW/wEZGmFNHEewOQK2ChRMuw1?=
 =?us-ascii?Q?U3M/Gt5dYx9DoI9Y6mFvVaEbaUUSAQ0UZ9UQNPFhyShPn53o8mmpYeN8/C9l?=
 =?us-ascii?Q?Q4eOG2P7I/BXiG8ade+mmVzLSV/J+opbUsSSgltr+iDJex8Me3b6LXIhMy9X?=
 =?us-ascii?Q?jTW9x/4MuGtWy1h8HgMoL+SVKuDxZzJ5dwyzLP04+RSHxTHlMfsp88Z6KjZH?=
 =?us-ascii?Q?VHWsuMyAtjokHzKegQvBApNWpyxeJx2X8I5onsNv6fw+savFGa0IiL5MC+G2?=
 =?us-ascii?Q?yN1KpoQJl0yLzeEFWOXqI9qoIt3GtW6apMnGdTst/xsyULs5aSRC+62ZqGX3?=
 =?us-ascii?Q?6NxtoClPIJlgjBUKR8vBo2vNE+WX3GiJ5aobZfMYHmGvQhBeR0Gh7EiQylE4?=
 =?us-ascii?Q?Zr+o+1UcxOWXIECd+LUZMtaxVxPs9HguPVyza4zAMvfFkWr1qfa9NpaDpf4m?=
 =?us-ascii?Q?xVOYFVYuPLbMVT8m2HR5xQNFd52Dj1h2uBJW3cq5BSzi71lIU4wF5uP3zuLn?=
 =?us-ascii?Q?LrVETYZp6Ic1/Ue41g6hkusNukyE6ljXwYqwaCF1XIiu+rnF32pDTup2c8C1?=
 =?us-ascii?Q?Y0R8J055AEXDZCMh+jnhlIR3/uoyS96nJcmZZBrhhlqNjSzjuRnncXVGz6wR?=
 =?us-ascii?Q?lRMsSDrQawspDfCQVpnTu2WNSdOGE/lK2zuD7sb0wZDskBuWIvlxTHx132j9?=
 =?us-ascii?Q?6J2CmzwUcwdTzmx8ezVjIxGevw3FbiB0LlrRAKR7ysakAnKB5rgiD5fd9jk5?=
 =?us-ascii?Q?YlbqGmLPO0S3aSoE1REdRZz7m2GbblAFDk9QqluC4v8f2IMkTU5MriXMt0wD?=
 =?us-ascii?Q?qyj3Q9R6HYhnxUi8CX28hsgWPsFeWetcGTcLeFfK9ww17RbrcW7Mz2bce0AQ?=
 =?us-ascii?Q?JbwnEYdT/yMmbKPw8tbfl2IJJEViGgtnTFevfrn1JNQEWNF8zsHp8NZiOcVV?=
 =?us-ascii?Q?8gMG4vftYCnq8WZ2XPKuO1xwj1yMCrIlbwz+bOTkM8WDxlJsd4xTJvUl6TGA?=
 =?us-ascii?Q?SQ5GLn1wxLE3TAAY8BBDOJ4ryep0k9F1enQXr2UYcp0RdDH0Nvnhs5pfu+Jc?=
 =?us-ascii?Q?Lp9uACaHgeyTK3NKxNjBrPCiq6IMGxizBqiXdkR/BzS4zda+IESOPMxg1ogJ?=
 =?us-ascii?Q?VU6Fcoi8a+7zTbNn+K/sYV6SnmPu5l7HQjPNQDckSoV8jgBaveOv70hjbMgw?=
 =?us-ascii?Q?Jo8n1crIqCtnbHDhcgFan4fNbSBifL9VBT19hr3j8bqryNDXwsvLZjWFo9m6?=
 =?us-ascii?Q?QIyxTJcXUbp0AA3B7myVgVH2fqDhsxsTc4vh6avyj+7MBxWbef3PdEtKwTHr?=
 =?us-ascii?Q?4po+4pyocbnLwdlQgAHQ2fpJ3wCeTteSS7+8azNjRLyhgMH2z0lZ/umDt3c6?=
 =?us-ascii?Q?MfREH7I/9VEWnt96u/cjbFf/5yRRVGuD3IAOzho4071HTKQDpXXBt1ur53Iu?=
 =?us-ascii?Q?9AsO8r9THfyk8hClLPypwJBlohAmRzh2EqpG+XfR5RBQFERRJog8NUPkx26r?=
 =?us-ascii?Q?G4ucK7Jf9pzXqGn2TxnnNvJD0t7LqAHWVcHXwKmiJoTq880qgaeLYhbk5Rh3?=
 =?us-ascii?Q?Je/DWK0QcLEKn3H8v2exx/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDEA237DF1559D48A95255E323D0DA22@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	phxGcTpyZmAp/nRPUfAFzm8ksmXbTRTdPkTRdS94d4VxixlLG0NN7z9oQbFX7GnMCNKYadaC6LLBMlOXVQtiJskp0vRno9OVZ5TU68wLAUWVXB9qjl53/Kikj9xseQU2vmExcyZtVWonO6MFWKwmyydRYISXtPLxMoPRDErsuCReYQ9dQvqmh/UEk3JgE2MvQi91/TT5uCDEV18Fn07SkabutfQjKwRVZeXB78rZXn5q4mxyUlbPld3TCbolZS2VeRvFR2Hvl+QDMHLMKy1sx5O1VW1fVgnvGPZTNwSCnDZvEdBsnJGTlEi+AItHCp7j2QQMi/2Ti4drKtxwNco/jXKLetnkmh9VhjUHIl7neYlCuwkCrI6uMC2L4lG9qjzkj0uzxljDPl0y0W+ZFoLIQzjfHpQbVn0psdwwTy4TX0MY1cyJXE4CdYkWR9eVOScCUolii+zY1iWBX13onGsMH1fhbkBz+3R5ibSoG3stjWZHTbwF3Y3Jin3/olO4TcqhZlLmXuod8x+CwLr4HUgF3VulGj0RGtR4YY1Aaw4L9AHAdnngvZ0wv36QSMs2aJymoeqKKQwboXxkhgNhGnGZLY/T8fXcpuyTQP3zAo6GaH7CpIzQzY+gdFO87t9xhF1q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6be3656-4d35-4327-571b-08dd19cee6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 10:30:58.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vbq8eKv8c/hD3/WAdmf/7xzQSK0DQuuXXPuBxo1iCZr0Xnlp/Mh/lZF6BxRX6jYMecLF1JKxTJSNSscU7iJ+WeTQe3tDJVTtb0Fw0KdgmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6495

On Dec 06, 2024 / 19:04, Ming Lei wrote:
> The 'offset' passed to mmap() has to be PAGE_SIZE aligned, which is
> always true for 4K page size, but not true for 64K page size.
>=20
> Fix it by adding helper of ublk_queue_max_cmd_buf_sz().

I applied it. Thanks!=
