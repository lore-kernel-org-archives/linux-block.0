Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645532C933;
	Mon, 15 Dec 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793906; cv=fail; b=GpCytXRgHwjvOR0qQGy4qXNaMzfEMnCsQhwNEOay1WfgETdYBpvX1kDtkpY+PgFtBTtBzvhiaUEEz+79/+yS5aUeOKm5cLMERc3nfyUinSeH5KVnxMzj53PFRDrlDJ+H+eN467Mq/NdWuqBB4iFHLRY3wUE+wSu02UIrz39m2xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793906; c=relaxed/simple;
	bh=3LyGln9a/+3CHcQ3x7Lmf2b2TUBIiWvPBaxIemJ3xOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRNdWP7GFfvoj//ZAFygrzf/UnMUDfY8G3nRoXzJnC624yCyKaHCcpNASMVgiRyTsE5mSAYkyQdFpWf6x0Z9xr6eUQZA+rhobPAJuV2Vvp4sKlC1Ezw9GtMXrnNGu0krVxIe4dii0xlKK/oDAr/vmO5cXq7CbR1+ZGwiSlMoHf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K9oAaese; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9oAaese"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcFN2L4Fu0fkLDfcNNSWYJhlsbbQ3cF9Yct82qsQnnFuLv8lOvxYPOxsN64kK1VTnqjVOGYnSgg2b7mFdfSD/lnYiXEQlZyR/1rQ1S3ZiB85aJZW4G3Wd61CaHYeH+LcO+Mkn6fO1cXQY9Pj701erSyeFP7NuRXx84zx/3yhoen7fjiGHafDMcXUOMvanL9XZae6VG9bLU2WY0PA9ClOvyYZpm8P5xS82X5hyNiXLfJ++FMoCOVe8ISir/IdsK+Ly7Ov9z0aPfhAetPjKP11/yYZlZADK/bejawbpNgSzmz5RsEw2gU+82JieTlizZLclF08tM18gr5uG/vfCv1lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMlsupzCFCk//rlBUiP2xjUxUFnVaeY8BOLJX2H9Dw0=;
 b=EHoAevlo8sodi2mCpF555paI4NdT+hT/+Xn6stb2rFbe6rYxeBnpAFQQlnsE5Lu8oj1dr74uS7Py9NQ1KorfAmJjoTz9RP10OWD4GgilQL58hSSStLGnoVATuIIhLB2tsV3FlaiaZQSj0vYZwLSOJ/wNMWynfG7KHcTa7lZsXe2eMrVGG4JSqYQ2WZt4Z/GUrs2NIcDhMaenr5MTuHIb8Gjtbcw7O+4cqpM0dJj6W3ia9ns7/qwwJJW3ToGhC2VA/1yRZURvAnw/RDtptWJZ7quU3ITU4vw16ly9xx+H7DRUPLgNvkkZ2ksUgVXTz9V269FisDo9lCjvC0JTMf5mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMlsupzCFCk//rlBUiP2xjUxUFnVaeY8BOLJX2H9Dw0=;
 b=K9oAaeseIDCXzgHLXGKjCQghFDbi7LhOk01mOB/A4c+fwWDsUqveOKnVQIExt/nI6IBAvjPkKDPOiHtkKOKuWW8jikZeJCaSZx0MOAoCEY7dqtCqdcvZf80CHnyZGhgq+pk/Y4Zc74C2REmk0sucWCldGNI7B/6+5VWnZlJXbukILoa8SWnw6il8OH1QCtt5ep67RIR6peZkilHhBbjup3Of9vYdlqk0FVlnyAiwIT6JNjRp9ZPyVy4qy9CAmhF6COw44X+aLmjV8HIGgffJb5yQtXJc8xLcde3JbM4meHBqmXFaHQGACfU5xaOF2PE/dld+Z3hB7fkoV1GrSMAl7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:18:20 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:18:19 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 1/2] block: decouple secure erase size limit from discard size limit
