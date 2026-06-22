Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3D3B0ACC;
	Mon, 22 Jun 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133608; cv=fail; b=pgfHNzCpjifb2wKlabfMZ06zNdXDmIu46Tdr1QiHLfAxISLyXoSl57kBPKTsBvFKyp7doCwv6BIMSaQnmtriSlO+jxZyf3CX5t5VJQvccaqe0WzKgSTapgxvMYTFGVN+KM2RDyXYkpnh409Pody8pJahPezBZ+8XjbY4IxpeCW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133608; c=relaxed/simple;
	bh=5wWt9mfjahCCifvbCQLQxPtVtqr2MBjjvVOqoHjoHf8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=UT9irMBNZ4N101q3RMQjdAm49olksymQBQiiq14gIfXoh4ZV2Z0tFyBf18HxvHxtcZgxPGx5yoS1mEG9dwslcU+u3UCXIWbCwSfYHsa2GhP8psvSfMZalS1BFOWH7AI3LdbO7tqgBOQy1ZB4OWJLnr6d7V2bhrr4yVUn9iDdOCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SQIuzWJF; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SQIuzWJF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2Iso6TXH5Kbb7a0rlV+EaX/kceoPEbw5CAOutcy0jl4ooeMNlu7XVyRelj+T5dhFukTkV3u91mZByKmVMQfmWngm7Hvu7u2sCxh+iCan55DyqRds4obwNmqnawIR5IboYhkAVhFuPoDd6IAuAMBZ3GaArhA+CwhWiJkgx3OdScX511ZJ4Pr2WBIzpTKtjE+iU/RfqwKzDYQn7MzrJsCxEEi3IE8dqsiogFk5oJCkm5dn+GTy+QJP6ekRuCEPjm1C5SC2aeoHV602fQZZ5bJiD9ocBt6Jh/ATl8QGaLGdk7s+nknBIvm6acH7T6PoSKML6mbcSeccImXVOz08KoCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu++/i7hIJGQO7w1AvQv809Pup7gLErt3DZq9eoBD4M=;
 b=glbb8Q7o3qOkEKF5dY1H3QEVXOeU+Yh/ieYLJW7qaYaMzJD+ITJleSBt0kLjiCvoDRrWFOYor9G2cVs3ys1xNssSiiMvi0sXXLYLmQ8pxJzTClFpnKy3ICMvD4KBqJtbsDOZ1GQPTk30kbo51KXEp9N9kxziFJadwFDGT/G5gYDd92RwpkI7GkDnj/LlZXgBQnLKpXGOFpJDjoAhcAOQR85mnMqjhVetQNs2KyebWb3t+kZ4QxILH9uSY7+3Lvf1BTVDdKMzbDtt3kJVaNlu2Y7FJ5rekrZhpUMO6Rxv+o3Q0SwugQX6FoPllJ7kjL+KeN7xBASHe1fHDGtlL+S4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu++/i7hIJGQO7w1AvQv809Pup7gLErt3DZq9eoBD4M=;
 b=SQIuzWJFgna59Ih9MHf67Jb2uNHeWelxovbhusG5Tn7AyoM/qKx95U6JlLEZNs4762KgTCqGerXizRGPAWUMlrM7ZsUqCQl6wumQ0I5gVYAk3X6a4IgZNP1OgVz7g+B/UTjvs0v1iie7eZh8HYtKYtbNN5DpGBCXqPyRaIuO8Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2817.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 13:06:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 13:06:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 14:06:41 +0100
Message-Id: <DJFLMYA0KQ0C.3Q17C8ROX7A03@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
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
 <DJFIQPLOVO4T.1K8T0VZM30LDA@garyguo.net>
 <2d54f3e0-3f35-4f97-b6af-b3ceb1aca246@linux.dev>
