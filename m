Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B031E850;
	Wed, 27 May 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890771; cv=fail; b=WUeJKE5Nxd4rzGTU/7g+sPqRWioYFCXwgE1hJkI/1K/8QBjWfVQAJwCBNRa+J111EhU99DzjzY/XPMK3uH2N1JKO49yN8tiEUQOa4JOO3zXKJ+l9pzGdrWmvugUmYB6BkXoPaMZJ92ZKhkQgSK2VstoDKzbRihwWd32kc3vAq/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890771; c=relaxed/simple;
	bh=96+P1XO1QsZ4Y7tXTTvfVawhebqo2PJ5lhDpG+3mpG0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mIfJkio842naiCttj72xySxBG+vw1MEAwXv6BRyNXsxetsEFwksCz1AkoUtHZ2pRBqix4rKY1aBhTj4C8txjq2yrRuIHcSIivqTYhbBMYBQMK+2i6tF773oS6wmktkvF9ebeFXjBGDxI1moEyFGtebojEYbAaILBQFWi7/wpfQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SqcIJDhJ; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SqcIJDhJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2QK52RCeW64EKmvvwEjOoJ0fdANdKVGjYWev957Yl+JaMCyjHcQEBtmtIDFSVJMYIfFGQFPxBAT36WeZ6WzrfeMUZZ1DYUCLEfZ/4vD+g0l+fSkLg/RppEB9b+IFB1OCK23aISEY5+79nsguwXfHI6kfepvxZiA0fce74ghshV5wNpFD8HXJNpsPR7xCcOSKpfYSOO+uBaJwHggLcZdsi9eLlO6T5KWM0cYn0Dp/uHHwESJNQqnKKnYHVvKKeSzOO0PePQsKwQ870ezG44W6aVSigUsNM1i4zQSEcbOmiigPxLXpHT8C0rEEdTbLekTcUkOVOXLGLZjYDQOyy511w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96+P1XO1QsZ4Y7tXTTvfVawhebqo2PJ5lhDpG+3mpG0=;
 b=m6XF67jH8q1Y8eeeLTqVeBZH8r9RTciI9jJ6Na2QVytQcAQQqvVwpB+jmwk3wEoCwiNsxYU5TEKM99XPNVbi9Vkh0E2Av20osryGC3SF6XKyKV1bHbMaezPYapSCC5rEs2eAIVvXuIWLVOGy8W6xVlTyYKebNPiHXgpGHlf+PZXcnOWj//Mn7808hlfPcbCE/7ROFcYuYrheWdNGX6FwGL6cUJMq1IlA3//6q6nY1EPv16PA/QxEZUmvNsKlDczmvKEBK5hi1LlrTbK2At2u4p0YXfUeqIi/30o8EfxU72V0I3NjlYjhl6Wc2Bgg5bOaqKLJIoTOWP790P4CvmnDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96+P1XO1QsZ4Y7tXTTvfVawhebqo2PJ5lhDpG+3mpG0=;
 b=SqcIJDhJwaVNAkx6yyCAiZA1hmi+rosKTn8wUUhlPoiGbyWgqnkGYs5l5nYndb4R0krx77rhKCG6x7mOuzfticqX4Ue2Sy7cJYK3M884oSwIxc2ocgZKsoMlCK8kRKd9hEolUqFn693ceXZeWOgHrsS6UDAAFw5WHrpzWsC7TpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6448.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 14:06:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 14:06:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 15:06:02 +0100
Message-Id: <DITIM8BWEI5V.3U448M44PZPI3@garyguo.net>
Cc: "Boqun Feng" <boqun@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 <linux-block@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: block: mq: align init_request numa_node arg with
 C signature
