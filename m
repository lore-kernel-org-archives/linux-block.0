Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021072.outbound.protection.outlook.com [52.101.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F301F4631;
	Wed, 12 Aug 2026 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579062; cv=fail; b=sFXGbdsP2bmWbIOPTd6zbHTNqZ5E+KS8zqKuw6RzMiJeCmGQNYyzdN8IiIEQZLEE4VFQP9UZq9RJaiw7x0oEt/+C01dUbVns+KfhlUh0dbFhW0mJO/79xYJUmCKHcGlJN4DCTJfuctEo5xqJZ7bYJBKrirRd+24IvqJwNdcGbW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579062; c=relaxed/simple;
	bh=zmba77DZCB/jz8SvwTnE1yO/xsP3f8TKPEPQiwdhE5M=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=cTREJzSFKL46DLGCIsQEndRmCMF/LupzwgXQXU8TMdUFtf2WGiaLAxhPzMioa3JO9vwPId2y3HLaa2aFFLlOnw6AZkGt8OJeLlMQB8RjxcftpTAABJ4MBfZ1xWFA+beRbCovAIw62XkMbc6juM3rCNcRQB2idtfSGhhAuYVmdHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=WD3Z7ZVA; arc=fail smtp.client-ip=52.101.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="WD3Z7ZVA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXjUIZaHS1cpese0jpJlu+flwj/M6WRIPclmiaOn1fly/usxZmCnGSma4K26Kc5Sd6LpnllM0xb5Nf9C4Ef411G/UcwCq9demfYLe/s5+CKgpdkMP9v+kk8Ho92G8qT2ykhpkp1e1u66z4KmASnvjVoiaVz3nzezO07H3pBXUcmpkI0UeTv25kjO9eVpaxf+taHvU/gnSAwbyd32axLROC0H9eguT+s8kw7niXbOV9T/Jeeh31juv4EPHt/ZsyxBuahWdb34tUCmEZP5PE+Ych/W5xS1GaG2lhfXkSi9iygMf3zpGP5snVAMBPv7pajya+ASVsSmlwjPbJKCuoBLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IjwwbZOfwxduS9HnddZO11tReetS2GDkJ9bved9CtM=;
 b=da/b3YmPmZFpSkSi5APazGjbIcbLYU/bpJ/X9Y8qnRJDFGb27j4NGW6MWM2NcPGYk85bWmji4S43jBmED1bYbBRqwZM53d3k0jc6PqW3FVlq6hioY0lbLX73LvqI65CjBl7O/3fE9zK0VIV6/AlpjMneh6Idkvo+ORbHMKNrh90oSmbJ9Bxfmd6nsDN6nALZye1FxXw1YilWca2WPv1NbcbPN7GSLMdMpwraKBBMxM4Y+HndNHAlHnN02dLWvIr9qW+B/Tt+Cbcq6mZCCTH6ngXWHsGs7KcyV4OmZRyQkbSXT/GzkJrQ0TCd2PRMWTWizQoFOH6W3gyCftxpUqSs/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IjwwbZOfwxduS9HnddZO11tReetS2GDkJ9bved9CtM=;
 b=WD3Z7ZVAv4x0Ra+Odq/tU7OVM8WKHKgsXxyIkMQgvV719TP/0qp5IwqtHf3igS+m4lWR+VUl9yGIQsrks/OHjHe7/0ETdjDO5DXdg9p8M5QCkCSUqZCJjTI4ykOrll8R756c72Yo4Q4VQ7rkzA1seOn5fMVQX8JsSO0oPQlXT2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6177.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 23:57:37 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 23:57:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 00:57:36 +0100
Message-Id: <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
Cc: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
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
 Llamas" <cmllamas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
In-Reply-To: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
X-ClientProxiedBy: LO4P123CA0645.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdec206-0712-4f6b-a04a-08def8cd7c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|56012099006|18002099003|22082099003|10067099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TS/LXEZksJoM9o+rV0Eo1BlX7gK6Q0mcQReoP3RuXvc1vw6KS2UbVwG3ZgjKTVtRw0Zd1lvCs13Cf7GjI8l+HZQB/vCCBrZ9LwIqmc3w14ybfX9i3FWkzISj7p8KscW1mGpEtLZCHMHDvMbCLAPBS6CMBxVVKb4JjZ8hSeSjfpRCEhIHiFCxrdVpycXrOv1xP0D2t6WiC24zmou5t5q/3VdbvLKOoxNZbB27z5lOEUIXaYrK8sdji0c3pPIeiA/Mh0uk1iBrkTgaeOrHhRLs1NARLXCx0ZtyA7ZIRFNK1iCxjQNbmCCOdJNZAxoMp64l/Frkx3SUdry/C9o81g/s3L3io8F5nRsweZ16E83y/GZ5hrcA3Rt3oEKO9a/2rIPtw3wnliSJvVSGKwwpdGUjcUZsWj5ce1w2eDeYgvYSGKwGz+/Pn2SrUCKjfrRot2AFj+xgiMNdTsWEjz5H9GkEoQicyHWac0RhLwgy9QzSR/uDeyaO8XG+/FdwINo7g3wtTDfz0Dx9YFR45G/iLOYlqXMLkt+JkMG8ofb84Z7VIuMeJmpYEgqarIhyli5UDtgKIetkDxyhubuunRW5O4ItT0clsk6Kb6ZrSdw6p7eEkRyN1fBSxX7otu6i/AtTcmQC/6baxOuiupJww8iF8UoTkAafVRqXCCyQAz2dlOTg6uk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(56012099006)(18002099003)(22082099003)(10067099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDhzQVErcVd1NE4xS0xUd3JoS29RTkhqZzQ5QTRpOUZsamNQODdDbFA2RWsz?=
 =?utf-8?B?d0dJRnB2bUtNdUJaaDZvS1dLRFhuckFLZWVIL3kveWtpc1RWMnd3b1JVSFBO?=
 =?utf-8?B?KzN4amFMUkFxODhkTUlRbENOSjNuUFRvdTRGdmN6VWtQOE5tSVVYVGlVcXhK?=
 =?utf-8?B?RU1MOWh5M1U5SVVkUlJ2bnBUK3VybXk2cmxiME90ekkxVXJmQk9iN1crM2hV?=
 =?utf-8?B?a0RMSW1UYS9pRTJjcFZualA3cXhadHhTSzA4ZUM5Vzg3QmQwQTNCSkNsQUk4?=
 =?utf-8?B?Mk5rbzBpbGl6TDYvR1dnWkIvY1B3dUZXc3lOVVlwM0lHQmdmcEVuNGJDaDdX?=
 =?utf-8?B?cmkyZk85MHpGYTQ4dkRlQVNHc2hqVGNLU0FsRXFZVHBNNWdXcm45eElMa09D?=
 =?utf-8?B?RnhDWlF3MXVtWGQ0ZTZwanNOeTE1NXdiWUpES1ZHNWtzTlQzTkh4Tjg3bDE4?=
 =?utf-8?B?ZjE5V0p2b3Z1dEJTdUtOb29UcUdwRDBaaDdET3l1RVpjQ0dKRGJueUhscHJp?=
 =?utf-8?B?aFcvNmswVHVMOVlYNSt6RkR0M3dwNWRnQTQzS0VlZ3BPN2NtS2lidW1nU1BJ?=
 =?utf-8?B?NkZvdjE4MVBablF6cmxQYzNCMmZZeTErNi90NXNycTFSeWtsdStmdjlCT3hr?=
 =?utf-8?B?ZFk0QnBMdWIrYXo3Vk44V0pPRmRLVWRjdTBERW1PVlVYNlZadnVKWXd2V0NB?=
 =?utf-8?B?YTZ2aEVBZ1RQNFFCTFRVT3hzeHRpTjdRNVdIS2JORU5jc2NSUEJUZmZYMFJo?=
 =?utf-8?B?aThFUHNnUGNjbGpGa3RqSzNxaVlja082TjRENG5NczVHNi9LUUtPaFR0VUxt?=
 =?utf-8?B?VHUwR0JGZEVGVFp4cWJHUkV4SHNBbStKS2NQN3V0eERuWHlKOGhJamtoTHlu?=
 =?utf-8?B?dXMrWm1JWHNMUkhqWmdIbWhBQUhTdWlJR1VvSzRzcmgyMTZWUXh3T0QxRHFD?=
 =?utf-8?B?dFN5UGsrQTNCTERXcXVsRHhLTHF5YlBCdnR5STdOVHoxdFhDTC9GajFzelZJ?=
 =?utf-8?B?NnJFd2E0YU1YY0IrVHUzQnZ0OWNpbWNWb0JaUHAyOGllVjNsVnd4L25Oek94?=
 =?utf-8?B?TXNTbjNiOHpBc0VTSU9tSE5ld0s2L3Q1SGx5U08yL2lkMCtXZkZuczBFMXdO?=
 =?utf-8?B?ZEJNN25qY0lucVY4MzBjR3I0UXJLMFR1eU1oSHlrcGZrcXVaNUhpTEhESE1Z?=
 =?utf-8?B?S1FmSTRtak1nNjFibVZuMEphYzc2em14UVcxclh3VTV5eXlWaWxSaTlMTVRh?=
 =?utf-8?B?UXNwcHhuTDA1elJIQWFYNW1NT1U5NlNnUEp5bDZvS3hvT05UQ0RVRWk4cGlZ?=
 =?utf-8?B?dUh6OVBIbnZObXB4MHVySk1McWJKMkcrUlhoekZZK1M1TTc0ZzFSeWVCK0NQ?=
 =?utf-8?B?MnFMa0cvYmxmSEFMcDNUcEdhYS9WODVCN0ZYWitMeHJ4L2x6Wk1yTTVhNlEy?=
 =?utf-8?B?bXBRVXVjU2tUYlFKOE9qQmttNDQ3S3RWRXE4aEdvcjZiQ0M2YmpadWZ3VjBW?=
 =?utf-8?B?VHpobjJObXMwNGdQZXBYMElzaU80Z2FDK2dRZEdOdTQ4cVVnU1RhZm5HMHNk?=
 =?utf-8?B?L2FMTWhpS1NrOEpQM0l1cmVFaGRpQ2pyL0t1dS9JRkhvdTBnaElTZXJxd1p0?=
 =?utf-8?B?aXBzcWVFQzFvU1VZR1lRNXJhZTFiRXY2aDlmTVUyUUJQQ0hwL2ZsNk9HenZu?=
 =?utf-8?B?NndBaW5SNE9BYVcvZ3RZQzVaVHpMOUo5Ykl6M3E1L3pKWkc0M0RIYlI5bDhE?=
 =?utf-8?B?YjVPVDZxY00yazlaWDAzL3FSYmR3RHJLL2hNaTFzS3lDYmJoSmVUY3E2b3Q1?=
 =?utf-8?B?N2cxWW5vQVBTc1h3ZDdhYmduSmtkOGZVSXJyWit3TVdacVFKZ01aLzIxeTRa?=
 =?utf-8?B?V2J4TjJ6UHN3ZzBRWG1sSkUxOGVLNUMzdnF2ZUpiTm5udTJlQVpaRmlDNTRu?=
 =?utf-8?B?UkVpeUhVTHNmVnd2d3BxcENNWnBXMUF0ZUEya2RGNmdnclo5UzRuRFJGVzdn?=
 =?utf-8?B?QkVBQy9Ba0VhbkhSa1IyMEJHUmE2SlFab0Q3MXRRNzV2OUhsajVOVXRSQUVT?=
 =?utf-8?B?eFF0bFBlTFBaM0tpcHRieTM4MWFvSytHM0ZhTlUzTjc5VURpalQ4NzlXOW5J?=
 =?utf-8?B?dkNjVjg3VXdHMHNoem9BQ3BYVllmV25WcGFWNlU1eHMxM1h2R3R0ZEJaUjdk?=
 =?utf-8?B?N0dPRWcwR2dNZ2ZnRTBDRWI4U3h5azZSUUlsQWI2aHlHQjFzbkNlRnVjZE9G?=
 =?utf-8?B?anpLYUtCcnJ1aSs5ei9iR3lha1VrUGgvOENweU1UL2VnMmRPN1pRazBWU2Nl?=
 =?utf-8?B?d3dNMksyTHltOXhnUGhiTXBmZlRWbHBENGVuOTdrRHF3dTVuNVV2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdec206-0712-4f6b-a04a-08def8cd7c5f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 23:57:37.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfVyMAnD08hJBh8YI0qdgbhVOc4BmH4Mrv+ytRMmxpuSbfRniXaHI1+XCkWvW8UBb+wAY4Corg6CywdaKFWY5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6177

On Wed Aug 12, 2026 at 10:53 PM BST, Danilo Krummrich wrote:
> (Cc: Mark)
>
> On Wed Aug 12, 2026 at 6:33 PM CEST, Miguel Ojeda wrote:
>> On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> =
wrote:
>>>
>>> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, th=
reads it
>>> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates =
configfs
>>> and rnull to use `this_module::<LocalModule>()`.
>>
>> Applied to `rust-next` -- thanks everyone!
>
> This series has a semantic conflict with both the driver-core and the drm=
-rust
> tree:
>
> @Mark: When you merge driver-core-next after rust-next (which I think is =
the
> case) then you need to include the diff in [1] into the merge.
>
> In drm-rust-next the build fails with:
>
> 	error[E0425]: cannot find type `LocalModule` in the crate root
> 	   --> rust/kernel/drm/gem/shmem.rs:628:5
> 	    |
> 	628 |     #[vtable]
> 	    |     ^^^^^^^^^ not found in the crate root
> 	    |
> 	    =3D note: this error originates in the attribute macro `vtable` (in =
Nightly builds, run with -Z macro-backtrace for more info)
>
> which is because the kunit test in rust/kernel/drm/gem/shmem.rs uses the
> #[vtable] macro.
>
> This should be fixed up with a patch on top of this series in rust-next.
>
> I came up with to potential solutions [2] and [3]. I think with the new b=
uild
> system we want [3], but I'm not entirely sure this works correctly with t=
he
> current build system in all cases (at least it did survive my tests).
>
> Alternatively, we could just open-code a dummy module as in [2] for now.
>
> [1] driver-core-next merge fixup
>
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index a4927452016e..17ca504b7f8d 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -87,7 +87,7 @@ unsafe fn register(
>          }
>
>          // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
> -        to_result(unsafe { bindings::__serdev_device_driver_register(sdr=
v.get(), module.0) })
> +        to_result(unsafe { bindings::__serdev_device_driver_register(sdr=
v.get(), module.as_ptr()) })

`module.0` shouldn't be used in the first place, it just happens to be visi=
ble
due to the unfortunate placement at crate root.

Perhaps you can update driver-core tree to use `as_ptr()`? It was already t=
here
and not newly introduced in the series.

>      }
>
>      unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
>
> [2] Open-coded dummy module
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index c04e6c5aa7e0..274924cfcc05 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -157,6 +157,15 @@
>  /// Prefix to appear before log messages printed from within the `kernel=
` crate.
>  const __LOG_PREFIX: &[u8] =3D b"rust_kernel\0";
>
> +/// Dummy module type for `#[vtable]` impl blocks within the kernel crat=
e (e.g. kunit tests).
> +struct LocalModule;
> +
> +impl ModuleMetadata for LocalModule {
> +    const NAME: &'static str::CStr =3D c"rust_kernel";
> +    // SAFETY: `try_module_get`/`module_put` handle null module pointers=
 gracefully.
> +    const THIS_MODULE: ThisModule =3D unsafe { ThisModule::from_ptr(core=
::ptr::null_mut()) };
> +}
> +
>  #[cfg(not(testlib))]
>  #[panic_handler]
>  fn panic(info: &core::panic::PanicInfo<'_>) -> ! {

IMO this is the correct way, also consistent with

https://lore.kernel.org/rust-for-linux/20260811-fix-fops-owner-v10-3-7e7177=
6f9dbe@linux.dev/

It might make sense to add this to rust-next.

Best,
Gary
