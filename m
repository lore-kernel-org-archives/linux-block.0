Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66CD1E32D6;
	Thu, 28 Aug 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390809; cv=fail; b=Cj+UE5OKY0cD5NY6UFhEeUNzYXkUjDshQuCtH7T+Keq3HSswB7m2gvQPZsMBSILGJbs6b4ksXmiCDht6+D1el9b/UxZN9bw8s0MwCR0AQdodMr/c4iEl3g2pJHopjsXg8Corg8yF76cj8OXqE5/IV2T6mhZvFbHBhzSdSRH5ew0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390809; c=relaxed/simple;
	bh=uCuKNofUZ3+ASqWnoq+zM9BFfESMZfSBsBgWS8neuUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pw+MN4DJhqL4+Wq09JsQLE5kfQaHtK4A5MPwzeGM7UGybHaPN9PoRojrtfyh2HtN97L2A1j+WUEnbJ52KMrOeUPgFY3258AD81SyUGh8E7dG6Hgb8YVRcrQkhWMGWMlLMkiBmzz121sa2a7ZR9uDVPEhFYBm3MmT27YGGZ3L2NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHVyRQqx; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHVyRQqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXFlyb8zuu/paS1ZawJ1ZJ1MoYZI9MLnsy1iQRbHVJqVh0OMUxaG8sKXQ9gUCvAmgpV1v8+TxTBEvGBqt41EVUhZjJsJ8xQQf4+cQiifYq6e688dR1E4l+DbzpHWHGlXiFI6tQR39Fc3jFsrQZ0KQU0LXMUS8snCsy5VYFMbglCunUMqSDxqGG7B9qwHJtVHKzu/6qah8xlWSq1+dkTDwCpXovBkSPvriF9V+FcfL6oZyLZfJtx7AyfIu4mvXo+IZgyWbdaOd0nI/bbQiiM6e7X0p5Jx9sBWiUoQFwQt7jhbHb8Cuc4I6WhJxJ+Q++yK05JNtdpvxZ3HFsTR+d+T6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQVNpin3YPzO6syYTrDj2tSQysPubw+YKna9LrX2ZNY=;
 b=vqBL+8iwISAvFAQi32rutRIDaee8G4QXtxMQDjSV/DujYuKdVZjsiXFWkC/PUu74TXfCI8Rb7+6HXdyzo2KHR1HAwpznQ3qfgclNfOeZhrGkDnohJDxP2thouVnCLHhNd+K2rR/jix9XQE0sTVT4IcZXMNFUJJpAMXZ2PZsmAu4q6am5QzEG9sB8EOtKTxg/KzXO81htlhie6Uez48NGNf6/+dnvyrZknwh5ZuQPwn9Sk4xqdnvmWmKuq79H0f//30GCIg46/bNgouKf92uSSxCtvCTu/4gPKSpTKFTuodCXYQryGE42epJCswqNeumNoF74pBLYZLqdQWDrv55afQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQVNpin3YPzO6syYTrDj2tSQysPubw+YKna9LrX2ZNY=;
 b=SHVyRQqxbnE8x5sXZFHYgdSh9gMgMYhrg8yQEA1uYaWj/7/MaG0hgHqYAfEXft1qTfGjKhNsG7Vc51nfNJ1qsCz5HcprFeDpR8TPEvjWZzATxCR3HnoYyBeQKie+HIk73SdCxArm+8p4ib4+F1YWAKZyyc4FrwrGogPFWXSSjz+wWYG/dvpiyJNhKI8WQEITG2Tx1ZUxzKxKh0expT9vQt/t4XihBOW+YCXthtRY6Hp93yitlnQPfrAQUtx8pUqIarwd8oXWTZyshskuugEsv4RRZFzqy/Dvb8YAfAUsgVVlFIkf0lEmJkMLRsFI9zwy34B4f8Imx1asqF4v+lWOuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH1PPF4C9628624.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 14:20:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 14:20:00 +0000
Date: Thu, 28 Aug 2025 11:19:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>
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
Subject: Re: [PATCH v4 07/16] dma-mapping: convert dma_direct_*map_page to be
 phys_addr_t based
