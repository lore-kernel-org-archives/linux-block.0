Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020089.outbound.protection.outlook.com [52.101.195.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7D31714A;
	Sat, 26 Sep 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466800; cv=fail; b=G1hm9QtIjkLd19b7DS+3LLiG9vl6hEbuj619mqTH7dDtgcX/CBkUcfRzCq3DqBajd4Y/q0HvpPknWagh2esubcrHx8rzyPW3suyjw06vXGK4mqfRwmvOkbdBUKVonIaKcYt5z5mpiuacyq8lujK4Se9nXFfDxQy8/FPJRyayx+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466800; c=relaxed/simple;
	bh=JLv9xQr0LQSI40mI2ho1bO2GVygTLVLa3MuNklTI398=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EH4oR7Q/+Oa+/zIfwzhil0S/B4ZL9Z7voNLWMuHEf2p+bZeeryo96RokiKokl89TkHdUGq1H9Uir3kyk6ldLmtn72PXnzW+/aJ5T8DklS+4vBHaAAnn2DFAexHtDenpqJQe7UkygOlT9nrtK16/kbRDfJJ6mgMkI/dVoAS0GDcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aM7Vn7TB; arc=fail smtp.client-ip=52.101.195.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aM7Vn7TB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY4Sjd8XmJnBJJ3UeH4J5XK14AjIXs34Lc1R4Wea4dkaD+E5ZwIK4gtCq5mKmJDT0e/dsi9/QQ7nszH41/Raxz6XNvu6k6TjanwKUNNXfJ2wzJw/eB0LCD7BISr5caMSZyqRvldjkrpsu52b1RJAA80ohJyvi+LViXLLkMsjcbKl57UP1lE52EzvZoIElnlAQ7cYQJknY5lCRxeXzvyeRHOwRvNpFTbsWuYroFAOXr2HLE0NRkxNqeIlnZ9y14BuH0OOvTebAxgNWwcaJXTzxNtmnsJjJvdiWIQ7JFPmT0vwZn9o17oAksrbz4/SxW1mie9OTh4agrw9IUWvC7w0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uCiMOYKVlYEuck8qKFS3hqmst746zG8zo1jKf3MxgQ=;
 b=bvFme8LhT33a4kCjVmOYGp5YeFjZGwxwnb5XM+AIP8ChnKOCQ2sOodNFd6QaOXo4RCSB+nAfeVabWVW3Gxd7gaEQzd8IZHh+hYxBoBoyp8nYDmaIvlUQoh5VvaNusC0nNFNWgmQ/Qy753kDtS886jZ6W7LrxUiwycX1BlQw/arroYbQyy0spUCCFVBnaY09HGcQp2+3c7vsTkgkWMSZDc9jlFgFeOsPqvR+5Zj3pfZK8YnUQ8FEeVjKGPKGTGGLvr7SA4BI3oJfhWtxfQwwLRoaFKzetiBMJ8oih4g5yHvEPN0fAOkqXLp4S4WE9xazyB3PNACqygSlC/75jVkD0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uCiMOYKVlYEuck8qKFS3hqmst746zG8zo1jKf3MxgQ=;
 b=aM7Vn7TBAyrpp6n+x/C6zwUmiYO9W5enekwhRwvBoiwsqT9zkSvb291zZ5IDql7bsEkuMdil7sIJQZGFfCKXzql5BJaXZI7eXkkvntJd0flGg7KdyZkVJEmle6vdp+BqcG8ALAuFDldQliQ9G+hz1g36A+dSkcXkQW/mXv4wltE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7837.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:213::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sat, 26 Sep
 2026 23:53:16 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 23:53:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 00:53:15 +0100
Message-Id: <DLPNIATK93BE.MP4DZTVSAEPN@garyguo.net>
Cc: <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <daniel.almeida@collabora.com>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <longman@redhat.com>, <lyude@redhat.com>, <linux-block@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] rust: mem: add DropGuard
From: "Gary Guo" <gary@garyguo.net>
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>, <ojeda@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
 <20260926173315.56772-3-mohamed.osama189110@gmail.com>
