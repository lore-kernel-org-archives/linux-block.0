Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021081.outbound.protection.outlook.com [52.101.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9A337B99;
	Thu, 18 Jun 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792107; cv=fail; b=njPrVrS3XfFhp1G6pEFxcaBYv+5WPXo9yPVW9vPpPA99GzlrmzKWJEH/ShRZ68hZVNXBVqhMeqlEx1F9sn2m/r5tN3edAyf43f8airUFyFBxjvy0JYI9oaSbAzQtoqMdUX5or3u60tJLbfs7hFsR3PtWlfclMm4P0upbvPX0UuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792107; c=relaxed/simple;
	bh=QJp+A2fmJQwENSBldWCCIWyw8gkosUO6WpTwVheebts=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MRyAXD/Di4qyg7KFyRqlZZGGJSs43fnVnGXJIvEHx1owEqTpM7ERb9C16+w2OBbjR6qA0aci6kgPvt079ulhH6TBDYly1/VcZpuY0PuQ8j2NXEVzH2+Q1bkwmzzILAxpsKE9vUFaYE40NFM2qwzwqKwtorAtGPVARDmc+/b3ggs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=l7uLzTKz; arc=fail smtp.client-ip=52.101.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="l7uLzTKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT/YBscamNqWACAPvCRnNjz9xaeiBhsCbsVrA9ap7lRt/FrhN3d5VIsTV1+bIc7/09o5YPiAycZk54s/IrsvsRgAK+ZNzm1EgaXKkMU4j4Y825Nzg+julxwEkBaSh+4d9hZIW5DMQVbSfem1pD7qJNH/UD54hWNTN6Vc/Y2MnikXxyzEZQWWcpeXrLusoRO++m3v7FL2jwVagfyOOkz3RH4D+FOofqhfvdOpFnzw2eui7ou6DTQQW6kuqkqcEscN7jzuT/4cMCr8TyuFVWc54hhpuCBglMbWs2W7JnJ2zA1TFCGSAchAUxj/5YL5YjiawcDCxetIAoMrXdYeW9EWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiaO2UyhLy6+0J3jqS0fhWy1eFYQRbm8PKDcjZ4HQFY=;
 b=CrVL2c1D+Ev7m17HDcf0TgExrrc6cJdPzuMguQlqshFVo5nEuuDKfNiJ3fkZdEWAbbO3uokfyTS4niCe6XGsI60v0Bs0KLCMjSIm2jm29xBi8KDV8e+Hn3rUma3azld5Bzf/juyIcj546buw1EiBwDh8atj4si+Jjiz4C+MZQ8htz3Cak4dRUw+kEZDyX6r/q87rS9s+fJVm89DXtW9jTdnhA5Qio2cyUiFlLsssCuN0KM6NEd3FNhBgcKnDh6eOgAb4v6lJj2axvxe7NyUDxgwB8UhBoCVnjZFF70ldvEo9pIKcvkvLyx1eg2DVk+MbgMkasjiw8XLHciOBlJ0ugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiaO2UyhLy6+0J3jqS0fhWy1eFYQRbm8PKDcjZ4HQFY=;
 b=l7uLzTKzniMA0GFZYYdwgXU7Sl6SL5Y52Sz1pY57TyKMBgBG5O9oid0W8MbaVAKsvEYBRhLFb5nQA65c9uGk/xLiAFPhs4qphB/EeT6LuXOo+IJ6pu3orhIuYp0IE87pZS6T8Wq0/+tLhjj7RAu52ydj2+MCF/5EJJ/m+CeTG54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2987.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:183::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 14:15:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 14:15:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 15:15:01 +0100
Message-Id: <DJC8L3EXC1NA.1JM4AY78YADO4@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] rust: drm: set fops.owner from driver module
 pointer
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
 <20260521-fix-fops-owner-v2-4-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-4-fd99079c5a04@linux.dev>
