Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010039.outbound.protection.outlook.com [52.101.128.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8B645
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851406; cv=fail; b=VoU19n+6lVCTTit3LC5ZtJSBQ93Z4STGETNHR7MKrzl2THp2SeQorxdzAnUt7EiuU98FGb6cBiZiDgXlaXpZQB5xdPih+givtGTCK7+3I7uCrMfs925iRM+9Zw1xZ1f5+vwiNoAJ8qBg3UsM3nACnHlO9RmU90V8B7LYR+/6m/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851406; c=relaxed/simple;
	bh=q41lcopPA0XvJeq7A/WDfX9J29qzdHSodPyff1twdz4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kpBuLEmquqhzabnpRC6C16NNEaMPPQWWGC3Eoi59fKtEa1xqUAY+tup/tXVz65x76F4nERYGyx2x4M99+2HUkIaAOTDFma61TJ7C8w/PD3YKNjQgEWqdwqRXxZ/vByfBGN5Su6TNq801LjK2jUXIIIpHd9nQkyWcbyUWL6L75HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=kVqvbtVr; arc=fail smtp.client-ip=52.101.128.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="kVqvbtVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOl4uSVXEwM1vB+n6LYYhhC3ssFsGwEdJZUcrLbnCKRWGg0XKzpSyM/ldS/z7YOr3T+1uBpQHir9lSNngLy5Ax0iscPJfPFn2F77NhL23+x/ckmjOD4udUzE9ZcAK6gJ1KqiXAP0tlq0ccgC63KvFB9J/9GKPone0dhkTgj0ZbHEbFj/lJAFWlQ42eEMlThXd7CBAiq0Flhzxj1hHw8VQ+imlFLCI+DSP9Qh2A5wdbBsTjvnVpYa+Fm7zeYUcWoN6fBk9NqnyUJGE9nP2/jbllkkg0xjrPdqOggXryeV4Gtw7MorrRAofVItEvoke0j0ZWsMaZWJSWmStuwhT+qsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+gPHIA2oooywpkV1RRFvBlojRBXE1kveb2h8tcerP4=;
 b=LvBR2G50J5Q2O1mxfwWGvvzEQl7jnDHf6sunO48F6V+ietLe2jTxJ4sHKLZ61UcoTRfhfthSfITK5X3TDgMjyEgzE0gk9O/Y4jB6uyN+netVSWt0X1CpBZfXsvznI2BYrOx/RyybqfXlXQiXw2iPGicKjhxr7YEmw4Nts81hiNIYStdxXeRLWoISs0hOF143a3Z8q/czSpt8KEVwp6HcVq4ajdNg+xqAQ0QUxp6HIS5EN0Rl1LsrFWZkJER/fHVYLeJZI441ozwgPecbbozvCthBrIvrClsgAlbykUVwXyVmwcJVB59ceBNJp1ZIVpla6YGuirOhq1MRHsxMqROUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+gPHIA2oooywpkV1RRFvBlojRBXE1kveb2h8tcerP4=;
 b=kVqvbtVrfXx42g490B97LWoitZZX7EVOJHnaD08sDL1cgXtNTi/qjcfv0DwFeyyE34VUxqVgZdHl8rJnXR6SGC81cYVEi+Q/NikfaVQM7vIe8JUe9j2kB7XvxS5luJ07+Lv2tSFhzWgB8FKB8qKRkm2gKe9cIhn+I90EfInT1Tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com (2603:1096:101:22a::14)
 by TYZPR02MB5785.apcprd02.prod.outlook.com (2603:1096:400:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 00:03:20 +0000
Received: from SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b]) by SEZPR02MB7967.apcprd02.prod.outlook.com
 ([fe80::5723:5b88:ed4c:d49b%6]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 00:03:19 +0000
From: LongPing Wei <weilongping@oppo.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	bvanassche@google.com,
	dlemoal@kernel.org,
	LongPing Wei <weilongping@oppo.com>
Subject: [PATCH v2] block: fix the initial value of wp_offset for npo2 zone size
Date: Wed,  6 Nov 2024 08:02:17 +0800
Message-Id: <20241106000216.1633346-1-weilongping@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To SEZPR02MB7967.apcprd02.prod.outlook.com
 (2603:1096:101:22a::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB7967:EE_|TYZPR02MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4380d2-35c6-44f9-2599-08dcfdf66bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhGsS1qiJdmWvNWnlJB2AUa4fPfQWMIWIUDXtX48AUp+Xhy5wH+H58R8ueEt?=
 =?us-ascii?Q?IFv/t2LEAmcJHun7thrFZg7q0LLPkx/XgcVwGZa3VG5t2eU2Fh60qOoLO9D7?=
 =?us-ascii?Q?3ozD/TiHcdlApQci1IxejY/BOm671895Goi7CZV2fiivOO2mCp2B+bLJB1PY?=
 =?us-ascii?Q?4iMDJ7IwC/m2HjNEGy4UDyL68IyOMhj5nVBFCOXppny1I+yILL+9tmIgUiqz?=
 =?us-ascii?Q?rAMDesJRvOPnqchJkszBTxbNbAZNPrLE6MHIxE0sEjAtCMJaa7qjWwoU2NbL?=
 =?us-ascii?Q?1SjZVz/UoscGVxXc1JdRP/JcdlILcUAeYLYIP/OXeVc/cbD2dCq/2YDUgBEA?=
 =?us-ascii?Q?GtkGKP1geAB8iT7ID0mJXzzfLRatyJOOL24vaxORYJagnpKXgMSO8O1T9eWl?=
 =?us-ascii?Q?jSh1+091pJoUo4XLZKCSCIThUHQtKBuBJfqljtYpNRVjYGpZlX2WHazymz6l?=
 =?us-ascii?Q?cp5bPyAYDUJc7/l9DYIzC+1bKiHtfWUeHfY8Wf/yV2pjMU6QO1nICmSlQGVZ?=
 =?us-ascii?Q?Rpg3JbngdzPDmCxZfT9jRFrCZjHg5VwClRXQ3+cG0vVxv1Qo4OX+zRpy5yiG?=
 =?us-ascii?Q?GPOaYR6rvbWCKiQFNr0Gi3zCIOlui1iVlQwBmgGZEjuoFikxsZ/tLHFe3OCO?=
 =?us-ascii?Q?pMaIjJzuvE3YJ4Gb6zZV74hkozv3Q3gctwpw8M19WHLkInXCwCoPsxJQKxmq?=
 =?us-ascii?Q?7glP2r9ZYAgyHXri4B4YtLB4rluQit0UNpssZLQN99M9b2slQ/BwDF4Ysujs?=
 =?us-ascii?Q?T77IdqpOKS00RaUCX9BSHa1o7tSXeKom6tZZoMVtsyqshVm+O64l8jPzhWPp?=
 =?us-ascii?Q?fPaiN3960hZIZGKvitl/h+z3r0dq5gfhH4jU8UvfeltOwjdQQHzlp27qq2Ot?=
 =?us-ascii?Q?BTWhq2Ot2mVM9gONuz5CiEkH3ue45SNsgjZOGwWVVNRSvxoxPZrjSluVvVI0?=
 =?us-ascii?Q?gmS3JqqrG1M5LtQGbh+xJB0yl+4TVaMLVwOgOBUJM7eNKWYgAsottk5U1a6k?=
 =?us-ascii?Q?g5rG85rzS6+42YtpLAzHkBF+I3Neh87SfdJf6r+gkFy23IdMmVOIXl/U2kgE?=
 =?us-ascii?Q?csET8hMjoCF6+4pP3KSPMQ/zeJ5MiScdleGOvNlApWWAGyQs5kcJaRbMtcip?=
 =?us-ascii?Q?FL7jKi4p2yLnHlngx44W7S0rV+epNz2EFTG7iBfbluydn0WEH6eF2ldtz6KN?=
 =?us-ascii?Q?u1ZtJqhft558CqEMjIPuvWHjWLoODDE0rNZRKUvkqCg76rAeXuzXBOalz51L?=
 =?us-ascii?Q?kIOrock3//GVBqb2f7k+NgIBEyQdbmeWcJ7IEhORDPmLB+tLW4tahcqyTGUw?=
 =?us-ascii?Q?gh2nEP5m+BOZIv8Z3w56qxtcRLS7HeHKHIZLFgErCZ739aWlCrrRcXxP0Kpt?=
 =?us-ascii?Q?5cxKh7+taYda1o6gYEBWBW50KRI6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7967.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zjdcwqKlUMguBJqTzwwDfAGLCu73GDFMrw04UjCT3mNTeT1Nh8/uLdp1u68E?=
 =?us-ascii?Q?BjXo1WtaqhPnZIt4qIe2qR2kkPKJ6UWRWuRF+dud8tfGwvJbHbuuigjU1mjk?=
 =?us-ascii?Q?NreCFKFLoybWf+V+hWpu+BpF9yBsCbFW1f9SAuVtTBn95fMXsHxndJ9igvtM?=
 =?us-ascii?Q?s16MY/Op2QjKZKaHJ/SSAqZb5WL/PBYEF2tfp0/BDaB3/9lDOaia5Kyqs0me?=
 =?us-ascii?Q?8ZA3DMXptOnmjH2teoa7ch1EtQeSE8Q+hMXXFhZBy7GImXY5gqqZRNF9ob/I?=
 =?us-ascii?Q?tzEDt22vX8IpBObrUjJJ41SF+URpgX1f4vCXcLDZySMc8SrYRstmh4qUjJ3l?=
 =?us-ascii?Q?v+6hO+EyW4Bm5iVQTT1O5sOODlRtF+fwraCrP3mjl8SAN8N9cfQjjP11lX8m?=
 =?us-ascii?Q?vlqRGMhdybatDgAGUQP1XVMHJlHnnK28HN+SNkSsRyCdezHXzGsJzCX/T02D?=
 =?us-ascii?Q?H2DjA+38ice0KsegGs9sDLfDNP1vodvUU7GWCaFw58jhq0wqMxN81r+UhgRO?=
 =?us-ascii?Q?cKo7Y51KNqnEF17fzHQv6jJCW1DQns/qoJ3APf4+3VgvMCeF2Eb+LQKaF8Dj?=
 =?us-ascii?Q?SobmcgMHZk9TEvGxlJANNuNtFL2JiFbx3yy7AmD+YFgx2mlDk/fuxcZ3ME06?=
 =?us-ascii?Q?WoplXtscJr4VDKS6ercFxlird+bIHZftZW8q3F8f12UzY9i9eGnvTeIk1Cnw?=
 =?us-ascii?Q?3Awt/KcCoE8HNaC1MokwEBA09V+4IVQ8HJDUtQIPvW/m0SJtCTKOiUWK3Bpo?=
 =?us-ascii?Q?m3eZqdlBmPCdYaGhLoZIFMrVjO04nGaiabbF+TvD7ViLtK39vLdHaUQ0e9Ab?=
 =?us-ascii?Q?5j0UZZfElxkUulYF5cjaBSEeun7bWAoIcNoti/tCunEPcY5My6rqcyuITpbk?=
 =?us-ascii?Q?yyPSOxQc9B6ecvsE9Pjkzd0ffyvX34NeyejYDjHOJ3RtPRdiah7lfV7RoUZA?=
 =?us-ascii?Q?XWwddc/9jTY5ZedF6R82fsH9TEBWIuZy0wu07o14zYrYiHpf5BDxNtGK/UB7?=
 =?us-ascii?Q?NOP0SQJY4aYIg7d6OOcbwW7upx1rKPz7QmqnZWu5Y0bIHE4yahixYFSlTBr4?=
 =?us-ascii?Q?qjLTUhr4GBs6U5Mt81629/SuCy2JHihf1CEpaIDtG9ZLcQXXqWb24aGR5Fdy?=
 =?us-ascii?Q?zTprhX9+HhLIUSE0BriVFdYMJeSksauVy3yYtBaNe8uCKdG9npmNidP7s6C0?=
 =?us-ascii?Q?VJzmLnI/z7T7tvdhWebJTepMM/2JmGTnT9vqMhOG82HqpxMQr2v8LYX2e33t?=
 =?us-ascii?Q?Y0jdm/57RP0dYehmLDSS6otZeYTFNsabF9XJxMtllHAb7XbSJdBcIRc9ToeL?=
 =?us-ascii?Q?trA3yj/vkGnAZRh5Qod2b3DTet45v03oZsMY/N2i0NXlwMduSPk2BeIbYWFC?=
 =?us-ascii?Q?+B83gr1uhmHi08o+6/r/5njzgPZ7DWj9snW2xRbq2ffNZWiJrfQfsxNLSfC0?=
 =?us-ascii?Q?I4zQt14qxe4M/d7/rZl3wEiI9XmhfyApyQfU0HFrX9H9VUKeOSu1NWOJb/dw?=
 =?us-ascii?Q?E9IBytEIkVOJoJifF03fiIAFFiKNXjZFILhhCmXHiXoaspP5e2VEpN6xcNTP?=
 =?us-ascii?Q?lv2L3gFH8puLnSQLOok2fvlvDLC1pgYTkt+XMKwM13gWR9ourze90i0mOD8u?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4380d2-35c6-44f9-2599-08dcfdf66bb9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7967.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:03:19.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7E0K3RGFdSLKxLdMN7b3ra0MvpXADLJ9Q3JkcU91U96YybnkZV7xsLHBbwQP5Nz8rwl7LKuZODeVARUkf3lcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5785

The zone size of Zoned UFS may be not power of 2.
It should be better to get wp_offset by bdev_offset_from_zone_start
 instead of open-coding it.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: LongPing Wei <weilongping@oppo.com>
---
v2: Fix compile error.
v1: https://lore.kernel.org/linux-block/20220923173618.6899-2-p.raghav@samsung.com/
bdev_nr_zones/disk_zone_no could support npo2 zone size by this commit.
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

base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
-- 
2.34.1

