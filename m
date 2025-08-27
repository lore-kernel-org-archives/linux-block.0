Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168682857C7;
	Wed, 27 Aug 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324288; cv=fail; b=rsPVvSxvaszHneLgnIWUx2m2YfLOCGXbMJmPRSO/azk3f9q9Tc2rsFQ7zN34FRWsadkcrK3Vpk2mlBaN7p0WR3ugATr61dJh6vYvIAHYcRFrFxWMGylT+jh+gRbd6c1713iCVy4r6SP20ker5wDaijFBmHK1Rgtg+mPGqgmwURE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324288; c=relaxed/simple;
	bh=8UjPnizeoFYhp51TvjBuZjZ9+QG5ViuIOqJvbGD67uI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1rrWPTFJXEWexkVN5ARqLnxPkv3A9c+fIWRZY1z9/j4aDMBlIgWbyGIMZaslhadJNHr8d0fyQwK0hc9mSqGKgfSMO9GJGZxzGhRd2G3EllISbVgHEQbgbgKgK0zI96UpKaQT2l/BqnLlbXQISTLdloaQcB4+tUjWqmJ0yxozz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bV99w4WB; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bV99w4WB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvOa3BXAD8RNNlF2qnGOLIHrpR32SXLTqYpB8QbKomFcGEoNNVKaht/ceNWmGkz8weT76wCXVNAHnPHtTwH8ntaQCB0zXmLy0MiExUbk9aZ/O+6h82dyZp0cvRZJlMP0mKuDBUdHGT+9ox81/CjtDgH4gyoeGIFgRimmwPn6YGTuz3gI0bTFC9pUrLu8TIZMjTxsTZK7DDjpztyRAbnL3lYNFKGO2hFjHyoVPDN+dHP/W5di6eq723afQLQqi+ZcTVpM+UwOvqqGAlDnC7GxGLtjR6+0y/fs1TurS2qgTkWmbaxxu2/7CWRop6c6z85+LsCGZASuyfu6hSQInvRcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LciB2SeKJxvq2CK5yDT/dZISis/hhy/3hh12PvKez70=;
 b=rHbz26C1RKA1ltudRDf1n4LDCoqcK5zdTIx3CY/Iyt9ZGmRHED+KBRX+TmOU+qvRzsqcRa9OeNI13cdBeBAT2PuhayLOykkGAsLg2e4OVBijBVdjqnvihoPmS9e9Lmzo1yjMFDcInKgwd8EM8oTh0sPnBB9FMYceUFzjdZsaLeO/fokoIY/wMc5zp+SaCerV31Hc8uTuEsIU6QkGbBN3amhtbn+0bizi94kdgXUR+TBklgwnjhoDNxC5geq4efA4mY1Hr0eDQQgmhZsVGFnKvSgEWQb9WpjGUzAJqM9NPiieFh0mVq1M16GLTW8l32qaJ4WlQHkXDLeZ4xGYvvOp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LciB2SeKJxvq2CK5yDT/dZISis/hhy/3hh12PvKez70=;
 b=bV99w4WBwWEY2o+NcqsEznUSGfocuqHREpaajkC8i8tJ4mDW0r6jJEqSPqNR/YzjslFFNOqRaNvn3Qb/ZFcSt2FjZc9Fp8I1bma4rHyaZ6wOqbey0feRICrCwT8qM3u3HHEFqa2NnlBJBMuCD0vE6Ln/YdwSIgYo5TLog7A9ut4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6035.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 19:51:23 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 19:51:23 +0000
Date: Wed, 27 Aug 2025 20:51:21 +0100
From: Gary Guo <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Tamir Duberstein"
 <tamird@gmail.com>, "Francesco Zardi" <frazar00@gmail.com>, "Antonio
 Hickey" <contact@antoniohickey.com>, <rust-for-linux@vger.kernel.org>,
 "David Gow" <davidgow@google.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] rust: block: convert `block::mq` to use
 `Refcount`
