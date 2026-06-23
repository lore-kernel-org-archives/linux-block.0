Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7263672A9;
	Tue, 23 Jun 2026 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222606; cv=fail; b=GN6zP/v/ay5V/xuXPJtrymkpJUPUDVCJhr6SJFiuQJe8o0fDGqR7qjH0h4cvL5ohShq3Ksjvjtp+Z8dG/yvNPQyqEivI/7lH5ksmRaagcVpj7vzudC4V9HJPTLFdb64R5B3FIDkZ8sF+VS/VwF3Mj8XrEDmLbThaf6zHJerFC5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222606; c=relaxed/simple;
	bh=+TQ0ucLH5xhd0sXN3p3S1X4HAQ0r0OjdP+NOstT49XU=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=ehIf2gIEbBlzy/Vnwe8k262lBj5lHLLDngvY2KucZZdbFEdNReKeQb9iMyyocEzzU5oKbZWzkXZBSp2m168U/qiP+R2N+4rOo+1ZFrOpElF4BcHT/7eeam7vpOr6qjRP7tRz83jJzFPucQs8NYKQ+dHdtF1j3F7gTmST6KLDhF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Msl4k8i6; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Msl4k8i6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAIYqmRUR8buT1BYp8yG2VAZnUSPi5rfa05ScrDdEGyO5N9f3yfcsq9RJVyXK1BIHcDk3kdKbZgt4Qwtvg1O89LZXburuXxZiCAyWkecKDn1y/Azo8+JcDFVZ0vE/ggR1ZER/6HvRnKrjHJuu/at5OfX1vsy81EC4TUnOtv8ifE0JrjHFrCn2SlPdavT/gtP5vqNGjD+jRgTnqjGrvYSupSMyFPvfdUB0Io8RN9ag3unZorG/LPnCcEbHJ6fau7PHCFlfYEiQu2X8unTSiGT0e+AYQ5NAveBWIbGlhQ+MXsv3MFHDwKEzC/KuAyLbV7Xkq1U0sVdbC8GPklwTouBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5piYaRMPmVmdlGXi3BoWv2WFx3h/hxOuiIO7fJ7ViTM=;
 b=FROFqukBQ5T2tw83RClvcVN3KbdRww46E2XgQPh3LzNRCTezY1BUzoVAPjSyV6Lo+a31r9f42lXwki7vi3KxNzm/D/vSQmfdHD+ef3GLwQKDWerLH6WdjzuRn/aeq2nTw8AXWs1fqOnmKFAZupGE0JbjMvk0Ws+0xoLJF8gW6UU5rKT31P7FsEQB35OKGuX6rN7/9v990pDvXUwrf80V3vjjpyql/NQvqrjlDRbwhjLbDbhjzEukDjyLYLHqlPYMb4vptNAWgu6+r7QWfx8shEYMLW0PL7bpzcDmswsx3xwwrpERUoN4TRV4E/212nUZHQY/BYa+xY335bCAH/SVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5piYaRMPmVmdlGXi3BoWv2WFx3h/hxOuiIO7fJ7ViTM=;
 b=Msl4k8i6reeJ8iTeurph7tOOBzBZduO1ybOw4eWaS4fIK4uS6fc438pTahF5tO6aAf+OnV60DMlO7jFgqR8Mwali/NxupM3VMqAVlhuowZeJeP4n/lrO/79NKyG1DTYPFz4Q3cmpOHTSu0yTHXxfiQpOr5RiAuu0NsUhW+lNsu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB7272.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:49:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:49:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:49:58 +0100
