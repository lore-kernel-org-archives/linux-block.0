Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A48139578;
	Sat,  5 Oct 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134621; cv=fail; b=TxTsoedSqVKFK9xzw0VJLdQrJSFA+oYQDyyMq/dYCsMV3V01n1k+odft4SflLOnvBOgCq9AtfBBq1pTTkVYsrGnGKg2ybtrhuuvIHL+nG58PXNFTmKaUQ0iTyOByG8vxThLmrWl7Mp35UR9aMaIaXZf2SQIJ5nYhcfvUgTCrII0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134621; c=relaxed/simple;
	bh=LXWq6clbLFGcy2iqN9F5Kmg5Scxk2VgFjyjl/u8c6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNoFcROBcU19BMKIpK6GFjNa960OftZ/wTdBbUuW6cs7ZpWBpVjsYpZe5CRsZaQ41iVmwTJ0y4ppRjkGFNmlplT6rAww00C9DF5cSI9A34QAhrPIUwh0y2x2wHStS4I8+AkP8esOpIQDJJq9ny3R+4bWJ/XIlK0wGHIs6cGpvyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=n3EKK5/u; arc=fail smtp.client-ip=52.101.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="n3EKK5/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+jVHO/9loubEIiCXBbU9mXbP9iy8K5rB54ASDZ2uzSEboIEGOAHugTFTHEsjzFDfdZ6wIBnkHwn6odjMtHidOhH923/JropU2YGTQWbT9G+WLkn5Ns+MPJiZufbr11rv/oUQhCzYky8C62jtR+69jeY/1M9s7n4UgRJvK8emcAhcSNcWwtBHlj1CPRNq+O5FOCD0rlgJSXWkIt1ZHCoCKfiqev9DFjGPUcmewsiIzcp6EgrIa7UDukDLSTrMeX2ZjAH4SPPinHfwmEXu+RFhPklcR2jgnfceXHiqybHzkjywAW8KL5PzcTRUCXYtW7iumMMHU+x5672+6jhPeW0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0liXJhLAHtfq3cZ+QkUJKKqMS9G4kjqvd0vkLsfDQI=;
 b=q9TMOWYwQ/mjMcP04H1xahCbmQnAOlUowrna+JQw5ZIOfLpUuHpj6ui0ziMKq2Niy2qtjrfIDGvWkRI58OVIzzQFVKDp28Ddtv2RCPWjRLuhB39AnbWSRktxlmrcVhmZom4QyfDzi4wJ9tQJxJY2yV0ea3H0jPKHvk2Ek3cNvQ2eJPlYdntpS09x5szlmPCifOwhvrTyi5ist1SpTHYgArfp5Qt+r+lWOrzEtnzJJEs3unBz/lgF11y7yqbiqJXOvUbRLbGn+idcb7ZUfI6ZDu/xfWbEmdhnwZyJr50qtX+FvhZoYqT39GuT5zczfkoI3UVPaOxd0uBcgsipMT+ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0liXJhLAHtfq3cZ+QkUJKKqMS9G4kjqvd0vkLsfDQI=;
 b=n3EKK5/uUx5+XffudfIn88LMNJH1vIVgEyev53sr1215L0PhxLnVffVY4/xQLoFA4NJaPNYxrlTtfe9ZCLI9MXR1f3YqwBP8waFUG2PDdGLuyk6RDunRuee781vPxSPdm7bD1H/KYz8CMs98cSkI25jJ4R/lcqSNHTPJbnjprnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB7231.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 13:23:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 13:23:36 +0000
Date: Sat, 5 Oct 2024 14:23:32 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, Jens Axboe
 <axboe@kernel.dk>, Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <20241005142332.78b8b5d0.gary@garyguo.net>
