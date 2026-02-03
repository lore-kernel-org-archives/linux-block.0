Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A9318ED5;
	Tue,  3 Feb 2026 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114421; cv=fail; b=X/y9NTY1Vdw+RljWHGXpyc5geIkN1E4Yo8d4amlpm6iNQLZAz4h3ZDKlYX5ysO5NIHObyzdXM2vywf8W2NAcwptdXacGAiLpbdX31+JcmYilElwtfwAL+hhDbyGssUXMAXJWlJXt7lUr0igq6lD/6Kg3DKz1w8Ce3DdDow+1g+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114421; c=relaxed/simple;
	bh=VSAllVeZTXriR9SZe0UkfNyOcmYH9JPAaDlV9ZuTxGE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aHHlgVbzLavx9hT4yQxp2zRPYvtss0qz6fqrF08qegRSnXIYD94y8c6xRSUf811fiPrEDheoYywGZdZVtgfv3SnsHdPup1rFEY1U3JNMhAC5f3vt2CwY33eZWmS9MTld4KRdM/dVWpdwn1xu4LAiwM4X0tyCx7qUtgx5OL4QkxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GCVSiLV7; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCVSiLV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD4ileOl5B4lVJseU4abbrcQnuLmqvh8c4WSNySfbSBi+S5duCluqFuhr/teEne6RL3/hOn9o9wPxfY64dzq7+QXDzWZOOrKbH0hTtAT6rJjHg8RWAhuYM52zkXVcTx/aBN/HnqDibx4m30xj2m3zqZitNyk++ccllh+ND15qOQeV2iA4/biS4mpL2cpC3pa6tmVyNQhKBYFssy0IOYJKnpFpYo6Id2ifi2Uzh17Q/2Yo22WMo+9xoxHDDnUQqRUo1qTgL9bCrjwYnt9GIT3cU9t5HDVqriLh3kuD60FeGBwQrhHsQa3LEr6lDiuiEXJZOJYgwTk9a4lepgI7/KiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=114VxTVkPgCZhez6ChvYISEB3luUOGxZMBEaI8Q4OR4=;
 b=hcrVXI75drxe6HqgEICRKqtxfoyN/ISBfg6qbKHdxUMWt78exDc4AJZC/+nOz/uJnU7/Oiobu9jI1ScG4lThdJvkhc7jdDirkkbie/nefdoCWyzsAAH6lTnNQ52qfsOd8BP1KhAS7P+FjPGB1sGkaDPgCkTS2XU/OEF/WKQXw0p7AvYHEx2nbuyltOrGaNE9n0P51sDzN9xmUVVlPnUaSJfnjamfljgdNuWeSRlO0ubH8bkq+qqmk7Cr0n5aevoRIG7Llpc90BXtEZRKiJ4IMSP1cgZ5m5tSW+6Z2ovyle2yTZJXtC5NC0WjMueeQCmbpEKI4MrWcszXZOELV6hTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=114VxTVkPgCZhez6ChvYISEB3luUOGxZMBEaI8Q4OR4=;
 b=GCVSiLV7VtQGuVICGe8MvU+/S5TvYmkKpALZUxinhfEuLkPHKYlyXfqTZ1mWyrBCZ/e61l8IqZthZQ2CBNFCFCasE0PM6xcsLzRD+Oj8a+kYri1rVZ2W7L8iacV6kWyMfIB0hTWpBUOKQcEfoVm/vVr+i+aJW/Y3Oo6h5JqWqFu0mPJQvwjMd/IbJ9FXGdmYp5ntKyJrtSY14So/HxFHg2XSMwkxAh7BZJ0JCDX3qNN1wrJ5m5fOTxcM8wVI6FWbdNtV3nT8VzTl0d0LGFR3yFkO9Eaw19mK+uUTDzar8pYNBGsLitNbvNC3hEeSmGYbcsVKpP7kDPsaaSFdN/xOUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 10:26:57 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Tue, 3 Feb 2026
 10:26:57 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 0/2] Optimize secure erase performance for certain Kingston eMMC devices