In-Reply-To: <20260926173315.56772-3-mohamed.osama189110@gmail.com>
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: f15b9051-73e4-4afa-da62-08df1c295586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|18002099003|22082099003|4143699003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	d5SqxdcAoCjvfQvU7vq9JhwJqv0i3BWJf8uVhH0DeiUcv2VxFks2ErkQnYGTBsnQejfX/8nbDkfGghhJwNEp7nojyyr7ZfzxqRWSioYJYmwnhTEdJR9RqEd/brFX9QelVs8vPafCEKO4K25/jLRV0ci+ZYswfZQLR8ovWt1qB0vo7X+YoLJvryAltxJ6dg7dcN6o/lhomydfFlP1p/4aYtQJsaI/S1JNf1GNePWeACjqnD7PWOHT8fSlZMHiYxM7CjLt90oIiEWSiTVWkrcDEvysjIrxbUQMidexU/pbwz4wV0V5rPW05U5dcC16sv5VRDikYSWawRfOpuUQuo/t3pnOYrdcBih48g8J7aE9rXDrIPaI7yw1ZtWs0415FhzK0Xiz7wLfveOWweW7Zeoudqj3kPVAZMY5vMSzZy3TSaFS0KsoyyvzkvAphVrabjf++4swTgmCqFSHR7wk/VTxQVzwse/NdRfcICyh07Nql2LiFXk3Z3TW4YFaDUfDcGj8koTomnPfY6WlVqgmBLn4T5GDl7kXetuZBcwVntLYn2Mh5eFRHR5qRjQsYkcjobAb0GYjvx0CoxY7HMLVl+48UOn5oip3dHmqKNM30hjyPY+PNDGRQurX/ldjdgreLlxWcJaa77fdC04t/7/39zwBLb5gFTbYxQ9w5nzyfrJDtUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENmK2U2UmN6V1BPZG4yYlhnK01vSjdYaUtLbFpQNXJGK3AvbFJZQzJOVGNp?=
 =?utf-8?B?a29WbWhZUi9UbHI2a045eTBpTVl2eC9PNE1pNDVybDV6aHVINGtXaTVsdjVU?=
 =?utf-8?B?blhFcTViUXA2dC9ReGUzaXV6M1J1eTN5MjZ1akJ5SlBkeGFnS1BrQlFKKzNK?=
 =?utf-8?B?WU1tOW40OE9KY0hzQ3dKYmRuamd6Rjlja3hTS2FZL0w1aW15cFlNYjVTMjZ6?=
 =?utf-8?B?c0tWUWZoN1lNbDdKVnVraXdLWC94ZFBxSEpodWwwbnBXczZxallnbE1PdWJi?=
 =?utf-8?B?M0V6d2dtVTFGSE1kM1hLZEQwcUY4ZmI5T2YzQ1ZFTlc1dXFXaHROUEVjV0dD?=
 =?utf-8?B?T1N4NzdSTWgzSG9RcVNWVHpQZTFCd05WdERwSjFWZGszRUhNc2x6cEYyckY1?=
 =?utf-8?B?am52OWlIWHA5OThjWHUvU3p6bDdjTXFqcThxTldPdDBGczJwL01lQTdEUlVo?=
 =?utf-8?B?YTJXSFJxZG5UdzNHZjVnQnB2S25QejFRYnZrRURFRnk0cC9NZ1prRXVtQUxx?=
 =?utf-8?B?M1dkcE9rcGZUL2JkYktFUDRwZEwzM3BzU1VzZ1VNS0tKVmpnOVdscHlQb1Rp?=
 =?utf-8?B?ZmtMUHhVd01YYi81Sy9IUU5iaVZYanR0U3NmMW1vS0F4eW9XK01HQ3JMZVlo?=
 =?utf-8?B?T1pKVlJ6WGZhMHZJZzZTR3dTUjFGV2ZLam5oMmFMZHBZUitSRXczdlY3Zkt2?=
 =?utf-8?B?SjUxNG5lNWxTZVFvQm15SlNFV3hTTUIyMEJ6U2Z0czloOUhmN3YxK2pYLytx?=
 =?utf-8?B?aGdqSkFZUmx0SE5Kc2RYVzFlNXhNUy9PSmJST01BSFdkcVJkUUFGSUhHUk9Z?=
 =?utf-8?B?RnVZMGwvT09hSzB2djdDMWdUUnltdm5RTFlpSzU1d1o3WTNIckc2RlpKeno4?=
 =?utf-8?B?TEZyMnFaelBrWXVrYjdWRnVkTUVSTFhlZUFqcElDbFlXVmNBVnhUVjNMRU5U?=
 =?utf-8?B?ZkdhMXFUTlJxbFRzckM0MkNETGF1cDVHcS9kZGM2VnZJUnNUYUlnU0hiQmJ4?=
 =?utf-8?B?Y091NGVVMVJiK0tzS1RMaG9OenpkZmNxdWtBNlBCNkFYTnpWNDFUODEydS8z?=
 =?utf-8?B?b2lEMFlpdCswL095UktnYW5NdXpoS04rVGxKMmh0TVBqSVkwdzVmaE5NNUVr?=
 =?utf-8?B?SzBVeEFuWUZlMytOUjl5UGtuWUhWTS9EQkdrbkRPVmRmLy9aOHpzMC83SUtG?=
 =?utf-8?B?MmtjWDJtU2xIMm1uWG9McTRjeEY4cDVBLzhUR0toK2NPUkdlWFAvVmJUcFhO?=
 =?utf-8?B?NUtzcEpTQWRwL0tValRFY2ltV2JxdWtwYnhzd2I4MHV6TzRtZnJVRTBpV1gr?=
 =?utf-8?B?d2VwUTkwSHRiMjZ4NjhQQXcrU3Jjc0oybHBPSEtpZFAxZ0VnNXN2alVUR09R?=
 =?utf-8?B?M3NBbXlZd01ZblhzbVhNa052WTUyT2hpQ3hINU91MHEwcVdUUWFHampkOFla?=
 =?utf-8?B?L0VpTjJ3SStWUFQzRDF5N1ppdEpXbkxpdk1EeGdkcEIyVzQyeVQ2SG1aaW5G?=
 =?utf-8?B?eXA1MXRjc0hIM0c2OE5EdERYamppOGpDZlNBcEV5R2IvaWdIaDMyQ0ZOSXIr?=
 =?utf-8?B?ZTJUeWIxS3hkQTBzWlozV0pJKzZwTDMvR1Zua2RpdERDUnFpTDhTdzA4TUYw?=
 =?utf-8?B?bDBsNHBpSXBDcXplZ3QxRkJaRFdhbVgrNTdJRERld0xuam5mSEF5dVJ3TG5P?=
 =?utf-8?B?UGpDcS9WNFZmYTF0VitlTHprRHZEZStEN0NDN0RNTjh0YlV2WXJ4Y0RsK2gy?=
 =?utf-8?B?QlZFSkJQMHNTRk83MysyellsaENPMUw5eFgxQkZQTkJrMUtRZ202N2ZpUjE4?=
 =?utf-8?B?SmtUWkx6cnl5VzI4MFhocERTMUxNU2JISVNCeVdlVlREVWdvOWFzTWNmU1Bu?=
 =?utf-8?B?djMxc0x5ZTgwNVNINi85VmpMSnJzZmc2UG1hQ1BYR0NtanNUUExhUDRVaWFG?=
 =?utf-8?B?VjIwS1RHTS83NE5WWlNoMWMwVS83VWNkOU9rUWJaZkttS0VZUnBkVHBSdHFv?=
 =?utf-8?B?cXJwVmVId3k3bzdoRm8wdHlzaW9LN0Q4c3Rrc3A2Sk1ZL3RkTFZMaUZxUGkv?=
 =?utf-8?B?QURZQ2ZkcFJKcUJwTXkxMWlZc0MrTE1KQnhUTlF3Z0Z6dSt1SW13b2I3TG5u?=
 =?utf-8?B?a2dzbi9iZHZjUldtZGNWSkxqa2VhOFowK2Rzb0s2eDIxQ3lSRG1haTJJL1F0?=
 =?utf-8?B?WlZ4NTVHdmEyckJ2ck1yTXNUQWNYQXlCeWU2OU1FYllSTzllNFhKcWtWSDkw?=
 =?utf-8?B?WU5XejNQYVNONVlxeFl6bzVXZVhTUjkwcTFoYzRhaEl0b0pPVGhhdjFsWUFM?=
 =?utf-8?B?V2t2WC9VVG9NNlRDL1RQNk1RSU5DRVAxdzFSMWEvZDdiaWVNOUYwdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f15b9051-73e4-4afa-da62-08df1c295586
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 23:53:16.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtgBDN3p+wSjozm6eGPMttgDnLMSpmompkJ2C7njjaQxBwZ6g03wodZNhvcCOTbOPgo5jhk8w0Kuno0qLLFvpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7837

