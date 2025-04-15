Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7A24A043
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702674; cv=fail; b=rKHmb4mylSsAeppx0OeVbusR39/SrAlkgLyTVIS1Lte9uw+KRC1Naz/VjuA69GsmgCuZgoBOTTM+5FIolwjLQC+uc6KEtLUbJdV0KPHJ59MNWni+3FIu+hserD+cb8aMsrE3E0uKWxj8O8bLPUfTOI7H1/5zpauYjDrdWFGyFG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702674; c=relaxed/simple;
	bh=FNRCCk89LVUc9tl5oHpYM25gzjmdE+1p2VEkdXwKl6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aeCvEktqMxJVlEp/NCxTzh7NWUWYDBQqliLHPpeKKiN4Luml7QLNjK2ioeHLFHuuuPeA2nkuZq2lYY6iDepfRz70Ebj+HKJZem+N9fR8WYacQ00VhoC9g8V9hf2qHTm6VI2iH53190Az5uC7IF44dBBtlzErPJyxiEszX2D5de0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=idp9jJBJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GW4YWHac; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="idp9jJBJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GW4YWHac"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744702672; x=1776238672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FNRCCk89LVUc9tl5oHpYM25gzjmdE+1p2VEkdXwKl6w=;
  b=idp9jJBJQvPsNnQXYI1803GbK/+HGDMUUdos7m2aURMVqG0z65hufOfE
   acIheqzrrjAnDFCm0nQzsDBDdDuf/54wvHNR9w51NCti2ztW04z6NcUXW
   +0uUeeUDFtMbgg+An8zVQJxuagNcAfOAAHj3+LW8ZYM2MPBdDueXVBn2E
   scDG+yvUT4M5+BK8mGZVjeutmNj2Gh6W755+4BSamIkju5YCxyFFtPyvI
   a0zVVtzk4Cbhw2OjL0eaDOY4RY17BucuNXGRmXnaqFiBIh3LREhxXpdjF
   5yhxlSTvh9g1HQZpwJ4vo7apkUwrZzOBymzPkFxYCA29Mh6OWW4DTt8sJ
   g==;
X-CSE-ConnectionGUID: zLE5bNV6Qvykx1lKdBdJwQ==
X-CSE-MsgGUID: PG7J6wXzTPeM/IkSBS9XYQ==
X-IronPort-AV: E=Sophos;i="6.15,213,1739808000"; 
   d="scan'208";a="75490455"
Received: from mail-centralusazlp17011029.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.29])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2025 15:37:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpMHV2FoQsS2BAxXP0Ot9Nz3tU4HolLfRQQYukqfgkwe8z3dgvcWUfJhk58Ed0VkwmhloBUp0wqWN6x7G9/zQuAgVBGI4j47LGDM3+a1h8D/sH8jmXqtOINQnWdquHKv0dy6KqzHBafoV3gQlyarG6+KrBk97v3pSGawshRw4LwdgA05vHaKNT4rWjLYTNcBuq+aEVKKFp+wpFp7wZm9Y1lMldm1o/257qbl1j3oV7VbG8yNmiOhkA0D1Td0lIrQSKEFJm4HwOgjsAWYS2ssDXgsYFoL+MEsmVR9AnHvuTDjGm/b92w5POfOxPW8YETj4aBdqdt3V/ItKS3O1c4ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mutgC+l6yF4LDumdE2pbQVUuCjSl8G59J7ShfK+IhE8=;
 b=OEVPxUpurn/RJ+gorUaCv2SG1wU7LHhiVm8CVcxVDkz+KuGpEmjlexK7ttqV29bY4UMbIRXd94wC9hI7VEiPyWNSkKPWkPSQeK7j+ya4796mN6vHk5bcUXhNIvPIlWNzO7VfU5HbkoL9IgTUKyALWCqXYOlb8Mgw7Nwd/7YLQsubSFdZQpkPypVJVUQRX64jY7M3QYZ1AG3djBu8us/pKvDqBU9K9DNhtSCeHTKmUGUEHKrxXJpETtsKPWyydnkEV+D+ljgkECgdzKkyUCHmQZWOv4QbnsCEO9vIfa5VVw98wixjpSvTvj2DG/+uCJK4Og0LEjvzio2o88bFy5Ja/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mutgC+l6yF4LDumdE2pbQVUuCjSl8G59J7ShfK+IhE8=;
 b=GW4YWHacuHHaV8MatX1nOCaGS7qCQON+gBpTGxyz+i7PlTJP24S+2llmL/Pd/zBKuDj5ppTKTS4u8CGLBxfGS8d07uvxCstvMDS9EcBf7UDBtjbPasDgT1IiXaIDBfMdWspOkr2aKi09cCpmvqMWxqaJ4AqYqQSRxECMiNVu8MQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8574.namprd04.prod.outlook.com (2603:10b6:510:298::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.37; Tue, 15 Apr 2025 07:37:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 07:37:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: Chaitanya Kulkarni <kch@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 0/4] blktests: add target test cases
