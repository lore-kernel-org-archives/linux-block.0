Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2C377ED7;
	Mon, 22 Jun 2026 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125438; cv=fail; b=gFrRwOLZh7mdoLOkk4v1yvBiuPTlr1WjGq+tBzNzZWFKCwTjmzJag0q77zMgYyn1pqQKeO2CHCo3A1vXihoAMi2lYhODOYYzz1TCTRPGJyYWA+FxXQsNsMi/A+/b/RaMPw/cGVwCxL1RgLZv+iIAfD3Ba9Dk7aQWzHyHbD2YRIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125438; c=relaxed/simple;
	bh=oFYFwGGA6BVGYjdt6TF8CvlxU6Z70Omxl6jnO9H7pYI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=RU3tRC9QjeUltO7H69U2MrL4VjrcIpXcRm5pik7qeIOMVegfFcCvOL/e88jYqOo/LLNIfzjqq1dE4PggZNC9QsfLTd9KoME22sQq/47MP2hl4hMD0k0AOO6bTsGrxtoOdnb7qiC/dTpcNyGgdYJbdANyJamxLRVtdf0wuY8EzPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JpfdQqxr; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JpfdQqxr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzEV9nDg2ezFTR4IlMn8Z9/L+0fqhZEqCwVcNUduUB471sjUWBPjOisG+7LSqXTkwFOLnSDTbVVoVc5oHoe+yaf3X/qbyTVPRIbTKYY9b9JqqzbQNnbsn12riLBKWy6xI5pO+rNUyqTnf+J8lSPZDWTHnvLZRtyRR/9rSnor9uZLFqoQABN5e9JvcIpr0dXLEibp8DyOST10WhL0X/9vx1e4i71Ll+aKIAubNg/41xYd34Ch2aDfeBRL2BZJLW6aBwwkDp9YSgtkhpoY0iGj0GFR4G73CrqT4ow9sJmMUjrsz5yTB4R7OXehN+R6dyh2WM4FlU5H40YYy/GqSAeXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6goImp8gxgefLdolFq7tajt8rR8if+B73I/tD/3xz4=;
 b=J9/0AX4ie4rSxT71ng1J0H6aN+uuof/6XHl7R3UkwEbzbCscBfwIAnOGPLkWShRD0Ppi1AuQg13nSwWEKAZ5ajWLn0dA1+UThtf+kv+idk8IzCuf/TkcfQUDNm55dB4eXcHDRAZbGnkWUBWNU9ob5q1ynQQ24fNmcB5AYWPsX/jhMpTGq699nHnKT4tph/UR36jka0TZILKchyArxeEvfkjhAWe074MVXEgWGJ6RyciTX6Bn1iVFH4YpOwyos6Igi8pCFHtYTo9VbPDzQoEsZgqS+G4PoliNykbTlP0/RR/elTHOpGerkMafdFgJq64eMv1SWEEoqXCs2SFvtkP3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6goImp8gxgefLdolFq7tajt8rR8if+B73I/tD/3xz4=;
 b=JpfdQqxr5wlAK85kFnCtFVPMf7/6hk8XcCB+gOB0g7KKcFfWMy4iOiNaP0X23b3En4RZe24PWZmsZ4qegNxuTvJMIKJiikSTjHTDk1Q7povx642GT9jORAigTS6otP8OcJ8yOkkOmd7ifv5mj/JUW/nhfHIwyOCPe/eNVm5+5Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2191.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 10:50:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 10:50:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 11:50:32 +0100
