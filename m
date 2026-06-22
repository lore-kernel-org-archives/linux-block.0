Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021109.outbound.protection.outlook.com [52.101.95.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3023750D6;
	Mon, 22 Jun 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124957; cv=fail; b=QqlhMSRaBm8P3XfVTOcHfX+8Ez0iU1LsdTXQiw3h5hM6iDMT92Vy/sFEunHCIDqBTE6/OkAfjD3vSR3zcxLM5teCfEGdJejwjDQ5uyWEyfStXLPsTlp0Gt+iOd/uJeFY1drzbloSAxiqBlIrJutU3nnNf/DOmGHHhuWOWfS+eNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124957; c=relaxed/simple;
	bh=BymoCFWnRziJE5JF2JWeSeyju8ERWX16CwzWYQclP10=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LSznUGYcF4Yb16Tp8U7ZezzWwHjtnR9Z4cQPQZdsHsqBY1tfWOEgSwTuAHqE1Xm8J1r+YHB2TdpzCXGt3tXYH1hKMq1nZey+rQ3208MgoEgXbJp6IoZ8TlOPXbCO+6vWGC+jFxsVB677cE99sAeRY0h1vZN7Z+KC8qxsxFpSB80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uxCTmiTd; arc=fail smtp.client-ip=52.101.95.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uxCTmiTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYB/3qxZtzYuGFHJTOTWRkAjUYhFqmCQxXkY7wAVlP23LMhqPJE3PBxpZ+U0pI8mctvEpW481AHArhVLZrd0k1/+H8U6HLxapDuhqA4qhhq5tbTFHCQFKhFuKluT6awr7z/utPqoK2ZTIdPeor6kjgaCv6fy30dv5csuHhhJiBWtOm40b2o0G2i5xNg7Ut8mLVhjDowSfVqBUJXz5l78Z/wkpEEocfT49biZIgKbxp/pk40MVwPXYHTi5w94XYrs4RinlauL4A6bv8y+FxD07wiC+e0q2F8z38TfGhVVB/iq6VTJnMweyrd+OgVNQJAGqEsoUqeMqifgzeghzfyQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A52cVLJHCXHjgQx7GmcHNR1THX6KTYFB0Vz49NczeF4=;
 b=FQFNwoBYdg5/6XW8Q6sG6fFfNrd/BO3pX2D83ta+vXkFXQIqGGxdOjDMemQuJ995FIQVnYDA+nTXS5oYrufjtH6dUb4SoKUy+v2Ed8CG0oWGJb7XBxp8Ej1sEzVuxZCR/+RbdzGx+LNSs21EgP0tYVk0sVCeglcnuKfRSJXSbhj1PcXqOau5kw3IkG52DhrmpKYL34TmfnDL1KES6O7yTrm2Q478rFYb0QWSYDRhtE+/PpLk988ajIvA2NdNBKkVty4tCvWa7TBICGLPgY6h5K7skDIckkH2287HDWWiVCY2XD2hpfVAtkRmoEkvQJv5bDARX4tnJPPzon7Bp9/goQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A52cVLJHCXHjgQx7GmcHNR1THX6KTYFB0Vz49NczeF4=;
 b=uxCTmiTdpELGXEf6Fh9y+F5lCiHy969tlO7jlXOYTDc4YVNWIVlvCx5l8H5EzKmKdZ8zYLDSmUojW2uDyKkSQy0d/weFwVhESFx1Co4vHSVNPk2lqwNi6uivR2n2XbnPL7YhipqUpGqVUX96oy9I9JMnus0CjmkAD5POxZKc++g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3310.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 10:42:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 10:42:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 11:42:28 +0100
Message-Id: <DJFIKIXLML05.3KYOXUGZYJRDZ@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>
X-Mailer: aerc 0.21.0
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3310:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b960d21-3976-439a-84c4-08ded04af50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|10070799003|921020|18002099003|22082099003|6133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	LsTFZYN7AKYy/qFnvD14qYKUHK0mZzkKmhcp6f/xVCxA7e+Jjn7kDXqDIcbzgnRbLZcuRz5ljKCB0VQHf4L6IwZZ/OrGKxq/nuoPJM823QaIpYLxT0Z87PwjmcT9otP7tJLUqbQVaBaz5FohcMRY+NjCIXQHdydSKYFXSX0d/SpugfUOEJQWmkALQeOCRsY9gaKKFvQe02HO6TrCE+U3O3T3XhHeHjHKYTTm/hzbHPgVaw4wfPrZ9RZ4Hxcx/0BD9GbpXb1+fVlrYdWBBFK9zsn/3fU+zXZINZawdNQSBgrPFfgHqxk2CpCdrS1V90ViwAM0jknVWypIxKMOJni1gbmvE0iTG/EO2FjuMYdG8rhX9clpvsz6fWWSpE7RODg7Qgfh4xkoZncFJNqTXC7h4H5BR8UO5vqvfsLdemuzk+EdoLge1aiYtTwjMAl8/1kHlwJvN3pf1oe73K4Hj0upU5Z7SPvBzunII/ZK0xI0IBxo7KBMXVE5iFie52j5/YMJ8g6JpnXBHdHcOweROE6GA6H4ZdXUyg0U8ilypzyuYNhYyx8J2FLPkanJwp2m2GaBZ3gbTx5YcuJVo+KkJXUHp/5hXDXPAkMbPzPX2ofQQ36+f64Ifm6bGKOZsWOFLWP3MxY8qK65ugo2ZrXRLk9/bi7gZyVEBvL+q9OK7entNfL0N+iOCknCRINAqbqEAmHYxP/Ybr0P2vglU1fnuikQpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(10070799003)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDRHVGtidzVWdDJmT0M0NmRxWkpNWkFJbEdGajFQOXFtcGlqei84WGI0dk9U?=
 =?utf-8?B?MG04bjVCVmFPL25wR09veXJmUE40a1FuRjFOdlJxQi9IMU1rd0ZqQTc3L2lP?=
 =?utf-8?B?NTZXS1NFSHRTTXdUdjFWUXI4aXhIOG9IbDhSMUhWNnNVNVFmQzZTUlpGK1Vp?=
 =?utf-8?B?bG1zMUhQU1QyQUFpMG05MHZwckNiQ1FwbzJSdTRPbEV5ZnNPeGVNZEVTNjY2?=
 =?utf-8?B?bmdBazFOVVVPQy9GS21OdzgwY1RuZjRGa0p2M1hSY09uNXJUYWhNK2VTcERo?=
 =?utf-8?B?bFFqR3ZWeHQ3THpDWG9kUHhrVng4UDRRdVFlaFRnWWIzQ1cyS0JPMXFvMUYw?=
 =?utf-8?B?a3lucnh0SnNXa1JRcms2RTVsakVXaUp4WFNNSDlibjVybU5PM3JzMG0zYlpY?=
 =?utf-8?B?L1p5SEJ5NHV5Q01GdDRQU0Zmd21Hd0FmZ0paRnRPeWx4eEMyanZzd1lob2NP?=
 =?utf-8?B?cEFqcCtqU3lyUXB2NVh1V1ppaUk2U1BybEdpZDhFQnJ2SmtHY1RyTzBDbkZo?=
 =?utf-8?B?SkJhZzJJREY2QTJlNTVjV0c1UzAwYWNGb2xranlyNXVSMnlVL1dQaStQL3k1?=
 =?utf-8?B?blNiMzNNR2NaRTBVUktvWHdBSHBWOUp1SzVhblRUak5FR3hJNXRHd295ZXg3?=
 =?utf-8?B?cWpvZjVJalpNWktNZ0E2eTZHeG1BOEtsb3BNMWFSb1ptMS90dGNSTzlzcHBC?=
 =?utf-8?B?OHlxTG9Tc2c0Z0l0SGI2eVpHbENZeXBGWTIyNU1EWjJETHRLNFFodGhqL0p1?=
 =?utf-8?B?TTlkRDRwOC9HV2FwNXVzb0xYZTQyN0xVbW9HUTBHQ2tqWGxpQXRqdkdxcGVv?=
 =?utf-8?B?V0RRMGJTRGFtSUoyRUQzdUlTUWNjRHRCOHlKeGxMM0NaeGJDRG1BTnhSQXVr?=
 =?utf-8?B?Smg4VzdkSCtSVk9YbDhxNXY5THBHdmZOMno3MkhiYmYyZTdQQWh6U2hvd1h1?=
 =?utf-8?B?S0NRYVRJTzczTm5qcGlYMjdnMERjdGJtTnFWcUFPVy95SDhCRFZaV3hoNlRQ?=
 =?utf-8?B?VjdySEt2NzRwYmNTU05ubFhzejg3a3lNbWhkcFN5b3JEV3RoYytmYzQrWTRI?=
 =?utf-8?B?dWtndS92cWkzaHVtbHdNSUlBVnhNc3FLQXpWUzBoV2tZZzNZNFFKR2Vod2ZL?=
 =?utf-8?B?NmpYUjdEUEwrRkJtOWNVcVpTaVJyenNNSzlLbE5vR3psd3NOYWdtZ3ZKMExW?=
 =?utf-8?B?c2hCOGxBSFY0ZnNPcUkxeUh6cDRCNUxMY01SSkJqK2NMRnJzQVF2QzZPV2Rq?=
 =?utf-8?B?YTR5bnRQSXIyeUJVVHdJbEl0TGtWSjR3a3RlNFNST3pVd0JsQ1BGaWd6c1Bx?=
 =?utf-8?B?TGZvWnNhN256cGJPZFhOQ08vVnVlWXpzcStNNFc2VnRJUmVsSDRScmxrMVQy?=
 =?utf-8?B?ZXFGNGNIdENISGt1ZGFPRk5kaGxJangrRWJkZGpEYTd5bHREVHF3S3d4V1R5?=
 =?utf-8?B?emJLK01hNzdCeFBERmxlSDBHTlgzcHFhZFRkYlZYS3JLTVlOMjd2OXc5R0Vk?=
 =?utf-8?B?TlFWam1hSWV6Qy9Ccjc3Ti8wWmtNZERBZUd2L2ZkcGdmU1VqUWdEZHBpK3k5?=
 =?utf-8?B?MEVUUGlSSDdZM3BtZG5SRGlXa0djQnlBWmFLY3dIWUlSTEp4djFLeXFPd2Qz?=
 =?utf-8?B?QnFjWVBCMUxEUVk5UThpOVR3dXdKTlhRRHlPbzlmallON2hvQTFzMnk0alhi?=
 =?utf-8?B?YTJLNUpqSFVmR3RTUTlGWFJISHdxSnRvMW1ESFlIT2M3eldONXA1WFRRdWVr?=
 =?utf-8?B?eGNrK3R0V01qMk5qM1JjN1ZNMmNod2FBUlNWMUU0dnBRT1VXeWVzZmpRTHZj?=
 =?utf-8?B?SGdCVGplaWxDVm5ReFR5L3ZXN05MMkk2MGp3YmhkMmtBMTJFMU9Ga2NzMmNs?=
 =?utf-8?B?MklSUC9xOHdna29pczI0cEI3SFd6dXhMMWg2TDhwRzM2cnR2cXF0aEttSldQ?=
 =?utf-8?B?cGZZZHNzY1ZldWc1c1NFRXhpZUdqSWdaZ0pPemJkNENieWJHeUNvaFJtdzh2?=
 =?utf-8?B?cnNtMmJVQ3A5UU55MmVERGRXRDRTUGM2NmFKMDloYTdwRHlwUlFIaWxSbUVO?=
 =?utf-8?B?MkcxMmlPMk5jM2gzOEEyNGJicmlldkd5TWgyT1VPMFlKSituSUYvd2N1Mjdl?=
 =?utf-8?B?RTRFdFBtWG12d09PbGY1eVpwVTJ3ei83Vkd2eUJrZnpsTVkrWm9vT3lTRWJ6?=
 =?utf-8?B?cmdCSkl2UWxtZU5ieDRyNUNkTmdEbEd2WExZMnF3ZkM4L0ZuUGNRcG40YWFY?=
 =?utf-8?B?cnNWU3RLOUJCZ0Q4RTFEWUVOalUwK0d1MnphZ3pxQ2xDY0xXUTNhcmhKQ3dL?=
 =?utf-8?B?TDJVakl2clRHbVFVUjd3M2JwTkdTS01KSWhKSkV4anVDMVlFOERHZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b960d21-3976-439a-84c4-08ded04af50d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:42:29.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guLvEiop2wd8aglgrgK+dke0b399IrJjonh1LNcHgeYd4HlSxWrV1u2a3KFDo8m7Ut6tCYAASgh5fxzkWdelVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3310

On Mon Jun 22, 2026 at 3:44 AM BST, Alvin Sun wrote:
> Since `const_refs_to_static` has been stable as of the MSRV bump, a
> `ThisModule` pointer can now be used in const contexts.
>
> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
> can provide their `ThisModule` pointer in const contexts such as static
> `file_operations`.
>
> Move the `THIS_MODULE` static from the `module!` macro into the
> `ModuleMetadata` impl, add a `this_module()` helper, and update `__init`
> to use it.

Doesn't this break existing users of THIS_MODULE?

Binder, rnull and configfs macros are using it.

Best,
Gary

>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/lib.rs    |  8 ++++++++
>  rust/macros/module.rs | 34 +++++++++++++++++-----------------
>  2 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b72b2fbe046d6..50f5a7b5f028e 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -184,6 +184,14 @@ fn init(module: &'static ThisModule) -> impl pin_ini=
t::PinInit<Self, error::Erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The module's `THIS_MODULE` pointer.
> +    const THIS_MODULE: ThisModule;
> +}
> +
> +/// Returns a reference to the `THIS_MODULE` of the given module type.
> +pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
> +    &M::THIS_MODULE
>  }
> =20
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..b9fdee2f2af47 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -497,28 +497,28 @@ pub(crate) fn module(info: ModuleInfo) -> Result<To=
kenStream> {
>          /// Used by the printing macros, e.g. [`info!`].
>          const __LOG_PREFIX: &[u8] =3D #name_cstr.to_bytes_with_nul();
> =20
> -        // SAFETY: `__this_module` is constructed by the kernel at load =
time and will not be
> -        // freed until the module is unloaded.
> -        #[cfg(MODULE)]
> -        static THIS_MODULE: ::kernel::ThisModule =3D unsafe {
> -            extern "C" {
> -                static __this_module: ::kernel::types::Opaque<::kernel::=
bindings::module>;
> -            };
> -
> -            ::kernel::ThisModule::from_ptr(__this_module.get())
> -        };
> -
> -        #[cfg(not(MODULE))]
> -        static THIS_MODULE: ::kernel::ThisModule =3D unsafe {
> -            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> -        };
> -
>          /// The `LocalModule` type is the type of the module created by =
`module!`,
>          /// `module_pci_driver!`, `module_platform_driver!`, etc.
>          type LocalModule =3D #type_;
> =20
>          impl ::kernel::ModuleMetadata for #type_ {
>              const NAME: &'static ::kernel::str::CStr =3D #name_cstr;
> +
> +            #[cfg(MODULE)]
> +            const THIS_MODULE: ::kernel::ThisModule =3D {
> +                extern "C" {
> +                    static __this_module: ::kernel::types::Opaque<::kern=
el::bindings::module>;
> +                }
> +
> +                // SAFETY: `__this_module` is constructed by the kernel =
at load time
> +                // and lives until the module is unloaded.
> +                unsafe { ::kernel::ThisModule::from_ptr(__this_module.ge=
t()) }
> +            };
> +
> +            #[cfg(not(MODULE))]
> +            const THIS_MODULE: ::kernel::ThisModule =3D unsafe {
> +                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> +            };
>          }
> =20
>          // Double nested modules, since then nobody can access the publi=
c items inside.
> @@ -616,7 +616,7 @@ pub extern "C" fn #ident_exit() {
>                  /// This function must only be called once.
>                  unsafe fn __init() -> ::kernel::ffi::c_int {
>                      let initer =3D <super::super::LocalModule as ::kerne=
l::InPlaceModule>::init(
> -                        &super::super::THIS_MODULE
> +                        ::kernel::this_module::<super::super::LocalModul=
e>()
>                      );
>                      // SAFETY: No data race, since `__MOD` can only be a=
ccessed by this module
>                      // and there only `__init` and `__exit` access it. T=
hese functions are only


