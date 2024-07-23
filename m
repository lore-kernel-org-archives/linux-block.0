Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023076.outbound.protection.outlook.com [52.101.67.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E614A4DB;
	Tue, 23 Jul 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717789; cv=fail; b=glJ1L6U+I6boWO7ZfwYyPvU+GFrIgED9PjOKi1HcJmSx2Ddr2rSZC2zIqNKjcST026nQQhvIvygVgFV4pqpbujrnlWOw4CutIXNrqwlcHFsiFxro+3HyjyF3k29WtTxxAedOXnqLJHvWdVYUvKhO9q+f2mUZigqsNWe1i42j0Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717789; c=relaxed/simple;
	bh=QGUg4dKL0WicheHlUHSl6HgAJX7MBqUHSbiJdNDTuaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dh++k4g0UMmLBnabvvXd25jXgIa/I8BwsryFz9n0ZfM40QEZeC2NXDwRwxMqdapOGZQjDHq/8gWz+VYZDADsKLGlnL6bd+YPW+2nfcdUdSBc2BjuLhQTM09xReJ3cFk+9xfVyhmP6txnJtsSIAnxzUaNAaitME4c9iUE+pLRBh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=WBq4oT1h; arc=fail smtp.client-ip=52.101.67.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="WBq4oT1h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqargcI+DTibqlulPoTfpSZ7HVoHjk83s4DL3Qy9WtbxftokdAdFB85b6FEwzw2WaBLK6aC6ZXuIa2CEEGCMrrXZTvo4UbDSn2sfFQm/+as/C5qdoyLxlnmHe2OeTrbvvqaElYWiGn2i4lEwSl8qs1xibEQkcRjVT3df0S7BgA9k8/1lSg2oBkozY+6Zr+VCe3/3/fGneerNIW8i4RbIisGa8a4Ldl56lebAiQUrefiAeNxeWybBxV5jIGeVOPH4tZ5paBTCJVgzTcEUay6uIY66N8P3OWGn5MjMECmz26yCYu5BVw1ystRnMoiBpMJvE+NcFsygRA9uNLyK5iUGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h66DTQRqNJcB+hJcxsgw6qlvmi9huvV9y54VL+AoxM=;
 b=QFk/OZjpI6+XGfU8GGNmICVviM7HPnF5VcMFbrxqvB9F/BoO6xKXvQq8wdFrewdcAUrWRPLFAXGOpthJoNSNoi/Hpz/wsv1VDfLTIZKb/yAxA7Em+2UTKzxB+Gq9O5mBg39k0dPFJ55Fa8/UXJGxmuC9lNI1s1sYbiDS8X3T6VMGD/qfVZHmVp4yfktvBfzYULf04MgolXPJjs6uOSS3I3hYzZRdTMDP2fcLBF7CUeCyEDqQRLKBUDhQogTn92kbyugXy4GegMnrjgMH4ZxhVXGseP+r9IFASls0mELHYVE9yjj31q1azuPm7kz69HzJv1AVAfvn8iO+3TcZXrh3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h66DTQRqNJcB+hJcxsgw6qlvmi9huvV9y54VL+AoxM=;
 b=WBq4oT1h5mv9soiEBPX+bZIeHhcz4DR+08XuF2cOw+TVl654wvmeHzvVywccXri/WgEUGBk0SbsOlcop4yFYhFuoAK237HtKcDww/z/WVS6saRnSRF5rE3YUgdsGwDcsSjSrf7DcKlf2CGb5x3ykdLFxPoqM8qSDbruJvFb7m6l3JlJtIYX6PNlsjBv/CblIhddRiaZqlUODIk03J8hoFsiH+FnHbrMTYK65VK3lCI9hhVLchd8g8CP/Bk5zSIWYSbOXwlgqKRHib7f4VeYylyIBVZf1zmBMI9ZYG4upAO9jnPkyIyANy5qH/6Zi0CeZUY/O2pfy6aANwdQaFU76Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 06:56:22 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 06:56:22 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 2/3] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
