Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022086.outbound.protection.outlook.com [52.101.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1335470421;
	Tue, 25 Aug 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665032; cv=fail; b=N2BUJzMx5rrBf1CYe4YRrhJpZBzOxRhsMc38f3Ejg+jU33ajoti8jZ3hEjAbl+l4ygyGflFmcwUCbFiYTRGGTuBis8ku3TRYWbniLr0+UeM7BoEYqHOepdbGI0Xol5JlFKebrvJfb9sUsPpL3/R+GSe97uNoV5gfTV8mXx4hGG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665032; c=relaxed/simple;
	bh=Zy+OOeDq3ZYpZkQ98k7kLPeUBp8dalKmgW1we7zpO7Y=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=umBe4VOMsa0VsXh6HV6Wi0HzPH5n8YsylIpxz1LtN6CpLOnaC5R13+FYoUN0vOU3U+beS1qSts3c2xAStlNLrZ/ljpD9PJpIZGn5csCQYX2EjvXSjtfbg0RCEEOUtSZe8Ny+tDTwOWPUs1IyqYw61ihXcLjcP9+rUhuCjtOVCLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uz8eUJa+; arc=fail smtp.client-ip=52.101.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uz8eUJa+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soPK5Hzeh1Ma2hiY3VvNvVd65OXdpJG9p0x9/kryqMmqLV8keCsb6ujUQ8BdHsMlIjPMU/OT0LczFuEOD0i52V6NihZ8OEYsCNKTVTWSQdJEIdzuuRZouuwboyVWNfl4Vp06W/TAZfEuq5C/hjeyr6UtlY05eiQae+hjLwMbyjR/vrUHYthdLLDbinY1/h06c8qIfVeHZBFPPBXu86H/5rg7dlJsYVswPuMZI5EF+r15oX8v0qq8GAK0kVKh7gNiuZdWTLYFGk8u4+S789KB+dU6gfC8BcuWQCi0PovsFQgc794BjLs/N8S72NY6ZxnAghByVGFXkXV32TuRSh8izQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya9oRL8hQP+2VLtBxg6F1Mzaryv1xrYEgcVxsJjZcJ8=;
 b=Ukpy0hvJt/zFRT7icrDACplAs+vmDny/IoIE09uGM0I/G89/fXluOcirb/IiyDhkUOJzb0+W1spGLB4zt82ircFJZL8rDZ+Egjn6B+QC7Q07o/8ROyxs0QEObWaDMKo1vScA/nthmfic1NhPxSOD1t8YG+ELk7EZQC54fJ9jtmv7dtAdkQ/P3wSFNc+YEMq/f0W0UgoWORw64xL8Ut/ThQKH8yVGPFnR4xF7WUjp06XZHBohfbNxGkctT1vOr3eIGM3DmfYl9q+J61fo/zr6grfo+3mvrFkW7Ox8lJop8mj40ZvV/w5x3nYxrAXG4nRMSXHFGvMCEMdOvLEI2w4iTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya9oRL8hQP+2VLtBxg6F1Mzaryv1xrYEgcVxsJjZcJ8=;
 b=uz8eUJa+6rfo6qLAawCaUbE6dE3IhmFU1x7osIlmNjCzo+EC9qU1wV2n5ALAwfHLh/+qM/L3seqLbbMM/0SAyFjIvAkJrk8q/XoXLlkK9QXSGN0COVVFP1dc7EnP6NSjFKk2rSRuNOPT8a4S1IEv2ab5kvGbgJxP1iDOJtdubsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2929.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:37:06 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:37:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 14:37:05 +0100
Message-Id: <DKY2D3AP6PZG.9RIX8KB3FF7P@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin@linux.dev>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Ira Weiny"
 <iweiny@kernel.org>, "Philipp Stanner" <phasta@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <driver-core@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>, "Oliver Mangold"
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v20 7/8] rust: Add `OwnableRefCounted`
X-Mailer: aerc 0.22.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-7-490735672187@kernel.org>
 <DKY1WYBNR288.36W5V60TR81MG@kernel.org>
