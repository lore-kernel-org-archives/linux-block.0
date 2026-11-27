Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795820516;
	b=Jkna2Jy4m+Xt5k7bETXPU5NSVlM78YNIxIL5LPTwd4RfH5In/kbtXnNecOfH9a0fp9ih
	 qpeqm2in6feJ26/jlDSHUbT/l+e5RSvJWWeF9BUvxqsqoiUQXkijq+0laojBIfy6fDHKP
	 4lTj3hs2212pJCS3GOdOosXPlWutBw1OWDWjFeHDFPwb4Etk7UArgY0u/Wg+3ee+MM5Yz
	 fD8w35RzkuNDtIZopFs7LWxYZbDZo1/+l5rRwXv/NjT30COPEdQ/ijWKS84EAhOWnbpSQ
	 HmKkezhl0GA5AcwUuL7bKJblAr0jmpKRUFectSWbJEEq5PCkJRQl9L+Y7ZFbjitwAeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795820516;
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
	bh=upELllW165M8rDQHr11hFVEi+ObboYVo9EgOybAORCw=;
	b=Qat/sM0WcsbKkNmaHkMInAwZn2asavwJ9RZJAMxXp6yOLGSI/ntCbH0wmjzmrBAQws/D
	 7E7RdPnVnI7/r8gVru/zEvOFMJYtEUjl5Q7FXiS4zmZb/7EiYsHLbeIEXDPZ9sP8zO6QB
	 0s1LT2tEf9jxGhAoa5T2F4LeWOthdkBjBeJHw0I8jH5nK5gptcV0iOMVPXKJy4Brd5BeO
	 tArp4GmSJD8K7LwwtDlJqXVrItW21b3UeEhvvAuh7N2QcHOn0zUUCOhD7emiCisCwoSIb
	 FYLebc8EXZ9WaIc6ZfOgHLPWMkjRsaOYgw+IuDJsXus7SC0PuP7T+QAVveQrWNCtFmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qCqhBm0z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051360A381A;
	Fri, 27 Nov 2026 23:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C051360A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qCqhBm0z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3xiv9G8ufYI9FATtkLlD+EKnuIH4sKflfhRA0daFPD/u24/fcZSNTpua30rxiu2Mg6O6lMk1rp3se6PVF1YM7qqt3LUrPAh8ZtF+7W4s6rR4h361LUHzOm7B6BndiXVxVzxbbbfSFHRjKWueydwrb1ycq0Wxis3M4yXuNTswqqY2LL85HBOz9Z+IhYW+3S4Sxh8FcvUJxMqddNUSxOrZ6KvToY4HPij2iPEgEjoA8c84TWcRl8nQOMa5WPuyB8Ut0ufl7MVgNCHIryIJmkd/3KsxSouO2/KdZukIz/XJOpd7lqG1iWzJf2uIMpdgp5SIUsL0WXp6v7nX5nL9JJQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upELllW165M8rDQHr11hFVEi+ObboYVo9EgOybAORCw=;
 b=hACD2clB5ulu/6Ztof8eUAI8AwzfP+1bry8TlMq0YOwNxXKYHelGSLbpSirYbDGfvsUHX6O0bU8pwuqykZ0ckMlE867VnFuXg+3XrJ7ZFFtkzrh0+MWrzjJNv3etnm3q5gRh98a3uT4Netv7VKDJYNs8XS0wPQt1pgyS6PRo0SFOAm4/u8WkBVVaF/H/lNjaAAaoP20t3MFGVy+2qDyp5u7jNynhIIlZ97lfme/BuBbCGDvCnwy7qS8nWak5Kn4KEp+4xi17YJZTwPPYvUYTmhvoXr91UTTZ3rxVbnoVxYPjsTwHR7CBkWoHnSfTkC7QJ9UNhE5qkm1JZXk2PHNJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upELllW165M8rDQHr11hFVEi+ObboYVo9EgOybAORCw=;
 b=qCqhBm0z0xtJ8GlPA19sNFx8A7XixlT2l6bfiFsLVHSY6QRaWUiLnvp9ulTryIkzR8Rlo5zoIoTDcdTO5ycpdLnE2X22S3jvCs3gnk39coG4ZIJvj1HCuEJqt2+lFLKNSOv9LQilYuA1UhC0qE+VN8X5bOCmDu32srFYbdiLkfRZZcIVlQMjcgW6HdCg1jXMdno3VJSKTs/PPEZ8dQVFP/wt9Uk/Bp/BiPKvHMB17eUO4zgeKpowSWQrtlYeC9NH52w9cbQEyg67hcGjqOmQW8A0y7dM0ivPyF7uVF/X08RtjXyGuQ73ptfrbbEBOoeYAT3vSUxZQa6pZI/zdYJIWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 23:01:50 +0000
