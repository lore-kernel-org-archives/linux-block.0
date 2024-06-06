Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F1195998;
	Thu,  6 Jun 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682284; cv=fail; b=qznx5qmTGw2oObWEsRxcLDAuAAxpOs14/10Dy7aq97PZHPpSOoPJ2f65QhD6LFQS6O8wlrnPQus2m5jVd8tkOEedpcr5AHitJM2Uc1Gj276QomMn427pDG8/lNyygER9nZVIFrt1xfYKT2MfJOrSEvwjELDD0mqOWLzWQtGhQzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682284; c=relaxed/simple;
	bh=RiFOkTigQhCwyyEedIwKeuwgPMjLaIH9pxr+ZR3zJTI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BmWSRl7YT1Mcf/TKVPbSXgt3iOQkqhbr9xDa5EXTtuIH/NkbxBYzd449wO+JFzhRDoYiHw2uUH+Y1IK+zKVRsIrgM94LhthFZ9sUvZEsUHfA5ST+ncHwb25tQEzKovxOpP7rkZfg92V3/pK59oA1aUFWpVxXTQbJ35025xefdKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yr8n/yGk; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yr8n/yGk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iolkCxfE9T283/VL2XySxTnRVOhYAnwkbBl5fZpaveSF1utnHGfq3rgJi6G6e8gISvEkSe56dS5FFW9g94paZRJayN8yimpRYiXPaZJwud2guR4iaMaxr3F3qpTssclUbRiQVTChvsUVQySN6t+2lj8DpGNTkymIG91tZNVl6qBqQeJINlEI1/K5OcLaD+yZO2MPbLcqDk+nbegHBO86a8lhpbL5YNIH69/VH/bOSXylJa6DXl1GtHXodcWJJd3kQn8Ngg2WJk3NiZtk2RzE6v6W2LyRK/nGum5O9/lfomf0zdOW1BKmKrd2ELbVmsxi/5NV5l3apKxj7pSekkRnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U5hmFU9JYPvvft8cil3uoLmcYvY5tHRSsftl5+QFHU=;
 b=Apftx3SRo2C9a2tyql8V9+EZv8FSEWGMphsj9QeU9qVaGI7egO3aVdobe9VJQf++SgWulEKS+SroqJhssz+HDTR5X+YJMJumBJtHdKnBXAnLQYx7Jg7Bll2kp3W+LDEZTQ38xo///NRMfbHfnxQUcqYU7HcX2oIPq/uPgZbySA0HwkuSv3Mq10O3gJgIs7eHJCF4LbdBtb6sX/IHL+6MTvKD3sK3hZDqnM1PiXUk6R9Y0hG4JHJxLDVGyxEHlcBJjAh6Pc/TBadhfmykYczuVfw+901AUuhq6dUpCEsS1jEXAF0vE7CctGvVMxYSxqZgxsm+b6sn9Cyw5/cPqWwWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U5hmFU9JYPvvft8cil3uoLmcYvY5tHRSsftl5+QFHU=;
 b=Yr8n/yGkmInHXbn1CH0Z16jMRai+uAdie/E+NEfgM1dRjEH3fnIPDAnEhFIz9h3iXGlER0hmRHRz6Om7Pwwt3gcU/jM4/HwaLaXEQA/j+qZbI511mXRozuaIN1+EJSQNgoM9ig/q+LUGtu6GhNK5A+UPIxEFa+1Z8BT/xodYAniiP7wqyuL+E3H0SMknIAzCL9ydh5KlwEla7QGyRk4XqiuZdCPaL/FzmRrahdj8ZXw0TViw+v/J88FJslYM8Kn48Fo9eIknfbGRzwqAxm+omT51f9fb5O16KbZBBjXTqsel/2SKH+cnzJcUjKy6PHjXUmfNaJgd3zu7h8MGCgzykg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by JH0PR06MB6317.apcprd06.prod.outlook.com (2603:1096:990:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 13:57:58 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:57:58 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yang Yang <yang.yang@vivo.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v3] sbitmap: fix io hung due to race on sbitmap_word::cleared