In-Reply-To: <DKY1WYBNR288.36W5V60TR81MG@kernel.org>
X-ClientProxiedBy: LO4P123CA0560.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2929:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cd4131-fb3b-4955-65fb-08df02adf49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pI7vH5zk0fwrZi33VGpjVwtMdNELTnTL14q7n2jxhjyNl0rVT1z7TMUWa8wCH4Ki0nlr/kHq3quHHfIGlpluPf+96fZlgn1d7pSznlUUacjYP9H8ZbzPBHwaLBcMrmdp9n5hxMwRa7IvKWt/RbhJ+UxwelLgqIJyad0xNozwtTD9sbxIith8ugiyZOjD80CNlt5xMzXAIR06/iPKo+hd7LcSOuvKA9O276R1CBzui18rHlnTlOUH2PaHOePw5VnfXQwKesJkKF/4d5zjchi5q7qFveq5yVnUzyyVp/kvKHKRIZCb73xn4tuCUYY1k8wYXvy0G9gaOaFMGE4B2vhbNt+HVAz0E2GwK3+1/d3WavLMZZNyYAHWqWOfMmACzj+ONlLWxZcAKwqN22fVFQ7Yiic4Wy2f+nJ3fHRvDEOqHVKeXQJd9HhpQGXJWLTr00sBzPW+0omei7YMDT0uWp9bB3MpxpP0cAqkDv0v+0kf2FQOfLZ3jqpceejh5AdftoM3zbnKg5Iw/W7Q6xhY8waqWcKuQWt5yj2Xzmn+wtucKOpjlkY+Q9l2xP1ddHUgUii1CqBaTCKjpROW0mi2khMffHn7GyuBP9Z1qU12JVhY2p/l4RJU/y3tCLPVezF39PsEk6Or0cfsOsuk6JdRVzPEAMTjkevcZyo7yHZJ5uJ6wuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vi8zVjk3R2ZrTnVvNVFLbG1tOGU3dVNDS1ZqdDVKSkNmdEVmMnZTQXJPYTRC?=
 =?utf-8?B?TmNya3lVekd2WWtWcTJPM1J3THJpMGZYM213U1htQWxuMWNWL0E2eEpHUmFy?=
 =?utf-8?B?VGlXSHQwelNzYitSZUhGaHZic2d4YVl4NW1vTnR5eEY0QXBtc1dEejVkaFNh?=
 =?utf-8?B?Mm5iNi9xK3VxY3E1VTRHQjdDdVdGWGMrdlpCN2s0U210U3Nkc0p2TUxqY2hz?=
 =?utf-8?B?dUd0bkhFbXc4TCtwMXRJVm9IL3Y3T25nWjN2eUJuWEM0cVV3bWtBVHBkL09K?=
 =?utf-8?B?blNUNFB3UTlKVDhtZnNDcEFnd3p5b3BQb1pQeEdiY0R2UldhS0lwOTBVSmhw?=
 =?utf-8?B?eWdkS0ppeDZ1SkZybDhYQW5tRGY5U0FsS2NIL0xHcCtBUGIzTUgrdmZMR3dC?=
 =?utf-8?B?STFzVzgxMnpCSndobjRVZ1J5bC9iWUZZMFlUc0IxMTlyRXdCbmhFYk9Eb0F0?=
 =?utf-8?B?V0E4Yk1QWmdrYmdxUmxmOXJaclVRbzVEd0RYSEtOMDRMNmN6a1VyelJzTG9a?=
 =?utf-8?B?b1oyc0NHRVdvNFlGNU0rVDlEbnlHbmxQb2poRXJIS2RPZGF0Zk84ZmZHZTRp?=
 =?utf-8?B?Q2ovOHB4c3l4UEoramJJK1hSWDlzWXU0SmtoSFQ3SjVCWFJ5dEd4am4zZ0Ni?=
 =?utf-8?B?TzNIeXlZT3NVVWdHdVQ0KzlIdnFXQ2hQWlpVL0VQdkxQMUZjaTV0TnhHZ29D?=
 =?utf-8?B?VS9XSUp2NUJMWjVHV1o3WWw3MU9VOURLaVpaSTQ4OWNvakVZdk51ckN0Vm9n?=
 =?utf-8?B?TjQwVGUzWDQwNzhVWU03bXlqZEJUdkY1NE9tZncvU3hRN0kxa3V3M2EvaXFQ?=
 =?utf-8?B?MHZXY2RZM0FLQzI2K0Z5QzM2eCtsaFIwWDlITkZUcWNtcDc3Qmo2RE5lUEZR?=
 =?utf-8?B?WUtsYWlBZjJNUjlIT1JIWHlvbUF1V3g0L281enQzM2g3bVYxWkNibjFTNEEy?=
 =?utf-8?B?VDY5a2ZwUGRzS3FGTUFhOXB1SmNMMllzMUhxTE1QSHJ6TUQzRkMwYkhhQWRy?=
 =?utf-8?B?dnpqVWRIaDAzMWU0bmZjYnd5dmdtMEpaOTVsY0QwZGFtL01YYnNwVnM0b2l0?=
 =?utf-8?B?RFR4UHBRZDUvVENEQnlPVW1kOEV2VFdVY2hmWlZwMG0rMUZuRFV3dWZpSVpo?=
 =?utf-8?B?dDNLNktBaTMreDUzY1BQdy9FS21VeFR4WHlsWTF5VlFIZ3JFSVArc2d5UWhx?=
 =?utf-8?B?QmJvTW50SDdYTjhhclA5d2tOZ0ZobWtzZ2tBUVNPUG1KRzJOeithQkVqeW9K?=
 =?utf-8?B?Y1p5NmpNcDZGeTFuZ1ptUDdEUWUySkc4L1FheGE5NytXVVZyK1I3UmRFWGdB?=
 =?utf-8?B?MXhzTXNKdml2TUl4M0hGaDZsanBPOUtUTTJRRHJndFVsNUp2U3NKZERuOGlt?=
 =?utf-8?B?RFF3a3FQUGtkbWxucUZFRHZYdTIwZ2w5SXhiOXBQeUJURG5OVFhJd2h5dFNY?=
 =?utf-8?B?WlRXdE13OEM4eEJDMEhZaFByaHdHMWtrRHdoMTJDMjhyTXExZTNmd2VsOE1Q?=
 =?utf-8?B?c200S015TEFxQ2FoNWVRblRVeXpwMjV2WEJlbVlHTndMb2lRVCtMMmlFMFFo?=
 =?utf-8?B?VlVHSWxUc282aVVnZXBJWjZpZTlrYURaRkVXUEJIcE84bjdaQnhyOVNaTDNQ?=
 =?utf-8?B?Vk00V1RpWEtoL3B6ZEorZUl5Z1o3RkNjeDBLQ2ZQYXZPZ1pvWTFudzBDdlFq?=
 =?utf-8?B?QWkyczY1ZS9LcFRXRkR5VlZYWXdnOWJCQjVNOTBjV0ZyV2R2d2RTdWdBdHNS?=
 =?utf-8?B?eWs1U0EwYWFSR0xhbDFUWktBZ2tjZlpRYm12eTZ0eENRTUR0K0hnZEYya0FQ?=
 =?utf-8?B?eUh0K3dDNjlJOTNYRjhnMFZoczI5RDN0ZDUyNEw3TFFGNUsrTENRMW4yNXRp?=
 =?utf-8?B?Z005MTR5OXNOdzZxVll1RkdkNFlkNmExV3FrRTZUU0pTcWhIc210MXhDM1M3?=
 =?utf-8?B?UGdzSnZKWU9ad3M4ZENtSDJub0kxRDFhcVlaM0V2M1Vqcy9zeWVZS0h3NHZL?=
 =?utf-8?B?ckh4YTVZcXBTRWV5TWFnaGRsQVVxbjlUcDkrck1QbnBncXRrUU5NUHJ5bDdt?=
 =?utf-8?B?TG1KM2JYNlUrVUFibzdXU0FzNE8wV1ZacmJPbWVGQmFvOVpKUDZSbFpkTFZK?=
 =?utf-8?B?bGIwVUJSQXRIbWJQWVpCNTIrUnkzUUpYWnlac0hxVGwzcURJZDlQblAvODdk?=
 =?utf-8?B?cmRwK1BvZzNvaGsyRTVtUGNNWWtxQkxZL0pnd0I5RncxZ3NHNXJoWFZCbTVp?=
 =?utf-8?B?TS9PMlJidExtL2cwam0vQTBCOXZhWk9EOXhwcHJsYXNxd2VvQUt5NVJxazNM?=
 =?utf-8?B?VlZ1WmZnWS9mT3E2ejN5ZDk3WnY3cU1JQlJ0Y1pxU1VVbXh5M0Y2QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd4131-fb3b-4955-65fb-08df02adf49c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:37:06.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALYGD5KXtFjCjlHERzfTe5xeiAY16ZVzMXD5zwRYCceH7qCL+ulKruVPV4cG6JZttYO2EAq7s80+lbqKyFH9dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2929