Message-ID: <20250828141958.GF9469@nvidia.com>
References: <cover.1755624249.git.leon@kernel.org>
 <3faa9c978e243a904ffe01496148c4563dc9274e.1755624249.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faa9c978e243a904ffe01496148c4563dc9274e.1755624249.git.leon@kernel.org>
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH1PPF4C9628624:EE_
X-MS-Office365-Filtering-Correlation-Id: ee25c9d4-a894-4ec6-2322-08dde63df8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ABT6QTC3/4LJlsORe9ECLURm5FPgYglzP4U8WaOSREO8cESJY67mpBgPEgf?=
 =?us-ascii?Q?MkjBrlOeWvd+Wx5sAHlUUxAypsE3sfz8tRKkX9INneWs2ZUhCuiL+xViVKT/?=
 =?us-ascii?Q?rfMpRQymx+irdvSIp4qZHv0it0sFIEnAypUowzkTqVzqCSgFEN9wpsDQUbug?=
 =?us-ascii?Q?qCBBjuZxvzOKP1cE3SXz7NfTZkR7c2f/KeWbfYAVmhwF+JdwiEsfdIKiKGfu?=
 =?us-ascii?Q?KFOGSgoJegWT/eiZ0MFRxjbwCG+FwEkg81Ukc1BsCPF+8jXdZtJVeXhv7+VW?=
 =?us-ascii?Q?h698g2uohrUxw5kkLDmqSBPVhg8ilvnXIutPYKjCAt1bMWYT3SVpW+eR99yn?=
 =?us-ascii?Q?V2hYNiLmkVaSAtGxDbv2FjU7DY4TWALSxOsgPymNrMjpcwvEPmg9iRhe/Kak?=
 =?us-ascii?Q?emtDF8WNI0h8UDSBKFdP2kmXFiGT9OpfHXOUDXYc0EyyoNYemlSR/WNEP8fw?=
 =?us-ascii?Q?iIxBcNn90ffR5b7+rVNjGlKo0XU81sqQRBi8X8mYq2jkXCEO/peYXNNRemHT?=
 =?us-ascii?Q?42p6fIV0eogpg/mvjNqfDzp3ArXrvuenVv/BvlLC0kDzmZAIOPwN3QdIOuyi?=
 =?us-ascii?Q?W5TJnKzgtNhmJnfCWp3jVysjCXd9dWeG7RuRghEbc2RH3Uy7bXU9SMn8dmf9?=
 =?us-ascii?Q?gpARsIUsJQqV2u91jnjSMUrFMRwiOwFxNW/y14lTJM8Zm18iTTRBjdBArogn?=
 =?us-ascii?Q?l32UDaIh3XzO+DR3xPn3Mja3Jzx3n01d+9vrDjvg/iV+yhn+FTJR9fY3oHV6?=
 =?us-ascii?Q?DMkOurjB5PukWMJDHBEc7Wi/WC2myrLMwYL9/39GprTbNLrTUexGld9LH1qM?=
 =?us-ascii?Q?rwGb7NwkfSSKgaz8lA0b45FLXa2uJCydXEhmG+J9Khp9uo0cnJ6Q+DBykbAO?=
 =?us-ascii?Q?W+/IAB/HpcrmMyzu3DIe1rXsJEZWw68SSNF1TDZgDOTQJovBXejmtt4GBExT?=
 =?us-ascii?Q?arBrV3XY04TZtmkEMb/4I8MSuMhMRiOd8CpHcvT/+tYP1p2QFOBQ1gIgGsPW?=
 =?us-ascii?Q?P3ICz7+xrw2/1SWkrb+ev8szOepdpDazVU32e+meayOMKWf575XW3D3a0gxq?=
 =?us-ascii?Q?Qfm5CLQQ0CT0QRq/f8LXBnRon+W9NZws9+kPQjiW4Y4ZZFuQVA1NXi9RXK2i?=
 =?us-ascii?Q?7d109Wx8+biBFpwcU3HOHUEZ0TsZ/y610sjQ45jorO+034WU0/zvgFG06Jxf?=
 =?us-ascii?Q?V2d72ZQL2rkiFbwKS0iOquz664r6LYn8VYdwO3xjMZ19nsn4SoO/cQQ7u1g6?=
 =?us-ascii?Q?kdNWoNUZZHdwDj1fesG0YxnkIrkDOakzRSpKryPitAhtawRRPfI+hNpj9aWh?=
 =?us-ascii?Q?ZS5rVojaCrIdUpbyZMPEv6trU4xPtIfIjmPI+hbXqgQadAMblXKCk6rKTX5S?=
 =?us-ascii?Q?a1ybeGPwK4NZcscvfiQySo2DML0nC9zFVon4MrwW6ODFN3spzuJrWfsrMo/u?=
 =?us-ascii?Q?4dmb68jk8Mk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GKUUMy2Zjj7bShx559KxLONxcEVScGItWUxoqpIFyh6XEjUtYEUSckAJ+VS?=
 =?us-ascii?Q?kRzeLOB37iyFXOukUG7mg8GSDXvLhCpRyfX2Oh2Fb45BNBhk2yEjnScpepNz?=
 =?us-ascii?Q?860jrVAdoO7ibpqBpfTD7zWlzqL9z/qjFMO22UMNfFrKPDrgiAnj//751W0f?=
 =?us-ascii?Q?WgWHubeAyDqwC5yntQuyj6PL5b2TYt2qobichzmcR75vrk+NM/omSaTnnokd?=
 =?us-ascii?Q?Hpd1UapkTBcfXsLjl7nMedjcjweiDkFLayWNjFiWrakgqmPVW7dziEmj43Wk?=
 =?us-ascii?Q?7ArwEpDKMyEo29afjiHg1veE1ewj9ao/+zS/WtDRHR1jDAwjoReLgRQDv+F0?=
 =?us-ascii?Q?03Z6s0dGmQsGMrJf/HltN2mTRCQ6IwYE0bHRLWqs9WMzd3WYTc5uuEBjZP53?=
 =?us-ascii?Q?0Enqlh+gVu673+0LDZ68ct+H3O6Unvf5NGCys5nRPF5LdDs/ahP6EB99/Sv3?=
 =?us-ascii?Q?UFTwKOm1WhdIHaBjc1VXOw2aJRSVENv8PLKhMa//9GsecikRKp1NDpBOxs5R?=
 =?us-ascii?Q?VPYBNKjffDK4iBHlfTrKx8n+pHYtwF/RsOlJTwF7Mpnktir+QiyPsxOBdldw?=
 =?us-ascii?Q?vUqPHod1VFyNkRyEFzZ9eTFEE7l5VqNTzRnWvivcB3TE9LxmDNQEjYDF7nFM?=
 =?us-ascii?Q?GP9LZ5v0U2yHhLn1RIXToR0xKkZ0BFh5+Y9ybZHAnURd4i104GJKlScvbreR?=
 =?us-ascii?Q?Q9BMdB37xbvftod+QfrHsm0p9YOsqOyVEDjNYTvAWUyFia2Ey7evm4ywkYTx?=
 =?us-ascii?Q?h+sIu07+uvh7racJKS/Z/xCUkTsr4GbLeZUv1lS4aPyxO96g0VfYbHgVQzcD?=
 =?us-ascii?Q?k5c0Vl3y01qhuqDwv+Nsth7/Rzh+5Hqakc84qx1CzTkWbf7bqkXsOWx/2Hsh?=
 =?us-ascii?Q?NN6DB6HizNh+TeKEGIgD42nteot86FM/EEGHVHo7x/qcGaj/but4TVQk/K1v?=
 =?us-ascii?Q?vRMaWoZ5Tmk15q3Tp3aP1129Cnt+dMu5WSWbuAEwJnbnczgt4XViE/ZqKX5V?=
 =?us-ascii?Q?nAApv4rOScsaCsker2ICS1EVqZ3/ze2jwu35ywe5GC/sKyuryKQx7p/CPCZW?=
 =?us-ascii?Q?1FkX4ls0qo86wW9mXmendEiz8R5CBLzpFzYmyhMM0O4v5MSi+lhX1rjl576J?=
 =?us-ascii?Q?UDlXc1RprnpiHUBQpT/3CTXFW0R4q/D1rdUPqFnFegBGw8wLZl1G9kZrzPjV?=
 =?us-ascii?Q?kyIwSDxl+GlmU8WG9ODPPzMraHCdju/SEdV5nGXP+idSzYNyGyCRO16YHz+c?=
 =?us-ascii?Q?sgsQzLW+SQbh3kOfIDKy7AnP8apjMad3QeUKs5Vbxiws6DJVnk+kC1U9aI6W?=
 =?us-ascii?Q?bv+N+M2QWywysxu5/R5s9QqPWKcCLYpk9UwU6vOhXOGTx/8ehEeRZMTzpc95?=
 =?us-ascii?Q?gXE9x0w7K4qqhLJQQoZNDRAdSzebrIqL+phygzWYqpV7kOpxvx9KOWMs5uNs?=
 =?us-ascii?Q?XS1HhwwV9Kh2B/aqy05LWXl9uY8kXMVVN6K12dkxOz15Hc7B5X6BfCCDydhP?=
 =?us-ascii?Q?fQxez10fHoATxU0Sj/6J8X7LHHevla7d3+DBz+Oze7OmFlVBqnJJsa2/UxPp?=
 =?us-ascii?Q?uT3klxfrEJzyDMyljFs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee25c9d4-a894-4ec6-2322-08dde63df8ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:19:59.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MleWSaT+fPMApu6hDDjuoGGeeHk6jrZi5TxdTZ3vJyLRcRpsAXuDhi0ZC+bhq47a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4C9628624

