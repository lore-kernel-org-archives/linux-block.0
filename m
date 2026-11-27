Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820521;
	b=cUGldo12Mwyt8SBIBAIvr5gagtzXSiFDyD5P2wmSf0u71bHj1FkOFZqpL8M82kMyDtMs
	 eiXDDryP8Zp3QPy/CgU4F8ftaJhNv3E3mdytaLxalUKPj19ht1/RIcOXCUneCkCmKk1Nf
	 pqBIoxO+EohC2fBfzJRTF4mHKNFNaLB9+T2eaQySQywsIoPjLyYlpitRpnRq8i1fVlORc
	 6Sya4LMP0VlFUs+1PRcvb315Gr0VcYgxdJvEJ32K//eksWEwYd+L7Kbb7h1Cd1M9zcjg7
	 AJvw0V47OVrqreH4GehS3yt3ZI/mu5k3dOXUvLOnI8bKaHIplF1WdVjIwbva/K7wCXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820521;
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
	bh=XsH1WKtrnwQZjeA+vFe7DopHLw0EI5pezzqohdo1lck=;
	b=p/UhdzkIY0UkrKA3eE3pWNyQULAw1I9GBrsF7/VRpIrPmcgAXIv1QuwjAl1bT6JfJJok
	 YzuEk1wSe/M3mgEXT2YZkNeE9sBuy74gNCqUDLO0KcfF41QoYeKxQlLcGUCIGcBJGbtET
	 6gdRy7ORo2yriKsqQ8BCJZDS8sxyMqjf6NR/QX8GEQj6mxEWdBxb8gYs9Q0IwHknPYYBF
	 eqNUmeC66EzuWAYvq5S5Kxz1/RX95NlL5HlXRVuhHBJCrZ/R/cmj4happbMBMy5U2aZkc
	 Xel17eAPBikVpb3QzP7924V2wHJIOKsdHMblaU7+mIPeIPusVvNl8yzhqKTDXKrzgLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=foI8rJbi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1960A381E;
	Fri, 27 Nov 2026 23:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B1960A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=foI8rJbi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxMYXKpWkQFvYIEOaGp/oV6dvQ8SCW/UqtTtHQrHjesF5eiPtAxYrrZVmEKjye+lHuC4Z2OcMwOZ4jsp+ty+zCcNDesl+ovvWimiE/PA8txBcg5qTnQ42DXn8rOE6U+qaoamDncpy6zAaW58OrJ/le6R9yK7AA8SNomF/UbA060D3P53trTzQj5lQ6IGz2fTlf1HVQWIq6AN8fkB4HIVMDiURuOCoHzxIcbGLHMsCWhrODCdYnhlsC2i83c/nzt8o73WYhcGy9t4dh/c7xmxez5haRlm6i63E9kDJ81WXqhLUctvaDVwnN5M+u0QAV+QAkB04tMmYV5YvFbSVXImxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsH1WKtrnwQZjeA+vFe7DopHLw0EI5pezzqohdo1lck=;
 b=SMWMQYPVqxpl9XnEMEFIFXH52ANOPfB65XZoBJ68d+ByO4UAvL0OSYnj8t/FP4As6qBGxNRe80klYxYiHjOUyrOAYWicumaYBuyUQmUZVLbzmzyqBcA1rQOT2azaXf9oPHLStmgZ0BgLtB+o6AkTPYxWWVEsGChdu3mQjv50e/LBnnrTBSkhtOT/1iVW0fyEJCA4lpnI+McfZCUyyOiKB3z2R4wmRuOpQWNbiCZSd+ay1a+tAckVQTmaVqv9r7iRp7EaCKrcRTLGTbmp+GN1A/v8krNqU8GZQTn7caRZw9m4tJMPHU3g8yk1sE4pRI9s/wxH9gp+G0dPHCLqmcnV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsH1WKtrnwQZjeA+vFe7DopHLw0EI5pezzqohdo1lck=;
 b=foI8rJbipfTxjhOsX0P+HYJ5zyb7Zzg+eVRGPLb/te1ZxF08uJ87d4YX+Bx0tBKTb96XjTK6Bsq7hVYPednqiudgmUdvanmYnmQh0VAg0Sqf9A1B73f3Y7OCXH3Q7FjAs0szjANLWuNxWA/LQi/5o8lFh4+GUP3yryI3hGl8kJC8oGKbvj3FjHQJYqF7Irp+FrwrPIPAs8nBgssVJXS3gZZo94Q2HqtjK0MTHtU+hUMWrSYLR9kbv5PTz6FUNzKS42SjvvXhtk2qZGbC7kt1oXbZn4YpvM+1AxxZYUINabGp+Mt7WUxPY+CqvPu3fXx1F20Itts6dwm/hCmzLegrXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:54 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:54 +0000
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
Subject: [PATCH 11/11] nodemask: add cpumask-style operation size bounds
Date: Fri, 27 Nov 2026 18:01:28 -0500
Message-ID: <20261127230128.111933-12-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0698.namprd03.prod.outlook.com
 (2603:10b6:408:ef::13) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3f5f7e50-0df7-4416-6d2c-08df4cda6e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	yrdn2LVXZ7jitEY/hB+EFcnScIs8CbW4nrqsXmFuoTzglBvnsRbWiZVt2HpmwDqaptK+Dj4e6ijqEW03xCa/6vgIWKC/93MBF6t56kqoJTDWoEOCFZIhNNdydSgrCNCOkFQtIWVZW4kbglMRDPtM2HlCAPlLxBB28NUIJiYk+jFpE12MVA5QhVKituU7jPsD2VlxMF4aJ77WSNMMLisEO0NkUYVeWAGOUTmVqryi/2nVyDVghuFgbJG0vus1SvphIpIoUB9Ji8qfRgWEU/nDySQE3nEK64EgPpEfisMJ4tGHazC3iobNU7R5TC6tUDa+MgqgooMIdInxqOHr8WvH8qvgwh6kOHNpvI1R7934L1keH04goxc93YRdF37GAlbKqk1lht4/UsDF9Oti2Nlh1cm0Z7OS3KAP2bAL6MmCvS7jrrnM22QYinwQ3Edn3qBBTAkjNfUUoji7nK8PVnESsKrQ8154BZ/aEYwjST6cbWIypSO1uboNjpt+yRmwaIFHonuVCbbM/eQxtQEUYv0GtNGDd8mQbPNhcPFtRRcmqT2Si2Be345jQA0xlVLqGltBrTCk//L+Tc8m+3DdK4l29KnvS2oGugE+FCy+/gEzmizkJy4BhZiuDPIclsbKv1vRxidBrd9ICqThj3j7QLEktOniVSGpbHVDErxoOATnmx3PSt6jWxKdBpjTWGEvHPQIa/T3EuA8dikhk4o6/fpqfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5t5z9GTy3uCe0LSX9OT/dZ3DDrVcMVerCzL0ll2/RoEJwsZkiTcDBWB5o0dg?=
 =?us-ascii?Q?RnKdRzmlUBOk7XG2VVSASC9wcULpAgXrYSsYbx74/avfE63HKVqs6xsMsDCC?=
 =?us-ascii?Q?/t2aYREoDH+UQdUqv/GIjWbJhDE1sanKHtmClJNkcuz+c6Isw8OPxQfIavko?=
 =?us-ascii?Q?9SHlMSm9/O8Sn/O7CL867dkP/XNwTAydEZBzrA0GP8xJBn6bu7KcOLj5bohC?=
 =?us-ascii?Q?V0IKtmWiNoGi4YVeoDSmYOKlaRJVeXHgz0WxBIpLTRPq4icCBF8SjCz7iR28?=
 =?us-ascii?Q?nnRERKI0W3Fzy24mtS2rlpLXImOdwoGq0CQyrysnoYZF42kCEtrvJCVkM8qw?=
 =?us-ascii?Q?Nd2sJujnrzTB3MGArM0/oDwRAVepBeahsDjPQKzAcfLPGMPVtef5sQfbCW5J?=
 =?us-ascii?Q?9i+mC0zcfSvGlUJ40zwotAtdxt9rspuMLJF9FiSdDETpPPf5juu8Fsmf16lj?=
 =?us-ascii?Q?JFv+NgbKE3S6T4+negwt5XmNifu7yykEuypHYgDXCiW7FtwoXA+Nq6ta9HDP?=
 =?us-ascii?Q?g42Y59DHn7u8vtk7O9csJvK7WguFNZgwD5dm19bCvNuLZL7SAQc9ADa7DEKY?=
 =?us-ascii?Q?8tNaEToJAtZf2F5CgaCBfr1T+nafNnhMjUhsrzFu+GeuVOiHB21F/FGN8kkM?=
 =?us-ascii?Q?QWEmbVrOOiX4fTxxBHfMIpb3gG2O99WNvayBB/OGeIhlAmFSWeyuHi0UNyOu?=
 =?us-ascii?Q?8Si5Ls/B/gmDLZZ1fX4wSi52xP3v+2y/FiU+PVI6U5+ctYxu8/sF6EcTRSab?=
 =?us-ascii?Q?gWEEYb6eeLhFzXB3D2bvqatkKgnBtzCmW6mO4NuutNqXmU5MKld7MNlZ9WlN?=
 =?us-ascii?Q?FmvCWoU1oGf9OSyK1Cy3kPyykwYcpAYeaVCk9SAsg4qZNUgcpzVD5JHsFOIh?=
 =?us-ascii?Q?PP+4D7U8EVcdea0nyTaS5aVdNw9IYMJbr5ZKjyAY2lUiz5IwrhesaoDHXgac?=
 =?us-ascii?Q?8OzXgs4j5wZZXEfHRAErB/CQiyctmzb1N3YGWLVe6fvRWdirETGA8xkS6TmL?=
 =?us-ascii?Q?CmquwqE6/wUbbzgUR1TBrlowAHGkFOY4Y5UofthHJzziVDEiUQwuUn46QiId?=
 =?us-ascii?Q?xwMNc/jz7rqHBHL08fAyVqNJsxjsoA9ipf71569cAbIrzH+9SttMdrC+mH7h?=
 =?us-ascii?Q?HnxxGlz86T8Gj8baTXvd2o5SgPSJTFAyQzVvOkKAuWhir7MA7Z5y9nqMCUmC?=
 =?us-ascii?Q?K4C/iC9HFoWi6ysdd/I73X/u46ttUuUa4S60FuKP0j52H6k8lM4tuXahbO5z?=
 =?us-ascii?Q?JBTx8MiM1pWZbJA7wrc12PuxJRAcbOkZjHmFe9pNLqh1YCkLnml5X9D+RIVX?=
 =?us-ascii?Q?uYpikucxDW4W/e+IRLFzVgSeWtEqu3m+DEFWP4AnQL7AxqEQIqL7M6LRm30/?=
 =?us-ascii?Q?Vu+ezQV1cITAav6mXBlN7067czGJY4W2ihqx9m4bMYhho6q/0AdolLoshJuM?=
 =?us-ascii?Q?HFdu++n1f7iRpj3/rCbGYMnrjg8tf1zNwHWlwtDExECPcgOoahpnHR1dS5DE?=
 =?us-ascii?Q?K6CoreJ7re7imuLKXgOx2opizUw+yY2a7d787wi6q+aFJngZtAI65RoVXbFr?=
 =?us-ascii?Q?6PqMMGKudtVl2hq8Jo9VgI4OgOaw68dY8Gv6CmIZfGaTt6FemucW2izJy48C?=
 =?us-ascii?Q?AzXDSfuk1Q0+IpXm10knRrFGZa+XSuPCkleYO0PP/7m5mjPGBUugFLtSQiIF?=
 =?us-ascii?Q?Ix+FubuFQltVH7yRjyhUkY4pJOa43QhMM2Iit2bASXWVbkWKcZf7S43fLS3B?=
 =?us-ascii?Q?XnKbAgrvqzKxAAoSs7ns4f70PVMDosmK4wnJsYEl9UsKA+fmMydD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5f7e50-0df7-4416-6d2c-08df4cda6e23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:54.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/l9wJgYmr748efETGzCySesCAvBF22ZH1VpkNYTTsjQdlu6x6kOOCXfgbsnUZjxjNSQ+XHgkXB0cqZsqfGunA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Nodemasks have a compile-time capacity of MAX_NUMNODES, and
