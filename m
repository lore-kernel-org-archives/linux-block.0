Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021108.outbound.protection.outlook.com [52.101.95.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DC1CACED;
	Fri,  4 Oct 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057244; cv=fail; b=ZUcMOYbkerup2yhUopbI5eu4OIkYnHP5obpkUUZ8iyh8g6XR0f0gD5hj6wYMNQqBpLa9TDKomUiUdfmvNP5f6IamiCiy87MEs0YmplJUKSufp/+qH+c0RGl3EBO3k+Y07lTj8VeVF1/GmcpEMPm7xvbaPuVPCRPT/jZvnCHUv2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057244; c=relaxed/simple;
	bh=/GcPR3HTu1Zq8dCgXyehbzh36r0ERVPv2y8bdB7vMOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIHkaMoHtBrxUE5uXuZN1UmXdutZwgsXtTLnSEUjdTe4dF7YGNb/InGPRdXGugcsAnw/8AmrDUdTzP6J2KtLPGxVPX4E7Cy4RjoEiLawmO0z9v6XOlPLXVb/pydneVwDcyXCr7Jh0+9WYk8qvCflhuvu67uL8jtk84JpJRD3+rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=J3AiS3Bw; arc=fail smtp.client-ip=52.101.95.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="J3AiS3Bw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWVzNLAhziO1hm5wnBeGETYvmAc0G27sw9omNyJQoVQe6yeLvfgTnqa4HKwam4roZ4kisvanQbR2npp8ZGPz3y2N5i79GR8cRUZKTIYIIHQUqHiKZFV5WzcTrCjKivXUF1Jnj+GSQihUitN9rsILoi4IZvpmo6nHVVzoznODNxewcMRoMwJPFIo6OXBn9SH9TNe5zn51dNKdjQrrDHl84AcNIW/9m9MNV9S99OIOBv/aGKw8tqtwzksdne4K6zr6UnvYiajlSYlWGyIRyKl5N+xNz1cqrZc9ODrs/M6/s7FT4RjWgaG3uyumybn75Q8cHyf7jxAurBJIQ2+WiikofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN5IRMyJOeEKBWDmB/4hhIRYVuROchTWNALvxHeMraA=;
 b=kkzwRq/Ti63FqHIh1UxarL3eMAgxDHIB9JtJfHYAOwO2sTcxOjlQEHM/RER3MI9NJYeo06sF5vtaqmKg5wBVaYl3RRRAk+xiFlBEnXINtrg5qTswbXO2FnypdJiSbl26kDC2Z+eNq91JzeOU3Mgy6wmVP1u66EP2dgALlU0dBKG7kgkKcnkVPZ1WbtwStN8W/eOdVGCoafYmFTm5HZA/A8a/5tdVDYh5WRCc1xCBaVNWjMyNMeaWdoVt9ivuhVo4nWY4rcAuptP5k1zOp8GnZdXRGln8tL3quApOVgzkOX0+nVDPxvGUdUfEcKW+/82whWtL3uQEOBiAQa8EhSYTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN5IRMyJOeEKBWDmB/4hhIRYVuROchTWNALvxHeMraA=;
 b=J3AiS3BwpN7pRyaG57TkOgbbJ4dWxHroYD+HSUatD5P/10du8QGtBKzhm7pVuEAEZ+RuXx1nMu3/y5SFDsSx8/TLCe2KNHKLZV1Vl2cvugxQK4xxv9jrBS66s+HSAvq8eZBrbgwuFxsOSGR6OVw/XvVAnc2GrSwjFH6M7zvKHwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2557.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:54:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:53:59 +0000
From: Gary Guo <gary@garyguo.net>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Date: Fri,  4 Oct 2024 16:52:24 +0100
Message-ID: <20241004155247.2210469-4-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241004155247.2210469-1-gary@garyguo.net>
References: <20241004155247.2210469-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2557:EE_
X-MS-Office365-Filtering-Correlation-Id: 310aab6d-deee-4668-e8a0-08dce48cc302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IETBxSra+aStSDmfvOKYMDJ7NiG0SyvRuJypJDBdVDGndYFYVEDM3PVkQ/1?=
 =?us-ascii?Q?ZlkWuh7MNl3B8XA+vTcDeG0pkfPjlsO/orB6KjWRzXo/JbY1zcj2Al2pUSWD?=
 =?us-ascii?Q?WZUHLb42e5uxVgl9R3+e1ddaMPd7TrRhz8AqIc7qQ5IUu49iVhNsBT141c3Q?=
 =?us-ascii?Q?GWsHR/4b/LtOyQgDpVmdVtGQVoYKIx6F3v/UUNuu1H+i+vA3yeFILwVPgUTo?=
 =?us-ascii?Q?C+lWDeXc0mU50N1kB6msBCbW3o3FUAfhmblduvWRuFmxWEdRBfytLDN1nq+k?=
 =?us-ascii?Q?paGGdlZZYHljoMEO1CnkHlzhGX0R9lzX/q/Zx1mOfGoXRhTMSRSkWUn3F22D?=
 =?us-ascii?Q?ZUh1WxadgwwRbQ79my25tGgyY39CpdJk8cW1zTAKzUdVav+qL5vwJSBHKcs+?=
 =?us-ascii?Q?do3s8/SsNmkcCc+4VNeLBYGINUO8B/nv08XuSsI2mCGcDBj+08fTPuxsApih?=
 =?us-ascii?Q?sY0q9cJHVfNPgl89VJFZEoI6bRkOIc02vIG/dTvHrPKHJZv1AzoWHthVAFcL?=
 =?us-ascii?Q?2v3W+Stb9e2/CDx6Fu46cl94BXQ18uHNXkzb1jrhZYy2gD/Sd+Q32Q42XYNw?=
 =?us-ascii?Q?8S1duRr9DwuBYW4kBmQPBDbcRqqDG/DfkF0gdC8XEW5mjQ9Gr5UExeB0J+bV?=
 =?us-ascii?Q?AzjzHpBIFyVVnoXmqNvwoq77zbywxW3buP8bS+xav6BV/etqXr7tIA2WBlRY?=
 =?us-ascii?Q?Pep9wm6Yddn5mEoySK7ymhAVzFR3NM//Qu+FtjKS+yC0iJDRTzmLySkBGxVQ?=
 =?us-ascii?Q?zqZLqKgZa1mcEG76R2qSeFAPvR2Ee+gyItp25PzvIcwAzzQXPt1Jh0pkFZR1?=
 =?us-ascii?Q?wg6nuddfwA7YiaHHfAqiMry+qhHkzr0cgyKbfewbnaEBMbxC3lA4BVQxktp7?=
 =?us-ascii?Q?dC8I2MY5bnF8beieA3KoudkcbWBwETiHXQ88vZKDQdElhnBh8axiAQvk+ynK?=
 =?us-ascii?Q?iC+WqQdUrFd0F3KXgTKf41hde4zCL083LP/YZD7xgzWrtYyjLdc+OO61+PZx?=
 =?us-ascii?Q?bBqonshKySo897O5w5FJ/kf0OLxmXB0fqNPbljLxQX3I6zraVpUV7+UVQs1q?=
 =?us-ascii?Q?KB2R0x/dWFyfveQNpHdaKRV3rsL3TOmhaQaMCzfsInn1WFozP0V9ooc1MJ4V?=
 =?us-ascii?Q?zsiqDIVkNwXsgvfs+Zim1Cue7WiF3Koj4ZSmxqBTc1pHFfdW0M6ylfCibp/j?=
 =?us-ascii?Q?Yyl5/bnV0VzudEjpt8rauxtPNrk09sxVPt5B3bWzj3pCih4OJoCEXgMZAd01?=
 =?us-ascii?Q?KNKWNCjnk0ANc9kudpeW+OZHXNHQ1kHr9kbMK2enm2uQ7pULvHPjDvMNW+rG?=
 =?us-ascii?Q?PD2iGUu+wwuGyw6OzaIyTXF8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHkkU2BpWc4XA6bWbSSzusJ5TXh8Blz12Wpoo5xmwXLvuHwqQDddpdoqYHlz?=
 =?us-ascii?Q?viHLtcsPd2vCEifUSet9nk7rOQPHv8p3QarJCyXe2utksp42/OIO/DVTM5Qj?=
 =?us-ascii?Q?ruGLGsYWT4ChXqq4iFSbyTj30qJVuvwpkHPBSLLpxoLWMpqYH0CYH2bgqWy4?=
 =?us-ascii?Q?jcJXyNAzuC3VMyeypeFa1HC9tKYr1/1tNDEU2e0q0+wGMRu4ByL+Kb7NJ/81?=
 =?us-ascii?Q?GV9USDN5CLmEtSh9LiloCKTwtYwxKcifLHnMdWPb2sd0ns4nbOE1EWTdh97o?=
 =?us-ascii?Q?/DRr6D2Je/tNillmdp9BdL/Szi27lregVk9xWsyceSLpVqpeOKnCyBjlo1IA?=
 =?us-ascii?Q?/ACywhrCL+wuYSCFkXJTJw4b/tMv9hts74Z73ss5VSgkMneXr7QhITJyHljF?=
 =?us-ascii?Q?OA470poCnu6iaYqalB8zgpXPdCgo0eD20/1NqAVq2kHU6boIT1ArxElJCPWg?=
 =?us-ascii?Q?Smigzwl4fmHKvYtquYzNmnBNIzUrk37YR8Ax4kZMgxTMT9nbdMYv3aJT+qzN?=
 =?us-ascii?Q?t6F54qMcAYK7iU5EdyoMDfPTf1xK0sDoXyDJ7Aq64TbxdUmzP93j2Xdx8j+V?=
 =?us-ascii?Q?zZq83cytg2tMKu/y+3yTvq1VZcT+6+hZNkjNumoNlcklwmoBT/yqJtiJg2kf?=
 =?us-ascii?Q?7eApk5njcJ/NHi24a0vpYHwnRv+SlUoY1EhkUgglqn3cgqbMbljFfRFdzORY?=
 =?us-ascii?Q?VsrsGv5D01RHltYEQ8wdfHruUVeNbHOKxTYCpm7ImMcmBhEtX/i9UCttpy5W?=
 =?us-ascii?Q?mn6Kn4GQfcBjYaL9TkffS8i99THlETAO39vcgEab7blcPyULfYQ3w171c4K1?=
 =?us-ascii?Q?aatl93gXtVyvL9QJ5zexeadFyroxwbpBEsc5zH8zgm8rUKuINJX627dPp+O2?=
 =?us-ascii?Q?duB2tvGmGs687ovT9Zh3WevSTbTIwrGKKWby/kvj+C8KW9vRmls82SGD51c/?=
 =?us-ascii?Q?Lj859UFL8Jcbagp6wpSrID5bp74kCwlQnygiG8m1YusNy2J10e7+R9l8SE0D?=
 =?us-ascii?Q?zDbwQQE5BhbsB8f1F784fSRk3Cb/G2lj2hV7k0fvvtvkeSo0A3yaRDHPt6PH?=
 =?us-ascii?Q?Q4RgiAaVzzgV6oxQPPB9ECnZ2Gad6IP7C11DeOWMh87YDebhvTP/uAlCcUyd?=
 =?us-ascii?Q?S8uXrxKf0DwbTiicAZCe/qb/NeC5Pmhy3fWhbvum5TBvEOiVE8V8fwSK+uWb?=
 =?us-ascii?Q?yeNmGq0n1c7CYyFAvYklbNZ6/eDr5JoHznxSSr5tHyJj0jIcSLvvVUwAYl3/?=
 =?us-ascii?Q?5JbNGMMHORpg0jJBIgiZWsIGc8fD6wBL5yllmlKC0dnKmJ0GFhypYp87zMxk?=
 =?us-ascii?Q?D/ALO2IIMf01qJjhw1+6BpBHRC8OIyvjSrbmu0r+/dYFLIW5jJlLkZs3GWdG?=
 =?us-ascii?Q?/SM2wEfQJDanUEH3bYIz6fg5FsISMav7Phr2QZzsQj36Oj7cmAKJ8ipT49Aj?=
 =?us-ascii?Q?pw/30i3lMCnASfg/c8vmn1tMRbY6LDLSoakyP6NdzTkiVEEwkbUnQbBJmuEN?=
 =?us-ascii?Q?1adhtzkYhtVpcnAjL0dxj0gGGg8ehZrcJGBzc/TZVJIOevAUbmpG0qsp8NOk?=
 =?us-ascii?Q?b2pPX9mxaI34m209D1j2AD3L66y0IcJj/q8EnAzhur/Ah0efXr1jnSLNU4nN?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 310aab6d-deee-4668-e8a0-08dce48cc302
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:53:59.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foLeJkAYgk2ndryT5nWmfiPOQu9RlUGtOJn7f55JkuLcmCAgkfbVZnDf4tAjfJIMwEAWEqdNM0Appa2m10xvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2557

Currently there's a custom reference counting in `block::mq`, which uses
`AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
architectures. We cannot just change it to use 32-bit atomics, because
doing so will make it vulnerable to refcount overflow. So switch it to
use the kernel refcount `kernel::sync::Refcount` instead.

There is an operation needed by `block::mq`, atomically decreasing
refcount from 2 to 0, which is not available through refcount.h, so
I exposed `Refcount::as_atomic` which allows accessing the refcount
directly.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/block/mq/operations.rs |  7 +--
 rust/kernel/block/mq/request.rs    | 70 ++++++++++--------------------
 rust/kernel/sync/refcount.rs       | 12 +++++
 3 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9ba7fdfeb4b2..36ee5f96c66d 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -9,9 +9,10 @@
     block::mq::request::RequestDataWrapper,
     block::mq::Request,
     error::{from_result, Result},
+    sync::Refcount,
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::marker::PhantomData;
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -77,7 +78,7 @@ impl<T: Operations> OperationsVTable<T> {
         let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
 
         // One refcount for the ARef, one for being in flight
-        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+        request.wrapper_ref().refcount().set(2);
 
         // SAFETY:
         //  - We own a refcount that we took above. We pass that to `ARef`.
@@ -186,7 +187,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..7b63c02bdce7 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,12 +8,13 @@
     bindings,
     block::mq::Operations,
     error::Result,
+    sync::Refcount,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 use core::{
     marker::PhantomData,
     ptr::{addr_of_mut, NonNull},
-    sync::atomic::{AtomicU64, Ordering},
+    sync::atomic::Ordering,
 };
 
 /// A wrapper around a blk-mq `struct request`. This represents an IO request.
@@ -37,6 +38,9 @@
 /// We need to track C and D to ensure that it is safe to end the request and hand
 /// back ownership to the block layer.
 ///
+/// Note that driver can still obtain new `ARef` even there is no `ARef`s in existence by using
+/// `tag_to_rq`, hence the need to distinct B and C.
+///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of the C
 /// `struct request`.
@@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
     /// C `struct request`. If the operation fails, `this` is returned in the
     /// `Err` variant.
     fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
-        // We can race with `TagSet::tag_to_rq`
-        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
-            2,
-            0,
-            Ordering::Relaxed,
-            Ordering::Relaxed,
-        ) {
+        // To hand back the ownership, we need the current refcount to be 2.
+        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
+        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
+        // atomics directly.
+        if this
+            .wrapper_ref()
+            .refcount()
+            .as_atomic()
+            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Relaxed)
+            .is_err()
+        {
             return Err(this);
         }
 
@@ -159,13 +167,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
     /// - 2+: There are `ARef` references to the request.
-    refcount: AtomicU64,
+    refcount: Refcount,
 }
 
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &Refcount {
         &self.refcount
     }
 
@@ -175,7 +183,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { addr_of_mut!((*this).refcount) }
@@ -191,47 +199,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
 // mutate `self` are internally synchronized`
 unsafe impl<T: Operations> Sync for Request<T> {}
 
-/// Store the result of `op(target.load())` in target, returning new value of
-/// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
-    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
-
-    // SAFETY: Because the operation passed to `fetch_update` above always
-    // return `Some`, `old` will always be `Ok`.
-    let old = unsafe { old.unwrap_unchecked() };
-
-    op(old)
-}
-
-/// Store the result of `op(target.load)` in `target` if `target.load() !=
-/// pred`, returning true if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
-    target
-        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
-            if x == pred {
-                None
-            } else {
-                Some(op(x))
-            }
-        })
-        .is_ok()
-}
-
 // SAFETY: All instances of `Request<T>` are reference counted. This
 // implementation of `AlwaysRefCounted` ensure that increments to the ref count
 // keeps the object alive in memory at least until a matching reference count
 // decrement is executed.
 unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
     fn inc_ref(&self) {
-        let refcount = &self.wrapper_ref().refcount();
-
-        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
-
-        #[cfg(CONFIG_DEBUG_MISC)]
-        if !updated {
-            panic!("Request refcount zero on clone")
-        }
+        self.wrapper_ref().refcount().inc();
     }
 
     unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
@@ -243,10 +217,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
 
         #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
+        let is_zero = refcount.dec_and_test();
 
         #[cfg(CONFIG_DEBUG_MISC)]
-        if new_refcount == 0 {
+        if is_zero {
             panic!("Request reached refcount zero in Rust abstractions");
         }
     }
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index 4a5b815adc05..2cdcb20e8ee2 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -31,6 +31,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
         self.0.get()
     }
 
+    /// Get the underlying atomic counter that backs the refcount.
+    ///
+    /// NOTE: This will be changed to LKMM atomic in the future.
+    #[inline]
+    pub fn as_atomic(&self) -> &AtomicI32 {
+        let ptr = self.0.get() as *const AtomicI32;
+        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, which is an atomic 32-bit
+        // integer that is layout-wise compatible with `AtomicI32`. All values are valid for
+        // `refcount_t`, despite some of the values are considered saturated and "bad".
+        unsafe { &*ptr }
+    }
+
     /// Get a refcount's value.
     #[inline]
     pub fn read(&self) -> i32 {
-- 
2.44.1

