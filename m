Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F47DF8F;
	Wed,  3 Jun 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496506; cv=fail; b=gDYBq2RCaLsz1/qTGyuwVdExQTV1hVf4xATFqKWKaFby+dkTMTeLwiH8IzDoPnF3+vjOpKmAQNPeG0gatstm6dlGWw7JDtpJ7Bp2wd6RJyZ5i62HEffj5uImBMju//P7QSyZ6xKWcWADa694y/jKNRNBsJ7s0YlitF856BPKQ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496506; c=relaxed/simple;
	bh=atrShOJ+8G5tNpaacFOHSZa1r9XwTN4lkrWkfmRF+iU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ktxGVgEKMZS8arDgsy3/IT6ExnBpZHlSiXEnevoxz6MsL3FqUJsJdOwIvwtiS0zpjALP9KboveRLmWbMqM6GSgZB5KgWM1ms00/EoiCXAeSYqg7hsJtHFq+tezXGr8OExkxQr8Ky+PyEIb8mCUigxN/xd6bh41JTUXS7KQqu0tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=P2R0u9Jq; arc=fail smtp.client-ip=52.101.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="P2R0u9Jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG7B7NjzDyaBLZbrgN7QvAhOGTGsMybAclv/smTQ3/BXEkkISH5DqkfKMOmyUi75MSAZV6FZ+MQppYOBCQrNVPsJ6AVGTcPOSmrvxbtJ3O0SHxAkIqXFUSdUCGwcgnS+7HzdIU/5AMbzufMJTgm2ofkVnKXY0o5bxzXW0kKwNJRUBz/CZhkEPibmeieUQorm0IpK9FSZMbHzIINCoqr+F9x4Ai96YGXcjd+4tyKSXAClYOU+k5j0j36jQY2Ok6c5jlLa223jLHTJfDYSofmBtEIXeqvVaoUMiAC2fCN5Mbvbltpz+jZ7RAeWG8FHoAlW/pf+XTarNha8H8aQ+RkR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbkX2DddI80b4Ml3hfrMZN67jaFvSfHwDGWmdajJXdE=;
 b=F56CHW/FZLbNtta/J43yCnZuYhIlHdLNvsZpqY8wSx4TEJCxEs5s1r2c68g7y969Hfoa32dG7ZIVBzxmayHvycySqmWsDMWrtw6Vo3MIBKtmq21GkdnTmp8ihRLoIPBCE3lsfblteYFvwmgTIka49ine5D8QUk436rScbgdr6YUrLQtbRTPBsk0yyC2noFgPJ3d8B/We16fmKJJDIl/KcKSNd3hN5meg/vkWzITAVIA1tCendzIMH0SSmPs3QYZFce84QTOTo/GfO36ZAx3C6lt95h/WLvxwQCq9YLHevWMyzfILK9AI5XlvZKIx2NIhadZvUrTwRE4lLIKIVwbVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbkX2DddI80b4Ml3hfrMZN67jaFvSfHwDGWmdajJXdE=;
 b=P2R0u9JqtIcHrDmydDaNzGByzX3cUhJtbPN3yRStVoxxpWSsZba7ZTd1RZhcZ8Iqjr7cEBlV381cXTA/TGi6pqApb3jG9o2wQ7d3wWYkDXdfW1mcRDIsmog8AAdSDSxegWxV6X6EklZcIydSMVMsv1zHYQLUOuWEvqjWRzu0qbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3032.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:21:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:21:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 15:21:36 +0100
Message-Id: <DIZHBYPMK0L9.3PHF5KXR33QDL@garyguo.net>
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
Subject: Re: [PATCH 10/79] block: rust: add `command` getter to `Request`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-10-de9a7af4b469@kernel.org>
 <abfbuJVbPtIEyweC@google.com>
 <87mrxbkfme.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87mrxbkfme.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: DU7P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::28) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3032:EE_
