Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820497;
	b=J6VOYD0we/1Iguwylg2eMibpknSETwN3lMS4mjlUEN25eD65xv7zBUXzZBcAnzx/+2b0
	 fZuUF8BBmAU6bmR7TrUQliebwpLF+fFlMkFQhuM9x+WueNzgEqpZsoOd2X6S4bmcqEAZf
	 nmSUZX/YSYVXlBQ3yga4Sr0V+vDm88HrcR8XP9X7z0dDWakt0ENt0rz/om0OBjD3cpghh
	 oQ/B9Wgy0fPARUSljqpdbG0CuhOlVTgdVWgdnBRVGjCLPkM5oOCA38zrJYBIXw8QNXKnr
	 qVlrcwLNS2LIYwVZT2NKoNmIGNBYNlPtSuosCa5UUMDyGWUAORYey7lZgeNRY1353HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820497;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sbZ378tAoi2FUF1xupjieQK7Xhu0KLqLD4MvWDVJOuc=;
	b=TTtMD3nBNrYbE3f4XW1H0e4+qA6+GNtsnmKJ1Thqmv8xst54pfI1A+txo6m3zgcv5jZ6
	 9AJSdN4w1YX3NDTd5FD88b8WU0aOn7hUut7oxhMttF5FEJoEv2LQfF+DDWlZrLgn/n3de
	 bGtMqbwBXaTZKQP8NioENWRoAH0drjpPulOcWNjmcHQUhhmnTkAUIicjFfbli4i0nPkUf
	 ZqirCVeyXQ8Bx1e6G/B3zqAAQviIUqcRYwfhRiE07YoPi40RBN6Vh5s3GjqvapYYixsVg
	 otyMmRdwRyrU7KjZybXii6TPOAuG5V8s7YOFBzwmVaKFEIrYGj0bN18qW/gJzgDjlbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fsZOy3Y+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.66
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB59606A31C;
	Fri, 27 Nov 2026 23:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fsZOy3Y+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TILDMQLQ8uM38Xszyeo6JMzPc06Z/8LkdG4+q+SLVdrgRIO9YR73SWv6EkWKjk7O+FawijRKZEfF5jPD/wUQLzNm7RW/1bHmT1LRRbB60qxRrQlp6YMVX2LDP4X1DIYB5L0FZtDHXMGEhLOUriTC4QUC3rA+CbN5PAPMH8zW9eX5WsTG9yVRb2j5hi9zRGo540V5yXyUmtyAVYXHlXTIlgqTzdGs92d3t0ifC1DKWuepyzrLyDsSwTN2YiQ9+ayGMRzxgNIK6uIpiMCbsx8mPkxY3XEluM797ly6c+aOPgzT/P/eSxCFYx5RMKUikQn05lHOMVZqpHAxYXjT6G7DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbZ378tAoi2FUF1xupjieQK7Xhu0KLqLD4MvWDVJOuc=;
 b=DKl2WfcVcAeiaM4NqKMqIuzXw70CVc6NSzZm1W4eFX1P+6LowYoR1I9nzlCA1iqI1eIe/3nTP1HVXFWwfpNEO7NMVyUY8bQdcgA+j4zpZPE+y8VeBn0WsttO75vy+5YR//aW/Ft2plhkuvZEee4SPY4743ankJAOmMBpH2YN/oaTak3uLDaTToNnUlhF3PeFrQ+2ZNFqrBPLmrDPO2S1Yq6EWlED0qwBOIvzE4REAINvzvM6X1TLXnD8XAjC757Xiitwr7V9TMDYmVV57qCj93DzTFpwrF8YJZVRwQ5kG0bKiq/0BNd5ep9s07YPqXoNjfYuDHN7Ay+yzFc1KUwjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbZ378tAoi2FUF1xupjieQK7Xhu0KLqLD4MvWDVJOuc=;
 b=fsZOy3Y+wavW0IOnIpo2fXdfyY3efpNdZjVYzpDdWqsziY+RgAd9JUrgi1BBC0iPRQnfhAvSuLCYC0zlCmsjZTRpTqIjWpnDE+MjN1/vJ1/aQr7ufCXdUuEGRL/AWBhDR51T9V9T9WOf4hdL3vAhZ8wjYntYI0UIGjAPuwJhsYrNGGAjL1oWzXbCO38E3Dwc/6iEy7UlbI4WT4TAWeLhMhfcfc6g0o8nyX9f4eSpygA0fddV3+YJuOZZi0vULpON/8r3DfHTMxJmL2yEMfTbhPTddtCLHVpDDENPHFQShuh6whBG8rypH+8yEpx3RYj/j9jzOo0J5Vtjt6hHTjwHWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:32 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:31 +0000
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
Subject: [PATCH 00/11] nodemask: switch to runtime nr_node_ids
Date: Fri, 27 Nov 2026 18:01:17 -0500
Message-ID: <20261127230128.111933-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0605.namprd03.prod.outlook.com
 (2603:10b6:408:106::10) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3aacc3fa-e796-4fbe-29c6-08df4cda601e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	viNvRmmBNyRbFaxrjDEGZ+mmwXnOMtKmPNTWubRlAJkk79qJ5o1DwJcBH82lvw3s7WUonCFyjHI1YPyh/DxzO+eBcIgy6tVIi7Czv5wojWRqMBuwJKKI/fwgdOpeINKZ6At1UxomZE6z8+skBxX7y+yNTHNVFjrNSUCYL+2jk/SWqpFTIifxashdWuEP27Y2skmv/WB7NYbk8V/lrBdYf4OcaAa5CR5T58VgEAMWqG/Q3RO9YN8DAca9FuDjJt8i63fwq1geo7UEvmp8RNpcoTE4ZMn74tnVPgQCUcFsRMpHErZAtHuW0i4phFeriR0gnKBZ6AmrqIRm3rSRovNB/uRIeKdLgTYnoWcA5Mw7YN9WbytVMagaK94bgZ/ypgpgHwG3HR02sAMqQFOVmu+xMhL54gc3uxa1SGpPUliRZktDnE5tnxhuynn9t2Ms80BCKV/ye9P2LRVda12FM0WAUFM9wsQy6m0m5aP7DZn72U7C6VISkCETLCMBsJZpeK1BG/9Hnk7KlACB3uAnVQEwnl8k1VAK6HFhrxZh/wHZeBy7q4rR/dgCZC8tuZWhNitXtY7IJWWWBr8WisOYG2dW8OdHd2D5OUEXbF2w7v4iYcWK0Sup3Tz+CPvql4k2zmXy7cknhgAZVN2Q7WZeZq1Lsz2o6ok6XbZen8Lk+LdygUpVn79YxYQnDNlnJcU7+y3xYMvZZI5Ym6tnDocURhofqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JG6uxaQO/BYOx0yqEclkqPBz5Rjtq57sxlhlf3+mVThpapC8j88igUxCceSM?=
 =?us-ascii?Q?/iOonaQWQ3wYGSih8oFCk/ZKJ2rzFVI7SmkMTp94lWSO7JpEQLILqvRHT/d/?=
 =?us-ascii?Q?mPE1h4AAw10DRK7tzyd5WzvY4va4RKka32dYo/jFmQ3adjZWi2nCna+muPuW?=
 =?us-ascii?Q?ta0VEQfbK4NM2nofFz2r6j+o80H+XAGWpv3VkYo3uNoJtv20NlQHzUgD/1Ri?=
 =?us-ascii?Q?8HpK86qZ4+aU1+/pSGWYsYQIFyNfzDAYMYfRFNyeswTIwcbU/4kHckDEABA8?=
 =?us-ascii?Q?kVs23EHoETajMeSqSZbDuOeVNafdNOqJazJya+fB/gZkS5ll8FsTEcVQRHvw?=
 =?us-ascii?Q?cOdaUdX0u6Sr0jFDOr8M1evZvWZDRstUp96utXQYOUMZFUABcldWGVQq0KzF?=
 =?us-ascii?Q?aXHTKvdHtYhxMBVN+bkf9YBux6PMa7xiN60kEufjbOnT3bqFpgBMsqP+EHJN?=
 =?us-ascii?Q?yxLl21/iDoRFculfUfDNChRKOUNPqxgZZwF6f5wooOyWImsJS/iUR1xoNKwf?=
 =?us-ascii?Q?TapsDcoG9aTN0fvRWPdHDscPW1whKuDH9ojyzJiiEo0FprvCH+g/tVOXfbSu?=
 =?us-ascii?Q?A9qdfKf8pqn9dIhzZiYB26MjXozXBhhcdcl0jy4SrItIwdmetp1LOKLyi2e2?=
 =?us-ascii?Q?S2hDqs/Awlm2hlwkEQrNITeXKHPj+2dINHk04mQnSY3l/QLWKchdwtG9BHD4?=
 =?us-ascii?Q?VgzRvBorv7f3707aFSHp+loo5m4JDuYda8mS+LcVCf8dmRTsBEhgJp9in7jf?=
 =?us-ascii?Q?D6MfzDt0utxvKfgS8AnHgm1F3hkf2z0ybBJRIOE1r/8yFLXWKq2r/rL+DKxT?=
 =?us-ascii?Q?LlZOImoJ82CMvnwSgb2+SSweeAAXmwheAYHN8KuujulX+dsp4gxVlaDlsfUo?=
 =?us-ascii?Q?teXUHZxwiESs+IZHQdO06uAgG+oEnhIjw6il9m9JBnxWHgr7wFo3kH8yfTsf?=
 =?us-ascii?Q?IxemFafvRUg3Ypc63hXtaESzE0KJ+mLsSFHSNdvDdQym5aMyhnI3w2Jxc4nR?=
 =?us-ascii?Q?04ceCffFsdXg5uWfQB1a0D9tOmxJNc7TeH0TcASZGSrt2HcZgtU0X1//J+p6?=
 =?us-ascii?Q?F+sWW0FVC82+q/4P+UP4haiVngHnikRnEeGjxtxzNhLp56TSfaNtUDLJGR1P?=
 =?us-ascii?Q?tmzb734sXjpi9oPCgIUcv34CcXLVsGX+uMRGziPwtu/8PoFM+iiS2dY4JEWW?=
 =?us-ascii?Q?Hd2w0N5mz5sOvnWLvApRXAQ1dhggISR5F8u6dSMurd4iiP+Pt8eIiZ0Ln8xW?=
 =?us-ascii?Q?rfvA2vIBKD/LqINMJs3SSQ3cPgcBhkusddYBjnfmfmfJ6HHyYWYkQtL7D2ly?=
 =?us-ascii?Q?9w08meY2GWiqaZIcvGZ5H7i33Dh8GNnsZAv1GiDV1TXu4N4XtbuAl3I64v5X?=
 =?us-ascii?Q?pXWUlVMZA23+mBGUf0H3b4FGBmhURevNp2ycsgDLYMajouy9i2KFesAkTjQF?=
 =?us-ascii?Q?lwJWCpBoZc2ijWBPSM8CMYpIQXhfYMwmq2S5Y/wIM/sjNg9AP1aAH9jqwl5e?=
 =?us-ascii?Q?DRM6WCbexfie2eSaCUIWWzYvDJtxewRXCzoX4fhvsC7JbF2K9ZZQzzUFYhhB?=
 =?us-ascii?Q?IVKsDOwt27lu6guki0QN5BopbYpf8p0lAFV0BBjHEYYUOh+wzmPIiCQn0+38?=
 =?us-ascii?Q?HhnSRIjYwoUxXgoG55dEwA/dCxclDTovSxJEg6RA13c+BLncBBA0ETLtMYHJ?=
 =?us-ascii?Q?oai+LPNoyRZtJ/merxTxNwM2n86ohjYpIZpEcHGcdhDqoL4sFV/P5mrGXCXs?=
 =?us-ascii?Q?ugvu7NdMumZSgI1iLvGfYFVmj0n14nFmuukRsEAUEqVDTm7Nfnr3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aacc3fa-e796-4fbe-29c6-08df4cda601e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:31.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhDbCocEeFRvnnBtIaykbsQhxfZpkXz/s61vy+0owoz/4ZeSpAG39cHvmM9YrMN/WiBnoThg6sPAxx8oEb5S8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Nodemasks have a compile-time capacity of MAX_NUMNODES, and
