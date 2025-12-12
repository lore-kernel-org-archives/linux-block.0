Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D82D1319;
	Fri, 12 Dec 2025 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528321; cv=fail; b=Kp67f2hPQ0Gxu8HF/Iz0feNUJ6xBqa/YoiwHfksGvSPlyXcUYnoRqYjuRLjaXI432qSdRA3lyGyhE52z7hEIda6jJMR1Oz/htM3qVIlrh/owlqRWv1Lp7M/8I4nBzIwM1I03sXKWMDEwbAGWK6enHm7I84UlS1zlpbqLG5ETkkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528321; c=relaxed/simple;
	bh=3LyGln9a/+3CHcQ3x7Lmf2b2TUBIiWvPBaxIemJ3xOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gTRp3Qg7J6RQLmL8kcYwep28iIP/1+YFvccGyGCYcqvxJXHTf8q+XmcI2yeZI1rMKpUMJdLCtkILL8rWd+Jcwiy1MAnlAfm8Ze29qniLWWjgTfFHAqQsg6I3/lV9uncvpvGa64PAsCdualhZ/yFfU36gwyywQdjFYsEkOGsGiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b5Ly7S9D; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b5Ly7S9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTPNsn7oAZRkq56oYK2+u8Qd+/L8Gv12+nhriZuIfJL0WoUSdbTbp2+3cu2BbZUfYCHFXzpeywvQBjEpl74/j7/j6REoPOFvtieJSLfYPgybAg0mQpSwolw6v+lKGMAMPgn2YWphHQxC3E6zczVLVzoefGWCo1tY/KPVYuDhe7ixMXFZKPuiGurE0jGfhGtkzTTQqsiW5Bu8DKymblqBWCKPjH3WRM3CNj8WhhnQLfY/y+AXK0pu9qgV6ZbgrDtXPSJrWOc8IvlTEK7iMAotkXW6jhPnpl6E9udUBv2eKMXxndUwu2v5hZhU0dQ3e+olMRJZ6CPS3Ns8+bu+5znahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMlsupzCFCk//rlBUiP2xjUxUFnVaeY8BOLJX2H9Dw0=;
 b=xxnJ8Pjwv/0D9TqQ5kJzLgRt5mMrWiztgIkJR9NBprtOEwdOhS+83Om6n+6RtppB0WUjnm/NC8t9k2Y7V0pmX03fBbqQGwspwh4yeS75+jbYM8/X28e8jLaZdItdOsh8GVDZpU4576uCsrA9FG/E61rkQADGfx1GWbYHAnS9WM+Jr9wHGym0H9d0TZkInNLz2T12t3esfLuZLSmQmyOpQb3R9S9nj74duL4QOCBo6X+JFrwh5Jt+TifEbAglZB0UnvhICDXJPoF/W6cgmZb19rg9TuUDn6i7Myr9W2av2BSlfeQeFpo4Dcxz78Rjeuunm46tKLu6Xd4rK/xLVQRmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMlsupzCFCk//rlBUiP2xjUxUFnVaeY8BOLJX2H9Dw0=;
 b=b5Ly7S9DNTFFUJH/6MkxBcmjKu/Qju02c09qvcM8IsURCaSAugHpJ37DNOabKoLhsJ6m3O76MJt25yqsL7cEqlFzmI5WtkMvxtlANSQvqoxQzqquKJ+P0spQ3fKMT3ZUyqbe0FyJIAzQQmFisZJgXwZd8VIPiykoiDMvdxl2kMq8+1hWtpQ9U0KrKx2IxAmrx8yJrv6G2/FEo9Xwugy4VY9MgNRWjG48A1/CjtHAaWyNfgTL3VgPPpy0+1Sd6amm92QXrw3Q+rwGTwniEVY08/P75eQ4rOGzX493OqPW5EJaew9TdDDTq6/LrTIuXPzUq2+muYVpQCc9vJDcDPHscQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AMDPR04MB11556.eurprd04.prod.outlook.com (2603:10a6:20b:71f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 08:31:56 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 08:31:56 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/2] block: decouple secure erase size limit from discard size limit
