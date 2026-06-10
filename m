Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB413E3160;
	Wed, 10 Jun 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085706; cv=fail; b=uJjj4XmhM2/b45W8GLJuBaX9Z6w+4KtCEHKCzpu3YomkPMQhtILlFVnoxvGEorM0vWD9pufwNMAKfrDV9STUBL5TmBM8N3I3K/gxCpRQ+Rc2lUR2TLvFabMqOgss7xtLkJ3DKw5sDKKi3Flmh8KWNhLqb9278o2GtkFS+SmaPEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085706; c=relaxed/simple;
	bh=j7UvAGBi219CMEC85y1l9fA4fnMjl8zIQFQOttnZzAE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=kM9R3UYN7rTh+uMvJ8o4vUCGlbiDYqcqXgRhq2qQpnEnERlIRlz7+XsGjLgzly4U0OK2YSwSulpvZOYzrleoapw8gexs3mWo7sGmosYi1s8pivV3OJ9/35LO2SOdz6Sa8zh4rOA7uhM3mAjSoZ/z51tXPHvAH+mRbAnlGkU2ruI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QPg0S1Wa; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QPg0S1Wa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ppr7L/M9k4m8SHU0qlsd/Tm1W3OY115YenI6VK//wCspC8sPyJcYlYBsxXNMTOgw0KxBO/TJAlLpJ4DV4k8t80SzRP3KKljmehV5hnXApgVJdhIRYkoskCxPRCbs9CRrln/RNxWP9EULg7mg2l0YiL0/Xemx0nsvKRyqS88UW3nKlVG1l88lVYemB83LAt0no1TJemO6d3AAxahrl0LtvXZCXoHR45pJxPxw/y7irwsbfwiSSBywy1mNrzLBsSo2s2xTGKULb1k6AYDarXRlSU0mXhWk2ruWdJPUX4RGj16S1SEBVbDUEan60Shjz/7r3NSXQLUbvF9B/lrT1sC7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlovoGxT4K79/1svAsg2n3oEulV3goL7MKrGtn1USFM=;
 b=ASvt4Tfa7tGxBEubEekjpbdDz0Ud/LTJuolkIOjNvCFg1JMhx93xPZGLCoPIVLpEIzaO3OlW5taYKHufTHtBmV2PIbOIA9FhlN6Tq/BNLBERQkeDZJNlhdx8TBhlUdn6I9If5nd0tHBRRC5/FpnfdSVA6jhYZSS7AO/H1zYA4yRk5lmIGsLX1CMze8FODEKGEGUODV7IoT9P4qh35bPX1zTVXAYSaTwtjHs3t5gCsK2iV9Ug19jzanzJH/dQzIv43qtr+KzDSZ7ofQBtBlA2No6AsnXYHpwhAXKJDR6D48XfGQ4x30cjhRA/XbCa4w3Bejfd5ssHn/1MCrcgsWfBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlovoGxT4K79/1svAsg2n3oEulV3goL7MKrGtn1USFM=;
 b=QPg0S1Wa2hfRHnij1O+3V475dGa7I5Lf+zSgbVJ03PycwXmvKPwIJAMCyuEzMtWLVbojKnuz1GezzTLAoKBb0dL+8oMdrp3+tQClbKILYroLT9vBRq+p3HIsYxzNvV3t92CZvxSgLHCypc5qE1hqOylKpOb9zKr1fnvyCo4V28I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO3P265MB1770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 10 Jun
 2026 10:01:42 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:01:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:01:41 +0100
Message-Id: <DJ5A6ROZH40P.2XTTI8JI3H4QC@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, "Daniel
 Almeida" <daniel.almeida@collabora.com>
