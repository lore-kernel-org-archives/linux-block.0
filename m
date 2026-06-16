Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022138.outbound.protection.outlook.com [52.101.96.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17253B7750;
	Tue, 16 Jun 2026 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610737; cv=fail; b=Nzuf7G72ZcFeigBsWwOFtIQ5U0Via9sFn7FysAtrVayBSk1Y63ewiTo3Mc97JSnhtFl3jA3F1LxY4nBVbPF+x5QTWMAMlanIMvG40KjjXwTgTFUZNbxflGggr+5jXrKGFAcCf6hplcQoGGktyGTmPeg4HwRsCMFe43sUKyugSGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610737; c=relaxed/simple;
	bh=xcfhGycqpUE+8Qo6EZlbuXpG48y2fnRfQE89pEej/R0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=UegLWDS1YVpV29HsUrJPzpRxV7gv6wcowdM0ZgPstpHLe2F4urk/y53Z53S/mEeycHlLQFhLbCxI4Du5vgdPpt8R6t+wSQERv9JavqQXjYcIP0+UZ/wPDzcuPA/fX6obCUsKeDqHqsl4WMuOZvOIosoHJtBZWnUFHFJ/f50Kes8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=H67cCqWL; arc=fail smtp.client-ip=52.101.96.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="H67cCqWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmRHdxkPyv5SRV5ZWrhVNAK/92s5AHpn0jrbGnv8lNWZZzP3KwLUXcQJKKkAut6ZQz8GpAVrXcvRVjDkTQ0nZKCjdeOdAKBwqNCGGpmMSQnl/3ctkSGHTgKPuE7ylID6NhsmLkaXOTWizZyJ1CtRYRUuRXMuhHZVng3Ib7HMc5aid9hvrFFRn6V7r52pHhJ6opKQEe8qs4fByc/q10+tPx1oRqGvPP/wEWeh5uG2OGmTlkJoIM1reXyv6tMr/pPabTN9Ekk5CuofRok5MT0FuF2VxpOiBfAbJg2B6DpCW/NU/e+3/OCiUcf2NGXOou+An4hUjn20LoIwp1wgExKFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05saV88BDRnUt9+HfuLvy8ZXpd1g6jM9K8StEk8oE1A=;
 b=MDOw3lWC6gg73GwSyDRNizTCqVdoRgzXFyBT755giNXCHeeHW0RO9mahNN9aBbqeKaYtD+18SNHdheglzkT3hmxGbrMYfAJojL5xvIxxN+uM9OA7JV3izr0c9Nn3h78gbQ0a7LJbp5eBa2JI88LEEFIYoA1ocyLjuIKTUBDwtPvWp0ciezyd0k3U0d6QkUGwzdLq9sw9Kv73Fb60UyUEe3X7n5CSbHOZYOiNWdoo/XyMzxQ54FvakK/bBesRRqlb7BQX7nKgJT+j+HU/d6B0er1wUzsDosK9IIwuV4Cd9Z/gic0eOPWVAAQ8Ba/VjdLiN3FwVHc46MKonG0o3Sl6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05saV88BDRnUt9+HfuLvy8ZXpd1g6jM9K8StEk8oE1A=;
 b=H67cCqWLhRDwANSCiRzjilOdsCQcR/sTKLk2j6JNwv8YJXwuNTawGQKWbwGwn1LbVdUNc/TXGszK5fYuhJnvq0Cu9xs/bwSIPOdkNwDoST592B36Ur7u91ko7ejhE7oSvn10a1w1MH+1Yc6ogTFIAcIehPOf5ph6uj5+7oTxVhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB8506.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:471::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:52:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:52:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:52:10 +0100
Message-Id: <DJAGAMNJ043Q.3597PYV2YD6CI@garyguo.net>
Subject: Re: [PATCH v17 01/10] rust: alloc: add `KBox::into_non_null`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Viresh Kumar" <vireshk@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "Pavel Tikhomirov"
 <ptikhomirov@virtuozzo.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <driver-core@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf5de7c-008e-4a5e-3331-08decb9db35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|10070799003|921020|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q9/HIh9CMNXG8bgye913HrVSETxYwEONTy8Z/yhiyWt3kNDjyRUUuiWWIYqAohPJ4W/QpGezELO1zhe27ksNHgtK1XjDO6KTi56dq8cgr4SjpwPGKebh9r7fr3XFG1ghsseuJ5dHJ2OfSEOzM1oYmF9uM8UCpd9jf8OuIhBp4gUqp3QqZCzz6HvhSMvlilFHZ+AkjstoJl2Dq+xpMPVMxbkBMjQFF1OBJD7yzlSbh72u9NJIKxHf9vMAlS8HCiKnqeebzdG7fheb//gh1FmiqUFPjr/sfaWrwVwGxkySELgUYcjUbJZfXcLZyrmjbF/vVH1Mr23QIWnyBecxV0erEW0rNSWF7iPu4MrGQO27gKx972Rr+93Poh5s5vEUpMos96rF7m4y5e4JAxqiz/InFWihRq7yhUnMferkOCiHTZY7oHAPiVQjFn15hhYpWPqpCFoi5pV7KMdZq+gTA4oLqLqu35xVwtygR8KwcJ8D5W7kyDSlOOIAA6map2xOPXgKO0fFxzlbK2R8IuvrkIatA0LQuG2GLupz90qUxfLpVucWbUcB7eaZCsL+q+imC7Gewyb0/GFFTgsr9pHhu035V6RJreHPg2RVfqkApdmQ/FU7VrgWOHtLZ4ZS2caXgXj36sA8dA1kymcfI3xhWN9iZPU5RrFewI2DX+IskZZTZbTm63xQW5Mw3+DqgXepT7k3lWBQ2SAkCe5qppbE+40Z2E3n3r9wsHmXzv8IZijS620=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10070799003)(921020)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTc5YnFhZ3c4VU1vUzIvZjRCOVlQTENCczBaV3BEWDVST25TZERHaGltbStt?=
 =?utf-8?B?WHRVRURibWFCWEJIS041azE1UTRsaDdGSm9ReTFuZ3V1WTdvV0Y1aUFZZXQy?=
 =?utf-8?B?TzFrd01qbEJLZFJuT0hmcU1sZkNVZlFWQkVzUUozMDVWSVVDV2FYUDRwZjBz?=
 =?utf-8?B?VFVlRlFtakRLeERmVHN2eUlFRWxLT1ZueE42d3RneGZWb2RDdVcwNGNMZnNm?=
 =?utf-8?B?S1Vya21OWDlmOXJVbFJsZzFoOWY4NXUxNzhZREF4UDgyTVNnOXp1R3V4MGIy?=
 =?utf-8?B?b0x0ZlBKVFFKNUE0Ukc4UCtrTm9UcVZrbnJ2bkxQNUcrOVBNYU1kK0FRcE1S?=
 =?utf-8?B?Q20zeFN3VzRoNkROOEd0N1MwbWordEtSTDdudTgyWHdwbmJsZ2I0c2VEWE1o?=
 =?utf-8?B?enNWZkQxZVUzTGN6NmszenJCVXduemRSUmp6QzdHVHJocTB4ZU9yMGtoTmlh?=
 =?utf-8?B?dG83T0ZXaUI1VzY3ZW1ONkNtdFQ0bHZSN3dPR01MZFZVRE5tUDN4MEVMNkhL?=
 =?utf-8?B?UjhDeEVZejNLODRUQUQzTVgyeEpjY2s0SXJQdzhjSlUra3pZRThCNVF6Y2gz?=
 =?utf-8?B?cmxNM0ROUTRsUjRDdHZjc0FlVjcyMEZ3d05NdlMyZUZadjRTWDVHOTJhQzhO?=
 =?utf-8?B?QzlYSStBZ2cyZXNJSzZWbTQ4VGl4SHNrOWh0bDI0M21lL1dPaURXY0dLUjBh?=
 =?utf-8?B?UE5lTGJOVkRxdG1DNjJYSUYrQWpDTXlSaUxCNGFhNlhzMzVpNHp0K282cnJx?=
 =?utf-8?B?Qk9ONmpBU1Y3d1d1d09wMmFRdzBKKzRjbFFIZmh4S0NCeTE4WmcwL0tMYWFy?=
 =?utf-8?B?NVRpRjJVYitXV0h5Vyt2d3d0aFp2aWtGc2hKdDlxU1pYRFJjSEhMVTBDRmZl?=
 =?utf-8?B?MmpQUUNlamJRbXVYSSswYkFIbTA4SmxaTnhLYVA2NHcrVE5XSmhFN2FYMlQ4?=
 =?utf-8?B?REVHQnRpKzYrbGtscGs4R3ZSaEJQQmdsNlZPY2JVcU1sMWprMTVDZldjcFh3?=
 =?utf-8?B?VnhXZ1AyRGlabXFod3NiVGtlWDNDd3lhZCt1V3huSjFsK05CZTBDZmxHNGVT?=
 =?utf-8?B?UXdhektZRUNPOWJUWVkrNVNRcC9UK2lJN3lCSkN1MHZOVnZ0b2pENTdBYkZ3?=
 =?utf-8?B?UEFFa3FvenlWWVUyRDNmYUx1aVpmM2twMkF0U09LbXV5WWpUbjluNnNzdU05?=
 =?utf-8?B?RmdNV3dyUFBrZW5Nd1VyemwzUm9zRXFNRFZ2SitqY1VrV29PR0RjWnVNOGg2?=
 =?utf-8?B?azMzb2lBbDlOVkd2Q3VPL1VReUduVTQ4dTMrb3JabkVpUDVjVGFiNjVIWUhW?=
 =?utf-8?B?MGJPUnh1VzVCUXZNM2FWWldSQWs0TDdIaVoxSGhYcEJhMThLSkVFemdTc3BT?=
 =?utf-8?B?SDlVMjNVT2s2dHEwaFZ0TnU3bkR5WGk0VmdKUTJzYVdySkJkUlNSSzVWSEI3?=
 =?utf-8?B?cm5sZnR1d0hialplVkp6K3dDdlN4QWJwWkp5WTJlL09XcFB2c0lidW1hVVJO?=
 =?utf-8?B?d0FPL0x2Qm44T0kvanF3WitoWlVkWlpOR3FISklDQ1dlak9GVWthSFRJdER3?=
 =?utf-8?B?N1dhRzhoZjR1TGRSTHo3bktmWGxVR21vbGRramY3THFsRE9YUjdkWTdvRmpT?=
 =?utf-8?B?L0RtcmpXOFkzNmxCYXZYNStzK2RIMkRWcjYvL3M1YXcvSEpUUVN2ZEhoeHNM?=
 =?utf-8?B?TUhZY3hwNDdzRWZ5ZUkyMWU5NDN5KytLS0tPdGJxOFhGbkVUOCtTSjljQ0Zu?=
 =?utf-8?B?dFFpSE03UE9hbVpRQ1MvTlJYWklra0hnbmk3UVA0MXROMjZ1Z1hZWWtGNDkz?=
 =?utf-8?B?aC9ka21qeDNmSm5maTF4b255dHlLK0c5bWxORHFWWVJDQmNlVXpqNHFvWVdO?=
 =?utf-8?B?djBpdHVUaEJxbFJZZmQyQWk1RlM5UlBGU1I1ZloxdTlHc3ZtTXdtVWEzakd0?=
 =?utf-8?B?MTN1SUI5WGtyUGM2SEtJNmFVdi9WRGdtUkFvWVN4TjA3TTlrazA1dWtDSXZD?=
 =?utf-8?B?T0dJUFZLNCtjYUJpeDFYeXVwV0VkK0NVOFN1RmZrVkJBVm9ZTFgzRktRZDFo?=
 =?utf-8?B?SFd2QzgzMDhzd28vKzB4c0ZUcFRVVlMxNGhQd3loTnZaQ3RtR0wyaStHQmh5?=
 =?utf-8?B?UFFtM2NrWitmUklBbjJiTVV2a1hyemdoNEFNUUNOemVPSGpuZHZZQmFNdDA5?=
 =?utf-8?B?eHhHWjRSdWJTdVhDWjRWQUxhUjVSd0JaSVNwWjhwWTFMeEFaUlBDOEJFMk15?=
 =?utf-8?B?RGV1RlZXNjVrenl3eDZRNllRTFo5bnZSMmRpS25YcUcwb1I4NTl6V0lhZE1n?=
 =?utf-8?B?WGk2TzlqSmZOdmdiRE1iSU0vbmpURWNQWjZSaDljL0EyVzVreFZTQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf5de7c-008e-4a5e-3331-08decb9db35b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:52:11.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2/lLAwZTO9LPC+egOCtIhkRBn/Xob7jYnVIP5JoWWVWOoPhqJkZerjA8A30pohqPaNYVqGNbH1NHsnuLBbxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8506

On Thu Jun 4, 2026 at 9:11 PM BST, Andreas Hindborg wrote:
> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc/kbox.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)