Date: Tue, 23 Jul 2024 09:56:06 +0300
Message-ID: <20240723065608.338883-3-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723065608.338883-1-ofir.gal@volumez.com>
References: <20240723065608.338883-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a07f8f-8b68-46c7-875a-08dcaae48feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vkNLp526umA9Y1OxhVLT8gWxPi0M1o+VIACbZWeWJg56hlI0ZwRe+UxHAX+q?=
 =?us-ascii?Q?WArW/My/kDfM1ZHM2IiCxn6hDKkZW2lKK5jjPyFy05+UsE8dcw0dgJSPVQuV?=
 =?us-ascii?Q?9gUluLNctiqxsZC2+DLpLAqiloUDgUaqxo5NyIzyTU2AzPBpOLXkLLPZhX3u?=
 =?us-ascii?Q?KCpRvZmSO5t8oWZ6UvGj1dif+ZtQhiUNucbtehIXTQiBiqqXyMp0LGHK/0LD?=
 =?us-ascii?Q?bGpBT88pFei+TWAU6mPVwBEp9YM1VkQfwMPimfB+a8tsWL4oCfY+oMp6BXJY?=
 =?us-ascii?Q?qYR/xHgenngRRSdGhRsc7xgTNDdoh0oO1G6PVe5HMHx5nmZCcU9j+6PtqfO4?=
 =?us-ascii?Q?I9U8IBZmYgTYWoZhsngBcZVyvudmYFYD1mcgnyCI5rh70I0ggmnqgHLdI+ia?=
 =?us-ascii?Q?D7DMbecycjO/EiENdk4ji87hmsE1MT7QDZWKE/+fc/yKq76y2fFrYgQX9k/k?=
 =?us-ascii?Q?2j+ArptCh6QxIFNXMRjhBhWZzPVQRtKAIqKL9KdbZD8VaLCpg1U/LEC2PE2/?=
 =?us-ascii?Q?dqJ6REWQmOIakMU7D7fJNdmtpELrXgZnUXyIaPm54ES9xx7G5s12eF4tr+n8?=
 =?us-ascii?Q?kGee29g1TvwD0BAn6cTl6MzlvGJfm1gUltJbNEV5HRpMmZHMRQ4IBCowlKhn?=
 =?us-ascii?Q?117mujLtSAExV6lS8ws5h50MYrhVORqaIEvq9HnNNMPMG3NEllcONgYTNSL5?=
 =?us-ascii?Q?VP8pqI7PkTKcTG9R4KOouzq5L7bd++mqrqaZAUPX6+d/En4rJOfs66VFCQie?=
 =?us-ascii?Q?xRm8Lzt0ogxwWjQY/HkiT6j+V7/iFusVwda243plWw2iP26TGHsIXoumnFgM?=
 =?us-ascii?Q?pt/zFdPMPWe606ZQHTAOR9o+8aZEogJQrc1Kh0ZbJB3nVuyB/k5KpoeUMVNC?=
 =?us-ascii?Q?FFasRmpn3FEDnqmrKdU10/Di6rzYaLsePFotucyuUmaaH6aTMEwCDh5tJk5c?=
 =?us-ascii?Q?s0CFttuUP9k4enKJR3xfna3VNQaPYpOhToMGbDGSR7GqOFjU/p7admJiQBpl?=
 =?us-ascii?Q?+BY0Uixu3eCrnmwpaXJno4mcY/L45IvbwO9R7ba6JYiAlPjvqaSo89zsadap?=
 =?us-ascii?Q?opwy/XA/7oGKEeGCoKPUZ3N2oBsGRKgF+uqF57Lz5sgaae3XjVO8tXXgglWh?=
 =?us-ascii?Q?/R8stWSbs7bfRBFDuX96W8LuuVbHmy1KI+qkMtM1bHV3tbzNmJXylG+J4RpZ?=
 =?us-ascii?Q?zw8AaUfFkK0s59aDI/GPIib2SBbOKfU7XxZ+Kn5oLrR/aWW4ATcGhKej/fBk?=
 =?us-ascii?Q?zaczU5a6pKxl1FOo/JzQLHPowhkn9CHUFzm13UCUTUlSTkjkSJpao2QEbzJT?=
 =?us-ascii?Q?YAg03Ak6WbblPczejAiiToYrEhv+/XW/BbOmrdq9AsgjZqweFJw432eXD8XH?=
 =?us-ascii?Q?cgPthYXvsDbXUU0tiAjA2Fhwp9VJopGuyMeW6CKxtprNnmzeKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GY6BwbkifSzL8MaoE1jq5ZHlrPhvQhcA2I0vGwslcutVAAcEUfchxq8r6JPF?=
 =?us-ascii?Q?PGy5avZh8simr+stjixX+XmFVbMi8GispbyJHVW5shVXdrPGpS7tyzEfpVHx?=
 =?us-ascii?Q?nZwj00enMKeswnfxLucoNaaaLMml3OI6wnmXjXMlf5GaS0lGVX6KBegbn3zT?=
 =?us-ascii?Q?T3DhguFRBy6+TnUEJ6zhVllyfYEhy/Yyj432SklKoxx+Tzw+0Z9G8aaj8U7L?=
 =?us-ascii?Q?T29+gxjIMHjYX4wF6gn/MvFgW6YNh9FLLDCyBjo+jrIRBQDzaeXYx2bekzYW?=
 =?us-ascii?Q?gv6uJHrC/+FbuFlcIZlY8gFyALpIGIdy2p3IndtOdGUHhUWmI63jYO4SIt9o?=
 =?us-ascii?Q?wnjrVKfM+5Vo7RUsfwA514p11eFcmyjFclfXLkk6mBwF9MZ4mw15Ve5dJnfr?=
 =?us-ascii?Q?jI2fVzo/HNEvKjeIW22tlQIOBtA6VaGVOi5j/WbsqjXuV9PiMwP02Aurb5Zw?=
 =?us-ascii?Q?pejlaYs9ia93MDR19XuaASBKgXDDLcJs/NFPhDmwYMWMLesakfoWaWmz/FJ9?=
 =?us-ascii?Q?72zZzxDjEgsccVp4tYUG2iGBe42migKHH3iDo5M65N59ByyoWohQ/3bD3Qpg?=
 =?us-ascii?Q?2gX1gF34/1OdrLoEAnNNS5CxsgRoZLSdQaKLb8xvivLwu8TVZgPjUkEFzH8d?=
 =?us-ascii?Q?0TSrq8zmhqsK4JXnFX4h3cM/p3XVV2PdZUgBjSzBjMOlPO0P80Vyl2Z5tWVs?=
 =?us-ascii?Q?8j6EEImmPgVkyeqwkwB+QbQCZDByvD52TtVIgfjLmsD62Xb+4ic2S/XcmJV/?=
 =?us-ascii?Q?d/Si8Zosa3p5miDOpoFHmLc54Ud2PNI+e0AEIcIlRXI8kQAIiSLvONx4RGhB?=
 =?us-ascii?Q?r1M/8yjGtZsDQZiBHf53m6b4jF1ZQZNKIO2Lol0q+8CfOR7VcbjyOGR3j98e?=
 =?us-ascii?Q?o8mopk9GgbOdSNgyqg1GCaltfDoCnVjXRb2miHrrFYc2v7NlDsNDXne/riFv?=
 =?us-ascii?Q?5Ejn6IS6bWAXLZcPhBLpykd5A/3yoY8DRxDJfFeLnCFTOJDxmyR4MnD7Ka+F?=
 =?us-ascii?Q?52e+UhIQT8JzFPYdCTMNzc0heRKfKteX9ufKLizaVtHnz1MIQojfBNO/KO6X?=
 =?us-ascii?Q?2smYzdtmyW/tZJApk0i34S4ZAalXQTgNjMh9FCD+JxA0c7PFewst0sFtCvX/?=
 =?us-ascii?Q?M4mxCivR5kVoqEWEtNpksX9K3BOH2z+P7HVhvFkoZvjGIyD2cTtJbVvR+nZ/?=
 =?us-ascii?Q?yeGKQLBWw5iJ4EfdKUjbF+PBWegT5HxAS3HmP0V03bAVLsrVBE6lTwvX9xj5?=
 =?us-ascii?Q?KHhmPP5lM51gUoiEsvyX/LUslmv9Qw9uj/l0TQRuJ4ShVx0L4WNg4ThOtW5d?=
 =?us-ascii?Q?Nx8LbvoMg1nku6GGfhS/DzeKi9rXX1j5rkJONgn/OeNWx+iZj3SG/QSuNIXM?=
 =?us-ascii?Q?DrFEe1cK2sLnnLSd9rCEtM120WHP5xbWRlbUvLKPXsVb+GBjVA9x5MhQoWb0?=
 =?us-ascii?Q?ky1IlutF24n3K5ZaEqALdssIoO54mKmp2zhZlU4RsZqznu7b9rlQtmaPGs+t?=
 =?us-ascii?Q?4uugJj0xg8Dj8NbvwU3mfYrLq7RMiLUD4ISFRrTtTB9PpEOvvAAsfUd91hWX?=
 =?us-ascii?Q?CqcFKs7yeJctn/EorhMuF5G4mE8xCKpVzuVfgpOh?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a07f8f-8b68-46c7-875a-08dcaae48feb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:56:22.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5Pi4IGp435bA/Qn/e41xeXMJYHY8OwHouCpjnZewhQi5AR8WvSQhrEwMqU4vvPeHl+tEQzNOrt+AASgwhHlWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Currently nvme_tcp_try_send_data() use sendpage_ok() in order to disable
MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
may represent contiguous pages.

MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
pages it sends with sendpage_ok().

When nvme_tcp_try_send_data() sends an iterator that the first page is
sendable, but one of the other pages isn't skb_splice_from_iter() warns
and aborts the data transfer.

Using the new helper sendpages_ok() in order to disable MSG_SPLICE_PAGES
solves the issue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f..9ea6be0b0392 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1051,7 +1051,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			msg.msg_flags |= MSG_MORE;
 
-		if (!sendpage_ok(page))
+		if (!sendpages_ok(page, len, offset))
 			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
 		bvec_set_page(&bvec, page, len, offset);
-- 
2.45.1

