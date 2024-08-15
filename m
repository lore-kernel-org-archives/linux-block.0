Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6058AC4;
	Thu, 15 Aug 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746304; cv=fail; b=TE02XxZJdOUO+NC086fgY8oWpz6kdr57DRJEMsyu62xJXSuela/Sy8na1yzrDyO8DBpNLU3Bv+ITuXgZ96j1ty2eBLUeBFSYK96cUXaA1XAU5gUx2snI4vJo9GbKWWioWKPa7Nq9vKBvXt+RJ/LHNHU5T5+oYPJMcsxEJ4YPmBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746304; c=relaxed/simple;
	bh=MI0H8R3lNYzVoCh2djxP7SXb4BuTJ9VfpBh/c2Fhp5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GVn+7wQ6Hb22dMsl8eH1xJ734YoZYnrrrNrRdmcsdu8AwYCKbveH7baAQM1+h4hKWRfDJL6hOBB/nYKqXxUjXdKeoNhQmz1hOmwzTa5yrrSP80MkIfvIGiDXFxhUGvHq6hgFtyd5Lb8z6dtbnnnol/ehmkJemITpoSXgG8N3q7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=F8aQZp0y; arc=fail smtp.client-ip=52.101.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="F8aQZp0y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl7AG+06JIG3rH+VAfAFPKslCXLL50QFfmf/zf2bdQMBUPIjPXMYoartLMPAelCrvYrAsQHGDOzN+jFePTaIKA5B7XYN3qxZ1ypHFtbn2IYojL6HECz7baNJx/bcZiWEED0467vUV0SsEaQLxCCZb5aA5Z6Q6ZeRoVsLbjKgYf/uEK/3Xp/oVfLChNm6FYdBkbwIhW72BvFybSRzjP/VNgcvEzt6fxwhzZyqt/UdnQ2VGUIbVczEwgEHQILCwhKjcvNs5dWSjhXy/lYPxjMTFIshWbNjDFKuz0xqrctD4YJY7yyoTRVy0IPleeWoZM+EWbOEQfs1au8CGDlQ8X0DeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep58KaKcdovzHErYUVUFmV9EZgvtHYYFSUsrd8otXyY=;
 b=pjhQnjzNIPUsy6wWFB2bQkFEDoQKlZmZ+kj3FP3fanYTITeXHxpWJw2prw7IOf+Qgl2Xp3E7CRFIBubnoI8nWyNkVCOQhWlrVdkbmKTwBvTg/xZp4/Hiq3jk2Ltgiktqcja8U5ncj+anH0jJ+pCn3wiT7Bci6jbG98Mz92wSxi+Sf02Han329F7DCT/tEaG6fN1lC7dvs6jLKOjujUYNB0obXKisFVc+QnA+LWahsVv4aU/q6QItaXg4wbfMbnb5n4jSEkt2gtdsb6UTjY5SBo4GEqEEWERnX2tNrYUDR2Oxm8RW+AUrsuFKwubw/MAUyNMcK5Gq9U09414lBxTWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep58KaKcdovzHErYUVUFmV9EZgvtHYYFSUsrd8otXyY=;
 b=F8aQZp0yV+A/gX+YYebgMEZ35uVghcgKJf5PhQDUDqjMiG7xSJRoz60ymO/oq6eq1FCtGLmVRXde3bYpKxIo26giHbeSFFJ8TtZ9zfYKMbv0jRlB0Kq1EKa6KXeBG9XQSxQ2ce11VcJi0dYv3t30Y4/ukis1TYC9NzhTE8W6JgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6151.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:187::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 18:25:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 18:25:00 +0000
Date: Thu, 15 Aug 2024 19:24:58 +0100
From: Gary Guo <gary@garyguo.net>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice
 Ryhl <aliceryhl@google.com>, "Behme Dirk (XC-CP/ESB5)"
 <Dirk.Behme@de.bosch.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: fix export of bss symbols