On Tue Aug 25, 2026 at 2:16 PM BST, Danilo Krummrich wrote:
> On Mon Aug 24, 2026 at 1:17 PM CEST, Andreas Hindborg wrote:
>> +/// struct Foo {
>> +///     refcount: Cell<usize>,
>> +/// }
>> +///
>> +/// impl Foo {
>> +///     fn new() -> Result<Owned<Self>> {
>> +///         // We are just using a `KBox` here to handle the actual all=
ocation, as our `Foo` is
>> +///         // not actually a C-allocated object.
>> +///         // INVARIANT: We initialize `refcount` to 1, satisfying the=
 invariants.
>> +///         let result =3D KBox::new(
>> +///             Foo {
>> +///                 refcount: Cell::new(1),
>> +///             },
>> +///             flags::GFP_KERNEL,
>> +///         )?;
>> +///         let result =3D KBox::into_non_null(result);
>> +///         // SAFETY:
>> +///         //  - We just allocated the `Self`, thus it is valid and we=
 own it.
>> +///         //  - We can transfer this ownership to the `from_raw` meth=
od.
>> +///         Ok(unsafe { Owned::from_raw(result) })
>> +///     }
>> +/// }
>> +///
>> +/// // SAFETY: We increment and decrement each time the respective func=
tion is called and only free
>> +/// // the `Foo` when the refcount reaches zero.
>> +/// unsafe impl RefCounted for Foo {
>> +///     fn inc_ref(&self) {
>> +///         self.refcount.replace(self.refcount.get() + 1);
>> +///     }
>> +///
>> +///     unsafe fn dec_ref(this: NonNull<Self>) {
>> +///         // SAFETY: By requirement on calling this function, the ref=
count is non-zero,
>> +///         // implying the underlying object is valid.
>> +///         let refcount =3D unsafe { &this.as_ref().refcount };
>> +///         let new_refcount =3D refcount.get() - 1;
>> +///         if new_refcount =3D=3D 0 {
>> +///             // The `Foo` will be dropped when `KBox` goes out of sc=
ope.
>> +///             // SAFETY: The [`KBox<Foo>`] is still alive as the old =
refcount is 1. We can pass
>> +///             // ownership to the [`KBox`] as by requirement on calli=
ng this function,
>> +///             // the `Self` will no longer be used by the caller.
>> +///             unsafe { KBox::from_raw(this.as_ptr()) };
>> +///         } else {
>> +///             refcount.replace(new_refcount);
>> +///         }
>> +///     }
>> +/// }
>
> This is valid as Foo is !Sync, but I think it does look racy on casual re=
ading
> and possibly even encourages people to do the wrong thing, i.e. to peek a
> reference count and subsequently act on the read value.
>
> Besides that, if the value can't be shared across tasks it's not overly u=
seful
> in the kernel to reference count it in the first place. Do you have a bet=
ter
> example for this?  Maybe a broken down version of the one that motivates =
the
> patch?

I think the series is very old and might even predate the `sync::Refcount`.=
 But
given that we have that type now, the example should do the correct thing a=
nd
use that instead.

Best,
Gary
