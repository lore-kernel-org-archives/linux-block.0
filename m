Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDC20E318
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003617; cv=fail; b=BUUi2lEGmKUwDdjx7Pv2isZhSOyBDnMSvC7lcQTXWmQh28PYAzuTZ6Amu0wUqlDYcIJH/Sn3lYJG/wId2H4/IZeLqSlgeMNyoVBUoNxcwXM8VtFz5cdSeKT6PSreWNP7914bJZrmCAENJnxdown4IqKPEhEAgCPpgUMctNp+DiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003617; c=relaxed/simple;
	bh=F1r6EB1mIUtoVt+4koeDIWNnG/iJbbn9NBvbTvxIKkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KOIwrckzyDrZy8AvXFa/xCKIAclirzcadRmihDaUe4gnWNyWZwLKtSOHTj1GT0Y5y5lJBpsH7lQMYCmviygQpUNq3IPhU2QR7VYxGzgb0sr61xmFtucdPLAPHAdr4dXuVRQdUahzXYMtiHy9Cn0NoMCaG7lIrHhdjLXzxQfzN3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Mb3w347e; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JOADe4iH; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mb3w347e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JOADe4iH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741003615; x=1772539615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F1r6EB1mIUtoVt+4koeDIWNnG/iJbbn9NBvbTvxIKkA=;
  b=Mb3w347eM+t6jcbDUZjcjrr2I0PmvaBVIs/ITj8Z4rQDy7xYJqS8e2Wi
   P7Fr0Okwfp1717Gox+zuSxugFnWTs99Y9+jqgudrOSEK2D3EPNrW7pUub
   WzQDT+X49bs39O4Es0pknzY5kFfJOzs5d0kf8WguPQaFqJ2Asf6rPBUOV
   ST40PbFNre9TaPcR63+huqh72Yj28PK+0uAxsLtp2/6YvsOhMZ6eN3PoY
   AX9hV7SYBY6TYfVGvEICNIgLBYPk+T5R0Rq8B0w5sE+F24RPR+rhnAkhx
   xJ8l0HJUGPBzAd5+SmZh+LxNU5sLhnwSg/Ss1GX7lKBQC7IoVoV2gcQO5
   Q==;
X-CSE-ConnectionGUID: 1gU6S3GuTFy0069JpApf4w==
X-CSE-MsgGUID: BNtLri8HSiSEUneBhQBJzw==
X-IronPort-AV: E=Sophos;i="6.13,329,1732550400"; 
   d="scan'208";a="40662964"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2025 20:06:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+x0kop5t9HQjTylkmMx9bMaaFtDlQ9t94GR1uFpxjzFamCHJsitNc1niMKciKXuhcSKwUmkLIn8iNLcsKQks4tRHYcQ1qmtH7qfbJCV++fG374qAqSBXbyh/O6neSaTT867Us+cm0HFt5O5h8eurnVuwlw5xQqf1Q60gSJFOY9Wyyxee5AvPo2y7Q1fyxzDa+woeSm38HR8KLl9M8y6J4gKTGPDrRGPlG+R5cKLikzi5rOfaokfuCcBmr1MWSYDfzotFt3WT+Xf71hKZAsUNs+nDbWLINoaq/yMBfF92SZnUDUgumUHG3H4Ca7RCuIAi9CRARYzW4ViJAqAAy05cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMxOl+WuJdL88ieBzs/7k84Kx2xUuSn+Mv54Zbkpg2I=;
 b=pukPqV0GHJvCBeWb7VN64E5Ca2WPCL4bjqoVVI5uHfmMLTJcVFOHtK8qttnxhEoM+MBdL5Zw40rH3Dgk1wQOByA0W7FsoDmSvRlsAtONALu8M47eKZwk4q5gBuFj19Ghi1Fasqj6Dm3E1ANEp0Kp2TYJE+6PXbAs4JTo9+zbWrIUP+UQERFqLudVt4zAD7pT9GTzCFat5O8svS8EW8Xj/75qvw3Q4rR2fyulmYOsfg7cvPw352+vfinDFZXU3McrSDdolVrkSNhcAptkQmE+s8ue8CMaO62e1DIbrjdFF5U3xVEXNxv5MLrW29M1CjhQhE4jjwEdgSbTrPC555G6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMxOl+WuJdL88ieBzs/7k84Kx2xUuSn+Mv54Zbkpg2I=;
 b=JOADe4iHhtDOVSacH08ikBKOWf8QTFZeeGhsGpKY3zLe/68CdwiYxaYfMTkH4JRSwf+oRNYvotmqrdCjIh9KX9SjM8jZMjePjJuzNm3NOotq/wfaGi3oniyGiTsdDF6PiiVoB3F41LOGn1Ak3bYYe1kZT2yL3CRG3klG8OW2eeo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 12:06:44 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 12:06:44 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yu Kuai
	<yukuai1@huaweicloud.com>
