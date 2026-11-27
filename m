Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820514;
	b=4+ySV+pYth/6CQKYSwIyKlt9lQ504/b5Oz3gOg9KMFVTORhSNDuFKbXLOjdnkG5ZD7YT
	 Zf+1SM+jdCdcAM/GyA6j+GJ38Ye8gpwvrowaFcaPQsL3G2yde5z2mNL6HkwNGnKZfHA1B
	 b9pAd01dNTlfNSTlX/OrvMgopeCd5fGeKJ3SpPI/B9YovFjm7VplalsQID8STAOalz4EN
	 aqGoCww3vaeFHKj7BTEkygn89mQhgTHb1ws4bu/e2doAf/Si/+SorTyLSo1O3wDgAKWCm
	 Vl7b4vUn6dpxtMisyZxlXCcdf1O5IgSdnKorvrdTRJrycaieI5uL4lEJ2jE/sxJ268Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820514;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5LdIclwL+xLdb9Xm2DjTbHZfjZsM7rhR8+SV2mixmrU=;
	b=LZFfFtA26Q6kOYliLx1s6QU8pFLbeeLgGzwsLax0OoVW8f6eM5aeKctE0daQ5m9E9CDi
	 D5MmdNbH/Xdk7BaD32qQECg7j0WxofXxJPtSSd4lRDzxrpnJjW0jxfxPD2xugbdNU5n0i
	 CheJQYll8DanqNfZup9YyzbrfIvhRR13VTNc30cVxnpXcHZQmWa0c6+19ZxXzMGxCiV2w
	 BG4omzyPGB9lDNj8TYCOT0KvcoT2/G3ZHW91kQ+4MRtwEe+cHTwZ2VRGrTYpF+rZSBvKY
	 FMiYRj9ay9RSuB5rYwWodvN4Aq1zyfqEOmNwQivHYtmxuTncm/lUexJ5WrJsUSa794A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hj0dEVtF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A4606A31C;
	Fri, 27 Nov 2026 23:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E92A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hj0dEVtF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiIcy8txKfWUujE96eQ6dqqmy4aE1hDxo6H3qWPo31YF5+NZ8vE4uY2pVbnVWVQbrJPxtyuD+hNXVGxxtwGKAa+35CmLdk0T8AJXmjgg2VM/ZfqoH7PMqzDH/qJJj4b8QX2p7buusdlx6YNWZEg8gliZHsKwo7gsDgR22P8FAXOKjwnG8pEEdkp5OFkBxAJB5sJzfY4iGJDQlyRNUoPva10diX9mOYUxHktbVK+C026LHOqsjEI9VXRA0KdBhLWBD4uNvOJsgdMJFI3+qGH7tBgX8CgE8KItbpHdy7c+q8NzkatmYogL57q5ArIi3x3aFRKrHuM2gC+kCw6x0Fcqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LdIclwL+xLdb9Xm2DjTbHZfjZsM7rhR8+SV2mixmrU=;
 b=O6j8pWY1bkFDzdHCJowZvELMxpSaSFJdNiyxWN0yDRHBba6IvvQTUlIkYxfYSgnPtbZ7fuL+9lhRYM54G2HGSl1oKqhKw6FhNyNo9JyYYiRv+GiLRqHylxFvT2WuUpVQqIhW5uChzsIUnRktAU4gKHhif/9TbfkPx4YRlEge3S6n1hGYGpc2ECDL7Gbg66MTOZhbqQTDkzvBqG6aoIq8W26Nho81LESd6joEKlEcKz0v2SOAA1+Mw1qMI1muwsVU1a9zUnxYzV3Q0efmXfKgKczAeW7KynH0My4ZyyuoQ7cpZCA0owpENnfJ7Nb4/DYGOWj4lzwEngNhK6N1iaTZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LdIclwL+xLdb9Xm2DjTbHZfjZsM7rhR8+SV2mixmrU=;
 b=Hj0dEVtFNzD4492YR5xQsssfdb6mw/ou+ypmsIne1PijjZCCts1foti3qNtRBNSBdqvcq1eNSr7q+caJWlno8ijZ6E7xjWrPw4w8KccwNIJBmxgBiyPGYmGFKpdZrqm42hCWOUsGmYCdyXHLUysMm9zpDrslVTWLxzBtlAzkqF0btfnF6R8iyAjVWZxswf5aLZgINTsqpCfS9p5pDZbdARxS/wXS2RAkpRGjdTjfwBmLVu1A5xjOntO/GkipxWe/jeDPmYAFY+vvwGzri74zyq1FwsCkZ8vOmjHNs7JNewIz7IYZ+QpQRNmqAcXSTitppFrUxFpWM9ST0EmAuz5f7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:49 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:49 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mips@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 08/11] mtip32xx: switch next_online_node() to runtime nodemask length
