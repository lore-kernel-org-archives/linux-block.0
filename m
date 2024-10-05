Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020136.outbound.protection.outlook.com [52.101.195.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C6D520;
	Sat,  5 Oct 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140949; cv=fail; b=mwRYXT5Oun30eq3sUKSqSV8xHHpx5D+ZooucK0qtYmdOo55tzAWentS4AMxf0ntPpmY3WxsYbt1whTqtEQ1z2SCKmjix3Ki2NcuzACVq6KdSFRKLTIfWzJTyqeC+RJ8lUF/IxVZ7LDJuJqGPiEnMFiRbjTu8aRc/CID+qibeKPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140949; c=relaxed/simple;
	bh=/SE7sX9xHzp0MLebvOOZxse+8nDCU3Ee4a7gDFPWb1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FLfA5+di15weDLgU3pD/7uCaOkEcIvVoskWuJ09NAvqvrNnknc63+txwPuQQc6BDBShzxD0driJwSZszya4k6QtrmtffAgFQYljFOIvpaSBY/3Hf+Dg6ReCC+mr5chMSq9HAlnWCJChEIARckfOy04ZNAWQhWvBGrlvCEy5HJ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tNgJNbVN; arc=fail smtp.client-ip=52.101.195.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tNgJNbVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJC+yVOxdo+KnclZKUUojfoUhSHFF0Z6dHStNS2D+9AtDwZddHIzTqD8+u1vWteP89sXn2j9pg9EZhsuGw9vQRUwei6+XlbNPfE1PNB0rufz2nWW4cdaTojK9qM6Pj+R0F3cSeww5fAuOW+HMv0cDOQQ7uH0MdINU3aBnIX7rgCKAsbwsQauA1WB9jxpCJpquOy4Hsp7Vn+fr8tW5aIDH6D6rB0oEfgG8wjSJGGHHoTCU3cHK286FaoX0NxTr2jSgiPxNOUA+KwRVIXD1AwhWbe23Uw+Fgzu+QZmrlW8/NiU8VL8FzB7YEsaelQ3nUbOgfzbuOtBavBGuYkyw4ND8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfILzz7QT8Bp+gjQGD/S4nH6xV9xyBSa1EQjsqehFrY=;
 b=qBHssqZoL18Crl81Tqjj4hqDVc3Are83Bpj1YikyOBGJ0e4jOw2BzP/QNDA5TclwCjDoZhm4v+dJKEk2G8oanmhYU+6NL4wCbAtVorO3ASTMUXUdMChFKQDWaEELZWryMDICqcz36qDT4VQ+F8YHH8qC5EcZ5lrYcvCoO8HFEw1fctM98Q+4yFyzzoTmVJwwNYJlRqDsIuxmewVTdGys+slkVNm1dWADoN7LCc2qQBcBrjxP6bDGAzptm8tC79/P54gR+MppaoA35Fv2XQtQnBThuVV3ss8Oa3beUhTjjupqYhTOEK5aBgptifi9qA1fH2VtisxyjnIxDCnq11bXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfILzz7QT8Bp+gjQGD/S4nH6xV9xyBSa1EQjsqehFrY=;
 b=tNgJNbVNLw2WiT6eWFlnoykj5moRubeRMOOPBso2WUphzD0QsT6chplB6Dwt5qDGXvGqEmOpBoFUfG7jbmNED4jS9MhPYhd9T9Yxi12yhz/OErTH8agHsdfT6x4n6wttnB9LBnRBEmuHM65dYIFQ6+SDsnxxtY46RH7uWmgY5NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1802.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 15:09:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 15:09:04 +0000
Date: Sat, 5 Oct 2024 16:08:57 +0100
From: Gary Guo <gary@garyguo.net>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Jens
 Axboe" <axboe@kernel.dk>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <linux-block@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <20241005160857.537ae04b.gary@garyguo.net>
In-Reply-To: <87ldz3pwui.fsf@kernel.org>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net>
	<87ldz3pwui.fsf@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eade774-66e1-4146-40e8-08dce54fa692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69I1i9dPpt5jqerRu/VsbbD2aMLbnILhU57kjy2Lbk2b4Irn40cUa2zmkNZt?=
 =?us-ascii?Q?0MNCGz2hWGcJI6520tqTNB4fpeviEYsEpHHwuLIxsaIWhDR/HTG5BUz/1qJa?=
 =?us-ascii?Q?pMenqulUJDWGZYX0n2VIcwEdwYNXqo0h8CQrQBl6wjuAJHSVU6R1XrCgXhGG?=
 =?us-ascii?Q?uNbGnc66zrPw4mEjiv3sZ8q58V9qt8hp/6P+1kZKcmUzr3r1yBeaGzD2bcK+?=
 =?us-ascii?Q?BiaovaVFRAXS7wCrCwZ1nMDZnCowT+lwdKBJ4gXG81Io3PwJsbYP8iMWdLeC?=
 =?us-ascii?Q?Ze34Uw1zIzpczoXPCLNmnG171xVPMHbdgUmpyfsPqruVk8JHYLNJs1sPHumw?=
 =?us-ascii?Q?/y8mrMffd13dDFFaJey/bgSKlHCQvyJjvR0Mhl+gr8ghlnhIqwm/xpIeUBDv?=
 =?us-ascii?Q?8XJuxivHSIqN7UoaIOkEiTyLv9zbM3dvdGpYHWV8KOmPJccdpLfhOK76n41Z?=
 =?us-ascii?Q?2J3vrcrO1TVUPoqLbNTsKrnEf/xYy0KMR+CiI8Yyacwx8s+plnRGULecgR9r?=
 =?us-ascii?Q?RKBXHHjhMQFdK2tOaPAQ+vDJ/3b6cmtrB+w+/xceYT6ro/O5GN46qVgfZlCT?=
 =?us-ascii?Q?n2se5bOpRwdXF+rokqabLsiH5dgbVoNvUpzvFdeNP1dos0nrUhh+MNrCuYgk?=
 =?us-ascii?Q?4SCt/FGqbzIgd72t+rXP5q1psnEOjAji7Ph1ccf1M+BiXmR4Tk/YublWk6tf?=
 =?us-ascii?Q?8QURQ7DzteUYMpfvSBYKG53MLQgEKsoPkSbO7sglORXth3qSGQOn6MqKdYnu?=
 =?us-ascii?Q?CUKkaTBW1tAQaSMm6i4yk71HhcWIBRSr7j1HZIdZtUi93hg+pgPPnTP2ER18?=
 =?us-ascii?Q?r8iJwHMXE1ou6xLe+HOO+ZOS2naQpjMqzhOOzKy9zKt/aFjpSLupkiyGxEQD?=
 =?us-ascii?Q?oWomkzfbTddg0j999OSWbSvBA7liBmcf/uZRSxn+8YPbucc+S3D5GDNR18UC?=
 =?us-ascii?Q?LX4SMTeeOqxe4Ze0v53KmxlMnWvdTh/vjb2hBCiyKqib4b7bFRd+Ny1DxANG?=
 =?us-ascii?Q?jlS52DxCiauV6Bm8l5S61Co9bv9oi1VCwxDlfiyWg2cRe/Qh/WqnTS/DcoWO?=
 =?us-ascii?Q?n+t1Hv3OzVU7SwNElXQuQpohL+9xnwk3oYwxzKRXF9COwG+x4VJGhwhXPQGL?=
 =?us-ascii?Q?wbE3/k6RKcWkhI2HawClyogoUeGev4400snnIMKXcGRlaISSS6gDh2Xs6RFs?=
 =?us-ascii?Q?DFG1LvanI0F3H0PBNZ7J9w1YgEqBqgC3yr4iv6SEOp3peLEzG2RdAPxvsihC?=
 =?us-ascii?Q?7rZiQReMPkOhV8/dk8F2fzxEnSDGREgDopk93Mm2JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXf/aMyG24oSv7hfUxa/D7qSMSMVg1zqN2s9HNlBDLDivpDNnQew6YQgXiBH?=
 =?us-ascii?Q?IM5gXcj2FfykZkuDogUpX+P5VKnUW1Cv25s14naXI2+mC2X7I2gRP3NAtYnN?=
 =?us-ascii?Q?5/SwPq5x0GJ3DqYIYIGSU/0u3MAtWBi0EqJBTgXMcfLIw3twQ+8579czRYfS?=
 =?us-ascii?Q?7HRww14vCPpzYagH6jFjgZjkj3z4l/K5dD9s059U9OPiRWtaX3bq5m/uqMey?=
 =?us-ascii?Q?kEda+9jBuveafOrwqyjXaOYw+2tAjDDDCTHlqtjzgiQ6556yFsCB6DqSUecC?=
 =?us-ascii?Q?cSTxRTO5qMsH5G5o6nQwVqC3R+V+sNArKhGIlj1P1PT5BfOlBu80kbomSXfX?=
 =?us-ascii?Q?i3+h8/U+Wq/B7J533iSMVg1AN3HHF6xvYqma5k0+1q1z2Jqvx2CA1QS2h0WO?=
 =?us-ascii?Q?IBJRbDdL4Sutweh6GcSPdGYkxNX2KChI9d/42cv3vCFzjDQqygy97H3n4ZM+?=
 =?us-ascii?Q?8MfEdc3wdKQEvZtkTMZoPjSBEoj8g9FgOuAbn8J93BvyoOTJPSEpj7VeZ0pd?=
 =?us-ascii?Q?XcLMzUNDLRyl7p8J9VlTLX4FAl7EKK+P82qFX4QOrLG/GqHlda35+c0TLAd2?=
 =?us-ascii?Q?c9WLRgOYVRGX1ceS6znCLZlYjroo8HC9TfhNETBDsT/fFpcstpsfVr72E+EU?=
 =?us-ascii?Q?7+8HyWBNWs47KCOI2dsd1sZVNqsatr/phiXdmCZar6Sfn9EoC+YiwOufnAQZ?=
 =?us-ascii?Q?s8IsnXzfKYgNBuyAOPkx6K5UQXZnEu+JA/HAKqb7sE46mN1l8afVyAvksERJ?=
 =?us-ascii?Q?4agfhfBwP1BNzOUB+3s3nkB0xEG5N4l2jaNn8PVGytdWsoslegS0LqUJfYlN?=
 =?us-ascii?Q?Wv335vYHoEL8HRy4VoPexppckGM/sO++eX6RnaJaOGzv1zyVZ/KxKniUwPdE?=
 =?us-ascii?Q?Qy7cavQLnQLBFKoK/a4LZuSSqy2G8LynL7Ar+edWrDNERzAngDVwnj1r9vlH?=
 =?us-ascii?Q?Roy7iSWPJ4MotHFoZheBiBrVwg0bASMKIT0yYgeUd5DlW9+lzu2GfgW11VtD?=
 =?us-ascii?Q?gM1NUcBee0utXrSdjeCRT9LyhFZg8MsOSwcgE/ZVb4mIT8IGRKzKaoXp6Tt9?=
 =?us-ascii?Q?X+DeGkm8uJHE47Nte97U8qJQTALdjlaCgDV4+bxq03f7Kl6Rjvu7TLk7arON?=
 =?us-ascii?Q?kN2hbq+gsU2vlBhVz86est/qrDRAOG+noscdLamX9uv7Shgi8nlZeCTxGyiy?=
 =?us-ascii?Q?iWBbqEQp+BAyrZCyXZ+/lU5EJ73MPvPrhYcoiVjqZeeK5Wip4oO1VUowgBiV?=
 =?us-ascii?Q?+1AU52JY1gS50cbOBrLPho2zt7boEphnZQVrfyxQvdEStAYLIQmccpuT0SYK?=
 =?us-ascii?Q?sxBMj5T8r09OBs6t1FOGx7w6s9w1ItAc9OuzgAVcHKc1kIfglSttVe+VY2D/?=
 =?us-ascii?Q?R6/WAH0RHlI8TIKPuAogfKEdOYgM2nT8TBq2a3B865J07MNPO9mwjK0f3Zg3?=
 =?us-ascii?Q?9Y/FDJ49KtlDM6uDZFqU47fITmqBXZsAGqV9yf2vo6k6U3nHv+Qu1bqYx4We?=
 =?us-ascii?Q?Te4yYl4EKe9h/2EQPan1StzSq19IvRZScggQ1fo/hKQY1fUge2wOTPZ/OJuq?=
 =?us-ascii?Q?A/2yJyP/5+itv1Za+QnUHkiqYEyHvQX2ZlwMQiraVO8KvRn9xM+nu6FO7EZV?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eade774-66e1-4146-40e8-08dce54fa692
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 15:09:04.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7IoEvJ5FHegT45L4x4zia7GH+oDiAzSAuLzbLpRxT0gBcpDvXRGvZBNeQo3NyFMgV6Y3iByupALLjtZDhDCgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1802

On Fri, 04 Oct 2024 20:05:41 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> Hi Gary,
> 
> "Gary Guo" <gary@garyguo.net> writes:
> 
> > Currently there's a custom reference counting in `block::mq`, which uses
> > `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> > architectures. We cannot just change it to use 32-bit atomics, because
> > doing so will make it vulnerable to refcount overflow. So switch it to
> > use the kernel refcount `kernel::sync::Refcount` instead.
> >
> > There is an operation needed by `block::mq`, atomically decreasing
> > refcount from 2 to 0, which is not available through refcount.h, so
> > I exposed `Refcount::as_atomic` which allows accessing the refcount
> > directly.  
> 
> I would rather wait with this patch until the helper LTO patches land
> upstream. Or at least let me run the benchmarks to see the effect of not
> inlining these refcount operations.
> 
> Best regards,
> Andreas
> 

The helper LTO patch series still need some time. I'd want to be able to
test on 32-bit archs in the meantime.

Best,
Gary