Subject: Re: [PATCH] tests/throtl: add a new test 006
Thread-Topic: [PATCH] tests/throtl: add a new test 006
Thread-Index: AQHbhqLif5OYH4hcJ0itAiKb9FdBJLNhXC6A
Date: Mon, 3 Mar 2025 12:06:44 +0000
Message-ID: <ddvcm7qzw3wxx4wrz6partrr5riobvna75vgcly5cxah76cmmd@w3v3k5yj4daj>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
In-Reply-To: <20250224095945.1994997-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7122:EE_
x-ms-office365-filtering-correlation-id: 9dbabf94-8d4a-4d68-8ab0-08dd5a4bddb9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sWtDxcLSXDVs0KZOwzoxPjWFvqq/maI3p2sSiuhUk/awdL6BnLhCG6GZnp1a?=
 =?us-ascii?Q?otFpvqUz+2g///BEWFQpsdMFe7/LTaaPaE4pFHvRfE+Rofg2dHlEc3FslxDz?=
 =?us-ascii?Q?v1hkKBg+Vf1sA2WVKX3emPAbftnJZzikU5vhQPoUKT5Hzn5OiTVQbYwkNd8J?=
 =?us-ascii?Q?/xS9gMEEaNXUCjLAp0KK1wFSXT/M+z+jpq+YOhjoqmB/BGboBVzZg0P8qTVc?=
 =?us-ascii?Q?g4Tff21MW+zOGzb6TGFzl+QuYEdbxZBJKjo0j/wPfpYZStbsccKMLmK6cm2r?=
 =?us-ascii?Q?uElJRqQiy+Jj64ig9ZAiWvJ5X5JT0I4GfDp4nBPOB6Zw67EOIHhdWWwo0jc2?=
 =?us-ascii?Q?KGzgguq+KowFmyjCg8Sv/pMHct9Tbcoemg7XmXmBjzm14vIO/J7R8HfD1c0d?=
 =?us-ascii?Q?nc3MG6CM+ICF9q8B8b/O8iQNPyyex0s6y8q7dfms9B3LRKF2PdeDPLIwaRcB?=
 =?us-ascii?Q?x0EaFrhodo9vQcu9C/+xEcLzUzkdOYNrOFg7cALunD99xoW66wSbkNaQWcYs?=
 =?us-ascii?Q?QcLlY3pWkZHkoIwIKb1ggjdZCNS/VxjwTGEWtxg6GsDZYc2qND16Q/0JzyGm?=
 =?us-ascii?Q?1/LfxB49V/D7vwt57fzfVmu8rMA0R2T4gwqrcr6CvZZn4hoS0vh9jIh1vvOF?=
 =?us-ascii?Q?Rz7Ze7gxZrcT8eY4gS0K6S0/KjgSuBjHGHlsPTZ2DRCtwJA/SreitfJ2BWWC?=
 =?us-ascii?Q?6IJyKbaAlMa79/rLmmFoHYXHLoLfDYc8vI2Spny4RzS5chQ+TgRcR3hV8hbd?=
 =?us-ascii?Q?aNbSghDOphrkfoRF7bIPUaeDkp39QYreovqyIYYno+/VaL7Sra1A/Eo/r+8K?=
 =?us-ascii?Q?r3d5z7eNSZReKXJfoMqfbQGfP23oGdBSHzhWiED0X/2j2ECP4g+XnaoG14vL?=
 =?us-ascii?Q?Om5Ii4nFEAjIA3SWQx+3iWCdwdLymAZkvfbxIQYR4yYizUxV2gMA2SnGALfj?=
 =?us-ascii?Q?aGXrbNJfRb2Lbfzl4zHOG9E2WxSCmnqteewaQj/ECmxWxNl7K/nxkWeEzfrH?=
 =?us-ascii?Q?m2euOL3+cHy+chBSX8dqX8/lR1E0m2Cp6Afz0V/tUsyooKXOEOSdexkfNy0x?=
 =?us-ascii?Q?WW5qPx6+v84JXxbdwgxEykMIkR0NTqWIYw981wpRQUjQHVDF4jV9sbM1fqLD?=
 =?us-ascii?Q?VseW+ZBCTPMqdmPNKgBbnzyNu/52Y6farx6qkPk/KTF8gmcg+kO4EBbgZs6e?=
 =?us-ascii?Q?RtAc8/PX7InFg18Xhz6sPatx+ATGndemOhyYurRFXOssvQJrlYWraIQlq+0N?=
 =?us-ascii?Q?IZMAD+rRH+UgSZSGO9jYjYEWw+2peVpHlWu7QjNiVEluA5nDHS8QLofG3GfD?=
 =?us-ascii?Q?LMcmv8KtnFt/uDVZ/pDwYXPy0NzpwcIAzrr8TRfiWNzVZcJ3MlpZORpCUHx3?=
 =?us-ascii?Q?1GyWWIWOpnULCPhGtDfpnr0bVTd6Xm1bLc4gjgRrFXKDOziVVzGX6WswoTzD?=
 =?us-ascii?Q?0TyMWSiKnxaj/ggXpcqKpPdSO5ByarVY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6yEeRLgGJ/6tQN9cflE5uGG/ry6c48bFmnqTfacqR2bFHbe7IbkCyiyhLL8p?=
 =?us-ascii?Q?FeM+lTOFrHaawOLlW1moik7O5bsHOvvMuzlgdd145kFojcsMFasCymXY09gm?=
 =?us-ascii?Q?Y1SNMu4IYN+lXdFlWzmmBYGBxULAXYvUWOpLDSubbN7oKtDyr6FtPPTUBBxl?=
 =?us-ascii?Q?kuClaa+0qZGk9PvpotZ+b0a6uD3fwHmrg+DprFwFYay1gPaq8ID48n5r/iVh?=
 =?us-ascii?Q?FaUXGFrCsc8ypRbbadboO7r0mfi0JJUSZbAC+EcCd5n4JUpo4AT6OpV4uppX?=
 =?us-ascii?Q?sUEV2dc7zHcHTK+EQhqpc1QclEVBNSLaO1tDkVbBE7NSTwG1IGJJZ3gtbyFQ?=
 =?us-ascii?Q?4XeOjajLE0ptQmswUJ7uedBa7t6FOV1HcWlYKADVXBunP93A7PqMlj4oM2n6?=
 =?us-ascii?Q?Xw3MkfTTWcXNfQgbTdZ9BD4AmMZjGgHTtJvQ3yXwiv2Jy1rmMibP1DEPAAP3?=
 =?us-ascii?Q?uJ4M7MTJ8ZG8iqJAFY9FPKwdgNUrmP90HAfxzuCAq6cDd8oGQoBtZOV9b0Rm?=
 =?us-ascii?Q?ukuvme4O9JVFlOSwr5F1vL0THjWUuYscrwGzfUlkHxQAfld/crkxd0JMkfWw?=
 =?us-ascii?Q?GvzngVwvNOyj1CjRjcyVbdImvyi7S2sZUvoH3oYsZrbIN91m5OhR3anjKSfq?=
 =?us-ascii?Q?taeCXkYWcm99YZ9wmPxPMrMlT1RytLL2wICJ3QU8rs8J+ufwMH8VH6pkKZcB?=
 =?us-ascii?Q?0OvLPCecVVfgqHjgbU2eP2SZVydbnSK/hgI1ApavRPI333O/OZlUlDgPNVhu?=
 =?us-ascii?Q?fSvvZhHvDanHEDVogirDbIB1N+He6UkYotMDk5Dss6jb0hPurmID1Mra3gG9?=
 =?us-ascii?Q?eTsOZYshzlOVqL/4MzsPCrYR1sjCKEQNM8D2Cha9MBcyzpWlXjroHr7uX9Bp?=
 =?us-ascii?Q?vc5xMdlh4UPFEFbpmmX+Koh6Wxf10Cudx1FZzbOWFGUYYiGTBiiPBwEo5WkY?=
 =?us-ascii?Q?BnIZ8E8AU1GEZ51lcTLhevVdQlKA1W7Q5+AvioWwe8yP7sIapJ4+RpZ5+Mpe?=
 =?us-ascii?Q?oUluBkWdtuLrPR7hCygBwA2Hf1ePV2UFMBGFemgY5S3l4ujXH9gwXnu0teyM?=
 =?us-ascii?Q?/YvK1a6Cfx4FHDysnJDUilvZnfaKhQIIWCoKnnxwRH9HE0dn0NDzOFzl3aLs?=
 =?us-ascii?Q?UktMcEEwa3SL0lwghh+ETXnhfe4ijFyWokYJOwWweUfpyIVwyl2NUnsHHb1h?=
 =?us-ascii?Q?M9bQGCvJYqnz1Mu1LkvkmzEuehYvloTHHuOFvqUrHRyFvWzeX8dL46HnEWpI?=
 =?us-ascii?Q?kqPGpXSQFlkf+3rirsGnZrRCJqsIeMXVL5Y/xlzlrAKY+CLvIZAOODL2H9Uy?=
 =?us-ascii?Q?pED9ZZUsS9V2Q0WKvOwoehyQh3AUVqCsxx+h/WYzr4Gko3eaUniHQd4xwxK7?=
 =?us-ascii?Q?6vfEOr49GXl28rHwKvkGYeaGeqLNYVndSl4UA6bH4/WFPPDCwnnqNRROMjwq?=
 =?us-ascii?Q?1NhYhrcedJjd484w9CWDayyv1Fn2a5/VwZe5e/4cWi5XvwGUHbEbPIBjvZOI?=
 =?us-ascii?Q?sX5dIx5x5Ossz809ivR2srIspEzlKTtsEg7sBvr9LzPueIyoJY3WYpWQhJLf?=
 =?us-ascii?Q?1pb+qwPw6qI9/ispWLMd9UtyITMVHNjoFTEnfzwK/3Urgcct3HAryXhWgN7s?=
 =?us-ascii?Q?P8WkGROaE3YXoAeW/WgX4qQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB4A2A682C11C140888662202BE689A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x02OcN1dmjPj0g6f7NN+N86H/ROLMJP3C4YACX9631ibT3iHLwNcf/Ar/4Ire0rP6xYyndA4jrJTHkFR7fQyrw+Q1z1CQgKv4YBR7UIFo9L1QDr01Lx4BWfJ9Vfs8sV9TPcA/BHZxCowxm+bFYeHs3BqgQphv2GTdybuOaJlahXQChyFCH9mNLcuKnOF0/9WWcs+CdPa9VGbQeRHwZsRXmoWdf60DhrlqXu8Tw2EK0ZtFb4Hgf2rzt5sdXHu1Tyo0b57q36ZdRZwDzkMUH9bRyarblvvTV95qPvI2+gK3rQZaE2IVzXvUukkIsoKnkAMnDFl0+HNq5hztf6+mekUejSgUd44lmDtTzlcXgpeW6TAdy8nJOq+uMUHYkA+VoVdz/5lSTsfR8F91PH6oTLCaRaKJMFbmjqj8vcD9J3NQ9fTxBsHGfW+Uy3u4IE1hRy9+aQrzz7cMPGcgvf1dBUCFOHfANKGFf/IVQSY1AwA0mtlddatebqVQDJm5tyxxkp4ALCtTb8hf6p/alkr1w0nQUJ0edHan5AM4ad6o8mdpKXFAghFt4afbgaDZKama4KRj2lIVRWy+5UV0wdkbWQFY/p2bRCS5BUV9mSSE3vuLzS2xReKVPDXjgfBKkIXpjeP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbabf94-8d4a-4d68-8ab0-08dd5a4bddb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 12:06:44.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oI937AQmt8XtuHkJ9kDXKrMBYI/DPG8G2RVCeIZUAAKmq548XIIuRQffhs3L/2VfWBX3yYXeGrDKNfmZx5qH4Z/qeFTWqcYqTTmJRlIKGs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122

