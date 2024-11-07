Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E081CD2B
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945158; cv=fail; b=BrMSorzARHbGHPzB3/7lRPB71VyrdeEfKzNYVuRhD5PVBvMcMmrrDxQFzZtiLYL5w4l4Sik+BEi+aGbc9Io69QssnFJbE7zBU8G6RhZjjd9W4h4/vuigyY6hoxypXYHBXSjYbhgiWyVfkHi1G9X6vCzB5KkqALyELJph67sLd/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945158; c=relaxed/simple;
	bh=YeZjd5LU8V0RcdIZ4iqkGDombYMJo6JpiWJp5vpmsW8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UhmKeqrtZM/EIeZ15NiNk+NItiW/ffHjQ2g/ej3ufwFOY4f9zObhBw5oo6Hg+aLzSZmZlvKePiK9nbKmBUPCOSh82iknWvuMFIibVoCTSt2o224yLN1gINabYxUAzW4u/KwoJ5xAok0cdYvRYKohVE6M9VoAstV3doPndVwL2+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=dXEyEtp9; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="dXEyEtp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LebiEvZwF7E3x7qkZ0K7sAzXI1Lo7n2X2WBQ+3aamM3ld8tZMHHY3qZXwb73fiRpZoizfZjpuouk2bSL1Kxuki1Gz11ODRTgGZVcdAJlnVy88UjaUQQDXVglwkLcmyjaCJ6iithGCBphF9gkEloLwHY1x58l6aCifn4xVp1ZOhw6K3oLZZdi6UVZy3vBv0Paym0LupGgTytxu9CZCY20E8Xqq007XBwl2UTIsoDHSM6M7LyfMKpxxv7WfRAiVqMpdKiefE/yrMAUqjMLRr5ftsN7pphEyeEJNRzDX1MKDWwnJLkIBsmmrj6N6tY4Hebduw/ZFxIQ250QPNgjzCfjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM9/m1PiCOQIEJy1+38H4872vwKA+C++A6JpsrSfeY0=;
 b=lDrL+p/zAR/HZPZ2C/i4E6OKdChCqXkYMjAAha+Jjxik0NNwkDm7N6I8WveIWQNsJ4Ra8jOHChiCfg/ZaTt/D+JKuKrd23aOMqKZ3fzr1ldm5b5uojZc8HqkiihtFq+4ZtmV8r7ZYFLzfbSGzdN9GdoJQXTopTogGl1c9Z9Fo4FDnrKIaXA9ufPdM+mBSfQy5wiaObw0Qu3EYQpuXQDPdyrooW63p15JP2NbHFLVzaoS8wASNmXGfY1CeLckzenRjgNtgfmbDrPmlP47iPa3IFADZqwBdzzLmYxD8zN0f1nP/WveLDeJgaPpi2C86iKmG3NQGWHOpGMrensxAhnv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM9/m1PiCOQIEJy1+38H4872vwKA+C++A6JpsrSfeY0=;
 b=dXEyEtp9wunaJhQ89dtTunsFrJquuZXuTKSxMFVxYH6SMP1wkxy4cvdPWDGUxRn6mOosvIXsWeujGPKiwNSjFJznaYinqgzethpcxA5+NBpkLBVKpZtTZbWxObCv4CAVSvB7AgQsCYheygs98jBTmVRL3BMkt+05E9Rxnm4Gv4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com (2603:1096:101:22a::14)
 by SEZPR02MB7688.apcprd02.prod.outlook.com (2603:1096:101:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 02:05:46 +0000
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b]) by SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b%6]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 02:05:46 +0000
From: LongPing Wei <weilongping@oppo.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	bvanassche@google.com,
	dlemoal@kernel.org,
	LongPing Wei <weilongping@oppo.com>
