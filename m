Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020091.outbound.protection.outlook.com [52.101.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5691E8833;
	Fri,  4 Oct 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067419; cv=fail; b=YGgltj/rIjqYOSBQIAIsnBlnV0IdenUfGIcq+nS5e0PJnd6i2NNRGpUWprPHecuOgslgNinura1Mgj109LLGbzFbTdcXYjLqjlDosD5K99wPRPvPVw1jv+15SQaVEJ2OUiMD889sXmZsDTjCcFYnqMWXeuDWZ87ACKasceGahgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067419; c=relaxed/simple;
	bh=PCeKpAzYQZcmXZ2LBpsT9tcrnK2PfvmUxdgONa2hdTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmsPaGs+3ATWPCt0+bhX+uTEhsgYqcGyFoQ2MRze3EwV2CerwyGBZ8n3mXgvlLbdeK7wTDMxJ2AgxFUhU0Xu95YKExcncSWJM18tejRsxU4WJY0A5EmmlJRH8pMz5jymDZMDsjh27zDVJ4xGV2gEitguYMwW8vEoNlJ+j73tESw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OmS02nfA; arc=fail smtp.client-ip=52.101.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OmS02nfA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erByRtvrrlywET75kESUSikuL8vnZ4HmV2MXeorJ4RlMh+3W8jr7BPh+TB0uS3yvx0Tp9uTEyZKHE6y7n6lj9Yt3fKSVT/NpY1ueHTDCcikQlJllDEVw7WW2xzErjh0kAAmmFHPh4pPaH/fNUXdJ4nAbIWO7SpffoDs+ht1XnMs6FQo9LfBZffk59L+cZBDiHgBgpIIwEMATInTDXv1PfGWBf/bDszLtEp4Bf5Qcjhy3dtlqQpbU9VVTetgYeWuunU3KlktXEHe2ca7sZWQ9sVH8KAWbUiQwk1PTGRoVQKqxTL8XP7CmsJspA8SdvfoQVRGWJtMt/0eHDOwdXNSrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSbgzJNKt8Dz1oCDD1/cxstg15mRUxiOFsLSKdS6gQA=;
 b=qdm7HYUATgFGaYA/kE5o6iw40jAzp0l75qQIX0U3oZZYcFwcqw/8gq4R8ym5Seq4S9C99s/GWcGGJ7smqgjt1RdpEfXulHg1rij2ibaWR6GOS95NZr8P2UGPSneus1vpKxmbB2T+h+ydO4xw7Smyv4ZiIMO+/h7C4daN1u8g4NGbg7mELibt8jiERcEtyN/APFzekDjkPwlOSozLsi9YXOUU938L+aULbBD9vW5q8EPrQTscBDbqzCSmmEFlawLcSKRvBjJn0hNeppJkULfeAiDu5Z9BZ9MgO0/UTT3i7Y11QewbD4BsUtgeM4w4FuF3XZZncRYNwoWHt+JrD4X2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSbgzJNKt8Dz1oCDD1/cxstg15mRUxiOFsLSKdS6gQA=;
 b=OmS02nfA/hwNwG+NDhW0TeZPXJcgznATRbYMvkZEJHyRA2G3qjeGxdMyIFfvKcc4n3ytZRVtxwSO74VHL0WVigYH2d/A6Q2eKBR4Xfl1VC/Psm8219d1aoKI4kcBDN3M6IKTz2xXHDGrwlfMmdGWxSjRyIGk4wnFR2JwrfMuy88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6242.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:249::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:43:35 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:43:35 +0000
Date: Fri, 4 Oct 2024 19:43:30 +0100
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
Message-ID: <20241004194330.651c1db8.gary@garyguo.net>
In-Reply-To: <87h69rpvja.fsf@kernel.org>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net>
	<87h69rpvja.fsf@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e968c48-96f5-4f5a-f94d-08dce4a473e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hq1L7S5pqYCQsG6Cyb++a5tnUCTo8ArgbQwQhxovg5/kD3eA2T06+K2WDzrU?=
 =?us-ascii?Q?nqLnOGVMFfQGQR2pR1Ouf+Y+VBrAmOVHfx3Mnpe9hqJKQECNdXZCdDumhBZ1?=
 =?us-ascii?Q?p5Dswi0Jb7ma25xfoddFo+vabHNwmzUdoWP/vo/GG+idLKOEDz4TK9TTnisu?=
 =?us-ascii?Q?2Odp9oBCazaktJwlxlooqHhgZ5UP1u4BdFCS0qnEUhy6F5t7/LovGo7PTvOq?=
 =?us-ascii?Q?yA6SuQkO9zRF3EvVnu7U9RwtbcZMPs7NxHYTbG1EqsG7dyS1UWgzEFdeYS1k?=
 =?us-ascii?Q?P1kiooF9JBIkmnUEogn0Eg9g+pt2UhZPUpDJ/dzsdCW7dBmB0IHHDq6tPToU?=
 =?us-ascii?Q?/t/O4+DAOLBuDeeDYaCshS+3ey5WJwtGAh0wUn8m3QORqWpEpL9fSdr0rS/k?=
 =?us-ascii?Q?yv/ZxIKsf19tnlE3Lkp6D2yzd8x7gSknv6j/P2H9qyPO8/HFxQGSAR5svrFv?=
 =?us-ascii?Q?cOTxXl/Li8pqe2vsyiwgSA7B7Z819nIwA2TQmkbvg8KbiugrW4+0Qd7Molg3?=
 =?us-ascii?Q?fkeeRjBN80AwGdXifB0litom8swkSiqW7BQourIu0A9Yj76nwrIy1py68/Ym?=
 =?us-ascii?Q?xlig3UfmDvbxhpuCXxUMOEpgarxtionCtknE4+rb6qEdh1lVUMKc65e7XAUE?=
 =?us-ascii?Q?IT1OGGsvdtwVTXBwbeoDP3o7BUuPcPZZPcXjP5E9y+4BuBm2h5ob+l28prhf?=
 =?us-ascii?Q?mu1svrxcqRUvedkzMTWFXV01Z+Ki0fP4ffRhiqDqiaNERp6tWNGFQnJzNN88?=
 =?us-ascii?Q?PBczUumwCP5le5hYgvhXUST/YTEDwrn22t5fMirq3tzBOuFANyAovYfHYcyX?=
 =?us-ascii?Q?AtqeEqkrJ8q3m+rhmkxXZKNhNYVsxyH6h+rgCYGWB6vLOdyYR0/wOG945baT?=
 =?us-ascii?Q?dKE1GVKEzxkopuEEPBNYCdgW3Pkh3HZTac3CgwjVzI2bPjESS6G9/K+61P/z?=
 =?us-ascii?Q?bdabbWJLBPSKBkZIk8fg4Ywpv9qTt3dGpIpv+5lRcQCGlaP8aRTt6aR/LP9L?=
 =?us-ascii?Q?eMWouzyW9NCsfAwDbnfukQQ2XolX+dsgFrEC9MHWsqOvBGlqDCM1QEgxiQXi?=
 =?us-ascii?Q?XU50juoVOPiVLAY1FlsMDSVAAs1dPXRBbrk522/abv32TI1QDRc91NUPlK8v?=
 =?us-ascii?Q?kkZ56KmFMLvBN7mt+gMpAc2kzfWyb5uyCgJTomAZs5C2lIhbWyX/5bhcdPyw?=
 =?us-ascii?Q?NQqDeqod/6T1LFdL7wpXqJLGdWTTCtIa02tT64+zRtC1Q57/84yyFkaMBIPP?=
 =?us-ascii?Q?oZ1+K0YVAl2TKkA93X6oC2oM5reAoX9+TVaymwP7lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ymtSFi53DUSjB9tPyZqDKZFU1xsjTPuhMWD7S5nwPnP9c79NA1Bl9n+iruF?=
 =?us-ascii?Q?BN4ud2e/W7Ukc2phCvgKvurLxf2/ErtvDvPtzv97F0j3pEXnR695MtC+1oz6?=
 =?us-ascii?Q?l88Jnz9E8lfeJyp0umOH/CIDsMHwCcGYFeYqMfVB+uLaNNp3XmyIqkU6lhRp?=
 =?us-ascii?Q?DgpKscrDc3wSUQiFcVvNROzOBPQnTk/1okYBFKWA5aiIQlgiVxH/X6s1eb6O?=
 =?us-ascii?Q?gCNkYnm2ry7b5BlMF2fXhFLzAx0wmk//LDw2wkJZRJxmTqEyG+dPUVGptK87?=
 =?us-ascii?Q?SSMDjBtcVNAZcLHRBW61zG2lirzBslqaX6nr56nwG4CIM59xlvKpylhRmtZq?=
 =?us-ascii?Q?2KbG2ra+QZP31mT4P3SBvKQLl5c4HLwTI8q47sYb4pogqHcZSueNo/+Af/PJ?=
 =?us-ascii?Q?vgo8sZ0Pr/o+zlhKme0MNJTcMsyaHaGp8BB6HH49nJXCgY9FpL/R8vdYRFzz?=
 =?us-ascii?Q?faR3DXuE/nIQxHzDO4+/Pw9mM1WZMjNDTSEJRyCtTJbHJGq/4kPnzINmXB1o?=
 =?us-ascii?Q?LIuL1qypGD9MOpT/kqnmBIgbxh1Oghn/40BuNAE5EjDNNyrpeJcyNHMSd53D?=
 =?us-ascii?Q?78ybZJAOuWZW+Red1zWQjjfBaXuheqTfx2LAh9fDseY8xJTEp5natu5tmBD3?=
 =?us-ascii?Q?am59Jz+JEUZHs3p8jkD6jAHYdoWXDnHdfeOGGt2NAl00QQ2IGtxxLhuRcNBe?=
 =?us-ascii?Q?ffcBg3NDt5gBzznKcrWIkU3L54Jca2LiFExm8c36c2MnTzdbtfZcDZjRTPhU?=
 =?us-ascii?Q?vRyrsSqBtFp2MCVMRU6zNA9bsiR4so5bhbsqVYno595b976de9QQBFRM9C84?=
 =?us-ascii?Q?mI1/hTSaKw1GF0EsnHh1pwBrMKzdn5NRHDNnkCbyJcgOrzS3PsQS26akuhfE?=
 =?us-ascii?Q?UyIxxY1xRq9HsFurHROonoENeJTpMx6nrSzafH9lxFXS93/zbSZZ77hWZ02c?=
 =?us-ascii?Q?dU/Y9HEM3cYHVBfU3h5GmHJ/WnICQbNVtbTyi7uEU6O/0ZbnGVqBU1bZyh3M?=
 =?us-ascii?Q?svXZ68sESe+9VQrbrtqNI/D6XtvOV3Mtvzs6EUIbhs2gsVcO0X9klaJ/OLgw?=
 =?us-ascii?Q?FiWPdvFfW46mSp8VPEDZeAngctEJ6VQZec2LGeUikoP5G2sqJgui73MIGc+0?=
 =?us-ascii?Q?CIq6ctDtF7A/2ulwRsUPpbU114eHrwtjTSswUqLd1NCSmoVnHhVcU9bie+go?=
 =?us-ascii?Q?F0ZfE/+cOW2J3acbQR68ne12m0fai3zxNvKB04G9pMpn+CreRF9f4uHsu77u?=
 =?us-ascii?Q?YbH1CEiTWn0xfB2YUr9HLXY0D45SoZnMuqijrv+bip8bGP9IcjVSarEfKmWd?=
 =?us-ascii?Q?XyJuAb3EGD7Ar0TX85J7j32yO985/14xMRzeHpm42L1lVREpM4Npd+NK9h2U?=
 =?us-ascii?Q?5Jsrde9EOFAljNLwH0fIh0CpoII/+iI26R/4x6NKQlKt2URTUfU94eNnEFYD?=
 =?us-ascii?Q?+zEGSy+OygAE8eIbp3y/+Zxv9aicsiEDbcbb0S33OTGijVXm8bWduvs+MTqb?=
 =?us-ascii?Q?QE9+Asjm8dqfDPMiw5frRVIUKXhGvOQLtkNDeUoTO4zHWBlN1I3GE7mz0oWR?=
 =?us-ascii?Q?rJAsDAoYHOYvnlG4zaUDMS52ihnx0elAkJdyhlbM73Ki5qqM7F3wGVjW18pV?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e968c48-96f5-4f5a-f94d-08dce4a473e2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:43:35.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P856HHUxdOQMfd7OyzH/6/d6p9e3o9ODrHGeeYFgK0qk8YLW6ZWKG6tb0AK4+1ksOYkUaRoMeJ3MahDr08zQEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6242

On Fri, 04 Oct 2024 20:34:01 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> Hi Gary,
> 
> "Gary Guo" <gary@garyguo.net> writes:
> 
> [...]
> 
> >  // SAFETY: All instances of `Request<T>` are reference counted. This
> >  // implementation of `AlwaysRefCounted` ensure that increments to the ref count
> >  // keeps the object alive in memory at least until a matching reference count
> >  // decrement is executed.
> >  unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
> >      fn inc_ref(&self) {
> > -        let refcount = &self.wrapper_ref().refcount();
> > -
> > -        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> > -        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
> > -
> > -        #[cfg(CONFIG_DEBUG_MISC)]
> > -        if !updated {
> > -            panic!("Request refcount zero on clone")
> > -        }
> > +        self.wrapper_ref().refcount().inc();  
> 
> What happened to the debug code?
> 
> 
> BR Andreas
> 

`refcount_inc` will WARN and saturate the refcount when trying to
increment from zero. This is true regardless of config.

I've already captured this in `Refcount::inc` documentation.

Best,
Gary
