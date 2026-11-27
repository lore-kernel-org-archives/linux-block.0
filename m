Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820506;
	b=GTAbmr050h+ObplO2E+L8oAnHSI9fvjAy7oYYTLSrUSjh0JgVdbQf5A/BwMERA8DEiDi
	 KDgp/4VsUx2KwwW69zhFIVSB6KGckGoGxZ5n2kB9XlDMbz4aBS0J2BxG3/o01hmAAAg5k
	 4sXPO7avuXhKtz6667L6mHYEpchteaALg92sJVkF+ILRe7K17lU+nRQ1HTm33PhKbKJru
	 n/L8lrY7AB8FPJT52cE6ZYgzur1d9ZNDLXMIvZV0D9XScnyHz+BPu555mUwF1UDimzdHj
	 LNlJN5uIWG14lJPloX1kgYhCmkWfeeKjhxJjwTzCIVINmrv64wXVGYRbrzJAuliArOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820506;
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
	bh=8j+fHuI7poAD4cKd6XZTXzwOJnU2Y5c5A/U1LAj+1K8=;
	b=nisZnFVPtdyhUp/M8sgskJylu8x7fE6DWavomxaeVq0APHkmohIrwj5v8TKyZ5/Dk71S
	 B1F57NKeMdCQqVr3SK+ADdzIXGwQ5EqbU7hZji6BssXd3sQsPtW0KxmEX3jfM77LIgoVP
	 wn67vERRCWlojUpQtNcmMYoy2eLHAEakhBWUG2QwvOjtgCh/Cx+Xuq06AeZk8uG4FDLAp
	 emZGmBZ/jStJuXAFmRw9/9+GaKg1CMcg8uJHEY3CeKykjYWv3fyoMIMFYI50/x/fQ5e13
	 XuNuOVmoHcTtem0wMxso6/Ev4HFNDmf3difugQ7aAGs/adWK6DF0cInPtFaa4ycSkAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LV146NSG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.48
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9773606A6BB;
	Fri, 27 Nov 2026 23:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9773606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LV146NSG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1sAUPDZ933EmM6neosA3tvDWX4atdMLRWhEyn4Ku0RxNmjvTmjswFdpGJRRFZO/43UKNIS3ePNPBBFmazf9Ebkc2P/T9FE1cgR9ZqW6GK+32gpg3O1nZc8BdmJ4g/BZV+CLMCqYual8KTe8tjR6L7HYGtM0yHlC0OgkZ4pzzFFKxjzf8qzOKc16RkJ2hYtR5ne63npOcrn4rwSZ6smAxmPO9HJ90WgONCdbroxn0PwxpVfxBQ4EaV4Dw1iWIN0WqQFAQwF3xUPUECNJUCSqMsC2GT+4KbK0LwqUyeEjOw0o/b6NRuFELwX1i43eczlt2+Y04kA7jayz4sez9anPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j+fHuI7poAD4cKd6XZTXzwOJnU2Y5c5A/U1LAj+1K8=;
 b=I3EEAGAR25QAkByOH6c7k1eTW0nEi42YIP5ndofGa1T7iYjcMHu43UBBsCocA6VO8gdbMlGiG/AH6ruPwGW/fjdVDgx543lpjQoi9j1P4xWzAp8i7CWy2l2NIqHhNH8KtmV5Yh4FV6fR3pm1+EzGDpneLCeMokVyDl5LS68s4C+YnuWIHjRwK06lZIUkT8Y3fdVF9aznCRJ8ZR1TgwkC21pBblGBY/ILZ8fq8QwU6vApjYt5ES98QhLXyU50qTDA5QgwmD7Dmg3LKThGGIvIhOy25dLSuft/1B6PojR80lS7ZC/g7FAcd5IKCiBoAsumZGBIQz0TaqctsSm6xu58wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j+fHuI7poAD4cKd6XZTXzwOJnU2Y5c5A/U1LAj+1K8=;
 b=LV146NSGHvvVYSGx199vVbi8YmKBZa4tQTlnOlW8GbiDwlVtINtWIhSpfaZo62svVwA2xdK9nYk9b3eIOIA86VXD32C20J8Td7SuWihWSY5RnDgqZVpkD/hShNzoUUuOKjmswPCI2WLSwEzkrHeMDf2hWkaTbLzQrTTVZgrSJQunoZ/XyB9M6M9jSfJpzR4xkNg591fzv1gvuvmklCOy5op+swCDD/X9vt+yL5BV4tkDDr0xbjI+nYVKK9ObvbmM7RGejJd1Y77cYthfzJaBo6CHbRJ/JGm0v5HC70rwtRfyZk/fLg5p0hFNz/Ba4yVlNve08OIYvDgJ2ncjGgAkZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:40 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:40 +0000
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
Subject: [PATCH 04/11] mm/mempolicy: preserve full-width userspace nodemasks
Date: Fri, 27 Nov 2026 18:01:21 -0500
Message-ID: <20261127230128.111933-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0667.namprd03.prod.outlook.com
 (2603:10b6:408:10e::12) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 62c80bd8-b2ee-4812-aafa-08df4cda65c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021135927099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|5023799004|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kkwSETioiCNN2qlPtjUUOFWHz5DclAuxyqxw0y9YG3Pbl55yVJUrOfv28yzULLx2Jv8bCk7o5TFW0l7I1Kh/0g1XfQpeY368gk7MJmYz/L+pgxl3drEm7tXsH9R45r8eK8Vdd85UASMsg4Cha7C1OqoUzV2l7gW5n/rmXkj7sbOWyiwaV9OulijLLtlt3fjch1vI2D0p/nNvEPlFaZZz85eCc7ybWDZ6DLaku2qLt/pms9mQuD4vEiAsn0oGQKKpZafpfd31uRD1pDv+X7CYAiEKxaKvFMbA6gIMqgI4ucfP7nJch0givCOEyUeBbiy59Zbny8RSruHXH8GtlQGc7mgbYRIhMsLsYehEeko8VJgxxWRM4rY1RRvF90ivks3URrRztQ9BLQpjKDWPWzVVI1NOGB/PakJaUfkQVMBfnDKvq7dv10uXVwhgb+u2iAtm93DV1RmttLp6GniRRxYt1ZqiKGk7m3Yv172UbduvggxlJ0hxRVpKpFg1BxA1kDA90qwcTxIkruYvgCLVBeNjUfu8Xt14WM7qnpQb3XpITW4HouEG3U+OEl8b6beaJk1B5Eior5s3BUoTpaLkDMFlWvG0Qao8iYK8WJ85MCaIVKHZLaQasWdIencdDHwW47DBrKhpNY4KOrJ83YgSMLeRkqlG/+I4PPUr50+OHRysNyy3bkwD4FherobmZNiqSPUyCDpnnzZWLeV7op6NWgqsNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZxfP7xtyYH7kCTVh5rlgrNnMrqmu/2rvO3Q82gwdvs6oCXsf4Mfq1EdZtdJ?=
 =?us-ascii?Q?OQ/NeQl2WFoSFt8NnpMUKXXrwsVapzHR8bVfytpGuU+CZyO5BegddjJi5p4a?=
 =?us-ascii?Q?6ppM+wVLwthjfrG5dhCKIKCLdR/GT2cITY2ZHN/aFCVx/sjL7Jb4FzA7JlNm?=
 =?us-ascii?Q?kHlszKNKzxt2vgWNdpehuDH00O50C+zBdi4Os/m0YZiwublG/tRacvoPiLug?=
 =?us-ascii?Q?Cnsu4qJbjXA5wEjR2H31ecQaDAfB3TWQS1VWJbVyWMzM3rxvYjruJvbdo/Dh?=
 =?us-ascii?Q?HHTeif2gWfhfj6jtOZixHABkSKnT2eDRTTU8U9M1pK9ERgaWlDo/JfW5D1Hy?=
 =?us-ascii?Q?XUhhvdijxWjjONDSO4PNOi5Id4Bm7EWcV8MUBrQE/tkp3qWix37GzPZVafWD?=
 =?us-ascii?Q?xeVnOR6mTTTMiyYe1NaE8jSxBxjKoG7u9i20w17t+/TNxotB2CTvoQrjUYWP?=
 =?us-ascii?Q?iFRgeeuxgm8+ia4JWG8iuWLUt8nJd53QGTbTMd6tWR9g6198zwmjPVdCXELI?=
 =?us-ascii?Q?r+a2r2Tv9+qP9ivAmFgxayLachH2Ty1X9tOEsq2bgOVFyzjXPONhzsg62L5t?=
 =?us-ascii?Q?MOlroQXW6WWOnq/FnpROXgImjaPDFCyPC6mWqldw4hyX3eZ9PcJkJpP8fWY2?=
 =?us-ascii?Q?MOlbG8szXak4zYcH2kYSp9L61QLyZ68MQIF/zR8wl87C32XByD3Lyi0W/osa?=
 =?us-ascii?Q?lsOGNg71bNQOgMdBc8D4DHxJb296N16AwPu8Qsg/CJviqWw+f2s5VadfZ4ll?=
 =?us-ascii?Q?hi5UCF5x7csGQQw5iyGxQRYm0QvW3NyWkEid8l9TfO2w6OcUfSz+oggarYAE?=
 =?us-ascii?Q?m8nvx7z37ouobDm65OBcHRAmfP0Y1HW54mEIMkkuAr/gBhp+pg5iLR34L8gW?=
 =?us-ascii?Q?TbJHl8h7Ds/zAOOSsRuiVOIXswUblpOep6efriWEvaekDv6nCopndFsAiwvI?=
 =?us-ascii?Q?rdp+uImYYakxOg8EgmMOqzSs885PpeQpG6lIrNfgnh3VNhsfxk8NHHpHqzRy?=
 =?us-ascii?Q?6Exz6vM2eZIfh8g9nYqDnN5pOL4xRZ1OVEX01c9b6FW78v71VGTYDzyY/tn3?=
 =?us-ascii?Q?Y5ejUwFEbyu5Wmb/ipMppCEBQFO6yRTJrBLdn4KuxaeRGAfnHAhC8RjSMvSF?=
 =?us-ascii?Q?EVW+9mZc75OaT3F5BOXKEfWI5e1vfrQ2xeq4tR0Ljf8bys5fh5wxWfqFDVSR?=
 =?us-ascii?Q?DuBX8YaX5aUdTkyhEPnDOqD41miyAyE0EktUN7Zj/NXZpzrGw/nCQZ9Wt2Qv?=
 =?us-ascii?Q?BB+sirYsNudAPr0ZYCPsVL6GXwbnPy5/pJN/2qhm6ppYmauTMAuJSYVLdenM?=
 =?us-ascii?Q?pAdXbMuWrQAgjux8fI6Kdh+TBmrESkrSBs7pHPGZvP7ukDMOLd0MiQfg1GHz?=
 =?us-ascii?Q?nwbUFmMAfEcaMyNKMvhCNdnsxY9zNYjjfo83hGB1i+s+9nhZTgWv14gqjct6?=
 =?us-ascii?Q?W9oMeoV0pQAoCvnYlKwKNmSzgSi7XZr2O3J6zD413sGwsD/AFSn6jqvvXKAk?=
 =?us-ascii?Q?MH2UH8DJXG290F8RDt4q/2tOjc8wG+YYNR0BwraEf6RMGOCMNgmegm8TnCyG?=
 =?us-ascii?Q?hUdZWw5UdcBmSqO5OO8mxaSFEuKFbodtOEU7IR9pJz6zCWQFM3/wOfU6YI4V?=
 =?us-ascii?Q?CYHPVL4Z5exWMmr7DpuLmNdob6cCngXlU4yUZc8ZIgb5VfUq7q+fR4fEJuFp?=
 =?us-ascii?Q?xAUU2c3NWZ7Obv0wcKANmjcI2ESOTDb5esZ40toC1uZrWu9nFa82Q6CaGgKE?=
 =?us-ascii?Q?Vy0h4geGVoHC0zm/gVn6mgY3G17HjhUXT7frk9O86JNAFSk2AvOm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c80bd8-b2ee-4812-aafa-08df4cda65c3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:40.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mAAji5+jkgunQ889MPj8+fQq3saYBI2VJQ4O3sCtheNlK4s+Gk0SyJ7xn9ccqY7b6Y1Kl70XuzAPA5gOcFtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