On Sat Sep 26, 2026 at 6:33 PM BST, Mohamed Osama wrote:
> Add DropGuard to the Rust kernel memory module.
>
> DropGuard runs a FnOnce callback when the guard is dropped and provides
> dismiss() to take ownership of the wrapped value without running the
> cleanup callback.
>
> This follows the upstream core::mem::DropGuard API, which is being
> stabilized in Rust.
>
> Keep ScopeGuard for existing users rather than changing its API in this
> patch. Migrate the existing users that can use DropGuard to establish
> the kernel API alongside the upstream Rust API.

If you're vendoring code from standard library, please put them in std_vend=
or
and have it re-exported from kernel::mem please.

Also, if the code is taken directly from std with only minor changes (e.g.
removing const trait stuff and add `#[inline]`), then I don't think we need=
 the
kunit tests.

Best,
Gary

>
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
> ---
>  rust/kernel/mem.rs | 121 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index f2d4cdf87d00..e7a84d15f3b3 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
> @@ -4,6 +4,93 @@
> =20
>  use crate::prelude::*;
> =20
> +use core::mem::ManuallyDrop;
> +use core::ops::{Deref, DerefMut};
> +
> +/// Wraps a value and runs a closure when dropped.
> +///
> +/// This is useful for running cleanup code when leaving a scope.
> +///
> +/// The [`DropGuard::dismiss`] function can be used to take ownership of=
 the wrapped
