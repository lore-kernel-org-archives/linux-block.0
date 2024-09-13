Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021083.outbound.protection.outlook.com [52.101.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B26BFD4;
	Fri, 13 Sep 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263203; cv=fail; b=CiIVogcYUfcvdCglgbqGsKBRJjgOysgy8pcSdwIEExhg7cC4jtzL7+CR4SrhQ4nqO6DDnGg7Fsx0i1bjF9hwSaqGxOdrGsi8aqLPqcK1HPBDIu1wzzzHIU57ENQDKFtG6UZSapfddcf51jhZTX3cllbZLrDm/obBjcYDXdn6e18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263203; c=relaxed/simple;
	bh=7hq6jzLDBx5K9CrHD/eJ0D0SqQzM5FCAbNwt1JpnSIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXoJN7ZrJOO0bArWIbsGjb65mjiaob6GlrzAJUxz3mqBL8Obe1ishUKno//qCjAGD8KaK4T/cW0Z2Ux1fdCiSU2UcMxlF6jxTYNv9bunOErGdh0EGOTsbLJjWpTIXZyYeTDDSyRgy5vLxLJsYJMtzeQBfb4hHBUNEb8wz18urGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=a4eadIv4; arc=fail smtp.client-ip=52.101.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="a4eadIv4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjmFbboJBtFRE16cOTOpopugnWm6RdzaxPmo9mlpxvOe5Nh24RsKsSYXtlJWaBWIthFFTkN34xKYrRsL4ixatRDXG1C0sumBnvOiqUtctu7IqsU03CwR/RGqrMfRdKHQFt/ZsHyIIxi1SpmR/Cs7/bFskFYd0nmL+z6nf8dKVT/7Cq7HO/PMCNx5TWZzNzt7x6W++hrMuFEFLkVk+5eEQP8RaZT941M/DHS++o0BaLhlhm7tKehYKzrNMx8gzheZWPOu5SH+wEbLE3R/euyLvPkw+sjOLgDnFkMdP7BvbK69lBf8zLoKeQh9lUDM5G8ni4++JSG1JOmcoElhldNLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dixaF+QQqRIqMEcyzJTkwBkF/DNzFV2Hk8KY1sM598w=;
 b=nZAnFIM7fVCF7FcWjzuAzvG/wqYjfd0a1M4XixYIroYdBQd1v8VB74yrF6NUhfncVQxGzcTvnwRE52BJSiO7TyZOJP511sDOE0PQshotYg/LXP6y/yfB1UkRC9UMic3/p71BR3cVDS/xwtv2GHzxFg1xo/9SALqpTz9pfD2kpVC57LdFAAgLlDxvR59zpMl02ziV+NKtpfha6HHxLlDM4UMN+AsjL5wuuZpYZEH09QxPWKonK26V7/KY0svPUWfJaWFWmKbkB4VVJCVfjl+qOVVSKSiAlfQCi9v34ELgDNU+G6XdE9+xEcsVREzWRemogbG0ztOKXbMCXB7xhAX0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dixaF+QQqRIqMEcyzJTkwBkF/DNzFV2Hk8KY1sM598w=;
 b=a4eadIv424xr4Ms/DWrCRS/+eLWlUioFWAugzEKqxMZw4KBTKRuO1IWrSTwtHmCeXPmX15eKPSSQuoVhdanvGLUuu1gqJlMrUZR6cXciwofeLspGwFb71pEZaCmnX171YgBRhoZ4D46pYmdfvnTE9ILGRVmchCnbsSKSSnY8Uig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3594.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 21:33:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 21:33:17 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Valentin Obst <kernel@valentinobst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Mantel <alexmantel93@mailbox.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	Tiago Lam <tiagolam@gmail.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kartik Prajapati <kartikprajapati987@gmail.com>,
	Obei Sideg <linux@obei.io>,
	Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>,
	Finn Behrens <me@kloenk.dev>,
	Manmohan Shukla <manmshuk@gmail.com>,
	Asahi Lina <lina@asahilina.net>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/5] rust: use custom FFI integer types
