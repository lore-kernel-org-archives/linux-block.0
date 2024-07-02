Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52FF157E82
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912697; cv=fail; b=DfnOYUoewAPv5MWSOFIVgx1llP3jJ3I+UGeXMLKLa+A3dMV3kZYMSCd/yfKDzDiobh+3tab+dK++9NIyFXjlT0z7wuReDrXc5xVdMovZpHfRZG62ENJj53eegFe297dQbw0anCEyrqoXXu7Tx4yg/tsLNThnKScIvJOVEht/k6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912697; c=relaxed/simple;
	bh=JInuokPC0zI2/SOVyMGd5xYQ8qBu70Vs9q6tBksOkCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+zNJJi5+YYd7GVQ376bk88dFbH4z1C4ZbrrWjRGt5EfFZVLuMGbii+w41De+TP3xYsS6DMFPX10n3xUWAjU4JOohZgB9zgpuf7mUlAKl0+MF4iy95tn/DmG2Q6mP0JRWaKoFOXhaf9eM5RVOiUn2uqoY2ANQ9dfbbzoLvVqtAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ntoxpXEQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=beQmwmiV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ntoxpXEQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="beQmwmiV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719912695; x=1751448695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JInuokPC0zI2/SOVyMGd5xYQ8qBu70Vs9q6tBksOkCc=;
  b=ntoxpXEQPc4bDDETEUJ0ji0N2Ag2UUWxi5eHr1xnexsr6Xvu7kQZNNVI
   5SGhx4P493bnWGsk9bFF4UCMW2cF+jJESkGb2QqSmmMXQM02lR3MIiKbL
   5yOFjHZ78kP4S51Hp5eRt4C64nJ2bW22ssFLA5iGfs7+XMle9WYrLgXwp
   zraOxOu7FjTfcuT+QdJYrvxWA/BskCEHcF9Tb4ee5b1ocLsxFtPkWfLuv
   /s+0CACWFzIwtkyAmFNkiE8/RRzJNIVudxzXHs0ISlcGPm89yELNe7q/J
   Sm2DiGsVOo6Zk3c2lCDuYHmpAC2n/CQ2outXQjDUwemyEfIlZy2UgK/ZD
   A==;