> +/// value without running the cleanup function.
> +#[doc(alias =3D "ScopeGuard")]
> +#[doc(alias =3D "defer")]
> +pub struct DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    inner: ManuallyDrop<T>,
> +    f: ManuallyDrop<F>,
> +}
> +
> +impl<T, F> DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    /// Creates a new `DropGuard`.
> +    #[inline]
> +    #[must_use]
> +    pub fn new(inner: T, f: F) -> Self {
> +        Self {
> +            inner: ManuallyDrop::new(inner),
> +            f: ManuallyDrop::new(f),
> +        }
> +    }
> +
> +    /// Consumes the `DropGuard`, returning the wrapped value without
> +    /// running the cleanup function.
> +    #[inline]
> +    pub fn dismiss(guard: Self) -> T {
> +        let mut guard =3D ManuallyDrop::new(guard);
> +
> +        // SAFETY: We have taken ownership of the guard and prevent its =
destructor from running.
> +        let value =3D unsafe { ManuallyDrop::take(&mut guard.inner) };
> +
> +        // SAFETY: We have taken ownership of the guard.
> +        unsafe { ManuallyDrop::drop(&mut guard.f) };
> +
> +        value
> +    }
> +}
> +
> +impl<T, F> Deref for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn deref(&self) -> &T {
> +        &self.inner
> +    }
> +}
> +
> +impl<T, F> DerefMut for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut T {
> +        &mut self.inner
> +    }
> +}
> +
> +impl<T, F> Drop for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: `DropGuard` is in the process of being dropped.
> +        let inner =3D unsafe { ManuallyDrop::take(&mut self.inner) };
> +
> +        // SAFETY: `DropGuard` is in the process of being dropped.
> +        let f =3D unsafe { ManuallyDrop::take(&mut self.f) };
> +
> +        f(inner);
> +    }
> +}
> +
>  /// Transmute between two types.
>  ///
>  /// Use this instead of [`core::mem::transmute`] when it is known that s=
izes are identical but this
> @@ -232,3 +319,37 @@ unsafe impl AsReprMut for $signed {}
>      // `usize` is not normalized to particular integer for portability.
>      usize isize,
>  }
> +
> +#[cfg(CONFIG_RUST_DROP_GUARD_KUNIT_TEST)]
> +#[macros::kunit_tests(rust_drop_guard)]
> +mod tests {
> +    use super::*;
> +
> +    #[test]
> +    fn test_drop_runs_cleanup() {
> +        let mut cleaned =3D false;
> +
> +        {
> +            let _guard =3D DropGuard::new(42, |value| {
> +                assert_eq!(value, 42);
> +                cleaned =3D true;
> +            });
> +        }
> +
> +        assert!(cleaned);
> +    }
> +
> +    #[test]
> +    fn test_dismiss_returns_value_without_cleanup() {
> +        let mut cleaned =3D false;
> +
> +        let guard =3D DropGuard::new(42, |_| {
> +            cleaned =3D true;
> +        });
> +
> +        let value =3D DropGuard::dismiss(guard);
> +
> +        assert_eq!(value, 42);
> +        assert!(!cleaned);
> +    }
> +}