Date: Fri, 12 Dec 2025 16:32:45 +0800
Message-Id: <20251212083246.582806-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
References: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AMDPR04MB11556:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e821ae-3853-401b-e350-08de3958e84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jag3+iSAfm7c3HlrZbU4Vd1+1qVV7/TA0lXZVpaOvUbhDKpN+9fqQp0oRWxA?=
 =?us-ascii?Q?MMVw1Ju5E2P1ultgm3Yv2kcdiWgWe6P+Cvdhn4Do+EmqeQF6dkrvDlS4BSVu?=
 =?us-ascii?Q?66o1KSn9UThjXvQfDofweC2G9zr4C4rsOMvRSkAphBP2HLlsKI8mnK7zMr06?=
 =?us-ascii?Q?H/xoL3HxVlLAu0DApmubBVC2bmJPrlf37ghubGa+EVwCrgJHkGWwEOnGDYfU?=
 =?us-ascii?Q?gEfbDRU4cMdYmYxHu9+QAU+VJa9idRnN5aY3VHy8yw7KVJhjwPeOJbDG7yp/?=
 =?us-ascii?Q?NjdLAIA9wLQvLSGttOU/HRM2yfdFM3rdb+nQFl+MBzqAZ60fONCTO6IQ5Fcy?=
 =?us-ascii?Q?ijqMxq3d+725pEd2AHGFxUMkPDBlS6wnFBe8S+WcJ2dvRYNiAKw2NJTSc+xN?=
 =?us-ascii?Q?KjJiq/Uw8ZT9UynGvKXTNg4qxehLHr2ejgkm1tf4ALbmI+UbaarJsrE+XWlD?=
 =?us-ascii?Q?B66dDAljR38j/ZuC0CzDSjbM79RI+CtD8kKMoFLMYLDYpNfvfd/izS63Z3l+?=
 =?us-ascii?Q?MHfzd/w7mtKuSnzIEymFzFleJCm5tK2VgGfgxee7t+gkUJAGbmqjkIAFffKI?=
 =?us-ascii?Q?j+tQrhmhOgtpusdf/GkKmJGe2/orh1TPKbBwIeebnQxVfmaxuS3JeYx8gb1N?=
 =?us-ascii?Q?uJc7LfZ39FVVJDrgdf4HhqiPfI0eTPaoYEVFAgEEoS0QD9fMPYd6zpXjZ0Mi?=
 =?us-ascii?Q?LLm1TW+PGfAKZFfUvd8+AdBCynz8YBuOubACHdNrhvE0y6DoVrd0lC9PeE2G?=
 =?us-ascii?Q?7S9XUccpuJt3g7h+Z5Glh3LDLv5ArafjK3HiIvSRDvAE1NZ8HQOms4ao31a3?=
 =?us-ascii?Q?fkVCqL9RR7nT6XaJGU6K1Wuf8JRfs/8W4X4wbx2lZXhOxBOi0lSgxJIL4eHA?=
 =?us-ascii?Q?R7LKa9vYVwkIgjQDM+GvF03C3i1XI1BuR9PvhwpfJJLiWN4NPe8Fym2DxQpu?=
 =?us-ascii?Q?PTWHBgyTYGVzSSQ6rF87lonz2F3/Gtema5S4D7iUGTT59DHl5fDPBRKQQC8X?=
 =?us-ascii?Q?S354a2HGxXq535Js9dBLfjKkrOEDGSiCuJSirNQaTtTlEXKMOaQrQDrnM5Bd?=
 =?us-ascii?Q?k7XvJNQUh4HPhfM4qFXmXsxGtW+xjetTthC5AXTFZWmnrUn+zcJogce3Ulni?=
 =?us-ascii?Q?brvFPmJgoc8ygP9NblDVFD0jpWuDmN+O2Dklu+q2jmMb4jsg46UmgKtzj6El?=
 =?us-ascii?Q?BLfsRwCLwEuNjRP3AD1Qz7KRycExxe/dPTEMSoG4YgQAnpseJe37XtAzxSwe?=
 =?us-ascii?Q?A9BQg5+XCAuaSj1cwJOA+LYkJBk+uh1Qz4Ur2tTAy/T7+EPBuEzL+cvi5pMq?=
 =?us-ascii?Q?wMVpg4xlJNr4Ux83t2CZjEifG8sPLvGiCsbhm0uNp6SFRrwwxIWexuRi35zR?=
 =?us-ascii?Q?D9S6Kc7YHNdW/ITsjnLq+YffScpgZgyKRZrLZRqDip6CSifGN2qikEd/MARN?=
 =?us-ascii?Q?H1OnWfcWYHfbkvRouEagjXL2IXNM7zbeQ+AEDOzBTus2Q6aa4EDQdf/SIlQS?=
 =?us-ascii?Q?rJzJI5yOVRCmlWZ1gQrS/XBK9z2ePgcu/HQg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ZMY26qzUbQQ1Nmx7ichGUGS4O+AfnQz/+oKCKTn8XLufFsI1oSjCv2Qu3Db?=
 =?us-ascii?Q?SbhYEv+8aRTBHrmgUx8SRW/+oyQHuz0HOMisBAzT2tkmG9Xt88r5BElIjpj6?=
 =?us-ascii?Q?zAhP8yRp8EoOUsvw7BGrOJ3TIuzy9q3l8AIU9FRvHREjq4c6UaiKWNfFrL4Q?=
 =?us-ascii?Q?4Wdgj5ffvU8Pp24DRtMuIXlO+qsIJfvfg4VlrV6plNoD65+kveyfoP2nlEfU?=
 =?us-ascii?Q?ZDQAJp87WZC+pkxlqLvm/zKqBEZvCznY9S8+nOt0496jzmMP+kPdEOk1lijp?=
 =?us-ascii?Q?FM3V+2wdS32OFyXZ8GDD2Bb5Ibs+WUrnmcUh5gBb73+/7GNtp6gfkZ+Svg8c?=
 =?us-ascii?Q?q0HgUfhwDZ6L9dbM5Oi4Qqrkrl99mDryxDBa73haQgcUJTeVqmkuCawG0ASK?=
 =?us-ascii?Q?ZB/cE2gmBwEvVUYxtkQ/9WokR0qXWApHaC5yaApB/vZaFXFmqJo5P3LF0VtE?=
 =?us-ascii?Q?IyPG07t+/47ROhtcvxDw1DR8yt3Gd46wlYfMHmOL9DGOzCkX7ZOo8Tp7/J7i?=
 =?us-ascii?Q?LSEXfbgGeM6pJYRch6/HBNufhleYUcR8DK+2WmOQ0PagDgsASSrvDodLlsL4?=
 =?us-ascii?Q?VdWDJaHPa4k01D9u2fGQsVoaz+AwJJrruFF2My7vTvibJjPm1KJ149GAG8Mm?=
 =?us-ascii?Q?0OrP4T3WfmEjNCa9h+aAqsBDeR7RC1a1DLmwzuJrwH/jT0BcNeWGbUNezQoz?=
 =?us-ascii?Q?2FVZWfsMEZoOGVrsvLO0/l4ZZReRkYHnXvi6DGsnVfxZ3+EjSm5PU+21ShvO?=
 =?us-ascii?Q?56U0/cnbT/7XX0ETj5+6avMtkIFPOs5saG1TVU2zMHvuYjHS3F+OXdwA5XYf?=
 =?us-ascii?Q?6nB/d/sRCX3qnZcXLSQ54Qo2SIodMADwbVfY8F/2KwwBHVlzLtn2rfSy8/vL?=
 =?us-ascii?Q?tL4zAGzQkqdVmV1xz8ttDm2PIgXmApySz1YuydsrCfPM/2ug4171Wr2aTtuk?=
 =?us-ascii?Q?qVafKie41BuFAro8qyNU/bsu2HgB6WglGYgJWlt+TrI9wz90hvQS5vYDm32R?=
 =?us-ascii?Q?YHuJ5Alcv8hHx3oOap3uH5hNyZX+b1QcIdeXNk14i4iZOgYHh+ylNJAFZzjs?=
 =?us-ascii?Q?3sOi9c0NkBKVdlfAiBswh5Wn5Kc5a+wYiy+XqW45Zm6iboUp5rgn8RBEApS7?=
 =?us-ascii?Q?KE/C0zGVf5C+VGCJVVNKvKYaPdsHeo1Q4pehZWl0zReuOyd6AjiyxoOXBXM+?=
 =?us-ascii?Q?fRdwu/yQYOqD3d9zi2J3PftjwnxjQFXbyDDz6men00hQKIKXKBNuJ98F4f16?=
 =?us-ascii?Q?PNmhOM8y7gFE7EIsjNiQxjPgFTFsui1NA1HQwm5gbnaTbCWKCUCJ3BNJnHni?=
 =?us-ascii?Q?0P4LqAnX8GzvSI1pBRbRyDYf16/VnAdwhrNXSJqckIwa4/1LmES72gqTUJzr?=
 =?us-ascii?Q?H/nyG2UA3jcW2OYVGRaacS+iPWiRqzDO3wwNpQgCd46Wn7BUdUfZ4fNdXDGs?=
 =?us-ascii?Q?eKfMhKMDZG3OerQ0pCqtNKXr0+il1uERaAn/yh0V81EMN7JWoBH/BzRFWxim?=
 =?us-ascii?Q?Zm4bGPCc1UgjZMmNmfO8poOEfz+XymYJMqKm0HPOYWgHe3NbVdT9WiVrdzNj?=
 =?us-ascii?Q?CEgudsecDy4EL0fkjTp3tWIqvGrjyfN93zf/ENI0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e821ae-3853-401b-e350-08de3958e84b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:31:56.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24WQFxrYKF3RNkcET4uWwBMFCnMy3DVzGy32hAmr8IQVVjmulsZz2NM46ymU6+WpodwTzIYHlfK9g6g6z0FUNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11556