From: "Gary Guo" <gary@garyguo.net>
To: <mateusz.nowicki@posteo.net>, "Andreas Hindborg" <a.hindborg@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org> <1552076fb3201e5e47ead0989e793472@posteo.net>
In-Reply-To: <1552076fb3201e5e47ead0989e793472@posteo.net>
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbd41cd-85e0-485a-2e0e-08debbf91680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nBagA9+B0Po6OGnQbwZ3RUA2I6jpGS6Rw5jYbynlOm//d/Eo0Q1ByKo2DYSsR/AFw6/jwjJW3exGSUkH6FaBcGySqlRTh6tA4B0ndTdDeH4bTbrUG1z398YVoYmW/RXzkyi2ruCTlxriFOaNRCnfZQOJqSbqSfDshXbsYXA05r/dTMU+8/XppYLTVxHZamxHQpiFvSH7uzObOvCJOU4hycJkuNsCHo2go+8myaiAv3nROuNXwEtSi2LHKbvaqnF3OILtHWoxERiZjc41E/QzGEDGxbhLTekzZNg7RRdWvqgmo2d3ur92ah5jE22HzMmWj26q0U7b/KBe2a4zCgneToO09xQN9VNq2yW5t3GXsvWRicHs5aGllaX5shWSDG7s1NG3+x8vp5jrSB8F6M+mqQQDLxXOoLrTKWj0HatXvJdcvHB8tNS3UwbDwmYG7ncp/sNBVS8VUK0BCF3jR8qiBtStn9G09zmW/ihOHwwlhS10584qBALdVeIiVHbIL4ZcjXhtRL8M3ojXuqGN1q5onHyQYT5tWOKbzH2+o4El0F7t23kwzaFLrZ01v9xkRKY8pFEiwGWHJH5TYSdf7USeZIUt4njB8iNODmKpEej+UzLwbZQCoVAFsjGGzyjSgeZ5IIZKLOhSfXI3eZInqXJ7hpVk+5/lX/beo/+qbWoESAOLR8dX2E1KBS52azrdtElm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGtneHVzQmJEWFBZZUdFUWpKcUlWeWMwK0hqN3VOalpRZUw0RWoxMkl6S1pa?=
 =?utf-8?B?Q1lJSmtoTUFaMWxOaGRweSs1WjhKVlFqVXhiMGw3dFZwQkRqRFJFUTRlaldI?=
 =?utf-8?B?OTlZV2RwTXVvWTVBUVg5T0tMN3BKWis4Z204c3FlcjM4dnBabGp2ZXlrZEpT?=
 =?utf-8?B?SHNrelIvSW51RUg0NkVVRlptNURndzVSQnQ1UldKWW90aTNaNFBiNmVoaFd6?=
 =?utf-8?B?citYTkJCT3VGYkUwY3k2MHFuY2hqUFg4RFUxT1JWWVRXNzVKaTJTQUdXYjU0?=
 =?utf-8?B?a3FlWlY4b0ZrUzFTNWxtUFFQOWc3SVpsaWxEdXkrZG9nRkF3NVBndmZlM3Rr?=
 =?utf-8?B?Q0w3YUtHQWJSUm9TaGhLVGFkR3lxMVhCTWwraVRZc1FhaDE5cU1BVDIvbERM?=
 =?utf-8?B?dVdrdTRHMGloMXZLbGVpTVE5R3ZqSkE5ZXczUEtEM3hMc3JUaEZId08wSlhz?=
 =?utf-8?B?cmoxTE94REgvWktVVk1nbXZnSysxeWQ1T1RZalU2MzFHb2JyYlhwLzA5WTND?=
 =?utf-8?B?QWlKaVc2YWxJMUtHSHIvKzk5TkM2NWVPUzJwcmsvVS83K0cyZlhQaUc5M2t4?=
 =?utf-8?B?eWZKM1dCUWNTTEM1elFyNkRndEJuZjE1OUVkMWE2TkRoVDFjUEdVcHdMZHVF?=
 =?utf-8?B?TmZTSS9WYm5UeXc1a2hiM0I4VUw3ZlJ1R0gvd3hHK3d2VW9jb2VKckRQRUdP?=
 =?utf-8?B?WjZZQTBTc2ZpMG55Ui9sZGwrVU53QlVPd05iNC9yb0UyeC8zYllQbGdaWlBs?=
 =?utf-8?B?bWVJR2gzV012dlVrbjlSQlJUaHRobk02LzFVVWRxQ2kxblFPSVV1V1FkK0o1?=
 =?utf-8?B?RDZUd0VMTXc5WFM2VFpOR2JXZGdZcGo3NE9FYW9rclBZV0JZWXYxbmpFRVh3?=
 =?utf-8?B?RlF0cTBlOTFhN0NEMG9EWnZLa29QbjJReFU5THIvQWdiTUQwblJ0L3kxOGdp?=
 =?utf-8?B?UXNUZXhhM2VUSHp1S3NJS3lxWnNTMTVYM0gxNVVScE1TbUNkYnRDSFVmSGli?=
 =?utf-8?B?T05MSE5IMEQvM1NsbVNvSkwzSFY3S2FydjhHY2VzLzk0S2tCcWsyYWVCamlx?=
 =?utf-8?B?VDBnbG9tZzJmOWlqbVg5dnRPZklVYWhYcmdnaHFHWThFS28xbzhwd1ZQK1FW?=
 =?utf-8?B?VkVjNW5GYThUSXRYeVdzZyt0emxNNDVFQk41NHhZOW9aKzFaLy9DU2JVSCtH?=
 =?utf-8?B?QWc4YmVPeXZDQXpqY1cyeUlaWjk5aGM3TkpWc0FoQmEvSThVQzQ0NExUSHkv?=
 =?utf-8?B?Z1YyQzRZZlpjU2htc2U2QmZnSy9iSmN0T0NFMFUvWUEvTVVCUmoweE12OXlp?=
 =?utf-8?B?cDlEYm44amw1TnBJRTM1Zy9MTUdabHNCK0puakgzalBHRWdNRkhpQzU2MzVB?=
 =?utf-8?B?eU1lRFBqZm9HcElJM05RSkFyUFJQMkJ4dThwWnBJMDc5eURERzIvMXFyWDNZ?=
 =?utf-8?B?amN1cmxoR0pCd0szWXZRYW14K1p3bkpNcEZpQ2ZLSkFCcWc0YU9JQVZqRkRN?=
 =?utf-8?B?amtSeGIyQ0tRaG9kcURiWEN1TnVQQ2p0dEo2M0Z0YnppVXZ4dlp4MFNWR3Z1?=
 =?utf-8?B?anh1NU1uUkljUkJDV3B0WmdRSTN1dnc4Nk10U2lyeVNqRkJxSUpYSzNhdzJY?=
 =?utf-8?B?M1ZocEM5OCtKTDdab00yWll3Vml2VEJnTStKcFRQZEpCbTdza1lwWFZmZTli?=
 =?utf-8?B?QTVpTHQ2bjR1T3g1bDFXSDc2VnlIMVN3VjlmY2RteDVmQUMvdlRHL2VCZUlY?=
 =?utf-8?B?TUx6RzRGSjFpaDJCZXRoTnhGUkpBRVBkQ2lXZnRScjRlMjhVZWx3bjhhQU1Q?=
 =?utf-8?B?elcvR3duSER5OGE2eDlVUWFvU3JQNWhDdU9LMWhDVW56aDlKaWFxaUFwQ0lG?=
 =?utf-8?B?R3ZKditDVUxYanRqU3phTS9WcmxHTTg0SHRHSnRDaFBraVAza2xnV2twbXd4?=
 =?utf-8?B?eW10TG9aRWNnR3pGTWhUbXVrcC9oR1Zyb1FDeXJwR1M3b3o1Q3ZoVjBGYjlt?=
 =?utf-8?B?Z2tPUWw0WXlGdUl1Y29FajlMa1o0RklrSzBmdE8yNURTT2dNb3JjRlJwOVVI?=
 =?utf-8?B?b3BMN2FVZ2taWmRJVTFyY29YdXFaTktuWEdqVXg0UnZ2TnN6OGV1UEREeXFW?=
 =?utf-8?B?K09PMXFWNWwyV1Q4c05UdXFKWnpsUE1CU1lWNzdNMk5BN3BPdlRWVHY3b3c2?=
 =?utf-8?B?bHBUNEFYS05PL3hpcDMxdFRVSmdFRnFzc3NaZUk2dnU4dVkvY1dxamFSWmVE?=
 =?utf-8?B?UURpYWVVcHVQYk16dlZwYzVCdFM1MDMvMSs5SFM3SU5pUlpFbUFDOEc4VWlu?=
 =?utf-8?B?bnR6VG9xZkN2OC9ZN2tvRkR1QU4zYTRiai9NWnNsQTYxeGI2dy95Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbd41cd-85e0-485a-2e0e-08debbf91680
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:06:03.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sc9m626qESVKrtkj19R2eQfCo/to0OT7mXT1Xl9ITpijbi4zkNRZFUVje4hTIJ/5Tyf4OqdycBsHy+vi6v8qaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6448

On Wed May 27, 2026 at 12:57 PM BST, mateusz.nowicki wrote:
> Hello Andreas,
>
> how can I catch it earlier in the future? I verified patch correctness=20
> with compiling 'allyesconfig' but
> I didn't catch rust issue.

Currently allyesconfig will skip Rust if you don't have a suitable version =
of
Rust compiler installed.

There's discussions on getting it changed:
https://lore.kernel.org/rust-for-linux/20260521-evolve-to-crab-v2-1-c18e0e9=
8fc54@chaosmail.tech/

Best,
Gary