nr_node_ids describes the runtime node ID usage.

Modern distros like Ubuntu default MAX_NUMNODES to 1024, while the
actual number of nodes is typically smaller. All nodemask operations
currently refer to the MAX_NUMNODES, which adds a substantial overhead
on every traversing operation.

Simple switch to the runtime nr_node_ids might hurt users configuring
their MAX_NUMNODES to reasonable small values because the runtime value
breaks compile-time optimizations in the underlying bitmap API.

Thus, switch to using small_nodemask_bits, large_nodemask_bits, or
the precise nr_node_ids, as appropriate.

Bloat-o-meter reports 1-8KB decrease of .text, depending on NR_CPUS
and MAX_NUMNODES. With nr_node_ids == 2 and MAX_NUMNODES == 1024, basic
operations like nodes_copy() are ~4x faster

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/nodemask.h | 80 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 4ef6ca642054..67ad972b8942 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -40,12 +40,12 @@
  * bool nodes_full(mask)		Is mask full (all bits sets)?
  * int nodes_weight(mask)		Hamming weight - number of set bits
  *
- * unsigned int first_node(mask)	Number lowest set bit, or MAX_NUMNODES
- * unsigned int next_node(node, mask)	Next node past 'node', or MAX_NUMNODES
+ * unsigned int first_node(mask)	Number lowest set bit, or >= nr_node_ids
+ * unsigned int next_node(node, mask)	Next node past 'node', or >= nr_node_ids
  * unsigned int next_node_in(node, mask) Next node past 'node', or wrap to first,