Date: Thu,  6 Jun 2024 21:57:21 +0800
Message-Id: <20240606135723.2794-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::20) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|JH0PR06MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be3eab0-6368-441f-8947-08dc8630ac04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6ou1yw51RxaOGyhuifcrzsNe8yQ0YGEqf5we1yksDSmQCxEJJcIaGdVEEmH?=
 =?us-ascii?Q?9Onz6sscZAG2HX0rdz49kdx9MYBiqNxbEWmbxaTwge9wdBaIgQSk96pUtDRx?=
 =?us-ascii?Q?U+AD2lhCrgoT1ewTC898ZGPNGVQOGXGDpNvlBH0s7z7Ie3F2PUIHe9rP9CZ7?=
 =?us-ascii?Q?mckKGDam2m3sU6+3TmMuXOq7x7MKwtxBzAi7s1VYPmG5mtxvZe0NC/gNV5LQ?=
 =?us-ascii?Q?TIef50noYMoqQbG3WL1hI7giV+ChBzDQ5FCAOES0r6WVip1+TK1NdGMuLRbZ?=
 =?us-ascii?Q?wd8MgrunhsBKVoTsvXWtZUL+uB6pRm4WEu6DMKRs2rUOPlzINS/7pVInbv8B?=
 =?us-ascii?Q?9P9cinTt1Ew6fMKN0DFg5DcdsnIfoHT2OW6Gz2r4MDdrOBZ2zkeN1F8y8OWM?=
 =?us-ascii?Q?H2dkPHxDKxZn7undQp/2nf0SPnB+BZ+i1tVj50hlb0w+WRff4r2Plz8vK8KU?=
 =?us-ascii?Q?5bkO83JROgQXmjfiqYvTwFlFnxVJSZDox/mO/A1+a3oiT1O6+Yrq8Mnq84s2?=
 =?us-ascii?Q?soi+vu+Fnjb2lMJhClJbCqQgD5y9Li5rhtcA8E6Sdrz8Aer3111W6tgh0xKY?=
 =?us-ascii?Q?EFI0nXmtIQmuzBOCw3eMPVlgAqjUEceJMurjNC7TBuP213EniZqfC2hijlul?=
 =?us-ascii?Q?a8ymNoHXRQcw9Rp84M2Wzq6nsUzvYf8z+48B9+KpjSqIAyfgmL/V77prt1iP?=
 =?us-ascii?Q?HXhh3sRYMxPtreelKN5cK6RvN+Pj8y/9SsdtzqCswLKTRArl2KODkF5n3+aM?=
 =?us-ascii?Q?TDZOgFE7V26DGKaxYiSOqk1ncyOfd45m3Zk4QLEe92iiX4QUiRfDPr6r6EoZ?=
 =?us-ascii?Q?gMAR5MfEHCW3L5KbgrNk8ooepfLhRpeo2PNt4BPdrCj47dDg/g1j5jj5KzJr?=
 =?us-ascii?Q?ToqAj47wUoIjekeJ+6DKo2MdVibP2lbA6ng63XhB8qjpvShxeLGdZOTL7sK0?=
 =?us-ascii?Q?MgfWueLpBe7XJPFwfH82dTDKo2w83VYugu+EPgpgCiEr/1bJZGvtVgHCX3n5?=
 =?us-ascii?Q?jLnd60yjc/DeXPmDr/ZjhpMeaImqrzvUWQ+Q8ea9tsiZFzH7KpoF99wyGKak?=
 =?us-ascii?Q?E6Q91IpZss2GWjGRdRh5UwtgyWbqaPD35d//pIit6ORCuuED5Kjvn21MLbgO?=
 =?us-ascii?Q?5dTmksGg4txRbEI8umN6P1gSEghtdC7geogjJWb4DJpHDaxuKKyFps7Ziq43?=
 =?us-ascii?Q?uAMy5rmvU6ypK2FGenjaFKf18bAoeWJzMGI/P5Zu39hKRyZ6qieoJhuj878v?=
 =?us-ascii?Q?Ydj+rI8zrK52XI9FV/dRCcgJ7FvT3SR0mRUBeCFBHwAFWEdd5fpC+gIFKCLT?=
 =?us-ascii?Q?58yuHqS05YVsBY5ZM5MY+RxehKzaEIOPRQeuachBH/HumRQrvmY0cdfCp+a7?=
 =?us-ascii?Q?zhUvXNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7oah+vxL7ZDcvWDmaIqa0aFHXOmF/4cC0IgpXD0JGMeZpukelXqVeNFUTWIs?=
 =?us-ascii?Q?SjFdwWwRFRXIZzCWYjverIF+MCYt1nrA/LKof/Duu/Ct3iWrb5VI11SqyyYo?=
 =?us-ascii?Q?AnT8gbMKZxLcRgViBNHzGJ8DQAVXTycFIaPJDfwIyYXBV5BCkfy6rOOIhx+A?=
 =?us-ascii?Q?jk9gt5yg5d3apeR1Q/eHvXT6JiExVk67M49XgzFaJt6xl7YX8wGjKXgFJaNa?=
 =?us-ascii?Q?Qx3mdMp5GMHwnlVbWHFEEaMyvA3aEjfVJrP9xwg5ww4n5bRYUazNZ+f9Uvs2?=
 =?us-ascii?Q?4gmb9xionAFRg/OCkA0d9f7crc94lGHF55NZi9TL/LBIPwr6g8hdC4dykFdd?=
 =?us-ascii?Q?09Ewj4tjZVusjM/xkFUkdTEJ8rPLiQBQBsaG0ee50oZMCaFiZApfF57GfzXx?=
 =?us-ascii?Q?471MYOR9axmesJVqu2W0/OjReHmO/kUYByLH/4QKANbYFZ/qhbgbU/rqgnJN?=
 =?us-ascii?Q?mYVTZ2oCzpwU0BHDcw3mkg+b+I8rGIS97nLnvo1IvNwfdphYZ5RB+1iX/6Fd?=
 =?us-ascii?Q?jo1n9tH5V28KMOtVaPKFqew7f0zPYCMtlaI6ySXopbfdXCpPpWsBO3z19aRN?=
 =?us-ascii?Q?kwzEjr9GRfbQlLFRaSzKOBCbMY6BqAN/pkFiFYT0Tnxq6t8Ifa/1xoLhSDdF?=
 =?us-ascii?Q?HgYYbXLxxlMuBrGqWcBSw2g0ZB7dpmHfW7igtkLlhdIzWSe0OaL39JQbvtQs?=
 =?us-ascii?Q?GVhLXiU3LInahprEF2q/ddLaxJO59j+PhbZsOgGvDtKjvay+6WVMtsKod8ZU?=
 =?us-ascii?Q?TwAy6M2wQG0VRrYIzxr7EVCthpBbjpcpCaxVozNnjgmCJFGZ6AjcFjarJDvZ?=
 =?us-ascii?Q?dL3FMBLU5nKfxz93Y3GccHhIbmFn3k/IWKYu4l1zxzxTlRTQ0yFJl08/aMTL?=
 =?us-ascii?Q?4BQ+7CNKARCBCnUWJpy6muF9oPlPnSouwgxrDVfIP87ZZ6IPujJvaYAZjb2+?=
 =?us-ascii?Q?YGywzKb1G//WYp+uX5Z7VOb5vb1y058CEqh1WZ16zwl3Yf8ghO3BQjLZiO3L?=
 =?us-ascii?Q?cPIRAhc61vD6yE9Hcj4zHDqlJKT/PTREMYcpNIUb6jYvkqcr3wtHQ94Ujhg7?=
 =?us-ascii?Q?eKs/9PxiAn1faB+AVo5G62pvDqPHf0GgZduYIkbS14idgCigYRhQtvPFrY30?=
 =?us-ascii?Q?34Rapo1kdQ+Nontka4ogRInVdfsDJV0PvhBPeKiJKNOHhELFyaDi5iUK6ERO?=
 =?us-ascii?Q?THFofm+OM/7TB5AkTpNQUVYeX+FvQXSi7zQHSSqZpHn9zA0kIVWdR4NfIODd?=
 =?us-ascii?Q?xwIlKbN8b2WUoK8mt6ghnRV8xKbKGhzqDvnoHLw1Y6hOI8NpUvcL59ZwOlim?=
 =?us-ascii?Q?LlaaFqwqPokipj3F7iNU8+MLNHvlCPYcqH2TB48dC1QlY1vSeFMq6oQgEury?=
 =?us-ascii?Q?qOzAzNjrjROq9LnrhZPmQkt+tJCH6MCdpQmkRCMCtN6t1Ms9HQHtNfu0xyZ7?=
 =?us-ascii?Q?tvg8Gb7tzhILx7fez7z80amLMOHM1MSmdYOa9kq3kITJHVAMSs/flsqKRN4m?=
 =?us-ascii?Q?y1t2IYvHS3bvBqzKlfd4Qo3rvnav+1dJ4b7HO0ndGH2YDyrE2R/KVw/sMwZ7?=
 =?us-ascii?Q?NVfDbPz7Ir4w9txIiw5jgJLUOT0tCDiRioqfKr0i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be3eab0-6368-441f-8947-08dc8630ac04
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:57:58.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAxuGY8HOQMbbG5ChHEsBXRy1u2TKnSyBS94mEjtYJZ+ZyWkOx98/LPnWqU1Db7sYNOvr92mj2Nw50j2ajexww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6317

