Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CA22CBF6;
	Wed, 19 Feb 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996261; cv=fail; b=KLMl28t9xcgOANLTxaJ4SAzYIurfcYERtpnotb7kQGlG26WVO4FHLddFvi06jCecfpedaHI+cELP62pFTkZcnZEtZ7rfA0IIkLIH1J2mNmQ6hA7pe4PVWYCG3DfiB6FG2kc14VAtPJoygvjfct3YNFK5ArZPPZCCIWY69iEOXgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996261; c=relaxed/simple;
	bh=tQ6EyiTu390h+2n3m4K/LABaO9AXSl96QjCrprD+tg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQ2Bxazjka9cEufU3/50xIYwNMcQ5ERnHqeM5K8Kv9W6pdbuAFJX3hzSCoY627KpCjj617IVjtM75AyhVdudL/bnTLk5mAxg5gyv6pTYkwk8J1GR/g3dYNc8wOgr/aAaTC/9KOB527z29KVqiHmeMQg0e8ZP7W5bDxnRuktcLRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ej2ELLtL; arc=fail smtp.client-ip=52.101.196.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ej2ELLtL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzgKYcSXBmU0xYXTkirtGzbhginUldaYlsNdypnOf3Hv/R/SqDndRy/P/rJiv4RLbrM7eOwJvSfggGXVrxvrC0htxNSIUyvRnpME7EbFXkjWDfGZ80uEHF38BPBllGu9BP0aOpBxe6C1zvTjZvi/LphWK3NVFofMFUwoXF1xXzGg3hrBE/keJNjgf5iBc4kCPWXTxE7lYREafMmE5y9VPIl18oaboqOH2fYPVNMWJ0/Fm6dow0E8VcvhpXuX7dS4213m0nDGuw3c6U+jrW4zYWvNlTfudDTfUOzm1BeOlsIfS4FdM9hqYVcg6k4NGiY1Vf2HFpw/3V4QPhGfpIKPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6YIJcs5tMZIQ17JbfWb7gmRY4u2A+6Nnhahsu63UIs=;
 b=eYd7hEVMZ/c5Q6U+TzW69q6IJTfitQjhIjMPPBWJ/hxx9Nr5nxwpMVCUIYa5N1eS0zXWzgg+69azfNFFQOEV8htemwx0CJwpzROeioGvdc0yuH+oqgnpW+u1H3NG4U7W56i674HPcMXI59biz/Yz+IQpbcs6pLHLxGH5FTKvBm1dV6eiCYr+CsqXYuNBDJIooHr5yrZpa2rwddQ3gZ8C2Wio7OlzKWh/NLncZY8DtgpbQBIZZRZWRYkUl9ZV+36YDyZke9uRJduJrIJO3phb867jzh9CkE+lB13iX6OZtp3vqIP4f9XYON8rAbDwkqb4FIWqev6iR1nY5h/Ft8QO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6YIJcs5tMZIQ17JbfWb7gmRY4u2A+6Nnhahsu63UIs=;
 b=ej2ELLtLncZx4CNpV9hywL5rOZ3jperFqZcixunmVzvmQGRZAJC7IFKSTpFdOQUnw8F5LCTPCZDBGxtY6XapFohM4zbaRusq+kFpeqqvOZ30ZlV0HBwyMp3CmLIZCa1PuOAa54QS8FYuG38w2XmuiyvlunSbfWl2vpmo25clz5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2783.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:17:37 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:17:36 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Francesco Zardi <frazar00@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] rust: block: convert `block::mq` to use `Refcount`