Subject: [PATCH v4] block: get wp_offset by bdev_offset_from_zone_start
Date: Thu,  7 Nov 2024 10:04:41 +0800
Message-Id: <20241107020439.1644577-1-weilongping@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:404:15::29) To SEZPR02MB7967.apcprd02.prod.outlook.com
 (2603:1096:101:22a::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB7967:EE_|SEZPR02MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dd6501-fe38-456c-c7d9-08dcfed0b10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfEAySrydqMGc/+8YAr7llgoOtzn41I1hRMDI6qmMmPlMsZb1VAgKciCUO6M?=
 =?us-ascii?Q?6UeHLtzj57w6QpeFV8T4uVd0KSO9F9zLUHOTb9EZRWv1T1c7omM0d4IJj7J+?=
 =?us-ascii?Q?7nlzSuNf2YBBhWdcQgRhBNatjyY+kKEKiP6ZqbvayQqzCiIyy6A7kscL9MBa?=
 =?us-ascii?Q?TRoU4eLX8lJvHP65ZL1kq8SYMCuGk9yYhjbEyaPFd5aTkCcKFBKG4ZSrDT0e?=
 =?us-ascii?Q?c0kAk21qlpYB45+jAmYdQrhgdLdXv+iqab/U8VoaDclCRSe2qW2jnhuq8xJl?=
 =?us-ascii?Q?P1TdK2e+F3P6we4finyhx184GFFY41cFd7IjguPY71VeFNs8gjRcLjVpSGj+?=
 =?us-ascii?Q?HFCZFYQpv3e/XFTnntzTRWCfP2ur06QSWzX9rITJrwV3NuGFHlEEUdLTG5Lu?=
 =?us-ascii?Q?26Vnycnbp38dti1GZ6+bZB9IsH9GdHw5ke3nI8OlVeqFTppXrehLHwsGIakQ?=
 =?us-ascii?Q?wFL7svXSb+o3aP+wx7Gf0P4VBBrqxiT3DAhVcv/ayV+Hy9dWdu5q1K3hokuC?=
 =?us-ascii?Q?FOdbn05wkGR2USWUIIOA2HCx0xFQmv+NH1zUyWivDTxe/er38wWH4nUwl8Sj?=
 =?us-ascii?Q?Wp6bnzyXgVaiW3y6U3F6AJO+32N9uo2/mdZplozyjnYFGKHh0xkx2Wzpet8D?=
 =?us-ascii?Q?C80sqc5SiWXqHwoveJv7WnExqDbdC7xAVSicE/2OWrhqdC9SoY8pn6iN2dp4?=
 =?us-ascii?Q?sfn2d9qzqGwqJfRx5RkBmx5qx6aMs2ACRqm1uc1dDNKAVNYaLqBywqYaYMb6?=
 =?us-ascii?Q?RanwEopUG7tb2mb0Yqz7fSZYFbObReTbSfoLZW61bwqGcAmvCHd2P42Bk1iH?=
 =?us-ascii?Q?gERlyg3cVITiNzFNCWNnPgTm1oNetGcq6zU9RyR/F2kXnPAq3TsewolpN1LG?=
 =?us-ascii?Q?9Cnd+6ybLuMJmw4gztHD3YT/MhuXSbpXqHwDHS1i4QBj133btin8EQWG5nyI?=
 =?us-ascii?Q?3mCLbWjgRYdH4XA+jG/qkbDJDhStwqYDGRVr5BxMS5CvBs6s3f1ZlhqPm7Cn?=
 =?us-ascii?Q?CSB0yx0yZdjnT3M4WBLtWgX3uxfIXqra6BO4X7PiJgdaO2qzxJH4Ha+LGn0g?=
 =?us-ascii?Q?QT+5HqnZr6xNnNz6GD5y+36Iu3Qh2VFittrMmyVQ2Z5HIDJ3rWct2vLweqYh?=
 =?us-ascii?Q?U1B5inlU72f30lvApRwwOuzIdUIWAfqRkczaSgKOMxd62qtyspAydq40PCKc?=
 =?us-ascii?Q?vL0nHeIgfHB0Mt+GjyfVO4QdKvJaXDLUW+bHWkLozaFyOj7Ge8BcVbbbutId?=
 =?us-ascii?Q?MhrTCZikNfvD+AcMTigFlHF+W2cBXR8xZG1enJgA5MWzq13GbW/v7hZL7wNe?=
 =?us-ascii?Q?1jbNDoQa7VfyBkm8iVGVLKyF+0xEFnf3pgL8ZIRbL3HfIe/DarPY5H/9Tpmx?=
 =?us-ascii?Q?CfTk6A4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7967.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FxjJi1TwW6Bl6OjJCiJ2UybXL8RRB5/2wXZLL9zAiqIpx2X5ze3VPyoXlNH+?=
 =?us-ascii?Q?84x+4uCmltI5GOeaVQYI8DIEttTbEz8OJvhOpY0p4psiQBSqD2wPhR7+dpdq?=
 =?us-ascii?Q?9mEcn8ghlcdLiE3DtLzvEBFg+wZalERWRjPIxJsd1sRjIRcUmtDF7aP4uApa?=
 =?us-ascii?Q?UuCQ/IKNFBsL7GmN2pQ1rnbJneA9kyCbcmz08U6cDCke48tcjxxethgQGqkU?=
 =?us-ascii?Q?ceKndbz5qzrTX7Uhidz+z7SV1gOV6HHwYydlTM+z0ugaASZes17RU8HJcllD?=
 =?us-ascii?Q?DIndGlLK0JAm5+OiB/Xo+HFaUB5pyRCesohoeklFdNi4QSI7rImO5NBqv0t4?=
 =?us-ascii?Q?/pylhrzPdFKSW4R9NiZUr8vQRecA/Sa+S8Al21SPHg+5vYSqeyRdnYH5DyKN?=
 =?us-ascii?Q?mRBwEAYGlKhPy+RNBaPtzIEBr37VCUjaRltn08KVfhqeO0Vvjz+Cy/lGFC+V?=
 =?us-ascii?Q?ZQay7S/YCFyD9MzU/O5siWLZx9n2R79HYSllCNds6+peDtUmOuoiJcWSaYjb?=
 =?us-ascii?Q?1QiBAYgRX37L7//8ufrSICHzhCHNDaBvNmjQjFJfuMd2s3SwLvKyhRwHCwkI?=
 =?us-ascii?Q?xBLe1hPcUDj4GIT0NwHueXOJU+HAQC1cKl127/PidXIO5uiaPN/MfMA74Zjz?=
 =?us-ascii?Q?6Rh+hF9FZl2gsm9ZyENA13vhKqkuSAbVF7h/pqWK7M4Bfg3S+GLPvI+URVKE?=
 =?us-ascii?Q?WwlE2T2SHzYp7uJSjH4v6QasBS8LpbTWszW4gm10ecofEot0MBeTGWa6dCQC?=
 =?us-ascii?Q?wtafKXD2rNhJYqDJKJkgd+J40b1MWblh46aqDrB+yKmyIYH8RStmzn37WuGb?=
 =?us-ascii?Q?Sk/ZiKWcgYOKlA7DHwwWW7h6dCXg6RpZh3+I7Zdl652CZVlUkWjYHW4Yfhrf?=
 =?us-ascii?Q?6dwUKup0BxuMh0ZDdpDsROO9nOEqGL/SVNBA7SGY2VPJkA0zt69rNJ6h9Abp?=
 =?us-ascii?Q?jOgKbpjuIPyOn5sMRHfldnUO77x/x/UXraxMrG73Xzc7MX4XJSAQlaf2tRva?=
 =?us-ascii?Q?7j2YUWLwl2Oj14U0gwjk4gaIauDAAhMaW1sxFseo+KSN7bJS55diWlfCVGUx?=
 =?us-ascii?Q?QvLZhRJmplrT/3Al4fiB3hnseHzAtBxW219JvcAyIHzYn0z/pfG/JKRfoKCj?=
 =?us-ascii?Q?f2zpTKCS/+oZDPSjPCe2zwLsHWfxTFre25EbavA16pznReka/gPF4mnkyyvo?=
 =?us-ascii?Q?nEIvf4oRMTr4M3wZKD0V2xBdUCUdo1YYqso4BITyRcn07dh86qeL9QvhueB0?=
 =?us-ascii?Q?NDGSksQow37BAJhwzCqBwxiXe6bnqoX0xuPjaC+w47UxRJvY/hnTpsMATUNX?=
 =?us-ascii?Q?/TWI6R23ujn8TuJaCve8Apt2Zn2ALeYFnIjwECt1QnSFvRBzWpGSlhOzBEVT?=
 =?us-ascii?Q?NpUP79K3FBkP0BCOV5ObNQf1jaA21Xb3XVKhwhy+ommrRw1St+fPPQhU0DPK?=
 =?us-ascii?Q?bec7EOcTf67tiqTNdib1ZzBoNHUkhXWcWTvWOsdG+5UCivZmDrXir6FcwaaV?=
 =?us-ascii?Q?J2NzhjqimVdqGtytmcjaycV+s49cw8sWTadog/Cae+j4PdJWbYL44UrZi/sx?=
 =?us-ascii?Q?fGSZHTJpVIzWQpVY1xH82Wt0yROUR+CuDzrD4SLR?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dd6501-fe38-456c-c7d9-08dcfed0b10c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7967.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 02:05:46.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH04FYGKYdEpKW/U6Wi5W07Jbh5CSLMex0ZumWUw6Z+1JEmvZPuRRDrYlWQj9qoyXwhndEQ6SFADi3ywF2uHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7688

Call bdev_offset_from_zone_start() instead of open-coding it.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: LongPing Wei <weilongping@oppo.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
v4: update commit message
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index af19296fa50d..77a448952bbd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -537,7 +537,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags = 0;
 	zwplug->zone_no = zno;
-	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
+	zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk = disk;
-- 
2.34.1

