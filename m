Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820510;
	b=p4b7rMEVcVUs6dkvanLFxUJ8nF0SpFJ5jaoJEFQ5quMDpxXqH1FzGBgfjMFLGelawwcq
	 W/VAmEM8qYKDJtOvCAPqIOGpbELMvVvL7Ayu5e5HYvgDvKdUxB+IQqAr7STBhy4bVR0J4
	 ZmO4plrE5gScEKkU7Ej6LH8yOnirl/QI8PBzjK6O6xAauDLWBD0Ia/JrNQ2/YBcT9IOS5
	 /5VZFPF0eC4iubYUEfHoz2tFqFDahBf0Nc6pu0bHSmQgc1u7w4GqUBuH2e7vcG9giSxHL
	 HnuFZ09O2RxF0F6hgjPpWtOXYCgDGxeNazefpwH3bODSwXT1nOHGYFeNtR9SFZQ4K+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820510;
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
	bh=A9jjHGoZpN8SfMXzLgY+jF4xm0VYSsUKUAYryZpul+o=;
	b=Cl+ke/MJuIAdygQAjH0ibSq90TB9Tn65Z6ilHyD/7nUGgigkSzPKAajZZzTaQcEsymHO
	 HECPtMtRZWRWDPdsT+7xLZ8HEijZJp4IbhTUIHgRZXoXDPIhthbZDoSBbGVOP1s8Tbs7J
	 N2tZsf8lMdIOI1y8Q1HpfKhkEtciYnHOJ+6zti/hz/qNNgAJ6McQyy18iz0arvW8ZrRg5
	 I4kJ9JlTlb2GepLXa39wpHDIRAdcSKSNLVVKNHFCFi3E1KQib3B9BD89BVYD0uWLfVb1J
	 vDduMF1Z/nam/2iZzuAgKOUSqqflxOwX8bTk3Xzh0FvcXsY94wSJfx5lo9OPccRHRfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LfxMFhnF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.48
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1660A2616;
	Fri, 27 Nov 2026 23:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A1660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LfxMFhnF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq1ZXOIWkTfuFeVTqt2eyRnHzhASARC8PvJDODFSV2bW9gjEo+zToR8HTdw3Xw7Azg1SaDISFuJsUoGGcBcYstYXz4I2jr1EPQ7hVoZTBrhpTbnDrivYhj1Ic2ISqNxKjzab4eWZYvxp5jwyHu+IUR6C517CCMXIIUIadXsqB3Hox6v4SLtu610NVj0hlS4YUtqpZs3rdJdcBq9XlGaul1EngUa8VacVBiR6BBVRBiWBtDmIXN1KgsWEcXY0oKHPUeYvxzGaR+ylWxeGJDMZogMr/I8Bmz1Fpw1a995ypEEdcsIP1ys3dPQ7APxarIYJ4xIrKR++KycSbqG6rGg/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9jjHGoZpN8SfMXzLgY+jF4xm0VYSsUKUAYryZpul+o=;
 b=T9pVCUsT8MCQ7xr8H1jQxi9XsiSXA5dfOhK3ZUXVLFQw9QuXpz4/qsmYu1dk+0ynn0QHxkCXRfiisSy/p+3xbmaD9rECN8zlCYGp62J3bZC3YpPayD8lgKLLvMMZz4NPdm5u0B7xxH5Axlo38ZE6MUK5B6AqL3XybMxBwO/10FDRGGboUb8o8PJ3w81RWCz6XdlWIBG97hW6RgnEpDwIlppX6b1wiU1xIM32SZ8Qvw+NY+P/hX3JYlj4AhC2RvtDNkoqrbB2pfY/Qfjhw6y1rglXdkj/Ak8167fQ42kMQngK1UUACEDOY0JUUFCX6+NTvyE0NSXm2kmJHW8WE/bFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9jjHGoZpN8SfMXzLgY+jF4xm0VYSsUKUAYryZpul+o=;
 b=LfxMFhnFCpacABBqPT9K87vr0xnTeqy2EPnXfgG98mWK63F0QQkgvpXs6thbLHA16yr4ujQ0KU+wjhjFU2L/eDpQ9JjEiG+Ye8lVx2KUEPIXcEuJ/jvHV4Vm1db41pLrmzdGNZd6T6BPRIgcVvF+gUGauLFkXmCst0REl3FgG2v22trsozKOGBrdV5SwXfCJEnl1Yb4ipvBtbkJguexACz/wExdieRndlhRmuuLryYpUeMeoDXWqOgU6EEQa47XTYCcxQHnwOGmFSYXRIXAHqQ+ojzk1avN2ta6UlIHIjLFNJ8TdCNjdPz3MiSn42SOWJjouZmaQRJYnwOxWCmfdZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:46 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:46 +0000
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
Subject: [PATCH 07/11] ACPI: NUMA: switch acpi_map_pxm_to_node to runtime nodemask length
Date: Fri, 27 Nov 2026 18:01:24 -0500
Message-ID: <20261127230128.111933-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::8) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 95fbe7dc-215b-424d-385d-08df4cda6986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Tl6cmFyUKeKD37WsmitVnPpCzkpQj7TmkYqVYlPXOduMv3JdNERDVzCEspS3qCP86/BI0xXhdGwLs/XrksnxJytgKmZUCZ+7xVE5nbKJoLLbSxecV11LnWOj79NYNfLn1Oql9WDEiXjNul1/EhiDYUXEmjEMcUW/hoHU6XK8iGYhSdYGyj7FzpGt4XN9qGsNOn1Nt+1NQVxZvC/OEyb1rdiz6wW+R+jYhKS9O4TC5T28P1t1VppE8Z0X08TIOVGrYDuN8U2G4F1kBZQavTgfTGN+b5PzEChxEz9xrb2061J55MXIh3rhlaaeOVOHyU7aQR9zlHrVhHImDKtVFlMI6FelHohTlDWcFsmurXyGndbT5RCFreRjcEsGCy2UGmJEJoedJ2zEdrbFTIyg38bwe2N5bQrPbfZqvKtQLCFMla8gyMpk7ZIyaNdWjWxONgnE/6s6n8t/UUGaESIb2mQnL9jhHsXfZV76i11rv+qkQSiH9M76SxJohhuWC1JzZ0OLyhVcnguBBZA3UiO8m+gEzM+sMrTYymAF06jtwVJgki2TIecKPkgrU0fFAfUrWe758aC/j5TYpMKMT05av5nwJW8mrBC6hhnKVUxEVgEzOtn+kYoebO9/4ZRhNSqNITyfni5au5okGWBOrstL7Q7TwEEWN6FMagcmfRpZqKAOXkT3IfisCqMikR28sU/IGIxsDyloE3hNaz/mFWX4Nzgwpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JowL88Y1vX/6vTxsfvaFBVUQZRYqK5HNE/kyTQj1sNHx1zmUgrvJy/c6O9Dt?=
 =?us-ascii?Q?tS9pZEL3qDIUPS8zu98zvgDG3ILu7SqyCSGv667UZII75VLqg7nKDmu/W0hV?=
 =?us-ascii?Q?g9Z6g2XEMVW6f2HZD/g2BYmWRJhKrXC8in2kZAVLlJ5ZT+eGi4TDkiZmNv6Q?=
 =?us-ascii?Q?8p53Eh9Tyf5FdX4cravQ3C5zYuZkq0m7oBt3cJrDocr9pgg1m4YorQam9QTy?=
 =?us-ascii?Q?MlmCwUwXSuLBWmgAn84iiZPsHX1+flAJG7hmZvaPKtukktKLUnNaB/nvHI4U?=
 =?us-ascii?Q?b6patnA78cxGEyroPh9lw/8dl/HK+fEnI0SswWCP2jBnWJfQxhG//jR7bxr8?=
 =?us-ascii?Q?Va7W3a7uAhGuZzP5uwrWBfYipuTd6btil9yaqFDtOE4dDjqBiDefqZ4f9AeT?=
 =?us-ascii?Q?yThiirmxlbK6BhKFtAvSh0v3vkphrYj8gxxdCV+iLB3Agrcc/SKDFuSUudO/?=
 =?us-ascii?Q?hVxAYNidcw096tkpR8/5ufEaCchaWi7YIYVeAkt81r2R6Y+DEBWk5qbwR+UN?=
 =?us-ascii?Q?Q/F+sCU8tfFvkKCJ7WjrYyLtP/YE2cXGyPYGg7Vp4fmyyeQiH+KBE34WFbNk?=
 =?us-ascii?Q?CsxMbgyf57gUwBURci/haKq6Gk/JewkwBa9Pa0VDL84frEBHDRJ03ICivP/8?=
 =?us-ascii?Q?bCBYLYTXCkXm9d52bbvM5nuvMDfRelARGAfkwnpnFTCW7nM3MthBZx1Gi/FO?=
 =?us-ascii?Q?jyI8R6GSpVPzIp775WqGZDmIdS8swHy4ymDLGcdaXes374uOjzohyefefp3D?=
 =?us-ascii?Q?WRQ6NgsDAegpJKQAqRpVehiouaXTj4rB4wc0c+sPmJyyN+hJrZ4NqxPex104?=
 =?us-ascii?Q?fn26esyovjuZLoIQk0fz82svPQr9mQNgEcdd47i/Xufy0yKrg8Jx1A+rW+Uh?=
 =?us-ascii?Q?PSMaSab0S7SGBQpn/zR9sDKnUQSuUye8vfEhUj97m+2MEqHpTSLLjpsqN1hx?=
 =?us-ascii?Q?7s3P+zcsNtDziuKCqelAaNzSW7L/IOBfFiy5O1rThhiaNjks6If2NrjRx/NX?=
 =?us-ascii?Q?9eP7w0Uq2gv6oB58QXHAFUW2ivQUXtcXgCud9pxQRrJWcAtpA3HzhmgtBmqt?=
 =?us-ascii?Q?nsu7OTueHp4rY0RrysKzqYEMgv53mVBtoGhIu9LeGI3mOb5ZOG8T+nAT0tWN?=
 =?us-ascii?Q?+S7fFcnztV3x8EH0tlmwry74UkpL/22o9nS1eEtixRQ/wK1bCk+2F58hLDJD?=
 =?us-ascii?Q?40SnAcvDUtp//bQqDEwOa3QqNuzyx5R7MlxDbOGWr2EbAQtESKRKvZQmeRxA?=
 =?us-ascii?Q?imCkxlvIpx/82FJB0grYyPy7H1ScOuM3RbBv8PVKX9b/yss/s7CMwfHxr5cH?=
 =?us-ascii?Q?3K0730zfYxSsiF/pRb1qEN951BXOTmGsL4YgHCDPqktKXH/F0tV+CGnJJd/M?=
 =?us-ascii?Q?NDDN+mew7/+J9ur7YCWcIhJLdFnyVsODdcZXINumVLa56RELmTWJMEiTo1eD?=
 =?us-ascii?Q?Ph9rGqbsrjAWwx4NLs+eJtPQUbPstaLyXCzcYIo5QsVZ+uY8aAl5fGBPmJyK?=
 =?us-ascii?Q?uFrVU0Wa2WfhBUNf/j2thhoPNXlTQUpfiXcxXw6hligGbUHsG/w4025B8vn/?=
 =?us-ascii?Q?Xt5Kel7Ph1LUAYB4mlROCD0Pzkrb/lyMwmbmwLHEt/+fDlDaKLSo5u/IXKZM?=
 =?us-ascii?Q?IJvMyKlRmiRA7PHDo6iBD5jNPLtp1WspyxwxYZyPNe3Ia+P7jip41ExIQCDq?=
 =?us-ascii?Q?UuyAwUZDmzGmg0Qayp301zMA/2g5quZMg5Dc1yruBcSNrU9JMHaEWBM1LewR?=
 =?us-ascii?Q?MYVcqCzc4/LgqhPHAq/nXvNu9N5K+OfPR8K7Rw/M6pWJkZwKksNB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fbe7dc-215b-424d-385d-08df4cda6986
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:46.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60v9vWEvm1SsL5kGWq+9arwEc3fAwzFWix5ouMMPMHqhY8GVrHDfD7JtWCMajD6uZqUEdn8Gsa5dMK2WDd26dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

In preparation for switching nodemask API to runtime nr_node_ids,
update the boundary checking condition.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index f5616830f5a9..d7acb2e973a3 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -74,7 +74,7 @@ int acpi_map_pxm_to_node(int pxm)
 
 	if (node == NUMA_NO_NODE) {
 		node = first_unset_node(nodes_found_map);
-		if (node >= MAX_NUMNODES)
+		if (node >= nr_node_ids)
 			return NUMA_NO_NODE;
 		__acpi_map_pxm_to_node(pxm, node);
 		node_set(node, nodes_found_map);
-- 
2.53.0

