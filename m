Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020072.outbound.protection.outlook.com [52.101.195.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CF83CC7;
	Thu, 15 Aug 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748866; cv=fail; b=XHaFUcaF5JQFgYP+7Tgq4nfEm77JiO+zyXwrBSvWAdTXrbyat5KdFgWFDhedzlkMclG1kY8mGF6ijHQvUCCWLnU9XPMdPHUNg0Upp0ZFAH99fzBvAy0HD/f4TE5W3PZfITX4xHZG9+578FEaPQpLyUVkNEOZgpKWeKxKqvt1By4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748866; c=relaxed/simple;
	bh=qaIheY5KiGQ3bRRh6B6jXI9EnCMTHAIXz6segCPE07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTdaJHqrnvsMaGF/Ts0Lu+Qcm/kWpAO5rsnekZO57FJzNXy+Hvm1IN813HS5tfqVzTEekGSDaFyuSGw81tMR6rf9oEZxHt4/xj31z9JpUUSJQjwOvFbqL9HX8TcT4DGWSKHpCs5lOcBlX67qsfD6ETz24O8MfI0UFfqtrAvelxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pzwCMEbd; arc=fail smtp.client-ip=52.101.195.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pzwCMEbd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a08+O0JHL6cG7euKVGfItFOGqDbjakJyVFXE8a0R7eDXLN5krlEK89gxS+jGIhwOoqbcIfLMgO/Mi1TQFihXz9n0K1ygX8Np7sxan/cBdx9M97ueTPXsN9onKomKb+meiBu53qYCfl4GDEihZERo/mB6IcNIAqobXK8SnDl7a6HmwOpKc46/YE6NItgeSdjQ2TBKnQqIO3pv+i3LK6EUJLseXjNwVlJz+DC7eeSrAJwZqhiUieH0Dk3WgGA+KtUwkJDYA2VguNvg3lAZ2rA6z8EEa8eYtKxkXsK7oGv1ET+tYgF0hGq9hqvtFUnQgHjNy2/hqN6vIKTMclBnZ/zarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaIheY5KiGQ3bRRh6B6jXI9EnCMTHAIXz6segCPE07Q=;
 b=EHN0YojfKUMHAi2DFD3frZYaP1tmVU3r9dbr/AMKUoOl6v3r146OJyNM27h/PjeRahbjf357tqgm8fa1uY5TjkSuAUusub4yCIZtlFXYZ3VOZPKhZ5fq2jx5MFVX1Q4vS+x+3JwIhIZjJZOxbhqeYZvg/gu7PdwXaBM5Q+rd+Rt9S3bHPcENEzFdA1ljMjyRHI2akUz5uf2rrV3I1ZxCXXkSuZtyjzq6NvmrfqXU1lrqIsMjUNZhjuFOLPPRLkHSf64oOCygXHuseAK9sly6+Cu88306slyqcbr3HjiUBrCUvRhlbA8g+qntCLN8lRLYyr1jCayyqP4N48H3LjD32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaIheY5KiGQ3bRRh6B6jXI9EnCMTHAIXz6segCPE07Q=;
 b=pzwCMEbduNrMcwG2c4LGRgnLtBIno43PLBHTcsEJTpEJpsaqkLal1K9vbuIa+lAs+nzFKfE8+YaszrfOR9j6Ja506NApYz5RqEugTgHo7t1ABeLZDQrniUuBH1faXQX6cRpBREgA/sFAdySOSDhcpQ8chf+D9D7zPLugkY8DxrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CW1P265MB7484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 19:07:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 19:07:41 +0000
Date: Thu, 15 Aug 2024 20:07:38 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg
 <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)"
 <Dirk.Behme@de.bosch.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <20240815200738.096dca4a.gary@garyguo.net>
