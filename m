Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0A225791
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737175; cv=fail; b=d/rRtOYr7QbhXYQBCXHbpngP/JGRdzrlfJKA6qinDPQvLwRah92m3r6K4y64tK6RpocUlruk+FRRYTE68Gi74a7L2bjPoEIJYkhNg2Dl2Hlg39dylYw2jyr0gDaz7Hu1aY46I+lPbS/aLCKQuPi+s8i+amelJeE0RJ5d+VQ1vjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737175; c=relaxed/simple;
	bh=UHTwz0vMHjWP1LzWU8dIVa165sNLthTAZcyVd1IYOFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PweqPTuxIwRM/Zbu1OFT0KuthCKj+pgphUquzcOPsHF55G4gQla03UXIChGS3m4BCZRMhEisd3JSDgXBPNqOnL+5HN5PigMGhv1tdTrEPXTjbWO6HwgYEVj3/+Yoktuh3jCoi5AZ00DhfkrNZ/35L0s+SDQNofs/Aye6qJglDbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T18FQOY1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JmT/9Kma; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T18FQOY1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JmT/9Kma"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752737173; x=1784273173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UHTwz0vMHjWP1LzWU8dIVa165sNLthTAZcyVd1IYOFA=;
  b=T18FQOY125WagSzPWe+jWkBS/vuI53Gfq00tRYN3EbITBGUSDlWruxvl
   pWPuGFdvZCAtiioNH+GTAYU6vTYS1o22AlT2oHN5fNq5lXqBiJh6a8TBd
   2WzbPwq10MhANWI6J9om69Z2ifACJK6JwkPzflDNPHGBLM3uKbsm+jV+K
   zlcAL29N1ZStOfTIE5/nkYBoF3idkcyLPEXtd72qdY52AChasFdEwcZoG
   5lCYcWpqkcepYZUITCtCJADrTjWfljXGVF0OsD8dUw1pPMW7+19XPTfiP
   OUzNVIwIb9nMuD9UOcGiRD5hZLbgFrO9Nr/ydYdUq31iPSNnFclH9a+yO
   A==;