Date: Fri, 13 Sep 2024 22:29:23 +0100
Message-ID: <20240913213041.395655-4-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240913213041.395655-1-gary@garyguo.net>
References: <20240913213041.395655-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3594:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a9f7c9-53f8-46f3-0957-08dcd43bae27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2miHE9YQpziwOoLatW/TyNAZDmTDZxfn+Aq0TdFrO7pO8o9myIuVf+gytvFd?=
 =?us-ascii?Q?5UMwZvzqWTe8n6D1c3TCnJPxOYC74EOtCjteHbO0+fEZJ1zXpcUF7l41uH+5?=
 =?us-ascii?Q?ccKen9LXm7bfgHN7ApnPYJ8fnTFwNoVyOtLxsxDDt3zwmkVczjy9RMnyLTfD?=
 =?us-ascii?Q?sJxI6e4o6iTJB+ZRPTkCc7KD9eVR+SxK4ITmKRXPoIAMAyCXkDvTPZbOY6FH?=
 =?us-ascii?Q?B4a+O2cPF5KO/WOvHNMriKz2kauGD2LWpfjq7te+HEniWzikDUxYglOda+k4?=
 =?us-ascii?Q?TmHuuVh+ep0cWRVNTmbCh6f7LaBFn3OoeYWlvbDpo8OTDAtIqlmaDWA3YjyY?=
 =?us-ascii?Q?A1w674uLitPj8ixc2Ir2iNEn9W/2EvS9Be4EnK0ZTqvt7H319t4gu2/5Ibp2?=
 =?us-ascii?Q?8+Sx1Zi57ZHaivcQedn5BGMCqNe1QKCbNoedPzefkVv4SCq2hid2n/YX1Pa5?=
 =?us-ascii?Q?LrsJCuoVGxhAl+OeLC/w4JJkP4WmND8DNbq32CiG0SLCdaCiXQThP3K7X474?=
 =?us-ascii?Q?RUa5MP0hEGk3gNXA5z1Oi4VOZHJ36KOzwBH8xJuhgFy6SM7sOC31zen5BpYq?=
 =?us-ascii?Q?DYE7OglfwPbFe6J6oS1fqRdlNHGinf82ftJg+42EHJK4xuFmOKeruGFVCQJp?=
 =?us-ascii?Q?WWx++UjJwtgdH7842Z5SNHUCtbHeJ2vxcmlp8K88UKst0Y4PMMGEA2wW3eSu?=
 =?us-ascii?Q?B9Iq8t3BH1rlxr5gwhstEFe08n5d7XBAp/BgzTohvVxeQVbDBS0F3gCcSSPU?=
 =?us-ascii?Q?Wm7/DyRlrTstWCz0b+TpOtvuq5KVdR/9svaa2vE9FKFOcrr0vLXWqTz/hQSQ?=
 =?us-ascii?Q?J0Heq7ZpxBhpVw6BrJeAlt0ayEfmgsSguDDsinUOlmzz2wrSagaw3sBvLgER?=
 =?us-ascii?Q?L1f289oCp+KO7g5j1/SVqh5OG52QhkJ1AlWAqPldHJYYxVnox074gMSaoSIU?=
 =?us-ascii?Q?B78DGdwpW3S2CF/CLUPo9qIUsEdRJkIU4npy2qdoTVRQcvtRrMIMxI1IBLKN?=
 =?us-ascii?Q?s1IiX4WRlIzHRZcz9mb77BkJOsNK6UTBJWCV1m6JxZnTJEUYW5QwQl9AdVW+?=
 =?us-ascii?Q?q9UJLOVXvATsG2STjvT+JNHCuBhnK/xWgqOu8a1tp0yvtYP65S8IfZyZ8D4R?=
 =?us-ascii?Q?EugZvwH0bSLeMxsDnpO4whGr/R0AFku/21ql6+UxOvL/G/gwm935nyLqrWgs?=
 =?us-ascii?Q?W24qhAwKvJ09YH0PkEZ6x4U0NnH65UH5vshSGss5wWE8+TosefQckZjIkMJl?=
 =?us-ascii?Q?JikVx9a77Sxq8+2G7CdlKT1XzQftBPafe/eughn+hDTUwP7nro3ydDAS6rjG?=
 =?us-ascii?Q?6ppKbS88k6rhP2J08xA7Hr7DGoe5B5xjTfIPfK/1JkLxQ8nLEn8w1sb6NIXr?=
 =?us-ascii?Q?M7iBYTy5z/65+21BYGlkna2zf0wO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFTRLPG7g3VRnXi6K3mgJSFActOe8G8RXXpmMaSwp3uWPbwa2kotwZZsQBoi?=
 =?us-ascii?Q?0Ndhv2a03RxrpuCPqdjviz3wxTxnKZejOTdZlAi27x09sVGPxwyObsIj6+HZ?=
 =?us-ascii?Q?KuNLAu20/33M/rCLt3+qdlx++NF8Pda4/eyqOPppV5pMqodh1QLDaT5VqChX?=
 =?us-ascii?Q?MsoCxoPKHQo0MckBySenxdKDF2yqHbjy/TQQhDDafhhyl16H27guWfXRMlL9?=
 =?us-ascii?Q?ruprG7OgJqx4LJrFprbqAR74hwydQEAZpCOXBSsaV0H1y+CqmE8KcSsW7wt9?=
 =?us-ascii?Q?Rrj+R/8IDqWkwsvisKkXze4Kp8UKXCMB8atx1a+NNiDC2dmY+xbg52RJwE1z?=
 =?us-ascii?Q?Ys6zVsKdFI6EgW3wRrHR5spZ/Z8s8CLd1Z2RVYJSquMKaRFAvfwfFoVOPPhV?=
 =?us-ascii?Q?saIRIY3MVE3K8POEAcgJd0XCPEDH0wM1+/Lm9r7Xeh5HdWIiJ0rICs2ORUlq?=
 =?us-ascii?Q?mwQqetrp9+ClnkTCmzacNq5EMdOhYQUHGqZFYPY3LTNOqFHYacPxOuwLj+T6?=
 =?us-ascii?Q?j1xMD/eRU9lmuqj5TN4FlNRvUu2+puCvFa46yKHi1X0KZfwvrpagye6Dmk9o?=
 =?us-ascii?Q?mHuxEgKGc5B8EiozfOWPsVm9dcbgr5X84YVPlgVRpB6yj3FKFCcPWf11BTYD?=
 =?us-ascii?Q?EdHrFLDdTyzGCeKP1hHfEm6IPU0T6h5Ye95S0YcNL1UkNyw+Qb8U0M3Ei53I?=
 =?us-ascii?Q?u3Kr/nyFL2RhkNj8vXFLfXyTFgz731dVCrRUVpTbydaYlWROkWhxfDntmF7K?=
 =?us-ascii?Q?mB9FHmqXZ9gn9cxRFcVtuhsT58qeFr/xB/ztgvKPh5vzusXdqEOPbC1lFzW+?=
 =?us-ascii?Q?VpoPQjQ7CaDjupMho0po+1B7MDGNtsrYgP7+16We7/fCXPXkEr+mORYlPNrd?=
 =?us-ascii?Q?qPRGQFu9uvXsVdW86ftRo02BVv+t++ntF4TdYcbuDROj7M7TLgQkkqbw3S82?=
 =?us-ascii?Q?R/6sl8Or+1T+ct+j9WhCc20n4ij72jZtsKMSml/t4Ev8sypsVr24qs5ww90M?=
 =?us-ascii?Q?kPrUQQG7tezxM0CUQJZJCgZUAR/4QoowTA2bByzLGfy1QgxkMa37H7UI2ZBW?=
 =?us-ascii?Q?/VffM8xKB7Ou19mqGX05iqp6hJbPMKIPEB01GfHZFDOp7wKgfKGQQiJW3L2Q?=
 =?us-ascii?Q?Y0vSpnKbpWlDmx3QjxTajE7XtfY971AyuWIAOC32FSPzlSUXGPFDFR1vgZKi?=
 =?us-ascii?Q?te/OjaxcTM3Fxyh37EuAgv5B08xKhZNNSiMRyf+YLkI5xGW60txXp8ii6Xlm?=
 =?us-ascii?Q?12Jv3JdaL7c/wl74zvjQOgKJQSxD6f5Wqcxfwknp9PNJWfo6cIs7wMTT67hq?=
 =?us-ascii?Q?ynxnPBX+kv6zx0CCcBjHucsma8Qg4na+kk9gz4zuJT5im03AgNC752Hf8HDg?=
 =?us-ascii?Q?xIr+0bPkFl+fzdD//T2fZU5XjNy9dzZjYUhhNoppOwMLLjTBRNQrlrq0cJd5?=
 =?us-ascii?Q?2SsUHnCqEZqI02BTkHQyozE8JsrWjLbM+MVvaYNNs+YcLlMie+SZz6YfeSxk?=
 =?us-ascii?Q?j/bqiULL+gAhmlzQl/E16B3MwIw9uMBRxzGlPv3d9QrOXMQBpJzV4m90Sctw?=
 =?us-ascii?Q?DlH2mUGUdXMc1E8xCIecDAF0xFdK19csmQaBRunH9ux2lvG0jR3PnF58LIdR?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a9f7c9-53f8-46f3-0957-08dcd43bae27
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 21:33:17.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbujmHVQkWY+huFKhJ6YB+Qal1ut05CUhPHExngEW/mQ4ZRt8uLaXRIWsJ6uYr/nvAC5T3LHNtaFY49XUG1qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3594