Cc: <linux-block@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: block: require `Sync` for `Operations::QueueData`
X-Mailer: aerc 0.21.0
References: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
In-Reply-To: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO3P265MB1770:EE_
X-MS-Office365-Filtering-Correlation-Id: 91066cce-a432-4d93-caf9-08dec6d745b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|7416014|6133799003|921020|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2ubaIY9k+SW9vOdJTrAH5dU6gGNJlR8SgGw6RNGrAw8+yO2i2VsDvMW//tY4FUisfYsA3WvDzrRMp621Sxt6YS460H9FoD+1LJSZjlwzOw6YnDbaeDzbEe91uip9Wq4UGicr5dytlg/IT9gMZxTdPomrBXek5mjY9WzfJ56TWraoE6OAESCk9JK8lKG/1OhW8KSexf8Q7///JL1Tn8WOYy27Cu3kB+NtFaRvKX7gKoEiTEF0kgvJtxaJ5RXDZSOp0opDYv9PyAnIeARpNen4vX0x8+8kE5J9cnNL3OPKJGkcqm+o2WNi54H8JPvfHn+9MxpDX7NjsS/DTt1dqmf5zPqtBqY91JYaFrRIl1rtBV2PCDjGlSYmsL1zdp9D5R13VGxSUJd/CAUMMfSvxzvX7N9J8+7aRh2NfsGyiwCX9lb+sP+Rj3JJ9ppA/h5F61CEJAr/puNih2AY7Xc+JP+2qpak0dn5QP9TRBgAVWJ/RFuNo81/gmlJHDI+7ctBD3tESETBWQ6QT4C2c2JsXareu3T56+pYUoj1JWZ9MwYqdwfUrb8ZkHbWCp1q06RiRwzmXOkf/k/ROrlDxy17b73BhUvPW7QKTAiMkxJUdRSbZ9wBj196vwAOOLs3ez+vIWTVSdp0/nEisi5n9kaq+94aX29ntp6rm21bf+OVTMSMGQE8XQvNcUQRSOclbyEwgzMm24OmtsKcyMQ6o780QksS87GKrMu9fUbfTF9y/WXgImM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(921020)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJ0L3B5ZDhxZnZmYkR0Tmx2YlVsYkQyMksxRDdrekJDR0x6OUtvZlpTUDVQ?=
 =?utf-8?B?aU9EMXJ2VlAyM1pRVHlJb0xkakNwMzhXdHh3eUUvUEExakFwd1NYNlAxSTNa?=
 =?utf-8?B?dUVqRjFUeVF4TTRGSks0WUdCUkhtekUvL2NjQmpoUnhnb3Q4ejZqMGM5TG1l?=
 =?utf-8?B?bGpYRmY5b01HeVE3d0lRZzBXS0hEVlN1UzJzUnZDMlEwQU50ZjREYkZCblpE?=
 =?utf-8?B?OXJLS2NlMnMzM2hLU2l5dmMwNHE1cUpZWFh4T2N4SXBoalk1V1dpWXd1bDF5?=
 =?utf-8?B?T2lzZ1ZxeHdVajRPcFpRZ3MxMm1HVmZ2UW1TNDZSVkF0V1FFZVA1VEQrZlRI?=
 =?utf-8?B?aUJyUS83ZlNYeGszajNxbFhKZzVybnUvNU05L1NnRXIxOUZ6WlluZFY2RHFr?=
 =?utf-8?B?cGd4OWEwMVZKOEh2eVRNMlVvSW95WkJ3aGs4MDNYQjA4UEo0REJyN1lJSWNP?=
 =?utf-8?B?V0ZzaUFVN0I5NDUzTHhxQnk1aHB2b2hRK09JWnJzZlphYm1xK1QyQkowMmtj?=
 =?utf-8?B?S2R5Wi85N2hmRWpWdkV0dU1WRUN2V2g1RkZ0YW9OZGdjVUNGeDRpUklHUWNr?=
 =?utf-8?B?T0tIOW5nZVJoL1pWTTBpR2N5UFJVNWZsMkRHOUdyNVVBT0pKYU5pZzE2NUpk?=
 =?utf-8?B?Z3dKWnVYUVpYRFFsK3haNXlnSEhZQWg3OHhid1h2ZCtVY3BwQ2lyLzU4WFI4?=
 =?utf-8?B?QStaY29TYnZ2d25ydSthek04NTF1K0dPMHI1RWNweVM0emlNMFFkT01zVFQw?=
 =?utf-8?B?Tm92ZUtBTjJNWlNRUGgxM1lNMjgrWnZyTFNBM3k2NzFrK3FIUHdlNEF5YTU0?=
 =?utf-8?B?aytZRy8xS1NDSHhkdzg5d1ZnQ0Y3VDQvMDFPQXVOZEdmN2xxb3RVdGI2N2Jj?=
 =?utf-8?B?L3NSdFd1b2dwWEloODBxbG5UVytWNzJGRGhUVzR5ckxpWTNHY0xxL1BwNnZV?=
 =?utf-8?B?SS8zQ2M5MzNWbis5MG9rSjJ0d3Q1RjZDOTNGaE5sdks3bDZPeVpYeE5lUVdE?=
 =?utf-8?B?WUUweWlnRnZ5dEowUEVVZHlrTlB1MGxISSt2THVxeUR3ZXlIVWxYSTEwb3ph?=
 =?utf-8?B?ak9idEFscWRhQjM0T0p0bzBPMFF0ZThkdENNekN6ZytOZENmeDVCOUhhV1VW?=
 =?utf-8?B?NUE3a09rdzBqNmd2YlR5cVlaU2dZRXJNeHhRcVU4M1BSbTJFTHZtQzZ0cjVE?=
 =?utf-8?B?WjgyUS9PcHZyTENKNTNXV3JRN2hJZVF2WGh4eWdodlFvOEFiUlB4MisxM3pL?=
 =?utf-8?B?VlJ3Y0cxeDhubzF6QUJpUk5YSWE1aGNrRmM1VzI0REZmKzl5ZHdHOVhiWVRa?=
 =?utf-8?B?VFUwMWpURXJkWDFkbXJqMXZQQjZXZlJVVUJJbG15NlI3dVVwQjU1VGhtVEkw?=
 =?utf-8?B?citlT0ZPVXdITkJoNFdiUTBKVGtQNm5VdFppNHNyNTRrYndYNWNCUDc2MUhV?=
 =?utf-8?B?d2xuWGxzbkU2OHV0bDVIYjV5WjE1K3dHN0JCcTNReHhFVGhaenl4NFh2U1BI?=
 =?utf-8?B?bnlPNldLZEE3L2Z5eExneXI1d21CQzVrSG0wZlNQVGM2NytBUUl5N3ljc2FG?=
 =?utf-8?B?bHp0bmRwRFlvYmJqZ1JwT09Gb0ROaG5VY3psaXQ3bjkrdmdVWDhqUlFaY200?=
 =?utf-8?B?ZDdWdzFvYm5FZmlwaXo4YmpEODZSYkZRV1dDeENZdTZpeCthWDVOSWR4SkNE?=
 =?utf-8?B?LzljTUE3cW82dkNyODJIZFRBcy9sWWJDZWd4ZlVGbXdlSko5THc2bThyOFpp?=
 =?utf-8?B?UzZEY3BwR2NuMWRsYThHcTV0UXBGU2hSeUF2a20zVlVwemdJM1J2MlZZenh4?=
 =?utf-8?B?OW80RjFqTHVvMW83eXVxQmI2ME1kd2ZrTjRDMmFzQ1NTYXpFVjdIUFlUVDdS?=
 =?utf-8?B?UnR4cUVCajc5V1pnV3FsbWtvSUh3OXQ2N3JrR2FzbWM1WFdGMzlmeE40WXlk?=
 =?utf-8?B?MzNrZnJDSmJyYzZVZnFUTENtVHIzL0dyWm1UTWd2WWlHS01pQk5uMVZhenlW?=
 =?utf-8?B?bDJWaU1uM3JvVUk4ZzdLcEw3OTFNang5UHAzOHlKaDZKSzZHK2paK0dmUkNq?=
 =?utf-8?B?aEJjZlI2WTdaNnJ0YngzWUN4ajVBakgwU3Q0aGtXQmtLKzZZS0V6aERFZ2h0?=
 =?utf-8?B?RExJYm5OU3N6V1NqMmNLN1NGL2VSMGxwcW9UcHFSVmgxWjlxWE1tTmU3b2tV?=
 =?utf-8?B?WkRreVZDa24yUEg3OGR2Z2VFOTRFMzlOSjY4a0htZUtPS1Z5RnRjNXBrQUpU?=
 =?utf-8?B?cjBlb2VwUVd0djhEZjl5QmNkdUFNZDhsS2hUbnl5cGlBSHVWbEdtOU51dnVp?=
 =?utf-8?B?d2oxSnhGYVpJbFJUSjU4ZjFBR2NkWCtnYi9ZTUZ4V2NUTUtEdDBrUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 91066cce-a432-4d93-caf9-08dec6d745b1
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:01:42.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmAX7YwyqcRkKBb+C7c5EJQLbXnb/ghvktI3WsipCiaEk9u7ohLmOtAThX1kemd6NWQ/I3I9ROKI0R7C9p0nhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1770

On Mon Jun 8, 2026 at 9:24 AM BST, Andreas Hindborg wrote:
> The queue data installed in a `GenDisk` is stored in the request queue an=
d
> handed back to the driver as a shared borrow through the `queue_rq` and
> `commit_rqs` callbacks. Both callbacks obtain that borrow via
> `ForeignOwnable::borrow` and may execute concurrently on several CPUs,
> since the block layer runs one hardware queue per CPU. That means a share=
d
> reference to the same queue data can be live on multiple threads at once,
> which is only sound when the referent is `Sync`.
>=20
> The initial `GenDisk` private data support omitted this bound, so a
> driver could install a non-`Sync` type as queue data and then access
> it concurrently from multiple CPUs without synchronization. Add a
> `Sync` bound to the `QueueData` associated type to rule that out.
>=20
> Fixes: 90d952fac8ac ("rust: block: add `GenDisk` private data support")
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/block/mq/operations.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