From: Luke Wang <ziniu.wang_1@nxp.com>

Secure erase should use max_secure_erase_sectors instead of being limited
by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
REQ_OP_DISCARD to allow each operation to use its own size limit.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 block/blk-merge.c | 9 +++++++--
 block/blk.h       | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d3115d7469df..0885e4b982ed 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -169,8 +169,13 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 
 	granularity = max(lim->discard_granularity >> 9, 1U);
 
-	max_discard_sectors =
-		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
+	if (bio_op(bio) == REQ_OP_SECURE_ERASE)
+		max_discard_sectors = min(lim->max_secure_erase_sectors,
+					  bio_allowed_max_sectors(lim));
+	else
+		max_discard_sectors = min(lim->max_discard_sectors,
+					  bio_allowed_max_sectors(lim));
+
 	max_discard_sectors -= max_discard_sectors % granularity;
 	if (unlikely(!max_discard_sectors))
 		return bio;
diff --git a/block/blk.h b/block/blk.h
index e4c433f62dfc..4cd5a91346d8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -208,10 +208,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	struct request_queue *q = rq->q;
 	enum req_op op = req_op(rq);
 
-	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
+	if (unlikely(op == REQ_OP_DISCARD))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_SECURE_ERASE))
+		return min(q->limits.max_secure_erase_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
-- 
2.34.1