Currently FFI integer types are defined in libcore. This commit creates
the `ffi` crate and asks bindgen to use that crate for FFI integer types
instead of `core::ffi`.

This commit is preparatory and no type changes are made in this commit
yet.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile                      | 18 ++++++++++++------
 rust/ffi.rs                        | 13 +++++++++++++
 rust/kernel/alloc/allocator.rs     |  4 ++--
 rust/kernel/block/mq/operations.rs | 18 +++++++++---------
 rust/kernel/block/mq/raw_writer.rs |  2 +-
 rust/kernel/block/mq/tag_set.rs    |  2 +-
 rust/kernel/error.rs               | 20 ++++++++++----------
 rust/kernel/init.rs                |  2 +-
 rust/kernel/lib.rs                 |  2 ++
 rust/kernel/net/phy.rs             | 14 +++++++-------
 rust/kernel/str.rs                 |  4 ++--
 rust/kernel/sync/arc.rs            |  6 +++---
 rust/kernel/sync/condvar.rs        |  2 +-
 rust/kernel/sync/lock.rs           |  2 +-
 rust/kernel/sync/lock/mutex.rs     |  2 +-
 rust/kernel/sync/lock/spinlock.rs  |  2 +-
 rust/kernel/task.rs                |  8 ++------
 rust/kernel/time.rs                |  4 ++--
 rust/kernel/types.rs               | 26 +++++++++++++-------------
 rust/kernel/uaccess.rs             |  6 +++---
 rust/macros/module.rs              |  8 ++++----
 21 files changed, 91 insertions(+), 74 deletions(-)
 create mode 100644 rust/ffi.rs