Date: Wed, 19 Feb 2025 20:15:32 +0000
Message-ID: <20250219201602.1898383-4-gary@garyguo.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219201602.1898383-1-gary@garyguo.net>
References: <20250219201602.1898383-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2783:EE_
X-MS-Office365-Filtering-Correlation-Id: a10227fd-bdf6-4833-cdc8-08dd5122739d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISqJ6rDmieF+vPz6DrW/8BAlwzhznHWYvipM7ev0pnJXml6VVo4zQ2lGm9Ti?=
 =?us-ascii?Q?RCYTOtUjX4QFqV/Jlupd48KQjVVKTFUIYM4Y6lEMO6/BLhoBe0KFGDvE3/+0?=
 =?us-ascii?Q?s87LzhocD8oLWJOtNMb3mejDaAMHidMCe2GecIIxjH9CKVk2v5KW+iFup6aq?=
 =?us-ascii?Q?4yZcC07HRzsR85ngSqleIinz4SIZRSecA9ZNw1dvvEsmp211CTbKttTUMb7M?=
 =?us-ascii?Q?2OEzAr2o+MVxiCRpTUdoV1j+Utmoy5BWB88+AgZ+B2KTs4nkDpl8l/ul0TvY?=
 =?us-ascii?Q?514i/Mpxfje4aE4GSY9BNDx/Sd7AkvZDKcZDCqExDBDlkgmHswZ8HQHVgl0G?=
 =?us-ascii?Q?/wdKKfuLotH2d1x/gtJVLvN4L6XreurclsDZE9Y1ler+juFQ6yfHfRqbyv69?=
 =?us-ascii?Q?GSBxfOQHqRaV4stsrklZn1MM4ShhCzGkWECVED26sPSzVg4rv7szd6nfegUl?=
 =?us-ascii?Q?CCWoV1PMBoXdj+2Vy9PVYJbSIy6Q24jzd3AFi6ssTwsBfMYkmG9sFXjSdUBf?=
 =?us-ascii?Q?XruoAK3XCN90UIMptlA8aTYcK9wnkQMkPD8FJKz3ztQ0qhxwXHzxTA8v2gNz?=
 =?us-ascii?Q?69v2+yP5bXF2Cp2KGhXTHT/kVS+dxA7QuYVbK8llyTe9bUvt9GS6LrJPSbWz?=
 =?us-ascii?Q?08wVVbJUamCVJ7foZw53jp7H55smck2hgL/slNRuD6YsDK0StN0mgbJGCC5t?=
 =?us-ascii?Q?1J0uc0VcbmWGQ/oPn58XZ8FUHlkmoGSATFjrX/fPlqrLFmptFGkALHb63fFc?=
 =?us-ascii?Q?tS+Jh+MIYSUwOX1z9+CYGQ/I+8yFohL23dL9a2lugSjcrQiwydQyUdbJjTFH?=
 =?us-ascii?Q?s4DXdV6lBUWuWAmSt7FuwdErXN9czux1Zc8xh4Pv5AAxTPBy5enH3lJ/OEZo?=
 =?us-ascii?Q?kRFEIA2DCPIWLBKR0x3ZA4zAopqrF31tRVVK252iak6HDwGvyFSaw/sKhn+t?=
 =?us-ascii?Q?/E7PcgZSz7/Xr7kju2Pyldw6EJSidzswgs7gxyXCPrcsjg5tgUOpW2d0BgZu?=
 =?us-ascii?Q?RHZAYGbT9XTFVghoUEy2hzoIL3JfaLz38VN4r9czRiU2+W/3bblT2gGA5lJK?=
 =?us-ascii?Q?TLy+NmUB1FQI+r/M0nLgHdnKKpY8/IImsPeOJgqfWLbtn87SYJ2rL3rdX8z5?=
 =?us-ascii?Q?NK//hwApsLFnOX9Y9SlUUUNAKQo2gznCD+5Wtzec+s8vKscsdKFLZt2LZUBq?=
 =?us-ascii?Q?j63t1L4wauIo2Fcmzs1wdh4mXdldJuFqeEPDzVY8UaA71LEssK4m5xFNv9E2?=
 =?us-ascii?Q?bZFZPNlITpNN/Cg7G5RqeHkJhWUlK+v5wt9WN0q2jhKvQRo6nyHDFnDMJour?=
 =?us-ascii?Q?d/eX7en0GlaeCHIcVuNYJjD900ZZs4AGbk5I3tF5BGVEavNUQ6KydZAmUojk?=
 =?us-ascii?Q?n9CelxLbeP8n22+xVj1tnmursOHYvJWS1BArtJVhTq6JKflxrQk03DSAw/Ow?=
 =?us-ascii?Q?doFfODbQ50w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZZlP8Z+X0c2hieTSiAWmFhc5tTRHt25JG2dEpNAmLAhvqj9ix8S4yhj4aKZ?=
 =?us-ascii?Q?Nv9dgy7LxBJvEUmPKdHjGJfziWuIa3BvIReWHuq2ECEBWqOhwqLlLJDDoOni?=
 =?us-ascii?Q?G6zGOVmZGlp20J0TiVDlJr6Y3EzKqjndCwm3GhQJgzJe9VV34t+g1YlgXFEy?=
 =?us-ascii?Q?tcWSPnys4+FtNV0ZnChuhp3qrbqk4zKIfn0Wy1apO7Sch8whd06Ga/wYO6/u?=
 =?us-ascii?Q?U04cwuaFhFUZ5dXxfFo3PAJZqBkwjQ2fUQSbDY4xoAFDdOhYX+6c17jb0OyF?=
 =?us-ascii?Q?nDynneXsjEv4TdDX0f3e4TkpsiP9UwSEMhkoVoULjUAfu6bO6JRbVuxgmUR0?=
 =?us-ascii?Q?R9NGKDCK5pXW7T+qk1VlUH5jp9MUur86bVuURxSdaE1871thLb9v6VYfK6l4?=
 =?us-ascii?Q?AmeD22nBxQO7A0OOGWCor/GC2jrgjZf9vLo4dr0mm6xFn7+oHmuYKIFumEyT?=
 =?us-ascii?Q?y4tiyiiVNbV7sL3+XtJI1Qg3Ae/ASBPiual8RvzH13JEcXKjvdaKGOp4yUZh?=
 =?us-ascii?Q?wa7oft3/G462SQNpxgJj/WS9z+bHlYD20DZCBUWs3sRKVRA62f6P/F4gXTrX?=
 =?us-ascii?Q?Xt7Vn9tQBY25OhZvK/7cEQHBSpA3J/pwFItfTtjiwd6cAY1vWBpAJ6MG0KFJ?=
 =?us-ascii?Q?QnvEWk15/gaYXQnv+iepl5VrCiLpieClYydBBQ57j1uyFYKwVxNW4WMAXlJs?=
 =?us-ascii?Q?Jh+TeEJsJm8PxTY05qJNdwwc8gOGVsFXlLpDrI8BORyCCkb9+CQin0S2ZIQx?=
 =?us-ascii?Q?eq6QMclxqQJApHyyi6dxrWTuEfkYruL+UCIhwnVWXCSMmIssRe1oydFvAe77?=
 =?us-ascii?Q?c+p7lT2OILutzKA3f16CUTEfegd+Zc+X4jOH/OAjPr+OZSAEV5d84C+6BH8Y?=
 =?us-ascii?Q?tj5Ax1w7NMMH64gI/kIU2SAE1jCsIZsueECCRiN8ajRGsh6YlMbAGiZrvCYO?=
 =?us-ascii?Q?1WrRnVCLnFMvOmIe9MaKKQTcNyYvtwurAxOOhrmZb83R3jqWdOI8TItXBoF6?=
 =?us-ascii?Q?qJrYkap5vs1cf+5Ew26IfrQ3y4wNGDtHwhx8dr5MShJQljFo0BMtdD2653N8?=
 =?us-ascii?Q?wTKRNcJGVn2DDbLKLgny5Cg8GHPrasUAkHfXfGPXP5Tg75DVzhW+//Kjw49u?=
 =?us-ascii?Q?C+Y27ztqPBTeRqQLVNbtWPGo2U4ZSyJKQYGmSprntzqbJ5r3/klVNLA5H0/I?=
 =?us-ascii?Q?Hf6ixdjmSR3pOzY2cRTUv7v7DJM6GVNwhZkVS23m02Cz6B4NTH1V6iUTZodz?=
 =?us-ascii?Q?yREewT2o1iH6AdJvPJNChZgZVzBLa2O3mwL8QNABg0P4mIqKGTZqrWw9ljg5?=
 =?us-ascii?Q?7ARJT1xYsbEz6s0lYicJtTLaGEaWUVMFvuNc/QtRM6EpCgWiacXn/2yYmKyi?=
 =?us-ascii?Q?/2baUoZnDwL2ttk3l3s1dTzx4DQ7h6Kv2/+74c/6opK6tQ6bmV64u2Yj2TVS?=
 =?us-ascii?Q?w3nNnxkKg1rCzKxh1bFe4SDUXkokUetQgcXGnV/W/t9NoIXOyxWc/yJc/Sqq?=
 =?us-ascii?Q?I6kjeX5C9i+2Ip5gxzMDWJHkh9bRb5lWnspzj/J//YtYSYasX0ccXHy2XblE?=
 =?us-ascii?Q?sMuTJoe2xy/ZSz7q4GYzZ8S4ZEiikkb9+keHumfRI4PzY+umScUMFFxsKmwv?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a10227fd-bdf6-4833-cdc8-08dd5122739d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:17:36.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQdmXesEuPszhVELJjc0+rH9qdcqqzAUYzMD0vxdXEroOmUolKq1GYDc0Vyj2ZXD2o01AgRCFL+A9ynKB+YsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2783