In-Reply-To: <CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-4-gary@garyguo.net>
	<OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
	<2024100507-percolate-kinship-fc9a@gregkh>
	<87zfniop6i.fsf@kernel.org>
	<CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bcc443-2ab7-42d1-9763-08dce540eac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnM2SlVZejFQNGRycHJQeHNmRFVub1RUSjA2ZVpqMUZCbGN0U1VFYmI5U3VI?=
 =?utf-8?B?SVZXZTdtekMwc0RGZVhyempDNzBrdnJsam9jWXhDaGZIc3ZFNHdBYzc1eEVy?=
 =?utf-8?B?WVFRRE5QREZGeUZuNk53bklrZy95OTRic2kxZ0NybytyMDZDZlR4STl5aSty?=
 =?utf-8?B?SmYxYVhVWUduVFE1VmJ4UzJGOUZiaHp4V2NIY3VmN3lTdUtBbFl5bmZmdFlX?=
 =?utf-8?B?djc3NTdLdTl2R1ZaU2JGZTRKRmRhcEQ5c1IzejBkRVg1UTVBdkJPVWxucWFj?=
 =?utf-8?B?RGRkYWpCOGkyTnV2ZTV5ODczZVZ4MVYvUnhYUTIrZkFjY0J1Um9pVEMzVHpn?=
 =?utf-8?B?VjlOTzArMFBTZ3lUbHFjQlJEOUpiS3ZwK3dQNGJkTk1KbG5qL0t1cnNuVGgx?=
 =?utf-8?B?V1lLUm1GY0k0SjlLK3JTTEJ6M2o2YnBORDVNZVdqTUxrWnlxVndjN1h6anF1?=
 =?utf-8?B?Z0VoZlltMngyQytZQTZScU5kRGI4UkpwaG1UbGd3aXEwU0xZTm82MUtYbk9h?=
 =?utf-8?B?aXVMNzJ0OFk5a3lQMng2TkVlQ1VZeVNxMmhOTFk0dVgzUlVBVFBNZUtMM0c1?=
 =?utf-8?B?RDM1WmdCZjZOeXVWbkVtM0x5L1ZtTkRmQ2NKV2M1ZDFSMGhBOWR4aUVrbitR?=
 =?utf-8?B?V2JjeHFJUGYwejkxYzRGZ000aURCOVBZRGJyMlhUS2xTYmxLUTJuYm9iTWg1?=
 =?utf-8?B?N1ZhRnU4SlpYRHhsQXJDdjZPK2hXZjNjSHQ2N0s4Q09TRksxRDIyVkVFK3J6?=
 =?utf-8?B?THo4VEZYWlZqK2lHVUEyUCtnU2NyQlVqcDBTRThvU3d6aGFZOVc1NmZOTXZJ?=
 =?utf-8?B?c3FuQzNlRUgwbjVyUnF1NG1kLzRpMGZNaWVEWHBTNFZrWHdpb1g3SGRRdUFq?=
 =?utf-8?B?OWpkNFBmbm1kem95MVZRRGhBNjROVXFseDM4WHJsQnpOUGVUMlVPUGlvU2dI?=
 =?utf-8?B?WEtEQ2ZFdFBYUGVROEZlZTdqdlFoNElISWJHdFhRV2Y0ZHBoQVg1SkFiZkdv?=
 =?utf-8?B?MkpoVGs1Tmcrcy9tUlJ5cmJrOHFFYmlqV1JyaTh0M1RHeWd2QndTWG5DY1Ny?=
 =?utf-8?B?a3dLaEJLTzJ1OVM0amIxSlZ5dkwyRHN3c2p1YnlDYU80cXZIdWhXTm5UVnpy?=
 =?utf-8?B?bDhCWi83UmJTT29RU0JWY24zaGIwZVM1MUV3OUcveEhib3VzUWFwKzRaZXdV?=
 =?utf-8?B?NzBKUHZyNVZrTSsrdmNHaHdUcUxjL2t2RWpaSUVGbCs4ano1RDlXZ3pEQXZH?=
 =?utf-8?B?b3NlL3M4a295YXhxalIwY21YeTVwdE1PQnJTbmJSeDRVUUwxK2k0OG1Ga3dl?=
 =?utf-8?B?alA4aFp1Y2ovcStKd0VPSGJCUDhmRk1idTdWd2g3bzZ6bk5xRWpneDhvbStm?=
 =?utf-8?B?a3A3VjlPTWFiOXRPRFRlcERnLzJhUGk1UjAybWd2VGtCaytlbXQ3eFhXYnRS?=
 =?utf-8?B?NUprbzNpRG9kVElPbHM0Uk9hN0tndWZwMkhVVW1zalIrbUNNTGl2MGF5MGJr?=
 =?utf-8?B?OHBoOG9KUysyaFRETTMwZUNPMGdjTlJFQkY1RkpHOTRMcGFtMTNvUDVaMDEw?=
 =?utf-8?B?N2RuY2E3QlB5aHB1ZzdnMzU1My93eW1wRFJwUnlONDBFNzE3VWVDSXlhUzVO?=
 =?utf-8?Q?xzFQJuLIOTcL2lEJV9lZKmSFMZWwrRYDnKEfJueWuWzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVk1RHpSTUdvSlIrR3NFTC82YnlZd29jZ2Q5Z2Y4QmEzQkR6OWxJRmpETTdk?=
 =?utf-8?B?Q3E1NUZZejdUK1V5RG0rN1VObHBKTXFEQkFsV3ZPTC9pOXZ0SnViSkx3bStG?=
 =?utf-8?B?SHZJckZNL1RYMVpRdmd5MzVpbTRTODVxWndjeWYxUXJISkN4RjkydTA4SXpr?=
 =?utf-8?B?RUdMRklJa3Jyc3dRKzgzRnJQTm9yelZuQlREbUFkSnF5aU5ENHdWTVZsVSs0?=
 =?utf-8?B?cXlvdTVtaVhiNWNPRkpLaUFuQUdqZHpiRnVpeE13YzQxT2dDcmpiZDhJY2Fs?=
 =?utf-8?B?UUZhU1lTVTZlOW81bVhVSmhCUXQwWHhNVHhFODN2SWQ0MlI3ZFQ3T2FJUklV?=
 =?utf-8?B?d2xJNHJtZjBRUzZ2ekZ2dTVFdnViamo5RmxvZHVCZW9iZFJ4dWNkc0t3cFVx?=
 =?utf-8?B?VXFVT1NuL09hakxJZkZjMGFpNktMN05ZRjBYYlh3eDRXdTJTWGovY0hza0Rr?=
 =?utf-8?B?MThBVFVUWVhCUTJNdlNaaldQZVVjSG9aVmtHb0daY0ZScmQycTBkTEhxS3R0?=
 =?utf-8?B?NC9KeFZESXVHTW5NSG01TkFoY1dLM2dsdDRmNWJFSkJ1OTA3T1dseDV6WXRH?=
 =?utf-8?B?Y09MNElUdlRYQzRTV1djZmhrcm9mamRZeG9PWklqSkdCTnVhQkNIQXhmWUdY?=
 =?utf-8?B?QlRya2IrT3lTWDcvUE1ZT3dMazNYNkZhdXFGOVFLdDZiNE1BSnIyTDR2QU51?=
 =?utf-8?B?WlZyNTd3TEMzQVRnd1pURS9IRzRYdW9DNEhmMGVOcGVUTTJkUkhkeXM3dTha?=
 =?utf-8?B?WkVoT3RCQjByNllRQTB5Z0E2NVJlRU9NSnB1Sm1NWm9MNnliaVZqWklnQkd6?=
 =?utf-8?B?bHJ3d2EwTW5rbDlJWUJYanZFZUV1aXM1c3pXbVhDWWNlMWJERG1mRmVPT3hJ?=
 =?utf-8?B?RlVUUEl2WnkrMDB1SlB2RWQ3RFpyV0FEOHBLODA1clBJVEN2ZWN2U0hnR2ZB?=
 =?utf-8?B?NXZ0dThqaFo4ZVcwd3I2ZjZZZGEzNEVxMHdxSXpwa1U5cGlDRHJ5VnVsd01O?=
 =?utf-8?B?WU5ESDNodmw0MldpRldjenlvYzIvKzJmMUY2S3RQaHVveDRJWWV4OVdSanQz?=
 =?utf-8?B?L0c3WHFKZ1k5anI3aGFVUkQwRXcxMW1ZZjFNa3ZydmVVd211S2U1WVdlMlRT?=
 =?utf-8?B?cTFGYlpuZytQdHVUV1NTOTkrbWt6S2lmNWh0RW5veFlwMUJJUmlJYTFkWEtN?=
 =?utf-8?B?UlBDSmN5cEsyR3VXOC9QOVBKK0s5K3hrcFhKZndTUFpncnZNRWFxQmd1NUtV?=
 =?utf-8?B?dXpLblEyeUpKS2FPTzRZY1J6bEVrRnl4UTBhbG9aQU91N0xzSGVNQll5emlh?=
 =?utf-8?B?bWd4YktFVEdkRitKbmc3UXFhNU5IU3RIRTMySHptaVp6Z0J0SGh1cGpLZDFU?=
 =?utf-8?B?TlhGTmI5UmMxdGhlMHBKcnB5TGxMNWVtSjFzbzJBV3JEUERHdk1IdlZyZFZw?=
 =?utf-8?B?Yzloa0NhRGJGM0dkdVloc2prM3FjT1Z1eFhMb3FyeEhDdnlhVC9oVit6VEVR?=
 =?utf-8?B?WURLWHhmVkU5Z05nQUlwZlp1VHQ4aDdGOGtlc1M2YWhHRDVEMEMzL1NKbHJa?=
 =?utf-8?B?eGpSdmFZUVd3eDhrK0NOV3dmMGNPVWp4dStaYXhiakVoU3Y3dE9YVVBtWk92?=
 =?utf-8?B?dTBMZ0t5dkV2OWtqY3I5eklKeS9BOXMzbHJRdXNVeDVDRVlzVW8rU0NRd0NP?=
 =?utf-8?B?S1JxVHlXWU8vV25OejNjeXlWS1RkWFh2NmQ0MXFRTGZ1Z0Q4b0JCeFpHYWVj?=
 =?utf-8?B?dkJMeUVSSHh3dGZhcUVEMysxd29XQUdJQzg5K3JmakhaSlFsSXlKemladnZm?=
 =?utf-8?B?WW1FUWZQcG1taWFiYVQyNjB1N3Q2TkRNN1dZbllXSi9mdmdVMndtREw4R0s3?=
 =?utf-8?B?QVBpdEtlMmh3cEZyYlZBelE2OTlFWW93OHBsT1FrSld4cGZ6YWdMbWczci93?=
 =?utf-8?B?ck1xZlljU2gzbWNaRGRIMTVaRHlmN0ZGd3BSOUtvdklLUmxYL2hxRjcvdjJr?=
 =?utf-8?B?R0Z0RWh4RHRONWRQWmVjSzVoWXVOSytkSXZWZmVZRjRkWEU0RW9OWmRKNHI2?=
 =?utf-8?B?OXJRbWxnSHFBUkxiVTRvbWJpVHZBcWVPbzBxWHRTRjdjdzJSOEpXS3VtSDll?=
 =?utf-8?B?ZUVjYTBRSDdrSHRBb3V4UHdRZlJKc1BvVmkwZWJxRkJlNmNmZEZyQzllZnZG?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcc443-2ab7-42d1-9763-08dce540eac8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 13:23:36.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8+k346EEW2YA18AgEG0S65VxTKQ36BI0HbQ4RcPD1TVHZyCiNUw54G4Vu7GAjsONB7OuKR+hTmDX/qXyFL+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7231

