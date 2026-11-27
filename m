Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820519;
	b=NCHM9CDt3HQLw5u6vJH86i2IwXi1Yanspua0itSFawBLGSvJXVHDbVG487+XVJxlqDb2
	 0gsn49PM0wiWQcUbhm9+JgdVILt591SnADVFXMLhmnNcgKEMSKbGgHULsnkKep9vZm+EL
	 EyIbTP4Qtvdp61VShugQ395n5n4A3zgozQG3JDx6HzWhSANWYCj9LnU4JLsYQPAQGfoLp
	 oC2CbxhRbl6CwRfsWmqKPar8T0YrrV9UpjhPFvtRH9sz+fGtFqLsZjcQyl+PZ2Biql9u6
	 nTnyK5Ne89DbNEjs5SXS8ViNAHgo+Q4focYSM7Zq2PVgQ7QdEd4k+EcvQd6ka5Ve9mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820519;
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
	bh=ZIE4iGENsrGg2GNp7iqSA5q8ihAT0ZByPRKYcBLYetU=;
	b=kQHFMpIBYxAYR75zk/Ikv2lh9HQ4bT4fLDnrLnAcj5+Sr0RoyCLgfnOEngB4Ye0BzIQr
	 D3wfTI/Z1ayPl9UWl72YGoxB9QbMA9H+RDD0Eh+KMzLvW94WPK3P+SrkUoMnOqagKaxpP
	 caJ6CqCT4TNk2NznPmoUs7OLV2iQA4k4Qn9NG7phTidvkevZ8i7p5qSwxwXkfyPs3Cu6Q
	 1iNRYljo6oaQPt3YJpamiek+yQqOmziBBehGH9iiXpEJFRZm0SRfWb7Qeig0V0iEgm2KA
	 FKfOY/Lb7qSDne1J69YGTzCpTQO5ZqYac03HwAYgndzhQXK2UGTVhWNYe75UTunJpDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kyEDwYbO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4C606A681;
	Fri, 27 Nov 2026 23:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC4C606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kyEDwYbO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKmzDqvO+p7IbaNru2LC/9dYu6DAzClt+DqrSlQvYta7YkwoJLYJP75bDoGmWJ7d6yo0qCVJV+ZOQhm55aioidSHvpgCTc9rBtq5gBRYXJZQchne74VVPl5TWWi+4qAUTvxgxUnCH4eWGesWKK8527OQbukohgHfeiqGtLaS6w4rfcnaeWgJ2h1LnxduzKMwe4n4LW1TQ3F/VyjO2vpi8fitaP3bHt5v6s2/P/x1Y1kovFyskQVaC2sT9TG2Wz+ZHSTVNbUhHmBf3svfsgA9cMFE3DahXXGLXOa5GVvU3RAyY7nwPmb6/zZgIXRf4H4Xk/MGmxJXAtdcwKG6kTJHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIE4iGENsrGg2GNp7iqSA5q8ihAT0ZByPRKYcBLYetU=;
 b=U/fNBhncK34D+2+B4Muai0fkGL4thPMwy90OB7UcfJIeLDnk2kou316DG1DIziDsBgI9B7JElgQ3eV9rCkXZEtHwtpx3jSSYlYiaE2fFRxfPKQVj0tdavLskJumq/UupKn+i7ctRQjZEmVRmMnOkYSd32Ha1cJqqqw0ajMSDE65K+WogL9zpliwfjv2uS26B8sMKFfsaHrxk7YKeUgyuQ0y5NXIcF9VTV+9hUJjZuNk0goP7yJBbhyszIqoiYZ+X8cEPn3gTPxfaJrO39c4YCOxAId8HjpZ3zwQM0F+5HCpnCZCYUtwueWcXrmNXhjJ3RAPl2NU+nj0ZHEmQbj2HRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIE4iGENsrGg2GNp7iqSA5q8ihAT0ZByPRKYcBLYetU=;
 b=kyEDwYbO2msGAIueRnmpuZMtjPX4nB2y7RA5UUiftYn8i2MIjzUeCkzkm9NLKIlLRfuzDEwIASq/6lhtRCNT1/HeP3YiMgeAgpcNByoyni7EYKv4feAqppihFDUwhrgG0TFb/GB4+cUgtdL7m+X0lBtgULlWnSqNzhudNYClhhqcQbC3okO5Y/KO4/16eXx5VWBW8pICO07Cv/ty3iKm4HLKWLUvq1eTx8lwZu1NXvEZvaFhZvMSYljFLBfX8QuQXOR1m6JCJtWulb4jLbelPSwdos5cBQWx/t2X6rl93Hn//WZMGIobYC/6KjN8Q99JkI/gg2hs9Qz+PwgsZ4H8lQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:52 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:52 +0000
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
Subject: [PATCH 10/11] sched/numa: bound cpuset trace masks by nr_node_ids
Date: Fri, 27 Nov 2026 18:01:27 -0500
Message-ID: <20261127230128.111933-11-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:408:e5::8) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a5a8823c-e45f-4dc0-9e52-08df4cda6d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026135527099003|261026140227099003|261026121527099003|261026130827099003|261028144727099003|261021135927099003|261021133027099003|261022115727099003|261021130227099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	PIOaLrDmejSFMwfdTY1m+LQhkgiwV7tHLfyUGf9JNFYRWsZMQ43XKxa2f9uWljWMeM5krc/Wyb39LEwqHw8BT3i+UvennbByNrOZ6AFgmABV1qth0D0mra0usWGLCZwb8vSTQTSdwwkVQf71n8/IlTREb+PCLsiEvUJNFU7uU+PtF2sCjnCDIlduS0caFOTQeFlrTJ7tLMFGQaQuxPIRJPVx+1r55JaTC+rCket3ok7yw8O/9jdYZg24McPo3h7l4bcfUx5BxFIhkHYxjkGOi03HXh9IhAGT6fasayYozCCQJw6aUOxOSVbO0O6q2KyvoicFnUVLlRCvtEli2X6/RRBe2dUPns4AWuCm9diId6X5yCqqprTeMZgLxgZoLiAmgWjpaAnWE6kibszW+N7iFltvXFvagrH3Nrd+I39lq+iv+ChcXCw1zw91Ak7wLUrMRLjfQHad5wlk1zlPBXmtjDGJ5BmO3PcDHVIbYE+6CT8K94THD5jEv3iaPfaIH2j6o2dDKrJD+l0wGWiZv2yAEoi16TMdiY3m9XzSs4Jh1ckwuXmL0h7cP1rJdArNiawX3CbY9suEn2zdpHU0brepTGVuQZ/58/GWKfWaewFITZHTat5aTy8K+iKc0bazafiLG5DFmuuQZYScYk04Ba54kJGBA4LVGHN8U7Qk4L4gfHfKMYnUMtPuLCWQRyrJuRNjULoxTYhDT13aBys+qjECLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026135527099003)(261026140227099003)(261026121527099003)(261026130827099003)(261028144727099003)(261021135927099003)(261021133027099003)(261022115727099003)(261021130227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTyt9H5i1XcvSRVx6sRQSoviJcqKgxGY3HohdIZQW0oWZfDKELspqchBAEYe?=
 =?us-ascii?Q?g15w/zYjyPAc2kER170uNZDvA7jzoo/1v+nhUvks1j62mKWrVu+ef1dQZOuu?=
 =?us-ascii?Q?TuZoZk68f2SYVXk7VT55g1mMVaO5AvV4uBKjvAs+ZEZoxR1EWlnovELrKmpf?=
 =?us-ascii?Q?sk8tj6+//2hbCZ6z70za24ujF0CLGCU85kXXEHFMAAbb42f08tFvAwZybL5h?=
 =?us-ascii?Q?ohN6EAW+stYD3s4PLNtQ1J3UMhKSTi27PCyR4SP+HGWtUkqWP418lxms2CzV?=
 =?us-ascii?Q?9BGKXO6cTn6pKZrpUjm1iaLxV8bM6A4TsstPUHCj6g4bxVWCfKEZ787A00JV?=
 =?us-ascii?Q?m8pSnRpuf8Ml3KN+U8WIteArnEFITOcFCLCSeo7SVzSolpcXqHLPI3lbFEH4?=
 =?us-ascii?Q?gfNhKbZAmuqdsmwpuGdf/oUJPb9Vyjyi5kTRubNlEJKRNHUeIJjj/vlW+vWv?=
 =?us-ascii?Q?PF4TQ7iaEVcvfslYFItRghLqSm8wAupB8ruG0T9FSt5RSB41NfT8rwWB6LIk?=
 =?us-ascii?Q?v6v5yMl+gb/8wCewIV2+X1X1FLLIJlbh9wn7cupLxiAff8iPK7/ZizA9nPUk?=
 =?us-ascii?Q?0vKnESrsKJ4LNCQQycJVT+zZN9TK34WUlrzguGHBrHDew7/+afDW29vTrSPw?=
 =?us-ascii?Q?K2YKAJSO3jPpjneRKzhnZGVYEAh3YspUlVLmQ6mZ+ZRezu0IGyaD6hRL43mn?=
 =?us-ascii?Q?BnXqeVI6MmmYUVVKlJk+4fbPVR4So+IaKfmUvijibB9cRb4nlUQPbZSGy5k4?=
 =?us-ascii?Q?EkrRHL3QMIK/fCmDVn4oPoTlU0E3QfQgKpE7NkSYVa4DKI+GGiShfp+NWWdf?=
 =?us-ascii?Q?YBlWtgQF2e/210taGAn+k1CDl0LDN+kk68hAmywfOD3UcGk2IjtjNQHoh57a?=
 =?us-ascii?Q?DMEN0htO4U2ffLW3kU9GrlBWJWv8hlngrBpVURF0wNsxvNVil6A+Fd9agsGN?=
 =?us-ascii?Q?i6ceod4RI8Zlo4F+EHNPIepKcoOPweNE2mdUfzad/HvFrLRjVL2pDYHj9rqI?=
 =?us-ascii?Q?RtP4Xwh/7lnS39778xGEz9qjbmqkhuWrTeLRIivG0+cXhBgueA3z5iTlKLkx?=
 =?us-ascii?Q?sYnFztDh6LDGBYrKk3ca1pIZMGCMPOi3mi0WH2UFycQ0QuNgT7xHPsSqQ7vK?=
 =?us-ascii?Q?e2IpZ9W2QjM+j58fT2AgrlTkM38clN3ohnZyXCp7zIP+jhVT6dDyLu96quSH?=
 =?us-ascii?Q?Y567Kd2qNrWnBxhRG3GIQvbARAKyAkGrzHh9j2FAmznMjqhsxbk5w6Fl4TWN?=
 =?us-ascii?Q?VLMFUK0VG5zQkZmxG5hWC2om1FDleTLa4zl4ZN4ClppmApDgBPsp735GAFc0?=
 =?us-ascii?Q?jWGS4FelgqndVgymK90JcerxF2E6OEWiSLs3mU+HBbpjCdxcLiex5L45g1jk?=
 =?us-ascii?Q?5+KGCccTX/DKnKv+G06u/MGhlHTCGJiwNfS3FtKgwrekt5+KYyobuI3fWRcV?=
 =?us-ascii?Q?0lQ0M2rkHPPFj7ll+KWV1Y25FN7mxN1+XpolET1G4sEDdHK2onSCadiBEx4s?=
 =?us-ascii?Q?hDD5BxTzPjkpuuVD0dn/y+nKLm81vQIeBGcDaKQPBdb84VPIJfjGAG8e6F43?=
 =?us-ascii?Q?XzehFXlNR7Qk8kqJOeFo44zeL342ApAE9YhOXAijYLkvUurB7OOJJT9Vjbb+?=
 =?us-ascii?Q?s+2DwXv9qFumCYbV177ZP/QbR8WElNl9+2+diqeLY2nb4Wu8Btp6UYTaRzEc?=
 =?us-ascii?Q?1SlZWbqeL2iJ5FtuLU8tfc9yBXTEUAFa8izyroxDNeI2VzlvJJYu/cWZgqMK?=
 =?us-ascii?Q?h8kraINAwdxTRHdYOoFhuWltDL3btYpDTGumXuzR7SUQAyV765Tl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a8823c-e45f-4dc0-9e52-08df4cda6d0f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:52.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Meivwbm+2xGsYPJ07oOznisJys2SDus3hRrn449fxM48JVaDNkB9gmBJGHCmKwDqBIXQxb+gwGR/nvVbRIwrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

With switching nodemask API to runtime nr_node_ids, bits beyond this
boundary till MAX_NUMNODES may be in undefined state. Those bits may
show up in the raw trace record.

Keep the fixed-size trace record and use nodes_copy_and_extend() to copy
the runtime range and clear every remaining bit, including padding in
the last copied word.

Print only the runtime range.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/trace/events/sched.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f15..38a2a10cba42 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -793,8 +793,9 @@ TRACE_EVENT(sched_skip_cpuset_numa,
 		__entry->ngid		 = task_numa_group_id(tsk);
 		BUILD_BUG_ON(sizeof(nodemask_t) != \
 			     BITS_TO_LONGS(MAX_NUMNODES) * sizeof(long));
-		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
-		       sizeof(__entry->mem_allowed));
+		/* Clear unused bits in the fixed-size trace field. */
+		nodes_copy_and_extend(*(nodemask_t *)__entry->mem_allowed,
+				      *mem_allowed_ptr);
 	),
 
 	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
@@ -802,7 +803,7 @@ TRACE_EVENT(sched_skip_cpuset_numa,
 		  __entry->pid,
 		  __entry->tgid,
 		  __entry->ngid,
-		  MAX_NUMNODES, __entry->mem_allowed)
+		  nr_node_ids, __entry->mem_allowed)
 );
 #endif /* CONFIG_NUMA_BALANCING */
 
-- 
2.53.0

