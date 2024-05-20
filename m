Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24520DDAB;
	Mon, 20 May 2024 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176363; cv=fail; b=bQgY3w0Uef3N4YxgIMfbHaM/IuDtIVP9SYCftodp8gKFsQQ3AP+qsxWfhRqNehT0SGavhmch3paxgeTdMUpS4j9HrUSAT3S2T/gPjvSVDt+btkvhcHLho5S9dl0AZljWdO0zEz14gCzU3t9zI5bV8RBEiqKRLTK4KIyiRgYQMKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176363; c=relaxed/simple;
	bh=bTsLvqHu2GbomBp25PUM469mj57dHGP49MkKeamhhEw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qDyjddh0jCOdTOt43wiElAB/AUw9k35lPjVxUQMqImG1gNAmyYHJEUXUB9koZa7Nbqsn9z1iXiCEK1Dn2GdDCK2ss13vSlGN5Pl7Urlpgx0dtdqc3VILb7k35Dkd1o0WORXthWrcCw6NiNXVVEkrR0DyAYAeThMxDL2Y76gizLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C0+TdFes; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C0+TdFes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmAlCLNMUVuvVobP5X9XE4A3NBT1pNH6mQ+5j0PfCFhj4ZhUSBwgI16HuTigC4oPha5+jAUrfJJClxVcfA/PsxVQ0dtHUuN0YO6+kXehtN4fYFQd1RDN8d7kj8wkrcZNgxX2kL67nwGvxX8QBjtDR52lCNhgvR9oqdcsR5/GwveUJ8idfsEYoO9dEAZ9wY/L/5sMAvdJJE5AAsRUB5QZYmAGviTqJD0g52BSoBG8JiZaWIwykgeCRhaipEPs8CweuJ6Lr7dvWMoSloKekOlb2ERr1xaPJc/et//PUwVJHfyp2awBnlDqirYkvVGKMh1vGFql/0RSJuPPgrEsbEhc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGU7/Ai8H0PuH72OGoH/z+9S0nVvJ+q6xeBbwhTsJWg=;
 b=KV8yDUVj+GdYEo1vfgk0MWKdKcBls8emVd7ozWLEVduVuuazgPwFWJmR1z2PmbZFN1dtUsV3Koj1rVbAEHAhdg8r7mH1BVdb6VW111h03PeHl2Xd6WjfWUlLxQ/1BJGcBDkDn55Y78PRrszESICQcO5SGaoL0cCPfGmoTLRwKMPS43wAXAIEByiZblQOYBh/gv2H1c4N0a+jcmRIcyUOdoGHUDNDdse5+IC2VbyVSOAsEb3FeJuGyiFkzhaA4licfs14zDJXZ0PMe/uiVlOExQylJavnQ524yVcr7vSn6k1CRIkzHZ1usUAPFeuSQyyZf+42fSAfrx9v/FetqW5Ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGU7/Ai8H0PuH72OGoH/z+9S0nVvJ+q6xeBbwhTsJWg=;
 b=C0+TdFesphbYMPa7qy3TPQ59X0vMepy3kNizM9olbQppjfJm/eheXhx+ilJrrV2musGjkNhKKu6CbeIKszvVfEw4WeuAEOaSEepGFamHK9qJykuXiVSXJGHLngiFHSsMY7YSUv1GTraIRAueKar4hIn9K2W6FLeUuLrSsW2A5SzhuJsDcTmFGD9jgpPoXupZ1VFTiUF7EUzfTQEJnsRPbuzI50i0LohxH6WAnh+bEc5EvHoUYkWyGFWtUQSRfhyZEMH1G0dXgVS4D9ab8jzyv6IYq1tkkgkahBqgHMZxMAaKgB9LY/xvtxGcIgveoRCvhuF/wxk1qRWMThCTFyFPZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB5023.apcprd06.prod.outlook.com (2603:1096:101:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:39:17 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:39:17 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [RFC PATCH] blk-mq: fix potential I/O hang caused by batch wakeup
Date: Mon, 20 May 2024 11:38:46 +0800
Message-Id: <20240520033847.13533-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee7c794-761d-4d40-efc2-08dc787e6d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bxgyPqijSBTMRGEGEmE0QjRdk9C4q6DRZYTkXLTD6fQmWIFJmOyZX+9kxqJa?=
 =?us-ascii?Q?Yf8Xla/YN1vcf0nms/55DKalMjv85a1HuFfOnYeoBulNMbLlO/dSm90+5CDb?=
 =?us-ascii?Q?dFRIDfSPjKtHzjp/nzrCGSsRWQuZ9pQ/X3ioCdxU8Pt8iYwnlUH6+gGwPQdD?=
 =?us-ascii?Q?M7N1VrCFgKcx3VoLZxDxef8lYXS2DVULTVS2h8d1LMe03XLqtrK+AyWths6E?=
 =?us-ascii?Q?X2L0QNWnzTrMXAcAXVQZw/tdrq3QpWlqP7NXnj4KqAzVjMkRRdDzB3EUkevz?=
 =?us-ascii?Q?6LlCD/0sf8GNLpzM4qeIdVqKJCKMSDW9SfR+f5yMLPynHb/HQB0AzK4cvyUH?=
 =?us-ascii?Q?f4E0BlMnJNyiNxBl/z3zamCyQo+RQfYwWQ22ls+N7TvVrJVHgYikGdMF5x1x?=
 =?us-ascii?Q?TaJwnWCVjUSqrRp3YSzdXSAk3Qps4U9L5Mf2as2pmKB5RhxzvEiELcEvq3tz?=
 =?us-ascii?Q?ZPJJQyC9iapnUdXfmXcsqXRXULIxxJt7hnhwTgfsZb5+woMf2otZFxHI3G57?=
 =?us-ascii?Q?Vr3wu9oF+4s4flaIqM0NIsba/6n3Dl9+tZ2WqwCb2Lg5ChvSSnDo0O9IeTHE?=
 =?us-ascii?Q?n+CtnFKADbb06qsaQo5Fm/lmLpz1Tje0TuEOc1Ba4idZJ/tphnN7r/Zy4imL?=
 =?us-ascii?Q?isGfQfTL28xXfbONfqvig3Ps9felnayRlo1XswaW4IdfJhFwibBwCIegn9wf?=
 =?us-ascii?Q?QoUkgNEWbjWEdzIeX5507Zw09pvkZzP2aLDCaXnYjHamN3lFYFC6dXtRdhdU?=
 =?us-ascii?Q?pR+tW2mu38R9BHSOJNns7ydsegx5mWM9p7GnqDsdQiSSW7udm4NyARFz/cqE?=
 =?us-ascii?Q?ZD0njL717iFgg1jQJUA3UTHhwKE4fE6i12C4By0G128iJ1eaxmwsKsK+OjMr?=
 =?us-ascii?Q?4mKECjsYReb8ZbtVtSpqM3v+DBjkWYPfkSHQPaqdk0Q3Tqb9rSZAf6vvnw2z?=
 =?us-ascii?Q?9jZx744clbVPXY+md1sUxBw1BJ8ULsQjcbuNm9WYJbgM4N11Iq4RR8mXcXzA?=
 =?us-ascii?Q?XepG2ThOqnPZ0YhhIKab/vSrMTZlxfmyXArtZrnUASdFjDSxuemjREqVkBMD?=
 =?us-ascii?Q?m3gcnJJYLUocqWbhGURTq+6F0xo41VVLXzu+Uy45EeOIm80wV/l6Yi/RqUcS?=
 =?us-ascii?Q?CgR5YlMM85bHzDVKoNfGeSUcxffGsOCw9iyVwrakOLa3KeJoM9d7h1uWdYUq?=
 =?us-ascii?Q?hh3m/pRogey4TX826zx4aklQDJzvfLCAKGSYn2lBCl9Ma6SpaOxx0GLedNcW?=
 =?us-ascii?Q?f0GgYmxtssSgMvJgdY0j8G8i4n5l/SZ7mWvASdGM1NbFQVpWgWfaDZAgWH6A?=
 =?us-ascii?Q?l5hi6HQvPNEvZsQ8Zq9jTj3mFM4qExbQgdG9/BuH2PgCUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ltEmVa/oT3ONGIkccdYCz/y7aLmyuaOt+Fcee7M3QjKbnOSDQA56nxvambAp?=
 =?us-ascii?Q?HV+vHZNbLei1IaRMwRBnHq3ejeAV+b8RoNu8tvVTDMOxp2aHyXBq5gZbw1Nm?=
 =?us-ascii?Q?XofIjAoiFkhvetbqeUjblw5aZ290yVnlnZiKEFaOYxXgJ3isYZ4BtT7QtZlu?=
 =?us-ascii?Q?0dTMwkDRR9KxmYbbrFszGZeu35FPmJkIymL3G7z323TtoQCUwFPjV3M6vsin?=
 =?us-ascii?Q?1NZfQrydpHCKvjF5TglB2lmDmZoL/zjuqas+aA3nZ88Fjc8rz5yqG1zZD6xC?=
 =?us-ascii?Q?9F6jvgJR3lCOVKsuthDUcsLNUwCI0fGQklRU0JZoN60mq9sSJ7D6UJ7p+3hh?=
 =?us-ascii?Q?mfzVBAmexp5vOjJcFtjQLQyftDSpmBgiK2lIaqVx6DsjymYozO7c7JI45dLQ?=
 =?us-ascii?Q?Aku0+yEPwbKrsbcUuaRRrr54Ar91gUp4JGZatkAQ1tDbsbrxH+A7bDgzWSGD?=
 =?us-ascii?Q?ewsY2Ky+nl/x5CX/hVm4NFo1FLGbgzknErIhhF8u9kRiE/a5OuRfE+rdaItF?=
 =?us-ascii?Q?jAOUKOa0N5lIPmzFC+rtBrCUl0nnLRPKj11JJ9gHNJhImWl6Mr8RwEQEruEI?=
 =?us-ascii?Q?wXEO0ybPSVgqv8Ra8xMpVKiO/4+Mh0wzLQ/0VUFsyCM6jVi64tvU/nr28TlV?=
 =?us-ascii?Q?MK/CC0VjG3DWbp+i1SBjlFg15AsMpD+LvSVyt8KN8AfN1dHRT0Zueuv8opyy?=
 =?us-ascii?Q?6uZ0s7fcZjh/n2PiW5tNv6BzdRcqYu5l6558+WHjXwWeoYZVENpHWmnWEe0z?=
 =?us-ascii?Q?gz1IDWivzlxykRYqccUsr8AfhSML3f8FKm0mfTpk8Mpha/hBPjOrFlPzl2Z6?=
 =?us-ascii?Q?uwt++nDJ0kwslZwkb44ais0xGFaicXq58KlkZttmqVj8Vls7yrL37LOc27yQ?=
 =?us-ascii?Q?M6QbYDdHSCz2VEHGtLnCjNftDPpzV5fUZjSFL4426AipzehPe/8O0IF4b1nN?=
 =?us-ascii?Q?mf3vgWOXYgwJlGlYmNDtSaj+hLdUD62DLeVhE7ZyLPNFaeI6HBfrn2mfhORl?=
 =?us-ascii?Q?eFxIjVzyOZFNpZoTHZwqcLNFqd10mIKtuYx/c31YDpUgrXgQO1+evnmS3mvx?=
 =?us-ascii?Q?l4QZKvdx+BtAYrHRasUGEJ0HAXlw0x8Ue16b/ImWIAXEbjM/HLFuWy4JuJIS?=
 =?us-ascii?Q?vd4JYMhRrW24GipFiFHU4MXd6oRT9FYihxKIcmEnb48thD3kBOcana6Vp3Tl?=
 =?us-ascii?Q?hidQNE5YUlafj8PxzvHW7xL7v5889aw9F/hN7qw3m5mHKql0sGgHQyApYMbw?=
 =?us-ascii?Q?RgmBq/er0b9PdAbzAhwnYDeWmNz8OwnQlwVLEdSWeniWc1Gz5nZ9PFmF3RsY?=
 =?us-ascii?Q?TNo7IEhHNf08ADiTJygGixwKhZITmGKimCQCdAg8wXNIrBv3utSuqks5K0Iy?=
 =?us-ascii?Q?mM7gNd4i6HNUpXCofj3weRltU3iOoUHJTzDRQhwGzxwUz8qSXQ7JANXcUmA2?=
 =?us-ascii?Q?ByEWqE/JycyfJSvmIxEjpJ+x+mumMVyLYMNXC78uvHniGrxSUSunxijTPU/o?=
 =?us-ascii?Q?iDcfWFkik8ksF1YcKb7NrOfbhmNSl0E1kPt+V2S+cX0E9960BD45kqwfgxkg?=
 =?us-ascii?Q?HD0v67pisj620TnlDYkGXsTFlu8M6rYH87DWD3+e?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee7c794-761d-4d40-efc2-08dc787e6d04
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 03:39:17.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdHBC140FjscUC+x08sOgYh8RFHaeUQe9MhFu6bRHcWBpeKwXwmMyvtHf8Zz2+iSXEq/aJdesiMGIor+ifoSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5023

The depth is 62, and the wake_batch is 8. In the following situation,
the task would hang forever.

  t1:                 t2:                          t3:
  blk_mq_get_tag      .                            .
  io_schedule         .                            .
                      elevator_switch              .
                      blk_mq_freeze_queue          .
                      blk_freeze_queue_start       .
                      blk_mq_freeze_queue_wait     .
                                                   blk_mq_submit_bio
                                                   __bio_queue_enter

Fix this issue by waking up all the waiters sleeping on tags after
freezing the queue.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 block/blk-core.c | 2 --
 block/blk-mq.c   | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..e1eacfad6e5b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -298,8 +298,6 @@ void blk_queue_start_drain(struct request_queue *q)
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
 	blk_freeze_queue_start(q);
-	if (queue_is_mq(q))
-		blk_mq_wake_waiters(q);
 	/* Make blk_queue_enter() reexamine the DYING flag. */
 	wake_up_all(&q->mq_freeze_wq);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4ecb9db62337..9eb3139e713a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -125,8 +125,10 @@ void blk_freeze_queue_start(struct request_queue *q)
 	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
-		if (queue_is_mq(q))
+		if (queue_is_mq(q)) {
+			blk_mq_wake_waiters(q);
 			blk_mq_run_hw_queues(q, false);
+		}
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
 	}
-- 
2.34.1

