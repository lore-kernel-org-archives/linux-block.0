Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021118.outbound.protection.outlook.com [52.101.100.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F25219A8D;
	Mon, 16 Mar 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658898; cv=fail; b=pjZ1Yn8GidEzud47wCy8aZw3sjVLPQGEs8YktaMZbEAdNpNzykTVtTFzmgG2QxODidu3pRIPcUmcTz2xAQPsG7R6G8grA02w7hSme5WnHqfnr16WnTK8qp4GiF+tkcfjk6dDxHx1hfgIHNGDqvAoTK5NUrnh7t+M2DYgjt6HX1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658898; c=relaxed/simple;
	bh=+c7IzHsUxxnrXbAYA/58+g/e9PazEXYFGAd8cptHuQg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rLUB7ph0XJ4MDFnfat1SZPgSDtlNkPeVPjNGB1dipYUg7KGxWqvdjYWLFEu8eVrHNAqtZsC9PF20/ZESitKZtqySzUfU5vx8OLXLErXnXpmkfa6QLwYBCe9l6YXWL451zvQchuwxxnuDoi7jenUlp5Hg2k1Dyw556xl8ARzpnac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fGv5SBSu; arc=fail smtp.client-ip=52.101.100.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fGv5SBSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gncWwhBxZQLRoLXT+lWOgeoT+rcSUPLt0u4kcolr+UoQgynTf5ggaNUSrUCQFDw7/j2hoNmHE/o7jC256Q0tj/Wo1icY0LYPEj7K68zrS18fYNJoQadGSZDs8ZZl50+NTIYX1f9VKtzJ6e24VtOcgM5eDaKMfVz16Obrwwr+D8Wdg9MXpt8jrF+UwDQaRIHAVVdanixxkVnHumclfa2W7yc71XBUq0Lva/RPfo2ivLpRH1CMAYDKZ5JKA7i3K+xwgRZP/FRfPaLEzim5R9mcc1K+lIzC/jpRG1ME/x8cwfQmoPC3apx+O3dOBxGORT9VZrkyox1zZsF94DO6m2WSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6naU6PjPpBmlLL4oCRh+GdLpKLGpyZj2fp3dcpFbaCk=;
 b=RgLgQr6ItqQsqd66Dc3zSl9zEz2OicJZ33ALhGib3EVZvy8FEEW07rTUKG46lg8ADONqZfUKW6ifNKGDZ7kbdre7wRxAH7HW1/0bLzo2JJ1wVe5BMm3D4pJhlodYqZo8YB1DKKyX6b4adFtJzpa0d88+MVsRPuoguOBBKLcc8L7zj36QmY6G1/z9j+40LrzFn6mbHVzGKTNzD2rHVUJPJBV2xGLPAc2rrQA1DgJwH06uGt+sgDhs4teeMqTmvIHFnnyaIXxJo6vdKAb1MNhdx5PJqQNu2RCokIwqaoXFPxD5sEP6W0D5mk1I/l0SXjoKD10v1dpP9DmojEJxytwHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6naU6PjPpBmlLL4oCRh+GdLpKLGpyZj2fp3dcpFbaCk=;
 b=fGv5SBSuRy7+S6I9PDeKbcF9uv+pjpcBQpJxxiikKezVfpfeg5563wXhakl3G3ZrRQNAjH9Xu3M87qf8wQZEC/AnDzhd/K2HKcThSMfYacFKVRXcTNpCQewUSmLsffbdCzdN31OGj6c0OQDiMCYJrc7i5d7QP8REy3tn+Yo8PVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6160.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 11:01:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 11:01:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 11:01:32 +0000
Message-Id: <DH45LQQ6VRB0.16G5TLOKF3LZ0@garyguo.net>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich"
 <dakr@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Lyude Paul" <lyude@redhat.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config
 option
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
 <abfe2LbhLzXiGCkA@google.com>
In-Reply-To: <abfe2LbhLzXiGCkA@google.com>
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3806b415-46cb-42e3-5534-08de834b629f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EpMzum7myf9tXZDRGpFo3hEJjkcaJufw8vp5AQ/nF7SSazbhlSkBgovlOW7+szo3c36q8PmIWAYz8T/HwzQpAbr2Ri0uTllYrfqGXCnqvzj+mnY6Q40OG4e8AASxTpnGnFwlOSzKOybLxSfDmpR3Gs9pXwCQojECPnRpbZrpyQOYBxDMdpcF72Jh/9DDDiSclwEKqxFURCMTuI5RwLKNFVFrEV0mEOkA5vBJCPnwvxRgZWGHb6Tq0oRhtWZYzPpHtZZxAyYm57ao4B9WWbllwAhI6+Nng1K12IMJrh+CvGVkUWOUW7LRH94GWJVvTAZNMU2VYwD8B7iIM7yqaidIzPd3kQQtYCnoN2cAZRo/iYk4BFn+NYSjY505aSvqGiitEUFEVynizrLZKbg58ksmQgDqnptEGjNZu1DjRYHf+qJGEDv+6Jx9oaBy5fqJsw5XpQOKOA5yc2LaXe+bubWq44XQfKyzQfif6qrGrgZdJHEnnS0f5cSWoAYtrfnF12cAB5DNn4sHs4uxxYu9uWUKjfAH01c7JwLRGVVboXmZOtJRhY5CGrKWlIBx/q0KuAL1MRJkKx2R2nPG85Mum+YYg9Iez2+XYVUjY2GyATYgdDbbgBKMhVDqBG1UbroaScz/A+gBTS+fgGY4S2C9SOBw7ul0wCy3T1SO5saA123BNN3eslTxPkHjqh0i830gGcdzhgnNZUA8DEkhfn4HuE59Uqi1gh47bKm/deGHrXXMsAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVFsOXJwTUtFTm9wNTFTN0dyYVhNRElBR0psNnRFL281SE90VTZrQWRLSi9B?=
 =?utf-8?B?VnI2UVVQaDdwSzhCQXpDSFd0SEdFWnZKaTgwcjNQbjZSbnl5TnJSeUd5VmtW?=
 =?utf-8?B?c2ludVJPYVZWcG9JdkVUcTl1SWZHOUdyamJPMWk3MmEvcHJ6UUZDMHpNUFYz?=
 =?utf-8?B?VmdJYjhPMDlyZTVEQUVxUE5ubXVPMk9NNkZiVU5EOUlXdTR0WHFndmhOY0cr?=
 =?utf-8?B?TnBwWm4yQmF6YTZDOEZIcVRtbmtUNHRLUDZKdkhvemF0bzU0V1F4Qkt0SjNI?=
 =?utf-8?B?Vy9SM2dtWVJrVHZKQ2N6bmpTZUNBeVJBa0FwclBuZDFjcWYwOCtYUityeVlB?=
 =?utf-8?B?Q3kvS3ZNZk5reVJnVUpYR1hMdEFYVEF4M2Z2ZEN4WURPREZlUG1yUms0WUND?=
 =?utf-8?B?RmNDbkE2dnpOQURYcExDdVNMTFJDeXAyOW9xS0hrdldEbWRnZklyRVZvU1VB?=
 =?utf-8?B?QmpsQUttNWZBZEM4RkwyQlJWeFRWWlhPUWVGdGZ1VTJONFd0OFp6Z3BMdUV2?=
 =?utf-8?B?WENkTWk1NHF0SE9uQjhIbW4rRy9tb1dFN216OXVTVThabGdSVUxHa0hZTXdP?=
 =?utf-8?B?V3JZNUpOTHNWeG51bWx2OC9odlNRS3VQYmFiVWViYzhaMjlwNEw5Y2hkaDlF?=
 =?utf-8?B?VCs5bldXODJHbU9veWwzYU84NzVOQkF4a0ptbXMzZnRzYURiSmRZUkNOOEZF?=
 =?utf-8?B?bWc1T0RKbmZkb09Bd0xXYUMxWXlDWWNvZmtDbjlyTWx5U3ZKb1JOd3RPd1pw?=
 =?utf-8?B?QzZWWDYyQmJWWWpSQi9nSkFtLzhib1QxZnVka0N3R25wZXowUWlWV2Frc1RP?=
 =?utf-8?B?b2NSSm1LSk1CdXlRL0ZIbVNmbW5ubWJvbjFFR2dzcGtJbjFHc2kyMVVoVkhn?=
 =?utf-8?B?YWNjVFpEQXpzYythK1NlK0MwanNYWHl5bm9SdmpaVkRzQXlDdllDUW1wdWV3?=
 =?utf-8?B?YUNVeWxkMkdqc29ZQ1V2QUhMaGpWaXU3Q3dCL1hjOWljMW50WVd4NTFqbmh4?=
 =?utf-8?B?OWJBU0YrVWRFVVV6dXdwR2lCL3RrNUNrSGhld1QvcW9QTWc4Vks5SHEvL3NO?=
 =?utf-8?B?MWxnbC9oRUthWkt3bEx4RzEvZFdUNlIwMlo0MjNKQndXWW1HbUlsUVR0T1Rs?=
 =?utf-8?B?VnAzOVRIZE5FZ2s4aFdRbjMvT3B2cTN0UW1BSFVTVzE3czl2eEduMDg4VXNz?=
 =?utf-8?B?V2lqejA5L2YzemFvNVFYREVWOHZnSnpTZThLZEFKQW5yT2h2REx4aTFCUVRH?=
 =?utf-8?B?YUx1RGQwTVF3UVJxWWxtdk9nTHdTMlVBSjUzZ0tEQjhBcmxta0dCTE9RSTFO?=
 =?utf-8?B?NmVybU9DalArSzVwYi9rKzRKNnNRaTlRQlA0aFNZM044cEx6b05BcUtROVJL?=
 =?utf-8?B?VXlaTEhaWEJnaEZobURIaDkrRmV2UmJ4bE41b0E0allkWk51cmN5R0U5cHFY?=
 =?utf-8?B?dGlPMG9DZ1o5Q2dNMUhaQ1ZycWZmSEVTRklPSEU0RXhHTTNHK3IwZmttL1VN?=
 =?utf-8?B?TXNqOFhlZWFxMWtQOVA5L1dHbng5Y21icUxhT0xMYnZHZ3VPUURNaksvK0U0?=
 =?utf-8?B?djhhVWp5T0lhbzc3SVhyM1FsZlM4NjNBYWo2MmtlRjZodTdJWUVIMnFOL3cr?=
 =?utf-8?B?MHdWS2ZkNXRpaEt6L3BnRG1Kd1E5VENTSWMvaVluN1Ixa2NZUGtHSVMyS3ND?=
 =?utf-8?B?M2Q1Tk94cUpGN0xRMUVhWXZkUm8xc1ZldlZKK1M3T0RaL29sR0JPR3lybU82?=
 =?utf-8?B?bE5KRVdGL2VHWHFMSFZ4aXFGVm1VbDczbXBOWmRmV2YyckpGdVRGL0VvQ3hD?=
 =?utf-8?B?MHZkMWZ2THJ3VXFQZWRzVGE1dEFUb1hvTWRubnlDNC9zd2J2L00rOGxIbW9K?=
 =?utf-8?B?SGgyam9FcTlJWUl6Qk1VV2NxY1RudU9hckdnNUpGZkxWbEpLRHZRYWtDbVYx?=
 =?utf-8?B?dFFGY1BQWlJhTmxaaVpjeTJWNFhiV1l0bzlyZ01GaXgyVkFTNnpYcTJEanpp?=
 =?utf-8?B?VThSaXBBYTg3OU1MVnNWQ1N0SVZPaE45bmlJekIrenFybUIrOW9YL2gzbUNi?=
 =?utf-8?B?Wjc1ODZDTUpZYndMM1dTem9aSEJUOVR2Y3NFUG55MVNzbkI4TFR4SjRXT1dD?=
 =?utf-8?B?Nk5Za0JwMTh3cEJjVGo0MU5aZWFLMitwMnJtUXJLdUMxQVh2eUpTMzdSdDY3?=
 =?utf-8?B?ZTd4d0RVY2VwTmVjQmdCTzUyMWdOc1ViYzdTcm1GQms3RjBOQ3JId3c2VWo2?=
 =?utf-8?B?YitnWUZ5YTBQdkZraUdaaEdNVDBEVlFOUVF6cVhKT2tVYndLMzFQZlp5SXlP?=
 =?utf-8?B?RXBFSjNtUG4vNHJldEN5YitMYmdTZkRNbVRDcC91cnVlNEJqcE1wdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3806b415-46cb-42e3-5534-08de834b629f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:01:33.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufesMyiBnglGAtWrz0cqb8ufk96QeNwYbquqdxoBqLRZ1uFpDCKsurcVZZ6E3oIeZjkMVXvoRs8NBE4Mjux3IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6160

On Mon Mar 16, 2026 at 10:43 AM GMT, Alice Ryhl wrote:
> On Mon, Feb 16, 2026 at 12:35:02AM +0100, Andreas Hindborg wrote:
>> Add a configfs attribute to enable per-NUMA-node hardware contexts.
>> When enabled, the driver creates one hardware queue per NUMA node
>> instead of the default configuration.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> This and other patches make me think that module parameters should have
> value() return a copy of the value (and require Copy). For non-copy
> types, there can be a separate value_ref() method. You would avoid *so*
> many asterisks by doing that.

It's also the sensible thing to do if we're going to add modifiable
module_params in the future.

Best,
Gary

>
>> +configfs_attribute!(DeviceConfig, 8,
>> +    show: |this, page| show_field(
>> +        this.data.lock().submit_queues =3D=3D kernel::num_online_nodes(=
), page
>> +    ),
>> +    store: |this, page| store_with_power_check(this, page, |this, page|=
 {
>> +        let value =3D core::str::from_utf8(page)?
>> +            .trim()
>> +            .parse::<u8>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?
>> +            !=3D 0;
>> +
>> +        if value {
>> +            this.data.lock().submit_queues *=3D kernel::num_online_node=
s();
>> +        }
>
> kstrtobool again. Also, this is *multiplying* the existing submit_queues
> value by the number of NUMA nodes?
>
>> +        use_per_node_hctx: u8 {
>> +            default: 0,
>> +            description:
>> +        "Use per-node allocation for hardware context queues, 0-false, =
1-true. Default: 0-false",
>> +        },
>
> formatting (rustfmt ignores macros)
>
> Alice