X-MS-Office365-Filtering-Correlation-Id: 990b1bfe-48b6-49e5-cfb8-08dec17b6d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iYQuLw/mlmeVHuzv2AkaToVNTg0x9OwoxHHE7doObCf3HSJoHCa8+v+cHrhVMn5WqKr1LT+DAd0Obz2pC9FcYoe5wkGgX161lS1BvzhpInKgnhRFlSKj+1vxMWvMjnRIWbdYVVGT3O2+dLoaGZeK/3mJlO3jccd6gT+18Z26xKzQK/DO4EfFZbX5DzENf7RuLKknPoAj206v8m9iky6+1e46OoEmLbN4tH63R8ynbCj8g+fnoN7VUYU92GKhyRa66HwoPU2h+XEB6xQKQJg3h0vpL9JyP2QLMiI/61rqanRTDTSrZCzxQwVDiIf7BN9TsweA3pBMgj9MAJAIk44QsuO5DXb/MLzUIQPPM8JvaznkkxyhuCS0pG9vPPaaT1vkGUoa3EpJ7EQkemlvEWMdQWHDjRYIR7EwQNcKHH+rUAHJ13g0voMb1Tc1QbTgn5ruMtYNT+C2cvVGCc1OcBmxWGJI9rl6GaV8zB7bXfNh/G+6jrOxP3OLsuvNqh+9nzjMVfpN+aYp6qoahDw6Gm5sg5u3k9jbVjws1PwterNE0kRgKUlzXyStyzUaN/wGmQ9xw7qGn5HRt7W+6Ubus61VpoZ8pRcwf3uf+stsaGUgM3FRY9Ut4RMWoswgWcygIyCIV67TaqzPxWlNt7CI46nd2Kkgkwq5Nbui1fqvBy6SY1GSP6CmjgIQoCKGayPRtx0v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V204TFFSVFllbVg5a214OG9hV1QxNTdFTkE3OXJ1NmRJcWxINmorTU55TGEr?=
 =?utf-8?B?Y0EwSktKZGxzR1JxWDFRcy9YZ1lhbGRKdE5RR3VXU3NKWjUzMFBDTXVaS2FO?=
 =?utf-8?B?MHc1SjcwK3pEN2RrcGVPOFBMWTlnb0hXZFc2WmZWVm1WK1p6cXZEcmhMWEJF?=
 =?utf-8?B?MW44cS9GYnhQVjczR3ZYR0d5L092YnhpRklhTy9lZ1VOVkZKZzJFQ0dNMWVO?=
 =?utf-8?B?WmI4dE00U0UyWU93b0ZDNE1jWjZMRCt0L005OXFQTGZENUdiM2NhYTZ3YXZ5?=
 =?utf-8?B?MjBTQUx1ZU9JWHNybkZ2Tml0eFBiWDZ5dzhJUHVWQnVLck5Yams0ODMzRnFy?=
 =?utf-8?B?dEZrUEpFQTd3RGdSd1JvcEc2bVBxUENyV2VVYzh6dDhiWG1lWms1Nm1vS1li?=
 =?utf-8?B?dE45NnVKMW9EVWg1VWxMbUo1QkZnKzllUTg0MkFMWW45K2c0V2pJanFXeGp4?=
 =?utf-8?B?Y3I2SVFIdFNzTmpMU3MvUUJBRE4vS2NoU3JSOGhNWFZVYlg0cEJVQzRoU0Vn?=
 =?utf-8?B?TkU1UkRNTVJJclZoQWpUeGdsT1dFK21iNHc2SW02RjQrdVo5QzN1ajhpQVBh?=
 =?utf-8?B?S1l5c1gwdTFLcWlBNllnTDRMeVI1WGY1ZjlOdFZwREhtUjNHODFEdWx5QkdH?=
 =?utf-8?B?eDBWSjFYMUxWSHBqR0JwNmU0RnNlMTNiOVZoVTlacHlOeEh2SVd2SkY3RXNt?=
 =?utf-8?B?WjhQczVCc1VoTU5jWGNyNUZMTkRNNGZqMmdoeUNTejM2cnZCNFNvL2preVRQ?=
 =?utf-8?B?ZTdnL0xQQ2JiV29ockE0YUk4OVo2d0dyL1dudk9zMHZtc0Y4YXdidW5zclNi?=
 =?utf-8?B?UG1oN1lqWUowUG9hUVZPUzZwZml2Y1pONlMrbEh3Skw5bTBWZERzeElNbXNE?=
 =?utf-8?B?VlNxa0hWbldwZWdYMTZKKzJTNVN3VEFoZnhtN0UxTmNZUTI2ZExnRzVMREdQ?=
 =?utf-8?B?VDJ4VW9FdEpKK2p5bVFpOXNzMzF1bVVrVkhWZVhSWnMyaFcvWWU1aVh5VUVw?=
 =?utf-8?B?RCtDNk5uUFZuamtjK3RZeFloc0lFU3R6WXE0cWdLQktCWE9MVnRHdDlOOW9I?=
 =?utf-8?B?a0NON0NVN3M4YVpPN25LZ3U5K2pXYWNaS2RsK293WXhzZ2xEYjl0cXFQVjZ1?=
 =?utf-8?B?K0s3MFlEQ2NXanNuWnZXUk01ZUFDVzBPeXpCdmpkbEhXTFc0Wm5kWG52ZmdE?=
 =?utf-8?B?VlNydjliWHY0RkI0NlRmSkw5UTQwTUNmVTQ0VkRTVU5mT2djUDM1aXBGRmlE?=
 =?utf-8?B?bXlXTU11bVZza3ZhQ1JEMWhDT1FhaThENHVsVU94Q0EyZ0RCUlNZTlNIdlRt?=
 =?utf-8?B?RXJhY3FPYWNKNU5pRFZaQ2xoTGluYXBHWjl6YWcxazhhYUZtOEg0enNPd0Ja?=
 =?utf-8?B?ZlFYK1NXd1M1YTVQSlNpRm1hNnk2RHU0RXRPdnhnTUgxWFpPTGlHTWxWU3dD?=
 =?utf-8?B?YW9BcE9EVktEYUNtdUM3bU40dmdHdGEveVlzNjFrVzM4Z3o3MWJxb0xOdnZi?=
 =?utf-8?B?akp1d21NR2l2YVY2SVFUZzFGa3p1YkFwK0VNQVNQVXVpYnl6K21lZEp3SHZu?=
 =?utf-8?B?YnUrZFRYTGZBa0VOZUQvem5lRWNoV1NCSk1mcElxWVVmcW5YQVdmQXQyYnU4?=
 =?utf-8?B?SGY4MXAyWGd3UmlkaDM1a05vVE4rUDhsa1M0aFp5KzhFWkpZZFVsVzBvZGlS?=
 =?utf-8?B?d09GeWN1cWNkV0w2V3V0TWVLMjFUSTVScG1nc1lnNEl3aEdFZURwU2VVbHRa?=
 =?utf-8?B?L0h4V2QwYUdVdGxHZ051Q0FrRlNMVWhGeTduRDlMNy9Ob05jNjROZUNSOUVM?=
 =?utf-8?B?dVJrTTAwblRweGQzcWdKY2ZMYlFnUzgxb3JXL3RkVXRrRWFtWnFlZmNaM2tr?=
 =?utf-8?B?alNFRCt6aDNQUUxLZWhIbVYvRE5yQlpsT2ZBWktHdTJyYURkTm8rWGIrZVlL?=
 =?utf-8?B?NTB6dnpSekR0WEdDVitDTWg0Q2E3UUtOc05xTXdpWDFlZVR6Rk05QUFIekwy?=
 =?utf-8?B?bncrNnI2T1pXYjYvS0Q3ZUJ3VVljQ29jS0QzcjdhcTAxZ0loYUl1a0swQWlB?=
 =?utf-8?B?YmtxUHNLRDV6V0dZZXF5Y1ZyQUxiNmxKeXBhYmpROXJ4RG50UmpIdElYV3hL?=
 =?utf-8?B?WmxUSnFiMERVRlZaQjBIVGJIUFNYdGN1QVF4bE9Bd3Y5Z2hmUC9MME5TNXpv?=
 =?utf-8?B?UHJDL09lVzMxZHhtUDk2UUYzckxaamF6MHlwRXNydGgvVW44ajJTLzFuYWtU?=
 =?utf-8?B?R2piMjIyV2tveUFEOWpDRHVhcElwN2lJaUxLS0diWUpwQXZRcDdGVWtWQ2hY?=
 =?utf-8?Q?4AT2EN/CFV1+kZWYHT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 990b1bfe-48b6-49e5-cfb8-08dec17b6d37
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:21:39.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBIcQEgSja4d3nXqGlJfpQa6Wwv+uU6dPg3Iz/DzlR0wdS+zz09Ilg7eBEBoKMQAOJkYullqzbzUhvo4qRhcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3032