X-ClientProxiedBy: LO4P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2987:EE_
X-MS-Office365-Filtering-Correlation-Id: a81ccd92-3a6c-4657-d959-08decd43fceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|4143699003|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7EiG6m2bun8H95WW/M2tL1GfAePMMkdOBJ5ztUkaTXx/rvYz8zkShKBr6T76hSrt697MMxLbpyl2V3+GpfEONthprM4jx4gFoh3TwXBg7OZ4EsEypzsyPDgd3lk5CtITP9n/i3b4QTp+LPgyw/BL3QKzWAYe4q+ZvDe1CVsjIzhybF6POK46msr1w3Nt+s+rktWQtClw32/KVyPraTmQYAWs9CPhFTl0+EGrNfMaAO+P8qgd9rdM0OwA9ViKemZWmFGdjqeEOX+oChKgx0otqV1YNL9j8+VAKSo2i46jlW1dfYpFfaE+5ouSXrMCnPOv/fP0str2q6gEaSkZabKwRaczbjYdTCe3rbpYMNOtp+PLPWWOGzAmmdoDpfX4En83egyrYnPhhKkBefc02gwjUawbHRGrtCOBUCM5iI5px4AETdSNssapgqWtFH491WpmDbhiWZZNIQ1YcU4+sv0fmt6ErLJ/L1v3elxD1n8Ksgw0pSW9zVX79wDBURCitlgJ4LpF81raeLClystWTmFUoxBSYGVtvoTZ/z9LFBlmwnDDo+/CpAt5sIe+vetebJkXNRR9vcRlyJFyQ/uoX4TRXk1wiyA2zKYdjzerUEb9IAJ958xEV1nDyHttPiSA0uoFa/QaF7SIUCxsKhjl3oP6CXpY8btZbQratAso5dqRlPfNrIV9EsYKHt69+UzV7AZMlzJ4GeM8/hMUTrV/jun1rXVqlovRbzQduWCaZgQgUOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(4143699003)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFtQXNic3gvUDlSYXJkZGZubTFjdFVMRFpWS0tQUUxUTmpFNDBSTXlKRlIx?=
 =?utf-8?B?N295MW9JejM1UjhJZklhclNkeVlTa2hMRGRKYUcxYmpSbFB6M2dGdlJVMU1O?=
 =?utf-8?B?TUZVdkc1cm42SFBIblhNVy9nNHZmVTVzdGRKbXM2TzU3WC9EUE1HN211cXpm?=
 =?utf-8?B?OFJjT01WUFg3QkJCN3V5dkdrdkFaRHpxOG9pSjJxbHdiME1JUXhDSUZwbWU2?=
 =?utf-8?B?MVJRRll1VUtwdHFBM293cDJEems1diszb25VYjNIUlJNSGtSMFJjUDdlKytQ?=
 =?utf-8?B?M3lGNlFtVUY4cTVEOXlvQVNLSTl4QVVERTkwbG9Gc0xlY3h6VlF3aWlxWEtD?=
 =?utf-8?B?U1ZkY3B0YXF5enBhMUFlaTJUNkF5NVF0NXFZbVhKZFpWK0E0YTlzbG5MTVlS?=
 =?utf-8?B?QWdKSGdsdjF2S29oVjNWT1pQTDJYTTdzRldJRzh2Mk55T00vdWhLN0hNRXlV?=
 =?utf-8?B?YlYxdlkyaEtOVWdERXdURkhjTzR5TTNmdTBzMktEbnFKcDB5aTZpL1RubVdD?=
 =?utf-8?B?d0R4OERWNHphamMxcFJVdFgyWVByQ2JJSEt6L2NtMTFGQkwyeEFUYWxKYUYx?=
 =?utf-8?B?M0VQb1F0RjV6RFJkNHpEMTd6cWhsVnJnd1JWeTFnUURZNWk3SEFOVmg3QzNt?=
 =?utf-8?B?R2pCNm8wczAzMnVwZ0pKWk0wM0pyTU9QNVRkYW9yblpjbHdxaEwyVENQZDNV?=
 =?utf-8?B?aWlPMnlxNnlCbFNvME9IUHlOL2F5T1QzMnllWk1ybHY3NmJiUG50akhoK0RS?=
 =?utf-8?B?KzkwUEV4N2lKSHJRVFBhUDVkdUZxNXdHemFSRW01MzBMMnVTM0VJNU95bU5M?=
 =?utf-8?B?WnFUdys4WldmT2NHczNaWDBTNXVKWU14aVV2cVRxdzY5SVF0MjFwc3A1Nnlk?=
 =?utf-8?B?S0R0MFBWRkdQUGVWTDhrY3ZBdWpQc2owdzFIZVhtVHNNWWNrYlIwb2VBSGto?=
 =?utf-8?B?c3pNODFFSk9tcUhtMjFWZG9kTjlQc2NZcWsySFp5bkYydzhrZ1ZYbG9iUGFB?=
 =?utf-8?B?UThMeTV0Y1h0a05iVmZqZ1p5Sm5RYkxyUGFZSTlocWRUcVRuQmJDWEV3bllR?=
 =?utf-8?B?ejR3YzZKTkJYSlhVbXdydmNLUDJsUkxxTFQ0YVhlSG9zTzRDNnQ2dzZyRTE0?=
 =?utf-8?B?b1dNd3U1S01OSU1nOW1VMjIwRTNsU2NxSDJ1VlJvaTNYRmh4d0hWMGl0MHZY?=
 =?utf-8?B?ZE1GUXFOc3laOWhHUVlhdUl5d0l0TXFoZUhSdGRrQkVlTExYdjhEeHRkUzE4?=
 =?utf-8?B?NjBVSWtWZ2V2OHNLUTAvTSt5YWdJNE0wMU1yRkJCY0kyY2k5alNjdVIzS2No?=
 =?utf-8?B?WGpJQXdCNVlhU1RlUFpYbEVVMXBtNEc3TGEwc2tieE1ZTkoyNm01UlVtZnlI?=
 =?utf-8?B?V1hZQ0lTelFmR1MvZXM3eER3Y0xySHZValNTQ1JYamhvczhLS01DYVhmenVQ?=
 =?utf-8?B?NkdzQitjVXJLdS9kTmlUSWczYW1NdFljZUR3KzFRNTRoWXZhemxQdDVtNDdh?=
 =?utf-8?B?QWFseEt1RVNteW9SOFdIME1zZmZYMjNTd0Z5Szg5a3lVdHZqM1J3cmlhQ3lD?=
 =?utf-8?B?ZEJYZ3drZSs4bUZDZlpqVXFuNlB0ZVh6RGw1cWV5OHZlSXZjcDIyd1V2aFRo?=
 =?utf-8?B?Sm5rdFlSeFNEN2ZidUxuZmYrdTVDUGJmWTVLOElHQmtVQk1xa24rNll1QmZE?=
 =?utf-8?B?RVZiS1hmYVRLdDA5d3VNR0dmUnpRV0VLa0hPK0pIN1h1aXJNQ2svejFoM2VP?=
 =?utf-8?B?YzNONkRMUWloaXprK2NMc1FFWkh1SFFnaGZ6UzFPQ0xWU2x6cGtrVUZWaWEv?=
 =?utf-8?B?RDg0SW01ZndDOUlBenJxbXFWTlZNanhtS1M5YkxBZklqZTlzcFFyd2lBbWZP?=
 =?utf-8?B?bEdUbDZ2YUNBbmN4L2pQc1BuRjdXa2U4OXhMOEg5c01SYWNtbnFWcXBuWVl0?=
 =?utf-8?B?OUdqdHhhbzYydWI1QTh5VEV3NWRVa0hlUHRMUEZuaENBMHJTcHk5a3JDSUxF?=
 =?utf-8?B?U3c0T1p4L1ppZHp0MUFQUVZ6NGJ1S1FQR01tdGpQZjdIZnd1blkzSHVWaTQz?=
 =?utf-8?B?Q1U2UDJzdGh1djgwNzM2andab2FoRUszaEFZMnFqcW9GSno4QzZuck1ITlkv?=
 =?utf-8?B?RVJrbVh4MExtMkxJRVZOdXpkYWlUUkJYcFduOXRBdUR3MGU2U2EyaWpCbkpX?=
 =?utf-8?B?THVmR1lJR1BGQkl1TUlXWmEvenE4RnJsYjdJQ3J2MTdjSjRYREE3RktCRkgz?=
 =?utf-8?B?NVU2KzJMTU9BamxVMFUxTWVwTXU2eGJ2YjNGN09LTGMvNEVsSUYydWNNQmNC?=
 =?utf-8?B?cUdwSktWV3BjNlhQT3dlSENBYnUrbjlqTm1rTGw5NUFlNWtYK1BYZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ccd92-3a6c-4657-d959-08decd43fceb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 14:15:02.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9jnE333t/Ts1wdGc5oantcLT7dJPuhQIELMEkCzUHD7p62voH5p4DMLCv7EXYSjprbsS7EEkGg5HarxPweHqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2987

