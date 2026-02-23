Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B4343203;
	Mon, 23 Feb 2026 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817476; cv=fail; b=IZ4jppwqKkaQXPtlDpdfq1UvrSNmAxH0lHnjCGpvX6mlWRdJRGXmX+4x3PJs2jylmNqsT22/k63u/XrLUwt7Xoc+diEzzk41wCURWUp1/FG39OZIEW7kQYBl0CD1cESa3l815QHO2UenFIiQrRlQ3dioaURzDFvWyb2BlckLLHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817476; c=relaxed/simple;
	bh=6neu7fDyl1fHJiV6Rj60Igyzgxcqco8b2MxIF5wKgvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffbByI0IMfAWayK8ddxn01/G3zBzuzDrt5IMyHpeE59s1XSgGQ+07anyOzeZ0jiRtvbqHBCa/evENsivp+c7nGWGhkmMHmZnMhopVWO0pZUe8xG0mmKJuN7kA0nxfGU2qchMEs9+OtdTOMkBbC7106dbo3hgHiCMCVxBMFA1uQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U//lU4Z1; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U//lU4Z1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEM1ZBoKH51IqpZCenLiWh0SlJTkL32fCzOkIh5VXRjM6VN+BYyYMv8W5j8ncmcL51MCsZG3mqcKyehQrLC+8FB7Z6jnAX9dAzjLCna50P3tK0NjblRfg4BnbjShCimpVIOKSC+en65JuP/74WwsUCnKvxadB7cn47Cp6TJDT9mTUkFoDkdrfQXkRJ5TPaMW6haFR32HiE6pOxq9Agwq58Xh162j5p/h7b56mCZhDsd3siPt1y5DQ1vCt1NF0t7dNellvlMfvuTMGdut6ijpVbXFzHCc5SodiGnyhuwEJcp1s0aSkRwKtzEBbwi66h7xScD3nYTg0Nmm02HvxDbP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NntCHJzTfCZpcDKHrbEPl+20RyEVXdBD72U8kZtE2nk=;
 b=qpXA3YmJpRtR/5OV5EVRWZrNu6Ky4xaJOOq6sLXwfbIyJXele6PlOgaSuajFpw2CaLdZp1J7fK7NSVgpmES7ZudwJTgYUqXtPH4o2ap9Hd9JHbgWxhnIZBkK321ZmjQRNwD9gxbBI3OJ19Ge6zLq9MuBro1x/zKEXdk/CiFGaxesF216f9nHkDUVDKSxzdkM346sFaifobuyffaBiTf0DIN7+KZaatS7YVzQwNEbt/HanpnmZim5qccBHhkWaWl3kbyp2D6yIKeQDbJl1JhfPHCLcAeIMh3B7eHPSxls+yg8YgWMgV3fmkPrtkTAauSemh5WZJzCJ7xgUvirjB5tDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NntCHJzTfCZpcDKHrbEPl+20RyEVXdBD72U8kZtE2nk=;
 b=U//lU4Z1ZitPr0Jrb3YSOBhHTgS4GY9jrkS9pxHXqS8a2zYbKNQVeJz24gUoqy68KI7iFiX7XrYS67r7wY83wE+0wqKXQCQfUYAPnslPAfXcY7JXdBXrCJVfzI1hYRStsEcKfnE2qO+5p4RagOxCu/LyR15vRKW4mNoEJrKxX0jFGZy+WYgrv+4shVU8J7+8utuCdn8jrGsDnAzsn2UdQOAdiMRj6gk6gOjKrWn2zY7xZj0MOr1edMlhlnAoSayzd/tyQdM/ICnwkdZMvViu6ZYeWbyFaMBxMPLhL5iHdbOFE3GlwuDz1sJwA1nD2c8YWwrl6P1LmDnOGkFMy93y4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 03:31:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 03:31:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v1 10/11] mm/huge_memory: add page->private check back in __split_folio_to_order()