Message-ID: <20250827205121.59e4cc32.gary@garyguo.net>
In-Reply-To: <DC0AUNNAKGJI.4KX0TW6LG83Y@kernel.org>
References: <20250723233312.3304339-1-gary@kernel.org>
	<20250723233312.3304339-5-gary@kernel.org>
	<DC0AUNNAKGJI.4KX0TW6LG83Y@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f5a367-5d9b-4f08-f595-08dde5a31a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GXGOMdkuXSIk1+TOad/1guqVaM/2CSRU7Fq5ZByKNHr+s1GsIExic2BwM66k?=
 =?us-ascii?Q?LrnZgE2CRH6oJZWP0xB0oKGjJbRY9JvUEtwGjrWYZ9JwlqO3BroDfyBUtAvh?=
 =?us-ascii?Q?D8RWYwFbbjOataGHrbkAzHii7WofEApS/64gJtTL7ON/CnijcSMygdCh6MYu?=
 =?us-ascii?Q?xOcOAzmexci8l3HYW/slpBpVzqAV/T8RHcLArqj97IOujEJY+sdsZGCKx8Zz?=
 =?us-ascii?Q?FON6ZB/Dum91qcc4dstjFyz1DZlI/UHcjD9CDaMk95LFzTxQq5UmOsx/jOsI?=
 =?us-ascii?Q?GFV08Gi24cZUhCqFwCeDvxarNykoh6nduJY42bUCveENdB+xCcah45DYeu2R?=
 =?us-ascii?Q?PUaENKLdaX5FrtUYGM6IPT8fAankTxkow5z5uPIEeaiYZkwlNYkEU3IkPDlz?=
 =?us-ascii?Q?gR7cV3fAzNvLz4gzDvrJSm3+RT91k1HgWs3LYiF2TOV6b0bByGOpMxkwWVJN?=
 =?us-ascii?Q?XqYeWCriwsHFhJJWhmeNVn5JfQhTgmdV4yUe4VQZFHNdE2tH/SyNjkArINsu?=
 =?us-ascii?Q?aR3LgOuUfMte9zqHyha9YKrHURyJX/aDFoBKhXQcGsn1dTiaIVqL1ednincb?=
 =?us-ascii?Q?V+eTzIlZKIQrwG0FLpUqtHBis4c25iKvusQSin4wnN3PJ55AXKLYgMfHdKU5?=
 =?us-ascii?Q?dzX9rOT1sIDMxVKDsTUSSnFCZgCcICFFx3PUBHN8Xey//gNJjUGJ80cOa53u?=
 =?us-ascii?Q?F0Dp9j/DYss9+NLJq51uLiQq8ikW0dyxG7LybnmywhCMFQ9WXINkbr3FlSN5?=
 =?us-ascii?Q?1K+toSDah7+iXGLna7iawJvr3BGaQbinlvXe3ub1t5QidwhEx+nm+zSF4CrD?=
 =?us-ascii?Q?2K2RaYFTi+uigro5Lfr2ErEqNlw4j/XWx7QBBhPLidpzq+Z1qMpCg5JYcm8c?=
 =?us-ascii?Q?ssJ8WsDXCzCUiJ3/t0XlEY0VihwXtUuzT9Zz32oSz1xcGMv49fJwrWUizNAu?=
 =?us-ascii?Q?jwcL4ZFaBccomlHywQ9UmVuKzymKLJqg3hq1RcDjRAJ6PYNCGNAillXA40oK?=
 =?us-ascii?Q?rB9Op4eZ2LUhiEimra8q3NRogCoaPTQj7t5z2enfZULJcR6lq9hP/gthb4kj?=
 =?us-ascii?Q?yDnlkYzMnpyihRFO5FPMRmH7Sn0A8cfiaHxBfW8jnfnK/wcSDQTZN9s3tKea?=
 =?us-ascii?Q?O5cZXETfK9hEwjeUCU9bpyigpqXplp6YpbcZK795QrHCXHmm4PZi3u6o9Syw?=
 =?us-ascii?Q?EeCMvzqv+2mgITvV4afk9cvaQ3AROiKvF34cMS8SRxmz4IkFTMArOmlRbFZV?=
 =?us-ascii?Q?6KZ7wB8TAOfk7qWlUsKpMLh6/nn+ehLTn2fqbG9mp0zm2XL3K1y8Pot/k7P5?=
 =?us-ascii?Q?kG9TLNU95+8obXSfQNDAK3ExbdjJUh3daLpIe4Y7EWVQrG+Cq9Q9RYmAkEaY?=
 =?us-ascii?Q?4zKylyhAA16kBCzNy8AEyD48qAf68Shr9EH5ZMlfXT8g7U0lCLAvLOtHkG3U?=
 =?us-ascii?Q?i66zC9Vdrv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6h+TPrPQKgA8uNYUQHKyWzVktE7C+X3Wa3tEsmAs/BiyW7jizrSdzYi5xht?=
 =?us-ascii?Q?IcvUXT2to6I0tZIrsB0EQZqD7JiqEZo+lqeTdKvA0mpcqb/r/z3pjYcEjKdK?=
 =?us-ascii?Q?yyF9owUwi9TnhCvlAlaspIV7q74JY3EY9+B6O2LijTpVRpS8XOnTs1XnMhyo?=
 =?us-ascii?Q?sSFTLaSkQ2zK0MbOQFTl/tRNN5c5/zjzY8fl2sBnFMAS37SzsKYDFQ1oPGWP?=
 =?us-ascii?Q?yYsWDta9InXRf2AECPoWyPjcOFCaliy6zJCHkSwMXJIxPL/ITV1kNQF7h3Cw?=
 =?us-ascii?Q?BzyZkFbJdAbbltMn4KPORPsENRIvfhdmfkKLUVvf6CSC1zkIx/BqAM2tNiRS?=
 =?us-ascii?Q?zdaBfSPKJ26Z33KviZ+anKgqJhrw+UPq9EeO+8DRn8GKofoifU1P3ltjP58d?=
 =?us-ascii?Q?FVPcuEs/VJFE8gNA63cTNY3dUGCmseeLH7G1NMNOlNjpO+79Slac+r1qyVIO?=
 =?us-ascii?Q?mkcc3hNUjCm1x2AH3+FG2+Q1D2aE5yPoXMP0Olt8dJhxJQ5Gz0pY1hjIJnGf?=
 =?us-ascii?Q?5Voum534QcqlviLvjRPiHrAuS/JIG5balIWSzIFmz62TqvZDUZDWlIwGU/QC?=
 =?us-ascii?Q?tfrpYp0L2l8NtyYy3/MIAmFQEF40MIFFRL5CEGA15AyZV6O35E1Zd9PIa3bc?=
 =?us-ascii?Q?b1HzUM33ssoy/qn4WCWZvEHOxFJL9M2ECmLNkfLYFoa8GBOb1csPM2ajIh6x?=
 =?us-ascii?Q?7L5fPvJUiZXmu5Z6oYMgogE1R012PDmz0SkqvaXtYjOWDXaIUM15z5NdWGSo?=
 =?us-ascii?Q?+7zkW6tYVw9Jz6UhtLFymiA1vC3nPm+uTviM0nf1kC3M1PbYgBer7T66XGbm?=
 =?us-ascii?Q?4S7P5atM8QQHWxwe+4uT0e70A6tzo1zlB9k4VqOvk7mbo0Vzou82+J+arxMI?=
 =?us-ascii?Q?wDLizEOXGy+/DJM83h9PFKqfme0Z/c9d0GZZc7t5Fs+hpBRzN/51kmkd3cFU?=
 =?us-ascii?Q?v2OlgeMsl5gmwmH/nezvYRP8egS+6RK5FG+n7ApCjiv8pQ2NrSDcWOGHanUv?=
 =?us-ascii?Q?Qh8I77H8NcfoXZx/+/wbs3zSL9LfkgkGe+v7MSo3Ze4SeNuaty2AhNwZ1ZSj?=
 =?us-ascii?Q?DFGKZRy93hG4oIQTzr+5Ntym5zMlOh2H/boadwImhFQ1Ou2FS1NjdxKCvIJG?=
 =?us-ascii?Q?ekILjyGd4NswR9z/xtdu0kU5bChxTn+tK1kpDAJ1G+AIWJaHjFrlpw1eNmVd?=
 =?us-ascii?Q?oLCtlVbSdhJd2O2BUQbK4bI+0O/dZjjwJ2agBo/az4fpxt75ZBFochgPMGpx?=
 =?us-ascii?Q?OAgN1AUZJhJnf8Z9Jq39N29jsEmYpNuMHQumgeB558QUESYLeNMNuE0olsV8?=
 =?us-ascii?Q?1qbXa0Jbly54Bh6+ASwm/hrQ9IeBqP89W90AeWKt8l1RIbcfI4XlgDdXSdD8?=
 =?us-ascii?Q?Uo2AVW+6kMF+zuYWUUN9s8r02lm8OmJD0Og0eM2US8rAyyg2Ls62VGID6lMH?=
 =?us-ascii?Q?SjQgVRMr1gt2RdRv4550EMILIX7CU/AOerCWpU+57eWRrrACk5nJImrL4xvf?=
 =?us-ascii?Q?JMRNfR5FVjZipWSIuni/wvdilKJ3p0NfLwuuyL5HiCYL4g+y8fAG0ANDcQrX?=
 =?us-ascii?Q?zpWyok2kH08CcI84vd/t7WJhhgoWLhd3KBfckg8HNOVapZ/rVLij1guIJ2GS?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f5a367-5d9b-4f08-f595-08dde5a31a1f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 19:51:23.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Miqg524gPfzkyUJ7J1kfGtTzuKxi1+AqtoU4I3QLY+Dl92wrjSlS7iRPKygGxZDnjMQQn7kkbYgs+b046hpj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6035