nr_node_ids describes the runtime node ID usage.

Modern distros, like my Ubuntu, default MAX_NUMNODES to 1024, while the
actual number of nodes is typically smaller. All nodemask functions
currently refer to the MAX_NUMNODES, which adds a substantial overhead
on every traversing operation.

This series switches the kernel to runtime length of nodemasks, which
also saves up to 8K of .text for minimal config, and accelerates basic
nodemask operations ~4x if MAX_NUMNODES == 1024 and nr_node_ids == 2.

Yury Norov (11):
  nodemask: add 'small' and 'large' compile-time sizes
  nodemask: pass nodemask length to node search functions
  mm/mempolicy: reject migrate_pages source IDs beyond nr_node_ids
  mm/mempolicy: preserve full-width userspace nodemasks
  mm: switch to runtime nodemask length
  MIPS: IP27: switch nmi_dump to runtime nodemask length
  ACPI: NUMA: switch acpi_map_pxm_to_node to runtime nodemask length
  mtip32xx: switch next_online_node() to runtime nodemask length
  nodemask: add nodes_copy_and_extend()
  sched/numa: bound cpuset trace masks by nr_node_ids
  nodemask: add cpumask-style operation size bounds

 arch/mips/sgi-ip27/ip27-nmi.c     |   2 +-
 drivers/acpi/numa/srat.c          |   2 +-
 drivers/block/mtip32xx/mtip32xx.c |   2 +-
 include/linux/nodemask.h          | 122 +++++++++++++++++++-----------
 include/trace/events/sched.h      |   7 +-
 mm/hugetlb_internal.h             |   2 +-
 mm/mempolicy.c                    |  55 +++++++++-----
 mm/mmzone.c                       |   2 +-
 mm/vmscan.c                       |   2 +-
 9 files changed, 123 insertions(+), 73 deletions(-)

-- 
2.53.0

