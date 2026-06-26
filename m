Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021128.outbound.protection.outlook.com [52.101.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAE3E7BAA;
	Fri, 26 Jun 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484920; cv=fail; b=oNILQLNKwhgjjDA9F3rGnX6cl75DxMbrVTRdDOywvZcyGnLJLN3IxREDIe3tjeVeZ6kNGB7tOHCbZ0TNw8xrtLOY+MxCMoo6BTIp5648bmHzGEOkPGF5J5JqcL7o1kAfERp9YB0abX9VRdyyb1Efa6BAFrKWeU+iQcrrRkVFSeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484920; c=relaxed/simple;
	bh=211i9aFU3cnEASYQx+RQ5YNzTlHRHsI62Yy8Zl3JfOg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=u6JDQesbNaiLLnW6CtRJCPcnBvO7tjrurXaHFdK4AS1yH95O7tqJYLmE/yUiAdy2vRrGHr+vs/NXuZWYMsXnlsxd2itJfzhikO6SrojKGYdJH8d30tAVcjU87VQDg8XnzllA0tZcO8vvsHObN7ZS4mAtiyNd1RnGzAsYPDOw7Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=UgV7kziY; arc=fail smtp.client-ip=52.101.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UgV7kziY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ert/M7N251cl9f9W0y0CnsoXwGvMe4GbUBB3tplj5nKdg2OnVZS7Q2LZ56pS8crJk/IFZUDMj3nlBN+l8fiL3Y7S1IvWjUDZ8C/X9f4cWIwHrNtf7r9jxB8E0LOv+Be2Oj0CUGnSJiuX82J9cXI/EvxhUrU3ORBAoR9YY8lenfTTUwiNNvB4226O/Z7kCevWDkvqzSPqrr5vkQFw1Bcn3N7ibsLMWaNwWvFD9YRdvIbM9K3IRJcMa1L4cY0F7tuBF+jabXIo1qoUC/WzkrxWZ3ZztDQmMKWY2cNPhynKlKmmtHZ8OjZ6PEw7MqrSVyoKZMwXpXcfMLfZKewb3R8muA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=211i9aFU3cnEASYQx+RQ5YNzTlHRHsI62Yy8Zl3JfOg=;
 b=NJqmJPC/fxAlZhhKyB1DcYXlL0P0zyu203UoZYHwrnUhR9U3ZLhNeXKmoJ4aArmNt9gQKXDfQpUhQuXc69MZMTIEfCetfUhRhkcdwQFf2LxkK8pFi9Tgm4PyFfqP1Ng74fTNEVlTo5ANZ2DipgR3dAK7ZQU1g56t1hIecxXpCK3JjgRRhkGz3aTrPQDVBPGcvNt7ptTXPG8lPIuspaI2McymJ1Emcblcq9Ba6tEZR+ux+RwpujfvfFA/AhjnhEX2vlqrwlWI63LxiKPUfQY1+EM2gDHR02ePcquGeFF/ZAtAfSZd0Nu/qFyFkV3fg+Q2Wu5ODWeMHWh7dEYUE/8K6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=211i9aFU3cnEASYQx+RQ5YNzTlHRHsI62Yy8Zl3JfOg=;
 b=UgV7kziYqxBySJG8/bepMb1q0l0YlrNp48ijgnfzC7Q7Kon10+NRGGe59iLIKTW2EG86qjZ+9lIA9Ib6mo5MExcnyzP1QM0fq0vUNhuFi6Rt3ZOXOksth2l4pnW+CjOGQmp0smHy9uKf7amS94bjY+3/L2OJrNMIpFrhW8yr3ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:41:55 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:41:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 15:41:54 +0100
Message-Id: <DJJ26195JBS9.D3DNLZPRJYO4@garyguo.net>
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
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 10/10] rust: module: update MAINTAINERS to cover
 module.rs
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-10-5295e333cb3e@linux.dev>
 <DJI7HR91X68U.3BVK3U4OJC18B@garyguo.net>
 <6d2b7611-41ec-45f0-a155-3b5c90c5d883@linux.dev>
