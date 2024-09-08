Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2114.outbound.protection.outlook.com [40.107.121.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E35338D;
	Sun,  8 Sep 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725779954; cv=fail; b=KH/71qgW0ljK4wkUcDJ3xsv7V8VCd9OR2nHkUdPQzXAjRhQpgjteqxwb9ffqPIVGI+6b3zKpzmhdBFOfR6JE28imz27zxtzg328dbZ1ubPstWiixPvt0U33uPYIgcutwcFFJOUm0tEhEgkx3cBiFXvbr6IkZGaKDzU/u7jw3do0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725779954; c=relaxed/simple;
	bh=PtlfoGiXL5PzfkRj0HXZsFeBphDa4KmVT5OvFzElfcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJdoW+Fh9Z4r+fihbmu/HedywX4amyDd23hpFgX2qGx/NmztyO8H0HppQPEpP/kbHG39Q3mEqRpzTFwViBCNn6NSfAkzKwTI7EO35FNaEAR5GtRs2cZa4vI8O9ZVZ2+l2nlO2eT5D4v3k6OC9d3B4nu/oACtm7t/Y662BwUzJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LpXAmQXE; arc=fail smtp.client-ip=40.107.121.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LpXAmQXE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzH7/gjhLzBh4twcDcNn1cHfpLkIEjCuKaKwZNIvYvLeea1llTjBJm+TUxPpGWh9a4kIGq7I0XQMZp34/otMIgw2RJpH7QJLWq+Ao6TkPNdccHtOS+r1wB2qyYF5VLSBesgL++hlG574iHRwX5Cn1IhrUn/cfu6/uFDIzH0GJqk7oICdJuXQCtfDtnfgVM0zZVhbu/CxFtTtsYoBx08if50gqi9NQHfseYf4InQvrKCXac7yHLITxcnVSNP1XTXzCIlslTRtSCHkJFiO2xMcFELxMMx77Yja7fBee5nacPAESxYWCttPrPobMHI2bYrsgkgPz3iooDj6urOlI3WiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZQ/ac/ibstO2sQ9grAwXiAhc8xv0iaNZIFa0E3ygvc=;
 b=eCtiMkNqWLNQV3RLmfHzL6wsfH5iOV4PcjsWO5cQG+dMbvpgk53G9EPUSCHXXrw9dn/xQNhrmnJRs2wH3WxObZWufbIwW+8Fg27IeS/HDf6OGSNHZgr9jsNhvubAerScjnihKV9f2UWq/C1Bx7RczT85UeALBJY5ZqSWpYlRP1s3JMGgNp+aqd+P0E2CFJZ2G7/1lyXWBOsNpLxl7b2s5OS1GMQo8xh1jzK3hQlCyv9/aS6BONk+woRarDLd532/1pxGf1NSwF5AtpYIT5nwN2qUJ53d+2NAVbTrSWNkOBHucgBUtdPcdX/x57NMpMetpPuervmhJDlmcdl5yDR61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZQ/ac/ibstO2sQ9grAwXiAhc8xv0iaNZIFa0E3ygvc=;
 b=LpXAmQXEvsLNn5P1FnhdlC8d1pU1C4iJXzrs5KSStQ0EBgpWQ7cA68SKC3Czokp1K1Dy73vr7LBLg85ejXuGs0PsbBUKBaN3HHBXabNFB3oSQjVRtTntMk43ELf39Ytwb38L4VuzXNxX5n2hijZaJtgQ5kKcb43PNxDAE44sgUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6137.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sun, 8 Sep
 2024 07:19:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7939.017; Sun, 8 Sep 2024
 07:19:08 +0000
Date: Sun, 8 Sep 2024 09:19:05 +0200
From: Gary Guo <gary@garyguo.net>
To: David Gow <davidgow@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
 <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [RFC PATCH] rust: block: Use 32-bit atomics
Message-ID: <20240908091905.1592e819@eugeo>
In-Reply-To: <20240905061214.3954271-1-davidgow@google.com>
References: <20240905061214.3954271-1-davidgow@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 731e6fcf-dc43-4be5-c149-08dccfd6877f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MuxRH90+V4hWVmXui/wO12plek3wgs6YgLC8zDmY35baFct4EBy3H7S+qqII?=
 =?us-ascii?Q?s+kTQlZm1v+DOGPzvncHWFY3B45Vh4uYiV762s6MHDUFLxLn6oIW0xSOwN9O?=
 =?us-ascii?Q?DyKJxzxXex1lBmcbbYEggDGlZDml7Qkg41529ukp5bPs3cNZLjCnrwYdc7Ki?=
 =?us-ascii?Q?YGpf3jw+P5nvrxg9GsBGiLvuMyLUMtR6N98NEXTu5pnE0pKep1JaK6hXbWLV?=
 =?us-ascii?Q?fEtKCLBs0KLydVdQeJMWaBsatMO1OY2GWv8oyoFdj8WB3ED0WwtSv8VEwmT0?=
 =?us-ascii?Q?MDZFKTLkbJOZ8+L6zh55mLMvJGO5e8hB1boHUT5FxQAwuj6+UhS30AE+d/Qs?=
 =?us-ascii?Q?dD4hBGFQowMv8U5ZJ1p7L3eQT/Tm0qFXS3Hr6YeSbjKjJJ7j54AG7mNHhxik?=
 =?us-ascii?Q?4tqXUoUJcCovtd8knTD9xuVxhnhhpbrpfB26txuERyraniltVnhih3gbPsFw?=
 =?us-ascii?Q?ixDnbwSrKARKz2xmPJGCKlAMtcaapgJvj3S29Hy0KTBiN7sppTv0GdpYQH+O?=
 =?us-ascii?Q?TOSyvnvBueoaC9mEb3V0fH33GKGjrGj1DOuNKE7Yy0k6j8nZ4eHETC3C41D/?=
 =?us-ascii?Q?J3sjMpZGLZU5nGhuQ+RudtxmbisEu5nEyPXRmRCUMhDphIMIL0keZ0TRaL2K?=
 =?us-ascii?Q?Y3aEUD45xAf36lRUyY3NemEGJRxgh9nNygixYUE79BzFhPv7egw5Oe2j+zzb?=
 =?us-ascii?Q?rm4EB2GyVmMA34d0JPeTRVKSdkaFpeCrFyXtrg+V2lp2/PhcNViNHxfAJyuN?=
 =?us-ascii?Q?+/nbosiP2Ee/ugWgR1lxwyqSxdbFHKKaklRg0XaJiK9tCvd+kMR7Sh5Nn55P?=
 =?us-ascii?Q?IsVM1TRpHAQReBwpzNZykTHf6PtEaJ5gkJ8+kkEZ5YqiEM9vxpUqheTuSLRW?=
 =?us-ascii?Q?Czc8U7jyKXIzJ/OTApscyURHsGQIDyHxfo82t//7nwkzVskmSZAZx2rVIfcu?=
 =?us-ascii?Q?HpgZ4ZaW/k8z+WyxRBQdJVe8j/WVF/UNUlt3Wu7AdoyKxCtTQte1ChLG3j9N?=
 =?us-ascii?Q?CvYwiZJbe99OcEjh1Vp7Zl7Mrp/qhfi9+D95kNfo3yG/4hiOuDLJtTs7oR9K?=
 =?us-ascii?Q?+ki/gRirUnq7OXitoDiV8AkLt874uTH+F4cBYUzeOK/UHz+2TTaptqoe1Uij?=
 =?us-ascii?Q?94cDVGxUiKwfwQWUwMn5H9sfSM98RiIzFbOpqIuextNC06xCElEuNPbu/s53?=
 =?us-ascii?Q?y175q1IziWv93za4U08qXAUf6bF5usMiiMQEXveHK5x6BrZTFTXxy8Ud6zJH?=
 =?us-ascii?Q?B7oc75qdBY1X2iR+6CN9CG71BEh7caDEnY+8PvfMPLeACk8nupNVahAwumWT?=
 =?us-ascii?Q?q3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQn9au2M4IGMvlPP+1qyPXmBsuVuUmgbAM9JrKP2/sEDORwo4b/jLoS0ysoa?=
 =?us-ascii?Q?cM9xp/KiB3C8VUSG8UcCL9DiK1MEEjNm9zeBwdp36bgYULKPavCPDHKw1vrN?=
 =?us-ascii?Q?aBYTIeNAf8HCkWULFTLzkU9/E5hTu1lmpfVJ/VdoJRoU7+rK1LJ4AtD6jgVR?=
 =?us-ascii?Q?8zQbywYXHEXSKAewjzu7Jmfb6eBE+u1k6zCDfUyqoF0ofFDCtVtDx4We7NzR?=
 =?us-ascii?Q?Wi7FahAW9otTakf9gu2H0AmAFea56TQ3Y6Vorkr1gIExG5MOdaGU73SRgeK6?=
 =?us-ascii?Q?Id10WG85UbueHrBVi6bPF76buPhltG9/dyaw0nzaCczcPYEExaSW5QNs4rL2?=
 =?us-ascii?Q?vkoqGo0/e3W3OQpJCmUDRAjbAnRtf12kThZzAdRcCGC6rWIM20kRdSTpDFh8?=
 =?us-ascii?Q?0nyJU1Y6fhvo984n0W5iLE8btLJZjWHJjOZrI+3Zr2LOVUk94Th2MSbn++GQ?=
 =?us-ascii?Q?eBy8YBd8+dxFHIoZFxwB9BU4qPOCQCgmpGsR6WTL0+iBDWRN82JMunDnXvLT?=
 =?us-ascii?Q?BJ9AoKz3wN9NN25cN9ER0hwnr88RJ82Cip+2b/qmVPNLKx5IcTvKOsJYHc3B?=
 =?us-ascii?Q?Idxm/3KDbjUKGYgd0+1S11xK0TF1ymTk1+Oi3MEpA/XqGktLqeRUEd6tUvMX?=
 =?us-ascii?Q?pwCyVH6ySg6/GOgmQ5srp2FLDqdwkdhX8L6zBDH+Eo6rI8TWymUbFFVkKI57?=
 =?us-ascii?Q?3RvoLgFtyvQK3OoHdgZv45Oc0LsnGrg21u+43BBous4z1exVzV3cq1FXnwv1?=
 =?us-ascii?Q?gJyfVbX7RxccH3eSpWK17D19YShATWScWHsFadwQEVKGkOYQSCHxknJIjxO0?=
 =?us-ascii?Q?ZhAwOAAKH+/AOJ4NZnV2zteWxDt9+ANEubhVoo5yXbb+sKB61c5VLyEPSgJO?=
 =?us-ascii?Q?S73Jc5G+HYnDuV0ifO/SiHcj2ptZw1nuOmN5sfDISXdWsSsxDWU52MC0IBsq?=
 =?us-ascii?Q?WDTfX60IMLYvINcSH/4mvgbQVCyG6uqjVUm898if1Lch2EWXnt27Moaa+PM1?=
 =?us-ascii?Q?aR7aCq+Gx5jPs003xAaaaDaZ0BbaAB0o3BTHXZdhzFFIfom9vtvogQ+WnSXS?=
 =?us-ascii?Q?+HjGRK7ukPTugTfs9Cxu87JskHV9zooSiUl/inPbspzga1oTAT6dDJVa5MYW?=
 =?us-ascii?Q?y6VC8wUtcq1I0QQcw+RYjvAlIyazhtGkNVBWQJXspVu+KimmtNkN4Mq0joYZ?=
 =?us-ascii?Q?5KfLLFt1KbxK1RncrDSRUb0P6GHZh+HtYIU9WdDBD5zame1X7ftn3j05pdgp?=
 =?us-ascii?Q?tgdLDBjuvV1b0149m9RcoEKEXGp7LqB6fPeTCRAZfL9iFNYjj1dISNcuhN5V?=
 =?us-ascii?Q?jq96IkCSr7ZRr93fnkv/1QenozBAcuWEjZamKt8lWAO6btW+oeIyAyewoH/L?=
 =?us-ascii?Q?hVH2dPBh0xV2H8OBtScQGwudgOunHlJIEVDjQxBkFOEyHoZIfxNvSsk4enwc?=
 =?us-ascii?Q?MDc03BdkRQxSsRz9Lb6pniif0Md6Xf4yBs1jdqBPTapnV3qzMcnYbbDAQbkM?=
 =?us-ascii?Q?cdaES7al7Czw2XDjea3Ct6GfMrcfO9ePJ8tngu//iER5uddkfDIZn1B7Vpqt?=
 =?us-ascii?Q?V2Y714h6ktbT3yzjizupwHYw5oiRrr1n0jp8MwpY?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 731e6fcf-dc43-4be5-c149-08dccfd6877f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 07:19:08.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aPtWoybXSuFTvHRZr9anowrcI0MaovdhpQIgOrxpvTI2sx7xw+LdYah/c2uxtd28KHwwWPfT/C8yCWLFk0YKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6137

On Thu,  5 Sep 2024 14:12:14 +0800
David Gow <davidgow@google.com> wrote:

> Not all architectures have core::sync::atomic::AtomicU64 available. In
> particular, 32-bit x86 doesn't support it. AtomicU32 is available
> everywhere, so use that instead.

Switching to 32-bit directly makes it vulnerable to counter overflow
issue. If 32-bit atomics are to be used for this, saturation logic must
be implemented to deal with it.

Ideally we should just use `refcount_t` instead of custom atomic ops.
Although it appears that the rust block driver needs a cmpxchg which
refcount_t doesn't provide.

> 
> Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
> won't be an issue, but it's not supported in core from upstream Rust:
> https://doc.rust-lang.org/std/sync/atomic/#portability

Kernel has a 64-bit atomic implementation which is backed by spinlocks
if the architecture doesn't support it. Although, I think for the
purpose in rust block, it's unlikely to be necessary.

Best,
Gary

> 
> This can be tested on 32-bit x86 UML via:
> ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y --kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n
> 
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Hi all,
> 
> I encountered this build error with Rust/UML since the kernel::block::mq
> stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
> is correct -- please correct me if not -- but this does at least get the
> Rust/UML/x86-32 builds here compiling and running again.
> 
> (And gives me more encouragement to go to the Rust atomics talk at
> Plumbers.)
> 
> Cheers,
> -- David
> 
> ---
>  rust/kernel/block/mq/operations.rs |  4 ++--
>  rust/kernel/block/mq/request.rs    | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index 9ba7fdfeb4b2..c31c36af6bc4 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -11,7 +11,7 @@
>      error::{from_result, Result},
>      types::ARef,
>  };
> -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
> +use core::{marker::PhantomData, sync::atomic::AtomicU32, sync::atomic::Ordering};
>  
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
> @@ -186,7 +186,7 @@ impl<T: Operations> OperationsVTable<T> {
>  
>              // SAFETY: The refcount field is allocated but not initialized, so
>              // it is valid for writes.
> -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
> +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU32::new(0)) };
>  
>              Ok(0)
>          })
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index a0e22827f3f4..418256dcd45b 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -13,7 +13,7 @@
>  use core::{
>      marker::PhantomData,
>      ptr::{addr_of_mut, NonNull},
> -    sync::atomic::{AtomicU64, Ordering},
> +    sync::atomic::{AtomicU32, Ordering},
