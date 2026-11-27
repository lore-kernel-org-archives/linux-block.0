Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820507;
	b=lAq3vAXx0hzYMdKkcOVsXkWCElTEzJ9Khq40CtUGY8/lp3ON4Z7W2EYyi0sTP5Z7+lNA
	 REaepCGmfebw5WqRa/nw3fREwX95y+/WXTiVl1RyjMAf5L7c2n88q6yPQ2rE6uvs6zHXB
	 XK/dqhdKEkb7pZ03QyLUMgA1DFsd9jC+uJkwKS09PBnimeAWI2Cs6T5LCLvxlAzuPMu3v
	 FbNcjLNORnDhkC6TpXs0rCoX3TKgMwO3nyd8Y8k9YJBZR9QolCJLicE9DMGQGoUMjP4Ys
	 JO3VsjtsK5FUdr3cUoNMvBPQnP6C+6sIcaRpJ9H1DA8bGwlJVHGnRIjG0vqBRilbjlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820507;
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
	bh=qx4/b9TaPJYgc0NHouCo3H2YDZr8zP7ZhcpSdOp5I5M=;
	b=eee8pDk+y3AHK47LjGSPwLLCXt71Z6rL8SE3hbsUnlSesPdQHR8BWyuAGgeDQopcdNMf
	 MGupk5aoEOvUqJOPJlHdyeIS5W5ewnofJbNNKGOsV1QxKxE8sWNPgr1AnSZ2hsHyL4FuI
	 ycttrUc9Ew8HauloBBina5A+COZEDkicxH8S6B+5xyb9onw/SO1Vm9xXT9+w0bMnsh5Jv
	 K1DFYA5SoCftYHKlHjs6vL9sjvsM72rMeydY0MxmgmE3WBkR1LElUOosNm+zT1nFwopNi
	 i1rF0+8DorDPrxbX7mWxUPDKo4mWqpJcH6ZnaOtQW0L4cjh6aHmvmQszdR5LEZNxaxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QuKPjYnZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.48
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3941606A6AF;
	Fri, 27 Nov 2026 23:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3941606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QuKPjYnZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJuhyM8SEHsQJAdNqr831w0+obNA8pfNnZq+UPA+ILQDj4vFl54DZ9kVMtnot93QHW0+FjfovOnnLdIqppjGVIJgDUaqSgXmC+yAf5MtzTqpnhq/I7jVoYB5/GMzcbTddPl5s6UBVsB+WFd5D01dkqMAj0HmAa4FhFB98lU3qZ9g7FOJf+88xhiZPaQnKewdOoY4/kO8Uq3FEY1jsW4pYypWONJpAI2ybhOkgCKtD80o2YrJMiYvakrnidzscgWkPmduOxnK3djV+08sSVlYQM7yV5URRmrQVuedNfoFi3GpLwsI90HfNuJU6s/bkR4LjjyIiCB0e4k0WecHSc4psA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx4/b9TaPJYgc0NHouCo3H2YDZr8zP7ZhcpSdOp5I5M=;
 b=uq0uKL7/4Rm+iMkr9/gQSOPyBDu85RiBg+0AdJhNkmYlb+vVuEb4EMt7wZaoCOvPip1V0P1St5vyU4fDsl7LhE0oUJR8wssQncDpxKRbkK6CTI9qLpbdEHMCZRICEVfc6bhp9hoGtZkAs2x0QdCS7Lt6jktGLtM18cxTkei2Rm+t4MVGDce3Qd4PLnYKwG4pCZlJxVRrrMNqguD4MV76mn88iOck4pZj6gKCVcW1l369W6LYnxCYGCW2303f8SNMFQmd4idtYWO24a2S75vmXv7K3UYDo0DPmk1IWLXPUQayo2XnqxO25PQtyQHvUbkKFiqFtbdZ4WJ5HoiSWu9sqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx4/b9TaPJYgc0NHouCo3H2YDZr8zP7ZhcpSdOp5I5M=;
 b=QuKPjYnZ1701HLzWiTrSZtJ5ZwQVfVCd4cM0799u59y2XA3NcWJlgKAbZnepILUp7JdbkmkqxonVmK1lHN4Af7QJv9mg3p3I11yI7jUOziJ+k3BV3JH22GT0OFkUBZ83nrVv/O96Pg9qH6spYJLdOFFkRHm6BPBYQLDv+TIWf/bPofk4DF+xGfuUCrryO0V7VmIE+GMnXpnoeYkZM3dqpB6FJ3dFTYfic7Wl0n6AnpXX4kHMKDQITbqfqw60pOt2++fb6F/ti622OMWSo5duYjr0rp8uiqdoNQaP301IX9LVY2C+wfsNVCKPq8DcNTht6QBAqXlBwcMEXKmwu11cjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:43 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:42 +0000
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
Subject: [PATCH 05/11] mm: switch to runtime nodemask length
Date: Fri, 27 Nov 2026 18:01:22 -0500
Message-ID: <20261127230128.111933-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0688.namprd03.prod.outlook.com
 (2603:10b6:408:10e::33) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a7f220da-170a-4944-5a77-08df4cda66ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Kish0E8kW62eb73HNrEZqCoZGPxw37RxQMkgxYp6nN9x0Fva55AGNByyYiQJxxLrMcMCGGAvWR45czw8nIe0urRgd0jDTTuxz3JL8FcFk1tMar77cVZ9wPJK25v+wUGSXCP0NjNdDEtbJ8MsJ5vSh3RipO+gBR41ufL4I5g2rBkWIOFNJt6woEbA+oyudQV/2bc+b5iFLiWHBKgw0dZQphdQLkblTMn7sWUYZoha+uiD+SiGl5Hk8D+qyeF3DBytLHGTB39wQNmkxaBNg6JN8x2gcEmnNXcas19G+2FGhbsEAyw1lgygmUroOJya0U3wURioHHdLZAT5C/42kvghwzW9TkTmR61MBcJ1RA3PpRTTrLh9z6F7sR34FHLvMfYzEU2+2mhZH9YXJoy1tyUOaVs8tRlohnuDDctxmAOC5+MxlUZFvzyX2xmBqFaqMa8myIwWmVbMgC0UxCnNjhgBwLHFqKXEgZgcVYf8jXi0Tyz8CalAiHEmS4EL7McbK83ffjLdMSGNILPAezC7lnHlRnMwW3w6X61n7GtgZQCa5oad2yoABBmYb1JpB423q51tZDCupvbwnoqzWv2eiYDrq+2puPZjT7MvcLVxua8Mr1p0LhrlxmpwjfA6G5oOCg94u5/aN48x3hBeaDgtPPa2qcd1KsuGijVI1Du+lOrzLDkT0XKI0mcHxbCf2WguuIHTyACwDtRltProTkN3Ui7Tdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANkSIt97N/9Aqsp2ESDBjzR12blIo6wLac8Ei8kh0Y8STZNpFAyFuIopx/Pb?=
 =?us-ascii?Q?8lVuBrmMvo8OMGx9/2XFvako+7C1GTd2sl51AsUZbvR64+Jjm9X7PZ+aTVW/?=
 =?us-ascii?Q?7xB5Tr1qUDmsuawD2WllXElUwymOxE/zL8j7u3iUFdaMWsoyRQCkWmDfzUMg?=
 =?us-ascii?Q?JOFwcxernU9aPnML/Lyda7ulcNZEKnVRjMMBT/VlIIPBf4Umi2J4gZKve35s?=
 =?us-ascii?Q?/+w8eAfWT8LsuTZFMhv2O1Y/Hv/cFx2UiqCUFFHQeoSHd/J1tdD1W6ZL0D9G?=
 =?us-ascii?Q?hdDfHXmduQ6jg7EH1JF2vwppldB4tjH1m5MJa2vHjKgWgn8xCtuQC9JFK+Nb?=
 =?us-ascii?Q?6sGX+d1UwOmvs7u3mvzXRDcnKVuM89aJ9N0mQNIzERaOKf8JapV2/YZ//Skm?=
 =?us-ascii?Q?iiN9XA4WLiJWpjYDGKIN0oyZWDBbjc+oQtBiOOTxw162jrK6M+rIwIFohp3N?=
 =?us-ascii?Q?IGUDCCL7dflSSRCDimQdSEmKgjmuFz3koOdEMf3Od7TLLve/8fMdTsWeVMGa?=
 =?us-ascii?Q?fbzPVsrgKvohrG9pV/LeaKXmJn8BLtf/k4gLgXsa1Y/N9jWJL1dk9s6xKsZt?=
 =?us-ascii?Q?vjilhgnG2lFqBOMzSaVV71X+KKPmrI2SPv3XYvoZwA4fOrPzVjnRIflGVFfT?=
 =?us-ascii?Q?rNeiAfmUI6ljAEaz5rEpE1bmQIg9EtyqyIoMZkGYXYnI6XK6NPNjZupeyOWg?=
 =?us-ascii?Q?qOClOiHzypKwTqdxzGQheRfXTZdzfP2tqPJS+gUZ7kGXt2qQaDhO0iMwGe3D?=
 =?us-ascii?Q?T4shfNLQ2sHhhARWhMoJbOgsvvDD4ToTmovrGvMSLW/i8+bq+jBvYAQhRZH5?=
 =?us-ascii?Q?5RAXx/pBSV31z0nsBc72ELqDnWNSLixdnmghTgIw9CgoSAZUtXS6V3ucL/Jh?=
 =?us-ascii?Q?Y+Dzg/fuLp6MXr0YSo4HOIgMFPrqt+fSnnk27ESzM4j0cq+3T3IYs6yMLiZZ?=
 =?us-ascii?Q?jPn5PUTswUVvDvo2rSrL8P/qiFK1enqeeVl0eKXNVRodFViPNO9DihHOuF8k?=
 =?us-ascii?Q?A2zLmNwQQNxF2maxXFnsb/RNJpz0N1Gkw2PhVCQNlbk3omg8LQnmOV9KW8+i?=
 =?us-ascii?Q?RKnecvn53SVDxRXQkyESLXbKrtVqgyNhI62FJtrUZZZjP1mABu0OR6l6Ll9W?=
 =?us-ascii?Q?1vVIhyf5owEa0Sc9AO9lqZR/eMnuiv0qEXKHJpXCulIg0Ynoo5waZ+Wm0T7k?=
 =?us-ascii?Q?xhQ+cAX5IJC4uX7Rt9NvTnJ1a97JMNnCScVc3JeyL0Ybs1grV3OZFhv2cfbu?=
 =?us-ascii?Q?1mLL+P7TLltR5XTbpMKPnyPeqtcUKF1YA5HEge1s4/W/mRy3J+ViQSWWG4BK?=
 =?us-ascii?Q?seI87qpHvl82JmL+3PjJv8LI4mhAzIEqygjOb8AAQUxm0btiGsP99HcMsnNA?=
 =?us-ascii?Q?31kv+as2/9rX1UKa5edx5nVgr1RvEdtfr1hxJYHZZT9MKEKWYVi8rrVBDURp?=
 =?us-ascii?Q?F6eMcOHECn1IsJuB1GL67NbCi7h/N9cdfKk++CL5GZnusWW3RHEwdX4svNkz?=
 =?us-ascii?Q?ChRqX37hryG1mSmOo+4+ItsGmSiddqXVvapHp2N92pMyL0y8pNt3pR2Bpfeu?=
 =?us-ascii?Q?v0WvDv1f8DOx7nTVgzlHqRh6qm1BDHrPhFpkp0kKpnISPyFOW5EYACFD9b9Y?=
 =?us-ascii?Q?ViGdBOIeyzKKDAiBPnEHyVocKfBgrrFCjDzO5ittTBdBoLkoSsQSVE4urBF0?=
 =?us-ascii?Q?DWVgjwl35a+JhvUPCfuXVROodikgq9zZm2krq+yb8+UA19QDB7pnoUA5Nnu4?=
 =?us-ascii?Q?v2r7RiGMJVc5g7RakG198yPrDq5fEAoF7aTYLTb2tqk0D2H4mryB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f220da-170a-4944-5a77-08df4cda66ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:42.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CG9ruaV2uoj4Q5Bz2EoIqx+lK0M0lqY24kC3vxuY4sr1nx9AUAnTB4nVGFiOoEYqjdy9sv/8eCOmso+4wsqiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

