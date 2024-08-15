Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021109.outbound.protection.outlook.com [52.101.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69214F9F8;
	Thu, 15 Aug 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758161; cv=fail; b=jadWW/TXOdCly9YgDz2H4lw9dQGoiHP6GSZvXhuxZW3KKkGoBfYVenT27V9Y1SQQxQB8BBZlBxhclq31H4vc94JYowhwO4Ao7p0gQ81jBMd+KZNYcAwekc0SgDftVaFI6n/L1XxzYvgKT7TmKPC9sH0tLdX8pAJ2b55T28GQcRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758161; c=relaxed/simple;
	bh=Pk/sxh6kg0RPURZ+r1rMIPNW+Dx6Wg+uba9ObULHwGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1vP4oqpSXGt+UDzZ4f7B3Uxs1F4sarmj4vXltwbunOBjzr3U/HXQtpb/pbTBsP52im7ZfZzIvMgtJfCoH2qRDY9rTkVPD0KrZCtAJYvs7txtmq6BwRhVi/eSTAc4vlG+q0ChBWp+uDkiHeZP6uOrZifxfaI/Xpk4xiQCXqUacA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YIDfK5+m; arc=fail smtp.client-ip=52.101.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YIDfK5+m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wtq+odl5T0ORTE7JcMaAPtljHEYdohLKVpCUJbj0wKf1KrDd/Xl9zdX4XvcHtJbAVQweUMB6gVIH+pQ8H4bV2R1KDRn3zDgVCgNmBTHY2U0+VnQc8NhRwIEmNSaBgfh/66iJjjmN6y2tcCUF4EvNP/sQYuXdBB3qJuDlkY8AiBcYmAviYpDh/onrXXNOEfuaV45410eCYJb+MJqxPtkMO3ts9/edpvAZnuOyeRBXInlLtgAyMtxBrUD95hkJ1GS7y/spnmrOws1ThmD9Th3jlc5aKCjbw357JKpeCzNZ3ipDeS5N4pWyUuBo7+mCT1mLRJI2puhaSxR8/8dNCTteTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZdXQrb5jLzuZwDEFyVo5IYobTQdQCP5z/3jBPr5/B0=;
 b=AlWb90jez6lGXGQjGQ3da/Q58a/TUs415eXZMTjrTa9Xc/IDS+E3Q/PExcCl7CwcGtj3BLL9XsGdIMthsMJAxRJlmXKRRGu+GeudoqIm7uPbRr/OYeBFkxpxPtFBDqHrSXZoruho3hH3p/fl0fLTP4vgl47iIx/8J0aFU0OjmZZCt/6KMTA8iW1JdtWiMit+R67R7JFXWG39OndLU+lA+1LG91M6gUgdPpjYap7nEVD5vyyPr144oKLitFI75gkuV2n9gGFDT8WhYLcxvyJFwRL0ddf8kcspl2MfEGfdI4PV8C6uzyMeLEk/OIbgLoZrHUGX3FyLM7qJEi+TNYExwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZdXQrb5jLzuZwDEFyVo5IYobTQdQCP5z/3jBPr5/B0=;
 b=YIDfK5+mL7E/H1Pm6nG2UWqCKb/KeN69uIPr15LvgqgqcsfTqQCGDo4ROVDHUqklLhVWTaU3yKJZxOVwZdBibP4yddGKnjaMyUsGJ8Xs0p8HDO5cjTzqY0uu+kbcSziAUlHRhktLUC1HoYfiB8pL9P1IZIBAlsVWTTgAymGO/hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2452.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 21:42:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 21:42:36 +0000
Date: Thu, 15 Aug 2024 22:42:34 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <nmi@metaspace.dk>,
 Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas
 Hindborg <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)"
 <Dirk.Behme@de.bosch.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <20240815224234.561de1b5.gary@garyguo.net>