X-CSE-ConnectionGUID: kqAQNy/xQrObg6bb5mTmYA==
X-CSE-MsgGUID: gyOiFVdlQyeeMACMPlMxwg==
X-IronPort-AV: E=Sophos;i="6.16,318,1744041600"; 
   d="scan'208";a="95344752"
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.74])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2025 15:26:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXaCqwLwicRBZvPUzEILjKVCCOeJ5q/6qDe4bTHoURNtruPUwUGKSvt5n2zgdKt/Mpn6+AS1iSRZ6aH0svmiylak0ezpS7rVmqyrpsIeKPA5xLkCfQQSyPs+a8opm01D6Cww6g2szcTb+7kZ3yPOktMJyEerqwsLO3/8LtzQ8AyB3z75A/Kjw8rlqy097dEmQR/MFsMgCK34GFia4y9enJib6wVoEmI0xfr+iRIrrm8jgHZpiTXDq1cLADUzOo4ibKfBhS/sWk5unn2KEnZR9tMqpceYKLt3wjKr+S9K9nepcihUxrWkLvo1WzuGwjdzbbVtehYIYavpAo+sdS56mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA/t7F3D/t54HiQK3WcOTqLy1sbXUMaUvvw5ZhSfVcA=;
 b=We2Uye4OA55tY2MIz2wYgKWvjbW3jcLFR9sOGQBqd+xQSA1oUb5OHFBpiByfq3beJ4HEkOzwaDEcrL3bJLHXOHnxGXmuUSMw4UenfNamcSU4LSm8+kGnKxDEQeZKQOMXV53gXtzpSM1QxuCME9ek6H4TSJF7Z1aJxfqL8FuNs3G3SMmExPdn3iCMiKhziII9oeKz5b0J1oEEYatN6HGBMK+n1WOrlGe1iLQ7RJWZ7KM8B9VvDHSrcWrIEYu3cUixdbIW3BSGmt3p8zGKPoRU5m8ugiISAxtilTMQGzihk8GJTONHOkpYRW3gEl3Zm48RvQcdD4mn9ZB6eBmE4NYORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA/t7F3D/t54HiQK3WcOTqLy1sbXUMaUvvw5ZhSfVcA=;
 b=JmT/9KmaDyVDnwPzMBCsuGlJappt5lCF2VoO5STBXW0f9MzcNgCHtvhX8tDZduXrW98ZHERPAuqyxD90WnyHVuedEjAEKVyooozOLGbD527JWSmioB3sPmsCNVEwBnY1kiAW8i8+M8I2cS0r9Z6facLzocaeLULWL0HppeDm2T8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH2PR04MB6695.namprd04.prod.outlook.com (2603:10b6:610:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:26:08 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Thu, 17 Jul 2025
 07:26:08 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>
Subject: Re: [PATCH blktests v4] md/002: add atomic write tests for md/stacked
 devices
Thread-Topic: [PATCH blktests v4] md/002: add atomic write tests for
 md/stacked devices
Thread-Index: AQHb8ko/U6M09UwFuEqvjdlRbW8gWLQtK1AAgAjIOQA=
Date: Thu, 17 Jul 2025 07:26:08 +0000
Message-ID: <2mfbhe5a64wqatyyl5kvfzjzisghxflxzuzwvyohgfwke7k6jv@7pb66vhuqctk>
References: <20250711095734.159020-1-shinichiro.kawasaki@wdc.com>
 <74592189-697d-44d7-a29c-bd6b246bc2b0@oracle.com>
In-Reply-To: <74592189-697d-44d7-a29c-bd6b246bc2b0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH2PR04MB6695:EE_
x-ms-office365-filtering-correlation-id: e381e393-5e3a-45d2-67c2-08ddc50332cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VLWAeY8WGCss00W0FHxMVDB7RuHyW6LrCN4L60sa6h6ULgHxlfmxJ3r05FVi?=
 =?us-ascii?Q?XjqCd0+oOQqeWMdrkY+Zsoppv5xEeUuiv3q1AfP4Zxq6j3QUGQNGJaG9nNJf?=
 =?us-ascii?Q?GY9UmlSonV2EpW5ZZAJRuQyX2pR0kCsQer//8KAKXaJfHq2kuPTv+tdnQAlB?=
 =?us-ascii?Q?Ul6l1R3vxKSzKgg76XOhhKDHTO6EB8kpJjpM+vKXDvcqT7eWDnrQaIRLJhy5?=
 =?us-ascii?Q?F4n69P7En5/qpldc4/KVJZflDPcbUowSkuGAYc5bGiICgHxs+x51s0is/NGC?=
 =?us-ascii?Q?rnDzMkOJvZ/mBluqWtmg+DAUi1SyqY66ab4ZnmQPcTcrgjT2eau3rmOK3KEa?=
 =?us-ascii?Q?ABIq8v0YdKDGv5SMdb1IjfMfMe8ORt+YEafF8Ja+NfRNKS0sW4FR53ycH0K0?=
 =?us-ascii?Q?kmedYHm5pHyMhydUB6k5fhiKvr8fQjbsvDHPgUpUa+VlWuO1BRXy9HQ/5Q+t?=
 =?us-ascii?Q?jWbSJSW1S4zLWIDrjeHJtKwJQrObABuvRy/1aK8Hk5RU+o93mS/v51oWeCCu?=
 =?us-ascii?Q?X16uw6r3CvJbmswX/qV3hFEt7QNPzEjgbUJme0xyR5inVH1tjgmf0dxAT49p?=
 =?us-ascii?Q?cgurJDkpGqI0Mu00oP/aWQ38yAGcGRF1SPrRHxiVHoPlsrLH88XffMJIZaiG?=
 =?us-ascii?Q?pdbn0xaT9lNitxJaCbUYhnFg9s8VFnyX5DAPQaXwlQooBqfdk3VHqmOJKjqA?=
 =?us-ascii?Q?RwxGMfQ8x2rVEK20fNThWaHAbQNZrQiu5vn3fDPIlJO9GZLYMV0JL4AbxPj7?=
 =?us-ascii?Q?4fOunTSz9k7cuoRrC0ybfbe9cm9xhAT0GlnObCnQUQ3rHa6c17wUcVhK8wIa?=
 =?us-ascii?Q?Z+6NUti3QJNgdocX5UJQW31UkDCZ8hc66wGqvlp118Mel38cEWvs5AKap2zj?=
 =?us-ascii?Q?aTy1ALJTzE/8ZhymImY1GjLivt2iJkMgriEy6dP+IsyCjmjRusfS7FCxZc0b?=
 =?us-ascii?Q?HT2PM9kv0PvgtDkp1eLXWA3LdGLyspvkTEjHUOBei5H5kR9QIF2ZFkH1nqWq?=
 =?us-ascii?Q?hg/XAQLnBWkeTfn8pOpCtZidYqgUVBBVxJmpiRUEMv9auN390de8Z2/aSbni?=
 =?us-ascii?Q?ADl7a9mZJscNHV7dWg8aNd0vScgRI3E7vm/syjX2ZW8qdfugf0+5EclLPGI6?=
 =?us-ascii?Q?iYcYhHm53qSsW7/mxlMYr733pAoDTpdQ8uLio4ouKb9aTAgTQkc7n7TvAKGe?=
 =?us-ascii?Q?IMz4rIE/fuJIJbAUAhxUjJjcPQ/ibcU1Hu51krhk+mnY3hCUxbKYOL2aB8xV?=
 =?us-ascii?Q?wSsaiXn7H6xXW5a4EBLJAGOdi78ap/h32ixawX+w9M3lEAGVDa8V9DbBM0ux?=
 =?us-ascii?Q?IWSq+GKhsdaVmV9CMLzkeW//2PZZyMyQnqVHHqLxy6YivTXpEFKc8LbxLCVt?=
 =?us-ascii?Q?c8nizZRPpAO0rn7DVkHn9NUKvdlquwn3JN/NmB9ktl+sv2icDrhCl5rw3roD?=
 =?us-ascii?Q?HGpdAGZa3xHkunFweLxqxnqavlJaspAGVfzHDirxqcMDk81K31yh4g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PR8TNWMHniepK3GeFoNdVX8E9Zd+mpTE9lq3Qys7Q+2IwBlz2Z0e1OrRJkWI?=
 =?us-ascii?Q?jaPG8aK15+IbLieiPh1RcZt/tzjQ0O9C0VZ+zs3eAuoHJzUdFOoZg22n+uBh?=
 =?us-ascii?Q?iyRTP7jqrzbK45OD5pMNCqoepd+IahBgirMFzeAs+DB6St2viLubTZdT5ftP?=
 =?us-ascii?Q?D/0snRaet99ExNPdV8up6ipjzprM+rkHv6Gvib9DsRb3nAHUfOZ30PEYpt+R?=
 =?us-ascii?Q?tsrZLU6u3MUEYt+arn3oI46Gqcj+j2pozJWUA9VO4vbLcTxy0UtyB9aknHjz?=
 =?us-ascii?Q?K9v8ngNI4rGzfb851uBi9Q/bJAmASDjrzXkA0HD7ySEi9L6Z6pVQKmbDBDyT?=
 =?us-ascii?Q?Z7g5xa51c3j2ggGCEggr4uAg267J8VaCsioB25BPnomR/SrDZWNcZ9klBy5t?=
 =?us-ascii?Q?0cyG9LtOZ2+HEp784ko6QLUpG0B1nkfBDJYMtyOMJZG8cgX9A535TWsecxyA?=
 =?us-ascii?Q?NBBmUlVSIDWYwTA+ZD7oxMcA12ZilHew29dArepQ9PBvwHAG7dgBdLgPzTxR?=
 =?us-ascii?Q?8oeCRwudyfEy8n4khZRBxt6XKowJCgNiCsHua6KUo1crFxjGW1spVPGUEwSJ?=
 =?us-ascii?Q?N6r97uYeYfySBgrHu6N5cjIhvIGLmFrD18u259CjrfpBsFfK+I1qkIiTQw+a?=
 =?us-ascii?Q?THJJJvZfvrmgogBg+pPxSKW4T/dsS0R4PRerxWF2mBie5N0C56pmranCd17b?=
 =?us-ascii?Q?MdZEDua/CZl6g2sfOBPTULQ061IFVve3VyZNwMwy2BEUPuUkjQOZH/xAq4Fj?=
 =?us-ascii?Q?+jfYrpGJler5O660EGL2UP83SWd4j+xlPwHQeLuKMXcgsVtRdj81gSpuysxu?=
 =?us-ascii?Q?RonsderJ4GKWHrT69qlBP1Ue8QhAqpYFTYGEP1JfXjhtIEMa8RXgEWnpU99e?=
 =?us-ascii?Q?S/d5D+BAgjpK5F9TrEfHk+ftK7CNLTB6rwSk0OvE1DOCejdeuTo2bdH9C+3u?=
 =?us-ascii?Q?Pt9ZPqZXyeGiBSAdNcIGjtFD8QD9smFBB+NZ3ILq9NsWTt66uv4tzf1NQbLZ?=
 =?us-ascii?Q?djWIAivNtPiifVTiUpdh1tqTf3OAh0XVC8tEShCNXnjt1aBs2kX7zy8AsSdo?=
 =?us-ascii?Q?9VMHoB6JOHD88VN6R9su/YG9dIguyvWr3zK6hf4ygexHj6kdDj6D3rXTrEg8?=
 =?us-ascii?Q?uZgP0OSwgbHduprjHk6fcK+Ro2/punUy0kI9XPzy+jD2vxZHXImfVisLvrs8?=
 =?us-ascii?Q?0gMhse84Sa3rebE/9V2HL4H45R54yXI9a5CvSp6nluUva+OwTYNWnqyQ0+f+?=
 =?us-ascii?Q?8zoqnA7Stq2xnyKlcDlpjNjUyEp7Ca5tjE4wAL6qP7McFd9y+UssLqiIzr6y?=
 =?us-ascii?Q?6wlG7v2nn+KZCVUirTrFe/B/HsQFe0xywyZlCJXwTbutR8PmNfbnTbW/7RVU?=
 =?us-ascii?Q?lQv0Af0yqfFCfsXA9n2D7Si/57hHvv4ifVa72qTn9s3m+tRoJ5TkoixSAeZ3?=
 =?us-ascii?Q?7Ik2urWXU9VMTJ/Ta1+AC274tESjl6AfPz3dm/YLW7T6B0jCZDktKBy/pzdS?=
 =?us-ascii?Q?2PF55qWT5cJx/oThvRb+Bcq73SCiLk8hHRGOO43TbR2myeWzpsSopYjZpYZx?=
 =?us-ascii?Q?+lXCGtqnYc+6NZHZ/7PoyLdnnRykFH0JbipUsdraSYEWZ1JF5gu8KLvihTDc?=
 =?us-ascii?Q?fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E21168FA783EC341BF9941B23A4428FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q+D6+cb/fxkXHKHCP1DC6oq/SVHGm1ii7Nbp7WSAJXYzyy0KFOhouG7L845RYm7l/JF3Sn1u7W87SgqitmHL7k97oTRq9VbojzB0ro7Hg+Po0VYMNbG5fxl/VDeEdHcxcuHOk8djdu5JeLJX6tGGtCLqEXmFd+1p4hutSXtePpTOxPwohlDJfjcM0F7aiSC6hFX7vidO/MIviA2udTJpnr0rOJrTS0KVMsJAgaggZZr6SViLDBIem4FIA5uBmmxEHN5OtXG2rcC0Wbi6oXKN+q/yZaSF0ak/JWn/ZV11cD/sfJxt+fWmkWy7PrDWWLe56RtGKUrGeH4iCnZHbBartRVpKqVddy7pIrkVLOdJbDuMMixTsjlpJK3usR6Hv11AF2YdqZS8faiKnZVNtW8UJ24yBJiEgl8DVgGr84xRG7yu3uoG/Vlh+lcLgAfaeSmkrW2jFlDv3E5VS3NOCrdL3DECAffuUpnT3I64ySDzP/tqgvL4HeOPJal45RMK1T2DK9WTi/JWvpYtRrK3mLeNI/Unjpro2pkASEdkPULMlernykYYrWU7e9vhKZZLIEB9WSsYckuPL6x48LICaB5a57b+wnu+fmz/MB6ZMFgUQ9AxT/L67SoTvUKg/R3qm7+Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e381e393-5e3a-45d2-67c2-08ddc50332cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:26:08.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2vQpoHbhK/G+UovDR+tkRu04cSJ7hYh4XxlKNyNemFJccgZTcZILgo4rGYuEMaPAw+w7kc4cQnqMIp7YAgaMUdNlTS2uVhsplwBUVdu6N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6695

On Jul 11, 2025 / 10:19, alan.adamson@oracle.com wrote:
>=20
> On 7/11/25 2:57 AM, Shin'ichiro Kawasaki wrote:
> > From: Alan Adamson <alan.adamson@oracle.com>
> >=20
> > Add a new test (md/002) to verify atomic write support for MD devices
> > (RAID 0, 1, and 10) stacked on top of SCSI devices using scsi_debug wit=
h
> > atomic write emulation enabled.
> >=20
> > This test validates that atomic write sysfs attributes are correctly
> > propagated through MD layers, and that pwritev2() with RWF_ATOMIC
> > behaves as expected on these devices.
> >=20
> > Specifically, the test checks:
> >      - That atomic write attributes in /sys/block/.../queue are consist=
ent
> >        between MD and underlying SCSI devices
> >      - That atomic write limits are respected in user-space via xfs_io
> >      - That statx reports accurate atomic_write_unit_{min,max} values
> >      - That invalid writes (too small or too large) fail as expected
> >      - That chunk size affects max atomic write limits (for RAID 0/10)
> >=20
> > Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
>=20
> Looks good.

Thanks for the confirmation. I have applied this patch.=
