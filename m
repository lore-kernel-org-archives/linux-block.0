Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA53344054;
	Mon, 23 Feb 2026 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817467; cv=fail; b=DJzc3hZoVnLXIarXFjc3cMgyF0ppNdOBldV63k7crJBc2ne55+1rUVBV4fJpVQWMLwbuYnC8vfr7N+wOPL+DCIiaUHSXUPNIQ4R9P5x1Ou7seHrU1sDu4ctlMSQJE9SjUkVg/J0pVAzWBEYM7+i7PF2m+/t/0kWgpVE+FLk33Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817467; c=relaxed/simple;
	bh=GgDXozhw1GUlrMwUlI/ZviOL/4OPXMcCuudzGd2sL3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLKQJJnkSSl2rpaLU0Mno4MX6TfeK3OGJ56ZDQnSKvinyqyMAXJ3rq7i8FPWX5eLYPAc9fQMEPKN2uUrxH/6VmVErHN2EAYvsH5y5MXyZhvswta/Zb0V/F8DhP/dB7JciBlzM79Pac+psFFs1cdTR/lE+Kgz0Lo1HzORCiF6+o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TkGvToqh; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TkGvToqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip125WUR4x/04/Bn43mO0F/W9MDpJbliBu27nc6R1UE9sgCPvfc5O3GAiwMKvePYLffzYrhNNCHh+e68KuvcAEH0Ft3Q/ePZ2A9cfBrCU/KRUoz66NdT3o18OP+zwTFqcU46ogQKchc3FPuoiIRbBx/YEvM/PCmuNOEk10frH+TaJvBvos/ZVlMSd5wnmr3PVyH+5x+Xq5KIhzUDE7cS7NUHRy/AnjYw39Z5Xld+ZblI4yGx2+ag2lqGUdiTT/ceuZYUFLOMBO/IA95bt9ou/YUweXlzXfES2kVxqsMs0qAAVZUr2ObXrQa4Ji0gZDkQiDK1UAvP2lQR6mV7GAU9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2linC/ld6GLcuh92gINyEn2Mup+4ofijXqZuXanEbY=;
 b=b07VRU9EQdbetqeG4qVJs/pHs5GeE9ZpJAiB+UU79QCxTBi2QktLF6Hmj+BuusZA69eLizH1L+uQYeSkbSTBXmlP3gPaJLI5LwxMxOp6q8VbYgN/7Pv86zTLZq4Lj3Ey2eNxt8OYt9/WiaILxsnC1DgvvuvDEA+rYsMbk2UuCq779+tlkPxIStFrQnCgVq6RyLeoFcMzm1+Mh4yv/nGSL+f6OjWcO+lkwEaU+JLIKv5s+a1lfAe0dSIXMyI6fJCl71gDQxksuD5+3jBXCvJ58R84BYdIu5nnR/MVzg2mmzjbIVrSBVJrRu5Ka3S7fp33ttEv+W09mcXCinZS3xJnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2linC/ld6GLcuh92gINyEn2Mup+4ofijXqZuXanEbY=;
 b=TkGvToqh/N3rUSByA1ADJh2oksA6Bsxz1AKiCDKA/+uwGUsBzzereuP3ps1j945qURlD4UB3zdR1eWDMraTvXQVQyHm1uIAnM8162a8zrqk83DeYCWh3cCU9QnV7oaX/ubCoXv5EQ3kfp8hvdQU5na+vC/jdtRw5EAejSjl110jUlDjj3juXBGORw+dlWMlb04dVSiezYFm/8N3nengnFuAt8tXf1X3UCUcYMlkEdNzlb7WWvxPznC96vLIvebU2bM5vPe22UyAl7ufTd1mWI6QrhXeuTMvGUWO84dQfiaiPPA9AZAejx8FofECmcoWwbnCJ29WXvNVEzLXiM7VStA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 03:31:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 03:31:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 04/11] blk-mq: zero page->private when freeing pages