Thread-Topic: [PATCH blktests v3 0/4] blktests: add target test cases
Thread-Index: AQHbrUZZQ7JmItLr4EayAnxaXwR4KbOkV/sA
Date: Tue, 15 Apr 2025 07:37:40 +0000
Message-ID: <e4227cqwlijfqvkquxk33p3frg7jbevkzsywkgvb45ol3oz4ps@yho4eeo5lzak>
References: <20250414-test-target-v3-0-024575fcec06@kernel.org>
In-Reply-To: <20250414-test-target-v3-0-024575fcec06@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8574:EE_
x-ms-office365-filtering-correlation-id: 8be04245-7f54-4c62-2f1d-08dd7bf06719
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UbvIj9OjXb8Reafe/6t5P6YvdT+sAmnUR/tLsgAI1bpGDRbqvZjAdloDFFib?=
 =?us-ascii?Q?PkV1PqOgEq56xN2WKIrfVhlyUP2ojTE37qaYWCTgpppZAkuaIoIBMSh1BUEl?=
 =?us-ascii?Q?ilB+HEQuIvaMU6vMgJeVQnmjEP34xrjFcHg5gZF+Wytbar3woAU+dVuU5QTC?=
 =?us-ascii?Q?HjWl1UVGqHGKZbtsEZ2t2wSn/guqx3KvGTMUhBhWWSfCz0P6FTxSymf+hIdB?=
 =?us-ascii?Q?9CNXIVsgMMLuvyqkmWZrSFt3jwULgdVfhTf+mhurE4KNla1gdVSrchx5NgOY?=
 =?us-ascii?Q?W9uswCX1d3e7CuO2kQce4uYlYAELmdvFyY4OXSb4NBIHAbGfDdMlMD3tBgw9?=
 =?us-ascii?Q?xY/s55713xPKa5luw5ej8j5TttJQ1vwkSE4zE5pZtwQuejeLvesrAOhmyRn/?=
 =?us-ascii?Q?cTAMNBB2t4//QgrbXbM+pAEEb43I032RZbrUa3RTGCORhUy83mVpKBXBON6w?=
 =?us-ascii?Q?L/Qx6kx1fkV1m6ZCfXfEWNjQWiulCg++V50eaw4S0zSfr5X0oBbvAT+/PUvc?=
 =?us-ascii?Q?KrBNI7kwHkWSaGcZ1Bc8q0iO77tbvLzyk2RIIpmARGQ/oaynnMp/KQTEjEEr?=
 =?us-ascii?Q?sTxFL364L14pT325Ksdfiul5PqqVf1eVvyv2Cjf0t9xnEot+QaPjvrM16z6T?=
 =?us-ascii?Q?T0ZU90dsC6CfPtmD4R+mzZJrXNS79mcQvCmwVDRhxDduAYE09hxedj26MjP2?=
 =?us-ascii?Q?6FuzftXaQV/aJlT2BWnVt63FtyB8odC5v5d1rxLEVEYbKOJwBuul2a8LrZD7?=
 =?us-ascii?Q?tIYzmsnXcIfGpaIDWAMhts3W4YgNKYuU7WK5j27KKGIER8xaC39Zqh+5ymhp?=
 =?us-ascii?Q?cFP7ATCMG7GtmH4QRTZF3Cnrfg3MEPvpex8AjJoKYPmEgN9yH/6fc4av1iPo?=
 =?us-ascii?Q?Dnmh/LaQwlN5lJCZX/gtdEK2MWhelEV2lPO783tbra4Kk3Qq1RuoGKVWJUhT?=
 =?us-ascii?Q?wVW8g/T8BfYVtYCPbCTZGsI+bE8AwE1VTm057uuAF++0PGwBKchX3mzFI72s?=
 =?us-ascii?Q?Xt673MVSS2wOI0gMG3H895Q9aHUZmvbgwmdLKMIbI/gyOsQ5+3MF09lV9pfM?=
 =?us-ascii?Q?dJ14xsuej2uFqrXTZdLwi1fULC970R3TqvF1JLIaJS/E64ifq6w4hVWGat+n?=
 =?us-ascii?Q?d2aH6XBNUoS2OPt6sOMXFS6WbDKE+X1j2hOxKGfsRGQffWkuaynsWmNDfAQl?=
 =?us-ascii?Q?Sm5XlD5eT8UTkBxhi+cGJ8QrEbPw9SwBTpja+NxWa8IXpwqqnUBZsAJ4FT0x?=
 =?us-ascii?Q?nRi+PA6KWk09KT5P+ugXsAbUB+NgRC8UMIga3LvNvJxGGWic5q92Cfu8RnJg?=
 =?us-ascii?Q?QeNWh/ALVJEHDqnp2tXFqYDukOD0igI/7sUF6B1ust5L3uxXXATHTMFBgYP2?=
 =?us-ascii?Q?gZ32w6LbfjwsRRgkWMnY25gS6akKQ8zqYcKVij5bG2/v9KRE0D0pFOekIsK2?=
 =?us-ascii?Q?P/hEFZgtc3vJNp8hYmdsvSukCud0y0mabtvILQykwpVTYs0ig0xEzg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xZ/iNJIbJaGtBXaeQsvsS9O5+LQ5sw0DmeOZ81jNV34oY6VhJPUpTJ1kuSQp?=
 =?us-ascii?Q?fvqYzm/QIq8SMwkLYaoVCoH69AFoWth6U7p0rDChFqaVyiQVKqZZ85YXp2Lo?=
 =?us-ascii?Q?PZLcIYGeT+9VWRsIPrHVfmkfBpJIBJYo8cGHVc8sO0FrWxCya6djc5Tv9bh7?=
 =?us-ascii?Q?jgruQjVPFQfeO+7KjRgbrPAifJ6A6ZlpEy5+KCfVi7LxMFHJVWXAXLKVxqGg?=
 =?us-ascii?Q?oEs6XAiXlNhxM5KJM7qrx0rkfDdKeJtXYGgod0ECpd7okVLKn0wvOK5488tq?=
 =?us-ascii?Q?dCe9NeqPfmaO0oU11AmZTHdo2scK3o4LnGhZfIU6N38Ov2xB8telIA4bvbgI?=
 =?us-ascii?Q?EQpw3SRL7I0WKOHlln6XAPD9JbCtP8a8M0/t8URUuIxrfjSv7BeIKBq22Daa?=
 =?us-ascii?Q?B8mn7hBYjn6rJ2XPtcn0j1ztQPp+zDOSe1yQxEISD0MfIRYdEMf5TSE96UG4?=
 =?us-ascii?Q?BYTUBDvUGCBTRB28Y7Yekm0FdaYBNX2LljXUO7ShuojYFkt38BrUmn7aSpmD?=
 =?us-ascii?Q?82jrl940AwqoNaIKZ9LeL0bGVqGPfyIN5lf4JhE9mpa4CSQ8CNZHHsoF/dGm?=
 =?us-ascii?Q?UVL+wWFQutgApS77Y5J4mASySI/WUM3Yl3c+cy7VdAy77ho+G/elcmmaTzPG?=
 =?us-ascii?Q?0bIuAj+RFrfdiBlyR3N/KtlznL265xccE5XNdp/HybeqiFT4Y6meFckSidXM?=
 =?us-ascii?Q?moQ5slDbaeJGus6Jf95Zvi910XV31QXN/ej0WE6CzUd0H2yDF0Q7NWs+gdme?=
 =?us-ascii?Q?KnTA8nNksSvV2i4hI0K4ic1t0hPrPfhwXdBh9EoKqDqEO3wXdhheMsVTrIwR?=
 =?us-ascii?Q?6LuCwYR0MTQekkgwc/bdwShbr1f3pd9huEzakw4DVY2kM6Xdc6wC/GXItHdS?=
 =?us-ascii?Q?eJ+7mjx4oGtzF2DUUZNrRxLm2IPJ9/nF2u0ieHVQr3WyMlBsIvO0J1RzQYam?=
 =?us-ascii?Q?NfwLuS32ASOPb5TaflY1OIBnRNZrJ1cF9yD4xWD3Pa84APzYeIOMHClJ1FRT?=
 =?us-ascii?Q?ZQ9ka6bIqNv4HmAHkogaDOZ+BY5LwOMpD8pBA/Iqja6oJVCnM3YxvNzY6dkw?=
 =?us-ascii?Q?jvdQldM4xnuGYOTPTyEsmctcp4pOespdBQ/WFakvfKYu8v6zIQ0ewKEKOepY?=
 =?us-ascii?Q?bjQPTLfFpBAUBs9hAqC2ECCdmDC0povoxJ9OF160xJOn7V0Zjet38pk01cgD?=
 =?us-ascii?Q?Ylx6n5hUkL8zEjKwSTB1OM64cHW2qI6wJ6dI3Vxuh85keqjWcIsUrboJm+jE?=
 =?us-ascii?Q?W5i6xJGm0UXDTPmfUXQQl02rWnmupKBfeoKnQRdO4PLyX7nu3F+2oiPAUJeY?=
 =?us-ascii?Q?NoY1a7r+Jy0xpUR/uSIIOsEOO7qZfxkFL7K3f9+StJDHwtTp/7lKcYYVXdaF?=
 =?us-ascii?Q?OsKvZ+/ek4Y3Ekq1f/RxxS/s3GXmkhSRLuzjITgSaFvUVn0jz/d1g/zkmz4Z?=
 =?us-ascii?Q?3HBSoc9e8+RAwomL3Jxu3bi1p9HptaARj4FuOWWGu/WNMEvLGOIrJDqjpQo0?=
 =?us-ascii?Q?2jkXjqPIAzK34BBZui57FUynZ7JbKJwbvqwL1Jl8yuI9gyz82iq2wUq4dZ5d?=
 =?us-ascii?Q?ITb5d9VLkwxOgrW2xeR5afh2Ocqq0W1Ag/ZzhWl7RO+C3SDasaTDhEIFTXIa?=
 =?us-ascii?Q?2rwdHl4bhPCvcQDkSMEdVyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <997C826852C7EB4C85DAA0F4204CBE36@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+DMvZWmW/aRtirWkrWwO6xDfDePY6WwKtQc618iT7P1C0IsuS4E6HnNd/WdAaGR09pXaloUyB8inEKnMuybheWzw8F7jMcSDVh112nWPEb2dBcOjqBpZtN8M2ezeogMizxEZ+Nn2liHYiGpDstHt3R6P2hBqCrD1qt97otUCBBYcwZjuujRWQEEzeoHRppt4a1Sd2VH0849c9fpmQwutd/7Nrdg4dK/MRsIyPqBJ41yj2FwOmZlTp2K3sSOKcmRR+GYbSMZlKHmnsoPyV5Nk5IiAQ1VpyS0VkOBvHmwuQVvZ1YkysxOANzo4QSaZ4EVACd8LF2Tgi/PgoSV0A6gBdhTdRV9F7FgnnZyy8RsukH79S86aW9GQ5t2n8ICxaCOKyhvalZieWVqLhsB8oIgIUEnCylNXsMp1JmkXNpq7xCrKtkJAXHBBJujK/ovWmxuc19DuQiFcWCKuMBVIfocEYMRZGNmGXi+G0XT4Aw91qtfjqB4PBDor31CLWbOiQCJRlH8Or66wiHp9WwLQXnVW+57+hI0Sf5f2GZHXHVZlnvHBQktEBzWde/KLbNXAWdDowlIJY1cQMhPuIIwpWIIUai7s8zSNElSp6dMs54RahlN/SHOAQbYA7U8mL0LlMysT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be04245-7f54-4c62-2f1d-08dd7bf06719
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 07:37:40.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifcZpKNBN46aUIZEE/SSx7OwV2rN6iHR25Kv6j+h/OPuk6m7H/bYEp3ImWnL9UlDXrIHSh3hAhOTbnF4k6UTVWMYwkMjKkmsCa8fWf6PE+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8574

On Apr 14, 2025 / 16:05, Daniel Wagner wrote:
> As discussed in v2, the tests are only valid for tcp, rdma and fc
> transport. Thus I updated the requires section accordingly. Also
> addressed the typo and missing quotes.

Thank you for this v3 series! I applied it.

P.S. I noticed that some local variables are missing declarations, then I t=
ook
     the liberty to add them.