In-Reply-To: <6d2b7611-41ec-45f0-a155-3b5c90c5d883@linux.dev>
X-ClientProxiedBy: LO4P123CA0235.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: db5ddccb-fc2c-4b06-5255-08ded39111ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vL6jiatnTWUWW38VaXwOMTl3cJ/y8VICXfs/ZxzcCDKEZNw36G4+8XZTBTQO7pvzW1Jn/2AQlFagrmQKVb1WwvmeO5Zt+W1cNghAB8wtqEqEcwsU9sG71OeryGeIqrlM8tpujNIITNbh7zltlspQRndjfnwe1fDJgHvsv07CIzIjBf4w9bR/7g3yHsdsMB5tdJKZBLP33kqdytGet7a1OM4bzdoflwNf5iZFNFOzvOFGDm88DHMtFtAFhXD/auqtskZUCvI8peg7+gKzv6IsvuTGWJl/A3JKPZCxpI1idQkEtgRdTRtVV8TPaEbaMolpc1dq4vzLh4MwEWBYJFpdnSonuZL3UHVe5Yif7S8E32H63tXmnAJkBsQjTf07iOlo1CJ98EIw2N/k9W4/uFeR8Fy9SHy2oadf6tDAGL+rsGM5d3SUx8KTbED7KNZLLAO70YOwsrk5BLzUzF3PQjJfuVidpgRNm/TpQo/JJwyGgQbiNATHIUWQAumqDixleO7fYgJP6RZsDalrEWH+86NSVqOvYq90TqGYWg9F+4gsn3UuXLZjwJYTHh+O9d9JVawpS7STy8VUN36otss8sUnI9pXNIMQygQqb9o+97KNgFWJRQvcV58yKvNqy6/XECG7YtppWLsjoi3LYV54F+8Oj7pMkVojq4UQgm/oinHv9EngSRxSLDFe04pAZmMIIUVxQl6L9cRhWhOQuB8TVYTotaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdReEtna3Y0MmJQT0pFZE04c0xNVHJQeUxjUVdpV1FUUmx4Q053WXJTNGYr?=
 =?utf-8?B?dnNlaDlzV3Z4VTM3Vnd1THQ1RHRSaUZOVUwvNTVQQmhrcXlxTGk2MG9QYVBQ?=
 =?utf-8?B?bUd3WDNyV3pLb3V4RG5UMExGWnQ5dFMzNkRjTjhOYjBhcjRZNzI3TS9pRjlj?=
 =?utf-8?B?QXlxcU1VczVSZkRVY0lUaStwcWw1UkR0akd1eStZdWgyN01VMWpKekxVQUcr?=
 =?utf-8?B?UDF0b2QrR3dQUUZZU2lwVXZOOTU2SUlSYnZ0NE9VUXF3TWg3b2FRSnZoU3RG?=
 =?utf-8?B?QWxUYWsyVnNKT25hbXVvM2R0UmJxc0sraWhmSHBIR0F5eUpXMnN6UlJqWnE4?=
 =?utf-8?B?alI2MHljUmZFbGFjdHZzWVdwNEwvREx6VHBHZjFyY1A5ZGkvZzNqZmxXc3VF?=
 =?utf-8?B?d1N2ZFhYMFc1QmQvK2JpZjRlY1RCem1iSFpvSjZxYjdrOXJ5blZJa1M4VjFQ?=
 =?utf-8?B?TUgwQ0p4amFmMCs3aTVZMk5TU1FSSGFVNTVJTzUvVk1IaGliSGV2d0FkM09U?=
 =?utf-8?B?amhFUU1sdXV2WEx3NU5nQjQ2cVoyd1d6VE9GUzV5TVNVMFhQRFprRUxaZEg0?=
 =?utf-8?B?NjgrVGF0SWxMNjA5MkVNNWNFWUdBMDhlSms5alhkdHI3bStObmdKUDM5S0RQ?=
 =?utf-8?B?WlA1M0xod25YWHZSaGltUVlGUlE5Zi94elo3U1JNUXF3ZnBuTDR1SmkreUxV?=
 =?utf-8?B?Z0thS1I0VlVmZ05ZSEZZemFxNGEwd3Z5cEttck5yaWhKZHBWN2Z5Wk1VbWo5?=
 =?utf-8?B?dklxUU8vQ3NFREtTeDdiMzMrOXNVaHpVYmViTFo1MU5UV3BJMDBCUW9WeE5K?=
 =?utf-8?B?VmpmU2Zyd1hmeXVJZWZQOFJ0Y3NMdnhSbmc2S2o5K1Q2RFZINXhzOCs3eURD?=
 =?utf-8?B?a0NrQUltOVhkKzlZVEViUElvWkZjZ1FBampXY3gxcURvZ0Q3eGI1TjdjWUpB?=
 =?utf-8?B?aU1wN2xUMTIzREhkamM3UUVPdmZDQlVIM2lNSnl2TDExOXhNMEV4Qm9FaklQ?=
 =?utf-8?B?a0RSYzQxUXE5SjBzSUpHN3ZaT0tDYW5DZEtRUk40Q2hBeXJFUGNiMEF5eGpK?=
 =?utf-8?B?c2JMQzZHcHJuRVdRYjlpM3Z6cXZCK0liSmpJVFFBOXBVOTVCaVQ3emREeWUz?=
 =?utf-8?B?STlFby9DYXRhWjJPSzlQN2JaTVJYQUpYdGQybU5KekIrSWlUUkxwOXhKYU9u?=
 =?utf-8?B?bFVZbU9RTkRSYzdxUGlOeEJ2U3ZURkVoL3Z4R283Q2F0R1MxUjBwczBsUlgv?=
 =?utf-8?B?a2xpeVVncTBJZ1JucGdoVVFSSFoxSnhlcnFpejBQeVFLcUk3cDJzbGpkMkpy?=
 =?utf-8?B?eC9DWnh3QmVVcUJjSDU4Wnc2d2lIM3NWNTRIMUdhYlBKZXM3MmJzUXNVckxG?=
 =?utf-8?B?ZXcrbE5GVWJFZmF6ZWp6Q2ExUFVDKzZjVUc5VDVIZndtU0N1TGZmN2ltaFQ4?=
 =?utf-8?B?NndOVWllWU0vZjFqK3o1YkRDalRpY1g2VjRoOURqM1kyNWlLcGNWanJaK0FO?=
 =?utf-8?B?RDVCUWhFenYxUUNpYmVpWFVFbUFDaXVMSlg2RHViSHdEWDRCZkFMcC9HSWtJ?=
 =?utf-8?B?Z1FjYXorQ1d4VWFTcTBoajliNnBmV1BsMHg3SjkzY3pNb0p1Wmd6K2I5U3Zl?=
 =?utf-8?B?TkhhME92VVIrTmVWUmEraFhOanNtYmpmNmlqMGYyNVBOWVR0SjNRUEpVd05w?=
 =?utf-8?B?cVdmN1A2Tmg0U0hjSFAxTTgxVWxVZ2crM0JhMzJxK2pFaUVkWTdwdWVHS2t4?=
 =?utf-8?B?OGVqcGc1MmdGZ0swTmw4SGM4N2pWVjFEaTJvT0VZMzlkcTNRNzRFQ0wvYm40?=
 =?utf-8?B?Y2M1TDZyRnMrL0FFZlovWnVPcTgrS0dDWlZ6QUtTTDBzeGxhSS9OZUYwT3Iw?=
 =?utf-8?B?Zmd5NWp0bk4weTZnWWdXaEdOakRkL2hPbkM5NVFUdTlMejVBczNWS1ZobTVV?=
 =?utf-8?B?Ym5rclB6ckYyNi9Ga3FXM2psdnRoS0k1N0doSlBlVmEralpuN1Jaa3o2YXFn?=
 =?utf-8?B?cXlXcVFDVnlhdm5WejlGdms2cUdzY2JUUi94dld5N0xicWFxUWQ0Y1hYMGt1?=
 =?utf-8?B?dTU2SFMzeEVSMkVnV0o2N0FvejhOOVJjTklMSlRWdEVxMlUxcFVCRzU0UnlR?=
 =?utf-8?B?RjByVFFsbDNKSkVZOGdTK2kyWHc2b0VjTEdOczNUbXd1dXB4ODVna0k3MnBH?=
 =?utf-8?B?UHlieTMzZmEwcHQxbTltYmlHZDJCMFZWc2V3bEp0QzB1dmpuL0xTSlhoVWYz?=
 =?utf-8?B?UWRLVk5lSFduWkt6OHdCbStMaDhFWmtqUXpieUR1MTEwZ3ErUkN2bjlyZmM5?=
 =?utf-8?B?bkQ3K3czQVlhdlltZXRBSXVvd0w2WjBKSlRXYitGTzdSblVReldTdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: db5ddccb-fc2c-4b06-5255-08ded39111ae
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:41:55.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55fqZQgDzKpVptDTA8HZFeLaMwASBTKuFsncHj74n1wFXhht9brEkkLCHF+YnKzD06VQq9wOvt+ufEFtuuCevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248

On Fri Jun 26, 2026 at 4:01 AM BST, Alvin Sun wrote:
>
> On 6/25/26 22:39, Gary Guo wrote:
>> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>>> Module types now live in `rust/kernel/module.rs` alongside
>>> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
>>> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
>>> files are covered.
>>>
>>> Assisted-by: opencode:glm-5.2
>> Did you actually use a LLM for this patch even? :)
>
> Yes, I've created a skill that generates commit messages for the code I=20
> modify
> manually.
>
>>
>>> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d=
21c5a1a1b8@suse.com
>>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> This patch should probably be squashed into the actual move, i.e. patch =
1.
>
> Sure. Looking at the change history of the `MAINTAINERS` file, the=20
> modifications
> are always in standalone commits, so I followed the same convention.

Right, you can keep this as is then.

Best,
Gary
