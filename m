Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9A1D150C
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801592; cv=fail; b=J1Wpd7hjzjfsiohi2DDB2vuOK4utGV0qUCjLcR36kblixms5k0uwoHTkGgduTRuPcdrUElB7OTwVVcVT0jf8gYM00Q/DOwknjOIdGS3Dd2beRRZ398GK/0PFshSlo4DRXwxvHFtP98FpCp1gcnITa0F4vU9QPciyVCzPrKYR/Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801592; c=relaxed/simple;
	bh=HAjG7MMTBu0UtL93gqGR/n7xsqCSaNfaePmWyvGN29M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s9VOgAekzp/Qd0DOY0tkTyjMAbslrCRb4sg/EUKrtF4HILhYKL+Yp8GwfH+loXz+gCkAXEN0Ls8kmPanXmEAdMoUbRcd3xlss2Bc18u1R+QF51QJ+MiXlu5dWVtWMbLkB/mJ57YB6NVa+35AQfFyxchW05IhmPwkeJttgR/efq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=MTXDtsV1; arc=fail smtp.client-ip=40.107.255.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="MTXDtsV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neWui9MiKgWKW1PnauVv3pbdxNnQikbc1SKTxgS/XeJ2jBTUMvFTpeqxULID1UtQlRYoLY3aDIdpuUQusK9560K/aRcRC8X0/VzK8Pqg26Xd2CbjxBMaDySAIG56al+bCFoivGrvTD1oBEYsTaKVr+pzviKDuiPFicyQFwEVM0aKTPDMGAvbkq4k+5kcMlwbKuBGGkVQdFrcenbMZQ06fxlMhCnZChvEa8TTxahPHUotjJempQEYhXWgIvOcwcQ5q9pwDAJP7JaIdrzFlmDKw6iHqz8yJuyI8HmhkPeVQV2AbjX0kLjmKF8o0G37HpgVFJhDu60OZ0wwFKCuvVtecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAMVHpHPhQDmYHeTnVlQ7VEQD1N+Bn9v9rJOtfUPF6M=;
 b=XUhIlhOfiTv9xAu5+AT/k9H0uzauw0Iht068pyINkqnfn5DeYXmFbuiIkCSNa+c3FSoP0aWRCdXEeLDO1MU3SRoJjcWhiEzqWse88et3veQRZ+hdBo2/6smzXR44lRLDFXskPMmQH79g8WEyuFOG9F419GXQKYLtFU964zy9igdG1NY2DX13mDBoRpNp96kisltrjX5NV8RLqeM5tjDtNvekPI1Zq+Hqn7wM7SKS088T8fH8O87XvpGeNY33vkTmcZWZ0YB2WKLGKMH9hQidALKLvyGRvgdGW3jQqwtT2Hfou3x1cLW46creJJCZW7Qxe5vSZOEdAc0WjbZI9DQkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAMVHpHPhQDmYHeTnVlQ7VEQD1N+Bn9v9rJOtfUPF6M=;
 b=MTXDtsV1H4RGvsKaki6A9cKPTDlN0Ns+lGQGf0UVFbje7GLM02bAXfDRL6FsK24LvpD7hSgy+ZbQo7P9KnIPp5Xd4zDG1jyGAKofrNi+vLfyymcnSKabdVpxeMI/dg6Xy+yma2nEtMs1hG5Nk4S1xqBtA6AQGfsNOLcHQHuz51E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com (2603:1096:101:22a::14)
 by SEZPR02MB7565.apcprd02.prod.outlook.com (2603:1096:101:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Tue, 5 Nov
 2024 10:13:07 +0000
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b]) by SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 10:13:07 +0000
From: LongPing Wei <weilongping@oppo.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	LongPing Wei <weilongping@oppo.com>
Subject: [PATCH] block: fix the initial value of wp_offset for npo2 zone size
Date: Tue,  5 Nov 2024 18:11:22 +0800
Message-Id: <20241105101120.1207567-1-weilongping@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To SEZPR02MB7967.apcprd02.prod.outlook.com
 (2603:1096:101:22a::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB7967:EE_|SEZPR02MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6c2495-f3b8-4895-f30f-08dcfd82716c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kiG6+O3kBHy2A9Gi2YTbaHjBx3xqZjSxe2ir+mFN07jsLrPdVHxmeec9wK7/?=
 =?us-ascii?Q?czRl60dhpaHDdIwV+iUO6Df5xH+XBNJjKdbQH9QVTby8grjkSlLhSXdvtdLR?=
 =?us-ascii?Q?tvN9H0aA1dpa/so/p7jLTccEhomPe8pcdOu2DbOraOjKyx5AxtaQQxq16eXr?=
 =?us-ascii?Q?KAldORKlXY8PeIufxdEIeTjRhiM5+1JNNNxsGsh+PdKqhYM+QKLCoLqytXAk?=
 =?us-ascii?Q?VrawU8E00SoQc8hTyf6bHMAsEqPqrXD8yGLG57mEV6jRqfzng6/nHOrptlFD?=
 =?us-ascii?Q?FqqeOp56ltcL9Oq4WTlyFxyLd/F1xszubPj2IIJabIWLHTEXOGroAob82+/H?=
 =?us-ascii?Q?44RWWt6zZrdQaeCszjcf0v6Djyk2wNm5Rw5183lZNqkuSP3+MIbQvQmDDhxf?=
 =?us-ascii?Q?jE3Ntxfa8NBL3H9qDC0mX83hQlqjKoujMaZ4x+uNomv1aIJEsYHFsup9mSsn?=
 =?us-ascii?Q?gTXbjp8meR5eAoSg1EEOlGpyoT8PvpGAzxFrZAuRLEP+Hs1xbsHD6sOBT0qB?=
 =?us-ascii?Q?6Fz4xhK/RyGmCye5QHaSxUMRm+0MsQnI1FNThC4CPo4Tb2+jv7E6LzOa4axr?=
 =?us-ascii?Q?JDcmfI1AtKrmmC6RSu8fRkairxTv4z6AOolMRgXZWPFRHiU/NEPXG4wsQaG1?=
 =?us-ascii?Q?h+F6+dT6CQwzb/+d6TC2QOLD0YoEc38VhCGpcucbHaMGi9qIIwaaewFVh291?=
 =?us-ascii?Q?2xOIGb2RUIrcbdyO7x2zXEA7+ruR0WhpsELuAXrbvWzr8cK7HNtOoYdcVBMi?=
 =?us-ascii?Q?N8Nmviq111tBUDTvM7OsJnQq+qOUOgo8BXm8VUwElsCIs4kPOtzEeZAKbUFH?=
 =?us-ascii?Q?IUNovKmZ/kaGWgNj/j3nUez/8HxnZsOfDnoUPcdbb9q5n/yqqwG+SDK8UHv/?=
 =?us-ascii?Q?laQ19uJYCbGwChnb1HeSfRXHMHKtGQqtxmLwoPo7aMPb2VbJyam2bipL30Q9?=
 =?us-ascii?Q?uCJErJVNKeu2LfyqCCcAX1euIBt/rOQwQXqw34qU+E8BtHYeQboSyonQT3Po?=
 =?us-ascii?Q?NzohFNm+kLD7We9XulEXq8tJ0bZJPxkZ0FqhCsGV6PY7At3GduvPRnDe6kcN?=
 =?us-ascii?Q?egp1ZtwRtIsY0ps+X4hXzy/SLzVhuTe1TxUwunhaihNjnzT+VS33WMtgl5Vm?=
 =?us-ascii?Q?DZL50HsiA7d0yItIBLRM5ktXCKw0Bw8j9G9O/vX969+bjVYz7CJTEoeZUGR3?=
 =?us-ascii?Q?hO1uU5RVErZuPNfEMheH75A7mHqsm8rs0myDs99kfBLCVWGYGa3ZvlXqLF/0?=
 =?us-ascii?Q?NkBrfOIf0cpn/FvNXro0krejbcKEiyWgjFfwnQgowcUA+UiqvyHhljWjvu+X?=
 =?us-ascii?Q?9jwe+f/sOf9qAMMoTKJ83tuHWSNplAHkLNj2Wj4RSTxP+7malHrBUWJ7cqI2?=
 =?us-ascii?Q?2u+Dye2g8+25IAXZct1XZHRSGuC9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7967.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TctDiQZS27PFFGo4cFGHLaykpBDL+mhI+/y3FWq4/NJQZrREQud/xKSVr4Dk?=
 =?us-ascii?Q?rCZAbopmWeEKt47+oJLLoWV1Pkuo0qjaXR3E5qTEVtffeFXsAphML2AHvON/?=
 =?us-ascii?Q?rnmbYOhTBG5WSTLRmxA5Kgn4vbIYeCngelCsPd3EeH4d2BjQ7oNW+NyB41wI?=
 =?us-ascii?Q?Q/PXh89gN31Bp7MjhnngrISqoDWC/+2kUowNO2kS+LNLv3B9JZHzlR36WaB8?=
 =?us-ascii?Q?a2qKE9tWFalfpmQKvkkw0Hns2gF8pUZTqcwPeHWsCKI6KSFDewvIfjJ70QIY?=
 =?us-ascii?Q?CVKeis08dwTEfuhAgDc7fQ4Gwfdgih0kUJJfgZ+MJEvoBrbyVnIfCUYmzN2q?=
 =?us-ascii?Q?UTVQTkU9zE42YMJ4UBKwNly0irIV8entZrivWhxYuZo5eQG9zbj2cbxZDLmC?=
 =?us-ascii?Q?EGHsEU+Gh+7q+uOUbr6vCF53aCf5lr6E7rFaCA+lPla9kHqWu+PP+VtN7BCO?=
 =?us-ascii?Q?qsFAlZ48bPIiNukO3RTQ3cp5fYpDSxetpgYdZ+okF9XOnYut+8sPJZmYwpZ7?=
 =?us-ascii?Q?v+ORJN7KQf33pN0MB/j3ZR4GkRF+vnU7hV1rvinqEb+ZAJ4QZm4r3w1tdlWG?=
 =?us-ascii?Q?wovgkjYNLCDvah/21csmFmomyrh2tfdO9AeWYBSUFSc8n1MuFHi8ibH9k4h6?=
 =?us-ascii?Q?2rDfPc8K87vWMSsbBkE0lTKErLfMFQyWM3Nzvyz/egkzz2H8RLPCeFI5M7Re?=
 =?us-ascii?Q?uwhrUaYsiB6KzmtJA6l1ETT+Y4YyoweF3erpJI9i1K8tbNAwQXbpvpNEr/jl?=
 =?us-ascii?Q?bPy49WmpWN0+5+G4WRdknFB+Da1PPO/VhOMrFjWVQUbk0wfMhvRLYJgC7UEr?=
 =?us-ascii?Q?DxxSGOyBqpeZH2O4isUJxEtSYVWeihkfj7VMiBHBQD18hLOWotdX6JENdEbw?=
 =?us-ascii?Q?RBGMUY47Fe5WNCxwEDXpnDi0JWNoMJU6n3D1aKZr1L66OrFqWiN7dXe/fHv4?=
 =?us-ascii?Q?TZgqpSBkHObFVROr5w9LB+rN08NhJzwGwzh56Y3/TLp2npJYEwxtVi/QVmRq?=
 =?us-ascii?Q?Ap9ZJnwstO7srsjGLO4B03sv8sHXAWjFwORv1NQvC0ezgJFgX+3jv8UKm4HW?=
 =?us-ascii?Q?lTWv3IjkmDOeJ3IX4bTqGG48liD7iSFPUNoVNugB2UJLiLN459n8uVwslhNB?=
 =?us-ascii?Q?KOc7WUA/hBtuWuU8NC+Ui2erZ+ciQut8caUjlCNRib6H3UIbD48Bu+Tp9iZk?=
 =?us-ascii?Q?816Eww9ojaqA/JlnNmx3avsLtPa7D7oK+e0w12x2mpmP0PWfXv+lvk/gEHC6?=
 =?us-ascii?Q?D5nKC87QvbXFDyVKK4iQLhdk+1WrFGyRJA7GW884pKxYFBlGFLCZRUfTju7P?=
 =?us-ascii?Q?KIKwK/GiyBmH2QrDFvzA3GKQqT++BeWLfsQC8OX/A8MbaojyhENQ/iC3VLof?=
 =?us-ascii?Q?YBVg73i2VmQj+sdsEW6JSt0uUQLn56712UB256jHjbzj32A+NLsKDhsZjv0O?=
 =?us-ascii?Q?mqMHr40kc1IXzB81XW92b7HT/oeUgLJwj/X1a/s0UIpAi6Oj7qPRJlTF/6TT?=
 =?us-ascii?Q?QCxvV3dXr/yjeOZ7vXxgHqdBoeky4f5nQkMHo2ZZ+8OE1TQY/WLp25Iekjws?=
 =?us-ascii?Q?79l79QUZi3yBohEafcHqk2ZqyQN46U6ACjutJGdlqcUYrv0fmgMhh/C4ABny?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6c2495-f3b8-4895-f30f-08dcfd82716c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7967.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 10:13:07.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KGZ6NiekXPqn0SUyT+xYlFePPvtU7ILuzfditmtRfjSPGsPGsf4H+IozckpiFj8etvMotgoFgaAF+uywFarTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7565

The zone size of Zoned UFS may be not power of 2.
It should be better to get wp_offset by bio_offset_from_zone_start
 like disk_zone_wplug_abort_unaligned.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: LongPing Wei <weilongping@oppo.com>
---
https://lore.kernel.org/linux-block/20220923173618.6899-2-p.raghav@samsung.com/

bdev_nr_zones/disk_zone_no could support npo2 zone size by this commit.
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index af19296fa50d..41b302dfd437 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -537,7 +537,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags = 0;
 	zwplug->zone_no = zno;
-	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
+	zwplug->wp_offset = bio_offset_from_zone_start(sector);
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk = disk;
-- 
2.34.1

