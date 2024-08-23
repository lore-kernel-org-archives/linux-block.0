Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55713A88A;
	Fri, 23 Aug 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397990; cv=fail; b=VeNxm+B5bOuWoOhwTCR8nzdEb1nEfgvXQxAZsBmo4d4p5KSiVHLgqaFdgIM1wa0TLOAhatn2wABy0+IVQ/OFP9Rwql1RW686Qn/JKVGQjv27VfG1KjYC2Vi1cOCufSZdIzqrRoCanh7fycPFTmz4fugIebWDggwafCgdNVbX3Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397990; c=relaxed/simple;
	bh=0+XuJkGpet6jyhnul4309jsZYqJKsQGr+vQ9rN6Ub4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tkCqRkyus5StZVjDOHwzVkvB+TrbzWjLPyitdMx87z7xH000wziobHHTnj6GDU+bLJy+Fpd3asD7+pNemr7kRmK7u1/Ff7kpzh7Y+o4EmyvK5TGK8dKkOJAMrQ4UUWUNP8zhk3wphKrbns1skTAu/+BOzheSCBPjfMAhT/xggwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=IKNS5U1d; arc=fail smtp.client-ip=40.107.215.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="IKNS5U1d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDGSXJ5xZklnr8aie0IZeuLTDvOU/H7ELqYFGvvmNhrBMBCGknwWTIFjXzle5LfV/2k2EerbW417zCmgtThYroYbgtc5LV9INg814nPBMycWsLWI8NECAS5TFe5h2Q3oItGi5Fl+jUxgDiP0K0DXIUT8k9o5iKn9HC5+3MytIsuun12aGKx7GK3lAaiwnx57/43VtLjFeRhyLFOM3qLOwk4UjexaRab9HPgSxsY8yQBJhxDGfIMSuAg3AtUE54L/6q73KAZ4TPCXMIdoq1wPhiHhvHCKWq8haa8/QasPuSxv6D3sPbRi5N4kWrHC8m41lfn5ODMUEzA8MqenY5B/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtZWPArHnnitCoO8CCV/m4x/YrUB0QVkPZ88KCMyhXY=;
 b=QsUT46JXF7SSrGS1+sdn9yilwBP5IfTh+1nc9bE1ZnDeQjdBSDSEkeaZx1CQoKCFbekTXpVXoN64J38YyNzf3vnVoNdRUR9dmV/P+znUF0P5E8n2y/chj66GCLyVKWTGgEyEQUGbiOYTANRNw+k2RaAu0R0wuk3TJdz++tns/607JknZkNqsFgZw1B2MuqJqiFLW96X0n5/Bci5Zd27jgH2W6JN1zbzETTQGhEXoGeTwEivB5/3l5u8xOJ+e0RJXW96rS2Y0yc/puZvuebdoh3NWuwEtC9hyGwJ8VmLWu4ZBMsp0O3cmBWO4mv3+R9VKKJZAkiEm2KLbPe5NoWFYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtZWPArHnnitCoO8CCV/m4x/YrUB0QVkPZ88KCMyhXY=;
 b=IKNS5U1dQiVwN5QkfCyJ9FQLgcxAQRBtufrUk5fiTq+YVODKBqYQzGn4ythNMCNCamk9DxdVT7RGUcFTW/4DfuWTOio+tKw2jzaPmBofSyztEUq7TE+E/eqZc6rbEqBKOrYOL06//1MpR0wS/5ra/4I9SFynclF0W3Njjj8gl7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by TYZPR02MB6524.apcprd02.prod.outlook.com (2603:1096:400:363::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 07:26:25 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 07:26:25 +0000