Message-Id: <DJGH6MRDEI4Z.108CPROD89ND5@garyguo.net>
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
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
X-Mailer: aerc 0.21.0
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-3-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-3-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e56f935-086c-4ece-158c-08ded12e50e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|6133799003|18002099003|22082099003|921020|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ys7YJAueNHOMVdRIpQAGzZwd4UiNxzmMNpMF1hQf/bcXg6aRvYOaYSiZeKzkeLjgypFm4qru/ghkf4qrgVopO/AXfkolkFsGuRRF7fBu13QrI6E3ajftcQwxVi61LC5GY8Q0D7C9WloNMgim8kfrry9IR932RzpEeE+pyWgJzpS/X27mVXuErWuf1FKPQz++59afuvmVooB6rUzlS1l91s31t6rUHAcic1uc2yJ5G5fKLRk67rZ9782jQ6zb6QCIFTa5sr5cir8L1HM+qMr+ebZMbWOUkgo++iOWZ6lga6KLsmSzDxHu6od1TFWt8msNPjcNV4Y6ije8wwxdMz7pf25U+2YxMMq6YvZJvHd7+mP0gAaniHMdAWhQfS7cBxtcy2/jBBvyKvQZ+yWMczbj57Nef6dcr7JCT9SAGbjPUyjBvs6xzhsWecZ9MT0rNNhUfUB5iaKvB9xK21L/h6/nZXvKqPSDwiFWU4DOh++dsIjfxMkRycNMX29Ca7w6J/cxsyxh/IV1B/4aG5otrYfm86dPbxTUvx0dTfgpbSRWdbcQo6QEsjO/vjrZT1m6MhTMQIXjzZFW+yohqArrVrTXWu1z3qQekqRDNwymjl4zhQRRapRTK263vIKuRwJVbFNIR7t67TSZ2FpuuDgGEiyhO53f0vIqQsP3XiPw/ciahaPmK8sEZLp2+zgnz9Fm0LbZpsitDlkt5UbfPsNHIOfE+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXZVSFBudXFEeUdiTEdjZllGaVBDQWIzYTcxUzVtaTBmcjZSc2JmS3dXQWVI?=
 =?utf-8?B?Q21TWFYwSDJ3S2xCUkdyM1VkWG0yUHh5Y3gzUlFKb1UvcHNGYkJRQVV3Sy9X?=
 =?utf-8?B?dTN4TlRQMnY2VHVpSjhEZHpaUDNVa2s3U0g1NDRaWW4wNEU3UTUxdEZOY1FQ?=
 =?utf-8?B?SW9VMFBIM1kvQnFiOG96SE5Ic3JPOWFHODhnc0hNSHVqZVNqY25xOHdqdDBu?=
 =?utf-8?B?VDRieHBPeUwrYSs1d1FWNG8zVzlzSUhnVEtFUlpoN0dWQVl2NXRRV2hsY1cx?=
 =?utf-8?B?SmFYSzVMcWdvOFB0NU81QnI4OHVzU25Vb3Q0MFczMzZvWExoRTBVQjRMTklF?=
 =?utf-8?B?WG80VDFvOWtMRGh0YlJtbGUycmxFTFpTcjJ0ZzVHSytUQzJiOFBjRG82aDR4?=
 =?utf-8?B?T2E0U1BYNWowVUp4U3NBajZSNkVZVWR6aTNLSkNxTzVrMDR6N1lLMGo3dW9H?=
 =?utf-8?B?cEVrNTllMWVoKysyYnpqcGd5czBPL0xzNks4dGxCRG1HZ0FuTnJGSTVTc3dn?=
 =?utf-8?B?QmtES1NqNi8wTFFHT1hvdUM4aHRCRm5WWjNkb3NISjZETHU1UCtBbnhORC9m?=
 =?utf-8?B?R216RmhoRHJSLzg3TXU2T2FYZHpjM1BEVWYxYVVyRjEyMDVDM2xQK1B2RWtR?=
 =?utf-8?B?d0JnZERhQi9VbHVHYlBLUDRwcXVQMDlQcjhZTnEyS3JJbkp3YUplYnhHLy9v?=
 =?utf-8?B?blZmcHpya0FkOHJubUVwRi8zVzFnMENZMEFqU2tJN0REZCtNSEFOQ1RRZTlw?=
 =?utf-8?B?eHVWTDFXbTdYQk9uamthai9OUDAycFNXU1h2VWhwR3k4L0s1VGJUbFhtL2pW?=
 =?utf-8?B?Ry9DbGU1VzhUcVNzeXdrSWkxNUZBaG8zTkM1cFovdHVaQ3BWY2dMZkIvU2xE?=
 =?utf-8?B?b05GMHp0bXhGcEZHK2EzK1lYNnVxMFRFMUt6cEVTUURaNzNvK1JXcTk3ZDBu?=
 =?utf-8?B?NXR2QzBBczlLN3VsdUdPOS9aZHozY0UvZjdVQWplV0M2bGhXaTJzYzlWdEtj?=
 =?utf-8?B?blpqSDlWRjRFWHQ2Z0c3eWhXQ3hTTEczUDYxc05EZ25hQXIybExoWUFuMXFW?=
 =?utf-8?B?ZURrbElkMmZBWVJlNzFmSWR5OHdzNTVEOXJFU1R1NGMrMkxBSXN1RFJCaTg2?=
 =?utf-8?B?R0VCaFhueGtGYnZBVWNsVVY1TmM2dFI0dVhsNXhEMm1lRUNCOE1EWExwU1No?=
 =?utf-8?B?ajVjNlRqYnd0eDFGSkVCQnlYR0dhc1NZVHlwRHBJZXNyQURLWXdwQjFYWXQw?=
 =?utf-8?B?N09jQVA5RDA5M1ZHSmhHekhtZUNZQzhROWFmbU5nT005Mk9FLzdsUEQwT3hx?=
 =?utf-8?B?MkZPTEV6bTAybDRoZXpsSlYwUWRkTU0rQ21KczlPRlFHZ3JYT2JDZlV1Nita?=
 =?utf-8?B?aUE1L2dKaW5PVHp1RTNCM2xLL2FRSC9DTVNXM0Vka1d0RXdBZVU5RHBSUjM2?=
 =?utf-8?B?NTlUSFowRXVrS1dkTmNtWjRSVTRUcFpNTzBNbGxFLzViUk9DWGh1WVR6ME1o?=
 =?utf-8?B?Y0VyMWUwalNRa2VKTTdSU24rY0Q3U0taYUk3d08vOWxtNU5LRHdDeEpqMUxG?=
 =?utf-8?B?ajNDS3FiREtKLzFZSlBGSFU0Vk9yNFV0SFdpNXJaVG9EY3BqaWNMZThwUnZZ?=
 =?utf-8?B?UGpCbnlHcWpUVXB1NWRYRTdSQ2xZcnhzb253bWNQSGdqRktpM0E2N3V3Y0tZ?=
 =?utf-8?B?S1YwdENJckQ0WFBYRnlHSHEzTDQvK0d0U2dmandEdzBwOElGbmEzSE5aM0xV?=
 =?utf-8?B?SW03SlVIbDFRLy9LbTlkZkpCcWJWemV3dTRVc2tmcStBMUYvcUk1QkhucjVh?=
 =?utf-8?B?WVZDYmNNTWdGamlDcFZsMTdQdit1RHBUY1FUK2grSWgwSEJWVDJpRlhqak90?=
 =?utf-8?B?bkl6TVNhRTRLREhDSzNoMTVoMklsVWNpNDNZU2U3ZDFZNm83NmM5NHVBRlJU?=
 =?utf-8?B?alpwNVkzQXEwajY2ckprdk1iSE1QdTZka1FNZjVnODhOcFJiRUJpc0Q0dEpn?=
 =?utf-8?B?SERaZVZJUTJUNXAwRnozUWN3dk5obE5sYkd5clh3eWMzZGUzdjRFak9tR04v?=
 =?utf-8?B?TDBsTVJqenhINzN1Y2dTOEJFMGVDNUdFNnB4QU03bEdtSVBOcXZzMW91b1dV?=
 =?utf-8?B?ZWk4cTV0TU44NThmZmxSak5wRURpNTdYYTgrcTQ1djByTVU5cGhPaUc2V3hP?=
 =?utf-8?B?L05EOHpiSVFWNmhlaTNyTEFXellDb3BhNnF1NjlWNjVpMU1FQjlid3dYVEsr?=
 =?utf-8?B?R2E4QUh5OUdYSVEwbXo0Z0tCWGwrY3Q2ZXhzNFFtTEdGQi9PWVhPSUJ1V2k0?=
 =?utf-8?B?SitaaHRNbldnalB4bDVNTWFXclhQRDNLUTc1cXRWYWd6ZmtEL2dOZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e56f935-086c-4ece-158c-08ded12e50e4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:49:58.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxxRkCT2B8fB2NNiwCX8iyq6agAvaSpG7WWUGelOoy9JwGLYZ7EA0U8JSwX108BmjHM7PWD5ekmvAs55qNmxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7272

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
> Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
> in the doctest harness, so that `crate::LocalModule` (auto-inserted
> by `#[vtable]`) resolves correctly when there is no `module!` macro.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  scripts/rustdoc_test_gen.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index ee76e96b41eea..198af4e446c8c 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -239,6 +239,22 @@ macro_rules! assert_eq {{
> =20
>  const __LOG_PREFIX: &[u8] =3D b"rust_doctests_kernel\0";
> =20
> +/// Dummy module type for doctest context.
> +struct LocalModule;
> +
> +use kernel::{{
> +    str::CStr,
> +    ModuleMetadata,
> +    ThisModule, //
> +}};
> +use core::ptr::null_mut;
> +
> +impl ModuleMetadata for LocalModule {{
> +    const NAME: &'static CStr =3D c"rust_doctests_kernel";
> +    // SAFETY: `try_module_get`/`module_put` handle null module pointers=
 gracefully.
> +    const THIS_MODULE: ThisModule =3D unsafe {{ ThisModule::from_ptr(nul=
l_mut()) }};
> +}}

We probably a macro for crates that are built-in or are not the main crate =
of a
multi-crate module, and this would be able to use that mechanism.

But this looks okay for now.

Reviewed-by: Gary Guo <gary@garyguo.net>

> +
>  {rust_tests}
>  "#
>      )