Date: Sun, 22 Feb 2026 22:26:40 -0500
Message-ID: <20260223032641.1859381-11-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223032641.1859381-1-ziy@nvidia.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:52f::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: e80d9601-962c-459a-0583-08de728bfcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KmkSj5zepnoa85sN/4S8nT0vWIpBNmojIV9wkEGy/P6jJ48FpQHo8PTI8YDM?=
 =?us-ascii?Q?2otKC6hwp8JMQB2UwvNpmZJabNcMyBzPO8A5OFbPJT5Uf+/xpaUubQc0ZMPS?=
 =?us-ascii?Q?afMrXTtI0lwaWn8pkO1grOD8ccCXLYsYWQKP51u+AVHgqlv4pqy19zSgair5?=
 =?us-ascii?Q?bHs4yUMm/xOIVKzj23BlDC9p6w7VoHm3ATeGFwiCqv9FqlIu5Z9Nrd5To3Vu?=
 =?us-ascii?Q?6ZyRmajPfs4McGqcVVWPcxdHSjkshI7zL9bNG7/fqdRy4YMtvZyc5B1si/w3?=
 =?us-ascii?Q?E95/CqEjxpfkS6o5qlIOy4Elsinyprwo7nLERf4eptKfriHeDN0D5TvKWs07?=
 =?us-ascii?Q?byzMXL5jd6mK/bL4tRog0JvH+PAozb69QnfZfw+tFU2JGcQi8dqD5Y0roECs?=
 =?us-ascii?Q?nqqhfhqt2U/03t6uJ7dvi3fbaRKw80QQBSZNCvxD2OyUAN1toP9Z9cEaVtHF?=
 =?us-ascii?Q?e1BelyT7mZGVE6Ut7OcLhY4t+2VRzR3tsNz8wAMc6Aw4KDhFJcqA6rpN/F3w?=
 =?us-ascii?Q?isXXzvRIE6jfPzP/S59OWAGMgXSFljUkUa8CzP/ytPIj6Z2eymL3rSM8I4SS?=
 =?us-ascii?Q?GOZzW1nTX+ULNS8LTvPI8g0o1h2zRT4CANvT2AlzJBabuNxbmnkxGjPzz3bs?=
 =?us-ascii?Q?217cYlvrVmTw2v4mcsnHqv97iCqDjcfTgMUnyMN2k22jSesFDq20YkWSnLH7?=
 =?us-ascii?Q?UPue1DGZ/2GwVGYaovUbqGa98yGbn642q1VCNf7LoH1b++9mkwbP8qpeF+Lp?=
 =?us-ascii?Q?5YQGxDRuMgWYp7hn5KVN8dC/e/1hl3QFh0yrr+wD175bCMdMxCZtyBVBkrj7?=
 =?us-ascii?Q?xKrlWSQ3JL9cdpZ9R4JUnjvVyBFXGL0PlCF8EAtAU0VajKOLCykWX/NgsGTF?=
 =?us-ascii?Q?06NSdgoVW16ANDVo3eZephNC04m+1tzRODeOZ/RY4y4otjjvKelOfF0KV7NT?=
 =?us-ascii?Q?M3R/6CoAD8KRY8TV3Wa1l3C+nRg1IxmWl42HbWDXRhYOk8YTvDVyosR1zOj+?=
 =?us-ascii?Q?0lCxkYGQaQEwjARDPA5Kkki8gaID9RAN45P/Aeb73sYDoW7pGfKwsWhCwDLB?=
 =?us-ascii?Q?m71ZyXQPkTSZnSHuG6ZSPLmWogSnRA2GkrE9kQV1XwGAuR6IYzH9iYrTci+N?=
 =?us-ascii?Q?ts+MzR3AuqKEPyCNYSasHjUaGkpUtx7QHFLGD9FFgaun5esrTD7R3+kfqgPC?=
 =?us-ascii?Q?mzGImCnjT5H/Cg/m2ccyCWjbGuRowIHpvDNt6nkWjg8UxzIfl4F6Hce/0Cp7?=
 =?us-ascii?Q?8OZypgdr3d2l3yB3ij6z8bXJBUbXjgP2k6QwOzA9Hy3HsefNRJ8OZj/wcfhL?=
 =?us-ascii?Q?T2dnxyc/8SldP9ZJ7gp2BOIxzaAJvHwF4FVk/zAeorscVeZHnCjIuoxl+hse?=
 =?us-ascii?Q?lDrhPcb3kfbiHCb8RVpi/bN4CTI+AU5c/9qWqmoccz2k2o54u2+zMEvmMuCA?=
 =?us-ascii?Q?DJQh1NMskADVGm6AtNS5jmxyxGtFpH3HyzWpo+4HQkrrsd56OVdcY5mU6o+B?=
 =?us-ascii?Q?pt9GQV88oCkn0zIvosZVy2JR3H/9uXwAFKElMCUTAGvlOoFVaRmt/GuL34q1?=
 =?us-ascii?Q?6kT4saaG5RejOmKUOD4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i95BdTUgK67yTbaQEr0YkFjJAwvhs/jNXsp+tJINydflL/XuaMupz3Py7UTx?=
 =?us-ascii?Q?va9vrGZ5oP9Bp8OzPoAuLUIZvdSSfG0dmJJM9U9lwkvP8bMgO8LHwxE5LWVk?=
 =?us-ascii?Q?0pM6OW+xsNGiHk3W5bnIDm65WgYSiy8O0YAdxAU2xfFwZ9IjXebHSXRS6CjR?=
 =?us-ascii?Q?eGOEaYoKUWh8dpOhE7LBp/sYPZp7rf6Nrd/g6+IXwcfdJPUC0/Qoal3+Llv8?=
 =?us-ascii?Q?GfCWMX6knddqH/DQKwPeRBn6ecL+AbgXeLSBxK1SWwd8aJUbUPJDfUFUf3Yi?=
 =?us-ascii?Q?kg00/CFJObQQdBwg2jIRQqcemlgKy3KaEvrnCXAZnC6r0aylgcXwooIhbQ+Q?=
 =?us-ascii?Q?lkUU7SM2Ll8mBch+5w8aKmTa+kpsgMfNvWgWf0NlfJkAapdfH3gIaIQS0oYJ?=
 =?us-ascii?Q?sr9BUBavwvh2kFdHgxPt+siNj/6GzfD+u0Fcrp7u9btBDPepJFciVUA5DlMM?=
 =?us-ascii?Q?+hoZ4d0A1gjEW/Zue9MvEE54QeEOSU7HCEISSwrV+fKOvnGpLUZxijK8kGAL?=
 =?us-ascii?Q?+g2QcB2zjCp3DDyNZwtMwMQ92H2W1EWQnaOjPp7yLqgYENq6z9TPow0GKMka?=
 =?us-ascii?Q?jJiSCyh7n2FHpkBelVfHGvEfYZAFS9frqyP+JnGjkH7uCIqEyS9duv+rdLcm?=
 =?us-ascii?Q?T1gAsCXvC4WX6nSpwMdbJyz+Ided98c81m9n/UNYigWwkVZCTQY7CWnBCwRP?=
 =?us-ascii?Q?tcxcddzkRmxthqY8gLbHnXdjQdy5QXXT+rrlAwfMA8bsyzSM6DJvWKIp814b?=
 =?us-ascii?Q?z1U0T9Gt6n9xwxWcLjZkNEBg29jxDCEo2eLZG18K4NBnuZ9lVZ42OTMPONqQ?=
 =?us-ascii?Q?CXDNZk0vpz1O5LoeXutSTJBoE5hmvFVxSKpXzZELa7xwIX0gqz77RcKJ5Rhi?=
 =?us-ascii?Q?4uZRppUoO++DNhUWauVN2g1pkrK3LH7O2I/Qc0mKjLKa5AaVW4GXU13O1QU8?=
 =?us-ascii?Q?Z9ATb4ISB/i36BCw1XvgiJxytr21UC+xlLeMLj4jqAtC8fj/GbUfud3Ql6dz?=
 =?us-ascii?Q?lPFtCQIa6oi3KMfDRiJcY2kMSHfv2K1obJ64c7S7pwLg12SR62D3TYM7jWqY?=
 =?us-ascii?Q?1sNuM7RppqxjF3jkro6Hh3QCVPB93ecaH6N42HdbyvZRVG86jHQvH3tm/njb?=
 =?us-ascii?Q?gOp5gI3fiAKaAKK1wolDaPgHG55zqhs5UcEzslO0qlv0z4O9WiL0BoQLjMKA?=
 =?us-ascii?Q?hoo3q3Ja+yw/1IBWC6kz7hFHJXWymlgQNqmoeifPvz43RfuLmADR0EX/5P7t?=
 =?us-ascii?Q?Cs50K6JBme6jU/a3ntxF+4DWNgo9ojZeqv0gxx2SuB6w8hUu6uT5cGTDhckF?=
 =?us-ascii?Q?JzE9zHkXBM2lVOvOiEzRENQ71c9UyCCGx3ifW6siynU82Y6zJ0QQBCxVfJ7X?=
 =?us-ascii?Q?LLvgC92B0RetZEbNHQC3ZBdlm8EEd87KEq8wDM7osdbxuVUOr2M5xAWWP8dK?=
 =?us-ascii?Q?FV2P4Bq3/0cSVq0ho2ldgtJjC4NB7N7z3ZFueHvcu34WOzmW01IEH0fe8tXn?=
 =?us-ascii?Q?3unAnFFTkk3/YlCSomtEF3lxejpOEtt+BgHpsHqGemd++HplZLiMfYvooUQh?=
 =?us-ascii?Q?8ZLOq0OU48i38LEUou/6pXTp845KC+PmFlvHAmpmIU3BmbJFE0JP/4n++T/A?=
 =?us-ascii?Q?JYRaAjKO3GCx4YTaaEc89rLYKdlyDplvqxb6UdrR66HoxYYOaCO4esj38yLA?=
 =?us-ascii?Q?NRKiMNxsSqOvOAxVM6/ioVSdYm3HIiTKQ5Uw8qoJtBSoL//b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80d9601-962c-459a-0583-08de728bfcec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 03:31:10.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpG/YnU9yY15/Uswbvll3RbxR9qEjapwl7UgySsCQyr77EI23ERlqq1E3hzwg7rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

page->private should not be set in tail pages. Commit 4265d67e405a
("mm/migrate_device: add THP splitting during migration") removed it
without a proper reason. Add it back.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: linux-mm@kvack.org
---
 mm/huge_memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 27316d741927..6b57d219fc97 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3548,6 +3548,16 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
 
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set. Do it before swap.val assignment
+		 * since private overlaps with swap.val.
+		 */
+		if (unlikely(new_folio->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, new_head);
+			new_folio->private = NULL;
+		}
+
 		if (folio_test_swapcache(folio))
 			new_folio->swap.val = folio->swap.val + i;
 
-- 
2.51.0