diff --git a/rust/Makefile b/rust/Makefile
index 863d87ad0ce68..041ebc5db50b9 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -3,7 +3,7 @@
 # Where to place rustdoc generated documentation
 rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
 
-obj-$(CONFIG_RUST) += core.o compiler_builtins.o
+obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
 # Missing prototypes are expected in the helpers since these are exported
@@ -114,7 +114,7 @@ rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
 rustdoc-alloc: $(RUST_LIB_SRC)/alloc/src/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
 	+$(call if_changed,rustdoc)
 
-rustdoc-kernel: private rustc_target_flags = --extern alloc \
+rustdoc-kernel: private rustc_target_flags = --extern alloc --extern ffi \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings --extern uapi
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
@@ -274,7 +274,7 @@ bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) \
-		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
 		--no-debug '.*' --enable-function-attribute-detection \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
@@ -411,19 +411,25 @@ $(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORC
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
+	+$(call if_changed_rule,rustc_library)
+
+$(obj)/bindings.o: private rustc_target_flags = --extern ffi
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
-    $(obj)/compiler_builtins.o \
+    $(obj)/ffi.o \
     $(obj)/bindings/bindings_generated.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/uapi.o: private rustc_target_flags = --extern ffi
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
-    $(obj)/compiler_builtins.o \
+    $(obj)/ffi.o \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
-    --extern build_error --extern macros --extern bindings --extern uapi
+    --extern build_error --extern macros --extern ffi \
+    --extern bindings --extern uapi
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_rule,rustc_library)
diff --git a/rust/ffi.rs b/rust/ffi.rs
new file mode 100644
index 0000000000000..1894a511ee171
--- /dev/null
+++ b/rust/ffi.rs
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Foreign function interface (FFI) types.
+//!
+//! This crate provides mapping from C primitive types to Rust ones.
+//!
+//! Rust core crate provides [`core::ffi`], which maps integer types to platform default C ABI.
+//! Kernel does not use `core::ffi` so it can customise the mapping that deviates from platform
+//! default.
+
+#![no_std]
+
+pub use core::ffi::*;
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e6ea601f38c6d..e7a5937a98b09 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -28,7 +28,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     //   function safety requirement.
     // - `size` is greater than 0 since it's from `layout.size()` (which cannot be zero according
     //   to the function safety requirement)
