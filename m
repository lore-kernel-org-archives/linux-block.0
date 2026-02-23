Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCC3446AF;
	Mon, 23 Feb 2026 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817475; cv=fail; b=nfxT83LfgY0QS/TSZ6epOakMfYpbCK5rba9IZYUYx9ZWpEvdUDzLlMrNQ6NPaB1opMj9FWHPOGp1Pzaglh+amuxuDs/9vS3uNhxgt/XeyOhJ0jhXBJL57DjCOa1bAryxGCr/BThANyBgA5Wm8qh3O5lnhDrtEuTyfK+987bpOLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817475; c=relaxed/simple;
	bh=YZ6AEEB4gNubkblajvF01y/W+kvx4PEdUykdXuMIvGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNlSYEUypJgvhwAlZp2sbt3vxGr1B6QXkULXO9GAWsJOU6nosSut93k7ax74kWgp0YtZ2mxRzqGfNRebRlY0XLTcuR0ErUZ0c99tPmHaeccrbjImH3vYZsESi/4laTJXsSYRoTUpU3KHCUWnvggwXm+Bn1yaliXLZeoyqJRmkd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p2TwDgcS; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p2TwDgcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyXkk+sxqqz1Md9Qg8kSz7VKsJuc52R0jh/ZvLR1cYTrnzmb6yrPnPQNzWOcpiTZpOmBs1VS6p2fIEn+Gt7eJp/zR32quvhY1UAIHOjP/fuliolrcg+b4oRmHd3uHlgFQgtfCRF9CAuqabTnYsVknk88qvlS9bihnUb9CvGMl6D2gNN2oCSElbtvc57aHy6yqjP9qxUFIsH4UpQOuW2zNGMCFz4Niq9P9KaCvoXopkzyLLzrmgcPv5n8lWOgFcRfJq2ie0Z7dm90QxFpNtlOchthKTjg94vSVWlA+vSa8iA/SLuZobRqQk2xkIomowK+MwfJy1643339O6RNrUXb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzORGMcpYPP/l9KscmEvO7ySkiy2PROCafI7H7K9dMo=;
 b=DXObp2IEFyEnSrqQQ1jcLMGUyF+QmeTdiOQrUo23jH0ns9RoLfnP6Wan//1TOA1H1+Tas5EM0OlG7cTC+U3dDzLnng29z3SXIaaJQ7GK+FPfvhbaaR//TlCjaxDhymABk1VkNW9mR8ZfYSqDuuZu27nKmpQMrTqEHNauEOJlFb8ghY9jGkhX1l9jLw0ahxs5N4J0How+r7MSNC8SK3UOcLwCAGl9SQRM1ZWh8J4V9i2CMSHhMcebpIai6Fk9mFm6CCJJnXYxkq9z1peHHWe9qsOuSgaDncZkAQPKRezEYPO7EM5S+8wHYUkwF8PL4xSNLVPSp33aJs0xReDopwb/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzORGMcpYPP/l9KscmEvO7ySkiy2PROCafI7H7K9dMo=;
 b=p2TwDgcSYU6t9B7BDyizzAa+o5ICsTYX16U/u3SVYEplR8ssLXafMGl+uH6bvEG+kP3KU8MlhZ+WzE+8CemsXW+ecbWgFxl+ulHniyS7xDDzL4wOMaN94HCXxPYOB27tufSeHZamirBWEeAAeta5hmjRbkdlwpOeEsvLy/zitrlF7XlaEptSidBM46lq1n5Egd286s9drBDvPQevRjKH5qv2aj/Q9Xdo6kDrmnq7TmRku2DZ5A8U41x2QLVlRK3iHw176wO84DQxYE/Y9rDGmhnQn32oWf/AELjj4+Z1cRwEcUZ2IbtGR9BvPAkUMh3KxYbvICV/KdL+ixxqYTh0Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 03:31:04 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 03:31:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH v1 05/11] watch_queue: zero page->private when freeing pages