Date: Fri, 27 Nov 2026 18:01:25 -0500
Message-ID: <20261127230128.111933-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0295.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::30) To SN6PR12MB2814.namprd12.prod.outlook.com
 (2603:10b6:805:72::33)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cfd8ba-4f86-4232-98a1-08df4cda6ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	WBaaKObIIjnHpbix3rre1aZEKkRpm82vs791DiYpjhKny2zIAUt6VPtYXYNr2qgHaEBxIMXhuflCoUCsa0iK+6aReyK9ko93Rf5dKi8rxhEAov2KfHyfTNy2zKqM60GAlIekKYup+2Y+YGUBQeEsLc9xI5uZKXVAcAIltonkTnaM5tVjJ1M3VRN/7Acdwhbl7+cY0JO6SWShOsqS0YwxaA6fCqOqNGYnkJt7/t6vtXEXoLeO9EjT+YZBStaB/rGjLaTR0wV6DyZarXeSv3m/hXluQfJyTcuLlcpbOtRJFlxp7XR1Kdq2QQBZQa7tcanlGfSJtu6d76QFci880bKwuoMFDWpwtgcHjfIT5uRNWnSIXAgTpgs6I7v/ePP7TCBkv5//kV7rQt4XC8+iydp8QX96n7f1PSlqqlDeG77ShvDVFkTlmUJW1QM0JbMn06N6a5Gygt/NDXYDOEMf/KeC1M6eC/o4w2HsRrXMJM/Vyree2CsMSlrfHu1hced8vQ1/dxElQ9SkZglG4U9VbHHzr0Ot+V6WeN3S2e7Nh5LEUQOg8NIrxX+Egwi2aVXwTbPGtn3jbByL+yxJcBmpvCtba0gJTi4vcIIZon5BpOwJTJMdWG7G4dngInfqz8Wugl2CcAvOwcdEXP9gaPP0jRGRaeOW+bTZ1vIkPoKZ6dMHSWFUg37g4X/Edw5Vl3qJYfHpztAnDNdAOkM15J4Y8+hPgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBPrSzxPykbd1Hr3ekzw+SwZhkuQ+1l9kM4EbhIp21SNwY6LJOfw+PCjxWim?=
 =?us-ascii?Q?Iqy4V4YijeieOaNnljbvp+Cw1l4uSK4hRNa4KmhSUdjP07nUuWPwI1hRRul2?=
 =?us-ascii?Q?3B+oF3xwfNmpYvRngi7pEKAdanfSv6PRpikqNLcaBoFWfRocM5736YYeqjB5?=
 =?us-ascii?Q?NKo1ZY6gLIezj4JLA9zwrRie5aCJua8mRGaU58F4DROKXavKuvHh0Uah7081?=
 =?us-ascii?Q?4uO6zyWRMmSWpkHcRvy7zxafETkKyWWfMkNLOCNnniUXBJ/auwFqI7M0eCBi?=
 =?us-ascii?Q?iZFlKZaEwcnOQ31hupYj8vdB6ZuKF7fihODeqLjrvS0U32m6wbvy4ma1af2T?=
 =?us-ascii?Q?YUWCzP9r0EDh6Pj1cuQZlrisfbwzVksfAIVqz7CmpAvgaSFfRxq6nJToJEUG?=
 =?us-ascii?Q?rH44BYxJTiFnR/a3PpO2VfvG2HgBPJdA8wxqxOtPpx7UE4PngFeCcdXcjMAM?=
 =?us-ascii?Q?C5eKXPhb4rClHmQGGhmcYYn369eV/sM8/VVfBEH+NmedrzKQWpDqrFdfDv/F?=
 =?us-ascii?Q?MM1JKT3brFb7ujDCkF8pQ2X3drl5mfXG9PFb9V3haJxa9G82438D1avHq3/0?=
 =?us-ascii?Q?PKN16NnzS5k1JRn/zXiuUyhvyAet614T3xfI0Ik3h5iyY5xXAjMwkfrRh87b?=
 =?us-ascii?Q?OHoamGvfoGtstoeuQoQPCy1badVkO36/AC9pjpzFPv4ms4kkZaovQBFu0xla?=
 =?us-ascii?Q?FB/xdfhgL96rNQ1tbcJuDB6/QPz/wHJglAwawptYEbfItVAG4rBfSUKl+9I5?=
 =?us-ascii?Q?Djam88KLtQcdUaICMRIvDJkCTPM09M8qkPs09J8K6NTADw0kXtP7YywPh7ge?=
 =?us-ascii?Q?M30bCgZb6gv1NTrF+GoVE7rPw1QAmzvqxlLCbgE2hKpNLXp2mv7sif5bmwsB?=
 =?us-ascii?Q?QTsgzxhoNdq1iEIJSghFgA+qg0hTvY17/V8TlOyE/p4letBpvxfqwpwYiw/g?=
 =?us-ascii?Q?nSN3bx0O7Su0dauQEwLW8BFY4n9MqiZjZ+vDvqKMJSNIArtbDQf9pNToPYkW?=
 =?us-ascii?Q?Voo2+cVZi8UJIk2nynXj20p8AEFXBYym9RG+XJCvXTzs+3cB9doqRumSIvCo?=
 =?us-ascii?Q?SwA+RvR4gvzZjHv3bXanoesyvsa19cqxQ69Bt+V3KJdZiAj37M1kNyIEk45y?=
 =?us-ascii?Q?1VsB/4IR8QptSHdkaNd2saDc6x26iVjGkCpvcIoZsQNrKDCy2rkDCSMk/rTP?=
 =?us-ascii?Q?jl97lJ8fu/xvItJF+C/7GaO2Y0wrpWO7BAh0FmHvY8a64+qHGBSUTXmPaGLb?=
 =?us-ascii?Q?+lfQ3SILEELswk/qALjaiLlfJ2g2gc4OW3KdKEByXYVjNvbP3NottmB6xZ5z?=
 =?us-ascii?Q?DoW2FQcZYFZjOT6Fyh0emQDJEoxV+SOZXJ+KuVHnpV6dmxdqAYrKj5pw4VJN?=
 =?us-ascii?Q?1MZZWdW+PPgdVPZHA6ZdbKrgH8D4QR1nansyYIVXqwLfWbYUYXi9iyYelUP8?=
 =?us-ascii?Q?7zmSyg7QGebfK4BbDvrsDmvUkAOG+td/B5+1h1QriOoKuT8c02bIbK8cx+CJ?=
 =?us-ascii?Q?RTz9xo/yVWfV8t3WlCbM4QVOF/Ev+7mC1JLw8Pf6rNA1RF7i+uwEb8b0vCCm?=
 =?us-ascii?Q?lVAkip8MiD0dfZZEpfBZYLcht6eMA40yzhq+TDaLUP9z9zqRHyFEYBkrPTSQ?=
 =?us-ascii?Q?VzbAN0iJ78nYfkgXCHz1l4tMTZP00dCs0irk/suWRmGuu1LhBn6DNdcrEhvR?=
 =?us-ascii?Q?hg1pclbbWcBRrgx70SE/rAa4C/sP0LCkZJ2CIhcit1hx0S/F9aBo/96rs4U0?=
 =?us-ascii?Q?fYKAKjLonktxQoB0HFqD9j4PI+1Faqgp5AHuMuel1p77hJz+XVWR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cfd8ba-4f86-4232-98a1-08df4cda6ac6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:49.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y85Iaz7QgIWM/FAw51ooaRgvncSiGtTBQE24pbKR1GpiGKpgJEpPDdFm2Gi+S33vFPHmYbhNVvxYKTEDyJZ3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

In preparation for switching nodemask API to runtime nr_node_ids,
update the boundary checking condition.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 113bdb868c46..8b8b4211e41a 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3630,7 +3630,7 @@ static inline int mtip_get_next_rr_node(void)
 	}
 
 	next_node = next_online_node(next_node);
-	if (next_node == MAX_NUMNODES)
+	if (next_node >= nr_node_ids)
 		next_node = first_online_node;
 	return next_node;
 }
-- 
2.53.0