Message-Id: <DJFIQPLOVO4T.1K8T0VZM30LDA@garyguo.net>
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
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2191:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b63575-d9c2-4c45-8a25-08ded04c15c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|23010399003|1800799024|921020|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	88H5YPr1cVyqA+1bRz4VBrwTC0KmJsiU7se4gKNdG6FIsZNwDXb/1YLjv1I3vUgF+s9uOrKtGVCVkugi7Kb9n78VzgHES3cnPGaO7BDEQPGHATsCIw5PBYLk/RRukw8sadARzk4s8X9d20fp+Wftokjp83ea9h/lrA26vDCxecFDpZOHkfCmvG9MIpvLmgnr314XsDX3xdxrgUx8aQ+04fjXZJriEKiPet6qp1CZHuLQtFuJoy//ZGkYgqkrcI8UMcJoV6WKNwZRvgxLTSvldfk1zm0wWoseuHOA18LCs1m2JVTmIB1QPU7FnDHwGE9zDHE8cs6Tf5frjzFDkCxOXBnyPAbtmuVG2GQO++KRV8Bn1VCM6wCqSsw1plYt31IW1N5RbqNTFcQDFgswWR0OXQa6Z9Hiig14BOmAz438l214zKnEWHDMKXOrl/y/TKGQVaNs7nR+PO4eD1TXVzE4OKWBM92iodh3qiKg+rD2rLx5QORqTEnajbHXxG/N0oiTChJofWxuJEGVT66WtN2Pe3Ii74uYIGfp/462LZAqWnRlU1olgFaAM+TZIyNiXFODqzgLfgK6NaqNZ3AKzp6HFFPNMqQ4arEvpbAq4RCbTjHR2Oboi+Wl0h6fCjCpDjRiiGgo7h6tAtSI3aHT9rc2uHOKTZXP1xNdC+q/vFq7bi04k6AonhTIqMGTnCWN/tpamn3Ul/jikHp2IdXdiE7PpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(23010399003)(1800799024)(921020)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZndVQ2V0TkRxSTQ0QVpQT0VWN24zUmlIS0YxTmtEeWF5RlhTYnIxV09QZTZx?=
 =?utf-8?B?dUViTGUxay9CUmwvc25DZjRqd2RvbWlQR3RxN2hhVnNZRGhQcE9QRGwwTlFG?=
 =?utf-8?B?YzBqZXEwRStYV2tOK2hBY2JQbHJqdlhiZHJUc1VhSzZwMVpiem5jTytTTWx5?=
 =?utf-8?B?K0E0QXZ5Nmg2ZWYzbXFUVDAvekM3dmpUWlloTEpOMlNnRlZ0V0FvMjkxOGJz?=
 =?utf-8?B?VjhZUzBLTk0rQ2FtZjBmVEV6WGVRekJJTEhmaGYrT0lUOEZ5blh5WHZLZStS?=
 =?utf-8?B?aDhPaDh2VkM2bmY4VU9CNDNGLzBCVTlmaXZQd2hsUUdjV1RvdTR0eFc2ZUF4?=
 =?utf-8?B?WC9RUDhENk5FZEppdEhMN3ZSZTBTZmc3WTBERWcwKzQxbWpJd2ZTT0g0eWVN?=
 =?utf-8?B?V0IrMHI4NGtyWkdLM0dOYk9rN21oNVIwTmhYT1dHYW5WdlI2dXZLZ3JqU0pT?=
 =?utf-8?B?bTJFaUZ4K1FxNEtOWTZ5aUhYdS9saTNkQlo4YXNsZlpjRnkvOWVnbU9tVE1q?=
 =?utf-8?B?SXNYTnNaai96UWh6RjRBeXJqR1VHcFUwclQ3aTlhMzZ4S1JyQmpTVlFLMUd6?=
 =?utf-8?B?ZUpJWHZpVHg4OXhOQUFOS2IxUTYzdk82V2Y0TG9sOTFKa2NZVTdGMlcrbG14?=
 =?utf-8?B?RG1xYjJTQUhmelBzMHVzRTJlNUN6SUIvWjNOb1NTVzFIOHBoQzNsOFEvRFg2?=
 =?utf-8?B?MDNDZHNUUERmK1NQa2FRbzFaeGdJbDVGOUNjNzcwQ1JCcEdXT3BRaExZQ25y?=
 =?utf-8?B?dHBXTFRycFRyR0hsRXE4cEtXYzVDMFo2VHNWcG9Jd2lTQWRyNjFuVTUvdFVV?=
 =?utf-8?B?TkZUV3NBS3YrNk41bTBKYmJrYm51b0VMVU8rUnZaREM0RDJvU1ZOYWY4dVpn?=
 =?utf-8?B?alFJbzlEcUFLV2VGU1VCNWtRa1Ezano3SERZZVdFSW9rVlA3bElGTy8xWEd2?=
 =?utf-8?B?Tks5TENac2JhSXlDenNOR2h3R3VtU2RtcWd2V3pZMUtuaHFWS0ZsUTBUTDZl?=
 =?utf-8?B?bytLenUzVkhZd2pPbWFDVXVhdGxHOGs2KzY1eWx6Ym5PR1ZITlFYQzNjT2pO?=
 =?utf-8?B?VzdYMWE2ZnlLajd4UUgrSUxTRUplVzdkOUJpRldVSGkyQUVtRXdkeTZ4MTVs?=
 =?utf-8?B?TWVua2xQRzdkTTRmZ3V0ODFrQ2lzOGU2WkJnUEpEMlc3ZFk0YXhWNytxdTVP?=
 =?utf-8?B?dks0U2RaSkRVRlJvVlczb0lrSlo3VC83TEFFa1hHT0NaUks2S2NTcjMvNVdW?=
 =?utf-8?B?S2tKZjV6WFVWZ3FVdEcvMzRLOTY2VEtwRkMzMDRod3REVjBOMlFSa1B5WU1N?=
 =?utf-8?B?dTdoOUNURDNyY2g3YXA4eDV2RTVxQWo0SjFjbzEyZnRHSy9Zb0krRDIrQWFE?=
 =?utf-8?B?UU5lbnFzc0tGc2NlT2o0bWNYYWo4TlBycm1qcEZabVNXdUxZYmh5T3BYaWtW?=
 =?utf-8?B?MnVtVURCa2hReW84V0pzOVNaQ3NGSFhMRnVyZXd2M3pqSUQ1UGZJWURLckpw?=
 =?utf-8?B?SzNwWVRGd09Ic1pzYy9JRGZwcGVGZTdWcUozNHpMbG92OUhHYzRZODF2eUFH?=
 =?utf-8?B?OTFsNlZabjhFbWc2Y0VTd0FISTdmSm14TmhrTkp1OEJXdzZvU3N3WFIxckla?=
 =?utf-8?B?Y0tFWU53cGozdExZbjFOOFZlRGg2NW1neGN4WkpTMzlDSkhnUWJpc2tXeThH?=
 =?utf-8?B?SmdRNytxcTdJNlcwcFBxa1ZxZGxDaXJuQkIxdmxSdHhEK2JlQzFpNnVaV2l6?=
 =?utf-8?B?a0FQUnBuZDgzaWlkaUlMbU9VbkR6Y3h0Mm5mZ0IvaXpWZTd4MlBXK0pKWUxi?=
 =?utf-8?B?V2VLQWs0WXhncE4vNnhnZ2kxZUdWVzFiK3VSYnJvL0VkVnFKODdnRVhRWHNx?=
 =?utf-8?B?bkplQ2syT1FUMUhkVlYzR3pFVHlzc0lsbjBJQkhiUkluTjM2eTh0S29BT3dZ?=
 =?utf-8?B?eDBvWlg5MjFzQnNWWE9KRklWV1pld3FiTitLTXRkVDhSeUJySVE3VHVDa0lR?=
 =?utf-8?B?QnpsajZ6ZEUwbzdXTE9mcnZ3N2xBQWVLaDhHbUVUdVE5UUZHM28vM21vVlhJ?=
 =?utf-8?B?WjV3MnE5S0sxUDRsODdvNGVpSDdqOUs4NldPYjQ0ZmlnMEk3UXVTZUtyalI5?=
 =?utf-8?B?eWV3TjhyZWJHMHJTOEY1Wm1JTkZQMXlTRmVuQU16SXRwWFFKQ3gvRlBaWFZJ?=
 =?utf-8?B?R01wNmx3RnBWR0hQa3FNUHgxOWtCL3diMGlrVW5VcXhOOTRDdzZYYzNwL1ht?=
 =?utf-8?B?U3FjeDR6NTdCdk1qM0p1N3FlSEtOaFlNU2JWT00zUzl5dE5qZzBTWkNQcS90?=
 =?utf-8?B?YjllT21YN1Q4dVJUdE9HeTZFenFNZGZGQnl4cUxpTHVEazczMEZtUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b63575-d9c2-4c45-8a25-08ded04c15c2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:50:33.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMy3TGT4OLdZ2ZqDJ7j5Ia+aJdWiC9rTwWmbtrVxtzmsobL6WyWtDZuOiILydTfEPNWNyeMTbv2757cDdwBBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2191

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

Also, FWIW I think this should not put this in the crate root. Perhaps crea=
te a
modules.rs?

Best,
Gary

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


