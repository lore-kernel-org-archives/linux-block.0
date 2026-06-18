Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022099.outbound.protection.outlook.com [52.101.96.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD82DC357;
	Thu, 18 Jun 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792200; cv=fail; b=dF5xgpOEE5dwEa5rRL/lgH7UjYbHD3bUCSAIWTjdwj71Kfl2EWVeD+8/t38fliP6jNNHBQDe+C2I2CcEt3K5iE6OMv2CUJFYIpBXliiOCmUl8AGpZIOzZP0teKtALtEhc6gjl2MiEzi3eMh5++5ZPUCaG7l1FubfQZo+VPV9siw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792200; c=relaxed/simple;
	bh=gXpahiYrAvSbHlul9RMNau2lvObXbfnQQ4/zNx6t0G8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=PI3UP8beU/zIprE5vrH1AGxZkA/V13Z5L6iSpcA2YTOrAULANEaZ9nmKcMPwBJltsHuiDScrU/o9DydlXH1uMGoxJXfvD4gFXjFAu2bnPCV2UunalXqhYbKOx1YGVP6ee3auKJwd3ghltSmtt4E4Q81vpnb1OqcsSzGpR2MaTDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BeVYaam4; arc=fail smtp.client-ip=52.101.96.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BeVYaam4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvl5pUc5EKFl4KihIE3elBFOiNT9QcZyznmyE2lvTMNpYm6lCDeUGAjFHFXd7strBBudcMkD5TbCJIrmTkCjED4qVXP5MrIAHNa+KiRtM6Ep0jXqlXeqKicuUm6c7dmVyqlUN1274kL2lEyOoQ4iTVQhv68FPNCehpWU+2NGmDA5zDGUKWh+/iZkyywwJBhGbZ0UUsQM2St9qlvI+g7WIjHzRtKLShqeAnOOjiYOYsB0T8QjM/egpXZmY/ta5t+KhGUvVglnv5m0yRK2u+JYOnv3s3toZTn+h6AbJolRAPD21iikKcV7ICsvVvrBd/hDZSF306yueLTEaCVNztk6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NV8qzjTkCssO5bL3QcVxXD14lOzn5n/4d2bA+89Fv0=;
 b=N61F6cY6Zg33gewXNS1U+tPRc3jOpDtF8AejjWo+75tAbV1jF1Z0bGDjtdQ+iroz4uC23w6CQDU2WSdy74fDzMQzp/9OJKOB+O3pOboMuw2bq86fugm8dGK58TTCiR3ePBuzXtENTjsOrj9A9ElRFfe/k/48HKJPNunYuLJdXrbWYlT3S1heYxY6qq3XSGOhAUCsWJ1TKSzpw56YGiNsdVV/wt/L5LFQwXoAZorAk5vPti3cFVE6h7Q2OpeEbUSXY/EAb1CTd9JYEWwpnRnFoFVD7GPy7wMO7uABsFYpso8G8AEZNLvKH+ALvF9+kxbCXVzJOSvl78rP8vniEmpdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NV8qzjTkCssO5bL3QcVxXD14lOzn5n/4d2bA+89Fv0=;
 b=BeVYaam4blH0M2GvWgeRUK3M7wUBQYbsW9BZbpSHszMoRyJVRxblVfjUub5ZPJAToxIbxNfSlHiq2PhkHEcptsELTYjRp/x9D66tSHr6NmTX5OVJblmvrPDE2qZwAvs4mi0dvQE0F+cvP5zq/6CiWE/COnHc2KpFN2Sk1Th24fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7964.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:212::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 14:16:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 14:16:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 15:16:34 +0100
Message-Id: <DJC8MA4TZ9RE.3T3VXZU2USSJG@garyguo.net>
Subject: Re: [PATCH v2 1/7] rust: module: add `THIS_MODULE` const to
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
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-1-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-1-fd99079c5a04@linux.dev>
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 780213c6-6026-4f46-c6d7-08decd443462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|56012099006|5023799004|6133799003|22082099003|18002099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	nyrRYueL/GrSX3mgvXbn13vASDy9GB+vxeI+gIlWJWSuzE21yzW6mXcN8miJTs0NFz4s5/NnqfCGkMbnHhUEBakckltX3cXtNhOeXvsQcFg83kOWb/8rdUBDtpwxcRkN5JHyNJjdK8gW8jbKCXkBuQxQCDG/onUNaB5xfNgAK3wgY4W8rLgaaGKpSwATamr6OQhNlR8JoqZTPk4m315QllsWZXofXxUS5+t/ADSYBJLnWFH5j3mG5edv2+Z1qFLjPGdz/lKDaXQCLw0kEhYwBNAJ0tgUgjlq3ufrafP162onmKJP4qw3oGMXRTLKIFykLMIEGYQLh5PYwS01mM41QCvMRpc6OSXfyUmw8ToT+NEoeeOmff5d1CclQiL2cuQ/R9iLty0/qWkMFZNN27NFn6CjYZBC35kIKyiuBWNeAFywpR/3Nvf0gSx+xbJEvMUsOfVtB5PjefhqtoKeH5VyrMD1ZqlbfZ15aLkoT9rdT1KZl2+oScKjC08dt9s7gKOjRP4QZElpCrKCv59U786Yh7kDF7IU4+U4jMb2wtNCMu+OzwmyM9dd45EFGWvvvClpucKtlxrTReeLiTShR7sWN22onyDHmtNhldmVKgf4jamnZFVG5gBsNOOWw0YJfik3MrUu1CNQF5F0/evcCVSRCY7sGuPK4MSKoUx1WP0meVYNTJrEhJGSfTktCzp8xY6QHSPezcYcqsk1n2lhn1Gjb0xefW4oeayhbnk+mbjou40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003)(4143699003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3dxUGkzVHZ3R3pxTnkyY2JFeDdzMTVoYUxONE5ORkp0b29ZUVRtTUhnTlRh?=
 =?utf-8?B?bWNyc3Zaa1d4bzlKTjN2akR6TGt1VUJrR1k0L1ZoOGVzYXpxSFRyMG1VQ3I1?=
 =?utf-8?B?c1NFSExBZFNUZ0R5bXg2V1RuRlBwZUp2dEtXMTd3WmdzSysxVmhBaFNVWEk1?=
 =?utf-8?B?OVh4eldrRndqdVRMYS9xMTJLU3Zqc1lkMjF6SWxmNUJHeXByaU1HWlF2VUFv?=
 =?utf-8?B?cW1mc0YrQkVsbnRJekdoMCt6N0gwZW4xc3JTdVk2ZHhBRi9SSzVKdEdralpH?=
 =?utf-8?B?d1hCOEpLV2VTbng3Vi9wZERyb092aFp4eEdQclRBMGJiQUNEYmpVdFVjclQv?=
 =?utf-8?B?d25ZaWNSU1dsVWZiOERvSjdxcnZ0eFA4RGRuSnR0eWsyOGxZQUY4Mk9uWkEx?=
 =?utf-8?B?czNmcFNWUUppL285SGdHamhYZEtHSVd0Zm44VE9QQWdUeE1PVTEzcks3RElO?=
 =?utf-8?B?aVlsSW1BbTh1QXRrOStzZ0kvM00wU0pzMGM5WXJIZUwrcnpjNzlzMjNhYzFp?=
 =?utf-8?B?aHFBMWlKZzFlSnVqaENCeXBobGRjRnFvQTlmTFZSc2FqTHgxSkVFcjV5ZGVx?=
 =?utf-8?B?QTEvSlJRWFY4bVg4b01BOHJ5UzFjKzhuSzkvdnRJUkVvOXpLMmVpVHhGNEs2?=
 =?utf-8?B?V0ZDUFpzODdQYkEvd1MvaG9lbEtqUEg3cTZuOWVvMFVRczFIKzU4djlONDIz?=
 =?utf-8?B?Qng4ZFpDTE0vdU9McHJuSHhSRmxITmdweE5TTEd4MWc4a1VCVkJBczh4NnY1?=
 =?utf-8?B?TFhGeWNVRFpSY2xKNkY0WGVjYWZhUnRlZThSUHFDcWdjQ25yQmg5OEZuVmZj?=
 =?utf-8?B?dGdGK2ZRd1N0S0NxSHJLUUdDYTBlM0g1SDBoYTJpY2hYT1p0YlpvMkJGQzln?=
 =?utf-8?B?a1J4aXk0Rk9JRkJDNnFnWkR2V3pHWmhIZ2FGS3ZUbTIvSE9OWUlwV3VFSFFB?=
 =?utf-8?B?aG9samI0THZXOENZMUpueFB3c0FIMXg0ekJlOENsa1NwQWMzRXZxQit5UFBp?=
 =?utf-8?B?bFBaTGFQRnRKUnFyTVVBa2pqWHNmNXoxZzUrS3YyNHlBZHlNeXRQVnRlZVps?=
 =?utf-8?B?UFRhRmdhSVZ2ZWFlczJpdDZNZTVsZ3R0eEd0OHl2SzBZY3UxRlVPck5kTWdR?=
 =?utf-8?B?VEdRNmN4ajJleG1jRmo0WjJuZ2JUT3hvZTRSZ3Y0K2hMOFk0WmV0TVI3bmxC?=
 =?utf-8?B?QmNrVG42T240ajNEWmJvSGV3MXpvRVR1Y0MvVkhseWIzL214RXhjRjl3NzE5?=
 =?utf-8?B?OHE3aURrUlkrNXY4Y0E2UlZsSEthSWRVMlRVS0RKY2lNVUZ2TlNOanBSYVc4?=
 =?utf-8?B?QUxyd3NOVEh0N3dzSFpEWkJacm9uT3lBZW1tTDNOaTY1eTZ2M2dkazQwK1Vi?=
 =?utf-8?B?UHhZWWxqK0RkL2tndmgybThpT3hURG5Nb0laakdTYVpwcno1M0NhYngrZVVL?=
 =?utf-8?B?VDJRcVhROTcwK0JWbzBCb251SVVLTUh5K3YvMWZqQ0xtS1dJVEpuN2hLeUQ2?=
 =?utf-8?B?MGZCM0dIRFBXNmZrMWdqbWJSeFFsaHFFcmNPNTh6Q0RrN3ZTQTRCZzQ5UHVJ?=
 =?utf-8?B?Q3RtRjJmYWM1TEd2c040cWpHQVlsTW5EU0diblU2TStZYmt6ZDhGRDFiODFU?=
 =?utf-8?B?RTNzRVNhWUNpTkVxdWN0VkVDRFpvSytPdWVNSTJQZG5MYitDd0N2NkZhVFRM?=
 =?utf-8?B?K2FBTFY2ZkJ3YnBtUnFMeGR3SDdTT1pEcDBPVFRrVzZjcEQvY3NlVlRQNmND?=
 =?utf-8?B?SGtvM0ZsM2wvb2RrZUVWb084d2VKbHN3bzFORzkrL0JJVzd0VHI5ZDdWRE9u?=
 =?utf-8?B?cXpXM0VaSENGeXNON1BIY3BkRENGcU9abHJPM3lycnRGMXczdFVzUVVUMzM0?=
 =?utf-8?B?WTBEYzU0T2VUMk5Ia3BwY3BZVXJwM2J2RTBmcHFNVS8zWkJ1YU9KdU0zcldw?=
 =?utf-8?B?Y1RwZWxVdnlmL1JhY1hadTh3bUtMVU9lK3FoR0F0OTJMaGVhWUEzU3h4Q2Fq?=
 =?utf-8?B?aTRiK1ZHUEpMYVE0NDQrQmF3RUc5cG4yRTdDaDVjMndLWE95bENISXRqaTRr?=
 =?utf-8?B?clZqWUwyUXRnNDJjMDNjYlRFSXo1L2tFeXFianRUTkxKQ3ArK2hHVnBTRkxq?=
 =?utf-8?B?SFdCVGUwMTIvU1hGcy9NbkdMZjJZdVIrVGlQVktsRXUvQ0RhTEhDY3o4N2dh?=
 =?utf-8?B?UVhqeFpBTlAvdFB6ZGhzTzE1Vi90OVZZRk5YbkJRYm5wTUUwd2pSQSswa3Y5?=
 =?utf-8?B?WXV2VlZkZmJKMEUySnh1TS95ZkZ3b0E2eG5zenNhQ25odnRpbHV2Y1hhb3dh?=
 =?utf-8?B?SzlKd2xaMjA4K09CRUQ5U0NCVUxsa0owMjd0QTBHb0Z1WVZVQXV1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 780213c6-6026-4f46-c6d7-08decd443462
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 14:16:35.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK4wFivKppD5lQbLCgRbLGD6XMveQrxlgnzMc096w5byiO5OCyZFSZPRuh0T0NqAyzCvNM32vIaB8gLOoaXtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7964

On Thu May 21, 2026 at 8:52 AM BST, Alvin Sun wrote:
> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that
> modules can provide their `ThisModule` pointer usable in const
> contexts such as static file_operations.
>
> Move the `THIS_MODULE` static from the `module!` macro into the
> `ModuleMetadata` impl, and update `__init` to use
> `LocalModule::THIS_MODULE` instead.

Perhaps you could mention that this is made possible by const_refs_to_stati=
c
which is stable since the MSRV bump.

Best,
Gary

>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/lib.rs    |  3 +++
>  rust/macros/module.rs | 34 +++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b72b2fbe046d6..f0cf0705d9697 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -184,6 +184,9 @@ fn init(module: &'static ThisModule) -> impl pin_init=
::PinInit<Self, error::Erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The module's `THIS_MODULE` pointer.
> +    const THIS_MODULE: ThisModule;
>  }
> =20
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..b6d7b3299fbf9 100644
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
> +                        &<super::super::LocalModule as ::kernel::ModuleM=
etadata>::THIS_MODULE
>                      );
>                      // SAFETY: No data race, since `__MOD` can only be a=
ccessed by this module
>                      // and there only `__init` and `__exit` access it. T=
hese functions are only


