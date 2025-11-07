Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8932C325F
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495498; cv=fail; b=S0pP9I6UcDYGggdFkAo0P0dwYdk7whPcmOHNtiMDmU/lzuaqi+Cf24NL4NqATZw23fKg3hLSGJIr0uIhYoN8nb5IFAWlxk1fRj8EdwlK/9n4g8T4kKkRYzEnNhEb1K2GxcE1DC8n8NYlQdOey3txpHP5PGlFhYL2NXdPaWUj9Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495498; c=relaxed/simple;
	bh=8RdY1acSMd9pvkDftDKm9nY7d1Tml2J2at8P/G8YTi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+MTSACM90f2tNlmgfNkitlDrtXyDxGI9d7Z54ZoTJ8uhZWKjM1VQHSBASH1smso3advs+j01KLUJpgKDzgL27zyC+wC9o8VzEtzwrLRaKsjr4C1dvmzgZQabZ4621KD9lFh2Cjg6fn10uOOcw9Ou3Q4eVwcY7PR6aUAObhrUtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c8FYiqOl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jQG/gzQa; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c8FYiqOl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jQG/gzQa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762495496; x=1794031496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8RdY1acSMd9pvkDftDKm9nY7d1Tml2J2at8P/G8YTi0=;
  b=c8FYiqOl0p/5rKauvQeevzLZwcikOkIeCsSyWcBNon+yXOVoftH0Jiol
   krFUFmPlOHNmlASb953BYalXHb2sIgX/uiFtSt+9ovVUPnpDo9gGWeoYm
   +eKeB1hTzabMX/ZH9ZSWUwRS/ePX58kidSln2m1VSRR2mf68XVErQ/W5U
   TjKEru52lZ8h4Cta9TnTU2ZgFtTZjgEXR7MU6DJKXuORMYpI4JVwc66JY
   xkNPywwVn0P4A2SnJqGfp1DYRY+zKusTKeKjF/cB/XUAdG+vKx9x0FmP0
   lzPqUbxLrrtli/IDcd8c3qb3Vav3b6G3z+DxEECzZktms4a4A4ORBfBVw
   Q==;
X-CSE-ConnectionGUID: Lz/FDXGSSJa6EdQnEP09Yw==
X-CSE-MsgGUID: vt8fR2fxRdq+ZNj7mzukzA==
X-IronPort-AV: E=Sophos;i="6.19,286,1754928000"; 
   d="scan'208";a="134698149"
Received: from mail-northcentralusazon11013029.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2025 14:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciLIpV5Fk+hhS/7BH0UEvTkfjaOW3RAdgFJg4248DYW3xX1FAT8c1EFL5vuJBYu0+LUKrba5FFyCedG6lN9PNHcyHvcO0mAbc7XDBuXbtgHAPzxjpb9jFjjH4mDpKKHBB/cANhz4ZaIkYEjrY/pITYKly6ZuHxerchd/OVfM2DkriiqnyaGytGkeKOY/JrZp+vV/qvE09hTOKV2kwVSPD/V0Me3m9Z7IUiM6SOFAQyNgGY98gHhhpSzS8lOAQ6DNnEhzxA8at8gwm7bVpQYNZtJzgm/370NOLj+PiSSqWZef/dJ1lWIBJld078eofgGsHfDWTZcYNjX/avqAWybwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RdY1acSMd9pvkDftDKm9nY7d1Tml2J2at8P/G8YTi0=;
 b=oBzbFn6zsOCGeeV31PynJLbVIZ+cKYk0rMlDCWqx4a0m+YdSSfFPjBkv03U76orq69eVHVvOqYpljTuyAKRoZD6Ge86856yvcXN+G/JGEN2D6gClfSqig2TTFzLHDYral8snzM/wPs1VEg9GwJ2H+hBiIw54+p8bmOfiIpQbpALilvCmP7h20rGO4VLDn3yzElCPS/YVcINxYDfA/aTylOmBqS08rebMYu+zMaNDzrMEiyCcQuFqh0ucuRhkaHGF0TN3iyM+y4+0HgaenZNMPdn10CVmGohBLgJLH1kdym4LgEIEpc2rYB79jFPWSJKmzCEXn+ZhRdivzLSWmu1rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RdY1acSMd9pvkDftDKm9nY7d1Tml2J2at8P/G8YTi0=;
 b=jQG/gzQancQQX/5S+MjwnWsSNkNNhsUkNikOuf7bWLCqZAw3IyWk86ZtoUtncT6W+qs8NWEh2kJPZcKlhAsUuz1xE+UVUD/SyooeGlImzzlG/8Bnw7TAwfQ1k9UKr+bgBfRGvpZ/jQDqI/EsFI5pVrllWphZdFYdF+51FqMHmNk=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA3PR04MB8689.namprd04.prod.outlook.com (2603:10b6:806:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 7 Nov
 2025 06:04:54 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 06:04:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] blktrace: add blktrace zone management regression
 test
