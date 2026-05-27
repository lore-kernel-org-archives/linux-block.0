Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022127.outbound.protection.outlook.com [52.101.101.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB3E9580;
	Wed, 27 May 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880176; cv=fail; b=qU0zXHdbgAKHkDqxGKlyljOvRfyGq9rsTiyVopoaxvJZrzsJfkj1Hj0SJtfQ8w0Z+kSvh5Pwyw86IimFUk+plAdxBrq2j4xWqfWVX880VbwgRmiOR2VLhTsjCYGM7ZgHXn6LG4hr0dg0mlFzkv+ljsv6mz4EliRpVkkvSR2+qB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880176; c=relaxed/simple;
	bh=58E1BnnckTbMvhnA39c2B7w/ZMdoLlMcA4CCxz5Wq88=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=cMlU3e1sYn1JsSBKrVcGC8GMgvCPNzH8VaxbqFKnQe0pezyWWCjTufhQ05EUW0fcVAYN8mtDXDUS0UyjtWn8/a1SZ2jf7Fd+YTP5zr7OM0kWtukZu9GKNw9h5hlLjhhB2nfKrj1J9DPppHERYwTu2TaLp48IjIqJ/EnDaV1beDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Xt8GWUef; arc=fail smtp.client-ip=52.101.101.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Xt8GWUef"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSUTp6I7Kv0xs1T4CKAFU00x/VXdy1dzMOnyPMc8fL6e7OtDuBI+RABAA3ZI73oLtPzWyOwjLLVeq21lpZUTpy1X+XR7B3Lx3zi0DorYpM1B65HpcRwMlzymV6H0B8alkiGe3mRX+mRr2l+Ce4QvUBHMa9llxUcGrlBDC1w2vLP9jfGSUJgHMvv74ToviuoJu4Opg8iKrf6SChXzh8DoSn9gC3Vho8bVBe76zMG9qgsAJy2CXdT1x1f62TdIqe628k3nXM7CEOdsS4XVCigBY03ozGJGfKz+g10DTSPKwZOt2S66VHcgGed8lrL5UXmmt/LRJYfy15nn2CvH8zJFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt3M/MMBq0gZf2kxsMdpapAnXdoKiyURmvAWheJnsUI=;
 b=EbsXuhfKPk19x7J523dX8ZAh1Do87pS+IViLv3oloLzFyF3hoF3TKSrQL6WzlPz4+Lx+nGttR2fcizR1IBKMAy4qu9/8q2YDzmTkrNfJD5Su4d/Is/5qUKHrnQfUbIAnIJMuITZ+Cei56A5tto/SjNJDbzejJIJmq5p1XDWPDGDDn3HL50PgLbjaqQsIgCr8IXB6ADvUQfmUfVzTnJkUyv3g2gX+2Cjt3TggPh1PwBnHd/uXyzxmkP/KEyoVorNyt5ddhJMLhryzbq6pP2gjTAY+LlIXEimvpFpkHo8RE8nu+bNp94iGZfkR3pq9/oVapEp4Ajwpig9tepikQnew1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt3M/MMBq0gZf2kxsMdpapAnXdoKiyURmvAWheJnsUI=;
 b=Xt8GWUef/InrM6mFEo4rnoc+O+1Aqv6Cu13TDM0fHVI8W8Ebnpm1qcF0RC9zKDkkc6v9lWXWJ/svnqqhq7j+nfGlxFHX7fDAsPkjM4PBOGFk0+STj3RL5nb5yQHDjD3s+jY7XAzIH8tDSIvSGWFLo538szH5t847TG79InMbbxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3221.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 27 May
 2026 11:09:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:09:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 12:09:30 +0100
Message-Id: <DITEV2DOK450.3R3J0EDVU6EJ5@garyguo.net>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich"
 <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, "Mateusz Nowicki"
 <mateusz.nowicki@posteo.net>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: block: mq: align init_request numa_node arg with
 C signature
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org> <DITELF5LNOB6.2IHJU3443SMVH@garyguo.net> <CAH5fLgiobJ2yCbDM56H8rzMeAWv0eaqt8-vPchU1EV3VEYb=jA@mail.gmail.com>
In-Reply-To: <CAH5fLgiobJ2yCbDM56H8rzMeAWv0eaqt8-vPchU1EV3VEYb=jA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3221:EE_
X-MS-Office365-Filtering-Correlation-Id: f51b309e-bd28-4124-d2ee-08debbe06d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|22082099003|18002099003|56012099006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	UGAN3XgXgD2kebbn/eJAAGW/bwFycPsuWQDVNOtCInu/BMPs081wQuS8XNEQo6x4sILD9o9SSV3+5NJEzBHaKKhHlYeaHq9YJj9LD/hwNXMQL4MNl1P8gz0tqH1z23XReXDvnIVej/vqsAKfodc/4iLqJMRlBuU2n6xzlymI7ZFfAEi5A9nclCBlSld4I9GGZRGofFanknQr2Ms7AHmPeR6PEtR1kbM3DIMSGHHFWG06ggF07n2SjnA/YuSuw3SWlLuNaNVMOKHaev6iUB+aWL0cXXtncKXNdjL2q0+9uphPVJTFOclwaWQo7RgkYxo4C7YDXaIyhIsNM9cz9icJ3+U0ssC7fN1ZZtQZhD5rh6gy4NzyDRuA0HXrXtKgeWhjql8/7nPZcVB5K/gEQyBYbbFr2BZV1lPHznqSnZpViIUtyHzGfKCR6tGCU/+yKGSEn3pPs/gHboC55c8UQZqKUJjUFLpSsVMco847ci8Ou8+El3lGxAJSH7u4OCtAoWaiRMQhMBPx9fVLfwbW2bhbro1IfpvFhyoHJWt6RwgqIO2cpj7jvNzv1nVoyxQP0DTO1dhKvdYmw1vu0SgnVa7bRvw2saF521t3iqio4i1GissZ6fjINhle+JgPUrT9KlSPsjQ14HnOeJHKJy/XBGibefQX/XvAnokaZWReRPpll1T7/Ejh4t9GZKYcoi0kYxJC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q003aUZpbGdGVGxnOGRwY25VMEFEeWFwYi84UUg3emVYK2tlV3YxUDdLTlhY?=
 =?utf-8?B?dUlOQitKc2lrVzE2b1QwWUkrQkkyN2JLMkpwMVVlMVkrZFluVlVUS3FBZU5R?=
 =?utf-8?B?cktKa2pLWTg0NDd4QktuS29aZk9YalJ4WUFMRjVGRVN0aXBDNWZFRTgxcGFm?=
 =?utf-8?B?ajlQMExMTnFSM2xkanJOUEFHUk42ZG0xdHI3aGJiUU1hN05yMldNODdpOG5P?=
 =?utf-8?B?L3A0eXJSN05wcmhCRmtLeU1sWXhib2JnelBWT2R4UGc5UXpRaVp2K3RnMnQx?=
 =?utf-8?B?YzRGdWFhdFJQOG5yY2lWdnNvbVFaVjVOTVFCcVR5QnlPYllJVDBkdWVRbmpJ?=
 =?utf-8?B?d1luaG1KNlRKREwvdjJ6dVdLTlJlNjdxcnVxTEFzU2N2WDFncmtad0tvRXkw?=
 =?utf-8?B?NGNuT2tHenMvc2cvZGJLSlhGcVY4ZWVWU0F0K0J4LzBDUDdsc1BCYXo2bjJB?=
 =?utf-8?B?ckhrYUFnQndzTGZJcElkVXpzTUtQR0xnTzlsaDcrd2pZdGNFVEJRdm1HbzJI?=
 =?utf-8?B?U0FmV1hBZzFHWkhXb0FjQjV5cnJNR2cyNElZcmlhLytwcnpvajZkdnlRaHFx?=
 =?utf-8?B?Y3BldEYzanBjdVJJUGgreUJTTzFCaGJXY29rRXR4cWlzcHlINTNpRE9NOTRj?=
 =?utf-8?B?eHB0dnVIeTJBbnQ0dkw1NThuZ1dtWG1LN2FVR0d0R294MDh3QytZMkFBSWtY?=
 =?utf-8?B?K0cybkVzSUQwSGJpVlhjbHJJQm4yRVh5V3EzY1RUTUsyT3RPM3lkcmJsem5k?=
 =?utf-8?B?MHNSYzl1aVZmTEJZeFU2WlpTSmFxSE9HMEhYK1pUcVBNeWhhMTQva2QxNWlX?=
 =?utf-8?B?WnJuMUJQanRaa3h3U0NRRGgyaG5GZW9HWTB6Q3VwVlJtWk94NGo3TXRsaGhm?=
 =?utf-8?B?UURZYkMyQlZlbDFzbWtBZXpNVldVdTRwSzhQLzc5dXMrRHdsY0hFMkNWRWMr?=
 =?utf-8?B?WHd6a3UvZnpySHJzTmVsbjFhLzVXY1pTSWducGpYalNzTjlsQ1h2ajcxK2Ny?=
 =?utf-8?B?cll4UjNaWS9HQnJ6TGFzRVVUU1NPZWNJM2lpNjBNbDNtVmFRRGIydlN1d05u?=
 =?utf-8?B?aXVCV0lhR2JVSnEwTHJwUW1RaDJBTzYzb2U5TFE4bjNYRG8xSmc3eGFjdFQ2?=
 =?utf-8?B?OEx6R0ZITTRUU0hxTU9WMnU4cUNwdlBsZlRleHI2Sk5qRnMxWU9adWlsUXNr?=
 =?utf-8?B?ZVMyT2tBa3EyWkVMVkladUVmMWg3YWUxYTFCL3BHZWtEUXd2WXJtZDk4Tmov?=
 =?utf-8?B?UGJrVnBMUlZsREJYQ1FlSDZwWkF1eXFrK2RDbHJxK3A4Z0pFVmVvNy9iU2tI?=
 =?utf-8?B?UjZEbldmTVRzMEd5TnZ1UzJ5dGcrRE1CT0owZ3U3Zy81NFpYZU01NWZpc0Z3?=
 =?utf-8?B?NktNRy9oM0FhL1loQ2JtK2MwdE5ER2VBTFJzR0p0ZnpXTlVIeDBkS1l1dXNj?=
 =?utf-8?B?UTR5YXBtR2pKSksrU0hTMjRxWWdpWFdGK1h6YkczK0F4TmtTNm5wQmZsb0E4?=
 =?utf-8?B?LytFTkVUcDdCWFQxUitOVUo4WVh4dUZRUE1kcnlvbFIwQWRZeHQ2Wnd4OSsw?=
 =?utf-8?B?YmdPTjR0ZEtwNnlOaCtRbTlHb0FBL042amdNdzZsdWNGc29NTHFIZmxvcHpr?=
 =?utf-8?B?SHpKY1QwQ1hMTytRYjVESlhPU1VDQVRVZzA5elJJVDNKY2tJRGZ6dkljbjVW?=
 =?utf-8?B?Z0RDcmw0c2tTQmYvTXJ2YVd5SXNJaGZmOUpzS3dzM2g5T1lxK29oZEJRMEY0?=
 =?utf-8?B?TENoSzJQc1BsVDVKOStxcmJmWThIMVVuU2NrZzFUUU1KVldBbTVRYS96ak4v?=
 =?utf-8?B?R2JjaG1sZmdYVUFVYjA1OTRLbEkvdVFBNDZjZHZZN1NndG9iWmdZTldDUnBh?=
 =?utf-8?B?YXRJMHVMK1FMQWpTOGdWdmp2TWdYbk51cy9mYlpydEUzV2VyWWpZcm5jeHo5?=
 =?utf-8?B?TEpLQkdXTDNDdmNUMldmWFZQZDhhTE9lTXpFdlVIOXladlBVdXZoTzdtWWtB?=
 =?utf-8?B?bHk5YjNxU2pnSHhORnI5czdnbmdqL1JPYWM0Vm9iSXN0SWVxSTBWQmo0WUJs?=
 =?utf-8?B?enFFNUhOYTkzU3VPNUFMaXBYaXI3Y0p6L2YvN3NLdFVwWGdRYm1MKzNhajB2?=
 =?utf-8?B?QUxMcUFRMklCVlN3UzZtNzV4TnRoSVNOWFJUZlpZRUFUSktjMTFtUVpVTjlZ?=
 =?utf-8?B?SGFEbTBVdjZkNXBzNkdGdHRQbTM0ZGdEaDBhcEVEa3BSWW5aalZadGFYQ3FO?=
 =?utf-8?B?RXBLd0ZWK3JaVVhzUWY5czNpeW83ZkRYTU55UUU1RU5EUm9CUEgwYzVMV2Ju?=
 =?utf-8?B?c3g4S1U4ZnhBQ0EyTzNkSFFscy9kdHJacWY2OHEwNmZyQWwzYlVhUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f51b309e-bd28-4124-d2ee-08debbe06d19
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:09:31.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4rSwF35MZKsI8sr1eA6JMovPEhIJYff9zzKflwKlqVmLbUSV900EGC0S7r4HpNa+SRQ3JNKTdIio3LPxeVlog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3221

On Wed May 27, 2026 at 11:59 AM BST, Alice Ryhl wrote:
> On Wed, May 27, 2026 at 12:57=E2=80=AFPM Gary Guo <gary@garyguo.net> wrot=
e:
>>
>> On Wed May 27, 2026 at 10:18 AM BST, Andreas Hindborg wrote:
>> > Commit b040a1a4523d ("block: switch numa_node to int in
>> > blk_mq_hw_ctx and init_request") changed the type of the
>> > `numa_node` argument of `blk_mq_ops::init_request` from
>> > `unsigned int` to `int`. Update the Rust callback signature to
>> > match, so that the function item can be coerced to the C fn
>> > pointer type stored in `blk_mq_ops`.
>> >
>> > Without this change the Rust block layer fails to build:
>> >
>> >   error[E0308]: mismatched types
>> >      --> rust/kernel/block/mq/operations.rs:274:28
>> >       |
>> >   274 |         init_request: Some(Self::init_request_callback),
>> >       |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >       |                       expected fn pointer, found fn item
>> >       |
>> >       =3D note: expected fn pointer
>> >                 `unsafe extern "C" fn(_, _, _, i32) -> _`
>> >                     found fn item
>> >                 `unsafe extern "C" fn(_, _, _, u32) -> _ {...}`
>> >
>> > The argument is unused on the Rust side, so this is a pure
>> > type-signature change with no functional impact.
>> >
>> > Fixes: b040a1a4523d ("block: switch numa_node to int in blk_mq_hw_ctx =
and init_request")
>> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> You could also just use `i32` instead of `ffi::c_int`. But it doesn't re=
ally
>> matter for this patch.
>
> By the way, all these constants are in the prelude.

I wonder if we should actually encourage people, by removing them from prel=
ude,
to use i32/u32 instead of c_int/c_uint, isize/usize instead of c_long/c_ulo=
ng
and similar, given all Linux ABIs have consistent mapping for them.

On a different note, perhaps it might worth adding a lint to klint to check=
 for
path references for types available via prelude for other types.

Best,
Gary