On Tue, Aug 19, 2025 at 08:36:51PM +0300, Leon Romanovsky wrote:
> +static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> +		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
>  {
> -	phys_addr_t phys = page_to_phys(page) + offset;
> -	dma_addr_t dma_addr = phys_to_dma(dev, phys);
> +	dma_addr_t dma_addr;
> +	bool capable;
>  
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (is_pci_p2pdma_page(page))
> -			return DMA_MAPPING_ERROR;
> +		if (attrs & DMA_ATTR_MMIO)
> +			goto err_overflow;
> +
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> -	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> -		if (is_pci_p2pdma_page(page))
> -			return DMA_MAPPING_ERROR;
> -		if (is_swiotlb_active(dev))
> +	if (attrs & DMA_ATTR_MMIO)
> +		dma_addr = phys;
> +	else
> +		dma_addr = phys_to_dma(dev, phys);

I've been trying to unpuzzle this CC related mess for a while and
still am unsure what is right here... But judging from the comments I
think this should always call phys_to_dma(). Though I understand the
existing map_resource path didn't call it so it would also be fine to
leave it like this..

Alexey do you know?

The only time this seems to do anything is on AMD and I have no idea
what AMD has done to their CC memory map with the iommu..

On ARM at least I would expect the DMA API to be dealing only with
canonical IPA, ie if the memory is encrpyted it is in the protect IPA
region, if it is decrypted then it is in the unprotected IPA region.

I think some of this 'dma encrypted' 'dma unencrypted' stuff is a bit
confused, at least on ARM, as I would expect the caller to have a
correct phys_addr_t with the correct IPA aliases already. Passing in
an ambiguous struct page for DMA mapping and then magically fixing it
seems really weird to me. I would expect that a correct phys_addr_t
should just translate 1:1 to a dma_addr_t or an iopte. Suzuki is that
the right idea for ARM?

To that end this series seems like a big improvment for CCA as the
caller can now specify either the protected or unprotected IPA
directly instead of an ambiguous struct page.

One of the things we are going to need for bounce buffering devices
like RDMA is to be able to allocate unencrypted folios, mmap them to
userspace, come back and then dma map them as unencrypted into a
MR.

So it looks to me like this series will be important for this use case
as well.

It looks OK though:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