Thread-Topic: [PATCH V3 1/2] blktrace: add blktrace zone management regression
 test
Thread-Index: AQHcTR49drAR8T/CpkqQeJoh/kjGc7TmvqAA
Date: Fri, 7 Nov 2025 06:04:52 +0000
Message-ID: <logjxeq2hgj4dcqhp7k2rvb7cwtzdfxjvhmr62vvoth5bzdmoz@gezhljgvw7jm>
References: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA3PR04MB8689:EE_
x-ms-office365-filtering-correlation-id: 5d6c6b11-c4dd-436b-d804-08de1dc39184
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8b3sAmTT0cHXxPiJXtFgNV08F71JWz7ROVtO9OMCwxUSLdJq+ZpYJhuvmqw5?=
 =?us-ascii?Q?BuWTdLR0Y2nsTbdlbJrxye489zqcSH8PCm90Jnq+qtie/+D0VUVAC2SNdeRw?=
 =?us-ascii?Q?NicH04Mlx7Cb/W4zFBJ3Pu5T0JNbEgZhGJuiU60Kgzece1GqazSM6tGex7OU?=
 =?us-ascii?Q?oSQd28J1PC+L488OW/8aBVzMAnfJ3Gs+yzklJmOufJMc3zVrVOhISNeeRE/m?=
 =?us-ascii?Q?HZYMeehfLc4LvZjS3HGd9Y2Y0+SkoBSQ7daFroqW1o2xIh4ntnJK9gQQo4HG?=
 =?us-ascii?Q?PE0CrfflZM2FyvyqCcnDtOZaaFYnyMRXZMqlTdMHLoykqK6yBbyZq606RNM/?=
 =?us-ascii?Q?prVoU621LAvD7XGSI2/WuSZieANkC2W9marF41bSswtTinYC+FjDGNz0mly1?=
 =?us-ascii?Q?+QI7cql+CHBT/XCj7S14H/zpwHLj1CT7uHi9gdgzzicrL4+MI22CXKfjFqRl?=
 =?us-ascii?Q?u/ycylkMnDpnXFf+4+eVKQsLZTqJpxhlGi1ttr6dOiY8ymKZl0Ers1Jql/9S?=
 =?us-ascii?Q?FoeWMmcgz8OTwqM0YW1HlKGJmgEFThCkYzyTnVjpGz72cjuNgVv1ZoOHAIeJ?=
 =?us-ascii?Q?O4D2uLaaBWV4lq/nd8IFdrUPqaJzHBYMs+EQd+ZW2bu3ZbfybprT2LNJmrpZ?=
 =?us-ascii?Q?jMO0+0MLdL6uGnWK9nWUEbKXBOrHEzke7/NBmJAyxeC2yjXGKvWicvbOnnfZ?=
 =?us-ascii?Q?4SR1KFgoyNaYzFi+TR8JNbYOyfJKC/NJegYVOrP4NHkYphldGbq6ChS0iBpb?=
 =?us-ascii?Q?mDBYtseoA0HWxCF032roO8ZHxQ3gf0dw2PCbW0kdNiaZxr9K7lKXT2HIpweR?=
 =?us-ascii?Q?grchLxl3lV/DQky2vskfc62ZMbAgsn2N62lV3xyOgEZQf6ljnhcpf6roKMeS?=
 =?us-ascii?Q?wV8if6DhKBX1NZSQU4n2dHnIGVyOaWHbTpcAw74yqa+Aud73DNEO0fhicjSD?=
 =?us-ascii?Q?ur4xtW3NgjpDjC/DjPiX6h5AQ4gHnSiXQzQpKYgnxwKpVOcRf4Lirwrd3wNR?=
 =?us-ascii?Q?uHzeBwy1kITzuGPT0CifB5U1f9fKO2cStr/ctKsT9prNu4h/kQ/ztzLoi64x?=
 =?us-ascii?Q?5ZwYGUEsLvy5FdZ8aF5uzxc3SuNBl+CPYMdegXUja752TdzZTMaHwH6s6HX9?=
 =?us-ascii?Q?qTKYHOVvRL4iBsHIssxtTfjobGMg48taWS7TjozmnN//zPzoAac3SVjs2kG4?=
 =?us-ascii?Q?/xAWvzN4M8TXaE/a8ALtfjgOjC7dkbNBCwrkuAlAPiLfEufgPxMLbRgMmVqG?=
 =?us-ascii?Q?J4rzgY3QpdQA7vC0uo2N1L1DeICpxx+wZrz1iHpkkgbp3pGulc3hBe8PCprA?=
 =?us-ascii?Q?8oAgkaEIpWm+iHKgRa1cdM6uCePsBFYEj2FSUL02ibYTFj59GMVXkJ4iDSIT?=
 =?us-ascii?Q?uessuj/sp1a8WFszq7kU3JQm7ye8XAtp2qTOUvSkfD0dtxjMZGwIuKC21GEw?=
 =?us-ascii?Q?044J7GFAFP0efY1KspM9RoxZJKFZKeGKc1YxilaCkChpq8Y9/9auh7azJQxP?=
 =?us-ascii?Q?Tx8HX5FmKgLa3rNzbtFqT4yiDT6gqxye+adc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4MDZnQ3548htZVJY1fCINIlt0CiIFwbypGKsVkdSS7HliQ5ADFcNONpKZ5kO?=
 =?us-ascii?Q?SD8ZBLQ+hFnkDQSFAW+G3Iw0qVNg2ILj+M/Xppz/JRoIITt8FGx973icUlN7?=
 =?us-ascii?Q?vqRdhkXoTxeZExsnHvQWkH/QP+0Aw6Hsf2FWiNgnDUcaJb5erANCqHBGgCqk?=
 =?us-ascii?Q?4uj5fAeVA0DjM+HjFgGabnkLLAvWCnPucu7gPojXqZYCwlK71UD+T+0LQfQ8?=
 =?us-ascii?Q?vksCc5f613AiJPwI8tEt8ZkyDiNAaNltELVn/NSd8gUFL46kpe9fUaYbDPxa?=
 =?us-ascii?Q?pxpilkqkgViltxUCJKxyPzjiRpu7HLIoVEKWUfhB1ogrCjgqcNJ3m30n7IEz?=
 =?us-ascii?Q?KhuxMhIjj8G4IeneFaB8JqxsAMx0/SrkIlg5IWDl4ZzSjZ2zDXDRlBe4BXX6?=
 =?us-ascii?Q?/w98dn5w1TYbS+8mAMHaKQmhu+K+3x4KRUyzmFkSMNzYA/DbC917pVxgvKdi?=
 =?us-ascii?Q?OWBI+0pDUf8H+HkzBoq8GU7LMqBUdGspP9RA1aSs9/PrIJVJRe5wNsVB4Uob?=
 =?us-ascii?Q?HPNB7F3iMWL+huuwFvoNUhafLgm0pr3kXvYOv62FZBXuZA15ImospufRJAq5?=
 =?us-ascii?Q?u+eonuA9L0jtyv9RyPJYOXq2/lj0cWJkpf+hayIaU4X97oSPB5JJAWbNrjGS?=
 =?us-ascii?Q?3E4/IahJt2OKcme/FzclWQiR9DrcLfk7nfRCEgvQ1wCktocr7ZbLmG2SRqFA?=
 =?us-ascii?Q?iDjALf5TYK5oKIy5WQQ9hw9HihuRiLSqdI8mbGHlzcMcHkx2vCEsq4tuIl4/?=
 =?us-ascii?Q?GL6aHMeALGo9wDS6KOAeIRVeJA8guZkygaYUV2z3DrvlPl1DPYLF7vjIc6QA?=
 =?us-ascii?Q?HEtoRVGcgl0aNkdVodYiW0PUf6ZhCOi0YLvePemAj6Yp1T2SYDwzPS4o2/xg?=
 =?us-ascii?Q?pE+qgMO5SAFzCKk9KbPyHDzs3uK6EWeaehmOvYjoc5SqTDPvroh2fpVqeqme?=
 =?us-ascii?Q?5VXP9TnqWdfNFf1oydxoHjVrDM0SYzodnDhxOPg0/DXAPEk0WeBImKl1BorR?=
 =?us-ascii?Q?JyxMdG+uexwivMb76GEjuw331skHDvKLhp7g7bYRpSArDGysp2zVdiO6/jqK?=
 =?us-ascii?Q?TVGd+iqN6ppVMZc2PmvXCS+KlFRmy/cVK8mmNIoIjz7htUy+h37IaB5TJ5DX?=
 =?us-ascii?Q?gL2p6EXp5WIJriOt7/8LSX6aJu5ZIVgYjcModaQLk9Iof24hyTblNkw3uTYq?=
 =?us-ascii?Q?iAyyZ5Ey5+3fADM1eypToNbXh6Y1EtovccVRe9/5VuJYZw9+F9eI+HLDiABu?=
 =?us-ascii?Q?HCXxt6s5IRwoPT+Tub4ED+W0ACWBnhF8dgV2YAZoqNcS1pQWgNAnXklgHlHV?=
 =?us-ascii?Q?IzXU2uiJt6TJquLP1padrZJNWJAhN/I70msurLyMJ8IUeEV19RCKKPXHWBm5?=
 =?us-ascii?Q?O7SLyy7pDn4hzprSUuRWKLMBTTxoHo1cSXg/K19XhaIAomoQaxKevI/D2Dr2?=
 =?us-ascii?Q?qf2rwyg7xHipXTcOJPx36778gzxxUtEw/FdvrE3azIxHeIt9BQ/oMs3bSFXa?=
 =?us-ascii?Q?gsuJuTUgygePnx5LiqFc8uFMyv2FenjxcdLeO+/AvFJN8fJA53WBuoFLcqln?=
 =?us-ascii?Q?Ms2BQFTM1vY+kiXBHer5oTe6oPF4+2Lk4iZTMc+52K73YaEmCH87ioIyxADu?=
 =?us-ascii?Q?7XKlE2xCgHDM6lHrISNlbJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8CB4C6995EFF44BAC409638C367CCC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WYVCGWrNxFECNdrCHyxPH5Goq3vpAlOb74kfdgKm6I5KqcJGKIcFkeciO1cqOfTTZfhnd5e4fE3NykEYO29nbfKUrTGix+vOYnMLdhjaMtSsMvHDSBGRZEnFQmfGgMTzIE6SGhI7SokAGG5xT2zKLSZwYAZ+EecnkN7miXSeDRErbAjDgTrjBlRS1GzLfdQd6cuOcQWmCN1KA4Zo98QW3x1wsbNb9GlWtSZPPkfcZCdlkc1qeEHpQJ5JseS3aAMkTC7YFOI3R8kEZ2JadDfVjE2UIb8megiU2HkrdN+om62Lzgob2qqBIsbHBM83umrduYXbT8xdHUA9RyV1GaVIMmQ7cUH/E8msKgjPZ6dAIOI0zY3LH2dHDA704eEE7lQLKsonJggbwHlXO+zsLy1ORygE8EKxrq5azFaFA8zh4MgUQgqaXDp1LfFHWsI63saIy8QLWhJiNbOyg+ofvzQOQrCiPEHsBBZTfyH5FDyqXuNzBOy1B3QHzXxoVBtycPR0VCz/C7J7ZN15FvKtuNloJh77I96bbyFs4+G/WKAZyodPE4P/NpPDKdUlLIZ1fq676rc8oSOY5D/yoPqCSUh/vg+96QYh2/OVr0cdI36J16Qo98GeWmTFXJE9LsXWPMEu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6c6b11-c4dd-436b-d804-08de1dc39184
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 06:04:52.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4skx/b3LDup82lSbgdPFW2wDqGHEj+CFdcZVBLEIttr66vBtblpB6c+QUurWoA6/8Xjm7RSKH38E1w3fUu9I5LtmHWr1nYpb3aRDTxUEHJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8689

On Nov 03, 2025 / 16:01, Chaitanya Kulkarni wrote:
> Create a new blktrace test group and add a regression test for a
> blktrace false positive WARNING that occurs when zone management
> commands are traced with blktrace on V1 version.

...

>=20
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Thank you for this V3 series. I applied it.=
