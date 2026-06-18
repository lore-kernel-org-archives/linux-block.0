Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020095.outbound.protection.outlook.com [52.101.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8373B2FC2;
	Thu, 18 Jun 2026 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792006; cv=fail; b=ZVM8sg7m2ZV4UebzYDTUDIc4lLDDL7PArupXukYFQSs3CMSBjeXNduj2Ke6pRHRhs2hA7GQxNiN33cqRn49DRHOWjuzc1miXEZs9bVyqQR9HZJE49MCflDbugm5UltRnQbDCXFMchLjPaX/dcLrMr8lla9OcdDxQpgZZH8iVhvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792006; c=relaxed/simple;
	bh=LGguICoG0DF2qdEGyvXd0jTj91Rt8S4MX8i6dxzVZas=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DmWBjgPwvQv6UkEfq8HNB/Bm8jSNCfcAcGgp6Z/FUfm5vnnqSj8rHt9WsBT24m2bx7PBeyMUTq1QfeGXLMuj4NIvgznASw8ji94u7DCcc3Uq0jNam4qg9yG8dj2urW6jVOOqgOLF9+r0xMWNiBIL6ScoExO70TeZSgaKVFHrlsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ti0Nan3a; arc=fail smtp.client-ip=52.101.195.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ti0Nan3a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9K1pv/iVb3NCHdopAtmDFsT8KbIO/c1LP5LzOfhOQvwKYsSs07GihWcjEewxqnlawSI7UE/u2/VpuTcc/xMx3ogBLr+OhBIs3e0ppNdHqTYEKSWNCRf5ujhyuisBn3VZg9/lxQWMDvJCRwDzZq8Ohrpqla2KX/y7p5aklMr+/e45m6AuS+bNI5C+0HaDy3iNe2gLIx0XiY1C+0epdS6OWfLnnIbl4jCJ2bDRahJxLb6v2MYYOMuXDHkXdXgiEgOliZEVECySxurzg3Fge0q6gz6CDNmR/e/mkwJCzD2ELbM1FKj0gPUhbB+cJauPzeIx62TQebM+ZUcxQFVk2K81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK4+LIHrLyMlwALjwaWbLzPn16Y6El+RtbotrA9WKec=;
 b=binkMd4Q1uINy58xhfCVme5Ue26A6fTSTiewIPgSae/kcalgOktXeC6XMgyTu3+BQUw+fFNpdhfQYTvHvhWQFdI/XJ9NMcEtNCaZrha7hyBxX/6Ax/P9it9rszlNVH+Y7ilyJF/VYmMyH/rkqEpGNP/RJfhyeO4HDSpv0qc/YUXduShvtoDvp0jfj1BYWcXEQqpU8OfauI7n7nyXUP+VnODYOQ3L0j+fITrSJhOkuilDjN2mVzNfA0V5xy58frBxw9+/Wn1jG0q6ItMyxplbjxaNR2S5JuthKRYjULBMj9UEcgc+YEB2AzpvJG3tjm4MVAWhKhJbkkX9d8hoNzi3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK4+LIHrLyMlwALjwaWbLzPn16Y6El+RtbotrA9WKec=;
 b=ti0Nan3aN6nYtMGc6lQK9ARcXL7OIPvPCCkGLKkhvoaC+rJlEeD0GsFzN7JCzUJk8rizWXdAEQqaE8oOiVZnRM3u2KCIGwNqAYCBnrUAGL3mVIDSP7vzt8o0w4yP4j1/YYOKUzA5pCNRt0sT+qX8Ry+BZlQw/FUdUGvdcgbdvUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6005.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 14:13:21 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 14:13:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 15:13:20 +0100
Message-Id: <DJC8JSYDERVX.2QI76YCBHDA93@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] rust: macros: auto-insert ThisModule in
 #[vtable]
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
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-2-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-2-fd99079c5a04@linux.dev>
X-ClientProxiedBy: LO4P265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0ef11f-41c8-4747-6405-08decd43c0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|6133799003|22082099003|18002099003|3023799007|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	M9P1Q3ZFMfeH7cBrlfiJTP9clnxe22iNRBfdm16oiruTiT+6M2gvKglBhwZT/VnaDHNpday4cP6uy52SBL0qeLGQnS/UCkWXiW+gXPFSn1FO7qtEFHJvf+cLI9YxcsyLn92/2EcU09dxJDeJemAmbD90Bnjbxa14PaJG33tzlpiiqPxGvOPnIele4a+7DNoqdVe0ejQeTh5YSypOyIGaE8KFlEfjiqpRHdTwT0ahZ2I6dHgybAwr+lavVK1DooBjseBPvUn9O/zvdSIzKnA+PGgniQpr3UOSlsg50FBOTshANEWoc4m8LR2l9bZUBlhHUxumd5t+JeOUKI8fWWhw97robOrfl385ZiJBc0hkCA1PZx/KYr5qiu495yPp5X9M+OY3+5LF2hdFZQVpwp4VgqzZinFmPDud010U2iPOvVRnkdS4dKk76q3hABYuU85PN7KllvjFXh/2AkAlXVBV7ntGuSFIeYjBA5usb3E7XhhLws/ljiCazrP85kIjv88HpFD8Ecd3NJZBw9Ga/wuM1/8ebhWRBiObK6xAtzYhZ6rQEiwcTyeUzlnleNzJExZR1yRW3OHahfqQ+rCaCsrjJdY7d/qQX9D5EQpUquMZwosQeCBH5Zk8KjSaWJZrfrGM0HNYvIyIxrDJLMyg0hXxt2Pc9RceDELEve23Cl+4Vq0H3ciTW65LWgFsTQ8JP8kea/BgXBP1YtruRhYS3cXDhSi+TjUFP+SKFqbU8FGD3GkoPupH+sN52qncuU8saTQp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aytGdjNsOThLL0JuU3hZV3JjZzZoWjcxVWp0V25ZTUYrdFhJY3EyclJqc3J4?=
 =?utf-8?B?d3BLYklyZGlyQWdsc2c2SlZYUytSY1g4aXF6SWk3cWJGM280Q3Q0b25rUno3?=
 =?utf-8?B?THZZQWpTT1Y4d3c1SVFRd0hJeVh0Z2NINDZaWnBEMnN6V1lUWHB5cjlPQWt0?=
 =?utf-8?B?QzdhMTZoVHZ2bEZDa2JRK0J6a05MUm5GMFdmSU02YWQxZXQxNnJEbzI5OHVT?=
 =?utf-8?B?U3N6eGhha2Vnb2hlZG9mYVBxZmZjUFY5S3VpcmRzd0VZenR3Nk0vMm1DcWoz?=
 =?utf-8?B?dy9SNFIySVUzbEhvbjF0RktJYVI4dElWMnpKLyt3bVdmMS94cjRIb1RmY1Fs?=
 =?utf-8?B?ZnBJdVlobEFVcml1UVJ6NlRvS1RuRmI1MG9acUJkKy9yeEljSmw4RXluYXVT?=
 =?utf-8?B?bUplNUUzbGhGTGtkNmoydkR4Y29oZ2NqaEVhRzlQR3dpZzNNMFdkYWVtUUlS?=
 =?utf-8?B?Rnk1aWdqcitQK1FFdVpkSVIxOFExUjJDY0RnYzVWTnl0eDBjTWdITFdKc1li?=
 =?utf-8?B?dVB5RUN4VzBOcGxwODA3eVhWVlE0UEQyTWlWV2VYNFpMbUZjUU04eldvNVVp?=
 =?utf-8?B?K0Qxbm9kRzFQN1JUdi9qTFZ4emRPSnVZcXo5SG9YVGI0NU5UQUs1TjRwcFU1?=
 =?utf-8?B?NEVGbjJlZWlDSGRxWkttalFWNDErdUdTTmpLVXh1RlF5aFBhZGpIZWNtWTFo?=
 =?utf-8?B?SDBOTVg5TmVhRVdRQWxWOUdPbXorSTR0VVJzVnN5L2c5SUo1Sk1XeEMybmRm?=
 =?utf-8?B?L0xGcXJ5dis5RExpTWRZWkZXbnV0dkZrSEJSOHBxanFxY3hGQnRDUjZnQUpI?=
 =?utf-8?B?aG52SlNMczdTQUNxblpJd3JtZWk4Q0F4b0FBWDAyWTdEN25taFpkMjh2ckxh?=
 =?utf-8?B?R2lEdTRjdmJVMkpmaHRoZnZycFdIdkxVVGpLa1NJajBUbWRpUTM3L2w5dWxE?=
 =?utf-8?B?czNlYjhUSnNUMjlCT2hXT3Z2aDlTaTNBQXgzM0FVSkU4L0xWeTdHUXlzdmJ2?=
 =?utf-8?B?VGViMEhQQkRqc29LSnRSdDJuYkFvcHBCUG5BMHZpWDhYVFd5OFp4RmZTWFgz?=
 =?utf-8?B?cHk0S0x5Wm9LMWttTU9EK1J5MWpjL0pRaGFsYkZGTyt2M1hTSXRsVnhsN1Rz?=
 =?utf-8?B?YXEvbU96akpNZEZhbk5OaW1ZYjVIakJKTEt3SGlrSEtnL1dtMDdQL3M1QXRU?=
 =?utf-8?B?STVmZTJqVkl2M0wyWFgvNDBqdWJZekpta21BbUZVZWpvRWhQbjlLeHhJeDZs?=
 =?utf-8?B?U3VmN3NDK0toMmhBekdac1ZySEY0dC9sUnlkSUxrZmlQb3U3dWkyMEJqTE16?=
 =?utf-8?B?SXpaQ1FIbGkxSkFxcGF2aER5d0lUWkZ0K0ExR0ZYZDlpZFY4ZjZ4bzFJZ1JQ?=
 =?utf-8?B?bTVZd2xrNXVjZmFCd3B6Q2hlKzNRV0N0Wk55eWhvSnlaa0tScFJXYzBaTzFx?=
 =?utf-8?B?ZUlhaVAyZ1lSb2hoU1JyUDNGM2JlM0lkcnVBbjkwVHFVWVluMEVhMVF1dlA3?=
 =?utf-8?B?VjRLNFFiRVlPVlI5QjZOZWhacnBJSFVyUFlLMW91NHR6WmQ0OGI4SUg1d3FB?=
 =?utf-8?B?cmNqeXJ5Z09FZjNwK0NzZFg2cFJlYWFoZkJCR3JEQmY4TmlGeWpTTVBSSHVM?=
 =?utf-8?B?UDFEMWc1S2lOcWxPZ0ttZWVJVE5mYVZseXUyT2RDRjdKYnVRTTZEZFVpd3dS?=
 =?utf-8?B?eEZVaFg3eWFwUWV0ckVFLzc2ZVVCV2psOVZVbCtnOEpNZ2g3WTdISW5IOEVB?=
 =?utf-8?B?ck1HbDdkdy90WXFwS1NPbFFRaTg2S0ZnTkhwUW5IVEZyOXZxc2R1bWNkTmNP?=
 =?utf-8?B?TCtxWWVoc1NVZXRwYk16cnU2WlhjWTh1aUVudjhHeTFIWDM5dWI1N2hsU3o4?=
 =?utf-8?B?QmF3ZjdJTVp6UG1aM3pDUStUZUxCWStBTFZrbkJQY1RsUUNQbDhzOFhGR3FK?=
 =?utf-8?B?SmZZOHdjdjBUZ0VBWmFGK3BvWWVxQStXL0h0Y2dSTmNYUzhOSFRHbGZBNmdF?=
 =?utf-8?B?eXNUb3d0UzlVcUVVdHV3Rklub25qb1BrQVhuRi9MbFNHN1VzYzYrRU5lcGxt?=
 =?utf-8?B?WUNwZjR3ZS9HYTZRRG1ncG83NThQRjFlWU5ralFybHVvZll5TGxaM3JMZXF3?=
 =?utf-8?B?VTdlK0t3UTdMTGJzV0xmTktEWkxqS3JHVUtkWWtuamRzOGZaTlIyMDNEZTZJ?=
 =?utf-8?B?NytuOHZTYnhmcFU2RlNvNnI4U3paL0hRNHRTN05mc0wrbzRRMWpkd2J5T0Zn?=
 =?utf-8?B?MUt1WkRmSzl2MG9nTWFaSzNHaDFYdUs0WmpRRVc5RDRSbzk1SkM2Q2lPRmNP?=
 =?utf-8?B?TXZQellOYUtMR0tDTGlBUlYzQ3ptMUMycUtVaUxYUXVIbkx3SFZzdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0ef11f-41c8-4747-6405-08decd43c0b1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 14:13:21.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGpr8v49BJS1CPRuhnL96ZLkMpGNJcb39+0vqcU9FeijWbxGslEnBjxVGCBKCLZMM+RQ4D4PV8K3aqK1BNsuSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6005

