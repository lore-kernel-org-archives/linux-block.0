Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021073.outbound.protection.outlook.com [52.101.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84E3EDAA6;
	Wed, 27 May 2026 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879422; cv=fail; b=YvJr+pnbltZEC1V37aZJz1yz9FF/geibynWSSlFXhTHwqMxvTRbHm1lulgS1KwELfwpz2beeijB2mv85Tz9jgymSlGSb9lj8Kh8xeikKzoC7EByJCMvo78inKqcoJ+MVZoggsir6+Vxjgw+Xb0WVnE/bWg8+LFhc0ThGnBXsTdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879422; c=relaxed/simple;
	bh=nywHb4SYKg7efiOYV59XtnOvaAibsJTnTjxMbHQybp0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=k9YHOzN1CbWnUA3/oNAj0GEcJBOoS0muZWyDaVgv+adUfi6lmQaBkOQ1oSD0TWPJ4gclj8cUHslnIAKaFvURUgmGUefBUNayf8+QPZD20IU8Be1SX59ayotGkB/6VSBgcKXepDPUfLnTyYhti+Wrk11sgXgyJSo5uzK+kBToRGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=r8FCIuRE; arc=fail smtp.client-ip=52.101.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="r8FCIuRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxbyC92CUhBBboSmFyQwauHLadwxaTIKD7q6RfJuIHt7qILGlsmBRH/EGrTWWBGBqjRREWTePSTEzYEvgspTU/PEyczKxWvSjjNcl0Nx249WJBb6JuzHEtUVlMCkMVrs/2ao5DMWUfW7VqhusD+w34AfRX7It3tYrEt4WxEB+tAMWmtXTw7iqjAFjxoL+NqcgfbBDQInV5dZS5LNl2U4yU5imHjhMXJ+LitkfAqniZHE7s/0uz2ArPgE2TuIUv8RAZSM4DNMa60VMtk/hjiEpwvSzH1QRJw0ul06CsRzjzDxhBj4iyZbAMtp7Zt77chkyOLmX7xu77cPyhqjeE6HJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga/TZsLslF6CE4byFBk9WcsXC7rouUcp54hbAxTALVU=;
 b=hK5Nz+pnGSBq9SY66Shf9bJkzauNS9z3hBYItCIF566jlKA41BmHeBHUsJVBDjpsUp6Pod/bEjoqRaU7IjvC1XnYLktZa3jbkK0QgDnpKk/qJFKCLOSE30wrVKVB6JYEGdb4/UlvgABcvjuRn9JF0uMrqqH5WUkrrtjp2K6jQ+CqShPk3yWFP67QYRo7DTf/jOTj+gMv1ATL1owjPqiiRo19TVPGMIHJ3Qf9pSIrKcaco4h/t/wN/oJoLZaTDg0DSoH6MYYas/6P5zS+sc9FI96aQphSyXhS1b9ZmOPKmKqpXEaDP+tLRPYufiotZx5LxUqTuGOJUGOhz3SvJ23Vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga/TZsLslF6CE4byFBk9WcsXC7rouUcp54hbAxTALVU=;
 b=r8FCIuRECilAJJC4/EtjOAeBLsD8y+7DVSBUUJ8vg6rHhpVr5oQwBznMYDrNX4Mj58MaUN1xvvngPsEOYCA2EOnxZCzobwviz63/3F8CDVXaftUkVP5vDnI6XTqLOuvcFD6U7sjhSBADAlgVvuZJlDKFYyRQpXm//QvANUJ0vew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5068.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:56:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:56:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 11:56:54 +0100
Message-Id: <DITELF5LNOB6.2IHJU3443SMVH@garyguo.net>
Cc: "Mateusz Nowicki" <mateusz.nowicki@posteo.net>,
 <linux-block@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: block: mq: align init_request numa_node arg with
 C signature
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>
X-Mailer: aerc 0.21.0
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
In-Reply-To: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: c431b08a-8cb3-43b1-6f8c-08debbdeaa9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vdBO9hL1I4NHc5wvAtqHeRmbdOlYmC+yY/NFbwG1sPxdfvWHnNrksA8GFurE8pJ7b/2A//BryFqeL0BXBuImgIXQEhuBy/JKjXovg1qQpPvJa8ZHSCZkTdCyhf6M+0nm9S2pN/nyFQM4J+Ax8XBSz+ZlEsMHgJoD0mCU9b3nUAcMZztCzGm8u37DXuckztAyUZoJVo2E9H0EUjMiIlJHZjAwjBYRTCKg6PJkhKLj/6LeWEGIydqtiaUba779yiKsTLvYPwv0KSKgEBy2KG/BWh2pfUjxx9MkvK3FDsG8RwpzDiG7GA2vDciVLkfRrHsiUHFaXryZOsZyClPO4j+RYREAFy3EVbhl8wfZLiRRF/ydOBqRu7DlLuAhpju2CI5GyCnexF/bWcC9k6winlabbFnTQLr+gt3bv4ojG+wS6Ot48Zf6vS/499r0MwKMppoJUwyHis8tVQZzSYGevBlIaPSuJG5wp5QviClNRWzYeQgz87oOctx1a2Jw/x6BmW0XrifdG5bqbpOu93e8IROCiiHZtYPUhoY5keLBUib/XrTLISi0dnyx4rSIsxF77QH+2insQeulF2vvxNYjj8tWn/NlHmBWxHC9UgYKS5e9NTwfwQbR5Pmp/tlqWhfTGo335B52OyUB1Cb7rxnZLh5f+ZBmwk8zid9BWdMijITzuqwc7RxDzLFMePo1K7komlQBuWVui+RbgqcmwaXaX2WQq2/n0KNk/PXTFtT7H2f9oDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkVWNmZHcDd2SHBDNGYvcVhmU1ZnQTVmajRKbWhoYWxWQTVHaEZNUUltbks5?=
 =?utf-8?B?cmZtRldTM2pGcDFPUGpJc2V4M0dmMnBwME5IdHI2cEtDeHExUXY1TkVMLzYz?=
 =?utf-8?B?bkVaT2xwOGNxL2VqejM0ZGc4MU96RmlzTkdWUW9tM3krKzNvQjBDV0gvVHF5?=
 =?utf-8?B?cml1Q2lmVEpTZU1IUTZYTUFNelJ3V2VGNlcram9ML0l5Ui9pbnNTeCthUDA0?=
 =?utf-8?B?eGRzUktFSjdjd1kxSC9HSXpEeXFPTi85aUo4L09qTDEycUxXKzRveWFaTHcy?=
 =?utf-8?B?MFlWK2cvOWw3WTdQa0RNZWluRzIzUXpMdlVhUCtvbE1OVGpGS1FUenlJK3U2?=
 =?utf-8?B?djR3dS82OU9ySXBxT01IdGJkSHUyQUwvUFZtc29hSVg5V25mVm5rSGtUWDhX?=
 =?utf-8?B?SGNnRThlem5JS0UyK0t4RnAxcVZCZExHbVg5allNRWZ4bnRXREtzcnlBOS91?=
 =?utf-8?B?WUhiTHp6V29VYi80V0Y3dU5mdkZ5VUhKTVY3UDJWOWtxckRlZ0FPYVk4b3E5?=
 =?utf-8?B?NnQ4VUhlZU4yVXpjZjdoNnNZMFB3eU1POHJ4dGFlWDdXUktsU2N6VzUwR1Z2?=
 =?utf-8?B?UGdoVXc2SmxFanp5emNtTnhrajhwSnpKc1g4S3dhNHRHelZIanoyaUNXZDNx?=
 =?utf-8?B?aHZ2cnVGeWZMZ2Fwb3U4b25RQ0ZLU0cxRkxWQmFFZmhsS0wzUDRoeEZWL1k0?=
 =?utf-8?B?U1QzcWFETllTV1VmR1p1ZzNTSG5kaEFpdkUrNWRKNkhKcmZNVEhGQUg5bmo1?=
 =?utf-8?B?OVdia0J0VTcyWkZlQWVIUlI4LzFBdjJJWC90RHBUdUlpdzRGcWR0QjdtVml5?=
 =?utf-8?B?L2UvY2h2a2F3WmxDTWVmQmVNWnNiaUxFNmxHOG5Pc3YxMC8rajQ1WmRZUkc1?=
 =?utf-8?B?ZDZxekNpbkdXYW9xdWRZOGVUUklQem5BTUdsWS9DR241SW4vZW1KOWlnQ3N0?=
 =?utf-8?B?OC91TnNRemdUUGp6Q2dmU2FmckVqNWNFSmI4d3VQVmU5SFAzdlRQb0VIOE9T?=
 =?utf-8?B?K09lZ2RkeWNnZkdvY2hBYjd5QnVjTjAya0daYXVhTGx1QTNrWjVNRVlnNERW?=
 =?utf-8?B?NjFjTTMzN1YzTVlZRGNiZE5oQmNZdXo5RjF3S3Y3ODlHYWFKSnZ4b1gzeXBW?=
 =?utf-8?B?V3p6TWZRelF4UFdWeGNiMzgrTjdnMjIrTXRlU3lyOGJBOU1SNzJoemM4UXRF?=
 =?utf-8?B?N1BBZmhwWC84ZFF2azZLWkVkaU93czBOYmp2UFVGVE5IL011SS9qNy80QWhV?=
 =?utf-8?B?WXNBRUV3OGlYT1FUUXRLTWdJQmhTQzJRZTN0MVovaVoyc0ovN0ZsN1FnNGo5?=
 =?utf-8?B?UHdTbDk5YTRWaElsQ1pTdEdtSU5jVTFka1h2RHNNQlB1ZUNvdnZkWFo0L2Zq?=
 =?utf-8?B?MTYzWDFxRzFSeVVnN3FHcGUrKzdHTVZVOXYwMVdkTzIvU05hamFBV0gydzl0?=
 =?utf-8?B?M1FMWERoNVRIYnlSRlZ5TWNtdFAzWHZHQ1FRc0ZLSERBOVdFVEJnNnMvSis2?=
 =?utf-8?B?aTJhRjNHVWZvS2JQSFRFaWp5NHBTcjlzRTZiamJXV3hOYjlwcU4vRUJNWklh?=
 =?utf-8?B?Zmx1TnUvWUJoMjhBaEs4U1RVQ0lZMHVFNmRLdnNyRHByZ2pTeGJZeUlVVktE?=
 =?utf-8?B?UzNFODk1QnVtY293emhVOVk0dGU2d3JHcWk2OWFCbkdrc1BsZ25kZTlMQVk5?=
 =?utf-8?B?U3lQM0RzMWFkbDlvRFRiaTVnUTZtTy9OMDRpY1dvd1JMUmVmNFF3OS9KWlI3?=
 =?utf-8?B?ZS9na2hKMTdyakIxNGlYbytqc2Eybk5uZEgrZGtVZlVpeitRVGZzTmNncUds?=
 =?utf-8?B?cUgyd1JTeGNENm5RTk1jdjgxa1JKb0lPTEhpWVE2ZnNQbkEvT0d4YTlCbm5y?=
 =?utf-8?B?UVd6NXVSWENCWEx2Rlo1VUtkYUYyOXkvS2xKNUJnTzMyZHJIWC9ZbzBiNlFY?=
 =?utf-8?B?b1hKZ1RzdDV4YWhsUXkxSjhVYnVRWDRUVXB2OENXVWErUlV6SHU1YnNRbEts?=
 =?utf-8?B?cTlVMzluaE9ZbVdFQUVSNnJ5ZVpCOWNYQTE1NnNscnhNOXlHUU0xNmEzbk5U?=
 =?utf-8?B?b2V3MkxISy9iNDhPVTNjeWN1Q3o1MWhmdkp6WEZ1Zlo3a3FyS3FSSU5zMnRp?=
 =?utf-8?B?NGprVTI5a1pxdzFYaDhTL1FqVllLRWIzZmt0ZTRhOVFTN1dpZmsxL2k2VlJC?=
 =?utf-8?B?d3JRTXBCdDNwWkJkbGRZRG95d3J6ZHlRU3UyL05Mc2JBSnV2eW15TjBXRjl6?=
 =?utf-8?B?NDhkenRkK1EyUFpQUlcxVVBiWEx1L2JJWUJrL0l3NDJ0M2VPWDVoSmxBMHFZ?=
 =?utf-8?B?NkZOQ0hOUCttZUN4eGs3NWw5UjcxTWhuRGZFT3hYNXpWeldJSFRpUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c431b08a-8cb3-43b1-6f8c-08debbdeaa9c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:56:55.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUt/RqErn/LDNp9cF86TZ2vRIi13uuOa8ff2uzab1IMAKO/iYEjZJNC7mTcmrTh5Lut82QKgXtrkbgwcCMHWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5068

On Wed May 27, 2026 at 10:18 AM BST, Andreas Hindborg wrote:
> Commit b040a1a4523d ("block: switch numa_node to int in
> blk_mq_hw_ctx and init_request") changed the type of the
> `numa_node` argument of `blk_mq_ops::init_request` from
> `unsigned int` to `int`. Update the Rust callback signature to
> match, so that the function item can be coerced to the C fn
> pointer type stored in `blk_mq_ops`.
>=20
> Without this change the Rust block layer fails to build:
>=20
>   error[E0308]: mismatched types
>      --> rust/kernel/block/mq/operations.rs:274:28
>       |
>   274 |         init_request: Some(Self::init_request_callback),
>       |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>       |                       expected fn pointer, found fn item
>       |
>       =3D note: expected fn pointer
>                 `unsafe extern "C" fn(_, _, _, i32) -> _`
>                     found fn item
>                 `unsafe extern "C" fn(_, _, _, u32) -> _ {...}`
>=20
> The argument is unused on the Rust side, so this is a pure
> type-signature change with no functional impact.
>=20
> Fixes: b040a1a4523d ("block: switch numa_node to int in blk_mq_hw_ctx and=
 init_request")
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

You could also just use `i32` instead of `ffi::c_int`. But it doesn't reall=
y
matter for this patch.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/block/mq/operations.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

