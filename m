Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021115.outbound.protection.outlook.com [52.101.95.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DE35CB8C;
	Wed,  1 Apr 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057223; cv=fail; b=kyIy1dPSgn7eYSUY4f9Gm36hnxocenbnNrMkJe9NDSV04Iobdc6sC8TSb4mhvDTT5Zylmsae4x0gBqd52oGxp71tDqgj9FjK0aNDgFdXhrqntp1iQKdajxDofxUMVboFdQtzDrMIXj2MPoNyckRp7rEOvJujIsz74OMQUu1zl5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057223; c=relaxed/simple;
	bh=Ic17u0xDO+rPPXzmJOWoKCbvFTqQExr0GOD1bN286MU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LbDbmpvugnoawIbSWh5nd1zIjDHQM4XZUVER33Te94g7p3029Gyvq/ZBX0QxaJ9b1+1IYsWhflhIJeWP6XfMiIcTWXVKXO6XHhU1d1/bF6804NX6tobiyXfUHaxfILdT4gCu4+7xVY/OPIkB3sWZlCv/2mWdZrhrWgXfB6LqyKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FYsvhxnn; arc=fail smtp.client-ip=52.101.95.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FYsvhxnn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYi/ttZM5bI9TCo+N0C/HY+vtddRNUPbVQrG8NDQFNNUxSy03SKSMLfRwwTGwcIHgeJsWoaDtSp50fo21e1rDHLQtXArVaUcNW6r68C8f6pHOXVB8Vh+4iOYLrx3udaNmSdfokI68t5aN9B2wupVMPY65o3s3cuZrhbU+NQO1DNx2PdUnVwZAHGKEGMWxyJf2TRH/AS+JOypeUhot1SwC7Ku4bzXpNnvPTneZcso6NECuFPLUJ9UeYU/cr20aT8Z0D62b5SkNC+Ew8tlMs/aWgjuUwOZ4n/uGBiYPHsFETQlJ0sGnbHAGFO2/+ZEQMPXOz1rMi11dCJ9+gq0kCMpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SG4SgTHst3JVz/66fctd4JjpYSHzcf9xgWFqCXhZWg=;
 b=E2PuLcBfkFr3zoBitxXOa+ROIBbAAEaHi7BL0o+vVK2dmiiOB+q4SBnl69e34rldPZ5OxCAGORFtzs5flaqzNngL0+F3IenayIqBq85da6lyTQ7Erslkmz0UU7QJMQJKKveegawJ0rT5fEd6OuV6xa/0YX+s8gbcZXw1UMbFKzbkGtZvIobSqjWX5nAto4fjmVxvWr82dDLd7yttDMDEByzJve3PoZm/o11Vlwt8RbFSf6FmC6sAur0bM+ayWF/YcUTIxnp6nHckEk6Iv/5OCAlzM0L8v+AGGbjmJqkNFH+fZiQjlc3zKDuSpuGpG3dVif9Y8hG+By0DmXqKgB4BWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SG4SgTHst3JVz/66fctd4JjpYSHzcf9xgWFqCXhZWg=;
 b=FYsvhxnnHbS7Nnu2L8TRcVXemtiNMXplZrYuTG2jTehPnvXUyxjqSPCh22Z2UUjtkZqpqiAqbjUmZaHa3ySFLCdbljNtbCqF3ggYjfYVxoUVpnMFpnevD+5HDl34zzbvsQvZpBE3aj/hHBXv0KPArom4vX4r4qr8GuyT0v2Bkdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8993.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:26:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 15:26:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 16:26:57 +0100
Message-Id: <DHHX9O7V06VZ.G0N1CQ7BUKFO@garyguo.net>
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
Subject: Re: [PATCH 32/33] rust: kbuild: support global per-version flags
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
 <20260401114540.30108-33-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-33-ojeda@kernel.org>
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc1ba07-80d5-4c25-0374-08de90031d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DF2UNII4ZFi/RgCxQhYQ+gwwh/1PW/w53wzlIWcI+N2yxr3oJaJptYiazNKgSPFLM+cjA5++QtsLPobEyBTvPhirEjIcA+PH6CuOzbssNTWD3yg5F6DOwq10cQo9K3d5TxtV1Fs/mBMJ4yGRhuyW2jgoyTmw++0xxGACin752T4OUtuoNSAOA7L+viCI+Qmzv6GQHgwZGK8AX4/IG9Tzo69cmd3lvv30jbyEyGMe0to50ZdjZCjTmYhDk0yAEpNRS2W4ZAOa3qIPuooO6xoFZOL2QldM3ccYWJeyU28ttk+egaAyhVXOy/88HbvpBXxADwzGF9nU5Vs7pZU8xNDswp/tQrT3Bt0iEX1hOYfFjzc+ghgnY2mFT+iTvP5og593uYtkjXNnoJlxfpU8Ed+mPEINelOLfCI8QBKVx3GHgEr9EFTSg2C5pSQB8K5yeF9LUhoTNX7j0nhKd89J1XSZMJXT1ZVe5JU74YlwRr5kcm+Z15GlYDlnbB1QeW5BlV9u1YBA5QvfU7pWdDkbdlqrKfpDPlOgNOeiCPn39Y3Vs7PpbQKtEnyDRggReYE1JbLbP9cfDneg70iDA4iKep8/feEx4Eh93taIpFrCkMVKYdj4p6IIKD0LbTJUJR13FhTvKPMx/XByj9OWCZjY1gSuS+/oY0vOHveKZ1QCshqc8aHP4lyXzbghINvHCwe9QdllorVdYbzCh/GMm4pm8ig/gg/y7YEKIvwviEbzGM8H4pE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0R3NjVIeERUb0VmYVZFcDRyUWtBL0w3bndKZnJsaWw2NXcwaHJZWU5wZDNp?=
 =?utf-8?B?QitZbTBPeGhoOWRaYnpwMmNsOEpnWVZzL29nc1lRYkMydmduYm9KZzdwK0gy?=
 =?utf-8?B?RktnTnlacFJQY2w4eHl5djFhYUVqUnBtN1d5NFh6eEI3dU05alZYY2RiajVU?=
 =?utf-8?B?eFgxeE16WjdzbGZpdjFOWEwybzgxYVJZVGF6RDZkZXZWeEhndGFqWG1CSThv?=
 =?utf-8?B?bHA5T3BjVVB4dlJVd0hJYnU2MlExZ1NGd2MzcmZ6OXg2d09OOFI1SkNYd1N2?=
 =?utf-8?B?bFcvVmRRYkFDZ0VoTmJJclU3c2pvb2p0RW01VjU3ZEgwRnltRG9YODljMmRt?=
 =?utf-8?B?NXZMenZOT3A1Rm5pOGFsa2lJM2krTmtBbjZiYk9BcXFGNm12eTdBaUZ5U1FG?=
 =?utf-8?B?ZVQxZFo2Z2owbzNObS9Nbkt6V20yamtGMUFFMUZPWXluNmZtbVJIczhnaWJw?=
 =?utf-8?B?M3JvVllFVlNIQW8rYTFLOTFaZTB2ejhPTFJta2lISlhvMytJS2hHRDRhY0JG?=
 =?utf-8?B?TjI0Ykd0dWpPVzA5QzRYZGk2ZitxTk8vNEJybXJETGZreTcxaDAyNHNLM3Nr?=
 =?utf-8?B?RVl3UTNCdWEzbHZ2cElnK2ZPZ2lTNDVGa21MOFo3Q2NGa0dHZXQ5ajQxSmRJ?=
 =?utf-8?B?QWgzMG9yMHlnVFdoOVBqRGVIbW9kNVNJdEhDa0I4ZE1FazRvVmRydXp4VFJB?=
 =?utf-8?B?MFdJTUp0TzdZTFMzS2JHdEUxcCtSVGlaNkR2WVdwcEZUcmpzZHh6cUNXcjJM?=
 =?utf-8?B?Q1BjUkE3MkorVU1CU3laTkloTDFvaC9vS3AxK2Nyd2wzOHdKVVQwSGRxZTV3?=
 =?utf-8?B?QmEwODdzNXJBMGlLcTZhNjNkdDNmRzV3S241WE5HRlljdGNySDVTdEU2RE9o?=
 =?utf-8?B?eDNMWDEwQkpwQUJKMVRkYmZuR2NGSTd0WS9RZWV3bkF3RVV6S3NVRTF3WWhY?=
 =?utf-8?B?ekJtN2djOEhnQk9ZcTQzcFpXaGkwZVp1RllEZEliZXQ4Wk9rb3NQYzJNNDVh?=
 =?utf-8?B?RlNaUlAzQ2lTbGlsVE1Na2ZzOGJsTDI0bnRYenRNcDFOSFo2MlQyREgzd0VQ?=
 =?utf-8?B?TFl4SDVGK3FHSFF3UG0wVC9STmo4WFlFSThGUzBwR3AzVzNaRDlmYmVQaEZH?=
 =?utf-8?B?a2kzSkNEY25ESWxQU09RazMzbGpNQnpFVW0vOG1BV3NwUnNMN3FnbGNCT0Rq?=
 =?utf-8?B?NHlxQys2WHZzRm9pTlc3QWk3NjR4c3A3bXROdlpFNjJXdTBvSWg0TE5iZUZM?=
 =?utf-8?B?RWNMcUsvMlNXWG9wU2Q2ZXIwUG52WjFLS016bkxCWDI0NHkvRlJsdDhiWVVB?=
 =?utf-8?B?cmxPTythVUNoTUUzaUh3WjdaQlpPQUVhMEhFbjQ5OUpCUE1WRkxnZG1FL1Iy?=
 =?utf-8?B?RldzaEtGYkJ0aDFsblFIL2RUbnhpcjRsM1lmKzB0K2k2YzJ5YTI4UFlETTJh?=
 =?utf-8?B?dzRMWk40VXVDaCtIZmV5dVJTWloxU09IR1J1Rk5Fd29INys5QVdFdld1ZUZR?=
 =?utf-8?B?bElEdHkwZzMybEd1NjU0VkZVTm5aS2E2MHI0MVRzSDVRMnNvOFpzdEVYSTdM?=
 =?utf-8?B?OS8yNGsvcDJXcDBkckloZEpqMmFKckZrRHZhbjQ4UTNFMm9KZi9tQWhaTGJs?=
 =?utf-8?B?dkliWnRmeXhzZDRoaHF3SzRtTDZDTDNQM1N4UjFCTE9JM3FBL3NaTEh5Rzcy?=
 =?utf-8?B?cGdZNWEzMkc5b3ZSNjMxV3paYnJhNzNkY1ZlN1JHcE5OYWt1Z3l3aXpqNzhJ?=
 =?utf-8?B?TS9CUXVGWWIzeUtvZzVjaHh0NlgrNDRoWGc5RHdPRHFZK05NWnpWQUpoa3k5?=
 =?utf-8?B?ZG03MHNXNjZKdXpJVmZOTkpsM0ladFVwYjFzb3h5ajlOUDY3ZmI5VFZtdzlz?=
 =?utf-8?B?clVaeVN5NVZ2emQrdm81QUtqQTRnOWJ3VUs3Y2liUXVZdzNCOXNkb2Rmbjlr?=
 =?utf-8?B?VElHYlhZYWEzUFY3LzBSd0pPZmZWVXh6MkJEdzk1aHJFWUs3ckI1L2Q3YXUx?=
 =?utf-8?B?VVFTVUp4bzdSWDVSQTdSZmY0RHFtVTFycWRmTHFQUm1CNUVkdTJseGhialNG?=
 =?utf-8?B?cjE0RFhUaEZiV2tuOE1QMFZ4WEF0aWVxOTBHd2IzcVZPWjFFTy9WRmN5M0NU?=
 =?utf-8?B?VjdJbTdNM2ttNE1vRFRUSzdCTzVYRVdBUDVGbUZqaWI2RlcxUXg1NHlHU3hZ?=
 =?utf-8?B?YVlmUm9RdjlPaGtVRUZDTzNoTExSQ2ZIL3ZkR1lRVnl2NC9pbUZZMkd5UGI4?=
 =?utf-8?B?MWdRNFhMV0lmdFdVa0dWQ2cxbVZ6ZEEvZ1BHN00wOUw0ZWdLN0ZUYTAveTRH?=
 =?utf-8?B?dFI4UG0xQVlQNFBzK0FIRkdDODFQR2VIN1ZOdW5WeHRRZ0dyTU00Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc1ba07-80d5-4c25-0374-08de90031d2a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:26:58.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InTfKgZ+3iBRhBf6RHR41UCwL6BeLK2zKjj2QmTbfuUyeD9uNi6ibJFAK8hUj1ftRFzmPYvvfDUpFJ4s+qhOfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8993

On Wed Apr 1, 2026 at 12:45 PM BST, Miguel Ojeda wrote:
> Sometimes it is useful to gate global Rust flags per compiler version.
> For instance, we may want to disable a lint that has false positives in
> a single version [1].
>
> We already had helpers like `rustc-min-version` for that, which we use
> elsewhere, but we cannot currently use them for `rust_common_flags`,
> which contains the global flags for all Rust code (kernel and host),
> because `rustc-min-version` depends on `CONFIG_RUSTC_VERSION`, which
> does not exist when `rust_common_flags` is defined.
>
> Thus, to support that, introduce `rust_common_flags_per_version`,
> defined after the `include/config/auto.conf` inclusion (where
> `CONFIG_RUSTC_VERSION` becomes available), and append it to
> `rust_common_flags`, `KBUILD_HOSTRUSTFLAGS` and `KBUILD_RUSTFLAGS`.
>
> An alternative is moving all those three down, but that would mean
> separating them from the other `KBUILD_*` variables.

I think I would prefer moving these down.

The current approach append the flags to all variables, which will cause th=
e
following equivalence to stop holding after the flag update.

KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
			-Zallow-features=3D $(HOSTRUSTFLAGS)

(Per version flags doesn't go before -O anymore, it comes after HOSTRUSTFLA=
GS).

Best,
Gary

>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72mWdFU11GcCZRchzhy0Gi1=
QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com/ [1]
> Link: https://patch.msgid.link/20260307170929.153892-1-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 1a219bf1c771..20c8179d96ee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -834,6 +834,14 @@ endif # CONFIG_TRACEPOINTS
> =20
>  export WARN_ON_UNUSED_TRACEPOINTS
> =20
> +# Per-version Rust flags. These are like `rust_common_flags`, but may
> +# depend on the Rust compiler version (e.g. using `rustc-min-version`).
> +rust_common_flags_per_version :=3D
> +
> +rust_common_flags +=3D $(rust_common_flags_per_version)
> +KBUILD_HOSTRUSTFLAGS +=3D $(rust_common_flags_per_version)
> +KBUILD_RUSTFLAGS +=3D $(rust_common_flags_per_version)
> +
>  include $(srctree)/arch/$(SRCARCH)/Makefile
> =20
>  ifdef need-config