X-CSE-ConnectionGUID: cq81Y3WZS3yZDp8yT0h/qw==
X-CSE-MsgGUID: l696cYMNRXWGs3iM8VxOHQ==
X-IronPort-AV: E=Sophos;i="6.09,178,1716220800"; 
   d="scan'208";a="20687020"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2024 17:31:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkOWpYkCNOgTtGxI/H/It7WMiHOMZbdBNCyDhl6HTTkhinu7iICj20oAmlZ1FXEam0vbXKRzfXDh63YPj0fKXx5T5M1wmxJPWICsZCIfmLGnJV2F2+slGJjuOzfZcn96qyNBUq15uh0cu1KeXJ7TBQ0LyBOHtCZ9ikZ7wVYbed0ggq+b6cBU9+6QFeEnB/REDevvje6C/MXVnmUQGDcBt/3Fdg62D+cK5URA3g7FQkgUOYKI4c/rBxIfnZ94m5u9kTO0hggR57JWRWjJ/3TiL0sx/d7Jlx0ksrrmDv2O/pzSgfHmMquHZl2P5xDtLC9H91upoib4Ubuhz1R27nNwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSdxLm7P4H+QvXfKGCWONhLrW2jvUUh9LoXZmu5TquQ=;
 b=HfmqgUJzMU/vUTfYTGpXaLtnRLaMoVbi74b0vWsFjZZZP9pXIQMptGMuppX9l4FE4a4oaWK1Kym2n8mVWsR4plDMBINFjblEHMm+KuAb+0itxFMT+3OScjwxamd1CzcUzcLEgbIy8OgBKXQg/UDrz8i+OhS1hrKZsd4sWr1ZLHpbh04DeX5OC8RMp/w6OAJg5xBzbOkFlhMl2k0OpfuPY1sapkwxxgZCAb2BCkq8jV8u/KHxlHEobEIbCVS0AW/R3hRf9XDf49FvVBEHnZwrXFCd3tVPZHJiNRr6DHsY0F55ldAabxfGekjb87HXhYiziMfxuAbYij05ez0k62+g5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSdxLm7P4H+QvXfKGCWONhLrW2jvUUh9LoXZmu5TquQ=;
 b=beQmwmiVytUvEss37AHr+FCsnQyycrcRsKo5jIP3PyEAlfzVrPNCWsSD7Dn/bKApghgIfK9KF0TjY6nxoBJhIZksdFi+/AjjE5MRAJEVabFvRKKC2z3YKSWNDKcR809YnS3cLtiTPAAX6UxOtxpau3ippGvb0ByhnXLDc0HM6l0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8573.namprd04.prod.outlook.com (2603:10b6:510:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 09:31:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:31:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Ofir Gal
	<ofir.gal@volumez.com>
Subject: Re: [PATCH blktests v3 1/3] nvme/rc: introduce remote target support
Thread-Topic: [PATCH blktests v3 1/3] nvme/rc: introduce remote target support
Thread-Index: AQHayHHfaO+i28+dmkSocZJbcLbOWrHjKUQAgAALFIA=
Date: Tue, 2 Jul 2024 09:31:31 +0000
Message-ID: <gpbfvnkocibvptwedmm23x4mryt2zxt2aofyovl5p6e4tetbxi@rrhmg36uksuh>
References: <20240627091016.12752-1-dwagner@suse.de>
 <20240627091016.12752-2-dwagner@suse.de>
 <2le6usvr4sfzconrglndjq52i5zwykftrfqc43ddx7cpqanq4m@g4ocikmnnw4s>
In-Reply-To: <2le6usvr4sfzconrglndjq52i5zwykftrfqc43ddx7cpqanq4m@g4ocikmnnw4s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8573:EE_
x-ms-office365-filtering-correlation-id: 65cd9686-001f-4c8e-2b46-08dc9a79c1e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LxxLf3STNcxJMZp4w/83ds0nyUzJFYfvBYxyF4Jt1IS0QbBin6qzy5Nu6jxD?=
 =?us-ascii?Q?qz0g/eECptZk2fd8bzuPHQMR3x2Zm9MnlJrtGaf8/igndQBfnXIHn8Ps0vQ8?=
 =?us-ascii?Q?exC6s8exwdrbuEsq3vAXBfsqBoKbYXpvaCzFT9N4LF0c3BmivL1IIYbcAwyI?=
 =?us-ascii?Q?8C3A66W+v2I6ZXu8p3a9s3LR0+ihvxlJDCGhKUwLehN5QwE9HfcccbTv9Icp?=
 =?us-ascii?Q?qGon30IVuG9pleCi0PQaU+sHlx1xGNcgXr58pdP4aF/RDO9/OZNV5ZUiVsA6?=
 =?us-ascii?Q?86YVy/Xp5kutIxORP4b1lgTgbnvjSywDwaceqWJFWXamh4l5zwpLa+9YMSsz?=
 =?us-ascii?Q?UVuRi4ebocXpUPZwlQnZG1puwxfE56ugzqweMtHv8aAn58X/2XQ0K9BeLO/K?=
 =?us-ascii?Q?kHhySpUd+ZNa0KovbwlQ4DLTbGKIrHe+8dH/sFMl1wDHNU3Kbt4WezA1jpgk?=
 =?us-ascii?Q?5G7DN+we3XRfu0GdNcBEofLqVQlWU6b7nS0qDL7HpW4x+gHtgB4pe5XTQlkW?=
 =?us-ascii?Q?CUPy9DUJlPoxENsvdZ3hvUdQtWHicA6ZBZfvAJq8cg9nkimG8ptPnOclhoaw?=
 =?us-ascii?Q?Vz4tJRLrWAa7dXKKRTp7KQdSdBWWoioRyHJdYVwnBVp+WYRbzNsymVOqkYpY?=
 =?us-ascii?Q?60+xkKl+MkFOtcyZ67JE9hw6dQJDs6P4VfrmCSbsF9u5dTN79h0Ts4oH3xaX?=
 =?us-ascii?Q?ATLV6++I9tTjrGLwHNYIc20+APfQ+w2EYmOenQNNrvf3gxuy+UBuufS1xqsb?=
 =?us-ascii?Q?OwZl9XecNwv0S2omosp1YtLPcb0cv0z9MmzYWZ/nJ9IaQbzgUGbSyb7R886a?=
 =?us-ascii?Q?h4/MEeKSOuzvGhfE9lR7nm3js6lqr+zrPqi0agJ/57YImwYKNxb2uLFYZ+dl?=
 =?us-ascii?Q?MM2tvUDUzQmjbLj3gvnSczArPhHCr8Z/w2tWFZ/HQTcTclpi2RM+6Ru3DIOY?=
 =?us-ascii?Q?liUjYHWESySsiINlo1t0upndhxxTND3YbwUZtWQraQt2Q/8n3p1G35ij3mtx?=
 =?us-ascii?Q?b/wnvyzXMKXA+fw7OyYEuETljeDhmHFiWxMAin1A+Q+XNbK3Mb72odS6tc9K?=
 =?us-ascii?Q?rZ5yfW1zCHptc/RghWAwB/oamvYd4klPJC/PnC3FdAuEYB4mc9J5abRaDT+l?=
 =?us-ascii?Q?n9UBCPSnMoeFZ8IAeD9QjasZKQ40Fc1gLihmYoUWc3pttZPEQqsnCFPbmHYg?=
 =?us-ascii?Q?47odotmev/FiI1MoVcdfQZXK0Y98kIbxVpNUyRbFGh5ajk2Gnb6d8Ko/Sgos?=
 =?us-ascii?Q?5UH49sLSXLsiegUvy3dP3wuqUZZstKg3c5GpLs4Z7t5roFiDN0VPFWGTMCD0?=
 =?us-ascii?Q?BePy/EeQGGcvmLglWTv4K/mL74KFISFv6pm2dpMm9lgPRW9Wwsdz8bAZZTMt?=
 =?us-ascii?Q?MD19S3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WPDtR6UnovjjlA0b2aAcp0nxUkG3DTX8wTDDScTbAedRMOgQyE7GMioVH4Ko?=
 =?us-ascii?Q?sMEYUIqtw0GsKQntGV8+3+WSpbPj/cgZ+emsRLrwsnpWk6XoEVRSztwClH9y?=
 =?us-ascii?Q?DLTLZ8tEiUcbZDXED+aZvYKXmoWVvV8pBFuMDoj8ad/qXko5MRq3tJxrUKKZ?=
 =?us-ascii?Q?FzPdaXzMcX3HIbtyEk8UZIYx23cr4CYha+U4duIJ5j2tAiWN0fND0HiI7/RO?=
 =?us-ascii?Q?CPs1hwVtcgT/txzb0dv6cqhRik/wVuTzT1dmHKdTft/dFzWQSjJTCxB8ShHz?=
 =?us-ascii?Q?mdfVU6vkop04rBZj46AZgCiBIC4yWDiroKQf6/HpaCpAOsfT43xYBp2h/TwE?=
 =?us-ascii?Q?DUBOJUXHoyRKcLgHD3JxWs6fjNqSgEgQUEKJqNKTnhOtZNU3G/8qAGXUKu7q?=
 =?us-ascii?Q?nL+bPvePiNB4s8vJ8BzJ57gIjSnXG2xhw9ND3hzXkg5T8t5Cgf6yAHp7JvPX?=
 =?us-ascii?Q?9kzKxWfzgpK+piYdrzFFd6+F7d2KlptGAt80sIe9p5WiUBWIYEgbk/+yge4k?=
 =?us-ascii?Q?gjx9jui04tKhJMv4sMr8sTcg3/Cf6sLevKA5SRPYp3QsAdUqd3UgcBHxuO9Y?=
 =?us-ascii?Q?Fc3ann5xKljkWDD53U3x+sgWLZPKfV0h2GL/H+7BK2IMHBS90C24XmeTAjKA?=
 =?us-ascii?Q?ku3YA6ZRMns5ywJRb3Lbf751Xn5q3XwLz8hlg9xCMQt1WKmq6V5zAZvXuvkX?=
 =?us-ascii?Q?+xLUV0cUtVGkUTuaSL5bmuy2A0sA/wAu/M/ZCesCbh+QSg6R2hkeDz1NvHJY?=
 =?us-ascii?Q?mBs9fT8hAVKzx6BYCSLudyUhPLlAfzo54ZQE16umE/K8EnLWiNnDMveMlSXS?=
 =?us-ascii?Q?k5qiDBRnVN3jLbn9ecZQzW678WiHT9w4md7YvB+7nFmIypiIRyQ4G62x9JnN?=
 =?us-ascii?Q?D0w8U5idc2+Hl650w9oS5aZfx6dyl/tZr4XZh+J+mAdZCpqLd1bEF0FwUBHy?=
 =?us-ascii?Q?iF4nppv6LCYJz8NvX8U2UmVKUI9Oa8ZBB+FvJ3tCt1nOaQkyouu2cvEp2MVU?=
 =?us-ascii?Q?hoM04FmpjXFlRz1uj7p98YXOJ+6SYy7/8jE49kBo1e8H1bX+DiO8dr0DcEvi?=
 =?us-ascii?Q?Z7o9+PEVZt1V2NhhByiJFWku2KWcE42vt7uerY3vDmTiX7UK+oWFxCx56MRQ?=
 =?us-ascii?Q?iRsPO3uyDi79fPw49li9oGH6m/9Q9UMRULZY7NsAYiiUi69PB/76dMyhCkk3?=
 =?us-ascii?Q?QKyImtLwDtHFNJZKHiYTyBLkaXlK3W5eTZ9B4+J9JH+edRyi/v5lwE2a3inT?=
 =?us-ascii?Q?HR5ThWtbO1ni70HHDe7KegwCnQUPowab5xu9VwtFECjOHZCaebrBHoV64yCH?=
 =?us-ascii?Q?0V8WJ5ZS/s2yf5i1uyfo6GhkKcKcH6Gp+H65DDcZwIxY3uU0giN1Rwni6gMe?=
 =?us-ascii?Q?EBKLx7WB6twhssIMlDH1YSH0UReHUgCxZyCTHCXXxSpLmb4zEpRPtrT/ktCT?=
 =?us-ascii?Q?yQDhc4gwGki2VH1Zj3WoOanqJDbOd2ZeyIT0MUhpL/FYT+WUL/Ajcc82c7zn?=
 =?us-ascii?Q?/tNc00HS8TmuqeGNVWa/PdbHLsoAzWY3bDA/i1FSgIzyJQs1mzixqqw8CsP5?=
 =?us-ascii?Q?Y7aU/SUK3o7Qy3sip0ZneJ50dLrD7yGHgfihHyQCM8Q6S4i+pNeAQE9YM5S7?=
 =?us-ascii?Q?wHAgyjBwR6TEBuirgmW/on8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <367CA63B278ACA49A837291CC805DC08@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oLESjUIfU/VX6cgK3kebokpSiTaABJndZO/fzzSahtEFJExLvJULzLxCRpunQrZZmCLuoXhxTtEGixbv1wQo8oG9nQXXcvQb6FSTW66rA8IDGPUnz9hXAUF8R1QVY3p7LG1qgUzMrIfzL2dCcZNUDUoblJP7sUR6DWcIOjFawBalh0LoNQc+TOX72F/hxsUsEfmLPAOf807a0I6Y/AQvrPukB/JI8qYNHvfTWju1XMs0SVleRzY8M4aip4Ke1zfePsPqGNAyFYPMqGaLdTRk7ttfUSKeex3Q+bXdpy29hhile3x7e0o8vNAWXFatTfU7tTS+jCREkgiUJspGo3KUpPEZ2S93ecG5M7YoZuCUE2lItecnkKxewxqi/nN0ntGZZYh+YuxFsTY7kDz15dnnYHJ51irtsTeyl2gIFPxfPt+ZOjWFnm49yYdxG3nTqIOCEw6P/BArFnmG/N2Y4iCO22FB3AZauCaAafGG+QSX6EyXHdExu1vXOpl140NmNsh5BeXuZyx9CvtMnm/4g+LLP6d8sm33w3N+6mO/FtI8R41VA/Js8Ynsrtt3UpUA8TK2vJkYnecP3xvQGR28Q7PKLJ0B2D9Nlf9Xokmz/EekTNEuBxsckeM3mao+wuFOHtv8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cd9686-001f-4c8e-2b46-08dc9a79c1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 09:31:31.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCEkVg8tnT8lx5jDcPanDUn3EL5sFamZwh3NT/MmN1Lf3Wow0l+k4lqD7Qqi3xNoQJwXplsh+4gxJOG3+2YUJtDiRg4gc9kk2G3smkEhu5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8573

On Jul 02, 2024 / 17:51, Shin'ichiro Kawasaki wrote:
> CC+: Ofir

Sorry, I forgot to add Ofir to the CC list. Let me resend this note.

>=20
> A heads up: this patch causes conflict with Ofir's patch to move tests/nv=
me/rc
> helpers to common/nvme [*]. Depending on which comes first, Daniel or Ofi=
r will
> need patch rework.
>=20
> [*] https://lore.kernel.org/linux-block/20240624104620.2156041-2-ofir.gal=
@volumez.com/
>=20
>=20
> On Jun 27, 2024 / 11:10, Daniel Wagner wrote:
> > Most of the NVMEeoF tests are exercising the host code of the nvme
> > subsystem. There is no real reason not to run these against a real
> > target. We just have to skip the soft target setup and make it possible
> > to setup a remote target.
> >=20
> > Because all tests use now the common setup/cleanup helpers we just need
> > to intercept this call and forward it to an external component.
> >=20
> > As we already have various nvme variables to setup the target which we
> > should allow to overwrite. Also introduce a NVME_TARGET_CONTROL variabl=
e
> > which points to a script which gets executed whenever a targets needs t=
o
> > be created/destroyed.
> >=20
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
>=20
> Daniel, thanks for this v3 patch. Please find some comments in line.
> I ran "make check" and observed some shellcheck warnings:
>=20
> $ make check
> shellcheck -x -e SC2119 -f gcc check common/* \
>         tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
> tests/nvme/rc:962:5: warning: eval negates the benefit of arrays. Drop ev=
al to preserve whitespace/symbols (or eval as string). [SC2294]
> tests/nvme/041:34:36: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/042:40:52: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/042:54:61: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/043:37:36: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/044:36:36: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/044:42:36: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/045:41:36: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/045:47:36: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/045:72:43: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/045:82:43: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/051:40:25: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
> tests/nvme/051:41:25: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
>=20
> > ---
> >  Documentation/running-tests.md | 33 ++++++++++++++++++++
> >  check                          |  4 +++
> >  tests/nvme/rc                  | 57 ++++++++++++++++++++++++++++++++--
> >  3 files changed, 92 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/running-tests.md b/Documentation/running-tes=
ts.md
> > index 968702e76bb5..fe4f729bd037 100644
> > --- a/Documentation/running-tests.md
> > +++ b/Documentation/running-tests.md
> > @@ -120,6 +120,9 @@ The NVMe tests can be additionally parameterized vi=
a environment variables.
> >  - NVME_NUM_ITER: 1000 (default)
> >    The number of iterations a test should do. This parameter had an old=
 name
> >    'nvme_num_iter'. The old name is still usable, but not recommended.
> > +- NVME_TARGET_CONTROL: When defined, the generic target setup/cleanup =
code will
> > +  be skipped and this script gets called. This makes it possible to ru=
n
> > +  the fabric nvme tests against a real target.
> > =20
> >  ### Running nvme-rdma and SRP tests
> > =20
> > @@ -167,3 +170,33 @@ if ! findmnt -t configfs /sys/kernel/config > /dev=
/null; then
> >  	mount -t configfs configfs /sys/kernel/config
> >  fi
> >  ```
> > +### NVME_TARGET_CONTROL
> > +
> > +When NVME_TARGET_CONTROL is set, blktests will call the script which t=
he
> > +environment variable points to, to fetch the configuration values to b=
e used for
> > +the runs, e.g subsysnqn or hostnqn. This allows the blktest to be run =
against
> > +external configured/setup targets.
> > +
> > +The blktests expects that the script interface implements following
> > +commands:
> > +
> > +config:
> > +  --show-blkdev-type
> > +  --show-trtype
> > +  --show-hostnqn
> > +  --show-hostid
> > +  --show-host-traddr
> > +  --show-traddr
> > +  --show-trsvid
> > +  --show-subsys-uuid
> > +  --show-subsysnqn
> > +
> > +setup:
> > +  --subsysnqn SUBSYSNQN
> > +  --subsys-uuid SUBSYS_UUID
> > +  --hostnqn HOSTNQN
> > +  --ctrlkey CTRLKEY
> > +  --hostkey HOSTKEY
> > +
> > +cleanup:
> > +  --subsysnqn SUBSYSNQN
>=20
> Thanks. I think the NVME_TARGET_CONTROL script command line interface is =
well
> documented.
>=20
> > diff --git a/check b/check
> > index 3ed4510f3f40..d0475629773d 100755
> > --- a/check
> > +++ b/check
> > @@ -603,6 +603,10 @@ _run_group() {
> >  	# shellcheck disable=3DSC1090
> >  	. "tests/${group}/rc"
> > =20
> > +	if declare -fF group_setup >/dev/null; then
> > +		group_setup
> > +	fi
>=20
> This new hook adds some complexity, but I can not think of better way. So=
, I
> agree to add this hook.
>=20
> > +
> >  	if declare -fF group_requires >/dev/null; then
> >  		group_requires
> >  		if [[ -v SKIP_REASONS ]]; then
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index c1ddf412033b..4465dea0370b 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -23,6 +23,7 @@ _check_conflict_and_set_default NVME_IMG_SIZE nvme_im=
g_size 1G
> >  _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
> >  nvmet_blkdev_type=3D${nvmet_blkdev_type:-"device"}
> >  NVMET_BLKDEV_TYPES=3D${NVMET_BLKDEV_TYPES:-"device file"}
> > +nvme_target_control=3D"${NVME_TARGET_CONTROL:-}"
> > =20
> >  _NVMET_TRTYPES_is_valid() {
> >  	local type
> > @@ -135,6 +136,13 @@ _nvme_requires() {
> >  	return 0
> >  }
> > =20
> > +group_setup() {
> > +	if [[ -n "${nvme_target_control}" ]]; then
> > +		NVMET_TRTYPES=3D"$(${nvme_target_control} config --show-trtype)"
> > +		NVMET_BLKDEV_TYPES=3D"$(${nvme_target_control} config --show-blkdev-=
type)"
> > +	fi
> > +}
> > +
> >  group_requires() {
> >  	_have_root
> >  	_NVMET_TRTYPES_is_valid
> > @@ -359,6 +367,10 @@ _cleanup_nvmet() {
> >  		fi
> >  	done
> > =20
> > +	if [[ -n "${nvme_target_control}" ]]; then
> > +		return
> > +	fi
> > +
> >  	for port in "${NVMET_CFS}"/ports/*; do
> >  		name=3D$(basename "${port}")
> >  		echo "WARNING: Test did not clean up port: ${name}"
> > @@ -403,11 +415,26 @@ _cleanup_nvmet() {
> > =20
> >  _setup_nvmet() {
> >  	_register_test_cleanup _cleanup_nvmet
> > +
> > +	if [[ -n "${nvme_target_control}" ]]; then
> > +		def_hostnqn=3D"$(${nvme_target_control} config --show-hostnqn)"
> > +		def_hostid=3D"$(${nvme_target_control} config --show-hostid)"
> > +		def_host_traddr=3D"$(${nvme_target_control} config --show-host-tradd=
r)"
> > +		def_traddr=3D"$(${nvme_target_control} config --show-traddr)"
> > +		def_trsvcid=3D"$(${nvme_target_control} config --show-trsvid)"
> > +		def_subsys_uuid=3D"$(${nvme_target_control} config --show-subsys-uui=
d)"
> > +		def_subsysnqn=3D"$(${nvme_target_control} config --show-subsysnqn)"
>=20
> I guess that the lines above caused unpredictable values in $def_*, then
> caused many of the shellcheck warnings in tests/nvme/*. I'm afraid that a=
nother
> commit will be required to modify tests/nvme/* and address the warnings.
>=20
> > +		return
> > +	fi
> > +
> >  	modprobe -q nvmet
> > +
> >  	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
> >  		modprobe -q nvmet-"${nvme_trtype}"
> >  	fi
> > +
> >  	modprobe -q nvme-"${nvme_trtype}"
> > +
> >  	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
> >  		start_soft_rdma
> >  		for i in $(rdma_network_interfaces)
> > @@ -425,6 +452,7 @@ _setup_nvmet() {
> >  			fi
> >  		done
> >  	fi
> > +
> >  	if [[ "${nvme_trtype}" =3D "fc" ]]; then
> >  		modprobe -q nvme-fcloop
> >  		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> > @@ -873,11 +901,13 @@ _find_nvme_passthru_loop_dev() {
> > =20
> >  _nvmet_target_setup() {
> >  	local blkdev_type=3D"${nvmet_blkdev_type}"
> > +	local subsys_uuid=3D"${def_subsys_uuid}"
> > +	local subsysnqn=3D"${def_subsysnqn}"
> >  	local blkdev
> > +	local ARGS=3D()
> >  	local ctrlkey=3D""
> >  	local hostkey=3D""
> > -	local subsysnqn=3D"${def_subsysnqn}"
> > -	local subsys_uuid=3D"${def_subsys_uuid}"
> > +	local blkdev
> >  	local port
> > =20
> >  	while [[ $# -gt 0 ]]; do
> > @@ -909,6 +939,22 @@ _nvmet_target_setup() {
> >  		esac
> >  	done
> > =20
> > +	if [[ -n "${hostkey}" ]]; then
> > +		ARGS+=3D(--hostkey "${hostkey}")
> > +	fi
> > +	if [[ -n "${ctrlkey}" ]]; then
> > +		ARGS+=3D(--ctrkey "${ctrlkey}")
> > +	fi
> > +
> > +	if [[ -n "${nvme_target_control}" ]]; then
> > +		eval "${nvme_target_control}" setup \
> > +			--subsysnqn "${subsysnqn}" \
> > +			--subsys-uuid "${subsys_uuid}" \
> > +			--hostnqn "${def_hostnqn}" \
> > +			"${ARGS[@]}" &> /dev/null
>=20
> I suggest to replaces ${ARGS[@]} with ${ARGS[*]}. It avoids one of the
> shellcheck warnings, hopefully.
>=20
> > +		return
> > +	fi
> > +
> >  	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
> >  	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
> >  		blkdev=3D"$(losetup -f --show "$(_nvme_def_file_path)")"
> > @@ -948,6 +994,13 @@ _nvmet_target_cleanup() {
> >  		esac
> >  	done
> > =20
> > +	if [[ -n "${nvme_target_control}" ]]; then
> > +		eval "${nvme_target_control}" cleanup \
> > +			--subsysnqn "${subsysnqn}" \
> > +			> /dev/null
> > +		return
> > +	fi
> > +
> >  	_get_nvmet_ports "${subsysnqn}" ports
> > =20
> >  	for port in "${ports[@]}"; do
> > --=20
> > 2.45.2
> > =
