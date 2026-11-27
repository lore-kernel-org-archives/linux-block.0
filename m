Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820500;
	b=T8UN1qomhFC1vA/gzECPWpfj32Gykv6m4qD5o+F6kxj48qea7iloEtTakbs8DHdT7EVm
	 A5VY/NaAmOb3rikjZbAMBzcDMCaRTrArSlZVvFXe8A9kJ7R8L9dWqS0soMNTOyfoOl6Rs
	 Pj8K5v2Qxl8nccEusCvlGrwxU2/9qil69Q59fjqNHIXjMNG5T8YcpQDMs+9wkFa8UCqgi
	 gJdbQDdTPWSP9YYPWVzaVE7+80iF/sn0YqdiPJV3u3y5qDpMAIyImTHq08ijkOk8VnZ8j
	 9tq+oi03iVjar19Ypg0rWbYdBF0y1O+t4WfEMvIeHndKJFqs0VObgoI7FJpjeJMBV2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820500;
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
	bh=0Nkfh7aFSH4dYG9fbf2t6iHTBDBqn9Q5pE7e4HQM0bw=;
	b=DBtrgEFaH3ZS7UZ/c0OfLFSncfKTl85wG7isGgEXiA+7yi7/P2K41iJBzDaLuizwq6Mq
	 VceJrsq0HgkCGPHe7Pc635/uO2Gt2bjVdrQv/v7JSGLIZlKWuVLbz7Oh3eHyWp/TZSOP8
	 1OMPjxv9KyJh69Y3WDFIFhE5oUZa6r6VhW8Fu53L/HHiuYJlkWYIWx/lyQ0sAXShc1+oq
	 pjgBvaUyBqFjwR/cm2J3nyf1yy0cIYD6KWl0/UkOUYPusunfGn1ua40OZwoaGsiB/f2ks
	 qNkxeg1CqxF+6JUEFvduGNL5EkCthckQxcUj2OYolfC7R0pf/7EeqL1WHvOEGaFJxJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iZqi7Bcv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.55
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F088606A336;
	Fri, 27 Nov 2026 23:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F088606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iZqi7Bcv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZNCXf1hLFGxtJcvSJiHJbIWSGripTKXE8nFed0znORuz2XJB7YGn5O4tO9RNYcUF/oevF9DxUYYGomW5l/wfut64RBqMhcicTODXGscwf1pHZZ+os+AJDGSBoamtK7EeEnwuGsGaKrsFkfDHqArrBRttcfiBZojvbWqAkNzyRtbqDYa1iSl2fkqGYvwuB5iAI3oUah3UlzIKlyIcO8bUBFzC3ajpkiwN+uENobWPwagkcp00WJiQDlyQrqs8WhH16pNnqdPK/Srs826InpfhHP6hLQBvnJQPQJSKZkGIm4JEAVqJJzFktGR39bZ+cbU8c3DAWdliTAY6L7FsobRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nkfh7aFSH4dYG9fbf2t6iHTBDBqn9Q5pE7e4HQM0bw=;
 b=pTK0OhWefMNZuuaBHk6qLgp6cliw+F2lzwx48Yt7n7inDmCJsPyj4KmGl4yM5eJ+1A89Wd27f6O1K/ZtiuYu8xTe0AH1J2loUHkK6909/Hlykvd6TYpnY13OlYXVWNgYxkQNrs/UYM2y6Z4i5Ba/+MFYHfgmJbmsZreLsu87WH8R/bD9iI3XRjWyKFWnqUuNY2B9PP964lw/PUKotEMQ3tShUD21KoRk+1x3kxu3puM+0mwwPhUkgJk6kIgrPBKVOsuwRyfXfwXlcaSB3zGJVvPUBVmC8MF4dOH50+QOwZu+u1/StnkqMYc/cfT0kuwvupbp9dWj5iU+z3ZVraAN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nkfh7aFSH4dYG9fbf2t6iHTBDBqn9Q5pE7e4HQM0bw=;
 b=iZqi7BcvtxVYQ4caVOESgelR5MdLVgfssDCsBzCZ3yLF87+1uR/5rh/RWBDrIFiSXwUzM8llgvOOWfonzfOu4A3J9E+hm0u2Um8crrNVxniEfv8xK22V5GzZDcgW8gXhM1o7iJ1M8iaEqjoLDK6XfJoDY2JZOB+IUU19k9h6LzslHRKaMesPE46BIJFYPcdLhjUSpSvfdEcMVxOEns7Rr34ljimtEvRDeZ/Q883Ikr2t38XN6PfexAvFhr401OKWH2+kV0EmAXWjZSFMXLWWrWpW8tJ5E6zzii/7MeMJ1CjzInSZzfPNovBKEz2r0o/IXA1yMtjTha+FYnmQFhFOUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:36 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:36 +0000
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
Subject: [PATCH 02/11] nodemask: pass nodemask length to node search functions
Date: Fri, 27 Nov 2026 18:01:19 -0500
Message-ID: <20261127230128.111933-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:208:32e::21) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ffdbb042-f055-4273-4eb3-08df4cda635d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	uxGYiZhoHQ7QY4+WfEdzAIlOFuMWe5oq4sQsfQJj9RecuTmNl7dq95GmdwWVR7sZn0jyw5HG7iAZLTAUoTl4zNyIDK3883dS7Q+aszQp2hdC0c2dTSs+ADDCgUZWRqVD1vSoxyR7A2Wr0ItSpW877GQ/b+ig6VAtHU6U7vovl8zol9Cc8dcLDuvc+U3F3PrIfiCZTwnyvqLh5Q4TwCagpR4a8E56Otz8AgJbOKSSampTvWzdu6falCL7aNtrnHxDO1vSgiN7RWsuEGNnw7+IMT62qRHIGbJtaCazD/GTU7EPfzRZ+etxDhbFcm77FLWYZ2zVYszXZoKSgoO2C5OkreqXu6dODGejOpHSNi2ePP53nQOff3P/iLmf5m6ji3hW8/i/BcVeBgwIh+m1JPsZnPyR4uAROAPjCTUmNiV+ZzdQ9ZG+Zj0VJ4xwO1T4hFPMhIW/Dtyx2pTMHl/q3ZFdLUiiHvpVt3rAo4FIsGI3E8TwYVB6ZlK+9CLNQPEH5ITSbiLZuls7U9WO4jnP9JjfanGiRuGMHT/jJEzBKnwAaREwUotNTcHiqeA+R+oaYS/KYrELCANcz+WrNSnZgLiNoN9qw0WRfCOowMWg6Ov+2qe3+hbYpwd7trvkytKeuTO6L2Rv5sj1u5oQuoTkO6eqQ7wT4BmGWft069Q/krFn/ufAWEYO1froa7pV1g2U1Ubzw+/IXv22RQYisvvc2y8bag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CpItdEPhlcYzmUogVFjK72qyvujCihvO60LqfUoVq1hBihsh7txDqX/FzYv?=
 =?us-ascii?Q?mYRqtjh0XmRPMIY0l9xW/GpP63fQdQAA/xPxSMPuWuFF2MBhJxqp87sWMlIb?=
 =?us-ascii?Q?m/j2KhJ5w+poyiGb7iXGn7fveadDcj9+NZfhKrhUvyf/pl4RBu7uKMivSMLD?=
 =?us-ascii?Q?zQRYZ66CjXqLlPyvkzpmvDDZ6HOas/ytwFPlNsKPNHLDsl1OCEwRMlMNk9JI?=
 =?us-ascii?Q?Lq+a6eGk/j0Cp1AdkiZUbzI1LWTKlHwKQHEEO6ckrY88CKOURcWltWIXVEoA?=
 =?us-ascii?Q?vot4VJd317JIIXp0ijKXCYu79KD+QvnDj0b8kIfm6YrIcdSTX8KGdjteCE2F?=
 =?us-ascii?Q?iDkiBc+/neQ+U7YjPjcRaDr/HgKMM/MH+8EiXe60yz+eBW0L/YFdyaklJTa8?=
 =?us-ascii?Q?9q0+Hq/ui+dOWvKnk/KPJ1LzAPT5NqKNDE4IlnqZ7UFWjFQnIhvQifxZctyW?=
 =?us-ascii?Q?814Z3xPvErLbgk0aR8X6MkorAg7Jk8spqYqISC8yH3VMeYu/0AWlaNchILNe?=
 =?us-ascii?Q?qpoEJwTz26cAQQtFwhlxpCkBzGKA9W7/O+id+YFDPVktBC38LivZMy9RImKP?=
 =?us-ascii?Q?rIZnMzMsJa/K+nTM4upuXt33yL041v9X7Src2e01jNjFtZ4Y9zxFdG1F9QT1?=
 =?us-ascii?Q?5VrWehFnKLMQ8eRK1d4faQvkGAk9+/T9nJdyWBFBt9aG8qpFAa9aoyfIld0t?=
 =?us-ascii?Q?D4NpAW/kEKcCwcyQQIPAntoog85bkHhoamZ9CekdI7ky1qDCl4d3n38NJMon?=
 =?us-ascii?Q?R2jq+msQVZERkcb8y44zQT24ie2NhGguaUf43uN3hIuHp6I1+WdtSVnXFEIM?=
 =?us-ascii?Q?z7gurrgyapGBmBgDF+cdtZ3MpH/1ix/aT4gCygoSdH/sfMcmH5AB4wyQbfN7?=
 =?us-ascii?Q?oAnWsU8Csnok+hAWA/0Y1y8e009UXgtDQgy4/FZD/bRnewd47Spxq7jY2XlI?=
 =?us-ascii?Q?PedWInTLFZMZ+SToIXr7Fb8TcrLlMJmQgvbLj6bAFiNm5lMevJlbo/f7t03K?=
 =?us-ascii?Q?mqz6LvX6Wic1LVsjEa3L7I+Jo6fzWCblIPMjFoKSkJkUq61nTfdnq3okBWNv?=
 =?us-ascii?Q?B1k+mrMf4YOEhbPMT3VJdQIslOn37j4rh327Eo/6hzxUh3Udy1Elm22etmS1?=
 =?us-ascii?Q?euKUKwKQ/AIdHv+Ja+WzgxI2YFI0B7504zs6+iMRGcQ0WB9agu5VrwdDph5s?=
 =?us-ascii?Q?hl07gMSZ9LX5AWXFQ2/KVSZOzyawed5nbyHlT8LhvdlD+Ekjd90SQqsgqa1B?=
 =?us-ascii?Q?Sn1vi1rlt/6R8DHS/KAGgyXPglmJNi/8iSqV86bQ+KqhVz+tL/eiulV+JQ5C?=
 =?us-ascii?Q?xwblNcjZuVdAM9JXskhpcwgIHxawftOjBNTsGzSM/Op0LO/+fOTcn3ZhzJJ2?=
 =?us-ascii?Q?Iub7C6Tp182Scm9h+XlaqcRnmti5jhPOWbATjEw+N+BgWuREPb8KhqU+CVyM?=
 =?us-ascii?Q?fjkxMgl8t9v/nnO7tKO/pqt5IitkrQrrUJ2YSFxq0A5EwOGnMolr755jBITR?=
 =?us-ascii?Q?NUXz0PclGclmaiAqOw+XwWVF5y1kzLGDlnJsWufgP7HpaqwD2HJlfeCD9iDQ?=
 =?us-ascii?Q?IWRzQiVbfFKL9UcM6JG+gn0mxpF4JM6UIauzFWVC/su1mc0VCiAEf8siPMFR?=
 =?us-ascii?Q?r7321T6XsGdgDu2gBEeY73fZZbed+pWgnQjigkCFlo2uZVcIe05e9YMc4r9T?=
 =?us-ascii?Q?R/cW9cV/53cRZRKkt+BRXbMMY459rUqT3TqPtR0mQtQEM6V6fPT9NzsmGjjX?=
 =?us-ascii?Q?pbqC/cmhm7ZpLIxE0q6r61P7bw54dtrHyFXN1YORd7HV3LhhSqFP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdbb042-f055-4273-4eb3-08df4cda635d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:36.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAeXmPz+cQS6uw5DzAhwoVD9AE6fFsvdAE111XbGjJ2B3y6t7ToRfsnlYQREx6LmHROL2kUqen3unuNp0+uN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Contrary to other underscored nodemask functions, search API doesn't
