Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820498;
	b=BDvkLV5oyJdsioc84fSHOQ+RkSUoHKl/1ZfNEgaqtSbj2u7lMXm0+HCSE7Dnci+b/W/e
	 12gFypY1rZ7v3boTRol0cV2oeaO2l6twtza8ik4UT+LupFfFT3jtTOlqND5cklnKYYvHw
	 JBUlYcF7CzM89yz2dsNxi8X7SnjyQ5uePM3Qe6RK2Fcj3l0iIfbvrun6sD6M9N68ogcfK
	 tYYtcl03YhWk0eIiSPIyPloF7SPxsFG6E6ox0o8Rsa2sG+mWLxf9EUE+Ttv3CJIARzjKe
	 5BsvGYNpfifMFza/ENC+2jef/mWEKfG0ZceLLx/xSYD7cEkSkeUvL+DTQHjZyXNtzEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820498;
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
	bh=+Ba6stcuQ1CMxCwtv4Wq+b4u6+cZCkk6OH6twbiW0hs=;
	b=zE+wEp36wjT5ZBS5tyWjoQ8hP1I7TNwZTAPNyZVBxO5+5fe/e1HxyOAVaI+KXJwT7PWz
	 hJm93tKLdYaz4AE5c1xseeIQZXfquReBV509vA1yZw2S6km364lFlRlmyepdMEg6qNy1u
	 lERI8yPK9nvACULHyaWiHYg2tQE1oXd/0niehC5MSIXulNzzSdCY/4GnHmbjOcsmrFym7
	 As5EYQdPvhRL8JBT6d1D5ZRjK0ff2zvdFsf/D0Jgc73XJPKFIDEi4qlOOa/moBXUSHX3z
	 4THSE4JZpKIKosjgEu68gnklhwqbjBMNlx5z4sdalQVr4aMK91tA/xWgrj/MwJwl5vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DlPnKfMH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.66
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC2606A326;
	Fri, 27 Nov 2026 23:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3BC2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DlPnKfMH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkDoJ48z+QK7fD/LXVPOjS5BfF5K+VXH2SfedY2cHyo2QXf/lJnDALw0gZTl7J6QP7iAUokPy6sg4vkwi9GDs0s+UMrBEfpmB8JCGQ/Biz7pb4IBSBu9R7CLlRNMXDDNp6hKWIN4SF9msgGnbkmsaxV8TkUff57k0Z3gFnCijwCZZWs555KKErqRt+xqONw4elstRrbv1ZuxHS+ZpZbPg0aTETdBvSAte7ReE2i1S7u2NEKkLWgI96QZzMSz+KWD8cXj/gI+ybZew0ZqQ61qPkcMcy8qvW5XiFgJ5JKmTpIr7Ely8XlO4/2R4XaHS4sErQarDluKCE3Q82TLHkY4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ba6stcuQ1CMxCwtv4Wq+b4u6+cZCkk6OH6twbiW0hs=;
 b=ptTaZtaTy4kS+YwWXe8oghl+6qbTH7VfrORtP0fgde+93xxToE6SFb1kyXsRN2GqrT04aA0+SyRZiYiP8RjO7aJygD6XsXR5UzSHnEv8Y7tgkGSP5selPkWG5yxUlupCJnVLhac9iEz4PdHksvzIJDcrRls2/djz8HorZfHFUglQfYzTvFzVs6CIZmtJAverR+DyCfU4xJPOh1omg9Xks3pduOOXCsP1L9jofLZbjwR9dx6nrP7f3cb5PoxMmK3s6L95NCqW4cQdV7vsozzhf/FRMrTelsdn8iH9w7aNrLxIh+FK9QJHbI9fe0SHuBNFrwPC6h/BVaPcBkPqeCxeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ba6stcuQ1CMxCwtv4Wq+b4u6+cZCkk6OH6twbiW0hs=;
 b=DlPnKfMHEoGG/wgI4C5Rn+rlek5h5lxEim4GJdLKlAdBN4qFhogQNtNKT+Ksinl24DBUsZkphElQYJg9e9IKUkv8ryf1VR93/cVoW6SEbr0vtRmy6AS8jVpWScFJJO1yppKvA1bL5xYR/m3GHHFIuf4PCS31cn5Sfi6A0zlCHYt3cG3dobYU+lDpiTSLCQ9WsMTehxkqddtgbu6Qt9yTKFpS+0l+y0JgW0dietm6/t5GXRJbvhCLYvwWvV6p81VA3px0LA12GCa1NflVUQ4/q8pT1EYtmK8/rIHBh5s6HuJDnwMHVlBt6kySbsxuZJodoXLVCVvm2ggsj2SoR4SuTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:34 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:34 +0000
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
Subject: [PATCH 01/11] nodemask: add 'small' and 'large' compile-time sizes
Date: Fri, 27 Nov 2026 18:01:18 -0500
Message-ID: <20261127230128.111933-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::17) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 45526a85-b267-4b6e-721a-08df4cda61f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	l5PbJ718evsEnTx67KrktpouY3eNPuAAEkFJSjoTjtO5cS3GE1bTYQ10pRsNWdo0lCaTZEF6obvkE+2AwrxVwj4hm6md7OhZpm3Ir4ujJN58IjoovMObH6uV5uS+dSKap2f+tJQzVTRRmz4x3bPU1X+QFEKZt2rir5bUChtxGISv3tYnCbjyIRPuB4/Dd/7XHL/O3JtCrdTX5UK+Zbg5lH4NCeaQjBe/y3dI2g8jv0xoWuYLfGDZSdgP10rcPSM0d7L5tIP8yEoSlPnP48E4BBabWVbHqMLk/7C8tciWYKT4xP+rFmmQSO/eitqeX+tG1i2s++vtiFtxNBvMhVwpSQdMx/dFpiwUdN/eElLKqnCApf4LcZdUomNalIW2ippvS+q0a6Iu3C4EOzmpV5ewU9Af6B71ap5gwyG1jLA+GSRcdk5LsJUaT4DJtNWVcEzRkPhB87V8GKgobaKitaR2cp1odWoylDJaKu2l6WO7M3UMuYO0myL+b6PsyEeH4QW7wPaEhrB/pD0ncz9BTjlZklbCBZRjQa8UQIdVbQlF1CCqzXhdSEmSCceKqsnJjnQc1DJzyWXcouvA9f528LzBHdYksJ8pua+ojlNj+oxbxOZy6FFNB9t1Td+rcmrRDhRCbSCedEu+80yi2w6/gGyzzzmbtBDBexk9yDb2i+ATmOHX6dGITBuyOCpW3lIGIARCkFRI2uMpKCPVtO6sIvkJXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USpwrf4NZzlbEey3BIrhPe0MD7qS9xHEllicYhM+JE86Desvwb6tDatNyKPh?=
 =?us-ascii?Q?TpAmdR04yS+8fHbMb6LA3pGYF6MkZ6mUZNtMIt7jrhVQXP7i1rk+rQcoWWrl?=
 =?us-ascii?Q?rNTt5EMqZ6F74Zgf1yWTcweNHwTlLQnjxDulOT+hj2HMcXGp/ZMSCGJMljL7?=
 =?us-ascii?Q?Lod4m5LOUBkjRegqJKTM6Zynoe6CPYZHsvYDloukUY8fn8g0ziDrropnojpS?=
 =?us-ascii?Q?OIbr1uywaIZDRAhcXDvBYlC1XzZWTvOasgS3R4y6eVGw27hQvp/N0YXe3z1i?=
 =?us-ascii?Q?Sn0DPYrBSyjsV0b2CeYcxb2sACgcSej1rp5hg1l+ORqw1mfa6om/hlZ/0ONG?=
 =?us-ascii?Q?SNVH2aaEnRgD90+RRO/1QEIdbB1uFZTP5LkpP5HVEYFFWeUJIPU9osQCv4yq?=
 =?us-ascii?Q?eVVLhrGos+BUSwluCF3J80pqowJeAxzWNr1TlTIKH3C7mDYcLX1xk6DVNkmx?=
 =?us-ascii?Q?7oL974A9gIbvC4D4FtObncfvMs+SUSpxnv921USs2orWx6I5UmDwDBNq9kcK?=
 =?us-ascii?Q?O2OS+sFViIUNPciZwoU2hGtDlWYAzWl8flVsCcejSHWMxncWUvn/oSY8V+o3?=
 =?us-ascii?Q?wUzsUjFlRZRrBXYN/TVzKYXIT0AJMQziFypwDUCbhJWavu/eRz0NoAvZnSja?=
 =?us-ascii?Q?fgtswBKgaHZ14OoQy3xdTLxqPzqxrMozKQyUwCjRDPozAl4TBbwWqVo8t1lN?=
 =?us-ascii?Q?+Crk/4QYlKYp5DCfdVOMQpRm0vCvryHncTbfvFEd49Ajqd6gqyE9uHow36I2?=
 =?us-ascii?Q?WwNQMKvRnAmXd+5jsC3KehNWtrX0e/a9tfBdkhvgnZrAhjQp9z7yh3h+lFMC?=
 =?us-ascii?Q?2/3TAM9cpgpdGeqghwUc0X4nwXOiSdHr9DCxW+5RQo5E7Fp8vToCqoyuYRak?=
 =?us-ascii?Q?Nkuba/L5f/6/4SUEYWBjzQzJExiDfonzQEiwnpMfshnHAikBheT5Yu0aGLEg?=
 =?us-ascii?Q?hAnPXhUbSqnV7BqJIvQWHJjLKVpmW+l7Yz04mdKOvACkx960vbOvAdqbFnj6?=
 =?us-ascii?Q?OStYLO2JRH8cMxKTvm2dYAdff4S+eAqM0YWY1Nvv6r322Vuh5RV21j6DrmB3?=
 =?us-ascii?Q?J+z25JNkCpVxGgkxVIIe+cwdIvmN7IV9aDrpyb0Af/ul/NRiSiSowYPMCcAk?=
 =?us-ascii?Q?8EjpBhIVxocoU8N5IaIW6oxKN33Ht7AkaicgrIL+5OljdMVHOjQU7SSYJyMS?=
 =?us-ascii?Q?dRiQkTSIGjRywQL5egc9bNG0bGfcuIu1Few7mcQHnetniw2Edh3GrH8Np3O4?=
 =?us-ascii?Q?X/SaxSVMv31EL1bTqy4TCq9jZvQGLliDDK6q9IXLkJ1ou/i8XdVLx9DOdUU0?=
 =?us-ascii?Q?02o2fBx7E4t0PO2HkMhUaO0nBdAi+lPmgkyGRyLVSsFJH75t4D0rjW+EbQEy?=
 =?us-ascii?Q?eNF+qSSiaYIImgpBwiqMjlcRztzgA+iHRY5sESJ5iKwczC7KyD7xX0hQiaNC?=
 =?us-ascii?Q?XT8tK9+zeB268zkdPOJgwuYIlOQ1iOVjortyuyqWVl2tSzGpU4XmdPzD6Oos?=
 =?us-ascii?Q?wnJMGPYWzq91bYBfC0XML1N3jw2jnBFKbEVC8Ean2WYDaC0G5eFvX0XxDuTY?=
 =?us-ascii?Q?9pfrLv1udRbOGLa3gFJRx8Z+OtfoGOiDpV7vnLVAQdOQgiC8JvsQuCcIulqk?=
 =?us-ascii?Q?YFLKmppLax0wiV+dBKlrvPnVqoTFtkJ+fymmQqOqmqf8yMXAU3fnJ1G2fbDH?=
 =?us-ascii?Q?nFyqOblgTC8DTx+aGOz/d0jll5e4vKNhOuR9TE6fzoTdBdIeK8FLjScg7mtO?=
 =?us-ascii?Q?EyYp8+riQp1DiKFDT5cYTsdBLX62TKWpQUu85TP2U4/jBdxP+0Jq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45526a85-b267-4b6e-721a-08df4cda61f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:34.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju/BWsPGaW4eim1qLy+esaK4JSDWhmSKurwMjfYpYq4WhPd1TyUQcOSW9zDyXYn0O1EaaWlHb8J9CnR23oA39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Introduce 'small' and 'large' compile-time sizes for nodemask operations,
similarly to how it works for cpumasks. Small_nodemask_bits is used by
single nodemask operations and searches, and large_nodemask_bits is used
by clearing and copying. The nr_node_ids is used where the exact runtime
length is needed.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/nodemask.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 607373bd83ee..37fd5ac957c0 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -103,6 +103,22 @@ extern unsigned int nr_online_nodes;
 #define nr_online_nodes		1U
 #endif
 
+/*
+ * Compile-time bounds for optimized nodemask operations. See comments
+ * for small_cpumask_bits and large_cpumask_bits in linux/cpumask.h for
+ * detailed description.
+ */
+#if MAX_NUMNODES <= BITS_PER_LONG
+#define small_nodemask_bits ((unsigned int)MAX_NUMNODES)
+#define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
+#elif MAX_NUMNODES <= 4 * BITS_PER_LONG
+#define small_nodemask_bits nr_node_ids
+#define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
+#else
+#define small_nodemask_bits nr_node_ids
+#define large_nodemask_bits nr_node_ids
+#endif
+
 /**
  * nodemask_pr_args - printf args to output a nodemask
  * @maskp: nodemask to be printed
-- 
2.53.0