Date: Sun, 22 Feb 2026 22:26:35 -0500
Message-ID: <20260223032641.1859381-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223032641.1859381-1-ziy@nvidia.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e45bf64-982e-4846-b091-08de728bf93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8y9UK2c22wYpcVggiIy49u5uDapVBodh7WR2s5yD6qbyl0gvtzduNMRPlnY?=
 =?us-ascii?Q?IErxEB1fqmmyb9Nkap60Ls5xJHVm45Gf3UMhy3CaWKfu9znKcgAkKsTg+EIT?=
 =?us-ascii?Q?bh9XTnia+lwdTVnDrcncaHrdSuuRIYTIGm5I3Hf1HJO822s85+S4b9oUi7/K?=
 =?us-ascii?Q?N5047ScZHbQzcUIa+rTfHtqpX4dOhMeBQPj734NKK0CHQ3EWMOCEOVqJAarh?=
 =?us-ascii?Q?c0IEwOR1IKcIUFzd7wA9eZG15OYmIyiLYhXIsNa6PxISj5l1xm+jG36ea1dF?=
 =?us-ascii?Q?l4UxjHZXl7tz73VK1R4HwN7x8HjiJqIk/x83puujyDFTCsXsrRpZ5sh/0AUI?=
 =?us-ascii?Q?cSRDHpT7Er/+ayBKW41x1CBzPwrLH+24572i0BIC80l27lVIv6wdxI5UcFPF?=
 =?us-ascii?Q?P/LFFBhTNi5TlCPogjG/g4Js+oTPCKx2ZvExqIcc3h1TEfsYqXzTEE9YFu3/?=
 =?us-ascii?Q?CT/b9iWX9JtztenzcK2qBc93LJOF8IoHeiPy7dUyswZ/rf6BmPVmxgiQcfUp?=
 =?us-ascii?Q?VOgJmboNx4J+pQFwvHfqIM0KFyfg19rryfIKkL9aIrTDwFXy6/thX3nBl1Ni?=
 =?us-ascii?Q?am0rBMqMWzoECAsl/CjBB1oXCdcwdgfP8EZSJUWjWZ3aio8kzftefElR2Vl5?=
 =?us-ascii?Q?jJ8fHuI16b3RtkWzTOKTdWcxHgKUFbIPlKomid0/TbY+1tDVaw44KbtGSW6g?=
 =?us-ascii?Q?CgsF/NLvC5JXoi7qno2YyRnKyfNIt8ehNYRKhk2szvmalHbEc3WkVoGgNjQh?=
 =?us-ascii?Q?DvntAghOIFoV5ybyVfaEkjAxVHcHwf1U7+QEPnCd7T7wiT7RkJ/mcwSVorRU?=
 =?us-ascii?Q?T1jmyLUDZyHyrxq8QQkSUuE87wr4sr2sgn/HvgQrYwMC59ezokcJqEciYNQK?=
 =?us-ascii?Q?2lGQqwWp+pTYJUW0+x/vyBplU9N22meGf6zorHQiuOa8ucY7SJOR8itGWY9P?=
 =?us-ascii?Q?/Z4d6An4oMMQtAfgQkX3O5F08YvIGAtFDeM7D2cPdgzqqsLgfHnFegNxeSEA?=
 =?us-ascii?Q?mPLxMzgHsuh/Rx3vskZNvGYKY7OE0cNq6erEPLYOeHfNAB45hGdJK201Sv80?=
 =?us-ascii?Q?WdUxqVM26Ay7LvkachPIaOhY7n9cVzp7zEz5tDntcNcXiJfkPaspMn0crWgq?=
 =?us-ascii?Q?Gj47DYZxF3rjRVTxRdpb2u2AAlJQ75ntzyUGt8bKmKVZ1JRb3yC5aM/bWL9N?=
 =?us-ascii?Q?sxEQ1JajLHIw4MDwiPQ7kXk6rY5sz+EI1PPDcAkeclUSbqXafBh3L95Eq6Gq?=
 =?us-ascii?Q?kH7JEz0YfY4YVAdkbXvJzV2LsmVbgW+/HJ9phImFrrdB1B/0+mbXMlxJbkN4?=
 =?us-ascii?Q?0yLMqdDX8S2WeC/U7up/i26vkH3sg7fD1Z6XnlUHQXYkQC7ci2w/jPbl4KeZ?=
 =?us-ascii?Q?d0HfBAmdKWauOlE/vGxlu/n3C7a9lsfEJsUGuSvIJNpjgfirLtZs/wTW0UBK?=
 =?us-ascii?Q?oHypwcvQmhSS3lf1a4+by5hdO1MnUWfWuZE5U2wfNy54IhTZ9LCqy0HGKXr8?=
 =?us-ascii?Q?uKkgZ59icSoHyRs2hnfupZGJFzxJdIESM2f6dgDtS8P5lTEfJiVU6NayjZx5?=
 =?us-ascii?Q?CKt0y7NgII8eujskzHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqWNtFWRFcOICxTXzyNb5Um2cSJJoWTVrUtEWWSVfbWrnhSK48RmI8cgSAHo?=
 =?us-ascii?Q?lFZ/gMKDjiLX3aECqPKKYRIrgluZ/l/gmnZj+lHnbdOvBG7XZ6L15ecxSMY2?=
 =?us-ascii?Q?Hei7A40aHCdlpEtRx4959eMYNemacObFpNZPMbtojmLpjobcJK2T3Cn5XjNu?=
 =?us-ascii?Q?SpEco+PyXGc4p2uLWW3LjRi6luWpKYqyjAlugSEzqNwCZKWdBZeELbnJu6GF?=
 =?us-ascii?Q?Xdxr7/h200WSUnELDbU3zo0XcJ/I5VimgbtOrzaVB6ezNCB0qmUmUyeNItUJ?=
 =?us-ascii?Q?nvONYa5lbaKzIMjIz/y4qvVtrEK9vwEa3A7DUja1KTfgOKMWr+yDjkI02osX?=
 =?us-ascii?Q?XGHs9UfRL5S3KmBXZEL1Ie0R+EofGFDqAICPDST70VrWiaZ+CUgDDxbcWaaE?=
 =?us-ascii?Q?0fnt8xMHxeNoVeMKMBMfx2e+33mGSZ1AhyYn96hkXQvvfnRhfAZQDu8wFHwo?=
 =?us-ascii?Q?IaaVsF4cuUjd6RDD4dbLA/ZPD4Cb/S4gwxYLcQDTsrXjE48vdlxETIFlNouP?=
 =?us-ascii?Q?m5EQmaJEG1X1uLi5PyE4f6C1bJEC3HsbbIP/JXMtKO7itXtQSR4fr/e4m457?=
 =?us-ascii?Q?PSvzR5jDJtzaWB32KyctlxjiSuWQGCGijpJdLJl85QpKbEQ+v6rZ/sXZ3UZR?=
 =?us-ascii?Q?b0BUfZNhycCun61PjEGApe5UTRDHUSUUAvDlR11w1ShlEpKrrcPVk/LHRrSa?=
 =?us-ascii?Q?H2FS8LJg91dWSrhTYP0hbdQB6Gy0F/t0YNNhaA6fZClnS3onDHfVKgD3OTIj?=
 =?us-ascii?Q?QsEhg5mjdItVVMyk+KVGY5uGLqGxusYMQdJIU0zQonEypEsG0J/+BKOoZkNs?=
 =?us-ascii?Q?0qVTyLGx19a9AgqBhGVdVE0vEJu715y3IqjQfX0G9krvqsTuE2Hyc8bHFEtt?=
 =?us-ascii?Q?G3lOjmkJTWzU0x1j4o7f5JbH0hCUlMocqntsSQUvKKNWXVA/JvrydfEpVizV?=
 =?us-ascii?Q?qkGHlAilj9eSwM2LBBAy6yLz1dANJ9xt8od+wm5HTCNQrZV7sYdKr58hk0TP?=
 =?us-ascii?Q?K3D451sRrpKfuZW11d2LXZfOsB9pyNiJSObty+QL8wW66Z6pRsrsdApgKmAw?=
 =?us-ascii?Q?bcTZe7L7aa/sCTPLYEqgnIuNVfMiB+Ygrm/EYKpLmV4L74+Ph360Iu+qa9Ok?=
 =?us-ascii?Q?Tu9ZPPnd/A3PHaWga2fT/dE5HE/P48OEibLnSgxdizXJragcXDCf1J/LGBRR?=
 =?us-ascii?Q?dMtjYFYaaXWZ9pslWCo6NkHPZr704Eav9xrX2Pr4Jah3RlQ6NbJe5cf6m/ck?=
 =?us-ascii?Q?/aVVMD6McDpPju6b21Q69r3UhpRhQAhVNQqRBmhJPMcY4czKEi1zfS6DDxHQ?=
 =?us-ascii?Q?VEUl+uaO7dLUEGMeOEkmv/NYCVzyWD+ef8FRAeZ5glFymi0hY/OoJ+Vg1Lt8?=
 =?us-ascii?Q?1qcY4y++4gznVWXEz+rItKRTklxJESObR8E3T5aiPp/YNCpfvIT8nGOlYe8m?=
 =?us-ascii?Q?rQJZQmA9jmTGmK8+9331RRSvQUsjEGp4V5DYddnvS/aGNEOBBkERByzQZJjK?=
 =?us-ascii?Q?DXLjwPwrMa1jvI4lI7AZSAZhGOxLmOfOZFobMGb3VMGwiF3+viH+U8f9+4sT?=
 =?us-ascii?Q?XjFIdCPZH7Ryv1Q7ZwoxYR+1d/rBqABghH3H9d6lNtXukWYwAiJIbdQfI/Uf?=
 =?us-ascii?Q?CtPfob/q7pQqwNyBoWtBGgvcFaqFX9auEZYrlluzlaDlKSpwk/wnMF/ZiftB?=
 =?us-ascii?Q?wwhafOHBUgBCMx8OKzkgzrZG6FzJIo07V4sT8g03eL4WJr8s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e45bf64-982e-4846-b091-08de728bf93b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 03:31:04.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXwQklTNX2sOZKkyvp7nWWGPwj/mVEJpXq0F+eJAd8Zx6GJ7kHieu0GvRe3E7A+s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

This prepares for upcoming checks in page freeing path.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Sandeen <sandeen@redhat.com>
---
 kernel/watch_queue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 52f89f1137da..8f887eafd438 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -301,8 +301,10 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	return 0;
 
 error_p:
-	while (--i >= 0)
+	while (--i >= 0) {
+		set_page_private(pages[i], 0);
 		__free_page(pages[i]);
+	}
 	kfree(pages);
 error:
 	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->nr_accounted);
@@ -398,8 +400,10 @@ static void __put_watch_queue(struct kref *kref)
 	struct watch_filter *wfilter;
 	int i;
 
-	for (i = 0; i < wqueue->nr_pages; i++)
+	for (i = 0; i < wqueue->nr_pages; i++) {
+		set_page_private(wqueue->notes[i], 0);
 		__free_page(wqueue->notes[i]);
+	}
 	kfree(wqueue->notes);
 	bitmap_free(wqueue->notes_bitmap);
 
-- 
2.51.0