In preparation for switching nodemask API to runtime nr_node_ids,
update the boundary checking conditions.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 mm/hugetlb_internal.h |  2 +-
 mm/mempolicy.c        | 20 ++++++++++----------
 mm/mmzone.c           |  2 +-
 mm/vmscan.c           |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb_internal.h b/mm/hugetlb_internal.h
index 1d2f870deccf..bcdff7485c8d 100644
--- a/mm/hugetlb_internal.h
+++ b/mm/hugetlb_internal.h
@@ -31,7 +31,7 @@ static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
 static inline int next_node_allowed(int nid, nodemask_t *nodes_allowed)
 {
 	nid = next_node_in(nid, *nodes_allowed);
-	VM_BUG_ON(nid >= MAX_NUMNODES);
+	VM_BUG_ON(nid >= nr_node_ids);
 
 	return nid;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ed8b20b27753..d64d3e70a82e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1123,7 +1123,7 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	current->mempolicy = new;
 	if (new && (new->mode == MPOL_INTERLEAVE ||
 		    new->mode == MPOL_WEIGHTED_INTERLEAVE)) {
-		current->il_prev = MAX_NUMNODES-1;
+		current->il_prev = nr_node_ids - 1;
 		current->il_weight = 0;
 	}
 	task_unlock(current);
@@ -2141,7 +2141,7 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 		node = next_node_in(node, policy->nodes);
 		if (read_mems_allowed_retry(cpuset_mems_cookie))
 			goto retry;
-		if (node == MAX_NUMNODES)
+		if (node >= nr_node_ids)
 			return node;
 		current->il_prev = node;
 		current->il_weight = get_il_weight(node);
@@ -2162,7 +2162,7 @@ static unsigned int interleave_nodes(struct mempolicy *policy)
 		nid = next_node_in(current->il_prev, policy->nodes);
 	} while (read_mems_allowed_retry(cpuset_mems_cookie));
 