On Wed Jun 3, 2026 at 12:50 PM BST, Andreas Hindborg wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
>
>> On Mon, Feb 16, 2026 at 12:34:57AM +0100, Andreas Hindborg wrote:
>>> Add a method to extract the command operation code from a request. The
>>> command is obtained by masking the lower bits of `cmd_flags` as defined=
 by
>>> `REQ_OP_BITS`. This allows Rust block drivers to determine the type of
>>> operation being requested.
>>>=20
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> With the nit below fixed:
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>
>>>  rust/kernel/block/mq/request.rs | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>=20
>>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/req=
uest.rs
>>> index b49197a0c66d7..0dd329ae93dfc 100644
>>> --- a/rust/kernel/block/mq/request.rs
>>> +++ b/rust/kernel/block/mq/request.rs
>>> @@ -78,6 +78,12 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut binding=
s::request) -> ARef<Self> {
>>>          unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
>>>      }
>>> =20
>>> +    /// Get the command identifier for the request
>>> +    pub fn command(&self) -> u32 {
>>> +        // SAFETY: By C API contract and type invariant, `cmd_flags` i=
s valid for read
>>> +        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_B=
ITS) - 1) }
>>
>> Nit: scope of unsafe
>>
>> 	unsafe { (*self.0.get()).cmd_flags } & ((1 << bindings::REQ_OP_BITS) - =
1)
>
> The `&` is parsed as reference operator with this change. But we can do
> this:
>
>         use core::ops::BitAnd;
>         // SAFETY: By C API contract and type invariant, `cmd_flags` is v=
alid for read
>         unsafe { (*self.0.get()).cmd_flags }.bitand((1u32 << bindings::RE=
Q_OP_BITS) - 1)

Wrapping the unsafe block in a parenthesis should do the trick.

Best,
Gary