In-Reply-To: <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
	<20240815074519.2684107-3-nmi@metaspace.dk>
	<CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CW1P265MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: a2931c31-fb7a-4765-d222-08dcbd5d8988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0RLbmpHMUZSUnh1TS95MXBXUTZDUDhBby9QU0pIbHBBWVpBQ2tYdHp4K2lH?=
 =?utf-8?B?VGxTMVRvSXdGdmJlczNPVy9OdWRPRE9XL0JqcTNXN2psVmZOQm9MckYyMWhm?=
 =?utf-8?B?bG9YMGl6MzVFSnV6ekRFSEpHZFNiVWFUMTF6eWk1MXRBRGdNY3V5NWV5UDNZ?=
 =?utf-8?B?ODg4VkNUc0lEcTBVRDN3a1Q0NTAwRitGamhhNWFtcW1IMUI3d1R1Tkt1VTdI?=
 =?utf-8?B?eFI2Mk5XS0tMclV4Tk5HdXZHWWhqTW91RFovT09aUHMwUmZMNzBnNUh3Q0dn?=
 =?utf-8?B?QU9ZR0E2VDBzMkorMTU2cE8vOWt2ZEFBNXNGNnhzZ09wK3c4VjhDTjJwZkJL?=
 =?utf-8?B?aDN5QnliNTZGdmRrUjZFVjFnODVtRXZ3akZoYTk1b252dm9FUEJLVGsrNW1M?=
 =?utf-8?B?NzUvelA3TTVZOEczdVVUNVk2ZlNweEhaWUVRY3M1M09ZaHpxVVVQd0RGT2lQ?=
 =?utf-8?B?azRWeDAxSCtwWVBjYy9pUjdsRWU2aS84T2tqa1N4RlRhRDZBODFucUNwZWl6?=
 =?utf-8?B?SXA1bjAvN1h6N2g3WCt6Y251Z1VXU011b2xDYk9KRTZHMWpxeStiVS9pL3dQ?=
 =?utf-8?B?NzljOEkxQjZML0hGRGd3QjY3SFc0dnVUV3lkSkZCZ2ZwU3RyU055Skp3N3Vn?=
 =?utf-8?B?bzJsaW84WG84eDZMdkdZNE1xM3lWNHp6YWdkWUE1R1hMM2NtbnhSa211TFpz?=
 =?utf-8?B?b0hKU1NEaTlBYUsyTzdXUW5ZVEx3RFVONW5lZDl2UUhFdDM3M2tOR3VRT2NO?=
 =?utf-8?B?T1Rsa0F6SWlGckZ0cGhyaVpHVC9Qd3ZIUXlzRmQ5akp1Qm0yMWlEa2lmTzFt?=
 =?utf-8?B?cSttR0hFM242bzdFRk1aN09VYnFZLzJnOGdMMitIWXl0Wm5BNUNXeWxXWWp2?=
 =?utf-8?B?SEJvd1ZzQWlPVDdLci9QSmhmN3RWdmI5WS9VczhEUDdNam1MZEt5MzE2Sy9Y?=
 =?utf-8?B?RG0xMnN1U3lBbW9rajVJZ01Eanloa1JwT3R5bnpPOThQemFtQlFGRmJ2L1R0?=
 =?utf-8?B?SitlWjAzSDhjZExHYmt2cTdmVnFCMHRtWnoyOEUrazQxVmgyTlpGUmd5R3RL?=
 =?utf-8?B?ZElrYUNIVDIyaEFkRWdGdTFtbHUvd2Z0RXVHS3V3d1RUYTFONHF1SDlEbXJ3?=
 =?utf-8?B?OE1MNFA4d1p6Ylp6VXRyYVdCYjNSU3pXNXVNd1NjaFhGL2pNZlVIcW5hVmpZ?=
 =?utf-8?B?dFB0Nm9Tamk4dkd3WTZwbzh1SUkrNlgyamwxOC9xVlo3WXMyZXdTZlhwL1kv?=
 =?utf-8?B?U29xSDV0SFJ1WFNkamhFb01Hbno3WGpYeUdrZ05MNWQ2Q1dqZTRzeGJtZnBE?=
 =?utf-8?B?VzhlWERhcmg0dFFSRW9uM3Z4WWhzWXV1K1BSNktIbmRCVGhNMGw3eXhkTUYz?=
 =?utf-8?B?eVBBYzFpSW9jREFSbGpBYlVSdFVxV1BUTGR0TUI2ZmtpUlBsTWlhWGtPRGNm?=
 =?utf-8?B?MTVhY25iY2NndXNtWGJtSjB0eUkyYXRXdk5wdit4ZFhpVkNka2RTUkFTZ29J?=
 =?utf-8?B?Y2VqeTJMRGxsYmM2MS95NzMzTjhFeC9NZGFCRFlDK0xmQlhSS2Y5L3VIZW9S?=
 =?utf-8?B?V3FwMkpnK2RQQmY1RHRyUy9rLzJkOStaQjBaZUdtNWlyd3RsbmNPcnFtVVlN?=
 =?utf-8?B?UG5MNmxKOFR5WFhoUy9KQlp2Z3JyS0ljQWxpSzYwdyswVnBOYm5jYk5wcVBQ?=
 =?utf-8?B?aUQ1enBSMTNtc3lMY3BLYTlXakpLNjZicXJ6alZSbjhpWkg1djBxK2xtVXVq?=
 =?utf-8?Q?b4HNzq4qTjNLg1Sx+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmtQQ01xbGphZFNhT0xvMUJBNkVLdi92V2FMaHNuQmtZRWFXZW1EYjdhekZW?=
 =?utf-8?B?dU5PTEtsc0l5WVZXZEdhY1dvNE13M2ZXaktFMENNOTR6VGNHK0RxWXZ3VlNW?=
 =?utf-8?B?WjZ3d0xGSDNwdThhSDYxZ0xPVjF2VFVKcTk2YWR2QzM0Tnc1N1lkR3p5ZXAw?=
 =?utf-8?B?VER1Ymw2WVlDUUJoTjBmRUovRCtVUVI3OGtpZ0daeVlHNG5lVk1CcDY0c2FR?=
 =?utf-8?B?SzVWYkNvdHJOcmtwbS84NlhOdW1Yc0g1R3A4alowZVNMelhJMDFVWGR3VnNl?=
 =?utf-8?B?b3VGbGRPb3NEME8wZWRML0FCTGFzemtocmRJVVpyeVBrRS9BZ3JObGY1bGlK?=
 =?utf-8?B?bWZiT05SYmZ6UkZ4THBsTnJ1UVYzamdSOXc1QVNnTThoSU1FbGJTclBZWFcy?=
 =?utf-8?B?NytpcGNQQ1FIZ3Q5bXFjQlNrZWd5UEF5RlRvVG5lRmJldVFNdmt6dHQvQzNn?=
 =?utf-8?B?QVhEVUxuUGlBM3N6MDFKV0RkYUdURGZIeWllN2NsRGF5NGxqZGk2eXlpNllS?=
 =?utf-8?B?VzhXQnNPTDBySFF6V05pZ2RUZnZ1K1JRdG9kS1JIR3lCS0c1cS8wQnBDTVhJ?=
 =?utf-8?B?SU5QZHBtSEJ1UERqMmN4SE15M2VWNllFYUhQQ2trVjBsdWFXbEE5ZGFMTlVm?=
 =?utf-8?B?eU5qZDN4MVFiTDBWbDBIcVNlanhrRXQyRmxYMFhzNHVNaC92dWpPbmFSejZu?=
 =?utf-8?B?NlhnNTg1dDlFaVBQeDFkL0pvdHlsS1ZaY0Jxc2JGSUpKcHJSakRld1U2bHVR?=
 =?utf-8?B?V0NzNXFkb25NNGlkbHlvTFQ0WFBkczhKM1dGeGxrOXprT0pKV1BOVEI2ZW9G?=
 =?utf-8?B?V29zWWpMbTNES2pvY2hMZHpBb2pSbTl1QmJlVk1icnM4Z28vcXlXakJRdm1Q?=
 =?utf-8?B?ekd6cHFOenQ5M1NReTV3TWlPWHl5MkU5M0lnNnlhbVQweFdrWlVDWFpiRXVr?=
 =?utf-8?B?ZElQNng5NzJYTlU2SThicFBFUHFxUGZ3cU5SYVJiZFpMeTdMWENNTytzTC9x?=
 =?utf-8?B?cXR6OGNBTVlvbHMxbEN4NEVMcFlEUVpiNjZCcnFKVG1memRyUnJlSGtiUnBQ?=
 =?utf-8?B?THN2TUVIT1JLcXVFd2lSYUVsWVdJano5ckN0VUFYaGsvRUJGUWlRK0lyUndM?=
 =?utf-8?B?VDh5UzBQT3B1RlBvclJmdUhOR2hZR3JaYmJFV25YTnd2U05XbUEyVVJSMkdy?=
 =?utf-8?B?SG5TSENGZm5xOXNuRlZSK0hFczBUU2M0V0dtL3dSdkVlemg0OElLVkgvbS9j?=
 =?utf-8?B?czF1cHI3MExnc3EzNHZnTWljdnY5dmFLWVN3VnNXQk01Q0V1a2NzYXM1d2hp?=
 =?utf-8?B?M2JZd2ROTzNueElya0VPeVI4RHJMaVdIZmdhWHpLenVva3hPTWRaQUNjL25P?=
 =?utf-8?B?ZFpORzBWc2N2U01LcE5ZVzd6VDRpNmd5N3FVSWdLa1dJN3lTUnRJSVhPNzIv?=
 =?utf-8?B?ZjdzZDR6YzExSVV1RWJOL3dVaE9xcHBvUUZMaHdDWkZxRVRaL0xrYjBCdXdm?=
 =?utf-8?B?K0FpcnhMQmx2Ry9YRHhEdzEvOStuVnJsVUkxcUJLV3NKRXFvdno0OS9RaU9M?=
 =?utf-8?B?L2RHd29ZZGlxVGQ1TkV4U1ZNZUdpTXYwczM2SmhvbzgvOUswcWp5dGhkTXRa?=
 =?utf-8?B?TXFlRDVkdHpUNThHa0Q1a2lkZktMcXg1UmphRS9WV3NWYUU0NVVlSkppUGtk?=
 =?utf-8?B?bWdQQmVyRmpuQnNhcXNPaUJZNXVjaGlIamZxVWc1REpXTjk2aXVxZVM0VzI3?=
 =?utf-8?B?ZytvUFN3OFVFZEdtUVVFRWpEeHFrWTMyOWYzTVVJU1Z5MWVzVUh2elRUNE1R?=
 =?utf-8?B?VEV6RzdweEVqVzA3ZmUyLzRnb3I3VGIyUTIvVWlhWU4yWExvZmRRbXNyRm9X?=
 =?utf-8?B?aGE5M0plaW9DSi9sOGdSMmJBdTE3OVRLU3Fta3lBL1VEbWxBaEJrcHRCLzEv?=
 =?utf-8?B?YWRXWlRrM2pIWUtWb3lXRk8zS0EvQTJwdEtEMngwbHdiQmRrUHVPR0dvTFRv?=
 =?utf-8?B?QS8yNWJiWFJuVk1qN25FRTkwbVVVQm5lekhDV0pPMG4wbEROdGZjKzAvSUoy?=
 =?utf-8?B?ZWpPL0Fjb3NMRWt1R3VXYzBxUlM3dk4vZkZ1Lzh6Tzk4akcvZzV4VWJrSDBP?=
 =?utf-8?Q?GPHIFPpEIYC3JRuYDw/ylvYfe?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a2931c31-fb7a-4765-d222-08dcbd5d8988
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:07:41.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+yVrkYNZrsWk4QJcwGiqjg2q97yWjciO2MUVLnbhUDlqgOfpOrqX6W+rPrU432ubXHiSbtgmq+JGFhwFdchJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7484

On Thu, 15 Aug 2024 10:04:56 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
> >
> > From: Andreas Hindborg <a.hindborg@samsung.com>
> >
> > When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic l=
ock
> > class key without registering the key. This is incorrect use of the API=
,
> > which causes a `WARN` trace. This patch fixes the issue by using a stat=
ic
> > lock class key, which is more appropriate for the situation anyway.
> >
> > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module=
")
> > Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> > Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Gene=
ral/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.=
20lock.20warning
> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com> =20
>=20
> LGTM. This makes me wonder if there's some design mistake in how we
> handle lock classes in Rust.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I agree. The API that we current have is designed without much
consideration into dynamically allocated keys, and we use `&'static
LockClassKey` in a lot of kernel crate APIs.

This arguably is wrong, because presence of `&'static LockClassKey`
doesn't mean the key is static. If we do a
`Box::leak(Box::new(LockClassKey::new()))`, then this is a `&'static
LockClassKey`, but lockdep wouldn't consider this as a static object.

Maybe we should make the `new` function unsafe.

For the patch itself:

Reviewed-by: Gary Guo <gary@garyguo.net>