-	if (nid < MAX_NUMNODES)
+	if (nid < nr_node_ids)
 		current->il_prev = nid;
 	return nid;
 }
@@ -2261,7 +2261,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	 * Clamp this loop to a single pass (nnodes) to keep the walk
 	 * bounded by node count.
 	 */
-	while (target && nnodes-- && nid < MAX_NUMNODES) {
+	while (target && nnodes-- && nid < nr_node_ids) {
 		/* detect system default usage */
 		weight = table ? table[nid] : 1;
 		if (target < weight)
@@ -2272,7 +2272,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	rcu_read_unlock();
 
 	/* the mask emptied under the walk */
-	if (nid >= MAX_NUMNODES)
+	if (nid >= nr_node_ids)
 		return numa_node_id();
 	return nid;
 }
@@ -2295,11 +2295,11 @@ static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	nid = first_node(pol->nodes);
 
 	/* A concurrent cpuset rebind may cause us to see an empty nodemask */
-	for (i = 0; i < target && nid < MAX_NUMNODES; i++)
+	for (i = 0; i < target && nid < nr_node_ids; i++)
 		nid = next_node_in(nid, pol->nodes);
 
 	/* the mask emptied under the walk */
-	if (nid >= MAX_NUMNODES)
+	if (nid >= nr_node_ids)
 		return numa_node_id();
 	return nid;
 }