-    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
+    unsafe { bindings::krealloc(ptr as *const crate::ffi::c_void, size, flags.0) as *mut u8 }
 }
 
 unsafe impl GlobalAlloc for KernelAllocator {
@@ -40,7 +40,7 @@ unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
         unsafe {
-            bindings::kfree(ptr as *const core::ffi::c_void);
+            bindings::kfree(ptr as *const crate::ffi::c_void);
         }
     }
 
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9ba7fdfeb4b22..c8646d0d98669 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -131,7 +131,7 @@ impl<T: Operations> OperationsVTable<T> {
     unsafe extern "C" fn poll_callback(
         _hctx: *mut bindings::blk_mq_hw_ctx,
         _iob: *mut bindings::io_comp_batch,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         T::poll().into()
     }
 
@@ -145,9 +145,9 @@ impl<T: Operations> OperationsVTable<T> {
     /// for the same context.
     unsafe extern "C" fn init_hctx_callback(
         _hctx: *mut bindings::blk_mq_hw_ctx,
-        _tagset_data: *mut core::ffi::c_void,
-        _hctx_idx: core::ffi::c_uint,
-    ) -> core::ffi::c_int {
+        _tagset_data: *mut crate::ffi::c_void,
+        _hctx_idx: crate::ffi::c_uint,
+    ) -> crate::ffi::c_int {
         from_result(|| Ok(0))
     }
 
@@ -159,7 +159,7 @@ impl<T: Operations> OperationsVTable<T> {
     /// This function may only be called by blk-mq C infrastructure.
     unsafe extern "C" fn exit_hctx_callback(
         _hctx: *mut bindings::blk_mq_hw_ctx,
-        _hctx_idx: core::ffi::c_uint,
+        _hctx_idx: crate::ffi::c_uint,
     ) {
     }
 
@@ -176,9 +176,9 @@ impl<T: Operations> OperationsVTable<T> {
     unsafe extern "C" fn init_request_callback(
         _set: *mut bindings::blk_mq_tag_set,
         rq: *mut bindings::request,
-        _hctx_idx: core::ffi::c_uint,
-        _numa_node: core::ffi::c_uint,
-    ) -> core::ffi::c_int {
+        _hctx_idx: crate::ffi::c_uint,
+        _numa_node: crate::ffi::c_uint,
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: By the safety requirements of this function, `rq` points
             // to a valid allocation.
@@ -203,7 +203,7 @@ impl<T: Operations> OperationsVTable<T> {
     unsafe extern "C" fn exit_request_callback(
         _set: *mut bindings::blk_mq_tag_set,
         rq: *mut bindings::request,
-        _hctx_idx: core::ffi::c_uint,
+        _hctx_idx: crate::ffi::c_uint,
     ) {
         // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
         // for the request data.
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 9222465d670bf..7e2159e4f6a6f 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -25,7 +25,7 @@ fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
     }
 
     pub(crate) fn from_array<const N: usize>(
-        a: &'a mut [core::ffi::c_char; N],
+        a: &'a mut [crate::ffi::c_char; N],
     ) -> Result<RawWriter<'a>> {
         Self::new(
             // SAFETY: the buffer of `a` is valid for read and write as `u8` for
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index f9a1ca655a35b..d7f175a05d992 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -53,7 +53,7 @@ pub fn new(
                     queue_depth: num_tags,
                     cmd_size,
                     flags: bindings::BLK_MQ_F_SHOULD_MERGE,
-                    driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
+                    driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
                     nr_maps: num_maps,
                     ..tag_set
                 }
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6f1587a2524e8..1090a13c2bd17 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -88,14 +88,14 @@ macro_rules! declare_err {
 ///
 /// The value is a valid `errno` (i.e. `>= -MAX_ERRNO && < 0`).
 #[derive(Clone, Copy, PartialEq, Eq)]
-pub struct Error(core::ffi::c_int);
+pub struct Error(crate::ffi::c_int);
 
 impl Error {
     /// Creates an [`Error`] from a kernel error code.
     ///
     /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
     /// be returned in such a case.
-    pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
+    pub(crate) fn from_errno(errno: crate::ffi::c_int) -> Error {
         if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
             // TODO: Make it a `WARN_ONCE` once available.
             crate::pr_warn!(
@@ -115,14 +115,14 @@ pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
     /// # Safety
     ///
     /// `errno` must be within error code range (i.e. `>= -MAX_ERRNO && < 0`).
-    unsafe fn from_errno_unchecked(errno: core::ffi::c_int) -> Error {
+    unsafe fn from_errno_unchecked(errno: crate::ffi::c_int) -> Error {
         // INVARIANT: The contract ensures the type invariant
         // will hold.
         Error(errno)
     }
 
     /// Returns the kernel error code.
-    pub fn to_errno(self) -> core::ffi::c_int {
+    pub fn to_errno(self) -> crate::ffi::c_int {
         self.0
     }
 
@@ -239,7 +239,7 @@ fn from(e: core::convert::Infallible) -> Error {
 
 /// Converts an integer as returned by a C kernel function to an error if it's negative, and
 /// `Ok(())` otherwise.
-pub fn to_result(err: core::ffi::c_int) -> Result {
+pub fn to_result(err: crate::ffi::c_int) -> Result {
     if err < 0 {
         Err(Error::from_errno(err))
     } else {
@@ -262,7 +262,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 /// fn devm_platform_ioremap_resource(
 ///     pdev: &mut PlatformDevice,
 ///     index: u32,
-/// ) -> Result<*mut core::ffi::c_void> {
+/// ) -> Result<*mut kernel::ffi::c_void> {
 ///     // SAFETY: `pdev` points to a valid platform device. There are no safety requirements
 ///     // on `index`.
 ///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
@@ -271,8 +271,8 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 // TODO: Remove `dead_code` marker once an in-kernel client is available.
 #[allow(dead_code)]
 pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
-    // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
-    let const_ptr: *const core::ffi::c_void = ptr.cast();
+    // CAST: Casting a pointer to `*const crate::ffi::c_void` is always valid.
+    let const_ptr: *const crate::ffi::c_void = ptr.cast();
     // SAFETY: The FFI function does not deref the pointer.
     if unsafe { bindings::IS_ERR(const_ptr) } {
         // SAFETY: The FFI function does not deref the pointer.
@@ -287,7 +287,7 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
         // SAFETY: `IS_ERR()` ensures `err` is a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
         #[allow(clippy::unnecessary_cast)]
-        return Err(unsafe { Error::from_errno_unchecked(err as core::ffi::c_int) });
+        return Err(unsafe { Error::from_errno_unchecked(err as crate::ffi::c_int) });
     }
     Ok(ptr)
 }
@@ -307,7 +307,7 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
 /// # use kernel::bindings;
 /// unsafe extern "C" fn probe_callback(
 ///     pdev: *mut bindings::platform_device,
-/// ) -> core::ffi::c_int {
+/// ) -> kernel::ffi::c_int {
 ///     from_result(|| {
 ///         let ptr = devm_alloc(pdev)?;
 ///         bindings::platform_set_drvdata(pdev, ptr);
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a17ac8762d8f9..e0a757bd42f0c 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -133,7 +133,7 @@
 //! # }
 //! # // `Error::from_errno` is `pub(crate)` in the `kernel` crate, thus provide a workaround.
 //! # trait FromErrno {
-//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
+//! #     fn from_errno(errno: kernel::ffi::c_int) -> Error {
 //! #         // Dummy error that can be constructed outside the `kernel` crate.
 //! #         Error::from(core::fmt::Error)
 //! #     }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f10b06a78b9d5..fbce57c09fe0c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -26,6 +26,8 @@
 // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
 extern crate self as kernel;
 
+pub use ffi;
+
 pub mod alloc;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index fd40b703d2244..d1a44ab2a408d 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -327,7 +327,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn soft_reset_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -343,7 +343,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn get_features_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -357,7 +357,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: The C core code ensures that the accessors on
             // `Device` are okay to call even though `phy_device->lock`
@@ -371,7 +371,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: The C core code ensures that the accessors on
             // `Device` are okay to call even though `phy_device->lock`
@@ -387,7 +387,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn config_aneg_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -403,7 +403,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn read_status_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -419,7 +419,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn match_phy_device_callback(
         phydev: *mut bindings::phy_device,
-    ) -> core::ffi::c_int {
+    ) -> crate::ffi::c_int {
         // SAFETY: This callback is called only in contexts
         // where we hold `phy_device->lock`, so the accessors on
         // `Device` are okay to call.
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b5..3980d37bd4b29 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -185,7 +185,7 @@ pub const fn is_empty(&self) -> bool {
     /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
     /// must not be mutated.
     #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const core::ffi::c_char) -> &'a Self {
+    pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
         // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
         // to a `NUL`-terminated C string.
         let len = unsafe { bindings::strlen(ptr) } + 1;
@@ -248,7 +248,7 @@ pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
 
     /// Returns a C pointer to the string.
     #[inline]
-    pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
+    pub const fn as_char_ptr(&self) -> *const crate::ffi::c_char {
         self.0.as_ptr() as _
     }
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822f..ec95bf6157561 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -336,11 +336,11 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *const crate::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr() as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`.
         let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
@@ -350,7 +350,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
         // holds a reference count increment that is transferrable to us.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2b306afbe56d9..fd9a67f5a2efd 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -7,6 +7,7 @@
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
+    ffi::{c_int, c_long},
     init::PinInit,
     pin_init,
     str::CStr,
@@ -14,7 +15,6 @@
     time::Jiffies,
     types::Opaque,
 };
-use core::ffi::{c_int, c_long};
 use core::marker::PhantomPinned;
 use core::ptr;
 use macros::pin_data;
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819f..9f6a5d2373bbc 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -46,7 +46,7 @@ pub unsafe trait Backend {
     /// remain valid for read indefinitely.
     unsafe fn init(
         ptr: *mut Self::State,
-        name: *const core::ffi::c_char,
+        name: *const crate::ffi::c_char,
         key: *mut bindings::lock_class_key,
     );
 
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 30632070ee670..abd7701578255 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -96,7 +96,7 @@ unsafe impl super::Backend for MutexBackend {
 
     unsafe fn init(
         ptr: *mut Self::State,
-        name: *const core::ffi::c_char,
+        name: *const crate::ffi::c_char,
         key: *mut bindings::lock_class_key,
     ) {
         // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12e..e4891670e9f3f 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -95,7 +95,7 @@ unsafe impl super::Backend for SpinLockBackend {
 
     unsafe fn init(
         ptr: *mut Self::State,
-        name: *const core::ffi::c_char,
+        name: *const crate::ffi::c_char,
         key: *mut bindings::lock_class_key,
     ) {
         // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 55dff7e088bf5..5bce090a38697 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,13 +4,9 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
+use crate::ffi::{c_int, c_long, c_uint};
 use crate::types::Opaque;
-use core::{
-    ffi::{c_int, c_long, c_uint},
-    marker::PhantomData,
-    ops::Deref,
-    ptr,
-};
+use core::{marker::PhantomData, ops::Deref, ptr};
 
 /// A sentinel value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88da..379c0f5772e57 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -12,10 +12,10 @@
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
-pub type Jiffies = core::ffi::c_ulong;
+pub type Jiffies = crate::ffi::c_ulong;
 
 /// The millisecond time unit.
-pub type Msecs = core::ffi::c_uint;
+pub type Msecs = crate::ffi::c_uint;
 
 /// Converts milliseconds to jiffies.
 #[inline]
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9e7ca066355cd..452328c675b7d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -31,7 +31,7 @@ pub trait ForeignOwnable: Sized {
     /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
     /// any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
-    fn into_foreign(self) -> *const core::ffi::c_void;
+    fn into_foreign(self) -> *const crate::ffi::c_void;
 
     /// Borrows a foreign-owned object.
     ///
@@ -39,7 +39,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Self::Borrowed<'a>;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -49,7 +49,7 @@ pub trait ForeignOwnable: Sized {
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
     /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
     /// this object must have been dropped.
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -60,7 +60,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must either be null or satisfy the safety requirements for
     /// [`ForeignOwnable::from_foreign`].
-    unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *const crate::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -74,11 +74,11 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
 impl<T: 'static> ForeignOwnable for Box<T> {
     type Borrowed<'a> = &'a T;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *const crate::ffi::c_void {
         Box::into_raw(self) as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> &'a T {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
@@ -86,7 +86,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
         unsafe { &*ptr.cast() }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         unsafe { Box::from_raw(ptr as _) }
@@ -96,12 +96,12 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
 impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
     type Borrowed<'a> = Pin<&'a T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *const crate::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
         Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Pin<&'a T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
@@ -112,7 +112,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
         unsafe { Pin::new_unchecked(r) }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
@@ -122,13 +122,13 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *const crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow<'a>(_: *const crate::ffi::c_void) -> Self::Borrowed<'a> {}
 
-    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
+    unsafe fn from_foreign(_: *const crate::ffi::c_void) -> Self {}
 }
 
 /// Runs a cleanup function/closure when dropped.
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index e9347cff99ab2..c746a1f1bb5ad 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -8,11 +8,11 @@
     alloc::Flags,
     bindings,
     error::Result,
+    ffi::{c_ulong, c_void},
     prelude::*,
     types::{AsBytes, FromBytes},
 };
 use alloc::vec::Vec;
-use core::ffi::{c_ulong, c_void};
 use core::mem::{size_of, MaybeUninit};
 
 /// The type used for userspace addresses.
@@ -47,7 +47,7 @@
 ///
 /// ```no_run
 /// use alloc::vec::Vec;
-/// use core::ffi::c_void;
+/// use kernel::ffi::c_void;
 /// use kernel::error::Result;
 /// use kernel::uaccess::{UserPtr, UserSlice};
 ///
@@ -70,7 +70,7 @@
 ///
 /// ```no_run
 /// use alloc::vec::Vec;
-/// use core::ffi::c_void;
+/// use kernel::ffi::c_void;
 /// use kernel::error::{code::EINVAL, Result};
 /// use kernel::uaccess::{UserPtr, UserSlice};
 ///
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 571ffa2e189ca..6f6c8d18ca2d1 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -249,7 +249,7 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[no_mangle]
                     #[link_section = \".init.text\"]
-                    pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
+                    pub unsafe extern \"C\" fn init_module() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // unique name.
@@ -288,7 +288,7 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
                     #[used]
-                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+                    pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
 
                     #[cfg(not(MODULE))]
                     #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
@@ -303,7 +303,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+                    pub extern \"C\" fn __{name}_init() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // placement above in the initcall section.
@@ -326,7 +326,7 @@ mod __module_init {{
                     /// # Safety
                     ///
                     /// This function must only be called once.
-                    unsafe fn __init() -> core::ffi::c_int {{
+                    unsafe fn __init() -> kernel::ffi::c_int {{
                         match <{type_} as kernel::Module>::init(&super::super::THIS_MODULE) {{
                             Ok(m) => {{
                                 // SAFETY: No data race, since `__MOD` can only be accessed by this
-- 
2.44.1