This series switches nodemask API to runtime nr_node_ids.

Userspace mempolicy masks can contain static node IDs or relative
indices above nr_node_ids. They must retain their full MAX_NUMNODES
width when the nodemask helpers switch to runtime bounds.

For example, with MAX_NUMNODES=1024, nr_node_ids=2 and allowed
memory nodes {0,1},

       set_mempolicy(MPOL_BIND | MPOL_F_RELATIVE_NODES, ...)

can specify a mask containing only bit 3. This is a relative
index: folding it modulo the two allowed nodes maps it to node 1.

A runtime-bounded emptiness check would reject this valid mask,
and a runtime-bounded fold would discard its only set bit.

Use underscored nodemask API with an explicit MAX_NUMNODES bound where
needed.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 mm/mempolicy.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 67e258c62527..ed8b20b27753 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -396,7 +396,10 @@ static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
 				   const nodemask_t *rel)
 {
 	nodemask_t tmp;
-	nodes_fold(tmp, *orig, nodes_weight(*rel));
+
+	/* Relative indices can exceed the runtime node ID limit. */
+	__nodes_fold(&tmp, orig, nodes_weight(*rel), MAX_NUMNODES);
+
 	nodes_onto(*ret, tmp, *rel);
 }
 
@@ -462,14 +465,16 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 /*
  * This function just creates a new policy, does some check and simple
  * initialization. You must invoke mpol_set_nodemask() to set nodes.
+ * Input masks can include static IDs or relative indices above nr_node_ids.
  */
 static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 				  nodemask_t *nodes)
 {
 	struct mempolicy *policy;
+	bool empty = !nodes || __nodes_empty(nodes, MAX_NUMNODES);
 
 	if (mode == MPOL_DEFAULT) {
-		if (nodes && !nodes_empty(*nodes))
+		if (!empty)
 			return ERR_PTR(-EINVAL);
 		return NULL;
 	}
@@ -481,7 +486,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	 * All other modes require a valid pointer to a non-empty nodemask.
 	 */
 	if (mode == MPOL_PREFERRED) {
-		if (nodes_empty(*nodes)) {
+		if (empty) {
 			if (((flags & MPOL_F_STATIC_NODES) ||
 			     (flags & MPOL_F_RELATIVE_NODES)))
 				return ERR_PTR(-EINVAL);
@@ -489,11 +494,11 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 			mode = MPOL_LOCAL;
 		}
 	} else if (mode == MPOL_LOCAL) {
-		if (!nodes_empty(*nodes) ||
+		if (!empty ||
 		    (flags & MPOL_F_STATIC_NODES) ||
 		    (flags & MPOL_F_RELATIVE_NODES))
 			return ERR_PTR(-EINVAL);
-	} else if (nodes_empty(*nodes))
+	} else if (empty)
 		return ERR_PTR(-EINVAL);
 
 	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
@@ -1685,7 +1690,8 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		     unsigned long maxnode)
 {
 	--maxnode;
-	nodes_clear(*nodes);
+	/* Userspace masks retain their full MAX_NUMNODES capacity. */
+	__nodes_clear(nodes, MAX_NUMNODES);
 	if (maxnode == 0 || !nmask)
 		return 0;
 	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
@@ -1940,7 +1946,9 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 
 	task_nodes = cpuset_mems_allowed(task);
 	/* Is the user allowed to access the target nodes? */
-	if (!nodes_subset(*new, task_nodes) && !capable(CAP_SYS_NICE)) {
+	if ((!nodes_subset(*new, task_nodes) ||
+	     __next_node(nr_node_ids - 1, new, MAX_NUMNODES) < MAX_NUMNODES) &&
+	    !capable(CAP_SYS_NICE)) {
 		err = -EPERM;
 		goto out_put;
 	}
@@ -2902,7 +2910,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	if (a->home_node != b->home_node)
 		return false;
 	if (mpol_store_user_nodemask(a))
-		if (!nodes_equal(a->w.user_nodemask, b->w.user_nodemask))
+		if (!__nodes_equal(&a->w.user_nodemask, &b->w.user_nodemask,
+				   MAX_NUMNODES))
 			return false;
 
 	switch (a->mode) {
@@ -3381,7 +3390,7 @@ static inline void __init check_numabalancing_enable(void)
 
 void __init numa_policy_init(void)
 {
-	nodemask_t interleave_nodes;
+	nodemask_t interleave_nodes = NODE_MASK_NONE;
 	unsigned long largest = 0;
 	int nid, prefer = 0;
 
@@ -3467,7 +3476,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
 	struct mempolicy *new = NULL;
 	unsigned short mode_flags;
-	nodemask_t nodes;
+	nodemask_t nodes = NODE_MASK_NONE;
 	char *nodelist = strchr(str, ':');
 	char *flags = strchr(str, '=');
 	int err = 1, mode;
-- 
2.53.0