Date: Sun, 22 Feb 2026 22:26:34 -0500
Message-ID: <20260223032641.1859381-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223032641.1859381-1-ziy@nvidia.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abb707f-fa8f-44c3-7c4f-08de728bf87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6LmvYkR7gVuh7vhzX/vgjO8ShYX0GKfQbougnt9WGVJYueerTRKEaiop7ne?=
 =?us-ascii?Q?sil01XPegI81Y2dfsaiqWpWToV8IXZMTzZvQWXM5I70cbcOD4NG17dkFYp3H?=
 =?us-ascii?Q?60vDnc+UtAfjcuaXQ3OA/BSVXoUZ4gAOiLuf2qYg6RBvfDxgMfqX2RiCpFnJ?=
 =?us-ascii?Q?OTjMBj2RMNDKZVa79cHcBlVsh8I8pG4yiKLpKUfiRBdoFvk9Gm90AM+Gme3O?=
 =?us-ascii?Q?C74eg/h22/neXYpk5dpiAld0wV936mShbau3QhYwEP3KgqsJS2jR6NdPgBZR?=
 =?us-ascii?Q?NujMXF/rt8Lk0/+fE5/UlbV5qA/ggp2Ud0Ls3NQ5Ppputp/FOTjByCPE+KSR?=
 =?us-ascii?Q?KupBlI7Mbdl/iciEH9jsyzPm4SyOeu8kBJ2A5MzrcXdfwoCM8KEhFHHc+WkI?=
 =?us-ascii?Q?kK7suSlfuHgdssglZrUpf34E5kNCm0gsvglf31Z6HQ1/O5cJ2LBSuBXEKq5N?=
 =?us-ascii?Q?GvOj9ZgqzwdIEmhIXBsUSQPgfVK2SseOCjUY4eGfP1jS8cX0kDqd8iB79SP/?=
 =?us-ascii?Q?2qOvqxNVxwCGekchCbYVkoHHSW+lqG1IiGrCrFJ+ugv1HEBsiiB474dkzlGd?=
 =?us-ascii?Q?fx+kuw58IZavXOB97wLDucmKjOQxFGyp4QJwcGYMiYNVViw/Lzc8DkON07T9?=
 =?us-ascii?Q?hRFdcV16ipXC/XoR4gXQbH5Nnv5bUJqXYqKDjMTcUT9hMwfoeCdpaEbiLn+f?=
 =?us-ascii?Q?wJTG1/novnxeUWJV3hBDE5Gd1RSlQccA/Xx6NzXkQyfTrZNU8FzkrYMBggjQ?=
 =?us-ascii?Q?wBCZ1Ox2svqgdtewG22aa1HDg4mcj7TNB3GAJkGl3/qcK5BSXr38FCM/+Xt3?=
 =?us-ascii?Q?Sg4p4y8hXfZMYSoytwOxwWx+KhIbLpD5WSRBGKJPE3D44s6XLtBnt571A0xl?=
 =?us-ascii?Q?edcDvbLrlDlKaid3gWZOQTtASFOOvOLP9VgPY548zMycEZMmg1jlKu6pcq+k?=
 =?us-ascii?Q?xuhhYw5yfbg/C1fPYjdigSim9fyrhNdPPF7HC9BdYEsuwcz3O92nuZu5GB75?=
 =?us-ascii?Q?/qxMwK6IdpjhTToHRA91y8D/nxrjV+G+EffqSNKQc3240b2cHC5lNBAQzpLA?=
 =?us-ascii?Q?9yhrI33VkHsjVt0gHHvb9KWkK4Mr1C4ERTb7A1erCFblPaqVEfAYpJ/53+xt?=
 =?us-ascii?Q?LDMMQfE7VX33d4CbV+XKUUTan8lyxheq8QJQ5cfaaSO/tNgRlZBNdp0pb+ym?=
 =?us-ascii?Q?0j+/X6c1ZJih8T+etEVatfFMy9GQfYDygodvw6FLL4H2PIcxhi9GTri4qx5c?=
 =?us-ascii?Q?FUE0/mgI35BD5RG1MraVzIAHhNKO7LqwrJqUgOTAvR2FpRCDm1/Os92b6RLG?=
 =?us-ascii?Q?PoyYe7wrH/c1+Wq/2GqltQISvxdGsNu4X10nKlZUEAc189tSXrHF+Pb7XVQ6?=
 =?us-ascii?Q?c5hc0HIlUZHtxoZoLXelsUOuJZbJyU7TN8BOj1K1KxnYDAMaxZg2bLDZOpiG?=
 =?us-ascii?Q?k8jGrr/cotGsTCt3LCcBpgri1qfHvaztQe6IzhDOyrN5MAr+DxAvosdVcNaG?=
 =?us-ascii?Q?vc6XMa1NoUyT3Z/HDpqmYd+HAY5ISgp9YSOhf9HRqAT1n2LTJs4Jvye1mIvS?=
 =?us-ascii?Q?uSFIocw+SY1WUfB5aMA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sfi9KHLnahzVf8ZOCUgqVZuqVGXTYcyHP30yDCi1UtGmY5p7kgUvKhb6QK0R?=
 =?us-ascii?Q?8Si/4A8BGkpmMmF47BCb3kU1DH/+x3ocO0ligU3Xholt7ET7MxKNnQ8QmPQp?=
 =?us-ascii?Q?4FYXn6re2fjp7nP8pRh6xRQLCAZohQVA1/oKepR1p58trQrNpTqKcy6u9XfC?=
 =?us-ascii?Q?wto8crwobAIOmISGo9i91PDnPptj2bd3W9542oeA8VXwVQVJaYgnprNTl4bz?=
 =?us-ascii?Q?+KtxDuFRvwno56A1ajO0HL/BiGowdMbC1zq33ghxEfklY1jHW3UTDdLDO7Ao?=
 =?us-ascii?Q?FuHMyojf8T6qsJDViZT9X3MoUQLXjudTGphT0Vgxf6V94hS4De/ERdksRvI4?=
 =?us-ascii?Q?OSZFvo3HCdYnSEkgSLIUmQr4XXsbEAE3VR/mMWSmFgHSCcrefW/TqgbW03WQ?=
 =?us-ascii?Q?yI3ILB1OS/Z5W0n9rvpaumDf7gPzAaG+oALyJgJkgRVXvAshErHnehcZK9uG?=
 =?us-ascii?Q?z5mVA+1VTcpJSKnMzy2jwxaNyfxMGpiWx92B65HyLdvwUUDOooEJe7iE+sFO?=
 =?us-ascii?Q?nOJSDRtHx7ygG2rGTNsz3DcidnSMIr+YtW3zcDxAygTRr0mJ8RM/EE4H/9kY?=
 =?us-ascii?Q?/DEJJFZN0ZtH7xRIojQiXg31t7AKo0xmRfRc/K0UOAcCj3H1Ds5DyJiQ507K?=
 =?us-ascii?Q?2WeGYk1UGPFbJRkRlPBX6wYR+8VBEdacAm+kNtIblBMkH4HJ1fGK/0VzyZKS?=
 =?us-ascii?Q?R1Vz+Jn4+7mf6OwPvfbqwsqvObRPVF5gMCpETlua3YhIGySn/fkJD0nIg9Yf?=
 =?us-ascii?Q?FyH4Ag/3vIdbVjp+LIn1wiiIBD9um22U5fi6tHZlkael7jaGLY3Z2SjICZ1X?=
 =?us-ascii?Q?CCUkRr5af6I4U2Xv6Gyjo+hVLnRQeWDshCDWodmssWFW2XWIOyGaNM4XWHDB?=
 =?us-ascii?Q?j+rhu+ELMuHKMyPMAfdZYy5+9veNdJqJWzs4WJtPxBd/mafPh5OSghHhpKB2?=
 =?us-ascii?Q?C1cQsMdMRn9rGZq7o/GVZUvMwLsdLRpjWe8zRIjiwskMQAiY6N/lOmp5Hrnh?=
 =?us-ascii?Q?y/9BDKmEv53PhvKdZAKW4HyncpGxR8jGUNv4sZCnz5+Y6Ah0zuHPXNZqsEwh?=
 =?us-ascii?Q?1jnAOFvq3oZdhSXftytrvN5xW4SDDGTpK2c00YVBLiTDIqkLltCOhZtmEEW9?=
 =?us-ascii?Q?cUz0lPdKjMQc9zDXzTlEa+xXyGIikVuON/uWwP3FWauY4a//r2f16tjEiznN?=
 =?us-ascii?Q?oFqa2+JN5D17Iok8nemyRVrdw2tAGu5XZa+n3Ij9TFNo6/XV/jqbKONLwBRL?=
 =?us-ascii?Q?YeRh7XZ0qpIlkzrUWVZH589aoxc7LFW6H+zm+L8ej1bDL0BTiVEqCLitzS2Y?=
 =?us-ascii?Q?9fGeueePFAV48MFaOI47YPCb8dUgWJgbWEIS6NuajJK9bePOxN7BVZubAkM2?=
 =?us-ascii?Q?uiK5kvwFpE3KEhDfkg5A6flPbDfAUgCj9I9sPkxBOOQRkhj+dNEnaG6DyxWr?=
 =?us-ascii?Q?mCFBDp2+vgtfJcEj680omqNZd0egyeT9jmRacMmlhOseHW/fJovWZDprCNz5?=
 =?us-ascii?Q?LKvWb2JEZrVrrvVqV3h8NqwF0qgl7hNV1PznFnvEz6EcClnkNdKZ0RdJq+6J?=
 =?us-ascii?Q?X8fyJFVLAp8UE/M2AwT9cqLSreXzBE2hpOgWigEQpNthgBBHTOWcbUKGWom+?=
 =?us-ascii?Q?Rbnzx/dN0TK2PYLvL22bybro3bEUgUy30DfN7B7cRfWU81J3INIlH39leVWT?=
 =?us-ascii?Q?fQTxfja0JIiQ0iBvYFVIIqf7TK4iaEVFPo23nIkARGO3sVNa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abb707f-fa8f-44c3-7c4f-08de728bf87c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 03:31:02.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGWfQOZyNeENSErqQGIjjA8rvR68TFanpiHVPByCKUMRmv9ASuFsOlYHGbUUrdXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

This prepares for upcoming checks in page freeing path.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-mq-tag.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 33946cdb5716..2d4bdf8df51d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -589,14 +589,18 @@ static void blk_mq_free_tags_callback(struct rcu_head *head)
 	struct page *page;
 
 	while (!list_empty(&tags->page_list)) {
+		int order;
+
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
+		order = page->private;
 		/*
 		 * Remove kmemleak object previously allocated in
 		 * blk_mq_alloc_rqs().
 		 */
 		kmemleak_free(page_address(page));
-		__free_pages(page, page->private);
+		set_page_private(page, 0);
+		__free_pages(page, order);
 	}
 	kfree(tags);
 }
-- 
2.51.0

