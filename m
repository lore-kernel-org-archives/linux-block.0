Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EB1E0083;
	Wed,  6 Aug 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504798; cv=fail; b=XvcBAHmJJ9QgpuAWgJXzZ02NwtlBnb9or08QW7yW48R/lXFXZ5hRFSjRXnPKFdMEodD0MqLUALn0MrcYJ7Dn/e1ZhE1cccerN5s/78d9NIDh0ymBa9av02w2DH4rHXOVNKlb/FCWmKsku89i6og4fOxZuT2VxuMerNi6eGjbZhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504798; c=relaxed/simple;
	bh=e6ac7vCwRfIb2bJlL5w58BAf5W98XKZZGiozsdNf3QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QZhe8k7bUthFXyq4ZEVlouXruOd1gVLfpaFMXogbUUD1iZ4PFZFLkWR6Hl3WR/KYdqB3BsoOUULz+2wTSjyffzdtrQlz18zpX6fgLuPZQQ2v/IgNXu8Yt4lOs2BoPKf5ws/CQsGeuSucWnrtWDqqhpByp3ofXMA1AVeMU2hUBGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3tRof7+; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3tRof7+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3oX4xKZrDwVMMnEgEiD8rNlrQo70s1Wnjel/mq8ahJBGHInkP2D2zAj401xXMBM9gTx3zrm4+MFSPALjx4xydi6NDqsElJJZ4hsfq4HJAGExDixeglhtFSmdPv6ppokj2Yj7/4NHvG+0QYs0pBx8jYs+otNzi0RaLmHXSh6ckgMN03hZSldHILwWL2ScGsbejCU20CB2pRelYWerEJfnx+aX3He0qBThOVi/OhmIrgRWfQt1Wh7OqXPCLVuajCd8kBOqYx9pH9/dGtnPeWU2p7+QS4VV30o0td4n4tmNpQn24RzQadcg18HdchJtkjrg+XLUscWfyHwfkckhc0tWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKJXQxXxfUIo4tLv3CJl6XJN+6GoOozWS8CT0poTaRA=;
 b=kiakdUudtbZi8emOq//VMD+aVo2GbqN7rv7GNnYKhQuloGMtgJNifUOyImW+84NupjZ1s1ZExbhmttSOZIz3prHNixdOYoTVNi/qN8rHYMdyRPFRg5LIpFnlZ/RXVcjW37F0xpg7qC3hhAZ4aFjOteU/dY31t19Pq/qVkgHlqimNC6aOvAaTldshJFrU/olOebipxFGAg0TWD8UYJw4Rh+Z82k922ZEyQJj4bSMTIZmn81Poek2xicFKuoqcRZ8efXfbxm+SGXyw3DXqrvWsusgqOcpEfySmpK2uUwvxmJhamDYAwBMyrntHiWB8CPdwvMLB+3n03jeGtcQ74R4nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKJXQxXxfUIo4tLv3CJl6XJN+6GoOozWS8CT0poTaRA=;
 b=l3tRof7+xxY2WZnQbqMnrPTyFo6bB2KhEebXASoWrJBaexBnyWn3Jid447R3/Sf4912m+R3EkjJq+hclLwVQ7buSDqOCwer2ijaLyWuTgpT1XtrrY+vcKJFv5xCdkEnVL2HLnznXPAL5zAt9eajBamj8Xv4jwkmLtjYCHqA+ddZJqa/lE/LBGs82Ob3kSVbYPTRNuafpsYA1cJBASQbNQwtWsN9z7PtVxCfRAyfBZfc/O7+OrRoUvdrXSzSSQRC++csKm9CCNmYRvegGyF7kMIyiWxLw8R4FLrFy2B6vbqPx4jRkTvYF71TGpGrGe3ZsFhA44GVs8WkPVOBjhkvcLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 18:26:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:26:32 +0000
Date: Wed, 6 Aug 2025 15:26:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 03/16] dma-debug: refactor to use physical addresses
 for page mapping
