Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022127.outbound.protection.outlook.com [52.101.96.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5DC3B38B1;
	Wed, 10 Jun 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085920; cv=fail; b=nwzPALXRv9TLxdJRPB59sdHC/T4+62LFa224kKNpl8yyaLJcrXYaVXh87gwbsLhiJW3cotSMu47/MY8QQ9rsOJHtd4wBIyDK+EZxRm6D2BLZDMS+mZC99OnW+T0AtjEFsCifPFAzEZt4rTWU4Y11SUI/zJotvv9hL2BJBfPFqD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085920; c=relaxed/simple;
	bh=UFQewHq5mlSL56iCqTa80HbfM81FX2zZOV2EE++8jCk=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=bAdTM5jrPpNtOkEYgfN8iFEI7LX4rPhM9KLGJEr5ndXEGQlzq/ZGNACMBsNeHoJXgLy/h+UpILxWqVW3n2WLOiEstHzXLQBVtXVBNtncHRqs7rZIX8rfhgXkw0yprrbd8EeePMwTBGxiPcR2GTWNzNtTuiwTKEXuMtp9yQ7hctg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=D5Cu97KW; arc=fail smtp.client-ip=52.101.96.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="D5Cu97KW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwvYXPfA4POVtLr1YHmQaVO6u9E233QSccS/Wq6x9/WBGZo75Goxg4t/PDH/eQVVD5DGk7ZeM87umD8/2lZY9XdphUdO3AFCGS5DcByZDSPfidMvluITOEhiR8Yy77KvDdnZhx/3hz7kyBhiGGqzc0z0tlVoQLFWgZkwQHK/Cqt+Hw003vA0Ak/EdphS4TH6k4E/sNlVpWS5WRx9YFBLP4okbAjEYZ2PnEhgk37SqyUs7YFtKox1Mcq3YUDkCzz76zJT7iJueBkxwNYycCKN9m+Pe6IhTS/YYamHYlXI+cNmdNJige5gY0fF83261UyCArYOhL533zqRC2SytebQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2CWoqiFmbItD0F1Tj9nl0cQN5zzqVyhMRqKqzmahtg=;
 b=O0W/Bg97JlBSaxvq/HJPvoz/PDm/icvNKgkZv3Zhx0FLlocRRyVFnoIffk/+1pcwNMhQ7rypQINDI217hVwUtY5neZw7Rth1hv66EkRzJeAbYVB6OZscBRr0aBe4dceXGAPg5JGnOAhge6F41BkO5/1iFxBVPtXOuss6gJnb183Nc4Ej2oDuf/opGSHa/x5p+SlxEADT++jRwNF2BYSz3dyAw9wMbL+qlynn2nKLxWDuFH1OpOzukHLuEWhI2Hy4qpjEknPZHyfEIcUGHU38PcWmoUfKGPZi4AFSR5ra7i4EX+TlbC54WTXIARJTgDkwA/1zrKaABmIvTnP1+dEv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2CWoqiFmbItD0F1Tj9nl0cQN5zzqVyhMRqKqzmahtg=;
 b=D5Cu97KWqGudIEsRQZBx3CsnDXzsYzqSsXdPz2Mbi0IoG6lz+2bbGvKxmx52DbiZBOBbrflyll1WT9LOEt700w6wSNQMxiKSCmaI0/CGmLL7SuhfsYtxO0ZTFSIFfzaJvm/1Q+F8wi0qWbxz16IeMm7Orl4+MQqKfYdCTEtt9qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB2675.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:05:15 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:05:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:05:14 +0100
Message-Id: <DJ5A9HIJ43EJ.2K3SCFI7UR3NF@garyguo.net>
Subject: Re: [PATCH v2] rust: add procedural macro for declaring configfs
 attributes
From: "Gary Guo" <gary@garyguo.net>
To: "Malte Wechter" <maltewechter@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Breno Leitao"
 <leitao@debian.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260603-configfs-syn-v2-1-cb58489c2647@gmail.com>
 <DIZHKJSZXQ4Z.6SPXJVGDV9ZW@garyguo.net>
 <f6a513e8-227f-4b22-bd4d-81d88536eff1@gmail.com>
In-Reply-To: <f6a513e8-227f-4b22-bd4d-81d88536eff1@gmail.com>
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB2675:EE_
X-MS-Office365-Filtering-Correlation-Id: 13568f67-3b64-45d4-bf26-08dec6d7c4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|921020|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Qi1I2699ItLtFzbmgMKziJfDE7YwSqJaf7IUmd+bJShH957goQiRQ/7LlgaTHotzphs+HNDgvtkGrGlf842jQh3kzvOX9tazrarj2EFPJBSeaKpfYBdZDTdS9S7/MoGz7m7crwr2DkVLugONjGaICWPi9eTztP2kCsZ371SvBkvSTieA1VGQtaltYb9KLLeWammF2ad1EQfDFt0Id2sGFct43zKKiGH01VmXGo1rIQAiwzH3rC68IVdtVL6S+mWVuJicKmOIlYzwNly+sNx17TQb6iFbkSwa/J3hhqN1adKOIOleVQ1GbSVvxJ3rpyzRYTzdq9ajzu4o/ItY4KquREGQ6FTfUycy5sgn3O5evw5O055Jtbc+Rw8gF9vPBOAdPCM57gDhtCnxhYXxfRTMR4hhADaUtxvg8sazq7C4+VowPeUDVP4LM8WIpce2tVi4nhK1Z2G9z8oAQo5Ky7jrp9v8Fv76llj8y+CrOjzyKNz1PTgEgBo/tqlN03bg4p/4J/xKtgQa/PSskJHC2GSZ/HdOitux7dzJ2qAo/29DPav+8Y0XDs+flwawnl2c2IT0k8P7oMwkCJPQ/8+2ggNNsp4N5E7m0Yb/TCAPsHOdZD0VukJLnwCNns9Rk4KhX138BDI/OMgHHiwCU2Bv2MhFv8hW8CVvw1Q3QvGAKm0dX2+mI5n70i21ZtUCCjUIoMfdcslL3oZnqOxlWp6kEfdOSm+8zq7STDnoKDZ+ynka+Ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(921020)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTBIQ0ZZUi9OSThHVW1QZW01c2dEQjg4blN2U0ovcGV6dFMyN0E4TDVDbGNH?=
 =?utf-8?B?dktWczlkZktHNmR2YlFCRkloQnV5T0dPRU9BNkVvdVRwY25sYk0vLzZuUUll?=
 =?utf-8?B?Q0h5MXJWY3NHSTQyL1Z4ekJjRWk2bkVnMW44ekpmT1A1WUtlbVF1dHpIb3pR?=
 =?utf-8?B?SEh3WEQ2Y2VhUUdCUTBWOFNTRkdJc3VUcVhGOEMyUldrRHdQNWFvRnQzaGgx?=
 =?utf-8?B?Q0tSTkNPV2FBMHRZWnR0Y20zNkdQSlNNQzlzZmtFWUF1VVZDNEo4ZS9DNDZI?=
 =?utf-8?B?NUtiK2hJTSttNW0vSHg2b2s3QWU5OFlQdTA5TXRqbjYrSy9FNXc2SjQ5NmFq?=
 =?utf-8?B?aDZucDhTRVpud0dTbXo1ckpyRGZtRzcvRkYxTEFuZzY2R3hFWjdmVFNWdUMw?=
 =?utf-8?B?UGVMcDByZjRJOVVKc1lZNWlIWE9saGM0K3dvbVV3NkpnaStBT0s2Q1NmWXow?=
 =?utf-8?B?d3ZQbTl0M3U3cWNUZXZSQ2FsUFcvcytWTEhSWW9HOFg4TVp1V3B3d1V0Yko4?=
 =?utf-8?B?R1hWK1p5aUQxOTJGWHVXTnlmZktibEN5QkV5dUlwZWd5aVpIbzAyZlBlRXNM?=
 =?utf-8?B?aHd6dklGbFZ4NHA4VExqeUVPL0hvWkxwOFN5N1VIYnJwME5wZ25jNE1McnU3?=
 =?utf-8?B?UjllTHk4YWJaYjV4L0pSZDlnRnNJdGV4ZDZoOXVmMnNaeFNmUjlJN1ZlaXhX?=
 =?utf-8?B?UHFQbGNZRUNkaWNmNkZNakZEdjNxd0lLcGNHeHd5S1kwVFBieXJzbGowR0ov?=
 =?utf-8?B?ZDhsVUdqK1daRzZBb0JRMFRPK0RvVTJHS3lLaWhFdGp6OEl2RDV0UUxiNXVN?=
 =?utf-8?B?T0xNdW5JWGd2aUdhUmtta0J5VVVrOERoRGg4SExBUDdtblRabG13K1RYcnV2?=
 =?utf-8?B?Q29lTTc4a1h1Zzl3R1pZTVNtc3llMHZ2L0ZMbGVKR0VXdzFUeTRIUGtmNHA5?=
 =?utf-8?B?dk8vaVM0eVAwQjhyMjQzMy81eUFYT3NSdjFaTTNXUnIzNjNjZlllQmtRdlhW?=
 =?utf-8?B?NGlGOEFpMUg0ZlBpWFRVYXhqekJaQlZ2TkMveDc0OFV6KzlvcC9KaVJrc2pI?=
 =?utf-8?B?YzRTakdZV1BsbmtkNk0wNzlFM3VaUG9ONThJT2pHT0xHdjBocy8wTTl0NEFa?=
 =?utf-8?B?VWJhMW1KbzV5em5OUWZ1bHEySnEzVFgzWmM2MnE2bUZ2RzVvcm5CMmoxTExs?=
 =?utf-8?B?MS9mTG5TM04zZDcxTUlxTStnUFQ4ZzhNSm9qMnhjTG9nZ3M0VzBzb2J4QlVJ?=
 =?utf-8?B?c1crQnk0Y1JwTTVQOHJxMFFhUlNpK1FaWk41VUp4M0cvWHhIZjZIZnFxRGRX?=
 =?utf-8?B?RGZQbWtwRnQ1QlFiSjROK05Vb3Y0V29oajVMSTRrUmNLOXFtZExyRnJ5eDFC?=
 =?utf-8?B?NEVlbEk4azJzSE4wKzBUaGJPWXMzcWJmUlhiTElNcnE0Q0lrUkV1dFhvemZJ?=
 =?utf-8?B?bFk3Y1c3TlVIdlVYV0NEMDdWTjR4MHFrektkOUlnNHcxakQ2emJOSVRUZWFB?=
 =?utf-8?B?ODVLRTdiM1Bvd3dCRy9LOThKRmRoM3IzU2k2Vi9ENlVpU2dscm14TEtBWXg1?=
 =?utf-8?B?ZWdGbHlWcnpIWkMvWHdNeVl1Zk8vcmVHWmVWL3RqaWNNM3d2VHFSRVRpSTBs?=
 =?utf-8?B?MGlOdW5NVnQ4QThIRWNlV1BmMXFROE45bzBiM1F2bitGNW9jai8wWThZRHZS?=
 =?utf-8?B?R09UMW1BdlptZ1Q2MEo3TU1pSHBnSC8xYWw0aUFCb3dEdWM0ZHpvSnVpa21Q?=
 =?utf-8?B?eGJBdUhnUlRZNERjQ1Rpblh1V1pMNDZld3VIUjFiV1QxTDFBUnlWd3JqQlYy?=
 =?utf-8?B?N3A0S3dGNG5HdzJzbFlvaDJscmp4b0VjK2RCMUUxUHNCeElhMnBMRDdVbVRN?=
 =?utf-8?B?aVlyU2xNZmoyb3NZZTQ4aXNwdW5ScWl5MDVMMVRuZ2J3RnpiQXMyMXc5Rm5U?=
 =?utf-8?B?anB2alhhWlcyZ0FjeERSZXpVdWc2aml5d0dVaVM2a1ZIVlJlTGZsSWxEUDRl?=
 =?utf-8?B?c2IrRGQrTjgzejhPYTVkZXR2eWVjWU1WTHJNRWxNOUJkSjNCOHBsU3NLQmxH?=
 =?utf-8?B?M0lPdWhrVCtSVmZzb2VjY05JVjdjeUpkQmRtU2NNQnZhUkxvQ01wdjRVOFRi?=
 =?utf-8?B?V2hINFVRZ005a0xHQXZwRHdEaVhYa2dORTlBdmlYZjFiemxpZGw2ZGtDRGhI?=
 =?utf-8?B?UEREQlU5U1gwdTRrd3NRcU9lb0c0MDh4LzZ1Q3VVVFhDMGtHUDhaR205cFV5?=
 =?utf-8?B?ZVNzeU5Md2Q5QnZWSms0cVRMa05QMTlaZlp1cWRWWk9teUpmcEpMVVA5QUpy?=
 =?utf-8?B?QkYvNXRnM2JLaDRPSVJMYjVwZ3U5d3J3d3FOSDVXY3EzMnhBM05Ndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 13568f67-3b64-45d4-bf26-08dec6d7c4a1
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:05:15.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPzQRJief4QMeAM27imvsM5mP3YTJW3R5u9Aq60uWGfYK4unPFtm/cyKXTqTTAWXQ1F5YMdtRXHNUdsvGW5GUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2675

On Wed Jun 10, 2026 at 10:15 AM BST, Malte Wechter wrote:
>>> +
>>> +        Ok(ConfigfsAttrs {
>>> +            container,
>>> +            data,
>>> +            child,
>>> +            attributes,
>>> +        })
>>> +    }
>>> +}
>>> +
>>> +fn make_static_ident<T: ToTokens>(ty: &T, suffix: &str) -> syn::Ident =
{
>>> +    let raw_id =3D quote! { #ty }.to_string();
>>> +
>>> +    // Sanitizing syn::Type::Path, this is safe since it is
>>> +    // only used as the identifier.
>>> +    let normalized =3D raw_id
>>> +        .split("::")
>>> +        .map(|s| String::from(s.trim()))
>>> +        .reduce(|a, b| format!("{a}_{b}"))
>>> +        .expect("Cannot be empty")
>>> +        .to_uppercase()
>>> +        .replace(|c: char| !c.is_alphanumeric(), "_");
>>> +
>>> +    Ident::new(&format!("{}_{}", normalized, suffix), ty.span())
>>> +}
>>> +
>>> +pub(crate) fn configfs_attrs(cfs_attrs: ConfigfsAttrs) -> proc_macro2:=
:TokenStream {
>>> +    let (container_ty, data_ty) =3D (&cfs_attrs.container, &cfs_attrs.=
data);
>>> +
>>> +    let data_tp_ident =3D make_static_ident(data_ty, "TPE");
>>> +    let data_attr_ident =3D make_static_ident(data_ty, "ATTR_LIST");
>> Instead of creating identifers like this, just scope them properly so th=
at
>> a fixed identifier is used without colliding.
>
> I believe it is nice to keep the identifiers unique, especially if you
> have many fields
> you can easily differentiate them.

What make_static_ident is doing I think is quite hacky. I'd rather not havi=
ng
them. Plus, the identifiers are not seen by users anyway.

Best,
Gary