Hi, Ming, thank you for the patch.

On Feb 24, 2025 / 17:59, Ming Lei wrote:
> Add test for covering prioritized meta IO when throttling, regression
> test for commit 29390bb5661d ("blk-throttle: support prioritized processi=
ng
> of metadata").

I ran this test case with the kernel v6.14-rc3, and it passed. Then I rever=
ted
the commit 29390bb5661d form the kernel, and still the test case passed. I
wonder how can I make the test case fail. The commit was in v6.12-rc1 tag, =
so
do I need to try with v6.11 kernel to see it fails?

I have two nit comments in line. If you respin the patch, please consider t=
o
fold them in.

>=20
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/throtl/006     | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/throtl/006.out |  4 +++
>  tests/throtl/rc      | 19 +++++++++++++++
>  3 files changed, 81 insertions(+)
>  create mode 100755 tests/throtl/006
>  create mode 100644 tests/throtl/006.out
>=20
> diff --git a/tests/throtl/006 b/tests/throtl/006
> new file mode 100755
> index 0000000..4baadaf
> --- /dev/null
> +++ b/tests/throtl/006
[...]
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _set_up_throtl memory_backed=3D1; then
> +		return 1;
> +	fi
> +
> +	mkdir -p "${TMPDIR}/mnt"

Nit: the long option --parents is preferred to the short option -p.

> +	mkfs.ext4 -E lazy_itable_init=3D0,lazy_journal_init=3D0 -F "/dev/${THRO=
TL_DEV}" >> "$FULL" 2>&1

Nit: this line is a big long, then I suggest to split into two lines with
     backslash.