In-Reply-To: <Zr5z7N2JCMBbQ_YK@boqun-archlinux>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
	<20240815074519.2684107-3-nmi@metaspace.dk>
	<CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
	<20240815200738.096dca4a.gary@garyguo.net>
	<Zr5z7N2JCMBbQ_YK@boqun-archlinux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a305fef-6404-4a90-415a-08dcbd732d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3NpUVJvbERZVnlXemdpa3c5WTkxSHcxZ3hVMkx0S1pGVTE3eGdsWjFhZXc0?=
 =?utf-8?B?cU1oa3JHWVpJRUV6MVF1RXZTTDZJU25NT3U0RzUveVRnSEJHbzV5MzZCcVlH?=
 =?utf-8?B?OHJScEZZZHJzNW5lVUJYcC8wQmFjTTcxNERrZ29VWTkwNnNXSFZLcjJoUitx?=
 =?utf-8?B?TE9jRnpXbE52eitieDI3QjNRMjZWU0JCNlZEL1ZKSjhnQWpkODlKUXpYQTFL?=
 =?utf-8?B?c0xKYW9ERlFhRVVQR1k3OC9oRnI4RTZ2bi9teGVicDZJTEhuSkRVbUJta1Zz?=
 =?utf-8?B?OWlWMHg1K1dmdmxlMHg3MmxSbmhKaGxvOGFQTU1zOFQzNCtRYVlSYzRRNGM3?=
 =?utf-8?B?b1FXSDR0ZkZCRDE3dnNzTUN1N1NUeVlJVUM0N0htc2kyS3dmaWd5NnpzdUZW?=
 =?utf-8?B?c2wxNEE0VU1nRnlEelhJMXNxTWVsQmVMdjZhc2ZPdVZZd2IydFV2bkhhTlFK?=
 =?utf-8?B?WVZTZ0pXY1RacDZGdlpqS3E3Y01YS0hsbVFCUlpGaGtpWlQwQU9CT2tpYW1n?=
 =?utf-8?B?N0FJbit3N1MrSWZIUVFYVDBCV0VUOVVxVnpPem80aHRQaHRuMStiSUxQSFVO?=
 =?utf-8?B?Q01udmhGb2hkdHFoVlRmQjFGZVNiZngxZzBPQ0owSy9GSTRNWDZiT2NMWTc2?=
 =?utf-8?B?MGMybGxyV2I4ZzE3K0kxZkx0czNOZ1cyR2ZGNmZzRVV5VXU2Z1Z4SHlYYWdk?=
 =?utf-8?B?TTFDTVdtaHR4WWNKajNhc2FYUkJaSFZLVmRac3RtOW9jVS84VnhYWkNoMzJE?=
 =?utf-8?B?Nm8xUjVlT24zWmNYLzJkcTJvTU9vV1YvR1FrRkJmdVo3Mi9ac0Zpb3Y5VFMw?=
 =?utf-8?B?akNNZnhScGtCSnlRTUFkZTlpRUdzbHBFQWxvSFNXSlRUeUNHMW01SG82aUk4?=
 =?utf-8?B?NTdJZ0FqUndBRHdRU2NjR2VvWlQ5UVdBcWtpNWMvWnRPdHBFeEc1MjU3a1Vk?=
 =?utf-8?B?S2lNeU01SE5zSGVVWEp6bTM2b3pkdy9NTlg2SFpjZmYxY001NFYrRUlDM0M0?=
 =?utf-8?B?VU1FK3NLS1lVR1MzUkgwbmkremU5Y1JVd2pFT3JpYmJjZzVLWTYyZ3RBNXJM?=
 =?utf-8?B?SThWTVpndzJRM2ZVRUI5L240TFcrelpTdmxoSk1zRjdyZTZqTGE0TkRINEx2?=
 =?utf-8?B?QlZmYkNqSXdMbGx2RGhndzJvY3VMNk11T1FWSzd5TEVybE1PVk9HcXh2cHN2?=
 =?utf-8?B?c2dvcExFSDRCcnpUanZ1UmtpWDVjc3FwUWpqdnRWbXJlMnY4TitCWjZ5Q0t1?=
 =?utf-8?B?YTQ3OG1Ycm9iMjduWnBSWjJJZ1IrK2hCNStHbzg0N25ITWdpUHJmend1ZlAx?=
 =?utf-8?B?azFSTW5DM0JHZFhDZ1F6aWxMSEsvWktsaytrODdjaGpOa0ZFZTY5UXlHNGJz?=
 =?utf-8?B?NFJnQzRwV1RuNk1NUG5oZzlXT3huNkZzK3pVb0FIWG9vQm1PUFBnTFkrbkt3?=
 =?utf-8?B?UElWbkNaZEVwZEllVnFmSHRXNFg1cmJCQXJnMjFubUZhY2FERXhLalNvWUtS?=
 =?utf-8?B?cVlPRUllTXJQbUxaUkcrRXl1ZnZoUEpkU0tBL0tES3ptdTNJQWFYWE8yNFBj?=
 =?utf-8?B?NEkwc3BwdDVWRk4wR2NHbDZUWHppRno3bXFhQXlwRW50V1duNjdYa0VKMUVm?=
 =?utf-8?B?cWIvR0Q2NUx0cmJ1U1hiQTIrUHlrTFJGa1BYZW1oSTcycTdnL1h0SnBqa0lm?=
 =?utf-8?B?RzZ3UWJ5YUJOSDRjNVc2U2duZDl6N1hYUGNlcDhXeDBqRXl4dEw0NHcwYU1n?=
 =?utf-8?Q?VPggAClNqv5tUh84cA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1dBQ2sxK0NsTGpuMSsvcVFTamM3dmlTTDAwT2NkMGxJaU9qVCs1T0U5TVZI?=
 =?utf-8?B?UkFaLzVnRFo3ZE14NEU3b0NkWnhHSFNFMnB0cjlUbVJpanFUR2NiZGs4cFpP?=
 =?utf-8?B?d3VXR2pDS0VoOEVGRVJ5ZitoUzFwSnpMb3Y0U0RsY1d0dmtsU29UT0htRHoy?=
 =?utf-8?B?QzdSdXlWQ2U1Q0ZHSnExbElENHY0OEtvUGJGajRYY3I5T2RNSitraTdJcUR2?=
 =?utf-8?B?cXVqOVZoT2dJNVZMNGVDM2NFSU56MGV3UVJoeGN5NlNwbFIrMmdqTmpMT2lN?=
 =?utf-8?B?ZzlNYWtwRUFXQlhIWkcvQzBzMGtpNzMxU3hJRFpQMDBJY2NjQUhSQ2pkc2pR?=
 =?utf-8?B?VW41NXd3NHdaTmt1SUpnZ1dzcXBvYUREUzBLbUZ2bXYydHovNVpwNzFlME9Z?=
 =?utf-8?B?WS9BbHEzaW5UN3lSU0ZBNEVORU44V3Z4clI3eERkOVJaUUszeE9YM00yL3h6?=
 =?utf-8?B?T0RpNkVTL2I1N0hFdkJXMDlhdDRaR1V3bGsrTzExQ2ZlQk5lK3ZrOXhCUHhN?=
 =?utf-8?B?NVpIaWc2TEtRcmszSmJ3aFdHSWE5SThtNXRhcm9DT01ISTJJTmxOLzFrVThj?=
 =?utf-8?B?TEIxR2poOWI0SFBjcUVZbU10d1h2bG50NFZYTlExR2VYa21kVFMxeWFORDlL?=
 =?utf-8?B?MmtLQmQySmE5cUtXd1RhQUY1N0t1Z3BvaEJlamFkUUh5SzdyQXk2UUhUMUlm?=
 =?utf-8?B?WkgzQ1R0ZHVsSGdlUzZ4VWJIWWs1SkRXcUZWQ1drOGtnUytRSFVyRktYNVhX?=
 =?utf-8?B?NG1BVXlhZjduSjJiNWlXeHpUSHpnclIxUEVJaG1oOHpJeDMra05LT2tJZHor?=
 =?utf-8?B?TzZCajBsTkF4ZWVETzJmY1VvMFZrdU9iS0RYWVNnL2dDVlp1RzNINGljNm9w?=
 =?utf-8?B?YlU5NDZMNjZEazZmWmgzdURMc0k0c3ZVRWcyN0R0TU9vMk91Y2dmK0dhREFL?=
 =?utf-8?B?NjJPQ2NMSjA3RkRta0srZitKWnFLYTF4V3NIUXNaQm80RTdJWDFTa2hCaitH?=
 =?utf-8?B?Rlo0TEVRQktCRzVudHRKRUxHeGxPNnpNdXg3Q1YwcWY1MUxaM2k4ZGR4T0FV?=
 =?utf-8?B?ZVFGQ1lqYVdOTy9hQmdvMlJKbU5EekhoeUFTTFU0YW1ZUy84TUlpQkdlZlcy?=
 =?utf-8?B?ZExBZ2U1NzB6OVhJSDAvVEhMTzl2ZnBaTnJQaHlWTkZIV1VQVXlEVVFTNkpa?=
 =?utf-8?B?azZFa3dGVXRadFpBR3E4NVpJOWo0OENRdG1paFlTbmJ3ZE5Xckh1L3c1Zm52?=
 =?utf-8?B?SzlNMnFNYnhmVHZwMnNSUTl4ZFM1NU9sVW1STjlSYytVdURxRDZXcC9SQURP?=
 =?utf-8?B?bDBua0Z5dkxMRUNwYi96WWpCdFB4SVN1enBRWHprUlRxd3YvWUpvbU1Wb29m?=
 =?utf-8?B?THppS08wTkYyempwdU1zdHY5YnM4T3dxTVlpR3Q1c1kyZjRlbk9ielRWcExj?=
 =?utf-8?B?VEVBOE1FcExwcDM5MVZaMTBiVXhVbEw4Z3p4b1drUTV1ZDlnWnBXK2JFRTJD?=
 =?utf-8?B?YUNMS1hSaEFaUUVvVWJ5QmlnNHZHeGp3MTUvbjlUd3dFQ3Q1L0lnR212ekJP?=
 =?utf-8?B?dVNhZ2FVMWVMWmtFUkR5eFVqZjJ1Z1JBV3FwdEovYXJXeUdVQjNWUC9NeWx5?=
 =?utf-8?B?T2o1WVpwYUtaUC83U0NWZGVYZWYwcEZOczR1UFYwOXNOVDhmWmp5OUcxMG50?=
 =?utf-8?B?VkhGS1VKOTVJd2lBWC80MzVlMnRvTjN1UXhRemZZcUlkMFpHcmFNWEZtV1ZM?=
 =?utf-8?B?U04rQ0tYanlpWE44ZCtzV203aEw5UFpHWTFnVFBOb1A2elBnaUF4cjlxcjJ2?=
 =?utf-8?B?cXdHODVIT0l6T1BVSmdNQ3U1bERmcjkrMTY3SXl6dzc2ZnZmcmdDODA2dUxT?=
 =?utf-8?B?OGtLT0J5N0paMVBrNU5nUndhaDU5NXg3ckNOTW4zM1F5WnlVTFRrQXlXaFZB?=
 =?utf-8?B?b3IreFk4NUcyMUpwQ3IweGwyVW5idCtmcmFMd09weURPdm9RL2Jla2c3Wm1x?=
 =?utf-8?B?QTY2ejd6R2g0TEdzNldHM09pbWUvYTYyMzRkOXN5L3FTNXUwSEJtRDBkSGFG?=
 =?utf-8?B?RXpMWFNZeUVOblZBT012SHRraEUxRjRsak5Fc3RZdmJXMWZDa21kckl3b2li?=
 =?utf-8?Q?E6eLeK2n1iQzkKM41KhO9sLo/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a305fef-6404-4a90-415a-08dcbd732d4e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:42:36.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYm/xBtascZlZSssqjcmAUs73Ym+1UudYg4jzPzrmpzuFaLReWp0TyHU0EqgBXbMaftrTDe80I4VHrmjXBAE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2452