In-Reply-To: <2d54f3e0-3f35-4f97-b6af-b3ceb1aca246@linux.dev>
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2817:EE_
X-MS-Office365-Filtering-Correlation-Id: e03166a6-4e4d-4d21-c96a-08ded05f1ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|921020|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+dCmAmMd7QmpZOVyLPam8UB5q1b1CWMSLufB9L1ApVpiaf8ey6e4RpWJqcRndonVweJxPSevsF8YNeC6Gt/7QigN0h9AnGyR2xsvk7LOha86xG2HyqmpX1aGoDOmtkGRjAv+lQuAcghSKYaZvkvRWijkbEbYH0ii8r6CNr7Cjx4sC4JgHp1KVY8RveD9ElZ2jC37t6P9ceiMfNkqrB609o/IImvXtnRBEb/iqcVgaXI67EkZjT+rShlIIxt5Y1XUG2b8C4iB6wLtvaA+SS2DglSJzg0J+57zgUQgdVeKHUgKCEbIdbeV8jxvvAo+VXEVCth6LQJrYywEHlPMnxA7Ly1yzj7t0KqdbIwKN9qc6pBp4vHUVcPyGNOSLYrY2z2pa363ZIoAt1+q2SwFWeaJceqKMuuNbuFY1AOSsjJdn0zHDWxJ58hPb+/OWIEEJizdLsKq+mis8FDzWkRlGETW2f10aaLFdbIUMNMeY62MMGbuKxsqnxPxa8vWxEGc0ZH9c16fQ8H8XxX9vhjO7O2HQi7ClJtwCsT2sMPQWJzcLJh/4c08qNSX5vDIeYUTolrL0LL3aVmclyMw9N+7pcIWLvHZtjXCfBweJErZibfzIIzWySbAVRF/uFBReTF+ucPQnM7dPQetsDA1FZOrA4sTMiDGnRtwy3mUdVR9vaiNuaDeREJcINJgdb1te6+HptNz0sHRwFW2lW2akgzs3UGpqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVhaRjluYzZ4cTcxNkZNMUNCczZmM2F2cjNFeTZ0RmwyOFJwYmtjWmo2Nkwz?=
 =?utf-8?B?Z0N5amgramJCQWpCYnNOMkVxS2FRUTBYcng3RVVhakYvSHovMW1YQlowSXZi?=
 =?utf-8?B?Y1RXaU9RSWE0aUtqK2hUenpBR3BpQVc4bjJFRmJOMjNpMy9MUzVtUzgwNk9o?=
 =?utf-8?B?RXMvQm9UR3VGOXplWUdQNCt3cDA2TGFmVkFOZGVzdnJFRy96R08xY3JoaDln?=
 =?utf-8?B?U0lhcGNHTUJHUGtyZ1NRaE5Bek1uSVBBMEFuMjF0OGkwbmg4UHBPUjJsOTUz?=
 =?utf-8?B?VkdsR3QybDAvSDBGSjZXK2IwZlFzZFgrSHU4K2hBclNLL3Q3c2pJOHhrZXRD?=
 =?utf-8?B?R3JYRGVVeVU0eFFZajhFQWhRYm9tOHBLb1B3NGpEbmo5dVhMNDJrcGdHQ1lZ?=
 =?utf-8?B?NEFmZjJPMmJqb0E4YklYbVp1T3BwVmg1aHcybFFGVzZwcTFCVGpWR2JBNVIz?=
 =?utf-8?B?TURBWFlzd0diMjgzeTRkbm9DWEpUaWEzOWVISXJ1a3lWSmlwTlB4ZER5NVd0?=
 =?utf-8?B?MnRSdmZrVGFxVjJGNW4vQ3RJRUpVZkVnM05udXg1Z1RFRlVFNFc2bkZSL0tj?=
 =?utf-8?B?ODdVWlZnbEpHMS9IY0Rua0h3aHB6dFNXRTJvQWR6SmU1ZlUvbytpbjJ2VVc5?=
 =?utf-8?B?bzIyeFZ0alBWemdDT2prZGVGTy9ZMEdLZTZ4YS85K1RvZUJuaXNUcjBqQnlO?=
 =?utf-8?B?QkdZbXgzUW92UjVPcy9ITHNTT3BwU1diZTFVVy9lcWl2a1hJeWVtRkJZODkz?=
 =?utf-8?B?TXkzK3hHT3Rwdmh2SnJmVDlyTHp6VWJ6UUY2L1haMDdnNmtVaWhkb2VuNE82?=
 =?utf-8?B?aVczVUE3RHNlZWFtSU1SSkx4UnVXOWl0MUFXYk5wM1U2eE9pVUtYMU4xUXBu?=
 =?utf-8?B?Mkl6TklXb1NINHRXSGlNbEkxVzhUaXExaGxsbEdYZVRWazJxM3N5ckNCaGxU?=
 =?utf-8?B?bTl0N1ZuVW9LVTlkMktlR2Y1cGk1dmRMc3RRakJaamNjdU90cmlsYnVBRGNN?=
 =?utf-8?B?ajJtWEluUlFUNCtnQ1F5YTNiREd3ZWk0UFgrczIvb2N4WEIzUWxEQnQrZVB1?=
 =?utf-8?B?dk9jbEllVmprL2JwRmdZWUJCeHVGaERuWUgrTFhsNkJIS1hmWGpIZk5rUlJv?=
 =?utf-8?B?NHUvWHZtSDkwWm51VWhZVGdWNXIxR3lLQTBWcmJSN3JSbGxVWEQ5WlV6MG8r?=
 =?utf-8?B?YUEreXBJM1lDMStlcGFlSzEreG1VYkpMMWFHT2t5UWRIZlhDcUJ6N3V1S1FD?=
 =?utf-8?B?ZkVQM1YwRmtneTk4R3FLeWRWYmZsYm1WZi83djJTWmgxekZhU1ZoVWRqdWI5?=
 =?utf-8?B?WDluTW5xMWUyM1JUdWR1S1h6L0pKOEFhYWNKUkU5eG9lemhLNDZnUy9MbWNF?=
 =?utf-8?B?RWNMeWJLWERBR2JpbUZtTGdLTmx0MzE0REhJNkFKVEpHWGF4cWUzZ3pmRW8z?=
 =?utf-8?B?clBxVzFuMm45LzdKZzl2VUJrL0xvN3hrQ3hTbmNMTEdVWkFGQWJNOVVScG9q?=
 =?utf-8?B?N3ArZnRvako1T1QwTVNHdWN1YWNZUVBpUVFqUXMwMml2Tkd6azJibTBUTWtO?=
 =?utf-8?B?QUp4QjhINjJuK3YxTDN1NFpBYTVsajZ5ZGdRQVJLcmk1V3dqbU95NE1mYXVH?=
 =?utf-8?B?NW1xdjdoNVl3dnRVeHhBMTloQWV5NmVMUEdKODRJRW5rWkRsanowSUpSOGJE?=
 =?utf-8?B?TDIvWngrbk5IVlhRQVBUcTNpNXRmTURrMFcwSnpuYkQzR2VvQUFrUGwzVjNC?=
 =?utf-8?B?L1l6bDdXb2J2TjBwU3ZLRVE1QUlYY1ROQ1dKQmNveTh1QkN3Mi8rLytlVHFy?=
 =?utf-8?B?NmEwSElmV1BKK1JrK1NtemtSbndlZ3c3VW5Jb1dXZFZwd3k3bGRZY0hWRTRD?=
 =?utf-8?B?c1RKbGhBVjZPRmNteVZBUGJEYU50WnpZWmlVcE9lakhwcGhMYW9VN21YcDhW?=
 =?utf-8?B?Z3JIYmk5UWJ1QTZFa2Qya1ZQRmVPQ1N3YmFzZGQwMUxaY2ltQ0t2S01uamho?=
 =?utf-8?B?Wmlrcng5RzhZa1orci9zNlE0UmZNaTh5L3ZaNEF6ZHhZTm80TzluQ2lndVlZ?=
 =?utf-8?B?VGpGcVBzbFdweVBIQmRwS0FxcVYyZjltZndwYmE1TjBMeXl0WHJ6Y2c3Q21Y?=
 =?utf-8?B?dEZWajU4bG5IYmNLQVRHSkdCWmhXemY5emhPb2lseDFVVmJtRnhzRC9kTnZi?=
 =?utf-8?B?TG1jWTZCK2VpYnZHa1RYaHNicDAwVHptbW1adlN0OW8xUEZtaWdxNWVlbmdU?=
 =?utf-8?B?U1A1SEl6eUllRko1akdoMkR3ZmFXNW1KU09KT0dpd3ZQRFJjUUJrbHRFQStK?=
 =?utf-8?B?TUx3TThkODFsb0ZZeWVZNUN1T3NrYU01QVY5UnZLYnRPUksrOVZQQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e03166a6-4e4d-4d21-c96a-08ded05f1ab0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:06:42.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbMZ++lxCIcYurXOVwjJblF4gwoSGEFSnuNUoP1JehnpwTGL4ijF/DiS6q3byEWROrZhvfheZ6EjQcKApM1s/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2817