Configuration for sbq:
  depth=64, wake_batch=6, shift=6, map_nr=1

1. There are 64 requests in progress:
  map->word = 0xFFFFFFFFFFFFFFFF
2. After all the 64 requests complete, and no more requests come:
  map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
3. Now two tasks try to allocate requests:
  T1:                                       T2:
  __blk_mq_get_tag                          .
  __sbitmap_queue_get                       .
  sbitmap_get                               .
  sbitmap_find_bit                          .
  sbitmap_find_bit_in_word                  .
  __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
  sbitmap_deferred_clear                    __sbitmap_queue_get
  /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
    if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
      return false;                         __sbitmap_get_word -> nr=-1
    mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
    atomic_long_andnot()                    /* map->cleared=0 */
                                              if (!(map->cleared))
                                                return false;
                                     /*
                                      * map->cleared is cleared by T1
                                      * T2 fail to acquire the tag
                                      */

4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
up due to the wake_batch being set at 6. If no more requests come, T1
will wait here indefinitely.

This patch achieves two purposes:
First:
Check on ->cleared and update on both ->cleared and ->word need to be
done atomically, and using spinlock could be the simplest solution.
So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
may cause potential race.

Second:
Add extra check in sbitmap_deferred_clear(), to identify whether
map->cleared is cleared by another task after failing to get a tag.

Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
Signed-off-by: Yang Yang <yang.yang@vivo.com>