Message-ID: <20240815192458.0969260c.gary@garyguo.net>
In-Reply-To: <20240815074519.2684107-2-nmi@metaspace.dk>
References: <20240815074519.2684107-2-nmi@metaspace.dk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0135ca1e-e4f4-4f6e-910c-08dcbd57929b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXsbuxnxAuupjhwyN316L/mfTX7XNdp88AkuGyqKFwDZ19btkHiUBHew25zn?=
 =?us-ascii?Q?dNc/8+CqxsYsH172c1fF9US7YqUFBjKAncXtzPhjSmymjlpTuNCn/Es4NB6q?=
 =?us-ascii?Q?2mx6N9VltwSm0/QDYnW9pMGmImUvRnRAwYEt8oxWvm0Fa/O3hAkZc5Gnargi?=
 =?us-ascii?Q?iifvgmWGTGRgxvPHj6dqX+bNbnH77rDUG9Wiq7utaLRCE0XjtgIsJe9Rmu12?=
 =?us-ascii?Q?MbzDvTz46V+0jpWTi5QStGDSsJlNR6PK5i/hvNfs6Jwg3/3FYvWbXD/NIVA0?=
 =?us-ascii?Q?eXMkfurAtdKtuswYCr5JoXPLRD9ujbuwlgnwHy6UG/eItYYElxCMq9qk+Uh1?=
 =?us-ascii?Q?ZhG3dptHs8HKavEMI3ebbdDUq84rokqPgz8WZdBXGDd1AM/s8/d6Tvuu7Wqc?=
 =?us-ascii?Q?ai8gx/0CVeuFewBUJoZQvOtepeyfn9FiAEme6rWP5mSfd2RQbeVBh3jUfZBT?=
 =?us-ascii?Q?XGPc1462cc3o0qnQEEDZKG0DDHhGVb5evDekSZ4gPVNAUKDG4lVNb7SDuisJ?=
 =?us-ascii?Q?YYTe2UcQgnXGzKf0V082ihqBHNYZIum8XqTr8haUe9IUQjeMRURQ5yYNEBGY?=
 =?us-ascii?Q?GtM4Ix1Ovn2xr3GTEcakapDhZZ6iwVwnmISAeE8lDV/9gGNnqfqKArsU2m3B?=
 =?us-ascii?Q?p4SxzvlZFbNe1w9Yu9CKQpISkryxtKduHNzzRWtQ9reob3wyTHEkRjIIa2Ak?=
 =?us-ascii?Q?z+9V2v5iKBp5Yg+PaYsN/bKgiBp04FhnYJ6Ccf38ixAut3EI1xKxxmfHsHMo?=
 =?us-ascii?Q?PFZbb+xHz/Tt4kv5stk+G6P6DeiWD5LdzbouFg/3atHeS//Ldq6FzOBNzaAj?=
 =?us-ascii?Q?UZYp14JTL+B+1Y4eDKVlEDSEd5MRBKaV44RDmh+mMf7sfCtkyVcBoSxuyUlW?=
 =?us-ascii?Q?eJszvJFcAXAiegD6Z/hIBkPCS8ylBb6ZIxZnu0pq5m9g89PbKE97dI5JBlcF?=
 =?us-ascii?Q?5UtyKSjMhi+wCksfpoBUmb4vHnQN4n/5pEwr6Y7fO6gw8ocq+DqRKywN3ygb?=
 =?us-ascii?Q?5VmNo8jgnMIlwXRxG6Yz5w/WKa9QhBbyy2xxAIJI5LOsxauErtR1wGe9qenm?=
 =?us-ascii?Q?lkrJotRB+bJ+Zo0JWOAAM990nMLj5W5/9Qf2JIWAojSLvEIZMpM0PentQfg5?=
 =?us-ascii?Q?+EKZXQM2K1CYkq8v8qazbSk4k0HIYn3A1TaKWBhYujQYDUb37c8K8U+oUIQD?=
 =?us-ascii?Q?ZRu+ol/EUxtLMUxqPRoYnyuN4HewqvXA+M5cdcJ7St1prj229JZEAeb3n1bm?=
 =?us-ascii?Q?qmypNZhFA5cSPzsVolnEH4wzKwpTA4aQLQ6nM4369w2iFOR60e6Jvs2PjGRj?=
 =?us-ascii?Q?BK8ICWbp2L0qmPYz4v8obeEG5r2idOvt4fZI7AcHE9RWTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D/LCHN7qdTw1hgaTWCQoftrOMRPO1GdJVzzEW4NepILOb6+Zb8WEpBDOBGF/?=
 =?us-ascii?Q?fk87kqpPVMvFxjm3mftoWQ7Z1YKPkW+9i+1f13I7O+2Ip7MYnU2uhmYPktML?=
 =?us-ascii?Q?vxcpMQQ3RomkeS6V+XtTMv66AaWPD4V2sJB3dna2CYD988t2k49e4ke/0j1b?=
 =?us-ascii?Q?zyDdmZARVqXDejg7pYfFx1aTfIxBRIxEOezhvj5wKOiLbH57e4N88Al7fK6u?=
 =?us-ascii?Q?a/xLI9btR4GlVgapHReAKs9bkX5g/TYHVRkSy7FgXLZhAaTkYEZ7ky/t47qW?=
 =?us-ascii?Q?nVEsiwE4WsQhiFjkJ0TqOwyw/fjWtZuc6VFrao95xtStOGsk081TEwK/SsvD?=
 =?us-ascii?Q?V2OW/FrZmZQjNlX2ufxKIM1Iwf3RtnYT+5GNXah9wljmduS/JzuabPYpaAQe?=
 =?us-ascii?Q?/kNOiDp7dgk+nypVIuitKlLtxmb4j9ird5SbJvPVivd5VQH19BDWOrF99klD?=
 =?us-ascii?Q?45QQHqZ//GpuGNI5AWTuivchZ3W+bi7ogkVmQBJwopOtTaZkG0ljAhTkONRH?=
 =?us-ascii?Q?AzXiBuJa3+qRdjcYMiGsx1TYkiRG8qFNBOtGWxztqfGrwtqFLgtIRd1MZY57?=
 =?us-ascii?Q?Mkd1T6ckJFHJeY57bKbJ0LjdVeYpEshD+sP/5ammdFoFaUE0a9/oW2Cu3dlS?=
 =?us-ascii?Q?QdViZ4Uc/BlHN+Rj6Qt+B3nREbW2/8tdXNhU/gRQuPZNSZYdSxTSYSzu8utZ?=
 =?us-ascii?Q?KGKu8URkteXYIKEdZlfN987yFaqJ/IwqsMNbmTfiFN4N2ceY3iepHoOxE7cx?=
 =?us-ascii?Q?mD0Y2KFnUR2YMRKFZrvyLzhwro9Gpj/G4v5c37bzfw3QtBX3tc9o+7qV1ol/?=
 =?us-ascii?Q?BdrVEj92E0zR9hgbAV3/f85d/oh3c59wqM7jr/6Rvsi2Ctr7vHeVQJrgPza9?=
 =?us-ascii?Q?JzwFm+l6Z4ezBasGs8IrZrtmZpSENLEW7Om/Yl9WFCkaJ94yeATkA8651kCH?=
 =?us-ascii?Q?+7mYgN11jwDWiOm3dpBfZLGQKHru01Y4LNwoZS5X0++GIAFawY5HZnxaTJmg?=
 =?us-ascii?Q?8gmHfRihuIkZLO//cw2pVGkQC9WHGeI+qQv+sQSOsrSwdx7UH2mE6a+i1xfZ?=
 =?us-ascii?Q?WLa/RhmEMVm6OEK+coUtyYUOfqr9RHGIcVW8Pryahy27EnoDt7G63dzMa6zH?=
 =?us-ascii?Q?rJ5JzcMSgCJ9WRR6q1qypirRUb0yIu+FclHulJsLvHlyxTOO/Yrg/JM/0QJT?=
 =?us-ascii?Q?knL4UJ1aNFBNt08aZgk7R7tqIetloDmPIT5Gc5rPJFjMLQNZOqJZmZOq6AaQ?=
 =?us-ascii?Q?OPUBancv1d7iqGNTYlPVhu3+DHL+Lth86NaNk2zCHM5WLaIw976tgKA5tUaX?=
 =?us-ascii?Q?JfEFPh5r8maHxVRxAQxb+WcgsoPidZlK77euZjmm9ZEfi4XOA7Jt06IEFKWQ?=
 =?us-ascii?Q?vtDZsstUG6MLFUUFEPkxzlUKHGs636KhgRrEeCUWcUuYXyxXWQt3CTJ+07WB?=
 =?us-ascii?Q?ZEBci0BHZ/Y5k7DSx6CPTqg/Ep3DXmMbactfvenxIbiJL5PUvhIdajOScMrw?=
 =?us-ascii?Q?wu/E/ofBZOWbK9PeDerF0HWyI5UFn5BpS6Ls4h0Lu8iOMMaIjvmsJX2hxgzg?=
 =?us-ascii?Q?yN0dyim107p39rn6OCOkWbq04RoqvsRNDrcwEMRL?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135ca1e-e4f4-4f6e-910c-08dcbd57929b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:25:00.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT87QswOlvmz0UN38hvwlXVv8Iewqr/8gkwsMu0JolMVd+oRD3nxd5/z+UVR14q5xKxJ3zzmd4ec3YJ2DjHxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6151

On Thu, 15 Aug 2024 07:49:30 +0000
Andreas Hindborg <nmi@metaspace.dk> wrote:

> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Symbols in the bss segment are not currently exported. This is a problem
> for rust modules that link against statics, that are resident in the kernel
> image. This patch enables export of symbols in the bss segment.
> 
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 1f10f92737f2..c890ec4b3618 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -305,7 +305,7 @@ $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers.c FORCE
>  quiet_cmd_exports = EXPORTS $@
>        cmd_exports = \
>  	$(NM) -p --defined-only $< \
> -		| awk '/ (T|R|D) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
> +		| awk '/ (T|R|D|B) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
>  
>  $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
>  	$(call if_changed,exports)