On Tue, 12 Aug 2025 10:17:44 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> > From: Gary Guo <gary@garyguo.net>
> >
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
> >
> > Tested-by: David Gow <davidgow@google.com>
> > Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Gary Guo <gary@garyguo.net>  
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> 
> > ---
> >  rust/kernel/block/mq/operations.rs |  7 ++--
> >  rust/kernel/block/mq/request.rs    | 63 ++++++++----------------------
> >  rust/kernel/sync/refcount.rs       | 14 +++++++
> >  3 files changed, 34 insertions(+), 50 deletions(-)  
> 
> > diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> > index 3ff4585326b41..a9b24c6b2f8a7 100644
> > --- a/rust/kernel/sync/refcount.rs
> > +++ b/rust/kernel/sync/refcount.rs
> > @@ -4,6 +4,8 @@
> >  //!
> >  //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
> >  
> > +use core::sync::atomic::AtomicI32;
> > +
> >  use crate::build_assert;
> >  use crate::types::Opaque;
> >  
> > @@ -34,6 +36,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
> >          self.0.get()
> >      }
> >  
> > +    /// Get the underlying atomic counter that backs the refcount.
> > +    ///
> > +    /// NOTE: This will be changed to LKMM atomic in the future.  
> 
> Can we discourage using this function a bit more in the docs? At least
> point people to try other ways before reaching for this, since it allows
> overflowing & doesn't warn on saturate etc.

Would this additional doc comment be good enough for you?

/// NOTE: usage of this function is discouraged unless there is no way
/// to achieve the desired result using APIs in `refcount.h`. If an API
/// in `refcount.h` does not currently contain a binding, please
/// consider adding a binding for it instead.

Best,
Gary


> 
> ---
> Cheers,
> Benno
> 
> > +    #[inline]
> > +    pub fn as_atomic(&self) -> &AtomicI32 {
> > +        let ptr = self.0.get().cast();
> > +        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, which is an atomic 32-bit
> > +        // integer that is layout-wise compatible with `AtomicI32`. All values are valid for
> > +        // `refcount_t`, despite some of the values being considered saturated and "bad".
> > +        unsafe { &*ptr }
> > +    }
> > +
> >      /// Set a refcount's value.
> >      #[inline]
> >      pub fn set(&self, value: i32) {  
> 