- *					or MAX_NUMNODES
+ *					or >= nr_node_ids
  * unsigned int first_unset_node(mask)	First node not set in mask, or
- *					MAX_NUMNODES
+ *					>= nr_node_ids
  *
  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
  * NODE_MASK_ALL			Initializer - all bits set
@@ -90,7 +90,6 @@
 
 #include <linux/threads.h>
 #include <linux/bitmap.h>
-#include <linux/minmax.h>
 #include <linux/nodemask_types.h>
 #include <linux/random.h>
 
@@ -158,13 +157,17 @@ static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
 	clear_bit(node, dstp->bits);
 }
 
-#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
+#define nodes_setall(dst) __nodes_setall(&(dst), nr_node_ids)
 static __always_inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
 {
+	if (small_const_nbits(small_nodemask_bits)) {
+		dstp->bits[0] = BITMAP_LAST_WORD_MASK(nbits);
+		return;
+	}
 	bitmap_fill(dstp->bits, nbits);
 }
 
-#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
+#define nodes_clear(dst) __nodes_clear(&(dst), large_nodemask_bits)
 static __always_inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_zero(dstp->bits, nbits);
@@ -181,7 +184,7 @@ static __always_inline bool __node_test_and_set(int node, nodemask_t *addr)
 }
 
 #define nodes_and(dst, src1, src2) \
