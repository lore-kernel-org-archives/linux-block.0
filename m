Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795AE13D530
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710524; cv=fail; b=eBcOZQWKZZ3n6tgk0L9OB9hXUXsZvfyEkYPqtfyQZdVEBo2MrplGLwdXvzXkvZ8jLUP5hCBRwUvXy4UrLYSgZfbDWvqb6kpoP/uQH6nw4B9l5Dm7iXmjn4HrAu8YCaQ8ftXrJgHHF4BtjE4SimHl7UICvzWFlPYMUsg8CaqoPhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710524; c=relaxed/simple;
	bh=yB6v9+e7sO2qlPskMZlrHMEdxJIhulPSPeXlDXpRcvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiCv7YpxlHz9jD8wOiZKImqjD/jNYehAvlA9pkRFOxyFlyIjQbvhb4I2lQjIjoNpmYFo5o5ofe9bM1N+APRXGUt443a988Wk4+ByNYthi5Qs+JpnyrI4TANGJHQQpLtXyqWFphqBDxefkChQN5xJcNv9+nfyQpgIzrdQe9Sb4IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O/OAhZDA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YtFnUK8W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/OAhZDA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YtFnUK8W"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EIXl0Z007009;
	Thu, 15 Aug 2024 08:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=RZXINorZSC/xOeoR1lgblJukeobVUKvT9ArDycW4LvQ=; b=
	O/OAhZDAWaLpkQdt+4Mx6deYpRIgtYENR/eTLIHOz8Tu8diSxZeKGgbfZKrxbIoW
	x+siXc265xflflU1NrdYzuDJJ+nFDZHvVbcgviPu0hVPPMy18xrQaNFUnP5Gf0Nv
	xUNhnAo2KoDeE/IOL/j91n9IIihox5k3+piAjlhtorMinon3BjmHczCp7+K9SucK
	OEdPkapwb6bhFordih6zEcH5p1blZkMGnP/VASpyTViw7fJRHefonGkS2tI04PKT
	XBOwxpahmg2CP5TKkw9Abd5aia46ajxQyowF73rPAGpHcTaJFDCJWn1p/3qiipxa
	UEeMFNaurWZGzCE9qUUKrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0399vfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 08:28:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47F7lMc7017118;
	Thu, 15 Aug 2024 08:28:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnbwbu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 08:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQDLSHJ2lFvKGDcbh/BxsUAytI1p7TQeUdSIYP7v9yrCKFp+QPhRe1/ey8mp8R68HvK54ASVa2qkTu/V3rZYge9UUbx2vwub/q8UB8gJPFujOy6i7LQre/U1TlNdglP36Pl8DHzOs5SJk3zRYm6Owh4NAS2hkxZBOcOZ4JOD1cE98/2n46R3+RKfnobK/HRJPt86rbi5zvLUmel6LrQrciZAF5YzNpKumNUWDizb4yX0V0JDCTieM66lfTO4KpTCdDS6hrPljHGCfYRmIoTduAWehFwTHV9Wwp8060t6TUMcE+nFMTCXUuO2PDCirtlvkJfN2oDrYuHGtGQ8N22oOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZXINorZSC/xOeoR1lgblJukeobVUKvT9ArDycW4LvQ=;
 b=sgmyllufY8O2QOBOdZDQgypVSfWGvY4Di2Y81gHxDN5r5rq+GZRWGSeiQCS7SscQ4cXieJw6+5NdjKzuq1Or7d2U2tBE8drw7H4xnWSM7PAFxM4GK7atn08XlfuLNeoxsII1+UXKub3aTG8l9sY0D/hZDEAxcU7G25kxtK9lh7/lQD7qkETsuhd0CgWSkiIkM+A0zaGh2N1k0gDcH/Teq7gk9yjpHBJwXijNUGxceF3VNqmNd5uWfCHB0Nm9Ev/WgKbE/K5ZLIz9bXBm25OPX2v0qMlgNjqvn+2ws6lC1GoECAXZrobCccFSNZ4c7tMHZCIHGHaNUqWbB5BVx5hc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZXINorZSC/xOeoR1lgblJukeobVUKvT9ArDycW4LvQ=;
 b=YtFnUK8Wty3zyYwUJxbzUoTvqX9hR1dnssNB1M8C6lvwsIlkl45ohTzl7g5MNnlOFJ0C/mj1IYEoGxJSJO1rM6zDhtKlssj4GE1thwagJJLZsc8Spexrcnzm1rDG4HFq54gKYkXRWBRQOSlrJhecI5A2yzQSSCwG2N/Cbo+W7Go=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Thu, 15 Aug
 2024 08:28:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Thu, 15 Aug 2024
 08:28:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, kbusch@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/2] block: Drop NULL check in bdev_write_zeroes_sectors()