Message-ID: <20250806182630.GC184255@nvidia.com>
References: <cover.1754292567.git.leon@kernel.org>
 <9ba84c387ce67389cd80f374408eebb58326c448.1754292567.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba84c387ce67389cd80f374408eebb58326c448.1754292567.git.leon@kernel.org>
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 632cafff-faa6-4b97-1b4a-08ddd516c47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owwpIJ/gX3NA4KCET+gimZq+FN0PuqQRzxipxevMPQb7n0i1WlzUqdFghi1S?=
 =?us-ascii?Q?19j+fumHYhWIjYAt58XbP5kKw0Ag6bpTz7rqSWX14k0J+w1uxD5SQzffX0oA?=
 =?us-ascii?Q?88/klCZU/brpMZz4Vo3dKsm+3sV6mHWTq+J1Fj2mmktQqG5y4NIJlQF1PMxj?=
 =?us-ascii?Q?Q4zAjL53yS0gcNHI/5KV7YERbSqdUPJUN/NaBsj+xfNDtKio8GXergY8uEEi?=
 =?us-ascii?Q?LEblKeO4/6Bwwml9K5BYoHIYHgdTGMgp10h0zhbZROA03uktm/FXzLapriuO?=
 =?us-ascii?Q?h8/KRarclJLPK0LnzRQQdchLSIeRhTGdMClq1ot8GQ30HUoFALDK/gYL2fzD?=
 =?us-ascii?Q?A0GeqOL5tEr+h21tfGfbu1Im0B7hjYPFTtd9AbRbeGdP43+JGj6dSxRdzNgD?=
 =?us-ascii?Q?Rs5abEENCmVlIWe+2wIU4DSMbJ9cocIyDrIui+iaETu2mR2uAKyu5xQxVHaZ?=
 =?us-ascii?Q?b34HTnzaGR5E6t0czMbcLiiUn3SxBp1RBFMvdYhYf96mY5m6juW54xR+jw3d?=
 =?us-ascii?Q?J1vTY0No7me8p4MCd3boUH+H55j1DJr1ynbKGjq0y5YGroUKcxdx/3vd3XPl?=
 =?us-ascii?Q?oSO+GWhSn+pBsg3tWgxlrEPC/GL7RAmuBQqxMBBrSNIixJUMb078qi6oZT8/?=
 =?us-ascii?Q?jv6iUD/p9tINXqWW3VePWXw+ilS7kVXlltY9ErXIUNUD3bMTxDW7ytPsmzZN?=
 =?us-ascii?Q?qR3DmMXglGcVshD2/QHfNrkWxaYWH1r2Hth+ZscjJjixAGNnqvVbr9OTeV1n?=
 =?us-ascii?Q?tjxQBFAr6QU3Z2wFMd17o7JNmc9H8Vu9Jt3JuKW+wyyBaTegwtsNs8jU6uIP?=
 =?us-ascii?Q?GpQRfIz0vj6rSmsBXPq091G3jMrNIVKu3tAqGi0otfXtNiR7uyQqQAm2J0M2?=
 =?us-ascii?Q?tX507FnQ2r1nHy6GhZT0+hy3WwS+8WDJXI2V/Xd3pyAs3wasL7pS7fUFPEJ+?=
 =?us-ascii?Q?A1cBy3LKeusKiCZVG1GHgP0k2MVqsrnRhdJ3yzjW4lbLFEZ3Iml6FKZi9AiL?=
 =?us-ascii?Q?ShausgFGQY6fuIJbjRxbcdb7V9Jiu5QdEfZVzvka/u0kXzIsche5PpSMHtMZ?=
 =?us-ascii?Q?ovKUcupTVZiqr5NX+oe1k546tROh8/2lY9PKafLR2YlLzCNLbPeLCWbmu63r?=
 =?us-ascii?Q?ebFwAfhAZfCoj0FHsvpowjD9e4aAPVMt42Mjui0CqRb8E+nI3bH1Ra063tef?=
 =?us-ascii?Q?fYqHKEc5+swy6EanZNW8yQfkS/+U8Jsn77sSaAWvQb83NqQnvbGWk3V202X4?=
 =?us-ascii?Q?Z/RVwduZChHGBt4zAOLato0o0xULnyiNcwej62TIruVz6j+7iZvAttLuWO88?=
 =?us-ascii?Q?ZvDokQKXbpNKsSBfd1tuMiEQEuQLkFH0JGV7YTRYVKG8bv2iH1Kubv+ype39?=
 =?us-ascii?Q?djF3iDL4dv4Yc8vRxDpa9OjtODHldc/4rM0OzlAbAMrP0kXfW9ypYmSStf15?=
 =?us-ascii?Q?9nk4T6yL2AI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t39ZrHsSyipF2FxxWvOCrpOiCdTa9RlbbmJcEiSd7/usPKmN1w32/HQ1aYbo?=
 =?us-ascii?Q?j/5Y5e0l+3NLEdR7e93EiSxB0oqskwO2H7It/NFd3PGm2rCH+ioMm7swn09o?=
 =?us-ascii?Q?lLJYuIAo+jk/LNlbBhif7rAbXEKXl3rXU3a1TF7ITt6zAA3u/5D7+6w8whkT?=
 =?us-ascii?Q?CVZbVRXFIFZ7iAkoBRqBNNMVTNGcvq//axasMan5txxNMZctNZKYRTonj5Zn?=
 =?us-ascii?Q?Kxor43X2FR83/bVhHWzhDVYgC5h4894y7CuYyfzKJ1wh7s//ZDgL2e4j4PhM?=
 =?us-ascii?Q?cMGJdRCaUXgsocsf9JS1+aL8Zo7DfzJ6J0pqt9Bgt0lb4xEcbAIB4tAkPLpq?=
 =?us-ascii?Q?zF2mvzStnV4S7ILBLVDNaMmfLFlYkOsTKUmHOmbjnl9lgS+8y72yI25f+zm7?=
 =?us-ascii?Q?VB6avAtH6rXq2f6IlN8CFOd2ShdIVMae+GcZ9IGH0/XrtRR+4TbFoPo7zri3?=
 =?us-ascii?Q?Lc9pzRkDJ833W62CQv6mOhQiko4WpHS2ExgKfqMI2gHQdfNKm0n/JKG6irkH?=
 =?us-ascii?Q?cDwamegxjR+CmPKIr9BNCNyW+6ostD0jXjRQ5haDMaAXG0y1hSHLuI09Okmy?=
 =?us-ascii?Q?srUa0Bel5tIt9YHwdqIMpqtx4gC2y+GgnFT6DbwvXxlmhcvNNu10QceqbXpb?=
 =?us-ascii?Q?md2BsLbubZbJYOvTHvqqpfjzYCQV1+O2cC7Zrg3URLW43Db/oWeiQpg0hbB2?=
 =?us-ascii?Q?zrw1a0qQ4aNYuX24Nb1U0TgBtOvz0txjIxMjpgKc4k4X60ZN2Ekeuy2Dl+/T?=
 =?us-ascii?Q?XTbc0+goCnOo9b/HxrK03gG5mt+WI4ErGszYXmNhQ1w+baEihkbqc1VZZPsX?=
 =?us-ascii?Q?yMZIVy350zZir+594B8HugXTTsLyvokgnUaVYhU+jrQRLEIbjVQCnsHLFKkP?=
 =?us-ascii?Q?F2hBYjGg50K3TpUniBP/5U3j6Au5BRtp6FsqHNvUVqOvUvQQXg/8h1cU2N8D?=
 =?us-ascii?Q?jCqAIyWJOirRho6xjjYF5ivS1MnJuEBYW/LshV423PWK1/kqIgiW3Vr64amF?=
 =?us-ascii?Q?+ntWBU8+VodOuYF/C8+uc3mSRjg+yYv9qnvDYyjspvEhb7PqErKztqzAn5xP?=
 =?us-ascii?Q?f0ay60/QIlHT6KKdynA/akQFVMESmJisswXCL0IVhWKwTKzocWh3Va5yq+ew?=
 =?us-ascii?Q?7AqeJVg3xG7+L/hCVPqXLh2M/Z+jpqFrqW+NkrzJZTr6lXXrOuCihasacQ3H?=
 =?us-ascii?Q?Yisd38CjiZTcD5D9yKaSEgaPNHIk9Z12+MPqa6pLiIJMMJuVQ2mR8iK/D2IV?=
 =?us-ascii?Q?F8ao5THBiVMbReo83xNy7mqfO4OoofdDQ7258uW/2/scAV8mHZu75y8uAY6Y?=
 =?us-ascii?Q?W/dzqqF9TZ3svBcvHCLDUann8lFvwTu8tb9r+8xE54jp9BppaKQkO4gawrUe?=
 =?us-ascii?Q?Mf1QCEmFJNxs8vTx2+il3bYtwyrAaCFkICKFjjCIYj22ca1P7/gBXhIb35gs?=
 =?us-ascii?Q?EH6jU23VieGh3yAXEHv8OJ2rXwfzatF23k+gR+qTlzXeUwHb0eXFNe/2Rpjr?=
 =?us-ascii?Q?m4zoOR8wSjHBOIwyIfs4ATrvfFrZgGQYOTAONPHxiKLdbDQ3pDQHf2E/hr1m?=
 =?us-ascii?Q?6Zn0o1VaFz0u1AIxWW8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632cafff-faa6-4b97-1b4a-08ddd516c47c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:26:32.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQMRHuo2jl8akCW9nlaZJvuQAC3fHS2K5cV5C0IU02DKbHti6Tp+SLWOuo4/pZrj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782

On Mon, Aug 04, 2025 at 03:42:37PM +0300, Leon Romanovsky wrote:
> +void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> +		int direction, dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	struct dma_debug_entry *entry;

Should this patch should also absorb debug_dma_map_resource() into
here as well and we can have the caller of dma_dma_map_resource() call
debug_dma_map_page with ATTR_MMIO?

If not, this looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