-			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_and(&(dst), &(src1), &(src2), small_nodemask_bits)
 static __always_inline bool __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -189,7 +192,7 @@ static __always_inline bool __nodes_and(nodemask_t *dstp, const nodemask_t *src1
 }
 
 #define nodes_or(dst, src1, src2) \
-			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_or(&(dst), &(src1), &(src2), small_nodemask_bits)
 static __always_inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -197,7 +200,7 @@ static __always_inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p
 }
 
 #define nodes_xor(dst, src1, src2) \
-			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_xor(&(dst), &(src1), &(src2), small_nodemask_bits)
 static __always_inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -205,14 +208,14 @@ static __always_inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1
 }
 
 #define nodes_andnot(dst, src1, src2) \
-			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_andnot(&(dst), &(src1), &(src2), small_nodemask_bits)
 static __always_inline bool __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
-#define nodes_copy(dst, src) __nodes_copy(&(dst), &(src), MAX_NUMNODES)
+#define nodes_copy(dst, src) __nodes_copy(&(dst), &(src), large_nodemask_bits)
 static __always_inline void __nodes_copy(nodemask_t *dstp,
 					const nodemask_t *srcp, unsigned int nbits)
 {
@@ -230,15 +233,19 @@ static __always_inline void __nodes_copy_and_extend(nodemask_t *dstp,
 }
 
 #define nodes_complement(dst, src) \
-			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
+			__nodes_complement(&(dst), &(src), nr_node_ids)
 static __always_inline void __nodes_complement(nodemask_t *dstp,
 					const nodemask_t *srcp, unsigned int nbits)
 {
+	if (small_const_nbits(small_nodemask_bits)) {
+		dstp->bits[0] = ~srcp->bits[0] & BITMAP_LAST_WORD_MASK(nbits);
+		return;
+	}
 	bitmap_complement(dstp->bits, srcp->bits, nbits);
 }
 
 #define nodes_equal(src1, src2) \
-			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
+			__nodes_equal(&(src1), &(src2), small_nodemask_bits)
 static __always_inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -246,7 +253,7 @@ static __always_inline bool __nodes_equal(const nodemask_t *src1p,
 }
 
 #define nodes_intersects(src1, src2) \
-			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
+			__nodes_intersects(&(src1), &(src2), small_nodemask_bits)
 static __always_inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -254,53 +261,50 @@ static __always_inline bool __nodes_intersects(const nodemask_t *src1p,
 }
 
 #define nodes_subset(src1, src2) \
-			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
+			__nodes_subset(&(src1), &(src2), small_nodemask_bits)
 static __always_inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
-#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
+#define nodes_empty(src) __nodes_empty(&(src), small_nodemask_bits)
 static __always_inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
-#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
+#define nodes_full(nodemask) __nodes_full(&(nodemask), nr_node_ids)
 static __always_inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
 
-#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
+#define nodes_weight(nodemask) __nodes_weight(&(nodemask), small_nodemask_bits)
 static __always_inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_weight(srcp->bits, nbits);
 }
 
