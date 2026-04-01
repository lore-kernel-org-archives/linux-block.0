Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021143.outbound.protection.outlook.com [52.101.100.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7072DF13E;
	Wed,  1 Apr 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052525; cv=fail; b=F9/iKF4RwQNfRiWsAkugHaNo/M5wXy8lqbMPL2HfM5xibIsN4izp7hra34t6zU69xuSeCScuSOLeKdNjGDj2arEBYqOfwU6qGK5eFbOwV+H6OYARW/0CEc0IyZIVFlVWOA3lbT+GEtKyRnsmkDy5UQgV8AijbUyV//w2EmpXDVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052525; c=relaxed/simple;
	bh=Pdj+YB49vFkg/IILTZ3scxZwXNRo1yaR/VERbii4Ajk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Xtfb8MQq4bSS6qMwfIKnTt7HgFnZRvxmG5IGP7dJLhF3nQ5TxnHhU3beAoqfRPqobNO1jR4viAcXWX5LjHdImcnb4NutnZwmSP954lU4nPZ2HnF+ONJ6mWPFGQnK6ynMrwJe2+taNUXiWtEF2bGpRXY7I6WwJaR7Qd6OVUkRm1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hectLkK+; arc=fail smtp.client-ip=52.101.100.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hectLkK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzLMSNaRfMkKOOAQT4QKtpzlP/rPVLeKi4agov4IkfUvs3RN1ElKDPfkKzUNlGYkXXoYXjSpSTYbhRqK+/xtwA9rKsU1JwR2rYw7JInr39CUS/Un5nGJN0jI66YVoKTac0oNhIQM3ws3U0BctiAwpZafM+ulqT/bD00rMTo3NewJI1A6zx9YmE+IzDD0I90x7c1rfJk5U3kgFEbcpNlyug2AKOmMlW4fh7+oAzCuqVKe5Ni0s/IfOvWeWzhQTPcJezY0oO0Nq5aKtf1HIeLQNh9GLEQZtpE3hYDQT65KNty31B4FGc+dsCRM94X16uD2DEEcUZ0p8Voe9voFkSK6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcv5te2wqFeaNQCScYp9pM1R+b+32z0CYFag1EP3+nY=;
 b=JLUH49Y3bM80dDgZP0h6Aod6s/algGSA0nxnl3ly+JC5I306N3L+vlqlsrlimbfLYtyENMDnf6bItbrMECrg63nQtRoQdf6Sgp4LlqYO/T+TpxWkxhBQMUEHgQxhIEOicmrfevIY8O7bOMN2frvlKLdppVTCaJfw67sWD2eE4AutyPoCBAREx8sPMvDvuU2SK1bE9joL9P7NBF3o2qZQIhXL3TJCVfC5fNWTPoE0gginf85FXt3j+s5zKZ7Q10TiLyfQE71/wnnPALuIyKyPCb1nDtoR55uN3m5dle1Dz/BLU9RrXBSuqVpx3TBbEaxmk0oQhrcqTrXvOIYolvpGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jcv5te2wqFeaNQCScYp9pM1R+b+32z0CYFag1EP3+nY=;
 b=hectLkK+RYJK2UG27lbbwDkWCnL9YihY8xxx9BaPljznaVnM85bn07SXvGC+6sk2CzgNfK1/oa7ERZwHw4IfoPt3q7JncWKj2b8NtS6K0n3X6aufZNpH2RLpBe+xTqbaBjGy7wTwbsVjTPYjoUV/qwAuya2/Qzytd7OPCIQvdHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB8529.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:08:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 14:08:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 15:08:39 +0100
Message-Id: <DHHVLQAOMLWB.3FHHSYKNM5TNP@garyguo.net>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kbuild@vger.kernel.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Uladzislau Rezki" <urezki@gmail.com>, <linux-block@vger.kernel.org>,
 "moderated for non-subscribers" <linux-arm-kernel@lists.infradead.org>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Rae
 Moar" <raemoar63@gmail.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, <llvm@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 09/33] rust: kbuild: make `--remap-path-prefix`
 workaround conditional
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <christian@brauner.io>, "Carlos
 Llamas" <cmllamas@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>
X-Mailer: aerc 0.21.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-10-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-10-ojeda@kernel.org>
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a003862-a7af-43a5-b14d-08de8ff82d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|13003099007|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SnWLrtcxKFMmMUTwaSikuQhA1Zc23ELC3x8wsHc6h7jMw4f1aXm03+MrxchJ9bIwhOg7dhbrdsSy2lUACaXB0Q0v68V+G43ILmvrepHFgriWpMDa0XrWrEdMyqJLH75Ng3q/fsLqlH2zeddTxns+jpNSZESlAKr06DuRYGj+7M0exH9Fje2I3r+kGxfpMsiV071XuzdZk8rc/QPtqOP8wekb1YD3qQNFnCCqcgXZv9eG3N0Zli6gXn8QFco+63xotSIDPyqGG9VmpFq+ZHRDPhfNTQ38yHzaPysomk6bqVcOgLbzyxuUy3pFl+vZVOYu22IH8cY8I3YnUQ6wqcnrkHMLD9THMQaMSPLxFs1PUOBGWyhFtO90/XwcV3UwFi3J9ZrhP4aFEsPkgBVuQRtqvr9mRWr0CLge3+fUyupYBP4u3K2HLnqaMr+rolx5gh+NrhfsBnbCmSeKmTu3iJfmZlsoc/pXtYwXPzoQTjJs4rbanwlQqJRwTSssv9N/3ounwexiwVNof6rKBNiYdMzXGrmxVvFLX+AcpBFoc9CZi7JmtlWZE6FYm9AxGPmInZw7/3yCNsZ5sh43o7Gn8Gh7Milf45997aBVIEwpm2fZBYVNEEgYny57bEtW6Iz4pVeIVz0HF6hpd7kui+b35G63DhYOXuXhNQIrwnjg/wzOiPOVxWjirDV9DOlXk6YCnw8uP2OP1mcCsxQKcBs+wY/FHrMWTlur7KOMHRygnK1sajtCb+ah7qRqws66OTGaKd4Uo38hmCRnMBDyRSLay5Wkmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(13003099007)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDlKakJxdmlFN1c5VWVOeGNDbFRwTFI0eEJwWW8wVnF0dTYwUGxtTTU3aHY2?=
 =?utf-8?B?MjVzMktKNVF3c0RMOXEzVU9EVlNkZEZ4REo4a083OTFtajZJRDFjTDkvN2p6?=
 =?utf-8?B?SmJ0Z20rS0RrdkFFeFNDMjVoMFpTRXk4dHo3L3lRQ0UvYWo2ajl3cmZVQnox?=
 =?utf-8?B?bGdOalJlc1huRDZMZVdYUnQwbFZsZ2ZZRTVDVDc1NnhMWlVjYy9HSlNkQ21r?=
 =?utf-8?B?aWJKZ0tHenRpS1JGMjZXM3ptdG41S25ZSVdLYTVpT09aak10QXRFNmYvYnBl?=
 =?utf-8?B?SGJBYXdJbDcrOTR0TDlGb3hWbmJSd0dXNnF0VTBCRVcyNkhGMGZ2NVdrTzl3?=
 =?utf-8?B?eHBjdVIxTHZWVldOTVBVS3BRZjlpdHpVSW5LMEQwbDlESGxaQzZKc09Jc2Iy?=
 =?utf-8?B?WHR3MkJKRDVHOEl5RDlqQkJCZXRxcTJWcFBoTFJwVkJGMFk2QlJxMzNIR2Nw?=
 =?utf-8?B?UE1tVGdYeVVySUdsT2xqOFRSR3pNRGZ6amh0Mi9aeERwQlJrZ1dWMy9GSmo4?=
 =?utf-8?B?cW5Jc1cxQlAwUXZkVUZXRW8rZ0VGajdsQkhpNFhDakJmYkw1eEN1ZTBkY2x4?=
 =?utf-8?B?dHlmSnFuVU9ESFFHMUZndXBHMnFaR05zYldXMVdZdHZSa3ZrYmhZcm0zeVo5?=
 =?utf-8?B?M2luYlVGbkxxNy9zNUdYM3ErYUVGN3ZiN3Y1TXZuREdyblJBUVo1b2lzZWdX?=
 =?utf-8?B?a3VVVFRkMXJvcHlYY1BpMXcyVVZ2VkNiYXNtZTVvRVRUZWgyYXpPN29qN1Fk?=
 =?utf-8?B?OStaMGhJZC9PU1hocXdieStxZ2RGYVl6VjM0cGxNdFg1SXY3dGMvYzRwNGgw?=
 =?utf-8?B?VDBTNDNjZFNtbjFQVFVsMWlyelBtZFJXV2JoMVhwTFV3RDZybUV6U2VGNHRE?=
 =?utf-8?B?dFJ6Wm9tMFlRNnBOSXZUbnR5N1QyR3o2c1R4ekdpNmZVUy9haHd4bjdvaWo1?=
 =?utf-8?B?dENyRWxYYzFBVndhS1FLNmhEVWtCMmtJczdFL3doNmdQbmQ1ZkppSkZOMW4y?=
 =?utf-8?B?K2tjOFlGNFhnaC9UTG45Skp0NVdYT01RTGk5V2pINklydU1PUVZCTjRWWWo3?=
 =?utf-8?B?RVp0ZzFXRkYzZWxCMG1qK3o1VDc5dDdsOXBZaFJzWUR5R3BoRjRBeVZXaHVH?=
 =?utf-8?B?TEpRQkMzVCsrYTNlT3M1bmhqQVVSQThzaUtML20rRWU4L2JKcEdyYmN3NXcv?=
 =?utf-8?B?WG5Oc0lINWlBNjVmQUtVOE9Zb3B6a0hCYjJ2YWhpaU9UNEVCNzIyRVRaditn?=
 =?utf-8?B?R2VrRFhRVGQzVXFuSGlrTkd1K3J3THFINDBISnhpUFArdnJGV05OWDVZaDds?=
 =?utf-8?B?L2pNcVFRMVhtMUxnYUdmRytlWmp3NEF0WTBWbTZBTzlSejh0UVM2dG44ZDBP?=
 =?utf-8?B?emJrUDNXaXVJRnNCTk4zL2tzeDJSdmtPbW5mU3UwdE1BT0NoZ1QwNGFobnd4?=
 =?utf-8?B?L2FzNW81cWNoYVRmRnJoMHVxQ0NFOHd1dm5uOEFxWENJOVRTNXI0anVXa2o5?=
 =?utf-8?B?OFFaMHdVT21zRXJEVDVUUlBJVlRtZjNJWXlnWlYwRVFmaXYzUlRYN0RrTFh1?=
 =?utf-8?B?TmpnSTk4OTFBTFl5N0JzbWwwYThkbjYxZ0JaNWllbG5jY2lRMzEyWHRWZWRt?=
 =?utf-8?B?dXFEQ3dOaUZGSHRDczRHQ1RTWldpSUhkMHBaaXhvemtJcTdlK2JYMm9LWFJP?=
 =?utf-8?B?bGRpRkorclJLN2pVdjZsbkpLa01QVm12Tm5mNjhJd2dLT0JJcjBLK3FkZzRn?=
 =?utf-8?B?eGJLUXNsbjBYRUJ2VlJweDZscWlER3dsMEczMXQ0d3NKN08rOTczNXNnbkpo?=
 =?utf-8?B?ZCtnOWszd1dXajkzYldGcTRZcXFXeC81NTd3bnlDbHNnb3JQR3ZPOFBrS1Vh?=
 =?utf-8?B?TjR6NWpuVXFWeFc2K2xaSnJkZS9FRmdHUTZrTXF2NVFPOUVQRmxZMEx3QmFK?=
 =?utf-8?B?NVJkeGhkQVZJRHN5SGJhOEhIS1F4eFNxaGlmZDc2YllSWTE2L3RjZTZ0ZCtU?=
 =?utf-8?B?VlM1SzBuWHEraGFzNjlHKzJ2UjJwUGZOZVZpUE9OQ2VBbi9ac3RwNnk1dXZD?=
 =?utf-8?B?Q0h5WXdiaU5vZGh2aGpYaWpqSDM3eGtPY0tHbmFlY1pzdnBKOS93eUJIdHpy?=
 =?utf-8?B?bXc1OVE4TFk1VlNGWEM0YldLZlVJam15aERtYjFzUzIyQWpnM01LZXR1NXZX?=
 =?utf-8?B?N3dkM21YRU85UGpqWlFLNXNwamFEeE95Uk1sLzdnSUVJdm9FS0Rock1aQ1pk?=
 =?utf-8?B?Mi9ZdTY4Yjcxd0hRMnErUG82YWFvZnY1bUlnQXhzV2lzb0IwRTNxMGZoWkZJ?=
 =?utf-8?B?cDdVaVJXMVNzSHNrVnEweXA0RjM2alpyMldBaHFUdmkxVWhZRnhPdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a003862-a7af-43a5-b14d-08de8ff82d63
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:08:41.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvMOQ+PcirV+qeC2TSYRT2K5Qb/c5C2hFGp9/pR5OdjySb6Qynwif57Fyk4xx6142WnqcnqLdCJr6bdwKcvGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB8529

On Wed Apr 1, 2026 at 12:45 PM BST, Miguel Ojeda wrote:
> The Internal Compiler Error that the comment mentions [1] was fixed in
> Rust 1.87.0 [2]. And, for other workarounds, we plan on limiting where
> we apply them [3].
>
> Thus limit the ICE one too.
>
> This will help to make sure the workaround is not needed anymore on
> newer versions.
>
> Link: https://github.com/rust-lang/rust/issues/138520 [1]
> Link: https://github.com/rust-lang/rust/pull/138556 [2]
> Link: https://lore.kernel.org/rust-for-linux/20260205131815.2943152-2-mlk=
svender@gmail.com/ [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 708530ee3613..163d2258e93f 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -145,10 +145,12 @@ doctests_modifiers_workaround :=3D $(rustdoc_modifi=
ers_workaround)$(if $(call rust
>  # `rustdoc` ICEs on out-of-tree builds in Rust < 1.87.0
>  # (https://github.com/rust-lang/rust/issues/138520). Thus workaround the
>  # issue skipping the flag.
> +rustdoc_remap_workaround :=3D $(if $(call rustc-min-version,108700),,--r=
emap-path-prefix=3D%)

Okay, I see what the comments mean now. Perhaps squash this to the previous
commit?

Best,
Gary

> +
>  quiet_cmd_rustdoc =3D RUSTDOC $(if $(rustdoc_host),H, ) $<
>        cmd_rustdoc =3D \
>  	OBJTREE=3D$(abspath $(objtree)) \
> -	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=3D%,$(if $(ru=
stdoc_host),$(rust_common_flags),$(rust_flags))) \
> +	$(RUSTDOC) $(filter-out $(skip_flags) $(rustdoc_remap_workaround),$(if =
$(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
>  		$(rustc_target_flags) -L$(objtree)/$(obj) \
>  		-Zunstable-options --generate-link-to-definition \
>  		--output $(rustdoc_output) \