Received: from SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59]) by SN6PR12MB2814.namprd12.prod.outlook.com
 ([fe80::9a18:413c:9702:8f59%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 23:01:50 +0000
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
Subject: [PATCH 09/11] nodemask: add nodes_copy_and_extend()
Date: Fri, 27 Nov 2026 18:01:26 -0500
Message-ID: <20261127230128.111933-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127230128.111933-1-ynorov@nvidia.com>
References: <20261127230128.111933-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0880.namprd03.prod.outlook.com
 (2603:10b6:408:13c::15) To SN6PR12MB2814.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6b431000-0210-40e7-29ee-08df4cda6bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	K6MPCuUSBzZZwiIWVijzIdTOAtOLWzYY1dV3nIILtHpADLvxArvgANJIhva/Eh2cYEsr2WcuE5iT1ebkpwQ3Ow5RpPbiajNerf6GGsGVY2GOhpcd6z+a3PC7qp5tj867JdJNFTkhDrV3NB31qI2RFIabyDBJ9ZG2yjXcYJsuYFe0TqaeTNU67r4Dr8MY5yaSxVmofO4F1G/JVzvju+ubTAQmLnIriQT2OfRBjkh3Tjv2mpd8YNEFZ77jpJepBWf+kbiir4Am3fQgMlOx32ks04ujQPWqmIGtqE8K2tspovNP5iz8VbzCcy2vXbUh+nu0C/fBpOPjn/qeuu8bDY2tYEyvMnifCUtWjZeqrE1iBAxk/lXDIBopbg/zwOrnoD+Hcav78z44eXI+E3vBkiXdSybMcYEVO6tvHDXUMwec5ne+83KYKvw00AoqEugYqSP0ev+KUTz5Yiy80dmrbiqMZEfEngScULYQuhDsx/tzczcL4GkDN50/0a/zbOxm/PwsPYUiQfppXXAzCjt1rQhPq5CNEjRdRPAah4HDdrTiSQ+UqR7mFOgTgfds3VqZAwalbQlLYjncwbUVoUQ+nZU3xgxkW0TxFCAiSWWTGM/pn3U90ZrKFgIklS2cFXuxxF5o2tYtBbw644fapwZz2QJ3alBei5+z/xQDSEO1j+abKw+HSS4BU+ANlTokHnE9k37B7ymx9n4Uhh2JjZORPeltrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2814.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0yCM423bmoS22oSW8SwZ4EQfMj2o2nt4sOhkpuNnO7fT4ZRtwME52mYLohK?=
 =?us-ascii?Q?bZ47zr4ewN1KCXilAljaZsG0SpNJeFWBKkplXx8mYZkkh2YT8u0Gk5m4DT0o?=
 =?us-ascii?Q?LmNiVfL9lKcyElmO7d7bxU539r2PKIvPsZ5KfeU7tBgsUe8y/OjENKvY7zfI?=
 =?us-ascii?Q?M+EgQIlt/slcsCHWfb+BoLci2DOUEKHWhx/xLnDAIIOIpe695w9XF8JjUlVs?=
 =?us-ascii?Q?pbt804MPI1pikNF/9+qYY03QOgLFJJ46XfeytubpIFIDbBYHzq5rdB536pQ9?=
 =?us-ascii?Q?wZESeqzRzFM06fZqF5XC3OQBGddkyjCy5txNo3rMZ0QH7w+XWY0KoE1C38Hv?=
 =?us-ascii?Q?Ruv1GChyEWH+GS1a5wXptY4xVaVVg29Q4y2NY/t2SBSVQsXnGpsGVoYhTCjp?=
 =?us-ascii?Q?z29Gdf3paB9u9FfN+5pezdy87P7Rns5zd9FC2Uq07LCz1wHWaegmyj+TWwtA?=
 =?us-ascii?Q?A9lLUxjePxABakbmctQjhkZ2+N50aVz2+qFeFmyexPSH+qtLNWfupJKaO+4S?=
 =?us-ascii?Q?ymacnPJRu0Vbw1r5k1agoHOvFp/Y99YL5k3rKtG55/u0srFarbQ1SduU6EMA?=
 =?us-ascii?Q?s0Xdh9Nu2bdjoO16wqKoI21DzlqeSKEOVp+pTgj1mXQPueqNrK708Y2kZm+c?=
 =?us-ascii?Q?+OXaxGYcfeCwcZ55bHWM+wv8DuQNWv5Jn5bwXrRi2iSCazcGEEfYXK7MDogk?=
 =?us-ascii?Q?8v+58pmTDkUUuQZ/mm/GOItqsDlPBdv0RhKcLA3bQS9g2lCKEQNj1Ht2cI/m?=
 =?us-ascii?Q?3p1IzAJjgqzMeupsio2XjeZYczGRVC1zi0myuHTnAnP1OxnMjxAaKMZ+UQoA?=
 =?us-ascii?Q?2NCnRR7rnj5iNviH5REDjVWX6NGcHqUEWeKsnRyjW+ioQZHapkb1nrtg0M5D?=
 =?us-ascii?Q?Fh2xnpRCJYZOxfDuUQQCsxpae4a8pgffMUOB7K0FsKnrvdp+IjKLcm2cBPIn?=
 =?us-ascii?Q?GCR6OeRQWHYqCkVW9Nm1Uh3JgRuqSdPHXJYNqO+T/MDdKqdZNEOwQqu6Za28?=
 =?us-ascii?Q?8lXIzQTDru+CFWW8zrUrqsAvi/dBEzLfDe84uJvuY3zxLGMATTaHPP+MQyQG?=
 =?us-ascii?Q?da4BZlEgH49nTPsEoe2XjkpSa6Rn7ly82Dh9dWAAsf7MglfSKU/749SF6x9r?=
 =?us-ascii?Q?6pcw59VW4s+Dgu/2FgWacGnQIlROUI6sKuFKNw1GXQSBF1AvAOtyFcCqh+T/?=
 =?us-ascii?Q?RjHlcwnS99uxpmlDdvy3x+KYh8CnnpsCcOzKJ06TkIdlvtO5652x6yfsg4JM?=
 =?us-ascii?Q?uexVQLSHsmx8FX+TpHYTokutWQN/EsieRVYBVICXaTdDZKZmu4M6V/gGRKm6?=
 =?us-ascii?Q?woquld8sOiNN6EZ6g5VIVavDMzD05/9MAiTJUqayqcYvTCoc/1gPnuwMWo7l?=
 =?us-ascii?Q?9GKl5vj4s4Ezor60BnwJkC4nHL/UaORtTI8gPgogKdL6sFzmvO4X9pUeGws2?=
 =?us-ascii?Q?YTk6vzW7gy604SnMVHHnwCGKuhnS+x8lAE7FJYwv+aNBpxTbg94+e/4yljOT?=
 =?us-ascii?Q?jU+1bnc0vApp5jp16z745bqSo67TXVc1bm/oxio1uDxhDegbFsvNP8lwKaKY?=
 =?us-ascii?Q?amXqYgRG15PCV/8o/7EVGhMAVT1P8QBOA4gta85FT+ScimMB+1LUt5WdLuCv?=
 =?us-ascii?Q?CxMAp/s4cxViBFxME53KrvzdbSkR3Z1KdMqmarakxnJqAady4eGn27N3O/2I?=
 =?us-ascii?Q?eyW9VLSTeNGO/XPsscXwV4qfbFPYimVd6NTlIg4k3VF9aypvfZhjoUM/0ZGp?=
 =?us-ascii?Q?8KUANuKP24bNpnc5aUexPOTCmayNwpCM/4ZVVhgtf8x6e5PDC/tX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b431000-0210-40e7-29ee-08df4cda6bf6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:01:50.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xutmC9PsND9k6Av5JEkrdEj7746kkmhl2+gCYJhFSjUEkj92Sz9UkA+TLwNwVNpWvkiLuCGiq5mO5iUXF+gABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Add nodes_copy_and_extend() to copy the nr_node_ids range and clear all
remaining bits in the destination's MAX_NUMNODES-sized storage.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/nodemask.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index a17aa5c2e562..4ef6ca642054 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -30,6 +30,7 @@
  * void nodes_or(dst, src1, src2)	dst = src1 | src2  [union]
  * void nodes_xor(dst, src1, src2)	dst = src1 ^ src2
  * bool nodes_andnot(dst, src1, src2)	dst = src1 & ~src2
+ * void nodes_copy_and_extend(dst, src)	Copy runtime nodes, clear remaining bits
  * void nodes_complement(dst, src)	dst = ~src
  *
  * bool nodes_equal(mask1, mask2)	Does mask1 == mask2?
@@ -218,6 +219,16 @@ static __always_inline void __nodes_copy(nodemask_t *dstp,
 	bitmap_copy(dstp->bits, srcp->bits, nbits);
 }
 
+/* Copy runtime nodes and clear the rest of the destination's storage. */
+#define nodes_copy_and_extend(dst, src) \
+		__nodes_copy_and_extend(&(dst), &(src), nr_node_ids, MAX_NUMNODES)
+static __always_inline void __nodes_copy_and_extend(nodemask_t *dstp,
+					const nodemask_t *srcp,
+					unsigned int nbits, unsigned int size)
+{
+	bitmap_copy_and_extend(dstp->bits, srcp->bits, nbits, size);
+}
+
 #define nodes_complement(dst, src) \
 			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
 static __always_inline void __nodes_complement(nodemask_t *dstp,
-- 
2.53.0