On Thu May 21, 2026 at 8:52 AM BST, Alvin Sun wrote:
> Auto-add `type ThisModule: ::kernel::ModuleMetadata;` as a required
> associated type on the trait side if not already defined, and
> auto-insert `type ThisModule =3D crate::LocalModule;` on the impl side
> if not explicitly provided, eliminating the need to manually declare
> and implement `ThisModule` in every vtable trait and impl.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/all/DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net

> ---
>  rust/macros/lib.rs    |  6 ++++++
>  rust/macros/vtable.rs | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 2cfd59e0f9e7c..d35e45ea745c0 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -176,6 +176,12 @@ pub fn module(input: TokenStream) -> TokenStream {
>  ///
>  /// This macro should not be used when all functions are required.
>  ///
> +/// Additionally, this macro automatically handles the `ThisModule`
> +/// associated type: on the trait side, `type ThisModule: ModuleMetadata=
;`
> +/// is added as a required associated type if not already defined; on th=
e
> +/// impl side, `type ThisModule =3D LocalModule;` is automatically inser=
ted
> +/// if not explicitly defined.
> +///
>  /// # Examples
>  ///
>  /// ```
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index c6510b0c4ea1d..d3d0e9cbd7172 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -23,6 +23,7 @@
> =20
>  fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
>      let mut gen_items =3D Vec::new();
> +    let mut has_this_module =3D false;
> =20
>      gen_items.push(parse_quote! {
>           /// A marker to prevent implementors from forgetting to use [`#=
[vtable]`](vtable)
> @@ -30,6 +31,28 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTra=
it> {
>           const USE_VTABLE_ATTR: ();
>      });
> =20
> +    // Detect existing type ThisModule so we don't add a duplicate.
> +    for i in &item.items {
> +        if let TraitItem::Type(type_item) =3D i {
> +            if type_item.ident =3D=3D "ThisModule" {
> +                has_this_module =3D true;
> +            }
> +        }
> +    }
> +
> +    // Add `type ThisModule: ModuleMetadata` as a required associated ty=
pe if
> +    // the trait does not already define it. No default is used because
> +    // `associated_type_defaults` is unstable (issue #29661).

I don't think this is relevant. What's the sensible default anyway?

> +    if !has_this_module {

Perhaps just make this an one liner :

    if !item.items.iter().any(|i| matches!(item, TraitItem::Type(t) if t.id=
ent =3D=3D "ThisModule")) {

> +        gen_items.push(parse_quote! {
> +            /// The module implementing this vtable trait.
> +            ///
> +            /// Automatically set to `crate::LocalModule` by the `#[vtab=
le]`
> +            /// impl macro.
> +            type ThisModule: ::kernel::ModuleMetadata;
> +        });
> +    }
> +
>      for item in &item.items {
>          if let TraitItem::Fn(fn_item) =3D item {
>              let name =3D &fn_item.sig.ident;
> @@ -58,18 +81,31 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTr=
ait> {
>  fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
>      let mut gen_items =3D Vec::new();
>      let mut defined_consts =3D HashSet::new();
> +    let mut defined_types =3D HashSet::new();

I'd just rename `defined_consts` to `defined_items` to reuse the same set a=
s
there cannot be assoc items with same name anyway.

Best,
Gary

> =20
> -    // Iterate over all user-defined constants to gather any possible ex=
plicit overrides.
> +    // Iterate over all user-defined constants and types to gather any p=
ossible explicit overrides.
>      for item in &item.items {
>          if let ImplItem::Const(const_item) =3D item {
>              defined_consts.insert(const_item.ident.clone());
>          }
> +        if let ImplItem::Type(type_item) =3D item {
> +            defined_types.insert(type_item.ident.clone());
> +        }
>      }
> =20
>      gen_items.push(parse_quote! {
>          const USE_VTABLE_ATTR: () =3D ();
>      });
> =20
> +    // Auto-insert `type ThisModule =3D crate::LocalModule` if not expli=
citly defined.
> +    // `crate::LocalModule` resolves to the real module type (via `modul=
e!`) or a
> +    // dummy fallback in non-module contexts (e.g., doctests).
> +    if !defined_types.contains(&parse_quote!(ThisModule)) {
> +        gen_items.push(parse_quote! {
> +            type ThisModule =3D crate::LocalModule;
> +        });
> +    }
> +
>      for item in &item.items {
>          if let ImplItem::Fn(fn_item) =3D item {
>              let name =3D &fn_item.sig.ident;