Date: Tue,  3 Feb 2026 18:29:01 +0800
Message-Id: <20260203102903.2953660-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: e6836134-b673-4f60-2f6f-08de630ec1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQeo6mMJW4pRnQL6BynWR/fM3/O68BaiL7vmmxDF8LZaTIDEtAUHpgJwr+uw?=
 =?us-ascii?Q?QMM1nNe4tyONWCbJtSxq8khFS5DLa8nKxz/3glg6AfKfX1FdXKQFIEk/epRu?=
 =?us-ascii?Q?TzPL8z0bmp+tJDppiqHwm6xot7qaJgdLWCn7L8XXDk9e3Hxw00Kj416K9HZn?=
 =?us-ascii?Q?OfFrwvSAhCpLJW9uqB3YzmzUgyyc+0d0VCtSi2hi8Wyn8tMRRpDmq4WuOjZn?=
 =?us-ascii?Q?YtcV93mIhPkGIueThMm1ebynJCtulNpcaOrwRycfRsVj8yVOKXvBQTYRvL7/?=
 =?us-ascii?Q?dQ9GLs+hKqO33/C8cQwpBSCCv5C7sL4/aa5S6QOj5WUQSL98JIAfZn+OAa5P?=
 =?us-ascii?Q?HYRmurEglGmSAlgAMB0ebH73XjiBXjcaMq0Yr+6aBaHik/zZ98TAJtPMpQtD?=
 =?us-ascii?Q?VgyNMA2z7NL7lMkPCvjzpOnFgyRYYI2TPCj5w+Zk4SHy3sn45Id0t4ngLrFh?=
 =?us-ascii?Q?TtgWmiOg25ym62DltAp6Q+OdSE8CKwzrGgJrAZ3MzcdvjlFxKXRhcdDB5F1x?=
 =?us-ascii?Q?KXwOgMeX+zAyy4wzYXQOd3d9zP/16faAA0/8hECT3upwYV6Dh/X6wZ74g6QQ?=
 =?us-ascii?Q?/Ne/XUUOh3dgyaYZOAv8G1gWkXB6jM85CIkFWu7B5yzOLdsaj3NX6X2owhaB?=
 =?us-ascii?Q?nDGcA/HYK0MJAsvCCL54ii/EuTL3DsSCWZNXtkgYTxTb4jprFQoVLVey2IRx?=
 =?us-ascii?Q?rrIxhbKTBkLrkF56xQ6sw+qDfy3XMGmn5UE40tArwEjnRxPXQCvA5pOT3N9a?=
 =?us-ascii?Q?+WouRFU9Ry7korZeptMePsJb1sAK5RiDA9ynSBDs+4MPsdFWjILhRYVUsT0f?=
 =?us-ascii?Q?Prks9D+31YrUczCdP1mEdDQyfPnh2Fybh+Mxc6JgWg7X66qEKGNRTPN6BzY1?=
 =?us-ascii?Q?Q4r7zlS3hYpVBu0jKZgJQTryY7FUE3J2XLbnTHj44GDcT0iu6PIplPRyPYgF?=
 =?us-ascii?Q?asAGvEM34EK5NAuHyBT+aeXnFnLmfSsHL/CbWR29XKWA9umAblp92KhUO5bu?=
 =?us-ascii?Q?hSnS+lAzUg/Tu6c6UO0bwyBqrvLNYF3Y7XX2Sjhw9F2Df9IspkH76BghTANZ?=
 =?us-ascii?Q?FcXWE/om69oVqoiuzYI/n/rumDlPRQI2mArOfU8mtobiNeL9XgKpKpKmYD0J?=
 =?us-ascii?Q?lIxJ13xx9jemm2Ooza4kXnIDxV93HOx8rK+ma5K9wWbnihrGfvgKha4CkJs4?=
 =?us-ascii?Q?74UjfRsnsuYfwX/bKTg1uCbDV5ZUq59dnQQSDQbqHWREG60Yh+OFqPr82Slv?=
 =?us-ascii?Q?inTicbdY4MMqxxGdmCGctzKJY9L6aKUaCNnR6hWXsyWtp58R5rEV3egChxdA?=
 =?us-ascii?Q?Iq7C2h+HgnKlEGVi/+YwyMVWi5p1btD9W3IAQF01e8ACCZNLsRxvQ0T8Z9Bg?=
 =?us-ascii?Q?4yJCvFNgKSQsmq/BtNXErJPykokjrZIOP3VSZDcuP6cA8T98BJwW/KJacCkG?=
 =?us-ascii?Q?tprKGouzS5QpaDWlwYBYJ5uACuYDisTmNXCj0NUYLZ0OR6GIcMDPKYQ45wa9?=
 =?us-ascii?Q?uc2jQHRQbke7DZULFl+rxFrdVSdHxFcOnoo41whb7OZSOvDNCFCRS1sO3+OX?=
 =?us-ascii?Q?icEFNfxok5ilV76eQIozMZKEsPhalcIBtTyqlkAXll9VxQ6cOnwl+HysAFsR?=
 =?us-ascii?Q?RimUUP07rTX6sxDstih80JM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBHuH90mKQY4kA6vSOQgQucpm1rColAercO2QllLHz/SzKhOUn6fx2GM5i3z?=
 =?us-ascii?Q?dVKKQjxM6q62yGuahf9yWWqaLNUipSVu+REBz3mN0neUNFoZnp0gtCwpbj1X?=
 =?us-ascii?Q?dJBLMATALTqmandlVKU6O5U1PTA1qyCYs9IRLvorJ98xUhtm9aIlpy/fr/xH?=
 =?us-ascii?Q?nqfTY9KVj6wsI846YwziUch9tSasSArgwq7urj5yEGAO1eEo1T9+jXbr6P4P?=
 =?us-ascii?Q?jswUPc4Wdvu9qhW7di8iptQntBVxFd8HuJroP/Z/yt36r/74+5HQF+lL+S8C?=
 =?us-ascii?Q?jBlwVeVMO3xh/deKM5xV3FGNdEepDQ2QUgeUkQAv3IwPloysWyIDFpVVCUfL?=
 =?us-ascii?Q?fPx2jWAUn+2Zml23FTIbfJ+y2cw8Wxjj2mdDEPmJ4qXYE2cX1IlcU9Glu88F?=
 =?us-ascii?Q?F1soecJQjUs9LEP5FL8useKzUMJKZvwtbAP9Y0BXRecx8JpU/DTWko0o62p7?=
 =?us-ascii?Q?uwT/Y7Cs33uVYHG99LCmjrNTGtnq4NZeXd3eMRQF8Wok0hZM5XTTROQ0EW06?=
 =?us-ascii?Q?Nz6ni3XORrvRJq4z60YDMvucwn4PqhvTpsmdl9ND/keW5LP+HsAtMztt4elY?=
 =?us-ascii?Q?rNkOmYxEmGIrc7HK8jMboZoo7u617mqZCAfzhCLUczVr05OHjeMWOrIksQyl?=
 =?us-ascii?Q?5lAYX/o8UpG3CGvpDT7Ee4/Nj/K57r5OQYyKG3qMNwkA9pauKv2X2J7Voyho?=
 =?us-ascii?Q?oFkNOB0JdHqNempzGSXb6t/x4u4Zv1mS70uty06Sq3lX6w/6rHHPAN0EghHZ?=
 =?us-ascii?Q?DwC0cKSWtfrYnMNCoUBeizXE2km1VvLI0gvpb4Rzqu2xuQE96Ty4StFOSVCt?=
 =?us-ascii?Q?xqIZhRdus0KPKo8ZIEcA2o2C2mgv+3Ha45isL2d0Vt6g3HrtE7OcHOklPFXm?=
 =?us-ascii?Q?KHlifjD99tJ2qglWnpmVBO7sHSIlqtDBwkK6mjP5NJozDl146v4wTzEgus+q?=
 =?us-ascii?Q?gyn34FQm035M0Y5N5U8i+rTVhOXkdvW+SXVWhcu6nD22sN40IxDP7Pd8IRJT?=
 =?us-ascii?Q?vTDeQWCLLTFIzzGdaEbW1JUY/uFZHfW/NQNKR8hIqy3tgvpMHvojkal5Mdzr?=
 =?us-ascii?Q?vK3wSKpb1ierSYX5b0JcyhCxaNRguIQlgWc8LYK3+NjzSxpy6preBpBJfUI/?=
 =?us-ascii?Q?7vOumDOD8YVp6nQkmr90wQIxDAeRttxlvoV506VvaDyVI1zDA305C1gtCHaU?=
 =?us-ascii?Q?xYb3MH9BNSVo3IoxCT7rFaQvBp+/dDuFlemmYn1buCZmJ4BBmD17HsrHHZU0?=
 =?us-ascii?Q?lmJujvn9dDZ0sl3hc7/UGj32/3F76EypgcxQH7UZjYtyDX70lBSl6h6rj3zW?=
 =?us-ascii?Q?3Jw0GXOt8+/o+Qkd/DR6BeUA9d+b06j8IJP8Tzl5yVMOM7O++fyp23Yj4Pgd?=
 =?us-ascii?Q?GDgFJrTBJbRDAUIsx6DRz8UvypJfP7jPXz+hcL66XBFOCSHPN4Xaq8PlVlso?=
 =?us-ascii?Q?u3fc9p+Dab2DdJubj+6270FBUZhYSzXpCkDOrRtZU5JQpFwY98qBZWgPysFs?=
 =?us-ascii?Q?GMpedRT2S2q6TDpVg+QfI1rEegg6G3YW6D7q/6ZoeMk9gilfp9qoS75Px2m8?=
 =?us-ascii?Q?et3ETDh+xkDrEOItlNKBhVoQ5qhFbM9LBMrPCwePOa9GfQL6hvW8uP+zXfAc?=
 =?us-ascii?Q?zUOYwk/qI4jd+xLSqW/ODg/7etNyJoaXvU2WRnfYcNiYXNznxvgCwKs9+L2f?=
 =?us-ascii?Q?G5A4/j7VTyjm4mZOd+w2NRZfvkQnYugZn/jb3U3j6jN6muzgZxuOUY320vct?=
 =?us-ascii?Q?7PVARNrenw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6836134-b673-4f60-2f6f-08de630ec1b7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:26:57.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+lLyQxwAtaIHvSLiFym3z54lfZ7ZDjXg3pyMR+V1FUO5J6rU8sFVXLXnHfIm0CWGaLODcozlPPT7HFjTJ3mcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

From: Luke Wang <ziniu.wang_1@nxp.com>

This patch series optimize secure erase performance for certain Kingston
eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
erase operation regardless of size.

Currently, a 1GB secure erase requires ~300 operations (limited by max
discard size), taking ~10 minutes. With these changes, the same secure
erase completes in a single operation, reducing time to just 2 seconds.

---
Changes in v3:
- Refactor to use helper function __bio_split_discard()
Changes in v2:
- Rebased on v6.19-rc1 as requested
- Cover letter: terminology fix (command -> operation)
---

Luke Wang (2):
  block: decouple secure erase size limit from discard size limit
  mmc: add quirk to optimize certain Kingston eMMC secure erase/trim
    performance

 block/blk-merge.c         | 21 +++++++++++++++++----
 drivers/mmc/core/card.h   |  5 +++++
 drivers/mmc/core/queue.c  |  9 +++++++--
 drivers/mmc/core/quirks.h |  9 +++++++++
 include/linux/mmc/card.h  |  1 +
 5 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.34.1