On Mon Jun 22, 2026 at 1:52 PM BST, Alvin Sun wrote:
>
> On 6/22/26 18:50, Gary Guo wrote:
>> On Mon Jun 22, 2026 at 3:44 AM BST, Alvin Sun wrote:
>>> Since `const_refs_to_static` has been stable as of the MSRV bump, a
>>> `ThisModule` pointer can now be used in const contexts.
>>>
>>> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
>>> can provide their `ThisModule` pointer in const contexts such as static
>>> `file_operations`.
>>>
>>> Move the `THIS_MODULE` static from the `module!` macro into the
>>> `ModuleMetadata` impl, add a `this_module()` helper, and update `__init=
`
>>> to use it.
>>>
>>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>>> ---
>>>   rust/kernel/lib.rs    |  8 ++++++++
>>>   rust/macros/module.rs | 34 +++++++++++++++++-----------------
>>>   2 files changed, 25 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>> index b72b2fbe046d6..50f5a7b5f028e 100644
>>> --- a/rust/kernel/lib.rs
>>> +++ b/rust/kernel/lib.rs
>>> @@ -184,6 +184,14 @@ fn init(module: &'static ThisModule) -> impl pin_i=
nit::PinInit<Self, error::Erro
>>>   pub trait ModuleMetadata {
>>>       /// The name of the module as specified in the `module!` macro.
>>>       const NAME: &'static crate::str::CStr;
>>> +
>>> +    /// The module's `THIS_MODULE` pointer.
>>> +    const THIS_MODULE: ThisModule;
>>> +}
>>> +
>>> +/// Returns a reference to the `THIS_MODULE` of the given module type.
>>> +pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
>>> +    &M::THIS_MODULE
>>>   }
>> Also, FWIW I think this should not put this in the crate root. Perhaps c=
reate a
>> modules.rs?
>
> Makes sense. I'll create a new `module.rs` and move the module-related it=
ems
> (`ModuleMetadata`, `ThisModule`, `this_module()`) there, then re-export f=
rom
> `lib.rs`.

Please do not re-export `this_module`. For the other two, I think it's fine=
 to
re-export to avoid tree-wide changes, but please do update users on code th=
at
would route via the Rust tree.

Best,
Gary
