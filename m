Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621034;
	b=CVsKAIaYdqjx4KTFyuxGIEqlVW51SkEDvIlfAAuNNGoeaaB/CbPcud2YUYh46cnDBJeZ
	 JiKXAlr7GZrUvamiSdFUvIjMxZ8ifa9Uti39Pqo/bnGS2JKV0xsJrkNmAEd+FTA89G8AQ
	 bpJVSzpK0OF5zRiMu6Oh+IpS0wl+FyCAK6RxTqu3ea5b7Ncchwl7+64IMRwtfOhovSkuk
	 YyMHa0eCnPEO6InQh7T4BHWtrm8sOwSnlg++kFKLvnSujCaDj/7iUqJ8RBHlIg49QpN2n
	 TBmhIYuM4QXH86jUnVy3wrTu9sGMJ19Rgczr63xWqw2o2SRYBVApJpP00w1Fqffbi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=RG1ccPI9JHAwdj2wLWy0g00yMGNvuest7RMJsDmRSxk=;
	b=PH1bxwp2eXlCfye2/M/ZXcI8wBIF5WKIi8hZ/CFyJEAuswefI7bQPnUuDUj8at33HNv9
	 nzFud+JWO3gm/S2cDCH03dOtu4/bjJd85I8AvFx2ukDrXLzn3cKAeMFyglnrTjzfyfHkA
	 qbduHgeNx9bFrKZf5FKUZ4MNhliJO735XS5EfGpB3NmMZtPewROOS+9ro/7skjlYMkdwZ
	 TrkeSO36FjuKMRw/g6oaq9cq1jXsE0q6iMmgVgVoRb+XOX19MGuY20ZLS/8KKpvIuEPKG
	 uNFZc1IcdhdGbam5EbCv9EZBCX+JSO8AljqyW6HGxwuZShJQdOPTaqCq6/oao+a/VmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I9rg/kLt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E535606A324;
	Mon,  2 Nov 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9rg/kLt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018A01F00A16;
	Mon,  2 Nov 2026 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621033;
	bh=RG1ccPI9JHAwdj2wLWy0g00yMGNvuest7RMJsDmRSxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=I9rg/kLtoiSFh7c7rTXiDq2rzL/dvyGVDA/b66dUXD5UjbD5DNSm/Vu3g7OqHRf0e
	 fSipjIVxy0A9fn2mtBMS4o4STtMm05yY/1Nv5eoUnmEUOrq15D+E9CyQaA0+bbb0Rj
	 dV/KeRbhDV+TQO41Wy1CY69RkGWV/kGAxxVHPrfYh8DNE3cjncjj/DPocOZwd/JYZ9
	 vpXAzQOigxD8HIyz4wrzjaFZA5dCp6NWats5ioomulrlGZRSSXBeF24OsQKq11kPQ+
	 XOpc6+THzzlbzT3yg1jxvf2LuSxbwFuUbzgCa2MDopd7EAYgKHjHVHeZDQjmLUCUN5
	 0pnsTOTSbubyQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 36/98] blk-mq: quiesce a queue that joins a quiesced tag
 set
In-Reply-To: <20261030223702.GA1673281@ax162>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-37-axboe@kernel.dk>
 <9ErYaIDN02sp59BXJT_qf5dz87zAly5p0TUUeDocTYRKZY41uAWC9DY1LmBbkwvg5o8Y3GQKVcKXV2DVF-dy8w==@protonmail.internalid>
 <20261030223702.GA1673281@ax162>
Date: Mon, 02 Nov 2026 13:03:40 +0100
Message-ID: <87zevrmodf.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Nathan Chancellor" <nathan@kernel.org> writes:

> Hi Rust for Linux folks,
>
> I only added a small subset of you plus the mailing list, if I missed
> anybody, please bring them in as necessary.
>
> On Wed, Oct 28, 2026 at 10:41:39AM -0600, Jens Axboe wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> blk_mq_quiesce_tagset() only quiesces the queues on the list at that
>> moment. A queue added before blk_mq_unquiesce_tagset() runs unquiesced,
>> and then gets unquiesced without ever having been quiesced, which trips
>> the warning in blk_mq_unquiesce_queue(). NVMe gets there when a
>> controller fails while its namespaces are being scanned.
>>
>> Count the quiesce calls in the tag set and quiesce a joining queue that
>> many times, under a spinlock that also serializes the two functions. It
>> can't be tag_list_lock, see commit 59e25ef2b413.
>>
>> Fixes: 414dd48e882c ("blk-mq: add tagset quiesce interface")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> After this patch landed in -next as commit 71ec3c7d6db8 ("blk-mq:
> quiesce a queue that joins a quiesced tag set"), I am seeing the
> following build error:
>
>   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper allmodconfig rust/kernel.o
>   error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]>: pin_init::Zeroable` is not satisfied
>       --> rust/kernel/block/mq/tag_set.rs:41:49
>        |
>     41 |         let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
>        |                                                 ^^^^^^^^^^^^^^^^^^ the trait `pin_init::Zeroable` is not implemented for `bindings::__BindgenOpaqueArray8<[u8; 72]>`
>        |
>        = help: the following other types implement trait `pin_init::Zeroable`:
>                  ()
>                  (A, B, C, D, E, F, G, H, I, J)
>                  (B, C, D, E, F, G, H, I, J)
>                  (C, D, E, F, G, H, I, J)
>                  (D, E, F, G, H, I, J)
>                  (E, F, G, H, I, J)
>                  (F, G, H, I, J)
>                  (G, H, I, J)
>                and 6359 others
>        = note: required for `bindings::spinlock` to implement `pin_init::Zeroable`
>        = note: 1 redundant requirement hidden
>        = note: required for `blk_mq_tag_set` to implement `pin_init::Zeroable`
>   note: required by a bound in `pin_init::zeroed`
>       --> rust/pin-init/src/lib.rs:1688:24
>        |
>   1688 | pub const fn zeroed<T: Zeroable>() -> T {
>        |                        ^^^^^^^^ required by this bound in `zeroed`
>
>   error: aborting due to 1 previous error
>
>   For more information about this error, try `rustc --explain E0277`.
>   make[4]: *** [rust/Makefile:799: rust/kernel.o] Error 1
>   ...
>

Thanks for reporting. This was fixed over here [1].


Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/20261031152846.746656-1-sashal@kernel.org