@@ -2697,7 +2697,7 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	int nnodes, node;
-	int resume_node = MAX_NUMNODES - 1;
+	int resume_node = nr_node_ids - 1;
 	u8 resume_weight = 0;
 	int prev_node;
 	int i;
@@ -2759,12 +2759,12 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	rounds = rem_pages / weight_total;
 	delta = rem_pages % weight_total;
 	resume_node = next_node_in(prev_node, pol->nodes);
-	if (resume_node >= MAX_NUMNODES)
+	if (resume_node >= nr_node_ids)
 		goto out;
 	resume_weight = table ? table[resume_node] : 1;
 	for (i = 0; i < nnodes; i++) {
 		node = next_node_in(prev_node, pol->nodes);
-		if (node >= MAX_NUMNODES)
+		if (node >= nr_node_ids)
 			break;
 		weight = table ? table[node] : 1;
 		node_pages = weight * rounds;
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 65880396f104..2c96341ad7e0 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -19,7 +19,7 @@ struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
 	int nid = next_online_node(pgdat->node_id);
 
-	if (nid == MAX_NUMNODES)
+	if (nid >= nr_node_ids)
 		return NULL;
 	return NODE_DATA(nid);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a1af9b92349..7d78181946b7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5751,7 +5751,7 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 	++*pos;
 
 	nid = next_memory_node(nid);
-	if (nid == MAX_NUMNODES) {
+	if (nid >= nr_node_ids) {
 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
 		if (!memcg)
 			return NULL;
-- 
2.53.0