---
Changes from v2:
  - Modify commit message by suggestion
  - Add extra check in sbitmap_deferred_clear() by suggestion
Changes from v1:
  - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
---
 include/linux/sbitmap.h |  5 +++++
 lib/sbitmap.c           | 28 +++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..ec0b0e73c906 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -36,6 +36,11 @@ struct sbitmap_word {
 	 * @cleared: word holding cleared bits
 	 */
 	unsigned long cleared ____cacheline_aligned_in_smp;
+
+	/**
+	 * @swap_lock: Held while swapping word <-> cleared
+	 */
+	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..06b837311e03 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -60,12 +60,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 /*
  * See if we have deferred clears that we can batch move
  */
-static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
+static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
+		unsigned int depth)
 {
 	unsigned long mask;
+	unsigned long flags;
+	bool ret;
 
-	if (!READ_ONCE(map->cleared))
-		return false;
+	spin_lock_irqsave(&map->swap_lock, flags);
+
+	if (!map->cleared) {
+		ret = find_first_zero_bit(&map->word, depth) >= depth ? false : true;
+		goto out_unlock;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -77,7 +84,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 	 */
 	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
 	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
-	return true;
+	ret = true;
+out_unlock:
+	spin_unlock_irqrestore(&map->swap_lock, flags);
+	return ret;
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -85,6 +95,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	int i;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +127,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < sb->map_nr; i++)
+		spin_lock_init(&sb->map[i].swap_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -126,7 +140,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(&sb->map[i]);
+		sbitmap_deferred_clear(&sb->map[i], depth);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -179,7 +193,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 					alloc_hint, wrap);
 		if (nr != -1)
 			break;
-		if (!sbitmap_deferred_clear(map))
+		if (!sbitmap_deferred_clear(map, depth))
 			break;
 	} while (1);
 
@@ -496,7 +510,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		unsigned int map_depth = __map_depth(sb, index);
 		unsigned long val;
 
-		sbitmap_deferred_clear(map);
+		sbitmap_deferred_clear(map, map_depth);
 		val = READ_ONCE(map->word);
 		if (val == (1UL << (map_depth - 1)) - 1)
 			goto next;
-- 
2.34.1