-/* FIXME: better would be to fix all architectures to never return
-          > MAX_NUMNODES, then the silly min()s could be dropped. */
-
-#define first_node(src) __first_node(&(src), MAX_NUMNODES)
+#define first_node(src) __first_node(&(src), small_nodemask_bits)
 static __always_inline unsigned int __first_node(const nodemask_t *srcp,
 						unsigned int nbits)
 {
-	return min(nbits, find_first_bit(srcp->bits, nbits));
+	return find_first_bit(srcp->bits, nbits);
 }
 
-#define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
+#define next_node(n, src) __next_node((n), &(src), small_nodemask_bits)
 static __always_inline unsigned int __next_node(int n, const nodemask_t *srcp,
 					       unsigned int nbits)
 {
-	return min(nbits, find_next_bit(srcp->bits, nbits, n + 1));
+	return find_next_bit(srcp->bits, nbits, n + 1);
 }
 
 /*
  * Find the next present node in src, starting after node n, wrapping around to
- * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
+ * the first node in src if needed.  Returns >= nr_node_ids if src is empty.
  */
-#define next_node_in(n, src) __next_node_in((n), &(src), MAX_NUMNODES)
+#define next_node_in(n, src) __next_node_in((n), &(src), small_nodemask_bits)
 static __always_inline unsigned int __next_node_in(int node, const nodemask_t *srcp,
 						  unsigned int nbits)
 {
@@ -331,7 +335,7 @@ static __always_inline void init_nodemask_of_node(nodemask_t *mask, int node)
 #define first_unset_node(mask) __first_unset_node(&(mask))
 static __always_inline unsigned int __first_unset_node(const nodemask_t *maskp)
 {
-	return min(MAX_NUMNODES, find_first_zero_bit(maskp->bits, MAX_NUMNODES));
+	return find_first_zero_bit(maskp->bits, small_nodemask_bits);
 }
 
 #define NODE_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
@@ -361,21 +365,21 @@ static __always_inline unsigned int __first_unset_node(const nodemask_t *maskp)
 #define nodes_addr(src) ((src).bits)
 
 #define nodemask_parse_user(ubuf, ulen, dst) \
-		__nodemask_parse_user((ubuf), (ulen), &(dst), MAX_NUMNODES)
+		__nodemask_parse_user((ubuf), (ulen), &(dst), nr_node_ids)
 static __always_inline int __nodemask_parse_user(const char __user *buf, int len,
 					nodemask_t *dstp, int nbits)
 {
 	return bitmap_parse_user(buf, len, dstp->bits, nbits);
 }
 
-#define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), MAX_NUMNODES)
+#define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), nr_node_ids)
 static __always_inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
 {
 	return bitmap_parselist(buf, dstp->bits, nbits);
 }
 
 #define node_remap(oldbit, old, new) \
-		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
+		__node_remap((oldbit), &(old), &(new), nr_node_ids)
 static __always_inline int __node_remap(int oldbit,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
@@ -383,7 +387,7 @@ static __always_inline int __node_remap(int oldbit,
 }
 
 #define nodes_remap(dst, src, old, new) \
-		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
+		__nodes_remap(&(dst), &(src), &(old), &(new), nr_node_ids)
 static __always_inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
@@ -391,7 +395,7 @@ static __always_inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *sr
 }
 
 #define nodes_onto(dst, orig, relmap) \
-		__nodes_onto(&(dst), &(orig), &(relmap), MAX_NUMNODES)
+		__nodes_onto(&(dst), &(orig), &(relmap), nr_node_ids)
 static __always_inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 		const nodemask_t *relmapp, int nbits)
 {
@@ -399,7 +403,7 @@ static __always_inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *ori
 }
 
 #define nodes_fold(dst, orig, sz) \
-		__nodes_fold(&(dst), &(orig), sz, MAX_NUMNODES)
+		__nodes_fold(&(dst), &(orig), sz, nr_node_ids)
 static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 		int sz, int nbits)
 {
@@ -409,7 +413,7 @@ static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *ori
 #if MAX_NUMNODES > 1
 #define for_each_node_mask(node, mask)				    \
 	for ((node) = first_node(mask);				    \
-	     (node) < MAX_NUMNODES;				    \
+	     (node) < small_nodemask_bits;			    \
 	     (node) = next_node((node), (mask)))
 #else /* MAX_NUMNODES == 1 */
 #define for_each_node_mask(node, mask)                                  \
@@ -524,9 +528,9 @@ static __always_inline int num_node_state(enum node_states state)
 static __always_inline int node_random(const nodemask_t *maskp)
 {
 #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
-	int node = find_random_bit(maskp->bits, MAX_NUMNODES);
+	int node = find_random_bit(maskp->bits, nr_node_ids);
 
-	return node < MAX_NUMNODES ? node : NUMA_NO_NODE;
+	return node < nr_node_ids ? node : NUMA_NO_NODE;
 #else
 	return 0;
 #endif
-- 
2.53.0

