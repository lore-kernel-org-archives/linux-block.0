Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022102.outbound.protection.outlook.com [52.101.101.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61A3019DC;
	Tue, 23 Jun 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222405; cv=fail; b=HE1aDpMO9Rxu73LUhKq20S21vCG3bdzuJp7Rz73YFtKcyMabnnVjIqWhLKPYueA4dwsAdLRK6GTEyHBLOe/nZrsctsnYZYswif44TYFm6eFDN+JfiQR9EDaqhkLiwknzYw1hpyfEiuIOJDQixTHvJ3ARxcPY58SszHmroVSl2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222405; c=relaxed/simple;
	bh=fcwYrXTybjuFg8TZ6MfvjptjhGvwO+JRouzdrYkBids=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ntXxzvmvkMcP4/WR1ClWDAgdBsA6jLJvEP9q+w4EY9zYbWdBZ+UKEc0g0zHFiH3Z9od8INmYkm25Gxfvid+JVLncmePOZmmOPsVrXdAHjo6I3H57RpMi2jrEj0v0ELuMVmcw8WU0GnazluBWmyLLbBXpHn9AZLwBsg8ZWjv/F0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yfKUBjTs; arc=fail smtp.client-ip=52.101.101.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="yfKUBjTs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+xXubxc/8RwIe02CW5G87YEK08Vlu65ZeVZErA7jtQdHG9/1xVlLM8aGpvuH8ocfdMyTsCyKN+PV1NgX5LHNm/QjRh9l9d1SwmNIGYqik08PpFuU1S3h/i5KW7fBPYmky1GkHFJLIiUUpr2iAxZ2qh2yKxmN65O9n5HUlyeRSGv7Dkr+GdB93+iNeHfRjXgPpS06qL2JYrMcu8Cuj6EtjKnHo+cqeQLBgmSPmrambdd7BLLR333adeOprUM+zv/DM02HVinm/GOjOAWeqA1eQp8v7GMXnkCYkUv8JiE2Pn7/SIrbseA1g/Z6TWUFEURkASRa6Ir2qoEZ9DS/FHe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of3V1fnBLCjELv6C5T7stW+8hZna8YMGhyhRSqEjHfM=;
 b=lvf1sL7FzjRygvKoH2y28/kDRnPfeOtQlJDvMoSZABvDa3HxQOcQHQkGl6Qh2UpT3vxrt9sHvOlqZkB3r8GVTLUBa5Ky2c46B8TVS0h7Ma03uvr+jRN93qMSaezQjEFMtbFc455V5Z39fkzJQ/+APRPAR24j4NRdYmDdJQq6wxb6gQ9Pv468Yhosini+41yo35f/aKAAt+QrxZ0kouu4Av4rOXHsy7xJjIkVJEpOyJ+8oUm0BrfEOClDbsDMqVtKHXlv9oD2qjHe3cCF3zbZ6NFbgYX3i9NWn+ZO2/yG6jiS5O2MjPkqQQBp1i1tMXh8x/WJ3d4pHs9DEGdTNXO4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of3V1fnBLCjELv6C5T7stW+8hZna8YMGhyhRSqEjHfM=;
 b=yfKUBjTsaqBZ+HSlK+8a7G4kkQM3uqmQTecZNMcc9ZyXg/W2plNM0PEO37j4zpv8ijZZ6Oz6SmXe4NNqSqk0D/zIBuzCxTBlTUTnQaL3qmQdkvweF1TnUrHnI1jZdd3t5iJpb4zJvYYULXCnj/lT4t/U4CX/6+ffZpwEVt8zXiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5377.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 13:46:38 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:46:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:46:36 +0100
Message-Id: <DJGH42AQ8KFZ.38MSQG8ATUFA8@garyguo.net>
Subject: Re: [PATCH v4 2/9] rust: module: add `THIS_MODULE` const to
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
X-Mailer: aerc 0.21.0
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-2-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-2-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO4P123CA0498.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a499379-def1-41c4-f7cc-08ded12dd8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|376014|7416014|366016|921020|56012099006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	nX0eeXPfjEIW8mbDBJ1Cx6SxDSedG7Xwtp+66dWOi83WsFDljec1y4p4WT5rIcJTT5uXtSUdmo+AHvNNx/p3GL2NWJyQZ4LX20N1RDzPriz+wu6qCHRAKP7xDcgZo69+Mjx5rKTHmqecpad6yDQYyOqoFvkK84NeP47QdS2pn1o6IN0PATdqHkk2dsH0fx/z7jcaTHrXoSatb/aM39DEmyYktlEzCAOuk1RvOWH3JaxdwoybyYaYzM5CHbSLu4ENN9I9JbqnZX//njMfeHKVAul/pFlBAh6sKLpQeoG6jwOGvUywCV+VfDFmRCY/qJMRw9G81kw2sV5FJ6JOoQWQO9Ou3YOqRR7SAAkHDaPtRVN7aesjFbSoG9aLxcSAMbDSNRDtzvqh4YE6P3/w34PahhecJXgk+EhlRl+rSYEucN0XlIl8kxwdnCDtHljFI8gJ3Qe/ILY5toNG1AhqmLNLzpKJW43pJY5xjbGky0QEFqa462I2ZfULlZxsaZ+CirEM1j2w38YkKrnk3k7ZMMK5++cUAkMgA0VGNvvlSDA/3q/Ee0hT11otBb/7Z/U8Y2fWH7sbX8XQsB4F3hFsjXYaHiNwUoYAOINzGIG4x189gwAhjDLKvI56nuNSwZmRagJFoOPCgusmRw6rVDnaG+NSIDzjM7HU0ZzdxLXNnQdpG5Sp9yTPo2eiZPvgMFNZ1X43woo+FAXEc6+hOSpIYXEYLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(7416014)(366016)(921020)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGJoc3pLYXFRNjZxSHA0UlVBOGNaUWdWNktvY3Fvd2VjLzhDMUtRUjNqNllP?=
 =?utf-8?B?TnQvamNYWjNNRWh3T0sxYUxQTUlLMFdOdWZzZ3J4ZS9TeGI5TU9weGkvdlFz?=
 =?utf-8?B?UGdJRjZ3V1F0aXJUeU94QUVRbUF1R2N1ZVZrRzZUWVc4MWU1VE54aU5nV2wz?=
 =?utf-8?B?czdhYUtOUzV2c2ZjaEdpY1FibVZQeUU2eXV4VUcxcVRkaHZNRGk5TmtrWlRI?=
 =?utf-8?B?cjI3Y01tOFcwU05lRDdIR20wUytkSnhvYnM5T1c4ZHFpUUxYZFdhR3h6OUdY?=
 =?utf-8?B?UWdYekh1TzV3elVlcVVndVVXQk94ZmNsNk54TzhOMW1oc3RUT1IwR1hsSDNq?=
 =?utf-8?B?VDRscXNsTThnNWpnS2JUdGRLSWZjNXN6MCt2bFNvTjNyK2NSaXFWRnU4cWhE?=
 =?utf-8?B?d0JYZjMwaEFpeUh6L1M3SnlpdndsckNnYldLMklpaHZyWEVJUlozOXNUK1I0?=
 =?utf-8?B?OFQ1MzNVaUFyK1JmYzhXZUM0eE80TG1XVnBCWkVsQ1BZT21XQ0VaOUY3V0hT?=
 =?utf-8?B?WDhQZnNpTmtiS0pDVDM0b0R0R2xCak4xMDlwckUxSm0yQWRkZkF2ZVB1TEJz?=
 =?utf-8?B?WjBrbzluZDh2OXdqN0VlYXo1d28veHNLa1pwSDhRY0lKVUZSVmtoanJkcnNu?=
 =?utf-8?B?WGdmb1Fmekp3a0k5NWxQTUc2REhRcUpaUGtQL3MrbUF0aTl3bUVsbmw1cGNr?=
 =?utf-8?B?Q2R1akRuOTFpajJyRSsrdjhxbTVCVGQ2dC80dy82c054SmhLdjIzaGEwL3hN?=
 =?utf-8?B?YkJoTzVvS1dmczlISzZXWk5ISXNLVjFPcUp5eGx6VXZhTy93MUNPbEQvNzRy?=
 =?utf-8?B?QityWVRHZE5BMHozV0VYTmRPakVGcGtieFhaTjRQVjZ0R09XTlh2ZVR0UGhm?=
 =?utf-8?B?M1NrN3VaUlk5dU1KMTAyNjgvbHVTUjl4UFJsaWRKY1hwVm52NjBMaVAyRTkw?=
 =?utf-8?B?M2lHdU1WRXV4Mkg1T0ZBOTNaOElPUFg5S1J3cnp2SENYczdVbXZtR1owbFJz?=
 =?utf-8?B?bG41dnZXQWVsQ1FSNm1HTkdhNUxFdGxqNzJPcldHV29Vc3F4MkZhM0dKZkNz?=
 =?utf-8?B?YS9CSEUydHB2bGhzT2s2MWtGNG5zODdNV0ZGN3RKdnREUnFHTjJIbkgwY3dv?=
 =?utf-8?B?Vis4UytKRGQvM0JFUWQ5WDQ5azNhUFJkenlHcW1TUlRHc1kxZGpianVqeVhT?=
 =?utf-8?B?Vlppby9GeE5rK3pYeDNXc3VFZXV1SFVEcUl5U3VlSWtTQlVLQ0xlUllEemJ2?=
 =?utf-8?B?MzhnOW9VeEowYURiMlZrLzhGakg5aDFQV3VpNExxRGhLc0JuaUVXRldBTlBR?=
 =?utf-8?B?V2d2aElDWElFd3hJVitsSVhDTk9YRUZmOVZlNEZkZTVsSnNEYjlSM3hUQUpQ?=
 =?utf-8?B?akFOM3ZrUkRTOGJFbGZnM1dDL1NsK09qTC9aeHNncU9BNHdEQmlyalpDQWtB?=
 =?utf-8?B?YnJYUGJ0UUdBNjFxdmpnTkFDZGJoR1gydzRRMCs4WDZnWm9CencvRnFIcmxJ?=
 =?utf-8?B?RUZURWczaUUwUWc3R0NwQzlCT0pHNThlQ2Y1QWhDZVpvSWJUNGNHZDlwMDk0?=
 =?utf-8?B?R0NPOVpqUlcyN2EwbWVxRlA1VnEzc3hob2dER1lRa1FkYzEvaTB0SlBCd09D?=
 =?utf-8?B?cG5TblAwWVBMeWxHMTlTeVltekxGc205QUFBTXhhZVRFQWRTTTA4d0ZjQzc4?=
 =?utf-8?B?Q0k0RXBiZ0dwRWpHZUFYZUN6YU8yNTF3b3ZVY0xqck9vYWhmTHZTV1BYWito?=
 =?utf-8?B?b25jbloraTQwTVVHeXpwdDZFSnhFWjhyaFE1eEg5eDFDNm1NS3NYa3ZqbWJ1?=
 =?utf-8?B?Q1MzSHJTc3BwaGg5VnA0MW1USkRjMTF1eXVwTWxwWFNpbG9EQUhWellsVkpn?=
 =?utf-8?B?OU1XSXRqTWszTU96KzB0YUxlWk5GSmNLTEsxcEtIS3VCY3d2NkpOUVllS2dx?=
 =?utf-8?B?VHBXdXpqNkhGMGxkRDNmdlp0ZUVpR2hyUmpIcHJJdGxNdUtYNCs3UUplWGk4?=
 =?utf-8?B?aTZBRlgvcWFRQzF3LytPS3Z4RmZmc0p2Tk5ua3lONjRscW50MjRaaExmS0Zi?=
 =?utf-8?B?NHZKa2h6akJndlJROUtoWEdrKzlIVThRTmUvbXVaUlQ0WDJyYjc2UmxLS2U2?=
 =?utf-8?B?dkV2aU80NXBvcG9KTXpyOWdjTDRTa2lPRlZ3RXMyUCtRWkxQOFA1UkNjUnp1?=
 =?utf-8?B?VHB4a0JEMXFIUDlaT1ByRDMwTERzeTF1eTdKa0VHbDhwNzdmM1FsTEMwVFRS?=
 =?utf-8?B?Q2JRb0JoUm1VM1pvOWxjU3RKbGMxSkNUcE00VGZFSU9DRm54Y1dlT1JvUVNO?=
 =?utf-8?B?Vi9EK1NyS1V6TXlvTUxaRmVzOTZHd1N1UnVVaFJ6Z3dHcVdsakJLdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a499379-def1-41c4-f7cc-08ded12dd8e9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:46:37.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9GAthAf1E34d6J/jDUrnNbA8R4mML1KdyiGF+CjqiCed9hpxrTgiAdtJ77IiTlOiho+qyVz6yXJODOeoC59Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5377

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
> Since `const_refs_to_static` has been stable as of the MSRV bump, a
> `ThisModule` pointer can now be used in const contexts.
>
> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
> can provide their `ThisModule` pointer in const contexts such as static
> `file_operations`.
>
> Add a `this_module()` helper to retrieve the `THIS_MODULE` pointer of a
> given module type, and update `__init` to use it instead of the
> `THIS_MODULE` static generated by the `module!` macro.
>
> The `static THIS_MODULE` generated by the `module!` macro is retained
> for backwards compatibility with existing users and removed in a later
> patch once all references have been migrated.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/module.rs |  8 ++++++++
>  rust/macros/module.rs | 18 +++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
> index be242a82e86d2..5aca42f7a33fc 100644
> --- a/rust/kernel/module.rs
> +++ b/rust/kernel/module.rs
> @@ -42,6 +42,14 @@ fn init(module: &'static ThisModule) -> impl pin_init:=
:PinInit<Self, crate::erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The module's `THIS_MODULE` pointer.
> +    const THIS_MODULE: ThisModule;
> +}
> +
> +/// Returns a reference to the `THIS_MODULE` of the given module type.

#[inline]

> +pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
> +    &M::THIS_MODULE
>  }


With the change,

Reviewed-by: Gary Guo <gary@garyguo.net>

> =20
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..aa9a618d5d19e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -519,6 +519,22 @@ pub(crate) fn module(info: ModuleInfo) -> Result<Tok=
enStream> {
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
> @@ -616,7 +632,7 @@ pub extern "C" fn #ident_exit() {
>                  /// This function must only be called once.
>                  unsafe fn __init() -> ::kernel::ffi::c_int {
>                      let initer =3D <super::super::LocalModule as ::kerne=
l::InPlaceModule>::init(
> -                        &super::super::THIS_MODULE
> +                        ::kernel::module::this_module::<super::super::Lo=
calModule>()
>                      );
>                      // SAFETY: No data race, since `__MOD` can only be a=
ccessed by this module
>                      // and there only `__init` and `__exit` access it. T=
hese functions are only