Date: Mon, 15 Dec 2025 18:20:09 +0800
Message-Id: <20251215102010.608421-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::19) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2025564c-f8fb-4a89-b726-08de3bc34505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9WGnMTha/km6gwBUJooe+LtxYIqIitb3UFARcKZ4Dt56UI6qJ3QxXJAcW0AU?=
 =?us-ascii?Q?ltfNtvgwf8CwYtV5R2eFs8qme54kWcqno5v3GI8dlKjIKNAFPtI7MSk7UAjJ?=
 =?us-ascii?Q?eMiwv97ZhKKhZD3l2M0l8AS6rAyEHRCgCfbV7Gfx34KmqY7JgH8Dx27TKW23?=
 =?us-ascii?Q?DsNL0wBx/em97Btbq/Ywz8v4Y7A22OODkT+yBluzfJYSm0gEDBBZ7S37Y82m?=
 =?us-ascii?Q?zLGDAr/ShVpnSyP7lCEBbmc7I+FTR2/k/2RrDtZrxtWUl5jVNc6i/IdsQU7O?=
 =?us-ascii?Q?hivrZDhf6Ot2f+BXJaEV4PNV+JGZ+kng8ISaylAgeyPh7lXhKnNCaLiuTdBv?=
 =?us-ascii?Q?ripyqMmoI/GLb3z1MZPcozFycVbbJwp5C9uAOi8EPqKunpUMLWYqLtvLZgPV?=
 =?us-ascii?Q?kXg5q7s6c0GZ7ZPj0s9cg77U+V9cJm+SKMWj2CC2OAl/gAG6uAIpk/yMjQZg?=
 =?us-ascii?Q?ro5GqDi93Y5uu15+DdLeokFm2riOEZ1CE+Rtp/feubOrIC6v8ZFlVCoLCIVP?=
 =?us-ascii?Q?IXWWyIvLBB0FkSHjpyZ8qTkXnGiM4d9bo9X5TmFiWxiAoEagczXRRWTKV+cl?=
 =?us-ascii?Q?olF2dW3IbsINuYMEcq9tOiYP9v0GRgAUasZlvNctr2FKanNS0GWzhNYlJhqN?=
 =?us-ascii?Q?NoU6kgWWup1XEfkYBep833/X9HM7gn3mtY4U1GqSQcfQ53H9uyqiYGDI0MLa?=
 =?us-ascii?Q?ThGhnfaYVhfrVCVVnJT8jxQvYLIHEWx5qrd2lPRbSDTpnewrjgD3oF7e9zKU?=
 =?us-ascii?Q?pxy5P3Ei4gq1Su+yOTeDl/rd6Xot2qOJikI3nZymNjWUeD9yQqx8saZ31rck?=
 =?us-ascii?Q?khQZlpMKgoWr8GHfC07CzrygHvDMhHXgVtkddx3DbYXDnm/mNELRBP86ZhoM?=
 =?us-ascii?Q?o18pMXOeFa9SpRugGw0IPrAs21xrNSCTWhHWDD5OzLB1eAp9YLJXPoXZtyCf?=
 =?us-ascii?Q?koPVX9SRAIp8X3F389dy7gEOYRVmVqmc/FbvYxdnJ8MyfvnlFOn+wbFlGckL?=
 =?us-ascii?Q?GoozXHLs1NWKczmym2uTokXfNI1A+IDd8x+Xgq35zzT7m2mrgmd5T212A7sh?=
 =?us-ascii?Q?FYdEPbVZDG9ovLmY51WnCxmF/N+IsmEh3k2861zU6btVp9CCyzPlhZZJ7pCZ?=
 =?us-ascii?Q?NzAWqaI4saSHLN3oJuPKU97Fr4YbYq4Oct+NRsFvbdgNsPbdiTu8tO671Te7?=
 =?us-ascii?Q?UiXoRdQopaFGpsZ4/pCbhOdwvmcEhiP6LmzjuWUJbjKJ562BKy70qlt+aAh+?=
 =?us-ascii?Q?ODwAkL2xzg4mJvtWWteG82e/8e95uVVntXFybbblZw6p5YjH62T/8cNi8Q/m?=
 =?us-ascii?Q?h+SNR87jKHub0V+jv9F/FFVXNLCV+L+ZsTZJlTTB+bBYUl44itcBx5eJZccH?=
 =?us-ascii?Q?aFoBFB+yYVM0jPsSCqPaW4IJilLPmEw2GF3mPw+iNymPO/oX+euah7/yPlxF?=
 =?us-ascii?Q?wmGl3HmB5a2OdtWSZ9PjOZCHIBmqLr4ZPgsQO2fcPrF04fPu8Ji3jVMMqH7G?=
 =?us-ascii?Q?UFSZmiMXNTOvMdgMrkwsQXbUYZIFmvqyQPg4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQjtOf5lBrFdz0DNDwR+L/jTZxkmxSSGpUS9vzjaxXH5qJrM+GVCEh9k70hO?=
 =?us-ascii?Q?9VWR/jwoC24XFzG1DtCatEYLPcfc38Sp3745jHueDqJg6lCsRELBdoJEw756?=
 =?us-ascii?Q?ehz3jYEQlGRMI5m1Ko8+wpbxCJfbTOo9cowDs7zrKmLnRO63wQrZI9r2iySX?=
 =?us-ascii?Q?uvZHbDZpSaYR+oBcN4tV2IxnN804F+XDN/sZ2lGJ+xTTTD4SD3CiRrBYsMTd?=
 =?us-ascii?Q?zMvmRToohaCClM9PMxexYjatHtN/fD7gQ2EPxIJBzCgJ7w3iKEnhs4DI88nV?=
 =?us-ascii?Q?uv97fwzklSVcyHGB5nmo658rlcds3dkOPvmb6a0wncvGtsXiV1vAiyIOTrU5?=
 =?us-ascii?Q?tKg/xDhlN9IOuH6Pt0tNQoYsg6ye6nXWTTIhFLjmAECyMNykgbMSeo3TagsJ?=
 =?us-ascii?Q?IL0U+/kKBmEyQiEN6V9Sl0CTgYBR7WPPGzgNpPrzE2IuQEJnm/eHlxjCDbAZ?=
 =?us-ascii?Q?vATkpJOYDaR9VkiShrOJWx60fRea+PktbQl6e1Z2bxapl/TPDQl7JYBI3m/Z?=
 =?us-ascii?Q?vl5GBVeLFkEH8/KwmJEr8VVcGGR6iH6diXlyqKVCi3kfCfiWiTVWu7oRvxEk?=
 =?us-ascii?Q?kBVSskgvz7jUVV+Z1+/XsJ7zKkkCyScbwtaVc2OXGK8tbc7DvDqWMnyluEbf?=
 =?us-ascii?Q?H5GcJnJsAx0f9N5nvrZNokZCid03LCwnTskGcqHJ4jAvbY/v+w/NO/2cbBa+?=
 =?us-ascii?Q?ovf6kkG/Pjpia3eAOm4LD+Uxlr4NoTRRrOe+hfzjEt3JP/50LESk+C6dPSqo?=
 =?us-ascii?Q?9QS1Uq/tTcjIrO9lF00GTV66j1wAZFm3XBMZQH6NsNE/CSSvc86R3+jGZSJY?=
 =?us-ascii?Q?a3bzdapSV7ubgIoZnWhFOoqe5Q04kwlFSivc9rPbOrRqaSj015ssen2eqCT1?=
 =?us-ascii?Q?JsJKSoXkZTtuhiOnshW7pqOOnyOiwo5fgub2b54+zSKiY4ARBPf2JUMseDK1?=
 =?us-ascii?Q?i7+B9yBxmjXWB2Ls6JtVJFYro2xWE7+MVay524ArhsgfYDjrjwUvC46rNzPl?=
 =?us-ascii?Q?B7xP4dA9LSzUuq/ViYXGdUybkkjR1Q7nA7LKND4NDS5bD3SRe7YzGqfcVBLz?=
 =?us-ascii?Q?AUOrmIdeMCxw/RtgD6qyJJ1aj5YbwJ+2B6v/Z6zoj5jp6zsO3BOIIjierTuj?=
 =?us-ascii?Q?GR9vJ0nIyQqUGQt1YxdhEMiYXFEGNUD0I5vuOfxLown4UCib5Mm8pZZmQBUk?=
 =?us-ascii?Q?sLEAyDGXPDPr+/1n/4sf/hK4Mudv6KsFurfVR4QbyxrFGwmLAtxbP+MJavCT?=
 =?us-ascii?Q?ZE75ykhuxYqZifTTZKJAwoHvPFQMm8af9wARrWwZjneehvz4ag48gcH+BUB3?=
 =?us-ascii?Q?XLYN174pUd5G4spnRgKL6yWZXasb6rAm+HYkyI96qOXjSmb9Wuc3sdku6pul?=
 =?us-ascii?Q?xWHGokbxwzl8ZblSa3R3+WNNxKyeOObrHPG2VPUtqoTuW7boxMiR83ADOJYP?=
 =?us-ascii?Q?OwC2jx2kk+rc/wuEyeQNf/vV2JrYwEUDV3PZw4XNo2ZCP1oqyG4m6hoj3lV/?=
 =?us-ascii?Q?/IGcKxwz0iBW8YbkNZuQzS7AIvRUpJSowhkd1nb7V9VeXldueQlRXhAHdOKn?=
 =?us-ascii?Q?ea1yPTs/2dFU3RLvfmrjWnhTMxa2pXdk6ZDJOQ+4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2025564c-f8fb-4a89-b726-08de3bc34505
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:18:19.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZzrSfAD2MAt6Q79xoIb7JSKOj7rIIKMEsTKBHPIKTfatH2/QDo6LiM1EsoWJGyhogYrvRj/6n2Wy3/L5OG54w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

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