Currently there's a custom reference counting in `block::mq`, which uses
`AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
architectures. We cannot just change it to use 32-bit atomics, because
doing so will make it vulnerable to refcount overflow. So switch it to
use the kernel refcount `kernel::sync::Refcount` instead.

There is an operation needed by `block::mq`, atomically decreasing
refcount from 2 to 0, which is not available through refcount.h, so
I exposed `Refcount::as_atomic` which allows accessing the refcount
directly.

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/block/mq/operations.rs |  7 +--
 rust/kernel/block/mq/request.rs    | 70 ++++++++++--------------------
 rust/kernel/sync/refcount.rs       | 14 ++++++
 3 files changed, 40 insertions(+), 51 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 864ff379dc91..c399dcaa6740 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,9 +10,10 @@
     block::mq::Request,
     error::{from_result, Result},
     prelude::*,
+    sync::Refcount,
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::marker::PhantomData;
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
         let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
 
         // One refcount for the ARef, one for being in flight
-        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+        request.wrapper_ref().refcount().set(2);
 
         // SAFETY:
         //  - We own a refcount that we took above. We pass that to `ARef`.
@@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 7943f43b9575..7c782d70935e 100644
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
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
@@ -37,6 +38,9 @@
 /// We need to track 3 and 4 to ensure that it is safe to end the request and hand
 /// back ownership to the block layer.
 ///
+/// Note that driver can still obtain new `ARef` even if there is no `ARef`s in existence by using
+/// `tag_to_rq`, hence the need to distinct B and C.
+///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of the C
 /// [`struct request`].
@@ -98,13 +102,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
     ///
     /// [`struct request`]: srctree/include/linux/blk-mq.h
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
 
@@ -168,13 +176,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
     /// - 2+: There are [`ARef`] references to the request.
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
 
@@ -184,7 +192,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { addr_of_mut!((*this).refcount) }
@@ -200,47 +208,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
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
-/// pred`, returning [`true`] if the target was updated.
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
@@ -252,10 +226,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
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
index a6a683f5d7b8..3d7a1ffb3a46 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -4,6 +4,8 @@
 //!
 //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
 
+use core::sync::atomic::AtomicI32;
+
 use crate::types::Opaque;
 
 /// Atomic reference counter.
@@ -30,6 +32,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
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
     /// Set a refcount's value.
     #[inline]
     pub fn set(&self, value: i32) {
-- 
2.47.2

