Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020113.outbound.protection.outlook.com [52.101.195.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7544C4F8;
	Fri, 31 Jul 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516214; cv=fail; b=tMSQwELRRzKCDFQq9b7RLL01mp5Cvg4hqOBw7+4/0MweMwYEepr22BlAX1woHFWw0QSxF3A3g4Gna4krR+FEfS75Eht/bbT2vSMSmy2yRk0RFDpmrfZYgJpcY1FoGpduuen/a/xi+m+T26m28MssoMzgVF7i/a2oI7wtKkvxAcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516214; c=relaxed/simple;
	bh=RTZVsFKDzX76Y+RxbbfwyEtOlXfpmsVAiYcbFD4D6H0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=UizGL5No1AWNiJCYhtsYuOkLZXLtir9Kxa9yUGFU9SUaUaW29LV9soPoY/9QZbaWygaS9yPTAT2SNh7jg7tqxS9rH+48SS43jH5UewlWrtJ7KePQQ/TkDK5gtbG0sWDNhBf6UK1YdaPnsT4PgNEuc2GUM/Y2S9TMASQ2TsmgDfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gJJXXIGY; arc=fail smtp.client-ip=52.101.195.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gJJXXIGY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQLApDi+mQT1yFpvvMOjlH7BvqUXJLnUonZmZImqck2GG35wKg6NNfJYs6qJvX0PiXh9j1hGBJM0EncWnnA2Q6ne+HP5wDcTYuAV42eTc66wS94r4XEL0ljfH7lslTp79VVb725nK9XYe2kzhz9DvFtpfjR/j+nI8xRNdfT6krtXcFDpFujjYmpeuJ/lc07bL/G9jkVZZTLRoXX4cwLu6egkUJD1Fl2IdWquhmYCLM+sWEuC0sL3AaC+7qWG1j7jzpUdbWOs7UnMe9ZOfMpnzm/MLFU6MFhIRcA2up1UcBZ4d3O6wBonMIQA7XYFymzS6qI4IfydgP7yetvqBEm7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTZVsFKDzX76Y+RxbbfwyEtOlXfpmsVAiYcbFD4D6H0=;
 b=PDvpNG+p//lmbprIlbeINrW+RKcjIHPkPcocj4eTWBJqd6GfYaPn6PaQqMrWnfCtDr5xsQzSSI80kwTyIcdkg5wJ/8Whgh9nGG+QzYFVDXE+Jvzcmwobk1AckWdSXr7MpGBb7OctnG98yUpxLsYZVqCZNEEH8HYAQWFQfni9GMBdK6+XmX/kWkW695GGFiJ9abdBbSTO3nN3u/MGR9KRtHLP6zdqJ32jDKGRerOUsCAu4lNZOFjLrEeOTSyK7uubl2qExg8OBXSCRW+U9yS9tNrhGsURTaH26OZsZqiyZNqiTmwmO2XCFHg4T2hM/hVgUyqqR8zOJrKQzZ8qToOtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTZVsFKDzX76Y+RxbbfwyEtOlXfpmsVAiYcbFD4D6H0=;
 b=gJJXXIGYtz1EcqXX2nkYPiMtww+EhAaN0f81jFiGZwENKR6Ey4Aq7tt11TVSAxIzUjEQOR7CSCVHcnKADaDCOspUgAMvTdyUQUFz1m6ZUIzxruu5Shy4sYJ3OzBLwekIZ3+1bG++HIrICRHIz1hSqlkkF8OY+qUClOnmGY9chgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3135.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 16:43:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 16:43:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:43:27 +0100
Message-Id: <DKCWO60T6JPR.1P3AAJAATMXBI@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
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
 Llamas" <cmllamas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
X-Mailer: aerc 0.21.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
 <68c43a03-5fa0-42a8-b886-2c756e39515e@linux.dev>
In-Reply-To: <68c43a03-5fa0-42a8-b886-2c756e39515e@linux.dev>
X-ClientProxiedBy: LO4P123CA0649.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3135:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edb5aba-3891-4f9c-dc43-08deef22d90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VPgetq3G+0JvU6nUNTr/YIOS7zdRBbv3KaiQ7yJXyuFpW2xGHCuOn6oMUKE6ccFR1oAkHp9NrU0xprTRQiKgrgcfTF/MZtQfSxiu+PnqUVuPbJqyBYWwgN7WOHpKiUyzBeO1pF30eLjQIVxWgIL0/hjgzm0iqxO8n2Xa5/MQomOZhBd16rW54FBOjzEB/25yYLCy+lRl9U4m8v5tAF/U6YNeRae02+RcxDowXGQVEfwyoHVn8QQVpR+emmkV4AMFnLG4VpQ5Z5RJxNCsvufI32sQIvXq/hkWAJghfdp52R58at5E7vd+JZHhK1gznioskONop3O7lsIlmV9qW4sJGF1+LS7FB9gQK5PHJf0lT8r8LFsAFEy+Xomnu1nwKm8qAG8gxCFMF82Njv13a/AG4PLfNRf7lxc4exmGes6Wtvy6jNoSXTU9In2PDvLe+sqRCYm48SSyRYFhxkNHPo+uTIxJuQjKbRp7hHxHeOo2/5lKYoRfieuZ1Kh2naC/n1enWvhEuSSVTQk0gnFXfqftDr0098UsWgGNHRjU3abS7oKNpZhYixudZytUAP0knaHnSctScidQ3AqSAjI+YbD7XF3gRblY232T4wERRZ/0eCFcD68XOjbY+V5ME8wIFm9PjU0TAgqADLpX7SdKGyv1W+Z0RWS3sr3jmJFKlpl3giM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkppSHZiVUQ0RTYrRlJSa25UdzgyRXpnYUp4NzBibGVwNGRhOGtlSVg0U1g0?=
 =?utf-8?B?QzVqbE5MUnY2aXNkb2cvTXhFUk9iaFY0eER3L3l3OE9XRzRRWWI5bXFUWEE4?=
 =?utf-8?B?Ymg5ZVZRVkIyemJIN1ZuOFREZm5BZGdyQVlKS2NDbWdKQmdaUzRDbXMxL2dQ?=
 =?utf-8?B?SkhTa1dHRTE4OFBkZEdyL2tmamVlRUxqTzBtQTJzNjhTbGtkYVBKUzlacDZa?=
 =?utf-8?B?a242ZXczZ0RwYWFodkc5K2lOeGwxYmcvUWlHZjQ5bS9KUWpuVDQweDE3RWpq?=
 =?utf-8?B?RmdKdXQ3bHJ2OEFJYS9OVG5PNmdlYTZlT0ZOTlZGUHRHMkE2cEgxNzFUT3lk?=
 =?utf-8?B?Wm9xdTBZbEhpakQxSSs4MWxBTkRXOXVPRXNiYXJaaVVheWhlMEZyRmprNHRq?=
 =?utf-8?B?bEc1Mks5c1hYdlRzTWpPQUQ0N0toUGMxSHUybXQ0Tyswd1RTeHpMVTZTUWtx?=
 =?utf-8?B?ZHRSTU5ZaGxRMTBVWWRZN2c1eFlSWjV4VU5TQWMvVDB4UkI1U3NyeGR1QjVT?=
 =?utf-8?B?a1dBMGlFWldsMUVvMk95K1VFYW96WUZFaUFpZ2xxL20wY05iemRIdzdjcU5R?=
 =?utf-8?B?VHk5dCtEV1czSHpxdmpiL2pmbVBkVXF2NXV0WjI3MWU0SE9CelR1Wis5b1FY?=
 =?utf-8?B?VnNwYWdRdXFPcWxZSFg0ZGhzREVyMGRLNEtCQysrOGpjSnB5Y2daa2UyVE45?=
 =?utf-8?B?UmdUSis2S3A1ZkRyWUZIZGdFMUR2Q2JQdWI1aWtOZ1Vaa3hnbUxzN3Fsc0N4?=
 =?utf-8?B?a2hrSjl3QW9BYUk2VzlhdW16Y3QyWXdIZFAzeWl2aWRrQ2l1dUk0cjJxbGI2?=
 =?utf-8?B?UlF4S2ZQdmxabTNrbEJBOVV2OWpjVkdQaWF0S1Bha0xRb1dNWk81OEo0VFQv?=
 =?utf-8?B?NEtSRzhMK0FGdDhmakVDWGx0M1pKWlRzdUF4QkVzM3FIVUUzRXB4aVBiOURv?=
 =?utf-8?B?YnBzcllSWGZZVHc3cm1UN3plLzVuM0lXUG9FS0RRcHZpM2d5OWsybk8yelVP?=
 =?utf-8?B?M2tET1ovb0lhVllZWnNQREVhUnNCSEs5TXFFOTUzb3crZjdTN21OL1hRNE5N?=
 =?utf-8?B?dWpBYUxKblYxZVlxZnlvMnNOVis2UnhLWlgyZjBZb2tHTEtOaUEraS9MWnhw?=
 =?utf-8?B?elRNMUpBOUVUWk5rUWJqVitsMHVULy8rMVhzdHBpb3lhR1QrU3pZUytMZ3dR?=
 =?utf-8?B?TUhUTkJHKzVHUlFTSExOWVRPS1JnL2hHNGY3T0hTODJUOVZuMGFQSDRuQ3pS?=
 =?utf-8?B?SkljenlSTzMvUWJiR0VBYTE2RzlOVWM3M2x0Rk94Q3paSXArNlI0UVZyYjIz?=
 =?utf-8?B?R0ROdkZ0MG8yaGM5WjZ2dlZHY2EzZ0RDandXbG9UeU81bnJWYjlKNWJhcksw?=
 =?utf-8?B?enZTaWYxUjVMMHQwajJXbVNlS2swNE9FZ1dFbmtXdGZsU09IMll1NG8wN0VG?=
 =?utf-8?B?aDlMbENOd2hDVy9vbDJjM3NGT2JLSHYrSXllaEJrV3JLbUxGeEtpblVXM1Bl?=
 =?utf-8?B?Z2NwcFc0WHZBNmh2Q3Rra0xMbWQ2RzM4dGxyUDlsS3VPd21zS1pKNDlwaVhu?=
 =?utf-8?B?ZlIvWlNheUZCV1lPK1JEVFk2WUh5a1dCWkI4NFVPcDFFdXJUbFJWNmZ2ZW4v?=
 =?utf-8?B?ZllIY1hRajM0UzlyVVY5NkUyWHFqR2VWTmVHUjRzbmNVL0tpSUsxWVRPN0lW?=
 =?utf-8?B?QWZZOFYvZWtyK05yYXMwK3dhcUFvYmkwRWlTWkllaldyRjRlSSsxMlF4blAx?=
 =?utf-8?B?OW9PbXBoMHdpdkNXekJ0dDZUWHRDdHM5OEhxVlBaNUdwNWlMS05IRmdSQjhF?=
 =?utf-8?B?WGN5QWRMWTZGcnVZMDFGK1Vrd0x6bFB5dUtwTCtlY3FpTHhKWmZJaWY5aVdO?=
 =?utf-8?B?ZFcwV1c4cnhYWTVQTmR4ajhEVTAxeE5PbmxJWlh5NHV1WmhHTCtaRkE3dW5H?=
 =?utf-8?B?QzlKZ3pNK0RwU1JLZnJBYVd6d0poa1FiUTE0ZnBwaENrbHpWdHdpNFFyM0w3?=
 =?utf-8?B?cWZIZlZqaHJwZWtwUGRJZ1dKTHRURFRtTzllQXVOTEhLK2FvZGJLbHo5Z3ZY?=
 =?utf-8?B?L1pFeGlFS3pyd1RYTVAwRDFxUTJKUldjVWVtY3lzZFNMKzlQS2xJUlBoVHoy?=
 =?utf-8?B?THhLQTFxcTdIOHQ3V012cnZuZE05N3FBMjhwK0JicUZySHNnYmd6MDMyZ2lB?=
 =?utf-8?B?UDN3WlZxTFN3Y0JuTUh5ZlRWaWFKb3E4UGZxRE1icjhwRkNvbEZpdEhkUEdo?=
 =?utf-8?B?MnJMRFhpT1FVSGhWVGdITkRxYk1OTTNmME1MNGgyU2lZaWEweVZQNWdncjFj?=
 =?utf-8?Q?8Dvh6MKWHd2DBctxbs?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edb5aba-3891-4f9c-dc43-08deef22d90a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 16:43:28.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDEjAsJ1O814bAYxAl3j0kQGqmLys9mlTSk5n/moAvCGE5uZH7VYQ4ip0bVtRl9xnw0iO3jm55J7ow/o6zyb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3135

On Fri Jul 31, 2026 at 5:34 PM BST, Alvin Sun wrote:
> Hi Miguel,
>
> Thanks for taking a look!
>
> On 7/31/26 14:46, Miguel Ojeda wrote:
>> On Thu, Jul 23, 2026 at 4:11=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> =
wrote:
>>> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed
>> Was this old tag used for some reason?
>
> That was an oversight on my part - I forgot to rebase onto the latest
> tag before sending v9. The series is now based on v7.2-rc4.
>
>>
>>> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
>>> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
>>> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
>>> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
>>> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
>>> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
>>> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
>>> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701
>> Are all these actually needed? Some seem unrelated (some were already
>> applied too).
>
> The prerequisites were just some import formatting changes that the
> series depended on at the time. After rebasing onto v7.2-rc4, I was
> able to drop all of them - the rebase was clean with no conflicts.
>
> I'll send v10 shortly.

If the patch applies cleanly then there's a no need to send a new version.

Best,
Gary

>
> Best regards,
> Alvin
>
>> The only one that seems needed has Andreas' Acked-by, so
>> I guess it is fine.
>>
>> (By the way, I will use this second message to take this chance to
>> move the modules maintainers in the To: in case it helps, since I
>> didn't do it in my previous message)
>>
>> Thanks!
>>
>> Cheers,
>> Miguel


