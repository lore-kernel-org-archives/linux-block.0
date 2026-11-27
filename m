Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820502;
	b=yugrUUCzsxiVh+rdpHHo4P5f0ASsNUH3Wy+7/I5rNAIDhr3EZkR3qs/PTQIaGSroC7Ps
	 sqmqmwXJ8g0SdThtt8rIC0b+X4/VPT9XOlTDks0j89O0/ER+m4lFymPRBXsyVH2BXvLDd
	 FIPc5GgA41l4EHzy4VElFJ0/wGUOVJCJShUTWcf/DLmRgX5Kwx/0NRe1oGggyQUufsloY
	 8oyPQeihD9holc6yned8WfN+Zoe8q1SmoS6oYVgsuyH31VuShezgmHj4UMEAV5soHiZiI
	 WoypjdMPI0w5pJGTnT6q/eOJnC1nn50g03ZjFWCl+GLwYod0ceM/C/DCLl1eo9HYpuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820502;
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
	bh=k3ZmOT2SF888jSN9A/SfPYy4HLPm4zCpMpOCYIlLGs4=;
	b=KmHNNVN8r/BM47xRn4b92fOC9Q7Xl1SKtSnlGUlvad3PZ6f+FZOczqcmql863FaaB27T
	 8ri8dp3mrMhBE7STmjEzQMYwam/nA2nItQaMDgIgZ0DIRJsvJ9HVoOXkNc5EsPPsd59CP
	 EB2bu7f0rOTxQGEiNLf2LT10hnaN8MwpRNTDm/P8X+qiR5RdlgnsxJGgpc+zlW3RszFPe
	 w01RLQB4SVS6A7WgTuYXi0ytNEZ6dmdHNsJgiKFLDQV/RY892+OgBbrBJzlNN9ppz+mp1
	 us4CF8csGgVNaw8Qhujug2iWmcrDGbQtAe1jYAgDh/fWfLmrYt798jQVsZWEqNCG/Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UyHRIWlE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA5606A683;
	Fri, 27 Nov 2026 23:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0AA5606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UyHRIWlE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLpBuJfOmIppYW9QFTkt5YRWAW0V9Ixb1I6l6VoQ1uXkBemPVC2qb4JziLT1eqfL4b2TLk7+10GPwhKm6uq0F9e7hHhrgQIU0KJSS4FkgwVnJfmgpsp/hYTN54hSn5xML8uifnn85HicMIcU1Gt9IH5BKWClXwR5VxhcaD3T2ef8iv4CyPCbMfNEWRpXrQQd3eg5bVbVsaAQ1AyGeBirxuMzWUyD+NC5IApOiyTSGhg/WmT2SVe3Q5/Bi/CcQTfBUNQYQqMOWZlRQ8J+1V0Yde0l91K79M7nRcySxQwkKuyURPzAOqARv8OGcSRdUV+y8k75qwRgRTiHv5kf3/dTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3ZmOT2SF888jSN9A/SfPYy4HLPm4zCpMpOCYIlLGs4=;
 b=J0lAOH8O6CRdprZnddmfZL4hEc8tdWA0Dr9v+pFXyDYRE0rxms5mpnFD+MU3rdp6rO1mBjLsrMTCAXn9AzWe5YxO/mFpLuCFmdgQUInBB4QcPEA+dqt5GGhBz2nvZsPUsa0kHBemda0xRdWAeGBc4KVqMdccrWQzEnUihJM9e/YrgLMvuFTVfmdacp4zq+qXVLa3OFrkj6yUMiewd7qpvuQ4cmi8THHGPEngl6eLvP6bO8ufDf8GcxLU42AdcTg3fM5q8ay/rHPCsvBjhA2dahc6LthjSK7tOwmjW3OavI9aJyu50yAR9rphX8ZvIIXCPEw4DKkv3/5VhV2AlGeAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3ZmOT2SF888jSN9A/SfPYy4HLPm4zCpMpOCYIlLGs4=;
 b=UyHRIWlEWkAL1QG7QmJdMaptWt+AAbbEGZctLJdeevMY8NcNbMSf50UtfQuddRkEit5N8hFnnaXeS4g6/EN1NmtO1urgDpK5bvFX/ISxA1Unrr/Ln3WNL5yOdAMbVHWE2oXaMEz3Y8k+A1aEKU6nNa3ea70qr9QE1aUBUePQ4oHLJSfPw1c/kgHpQ+loknN2OwN5/sJKaJPh9L0pLW6m/+yHAviFZUNKoZuOzkCmFImPxoR5pAfbfVncg4DTH+hBLp632KtlpujNuDMrBbOyBxIfuQ8/1ZOx/Qdy89NNNxmd4RBMtMFkqRdNRqxdAaowj2XMaENIxq3tFs22pxQEGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:38 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:38 +0000
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
Subject: [PATCH 03/11] mm/mempolicy: reject migrate_pages source IDs beyond nr_node_ids
Date: Fri, 27 Nov 2026 18:01:20 -0500
Message-ID: <20261127230128.111933-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:52d::32) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 801fdf0a-2120-418d-a335-08df4cda64b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WDyzIXrGMT+/FPN3btkfy0BxQ7rJl+lVQET8HftofNbiajrkFeg9zFwd52bOUARoP5KX9Idn8NhFMggWxEQNIflXzheZyqpmAtsTyqWsa20MQs1tf6CqnGAwPaXp5XymAHCIgD+cp3d3o6naCwmm3wxW5Wh7egMsfKNhBlTGNRgqIUlAXj93WeEo+M2Sob8hJ7LO8XjQZNpdMgUk/9H17VGffqKkmKnQnna7WkhzjKcCqfILfqN7wbbzGfeFIuXsP2hC939R/yXDavHw1VVjDdW46er7hnnsAXzaokMglXy2Zvb+x+C2rHLV2CSONV2QaTsWMvILU58G/dRrvb9qx+ol6s5cWyra8sGvl/Q+PJh5HjkxS5BgbVLFTQpcZOwgCEx+SmGXQUN7MzoAzQYUcmIR0f2kZ7D1BrRjdXrKVWllOEKXGYIghkHkt1XNkKgfbMdeZ3zLZI+jLFkdKd/pDAM3Mvq1KxrXCc5B4fQUbY/tCRadZK+jHfgs+PNvhUVCWau9YYOuM9qi3z3gy9qA7O4CXPkvbpiccOJoEFM7qjnRtRDINaCYjIFs2JRjP/+MAposNKDYi2ba7bzmKOVEqZNp1shQhY4gO8oVZj8yiQWrF2QJafIMrJLBqPh0Fs9liv4RCYRpxX7d/V0zf1QX4jFxokqRX5mk046jSbkG5pwmT3Am0jMhCCKFQ/DCF3chpbSh+Fq3bljp3j5CGy4oDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SniKESgucCEqwRBknwSliLaLVjtA52wtVp+jKKQ2pWwNh0FXqimTgBgCXOta?=
 =?us-ascii?Q?zUG28i2JUqBChioWpSqWbUF1ge455UBtpsqvN/wJ5r5iSYIWOQ4KLVQYjp88?=
 =?us-ascii?Q?NcxQbS3p54xJ7allQftzqRucSxJGhM/jCfZrf+Qv/qkpAX9zkiXsJ1BfFO8d?=
 =?us-ascii?Q?aS3Hts9QT9QFU1Ke4NVyqaEdkl9l2j6I3+uiy7CFtFmwW0I/oxWlWmYwqXfu?=
 =?us-ascii?Q?H1YEbfYXwoFbeZZxe4TgBknIGdHu0JqK8XYiWaKVy364w8ugwc/YUkrd4oue?=
 =?us-ascii?Q?58dHrmfxOIhFxfDs9Rfkb2pIYOSRaTyLvNkOfBeNAa5ybCzMsYw2XSiyc2qv?=
 =?us-ascii?Q?0BsiKuLt5xmmO9pjZ8PyFUCfbXST06i8r3K1EBuNkUnxctez4r27WS8i3E45?=
 =?us-ascii?Q?hH0NDnm2pQP3s3HOfEm04TsZiF8ILcvjoMDnzl+byPoGT/TPaEO1XCuh5stV?=
 =?us-ascii?Q?g7vzQUwm4H7cIYY5OcCAXpwdQ4cXOA6Nhggn38oqRh88TuBQE+zWJ/oWRinc?=
 =?us-ascii?Q?+d8IPar4vidDTTYqAULoe1nPS22acxa6InEkwDDqA31iQzq8PvGRclTObY2k?=
 =?us-ascii?Q?3ghDZx8GubpMfBXcyXNGAZ51n1Z5u+jdwtnltDsFwB75+eqtUK1tMwro/tXU?=
 =?us-ascii?Q?WEjCK5smRObZM25L9I5SOi2R0o4rYYjIVzNKlI7aSFIxWmSRdmyAN9iSh6mJ?=
 =?us-ascii?Q?7kSouLQmq4Zhis6Kl3TmuX5cG5HDlK3MMtAYUCTzI5kjNCPbyeysmRtxttH0?=
 =?us-ascii?Q?on4MbaJBBejVpILepFBRfNg4PX/62ahNyZUsRwKn2og4dLKEYXanIH9Bx/vi?=
 =?us-ascii?Q?9h9ja/9je7resBzQb4KBhYdEk2HE7wTpZDNHBWb/xytuDtJBJdeEc1HH08mw?=
 =?us-ascii?Q?otfuqGJ9OcpHvXCcWlzDGWWrT0limgT2V5TQw0krNZNYnTd128dbftTuo9Tk?=
 =?us-ascii?Q?V61hsXVndKoVUw/Z4Ttz3l2drFAy4ndgfVg88+lrXFaMFu02ySc+o5xnoebp?=
 =?us-ascii?Q?Fi+U2hdi6MLgbGamJPGfNRYVMIwo9IAmj+IIGm51iQeIoQooVGNMHElPUBjX?=
 =?us-ascii?Q?M6+bYDejFUlgs/nsw8y53LdXU+BPsPFtBuQO6j6OtGwpgb8FLFqEqCy2g0gv?=
 =?us-ascii?Q?hr2L0sDfKeivW82j1blcxi3X8GaH2KnuIWrxjrVzW7VPmEFS2edhdzjiuVa3?=
 =?us-ascii?Q?m4JRJcvmqcgfgdio7rxtLiFTKG2T0r52xmDX7EZfyTzGficEmq//FGCAsGzL?=
 =?us-ascii?Q?pkLZhyU+583uYQ2mvsOnJa5zjdPKJN7YuQibKy8lhgcv0Im0kSvSwHsAuJ92?=
 =?us-ascii?Q?e17Cf7Gd2By7wtCuP5K/iKAnvjXvQEj621Bn10HRBsWwgk3bfMgRcqhzb3lr?=
 =?us-ascii?Q?Zcv+JK4fGV89fqmv48MrbM1GUmhWgTqN9ERPZ+9P6gVxBkptczUYBXko8SDH?=
 =?us-ascii?Q?fCGvSec+kGiiqOtuowT8XT6iZdWrEY7DRPOMMiIsptmoDbwdKggqZBT3A8Di?=
 =?us-ascii?Q?6UMj43Rr25gt8fgbpRtuqzpY5Pb/UE0bI8DhbyPA1gksktzuwhiQxfAHuO4h?=
 =?us-ascii?Q?sNxiCJ1vQoITaMzbGC4jXnY6kiKOKkwEfJBMPryw9jErMvriK2KzEBgImI4l?=
 =?us-ascii?Q?dKM5MZHp3hYN2VZcwURCOWKXJDTg33tAUlmhvUW9iXA3XwMKusHasTDHpMZq?=
 =?us-ascii?Q?iOixXA4LNXbdaGMbrpDomssOSvXu8n2USpiEQh/VGAAzbTv5a++mS3cIgm7Y?=
 =?us-ascii?Q?wEXMnmDzx0M482PhUHA+7YfOKwuphHducbc2zD5HlibftzMNIPZr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801fdf0a-2120-418d-a335-08df4cda64b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:38.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxlKkEH+7QUEIY5I13Q+yeq8HFIdmCDzWwUOoUGW7pY6axP59o5zcEFBoeYUShajaL/GwqESM6XFGbiK4hFMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

The runtime nodemask conversion limits source iteration and weight
calculations in do_migrate_pages() to the runtime node range. Reject
userspace source masks containing node IDs at or above nr_node_ids
instead of silently ignoring those bits during migration selection.

Check the full MAX_NUMNODES-wide mask after copying old_nodes and return
-EINVAL if any source bit lies outside the runtime range. Keep the
existing destination permission checks and the do_migrate_pages() API.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 mm/mempolicy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ffe4e45cc97d..67e258c62527 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1905,6 +1905,12 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 	if (err)
 		goto out;
 
+	/* Source node IDs must fit within the runtime nodemask. */
+	if (__next_node(nr_node_ids - 1, old, MAX_NUMNODES) < MAX_NUMNODES) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = get_nodes(new, new_nodes, maxnode);
 	if (err)
 		goto out;
-- 
2.53.0

