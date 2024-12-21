Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3E13D52B;
	Sat, 21 Dec 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734805896; cv=fail; b=dUp26jD3WLP5JoSYKpEkWWn+KRvBS/fEb5yIg9Rbh96/UJlnFTHrQgeD1w3E7+6uV0JrrJMaUH/I1c6UjXGNTzwQpUtKiI7b9a548QpHR8qR6YhjAhiWgcIBnoX9OCyJz8ihgWU6M/RfHAFjzLRDqNDYc5q7DCVbad+PSUe8+6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734805896; c=relaxed/simple;
	bh=G89NX8Urz5Agde/MBLyQdOIQ03mjNnKkVmrISHkBzfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TQpI05URxzfC3C3UuLq6ps0x6gFlGN+7Wwnqys094N1EOSJOIcBBz5nUlsUzsXWFEJHHcAoLqHZhp4L6ant4SdfbC7G4cWqOlXM35qKbPXnLNde4Y7Jm7dtSHxm5W2E/mA91Ol79Wfn5/cOWCwmknb3zNNnFwbO4+zbQkocxdYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oKCVhjq8; arc=fail smtp.client-ip=52.101.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oKCVhjq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObC3kKQJLy/fQrsgZL/IWIoRDtUcU+uSirUuaGBy719jqQv+qVAsu4ecpa7taM0X1sA3mHZjXUUZfGLDh5W5WiN7wTgALBIIhmvtDncjY8Lp38L9lrKuMuesUcz0BHBUt6TnXCA15PxGMjuOhBC4YHnbuYUj1QZKhJhnZWpD4VrI4hP9/njs6Vln2btw7jg5wazN1O0uvZ4ZGfk/mYgA2DTp6bCAsD/c6Jj2STP5L2mt+p1DBdqybLXCwjuGARxJBriz80Mej0ZJ3R1R0RDpADAoTY68e7Smgmnpfy2MMi2yOgVAgYVAq8cll960LBbw8M05MPbe9iZDMeCuLApP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM0YecFtfuL6LxAaeFYMDLZXdAPd2k2gCYgykGqoFOw=;
 b=VwQ2bEVPtntyeV68DPlwLMSwJS8HbHgSk6Dihr5SE/48xdNxXqdQ+vxic/BpyS5K/Zlu+J5OXbsepo6JGy/E/K1tpqhl5ITBwVL/+rgZ7k0kpNVwDy+pnhfJSoJrfJpRNP3V/bqO/7A1vewresR1Udkp6Wtj1Yun9/W/bPKfcDT9YES1H6rUZfTxT8dFUI4AhIOJEpvKlY8UdWZFXJAmotk1FncPWeFgxfP8rgvJ5brRqHhrUt0ttOKUdOsyPmcOq8vEBEyngpgWLwkeR3bJKvnDKVoov05VxdMQjRR1NMHt5eF0hauzce8SiCxGr/O3aeQXCqbsb11hCxo1xIiVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM0YecFtfuL6LxAaeFYMDLZXdAPd2k2gCYgykGqoFOw=;
 b=oKCVhjq8Dsqny8ZLTG6C+Uja7cCIHfeXZuH0siFNiyBYdWHpfYsBj9Tmf2YSDDzOOIbk33DujJ43YJmzuTTGxNBLYaPlVyDIARIw+pDw9C7cDSqgl2H1xy5mQ+BRpCMHEy1ceW9RuET6TQLBV/MI+N0ugap5YO1IaJOJT454xlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO7P265MB7439.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Sat, 21 Dec
 2024 18:31:27 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 18:31:27 +0000
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
	Jens Axboe <axboe@kernel.dk>,
	Francesco Zardi <frazar00@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] rust: block: convert `block::mq` to use `Refcount`