take the length of nodemask. This series switches the kernel to runtime
nr_node_ids, and where the MAX_NUMNODES is required, the caller would
need to pass it explicitly.

Add the length argument to __first_node(), __next_node() and
__next_node_in().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/nodemask.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 37fd5ac957c0..a17aa5c2e562 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -271,29 +271,32 @@ static __always_inline int __nodes_weight(const nodemask_t *srcp, unsigned int n
 /* FIXME: better would be to fix all architectures to never return
           > MAX_NUMNODES, then the silly min()s could be dropped. */
 
-#define first_node(src) __first_node(&(src))
-static __always_inline unsigned int __first_node(const nodemask_t *srcp)
+#define first_node(src) __first_node(&(src), MAX_NUMNODES)
+static __always_inline unsigned int __first_node(const nodemask_t *srcp,
+						unsigned int nbits)
 {
-	return min(MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
+	return min(nbits, find_first_bit(srcp->bits, nbits));
 }
 
-#define next_node(n, src) __next_node((n), &(src))
-static __always_inline unsigned int __next_node(int n, const nodemask_t *srcp)
+#define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
+static __always_inline unsigned int __next_node(int n, const nodemask_t *srcp,
+					       unsigned int nbits)
 {
-	return min(MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
+	return min(nbits, find_next_bit(srcp->bits, nbits, n + 1));
 }
 
 /*
  * Find the next present node in src, starting after node n, wrapping around to
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
-#define next_node_in(n, src) __next_node_in((n), &(src))
-static __always_inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
+#define next_node_in(n, src) __next_node_in((n), &(src), MAX_NUMNODES)
+static __always_inline unsigned int __next_node_in(int node, const nodemask_t *srcp,
+						  unsigned int nbits)
 {
-	unsigned int ret = __next_node(node, srcp);
+	unsigned int ret = __next_node(node, srcp, nbits);
 
-	if (ret == MAX_NUMNODES)
-		ret = __first_node(srcp);
+	if (ret == nbits)
+		ret = __first_node(srcp, nbits);
 	return ret;
 }
 
-- 
2.53.0