On Thu, 15 Aug 2024 14:32:28 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Aug 15, 2024 at 08:07:38PM +0100, Gary Guo wrote:
> > On Thu, 15 Aug 2024 10:04:56 +0200
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >  =20
> > > On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspa=
ce.dk> wrote: =20
> > > >
> > > > From: Andreas Hindborg <a.hindborg@samsung.com>
> > > >
> > > > When allocating `struct gendisk`, `GenDiskBuilder` is using a dynam=
ic lock
> > > > class key without registering the key. This is incorrect use of the=
 API,
> > > > which causes a `WARN` trace. This patch fixes the issue by using a =
static
> > > > lock class key, which is more appropriate for the situation anyway.
> > > >
> > > > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` mo=
dule")
> > > > Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> > > > Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-=
General/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doct=
est.20lock.20warning
> > > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>   =20
> > >=20
> > > LGTM. This makes me wonder if there's some design mistake in how we
> > > handle lock classes in Rust.
> > >=20
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com> =20
> >=20
> > I agree. The API that we current have is designed without much
> > consideration into dynamically allocated keys, and we use `&'static
> > LockClassKey` in a lot of kernel crate APIs.
> >=20
> > This arguably is wrong, because presence of `&'static LockClassKey`
> > doesn't mean the key is static. If we do a
> > `Box::leak(Box::new(LockClassKey::new()))`, then this is a `&'static
> > LockClassKey`, but lockdep wouldn't consider this as a static object.
> >=20
> > Maybe we should make the `new` function unsafe.
> >  =20
>=20
> I think a more proper fix is to make LockClassKey pin-init, for
> dynamically allocated LockClassKey, we just use lockdep_register_key()
> as the initializer and lockdep_unregister_key() as the desconstructor.
> And instead of a `&'static LockClassKey`, we should use `Pin<&'static
> LockClassKey>` to pass a lock class key. Of course we will need some =20
> special treatment on static allocated keys (e.g. assume they are
> initialized since lockdep doesn't require initialization for them).
>=20
>=20
> Pin initializer:
>=20
> 	impl LockClassKey {
> 	    pub fn new() -> impl PinInit<Self> {
> 		pin_init!(Self {
> 		    inner <- Opaque::ffi_init(|slot| { lockdep_register_key(slot) })
> 		})
> 	    }
> 	}
>=20
> LockClassKey::new_uninit() for `static_lock_class!`:
>=20
>=20
> 	impl LockClassKey {
> 	    pub const fn new_uninit() -> MaybeUninit<Self> {
> 	        ....
> 	    }
> 	}
>=20
> and the new `static_lock_class!`:
>=20
> 	macro_rules! static_lock_class {
> 	    () =3D> {{
> 		static CLASS: MaybeUninit<$crate::sync::LockClassKey> =3D $crate::sync:=
:LockClassKey::new_uninit();

nit: this could just be `MaybeUninit::uninit()`

>=20
> 	        // SAFETY: `CLASS` is pinned because it's static
> 		// allocated. And it's OK to assume it's initialized
> 		// because lockdep support uninitialized static
> 		// allocated key.
> 		unsafe { Pin::new_unchecked(CLASS.assume_init_ref()) }

nit: this could be `Pin::from_static(unsafe { CLASS.assume_init_ref() })`

> 	    }};
> 	}
>=20
> Thoughts?

I think this design looks good. I suggested adding unsafe as a quick
way to address the pontential misuse, when we have no user for
dynamically allocated keys.

Best,
Gary