Date: Sat, 21 Dec 2024 18:29:46 +0000
Message-ID: <20241221183024.3929500-4-gary@garyguo.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241221183024.3929500-1-gary@garyguo.net>
References: <20241221183024.3929500-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO7P265MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 355ca5ba-f7f6-46d6-f7b2-08dd21edae8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qgQaHo7t7T5gQBm/lEsqJAbYd6BZjoZX8O1jfMvFyR2cCmHFdWBUMPSwYsa4?=
 =?us-ascii?Q?szL36zCrTsu/dLmQXaS5Rl1WV3+myvkjjF89R/xRx5oUEC/7EN87+10z0OAl?=
 =?us-ascii?Q?wz2EAD6iKj9oHlj1FPNsA6bTC956vB6i32RtfXbxCueaBmUmJaeZ2hMSLzjq?=
 =?us-ascii?Q?uaVnZ0JiAJkFzXoLsoqO2gtcttyuYQw1vcIp+ixUn0yktHxagVg8QrCv0var?=
 =?us-ascii?Q?SUBIBQR+302wyTf6NOFGMh7RDc70UWKzXw7AtGX5LbA3krtk36brwh8zbdhz?=
 =?us-ascii?Q?LBFlLw2CItHkjv7LHJGsMeNqnxJIwXXjmGHUGWF+NJRZqVbCbzYMACVamJoq?=
 =?us-ascii?Q?wSllCfwECa+hn9qn9mgPggbio5c3f2FqZ53sWXYLQGzTyHLDq4qRWuVJEp9d?=
 =?us-ascii?Q?X7JDv2rpf6uT6V2svNQG8NwEJ5mg8zvOgPDuXwyEFPHTrCgLh8T3bsj4jEI+?=
 =?us-ascii?Q?VVwt+QLa4l60YXuftbZgS/MEEVqQGOSc5hvndzBYPmhV7Rhqk3m7KMmAxC5f?=
 =?us-ascii?Q?GKAtlV4DeNmFn3SC47WPS8G8qEWnsXTfRtKPcZ/e1QLx/Y3OWqNhQLi79Bl9?=
 =?us-ascii?Q?e2rm18biqn0ZsHIt8X79TTbth3Ptq4Y69Ao1o1AbvHEadL3HHw6v3J4f9BJ8?=
 =?us-ascii?Q?eJ8i+uQg+oYBTcvkhW/1zu/0m21MecbOR+UxbP7dMfqEzVWhPaDNMYWWlYbh?=
 =?us-ascii?Q?ESIaER0x4oVyBtnsk6B7sIcmKKXLiC4cCcyTs8tnikeo/A36crW+KIWK+WNv?=
 =?us-ascii?Q?z3P0SuumOFzIe0IZZiD+Kx9gYR1fawVM3Xp4vGMpsSA4OrXgYf8XcesX/xms?=
 =?us-ascii?Q?i+2j93MNNz8esr77QL2Io/yyLuDXVH4gyAg7Eh0JX7kR9XYUhrDHvzRkLrZX?=
 =?us-ascii?Q?CDUIREKnQN1cmqITE/aUhmsC39uZ1+2JxaJ/eiS1+k+RNCy7SGIKoh30vf6u?=
 =?us-ascii?Q?ViRDWf+q/p+oNngrwBpENZ1oTH/xP1e39eet66v/1jPhd73cY+BU5hiInJJO?=
 =?us-ascii?Q?xWTkgXD9TXRQEPU7UpsbxT+cM52iSOfEDaOB6/eSG4V6U7+2IU3NZqphSQ6Z?=
 =?us-ascii?Q?OgmA7oA1DEu63pJ+/EuVfFMs8L/KiBd6DhrPH7S7KZHX753AF7cUJHFZOmcc?=
 =?us-ascii?Q?vEsSMSRFdrq3soPgHah9Hgy/AQqdMaRUHjkocic5q/+xRefd7PSa5XQg72Sk?=
 =?us-ascii?Q?5eI8s2k9r2WUxwaCvvrVP/KQKhZ7NbsPD3KIThpHPaQSnwK3o39HsxRlRq2R?=
 =?us-ascii?Q?+19GQKiq05/MmSQzMHLU/DyYq9CJkxuIT5YMDYI6UzBRlQ0ZxCbE6b/s40kd?=
 =?us-ascii?Q?v3Uj29EiIHJtjMRYHT8pK1j/ddWfBe40WMJK+Bd9QsfQ7EK7gx4e+KdUFQtE?=
 =?us-ascii?Q?+qejwaGcL+nlf6bkgaWOIRxAcLJm+bCTZaaSIoZhnW7ISsVp0Di5C6q5IUpZ?=
 =?us-ascii?Q?Ef8Q1qiv+7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6RO5klaOFjuXa3h9GWBRgOyK9ccLbGc0A5oBes8lmt+wIH/WRbfDFF7DcLNK?=
 =?us-ascii?Q?FZ1olTjHhJjRtoneRlYGcqSivuq/94PI+6IrM5y7CuckmWdwbYmIomYXftFr?=
 =?us-ascii?Q?rB8Jzf/WFEGQ5CeLpryNUfTrEwettAX1HlIGp0OZsCvNYRTJapI3yPgaaM67?=
 =?us-ascii?Q?5gmDbnJqjzqEWsMMlsZUXsITginOs8ba5QgFpQykwZVXXtXt/x/BNfP2g8eZ?=
 =?us-ascii?Q?HGRX3BscOKrwAaWYb45/CaPeW2IGqTbzXW1RXJZcxuq0c2kS6/SQRVU+9XSR?=
 =?us-ascii?Q?ci3ydgYkhAf8S4DlpbKf0unPrU0CkpX6m17ZL/fQR9t7LWox4wE7hXZ4EQz/?=
 =?us-ascii?Q?iEtpQM6NBtzottBfT0Mec5BPUbfA0DecQ9r/3mvaSUo1Pzp2zMb6gmg+sTRP?=
 =?us-ascii?Q?mFwFw5T04OcjSQhbBlSuXmBABGng1bBinj4TANi1ACvETju/MHteAoyeD5Yi?=
 =?us-ascii?Q?Ezp6UOi7o8d4NbLHxaJBLSlpkItI5fiu4mGxyf/d/pLTZEjncReN85cZg76w?=
 =?us-ascii?Q?LLQyASaU/S8ZKNmwuaxiAWd+tLkNB7X5gj70gu0jkUp85/1pBW9qMbTHSxkt?=
 =?us-ascii?Q?iWW1hNvdgSsd9UEsJa9WIO4IikHRGuEifWdsVP+bjn5QEEEgVjyjtc3S3ZSZ?=
 =?us-ascii?Q?mKgvxJCZYsRST8/9GnH/ddoKwvQ70eHw2tbDQExe44A+Tvh0pBcpN/B8AX/n?=
 =?us-ascii?Q?Dznnb5zze5PLN6LiRh5xTA1t3imYoGWn+DPZGg5dm5IaUcpjNbCi0cohUHom?=
 =?us-ascii?Q?1iAVMO4UhG43Y34bpZg74EuNfOiWwiW3TH2RC7mNBwo6vvXGgU+8ix7OYZEz?=
 =?us-ascii?Q?PCLM9XyFTDVZ+wdLBElR1vVn3qwMrxnYOoWUMeHzmo65wn6LsV8iQFwqW3ny?=
 =?us-ascii?Q?Bn1h6Xe9gBb0xfN9lYaHHhSOcq/PwZVNlv2oUH4kjZcPGvPdekkG8SeLjOj/?=
 =?us-ascii?Q?DHmMfXrx8bjP6kfbaFT/CvfQstQ61iKkFzquK9o8jiRYvFsSWl83mBDN27ab?=
 =?us-ascii?Q?kBJI/wbibWoEK3NgR2f1zdRIsKr9odHd+CsJPgRG9vbHJxAGhn63MNJmTPxN?=
 =?us-ascii?Q?u6LCcauU//vg3TBTibGOoE2exzHlAcwiWV+9YnUC56sfDzjij2Y8CK0n0H25?=
 =?us-ascii?Q?u86QVfrOICVe4zuE2LCWrNoDbd5mxhrQtULk1EVSlSyZT5JOBqm7Ix/0ZfZb?=
 =?us-ascii?Q?C4CzuKlh5pM4796FLBnRJRf6aXNM4EfGEmlVyBM4z2EZLfgY1OIwqTTrPCSs?=
 =?us-ascii?Q?FZqAAc6/T19SNV0y0RK3kXZjwpnCKmZVVMVaR9K4GSuDyQrrMyYV90p7N81O?=
 =?us-ascii?Q?ZGkNU66rmz1ZCXrmgc3olPYO1hj+GUC0BDiR75L/sHhhBH+q6SHUBps5WCq1?=
 =?us-ascii?Q?eZ3c7tIQCFhcxJiS+9niIMX11wk0r0ZrQvLC60fkrV3QVR3hwamVMQoukFVK?=
 =?us-ascii?Q?Jrex/E5Kgnr75CS0M+Nw2t2VTrzRQ08raOlIB2CsScNeWPCI1Wz/m6lBHM2L?=
 =?us-ascii?Q?J7Iu97fafdyJBqYL9uilIGhrTyQHSNEQjrnITsNab77s4aiqktXirRYygtPt?=
 =?us-ascii?Q?JhrRNExpK5DaQnoJG9lApf8AtvD1O039VV0/6bzqC9P0UqJFENIb2fgOzRAv?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 355ca5ba-f7f6-46d6-f7b2-08dd21edae8c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2024 18:31:27.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoUQimCDOnuN7UGI5X9XLdQVHn8DhiyPjbPB0NJbewpUg7JyxAuxwV/dDif+N8ctpJ+E4g4kRZ4Oau5UhATKZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7439

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
 rust/kernel/sync/refcount.rs       | 12 +++++
 3 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index c8646d0d9866..8314ce94910a 100644
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
index 2198b1598b60..ed525c719c12 100644
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
     /// Set a refcount's value.
     #[inline]
     pub fn set(&self, value: i32) {
-- 
2.47.0

