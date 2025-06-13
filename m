Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013056.outbound.protection.outlook.com [40.107.44.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6339291C3F;
	Fri, 13 Jun 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808320; cv=fail; b=Qv4olPldjWAV+5rs3xSQWiA00Hb1Wi+H2Bx16VUk9gRsxeHnhtOHRCmCeiXrdKN1hUy1UsH5VTYMGZWM4mpR2avAfL1KMHG/Z9IT+g1/uQvrhGbv6pgsvlUSfaVvN5y2hC6jBTs1HADcUW+9CqyPZsox3T3u9t//+oYNoJ6SzG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808320; c=relaxed/simple;
	bh=ZWRoYetttoje5wlek/B5QRUqyDM+NYzivzZI34Jr2F4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VFWMJvT9GP/M7ZvFjYjP2R82RpKN+IoqCygmCVS/AjK8JY63TA2+LpPS8lfRyv/MZitKYf+F5k2EjVTV5fgiZeJOGW5NIQzfh+q2gbV6FWGEf0wOj0bN2SDy0cigUmzwfHA71RvzY8K3NLvQ0TSvIe4g3F+3G10OUMLCcyaBLzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dO760Fx+; arc=fail smtp.client-ip=40.107.44.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dO760Fx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8ZgPJQCXaj9Af3Xy1FZc0LVsbZMCYlUngNRlebRHkFB4M1ceVa80tRX3J88CSTgFhI49jLh6cSa76ZmmEOxEwrukYpemfXD1k0Kw7uW22I+oP/er1sPy1qcoIfyu1zR3XDgXilzC6s0nlckfJDsoO3jgtcgGXvGzsJsm4/Sg9eikKPdI1qk1CVx0F4ktkp8nCZVhZLod2BxAZ/brDlNH3Gzlwbmz4J/07XkIftzPFybWduPMlB6g1PdCLgv2vRqhjkCKhANb2aaIAAJkzyDYIiCztaIvLyNviOgbSM97sEvCEoN0AXO0JHBBRo/fTprbavI+/KT/Nvoyn25zaOz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alos3ccq4X/mvMP53e6JKkUJP5Dbv775gwrS7vTT9jU=;
 b=Q1kzmUOCKOF/YcyXl6/cKKVdlG63/ucaqihVikQz8PLbJHHstB4WxsLgCS16bpJiUXpAx5BVjmjL+IpnbVekmU/7tbZV/E7bEYQyCl+HYLeXJQxbcCsp425mvz4gl8HrQjo54ltW9HwLQYsUFH8/NJlTOf2JA4RykeAcjVOieUSgTEEqWep/SzWqT6fk97OjxLXWlcwCetCbNHhmrpkfJg55+7oAQvWiF4bU2xU0gCkY029r2ss2acLd3MDMiuAVLcvbZV+vQe3huHg4E+HzuFwwqVxcpavf5Z4XYbj/21K7W5FWIUQk5l+j6eNB3K7CCZ4WY16uGDamTc3DhsyL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alos3ccq4X/mvMP53e6JKkUJP5Dbv775gwrS7vTT9jU=;
 b=dO760Fx+UmykvGK9JhO9onLXLsRmSc39S4T/Z8EFfnp4P2ABLwWjCBFPW18K+j5v40atNF7O0n1wms8rk1f9YLzS10i4+ujV0opH7PDbG2CG4hy45ubqffb8sBsiYXItxP1tQ3d7TnRdl1Vr0PJ+42RPXU7htojAZzrYMaUY9WCO3laUGxf6bzY7XNWcxEWYQSg03NKT1cP3ZLVqtsgsDySbrCYI7JSWoAWAgddE2KAQIrhRbr8BoRU7dZP8p9g5TXrl72lA2ejbb/vspdFkpwULB4NzLxFpsNWtwM/XP0daJSHpV4QWKu0U9GJTRQZVad9pb04zf2rl9OBgNeUwsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEYPR06MB5672.apcprd06.prod.outlook.com (2603:1096:101:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 13 Jun
 2025 09:51:53 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%4]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 09:51:51 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] aoe: Convert ternary operator to str_up_down() helper