On Thu May 21, 2026 at 8:52 AM BST, Alvin Sun wrote:
> Change `create_fops()` to accept an owner module pointer instead of
> hardcoding `null_mut()`, ensuring the kernel correctly tracks the
> module owning the DRM device's file operations.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/drm/device.rs  | 3 ++-
>  rust/kernel/drm/gem/mod.rs | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 403fc35353c74..53e44a780ae97 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -111,7 +111,8 @@ impl<T: drm::Driver> Device<T> {
>          fops: &Self::GEM_FOPS,
>      };
> =20
> -    const GEM_FOPS: bindings::file_operations =3D drm::gem::create_fops(=
);
> +    const GEM_FOPS: bindings::file_operations =3D
> +        drm::gem::create_fops(<T::ThisModule as crate::ModuleMetadata>::=
THIS_MODULE.as_ptr());

I wonder if the assoc type should just be called `Owner` or `OwnerModule`?

Best.
Gary

> =20
>      /// Create a new `drm::Device` for a `drm::Driver`.
>      pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>)=
 -> Result<ARef<Self>> {
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 01b5bd47a3332..9a203efc59116 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -357,10 +357,10 @@ impl<T: DriverObject> AllocImpl for Object<T> {
>      };
>  }
> =20
> -pub(super) const fn create_fops() -> bindings::file_operations {
> +pub(super) const fn create_fops(owner: *mut bindings::module) -> binding=
s::file_operations {
>      let mut fops: bindings::file_operations =3D pin_init::zeroed();
> =20
> -    fops.owner =3D core::ptr::null_mut();
> +    fops.owner =3D owner;
>      fops.open =3D Some(bindings::drm_open);
>      fops.release =3D Some(bindings::drm_release);
>      fops.unlocked_ioctl =3D Some(bindings::drm_ioctl);