Date: Thu, 15 Aug 2024 08:27:55 +0000
Message-Id: <20240815082755.105242-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240815082755.105242-1-john.g.garry@oracle.com>
References: <20240815082755.105242-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: f59605f9-b6c8-48e1-a3e1-08dcbd04342f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ocfPG249gNG1wrXpi66DZw0b1zXcU67GpyYlbHARpXXeX7jfvISj4aksWHXZ?=
 =?us-ascii?Q?/LR1XweCd60pwaGdDhmGTjphSUzSzPi/wzAiTSSR/2QBkDWpdIV81Sqe2pLe?=
 =?us-ascii?Q?Fm56av+6oCC7+2KlZ/QNCyvMevMnS/U4aBtvEmb/sB78fFPKIkZVSp7SXk8d?=
 =?us-ascii?Q?HgT6QQkO7UKsoyk3VEveH8Ch81d5e1pxRo+4CqaFO14DzrX3tLQmpZbtXt43?=
 =?us-ascii?Q?BWP9XYEYr8jRib4qcgXbrX7dnF6mhqX5dYHfr/jseOvt8RN9TdbTcAAXRoNe?=
 =?us-ascii?Q?pVuFlf2/4oHHFZHbN76MM3gW7k8on2mSX7fgmtvozBvtHjGVUCQP4bPml2tg?=
 =?us-ascii?Q?jWL3Uwl2QD12JbO1m1FyD/CZtApCgke81BXrB0qd7DgOWfc29ukCGbvrowJ9?=
 =?us-ascii?Q?sjsQRfHp+ivNkRW1WAhi9KYhRQiZ8ZatFz2ikIfJvW2W1kpi73K6FBvkBw41?=
 =?us-ascii?Q?DddJhuBE0xg8CnFp/lGVSBtmj4OZzLVI4aLpb1XTiIKybBO0nvrDaQqN0Zw8?=
 =?us-ascii?Q?GAOrVg0oLHmEatYogYIbESgEUntorL6LB3ZfveNWcojIishQ4bHiSjyPTsQ+?=
 =?us-ascii?Q?A5vtDunT1su7Td+fQZi1yoE46U6TfNY4GFv8htUufNECcuxARW6XYkLEZwa9?=
 =?us-ascii?Q?sus/PlZ3VXlZWnYBznsbuHlkmvan9TqzpGQfprCUDz3X9Ddv3I9bsmxXCJ7m?=
 =?us-ascii?Q?UnmV65svyAEMODxF+CGo2eLb764dPUzV3Lfb+yhndOJhXC2wUb3PgwuV+zrs?=
 =?us-ascii?Q?QvX8z8fbEVx6KihXmbx1GnqLPsUlXhvanHgCCrlPzQPw+sksK/5UWrQDRrMO?=
 =?us-ascii?Q?Cmex5CehfRK/hN3613XONEwLrde6FYDWl13gTVwzYuUndgbQUwOdgwnqSVUs?=
 =?us-ascii?Q?Bx9jtboXD95H5K0rVYlUYYv2B+m0hyyTx2Ykg99FutspmtggIFEPFGkVJRhj?=
 =?us-ascii?Q?SM0CZOCXtwBi9A4rVrKatTNqbGXDZK7dHCbufuI4QlkvJv2K+vTCGn9EOE8W?=
 =?us-ascii?Q?B4Zzm4OFohqOiv12IgY23NOjV2F1DpCQuGwHN4PemWy8AkD74NOXU1y5kEeG?=
 =?us-ascii?Q?v3qlV9uZa+wcA8jgk7flD7/L0rfm4VoRUeISRevMxKDdCepl2/0KhM0Ef2UP?=
 =?us-ascii?Q?p8avwOLBaqWux/d05Z6POPBtPqc1TRPzXeGWI+1AEAH//rNmm9oQAoEHOOvK?=
 =?us-ascii?Q?snNU+6Erfurv7Rv6tm6QwK/LlWAqBDD/+LqXwpIpLNqavM+B6ICKD0fOBmZh?=
 =?us-ascii?Q?dfMcTrFwsemoHP+FK+7j4p4T+TgtvkEtOr6arMjb48NoK2mpUqTFk1ez/LBF?=
 =?us-ascii?Q?r+bAf0u+q873MJ8AF4PF+Ca82OXiQUcXmj92klSOoQ8dxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OxVWmIyNhYUIAC6tdOm6zdGwH35bpogp/6tWAiZKkAVKY0wTlUwed/pnKV/A?=
 =?us-ascii?Q?kIFT58I9AjqjkGbQdWR+968MRucNPkYz2W288LUKZz9n7ksRUdGNg9tgzZeV?=
 =?us-ascii?Q?Zja2Mxi2QG59HSWlQ97a6j9nFL9Iq3DdzdC3dmtaLGiGlNtqzYnjCtXo0MmT?=
 =?us-ascii?Q?c19bg7iuUxBorxJtjWtLySzzpVjmDppu9mMWA2jGyqufMLHRvk9ubcomuZtx?=
 =?us-ascii?Q?T8xoBjYbjOv39ppiuBATIAD0g17NJi+8kTliL/xi5T8r4WXq5K3Gta2iGrdv?=
 =?us-ascii?Q?TalUm16FGz9GndsuU2CNHBzndm0iwd8W4FYT5DvKjVUN6QV+8USiK65+Id1D?=
 =?us-ascii?Q?r30gdCJmwtuyUCNN5BxxS26uLEvrePopx2+N5+er1mwZoetznjRXgbwzmF/T?=
 =?us-ascii?Q?0ew/4QQJjrXCM3idcmcrPpqQUwYTzwF/lYscuFHxgQvf43SUUtAApF+YS2B1?=
 =?us-ascii?Q?RdDdGzaLIKGC3oSi0H6psqYG5fXbzmHxuuiScGIe8cJzFeQKUCw5HEWrN1pP?=
 =?us-ascii?Q?GOvD1l4iIhqMsBSWAeZu9elqV8IN07TdNi9LFwPkCcSQFOiCZIg8rRMs8uqI?=
 =?us-ascii?Q?JigufET8xEGcWhp2/QM6pSULLjlIW/Z6S7fb/J05fCz6UQJK9NgR/S2vQbBD?=
 =?us-ascii?Q?mOblG1S0fMLBklCWCytxtDCMoFQbdHclQJXRpxpmkDqoOKRKCR+sNhPwtHh6?=
 =?us-ascii?Q?/aqcPZ+oDymUGHDD/8ajckUgk7/QwalZYFJNeJM0X8QTpCI8YkzKdDa+Sa1q?=
 =?us-ascii?Q?NPxantwHCrj0y0nwQ0WJE1NPJeQ06GrEE08ap6uupCaJAXgmMxFR59KTbmJl?=
 =?us-ascii?Q?te70yKA9itZZJ+Gqo2CJIVlLtnrs5UJ8MFyQFbqG3hoAEcMxEzAayADVEDhO?=
 =?us-ascii?Q?xZg4QNhRX2a3Lx+mlnOxpFejYQCxfwblPf9uLwNrTs7KyYrlVObUyGo22W2S?=
 =?us-ascii?Q?VBCqrvETE0OvQmsiIfl1HoLaPLuBZsgfwtH3JW855z5m2vjHsgdlNQu+rgmE?=
 =?us-ascii?Q?99qxjRMy58bI9pj9V+UXfqZBhQfR/FANl/oClx/yr5cJpzzs5MSJmzxlzt+S?=
 =?us-ascii?Q?nOPa95z3H2AB2oGHBQ3DJi3D5aFzlj00R/tIOpuVVx7O/sMRgBFAosVVqTGj?=
 =?us-ascii?Q?WiJrY/6cZ6hirguVbhe0zPDtSPY4ZtzntZfct2DcLae/3y4ifsByVmxZazz9?=
 =?us-ascii?Q?q1KhqhwQ3zOquAnNUJL7d0hBrX4QlC+hdtBm6a2KKODMsZ5jSkYXa2+LUVZ4?=
 =?us-ascii?Q?6DnlbJJ35aqDbMxMXXx5aPEiOyytuZCeKth1wRh1c9Hqmz0NkSlZ81y38oTQ?=
 =?us-ascii?Q?AJcOkQPTNmZV0GNLMiNnbMWCftpOmWS9TDkqA/JGjaRcvJOnbhxQhy6Ywb3Y?=
 =?us-ascii?Q?7ZWc6hg99yybbfSVlrOENRol8LAYhdwj7mhHxM7DiESbD8ab94f+/SoHQ8eO?=
 =?us-ascii?Q?gqwUYrxpiA71qvyLx8icJHovdiLarPdfS/9HEcj4iZ+HO8dKrWd4BbaIdAkX?=
 =?us-ascii?Q?/p4eWtQpHqSLbANHIzo1LdV3xZDmZkMXnYzIMwDRj8LC+yuXhlc4g+G3W8BU?=
 =?us-ascii?Q?idfAUNCDK9cRH8ubF5u3Qzfaq1nfiX/8y+N3SnrXQYbEFwP9grr3IIkmsWXl?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bHVmfyzpYrx6GLJ5+FGoAx+5e519D9DFmtl78cDQ7xfVluKGrxfannI3yBmbod1BQLDthoDuS0gSPmS45HbALGR4shouxsOY+Z5y1coYjruAS/ip2ahGN7PUtV1vZd2MXnMDqveGHf9zlbb1pV77wC+nHJTXRXg2W+DIAPz1ezv3dJvTDvgSVpdXc8Ej6cHhgbfzTqJzZngy3gX1kBq8RRhigCJn8YrN89/hBppYbmZ1QmtuRsNCa09yscmye8Q/oRMT6jF1urIlZYH9QVr7MFiStlz20GOZWtmM5o0jH84tiwDqnhhQZJDq4FDKz847T0Gsuek3Nqal8OanWxpygn7AXVTforC2mssaLO1yitmJWagl1W+jjSo/0ymSpeMKh20SSwsu3hxq7czPAfTt1p/8i9FL40PItHcoFHmSJt9tD25undsdugc8nqAfW66Aa3QHNIbfqEPKmODIh5ptbgV3Zd2O6aUXtoG0Ro8JPdWeQC61TQgrIFigbgo0n14qkJ+FcK0BIRXZrn3+WXlumr7OxHshh7AmIFh7AqglB25goB1wXKlniWTD/lAMCCPtg/s0997E+iPjNskUcVhHA2AIhUtqGoCWGYh20uT9nGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59605f9-b6c8-48e1-a3e1-08dcbd04342f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 08:28:13.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXjihynZ6E1oW3XhpFctoZU0EU8tzeFnmkUEhgJno72k7206o1c7ugCwq6oRVDTPtyt+F+R4hT911bgoZt6kYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150060
X-Proofpoint-ORIG-GUID: I-4fbODZXhzi0jEOQCVy2RbekbdKvuKL
X-Proofpoint-GUID: I-4fbODZXhzi0jEOQCVy2RbekbdKvuKL

Function bdev_get_queue() must not return NULL, so drop the check in
bdev_write_zeroes_sectors().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e85ec73a07d5..b7664d593486 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1296,12 +1296,7 @@ bdev_max_secure_erase_sectors(struct block_device *bdev)
 
 static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return q->limits.max_write_zeroes_sectors;
-
-	return 0;
+	return bdev_get_queue(bdev)->limits.max_write_zeroes_sectors;
 }
 
 static inline bool bdev_nonrot(struct block_device *bdev)
-- 
2.31.1