Date: Fri, 13 Jun 2025 17:51:30 +0800
Message-Id: <20250613095130.3025363-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEYPR06MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc08863-c16b-431d-8322-08ddaa5febb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KiPwFatBFL+uuciXGtEF37CbQZo+zB2f+0UFfct964Ewqig/5r62QqgbIoVp?=
 =?us-ascii?Q?TN6dgXB4JP19GFJsXvJnTE/wxUSWlQn84v/UOKSX05HnehfiH3q351m+UAHP?=
 =?us-ascii?Q?BFgM972H14Tk1jn/kvTo1Gzj107Zt4hA4fgGNm9HqYEFLO5yZ4BQmTDf8I60?=
 =?us-ascii?Q?C8vhE1dRSmMy2+vc+zgDYrpltkRmTlQUYFpsmYgxXHXtsigO5E+PusS+sWgz?=
 =?us-ascii?Q?WSowUPu146A3lOvbJIfEm+hm5XmcPe0HBymkJB/7NsLgIbnHRmZm/SSLcqjR?=
 =?us-ascii?Q?8BvQGvDcf+E0M30Cd/P9lbxjL0qcQ/Sq36UliEYCP0LcbmWh8YmzFLE6C6jT?=
 =?us-ascii?Q?P5TlyzEdd5iqNpKwvxZMygLB3KH/HzfOeQVf9uVncTdgJscH1nlQnhVSz8co?=
 =?us-ascii?Q?SFHQt1dPZEgHO2yyyPLoc5aHnNscN4VBTyQFVnxCW2xiqA3pewWi3vUf7WQU?=
 =?us-ascii?Q?wYmpji9M5QCbsBIKGdOYpsOuO2E4XxSO1L0e+vECiUVMmPObBTDeWrLAqGTE?=
 =?us-ascii?Q?odhlM81vuVlSrYaBIpbPpfDqWQX/d5NTtwhm3PBoToOipzEMQ9c4ZZla1W/d?=
 =?us-ascii?Q?pf0EY4n2lrIEhC0LewY8EQeCdqV16yjwH2/fxL3ukC1cf/5nOyC8eTlyKqX/?=
 =?us-ascii?Q?hW69kLhxlzqqbTgBRs4R3eBukdFELsPxMrPpNK3wEf9B7bSJQXn5uX2mNAko?=
 =?us-ascii?Q?09PzFiqeCxxZhyg0pubuqTJrQhFNZGngD+i4HVa3WNvnP9ey5+Ozr2avWlB3?=
 =?us-ascii?Q?crjsngul3CTH2oxcFhOwBNKPRKEOKw9lTevO+iKRdWzQCBRph2oa0zy1+tV/?=
 =?us-ascii?Q?xwvQrAxRgONu/JuE4/O2Iv5hHv5q1znNZzoKTphG9w4tUdrgT2IuidhHR+ny?=
 =?us-ascii?Q?pTnl1VCKmOzwn6ASgF+oYbyJC0FE7waYnK/xL1TThzItpWAgNw3ZLZRRVcpg?=
 =?us-ascii?Q?ZCVbEV/Z5YQMJYsvM3Nc3LZIhvF0gtnlWlj2Lt2AscXArokIvbVWh+Uq/ZpO?=
 =?us-ascii?Q?Tz1YUCrXRtzHfAVReJyuBmIVrQLW9EvntSs5ZLJPQNFrKzzaxADCbq2bZ4/t?=
 =?us-ascii?Q?DKwtJczuyyvWfzXM7E3Jmdht8NnxUKpoiAGNZBTVMX0GP0VYIt7KDgj6Dzoo?=
 =?us-ascii?Q?tKKmPDL7YW6Fdmeov6EUZ7wKIg3LQp7ItxXByyE3skB3nXRMy+S5VwbxgyPR?=
 =?us-ascii?Q?q0+g2us1pYTFQ0maKL9BUBqqP5uAEI1DxZqyddGv+0lwmaIx+M7fuBFvIQav?=
 =?us-ascii?Q?0db20IX6l5FnsKx32+p7hR9zWZSoccWbzSlOdqkXS0SkBIrvVoMiwyTSV/ur?=
 =?us-ascii?Q?3PhttG+sZOKcRb15713UiJxu+5F8SoYs0gpjm7S71sC6fZyRLK565YR96Gus?=
 =?us-ascii?Q?x/RYb63m15cwgRZkpk0EvU2zb9ocKnWKqUAKJykKEvJSbaB+80KG79tPo2PU?=
 =?us-ascii?Q?rk+vVL0EZBlqzHClvB0Rr2nFL61n+2OD3fSPYjvKNIVsNfS62GL17w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+mCH3r1qmTM6bw5Q6u89zmDc0Ym/qCcZIuBFUwwLeGlZSYIIsLjdipxZYJJH?=
 =?us-ascii?Q?URrvsKj6pVPQPF8qRTzh8BR/OOPgwNfVOX6kJyr4gznu/JNEPqzypLKde6bb?=
 =?us-ascii?Q?1j1TvEmWB/HctVARnD1TJlv9NKtX7SxYNW5LUn5DwSkm4drTXxqxYxsJDYY9?=
 =?us-ascii?Q?BTn7l2vsDP0pV+9r+R+VXXoROWRjEW3bjPvQAcydP8d8pNB+/XjqPCmXeGqG?=
 =?us-ascii?Q?4+xjlI9dy9F8g4ApqfAU+JpdubWV5Fhs8Y/rkc2jRGf5lbR+eXB+UaACSTNB?=
 =?us-ascii?Q?2nfEEKNUU6pvYV1JIkkR0l5kGmeThBjO0/jvAP/pCen7B+6eD9bFUZrKqMkq?=
 =?us-ascii?Q?6qf1Ued5jIFEFVB6yb6bJeViK+oEhzCyy1UJqtL0Lb8dAwJasQt+YVnG+nOF?=
 =?us-ascii?Q?NljVnYKHcIRYcuYhHPSjd3UtVIC/RVL0iy5OatO0YjIRr/3r9p8CozcqEuWm?=
 =?us-ascii?Q?zXWJeTKQY28DKsReEL+VYUBEbwWkpsixigkRMhnbUa06nC4efJ1XF1zMqGuA?=
 =?us-ascii?Q?c9cIpCWThkZ8fgQYqxBA/xXMflddsAVmOrsEnpUja2PVlLJ4S9zK79E6whGN?=
 =?us-ascii?Q?P493/GPJ0/pks6cinr8yBZ2BfPNtnzM3HiV4ZtSezLYzZ38SCSWd8+cJ9B9Y?=
 =?us-ascii?Q?3jv/G6QkqBQe3U+GvU03cxibMOaTZxOBrxNMm4mJf58zdpo8CEyasdQUJRrQ?=
 =?us-ascii?Q?xJcEzfmciXEnO4b4TiGP3sDu8gIWXoTBbSoAwnfC43FDVy5bSRaMOksz/o9I?=
 =?us-ascii?Q?Y7BHYnApfr0Gxr3cOlkcO00QRo+qioZvlt1DuJhXGr2oiOgtctgObL/b1C1A?=
 =?us-ascii?Q?PY001PqHi/P7jknfTjPdLM9TYq4A6RkTOFBuKBgsz7KaedWETZSANH5e15A1?=
 =?us-ascii?Q?mk+3ORq/XBNxP+oSn4GWrJcGTvDILTAHZSSyt/kghoJ1umjl2ctGo1l/tX+h?=
 =?us-ascii?Q?KqrQVkOXpNx/t7GwNlc59mjT9DNgvWz/tmPGj/Ip1g9/RPUQvUimGOk50h/m?=
 =?us-ascii?Q?iQhklQd6sU7SIdfoZAG9GiZkHAJUYBeszgQuP7ZzIEBwmly7wpJIVmqV24Xw?=
 =?us-ascii?Q?7MvW9hLk1R8SuQIgk+Q5U1Fc8g3K1k1Vhjxw0Fai7mZhcoBCn+xlUdLp+JDg?=
 =?us-ascii?Q?InzEnYcY9TyHINgs9cCcYK51hLNjvhvbb0X8n/bdx83kLO64mYmN3+w1hn6m?=
 =?us-ascii?Q?PeyzZ0A4FidKOHf+oMeWHZj4zjY9mAO2kAzVmtyx4Hw7PxcQe5zkCISBAvCZ?=
 =?us-ascii?Q?NDBghDwCZ1XZq4mnGIwru29CxUYjsyYF+9qFd3hNCTPT39CJoOQlJdeMy6H2?=
 =?us-ascii?Q?iBGHfuHJikFsjkll3biwdlkGT2wEPI5O+ojUv5O9hNtE51c74zzdJW6KY4xU?=
 =?us-ascii?Q?32lpA7Lzf/53m6pi+NcOqxvHt4ICBSiTAMEm0gUYvcaWgoI2zDW9KjSvbCkV?=
 =?us-ascii?Q?eCZgIgiH6dODxCRxGwgR4DGJ97xYSEnPaMgXtlksRA0fLs9K9L12YbwBM92L?=
 =?us-ascii?Q?v4EuksLAkZPIKs8eexJF6bmSGECElKgLK5m1HFJN+8byC+H5txWB0/K40xnS?=
 =?us-ascii?Q?EjcVuR7YcfRNvA3QkA2Bcfm/Qz/MQkGScET/JL8g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc08863-c16b-431d-8322-08ddaa5febb5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:51:51.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65aiEIgfudpPU8t4sG6XE/7SFC6SAdyVh+I3IHrMb6YrvuQAsXDzH6oRR3CxSufaeSNNFt8Vmh5oF9DJhNPRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5672

Replace direct ternary condition check with existing helper function
str_up_down() to improve code readability and maintain consistency.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/block/aoe/aoeblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 00b74a845..0d95e06e0 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 #include <linux/debugfs.h>
+#include <linux/string_choices.h>
 #include <scsi/sg.h>
 #include "aoe.h"
 
@@ -37,7 +38,7 @@ static ssize_t aoedisk_show_state(struct device *dev,
 	struct aoedev *d = disk->private_data;
 
 	return sysfs_emit(page, "%s%s\n",
-			(d->flags & DEVFL_UP) ? "up" : "down",
+			str_up_down(d->flags & DEVFL_UP),
 			(d->flags & DEVFL_KICKME) ? ",kickme" :
 			(d->nopen && !(d->flags & DEVFL_UP)) ? ",closewait" : "");
 	/* I'd rather see nopen exported so we can ditch closewait */
-- 
2.34.1