On Sat, 5 Oct 2024 13:59:44 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
> >
> > Hi Greg,
> >
> > "Greg KH" <gregkh@linuxfoundation.org> writes:
> > =20
> > > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote: =20
> > >> There is an operation needed by `block::mq`, atomically decreasing
> > >> refcount from 2 to 0, which is not available through refcount.h, so
> > >> I exposed `Refcount::as_atomic` which allows accessing the refcount
> > >> directly. =20
> > >
> > > That's scary, and of course feels wrong on many levels, but:
> > >
> > > =20
> > >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef=
<Self>) {
> > >>      /// C `struct request`. If the operation fails, `this` is retur=
ned in the
> > >>      /// `Err` variant.
> > >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::reque=
st, ARef<Self>> {
> > >> -        // We can race with `TagSet::tag_to_rq`
> > >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_=
exchange(
> > >> -            2,
> > >> -            0,
> > >> -            Ordering::Relaxed,
> > >> -            Ordering::Relaxed,
> > >> -        ) {
> > >> +        // To hand back the ownership, we need the current refcount=
 to be 2.
> > >> +        // Since we can race with `TagSet::tag_to_rq`, this needs t=
o atomically reduce
> > >> +        // refcount to 0. `Refcount` does not provide a way to do t=
his, so use the underlying
> > >> +        // atomics directly.
> > >> +        if this
> > >> +            .wrapper_ref()
> > >> +            .refcount()
> > >> +            .as_atomic()
> > >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Re=
laxed)
> > >> +            .is_err() =20
> > >
> > > Why not just call rust_helper_refcount_set()?  Or is the issue that y=
ou
> > > think you might not be 2 here?  And if you HAVE to be 2, why that mag=
ic
> > > value (i.e. why not just always be 1 and rely on normal
> > > increment/decrement?)
> > >
> > > I know some refcounts are odd in the kernel, but I don't see where th=
e
> > > block layer is caring about 2 as a refcount anywhere, what am I missi=
ng? =20
> >
> > It is in the documentation, rendered version available here [1]. Let me
> > know if it is still unclear, then I guess we need to update the docs.
> >
> > Also, my session from Recipes has a little bit of discussion regarding
> > this refcount and it's use [2].
> >
> > Best regards,
> > Andreas
> >
> >
> > [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#im=
plementation-details
> > [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685 =20
>=20
> So it sounds like there is one refcount from the C side, and some
> number of references from the Rust side. The function checks whether
> there's only one Rust reference left, and if so, takes ownership of
> the value, correct?
>=20
> In that case, the CAS should have an acquire ordering to synchronize
> with dropping the refcount 3->2 on another thread. Otherwise, you
> might have a data race with the operations that happened just before
> the 3->2 refcount drop.
>=20
> Alice

The code as is is fine since there's no data protected in
`RequestDataWrapper` yet (in fact it's not even generic yet). I know
Andreas does want to introduce driver-specific data into that, so in
the long term the acquire would be necessary.

Andreas, please let me know if you want me to make the change now, or
you'd rather change the ordering when you introduce data to
`RequestDataWrapper`.

Best,
Gary