From: Yongpeng Yang <yangyongpeng1@oppo.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH] blktrace: Add 'P' identifier to mark I/O with REQ_POLLED flag
Date: Fri, 23 Aug 2024 15:25:29 +0800
Message-Id: <20240823072529.438548-1-yangyongpeng1@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|TYZPR02MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: cb403c21-3720-49af-757e-08dcc344e533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYjXoJ9ajETnrGO2MoYnTUd9eSq2bwviUCqaiJFMZspfXFrH+juXrgrI5Pp9?=
 =?us-ascii?Q?0vDeupyx1VZDAwKlaB0e577qna9UcGe9AasmDJORm7fBABiUmKwz/QUsPYWS?=
 =?us-ascii?Q?bvdYEt/JLtGAIcPEL9+tbOlr6SJxS19GGSwyFMaIWD0jlMb4o4ktsdK5HR/n?=
 =?us-ascii?Q?bY5XltYakabXCLE246RkRaBkk4Y8dakv+7f/krwQZ5RhF1PLx6LjIhPjcw1O?=
 =?us-ascii?Q?WYLF8AyCvb8W+YBS6/ZKnGuuq2pxBcdX6gjFGTMg4mt99h9JtMBcmVBsvcjr?=
 =?us-ascii?Q?1zdS9c6OBX/9z+em8xvxTXd0zu+KX/ATPUszXune+XTi/cByYXNdZIl6KCBx?=
 =?us-ascii?Q?6fYfZoaBGF9EPKGyxb0dO4UEZfD64XssfhS1lWqu8jcsDsi+B5ganu8TY4tJ?=
 =?us-ascii?Q?TzNPpGgMy0LnGF8CpNF+3WpiB0VS/nfmPyHk32A9gsvlPv4IT9ARxmHHl1i6?=
 =?us-ascii?Q?39nW0n5I3OZV+EzbU0S/oD8ji+0d6SkgQARU2I5Oc/EpRPM2tdWarSdC9+Ui?=
 =?us-ascii?Q?tGrjnODMPFoo1e+RbyH3e0/RtFnqUH9qJMBD4YoAWik/qU9mrdFZYm47fDaL?=
 =?us-ascii?Q?g+X8hwtqjeBPsn/qP3jgligVGJZTPieg3R4v9b2KfbW2vrvGhxGwCjqk0GA5?=
 =?us-ascii?Q?U94mVcFXnE5uBVIgOh/hrjZyE3giSjUYRzcLxWYDLVsrmPioaCnaXogn6OuK?=
 =?us-ascii?Q?zSaQ1xeXFNWLdJ6osa5/FE0lUFUY0adn6YFPVe4DRNjV4xHonZEn9ABP6Yek?=
 =?us-ascii?Q?G4n1JWbiPBJSXyOpEnqHRIrRi9i+lmPRc4Qr86/S1KIvUnRmmTn5S/nxxzJK?=
 =?us-ascii?Q?/2UBSQCZXZFqgdXtePBNF5CfBbIaq4MDUWi/1LQTAh0DSeQrVDmYJWiv6yoy?=
 =?us-ascii?Q?9knds9USd623idn3XtjI5KNQe4lI5YoWIXFaG+7ETdFSrH2PXN15rhmb9YHb?=
 =?us-ascii?Q?xC3EwIvGPEDEf+Vae8ZOmC8E5KThzMf79RP3hkQ9e2p2dZ5gydgIKwO0zslD?=
 =?us-ascii?Q?PEZ3gIO234wDzFzkSaKXr77s+dun03AFHlYs2qaniglioz0jAaE7tsLiUrzQ?=
 =?us-ascii?Q?IzRw46qJsehpY+2OcSotlyKwW/bDsDD8jr7MItgeGHlW/WD9q/JE5T06rVgw?=
 =?us-ascii?Q?RnjXWOAYdZXj2ic7uHewKwYAHr/fTDy0kDbHUur/xAgMY1CqZ3ufQTBfqTqS?=
 =?us-ascii?Q?qP0ZQR/GdtIaRdlgBIq/MGFhqFZ6j/ni+yfI16namRT25bLXxsZNUrsjxczO?=
 =?us-ascii?Q?2U9damZTr92J9HJUv5xdX82mRmCrM2Wa2Jy6D9bP4vWLyAFrFtWrIkxD6LB8?=
 =?us-ascii?Q?tHVZg3kCnq/7OsJd6+7S6ZdV3oIaSHMRjJA74BgHQIhw+LJ3VwHryRGYfaKr?=
 =?us-ascii?Q?KrbLeQfgNq06BLeAeYvfjPe9rUarxRc2LmpqT5osz/bUXAbg/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fSDXGx6aWHxWNDy0e8mNnU2yHrcL4ZGMkBNV4zGfo+Tw9P574kV92JfgXM4G?=
 =?us-ascii?Q?r7jts5PBuzq2xlmjhoTo9Gkw/CHcajroFcpax8g630FWTyUlvdkwlTd0UMsH?=
 =?us-ascii?Q?kZzPQOaadoe7LxuUGz6VcQLin8yKcMcR7FTW0yv6soMdSVRubNlLmFSVHd43?=
 =?us-ascii?Q?g/UPbRQd56UXz3YcRXzfwJQjKkiIhsEqlyGWqB5QAlf/ylorGL79ACT091vO?=
 =?us-ascii?Q?JRDOG7pOX9m8Zu1fVFqC3iV7wGmdjgXh9WAdspvN22ReIo5LGd1LDBpxEPK3?=
 =?us-ascii?Q?oP1xWW3TxvEvA+u2skMeWLNzIC2zWMewH613+P24BQM9ECton3Y7/WdMKQgw?=
 =?us-ascii?Q?yOn/wGT7gBkfTzL+AIMyDJoqNThzkDtqN5EfWpiE8TcNQRdcbC5q+I2DE02b?=
 =?us-ascii?Q?xmGfTwRH/kvSAW9BdNKKnLYUILHI/VVTbymTt2tC3vk+EsVa1qTc6XLP9EFR?=
 =?us-ascii?Q?eEuP0+IieipThxuX8iknIt5wiLnKpZEAV+VYB624IzrekjYpfbj6PhVaJCSU?=
 =?us-ascii?Q?1UxfGeVCfuEpQE97wDqNy5Y9lp0LwyPkpxlU6osi3Sc12nDdxPIGtAfdPIMB?=
 =?us-ascii?Q?Q6xC8JPSHXfXN8LcSwrC1jXJRzRkF/hE344OGLyVrv0wQepa1K7J5rQbxM8J?=
 =?us-ascii?Q?Ns3eem/lGR7K10kfli+c4utjvuCWBynXKmrVo2igdZUpS9O0EXcfm5MEpvFs?=
 =?us-ascii?Q?n4wxX8nwmnwiVHtQ7/m5d3P7l6vMukNigLI1i5XqNqClKeNMqpjzPlZdwETh?=
 =?us-ascii?Q?mGNt+KSf4rEgvziQqcdQgU1zmfvUQ/1SRwPncNrDoSTW0BJQXDbgAkNtSrhv?=
 =?us-ascii?Q?xrFjZzpMulql2f3zrUjm0NAqBErksMHciUs95kvOBU8ekw1zl3piURkrNGHo?=
 =?us-ascii?Q?ImzC5VNeVf29pqh+0lYF4WGJkgU+evsx6QFMK7KLKLBRqLcOkkKbU7HYofbi?=
 =?us-ascii?Q?L0BtSOdlthxAYqJwseBC7yl+9j4bB7tnY1mjkcoNoy2VtmG3am/FwkV1+mOu?=
 =?us-ascii?Q?mXlsmUF8RufzVJhJs/PXj48XXI44ipChW4Hh6zJJ7gTRYKormHJoPQ/8PCn8?=
 =?us-ascii?Q?s7+TaLmpqOgEy/pAwwEjYKhQnFySczTCb/Cma1VwsdKHZF8EQU9kKM/ZnEi7?=
 =?us-ascii?Q?cmfOKEJSITVuyMMvKu6E0o20GDojjHYM1VjYJFOZIhD/PODIiqRqHKC8+Im/?=
 =?us-ascii?Q?hKq2hIoBvN9YKuSB//ABDSiO0lsmcy7YIK25o46h450ZbhUDbbXxKCpG2fOB?=
 =?us-ascii?Q?k6seCP2lCeeD7jr9JfSoFgu36opzdlQaxYkcV+ODzy2Y33loZ8gMLdglthTc?=
 =?us-ascii?Q?Ox23tce/XdoA323eMWgIDrNr8BywA8vJpameXKir/5WY1pFdzeP8PDZ6mFRI?=
 =?us-ascii?Q?xHKiviT3v8B4gogFKehbJiytoajuP+1jwKMS/ajD2gVEimRzCBceiK8+w7N9?=
 =?us-ascii?Q?V9nTWfgAqW3M2P3tNqVCQSiD6XJmlSS4Qc4tNxqhHShrlMFPeHjnsHndXkBS?=
 =?us-ascii?Q?NiT9SP9QnpiOku+uZqhEUtLMHQiOwDFOmW0/xf28A9bF92akzfN9/2weDflr?=
 =?us-ascii?Q?cAORaKbzrVe6oJkL01z17J3ORs2+UczBLGGEaH+5RWT4F1FK5tPqbTP833a9?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb403c21-3720-49af-757e-08dcc344e533
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 07:26:25.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGC/kTOs2zmdqywwDDbOo2xem8lpyjQ/f6QMnKINbM0s1uHBR6y5YScKf7VEzCcJNxt4ACFjVXL1hFx5pYcWig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6524

blk_fill_rwbs function currently does not recognize REQ_POLLED I/O,
it's not convenient to trace the I/O handling process on the
HCTX_TYPE_POLL type hardware queue. Add a 'P' identifier to 'rwbs'
to mark such I/O for tracing.

Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
---
 kernel/trace/blktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd292d34d89..69b7857d0189 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1908,6 +1908,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 		rwbs[i++] = 'S';
 	if (opf & REQ_META)
 		rwbs[i++] = 'M';
+	if (opf & REQ_POLLED)
+		rwbs[i++] = 'P';
 
 	rwbs[i] = '\0';
 }
-- 
2.40.1

