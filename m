Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213139B4AB;
	Mon, 16 Mar 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669479; cv=none; b=BpXXkTYqnOEx8rgD1I2v5dhdHtAclAPaN024k4USVGQyzYU1bVo+C7kZBmmTewalBicpvYAoL4ffbesT8yTjdBCFkKOpYUagnagdmmeP6IX4mdYJ/7isNfPoT1J8m+LPM3K3gOp7JtGsdatEUIbpWzTMkrvDBQKx/0hzcAtn/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669479; c=relaxed/simple;
	bh=VDUeCgFqwp2e6JJJ7s6KUkN8gmIfp/ny7OylspMs4H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LoO3L+LVIw4IdJ3FwRF4i6xzkKyWnZLdhrEf8QM2k89a0umXcNdUp7ZGdSYecLPi8TL5ZmHvJMi0yQXlSVLBe3wjpZR7CbYW6wA8oVmg+zOPDZeR9Rp7Hox+/+2yF9eCw1JNh22cH52qKklF41fMHj1ibO9wZ1MMRe9dzu9OPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odexS+4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odexS+4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14F3C2BCB5;
	Mon, 16 Mar 2026 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773669479;
	bh=VDUeCgFqwp2e6JJJ7s6KUkN8gmIfp/ny7OylspMs4H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=odexS+4XwBT5gxh2uEzcH7csdkjlHlHyrsjmyW/FmIbbGuIjt3WP1zKzkTbsAGld1
	 SuCGvAC75w+LV9KezFY8t2eWd+icKSifHjeSfYHqY/B2ZkBXLLa/wN3/ReuaYdJ0j8
	 V9Q0q5FN40LVhtZmtInZDKJN/vnCZhDVZRxBcY8I9bSIVjDqQd9tNos7baTGObfQSy
	 A1t+LSEG2SkRW4agZr+LELx0uZDJrLPPNZMBQgDEufK/FursgY1qRzSb82KqP6k5UD
	 B4P4ejcd9Inp/o+lnUzEIZwCh7vvg0bo4zopiUwFSzFNFIJMewLxuq7NFsjJ3GjGpy
	 6ikzWa04rEH3g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic
 Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, Thomas
 Gleixner <tglx@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config option
In-Reply-To: <abfe2LbhLzXiGCkA@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
 <Y7WTRL6v0WsR-DWju2vumM1EBu4KZgQzE0VJul7mK3pUwD6ba0UuQO8sclDzOaeLGGh9u3WG5iSKq9T3kQqH-Q==@protonmail.internalid>
 <abfe2LbhLzXiGCkA@google.com>
Date: Mon, 16 Mar 2026 14:57:47 +0100
Message-ID: <87cy13swpw.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:35:02AM +0100, Andreas Hindborg wrote:
>> Add a configfs attribute to enable per-NUMA-node hardware contexts.
>> When enabled, the driver creates one hardware queue per NUMA node
>> instead of the default configuration.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> This and other patches make me think that module parameters should have
> value() return a copy of the value (and require Copy). For non-copy
> types, there can be a separate value_ref() method. You would avoid *so*
> many asterisks by doing that.

Makes sense, I'll send a patch.

>
>> +configfs_attribute!(DeviceConfig, 8,
>> +    show: |this, page| show_field(
>> +        this.data.lock().submit_queues == kernel::num_online_nodes(), page
>> +    ),
>> +    store: |this, page| store_with_power_check(this, page, |this, page| {
>> +        let value = core::str::from_utf8(page)?
>> +            .trim()
>> +            .parse::<u8>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?
>> +            != 0;
>> +
>> +        if value {
>> +            this.data.lock().submit_queues *= kernel::num_online_nodes();
>> +        }
>
> kstrtobool again. Also, this is *multiplying* the existing submit_queues
> value by the number of NUMA nodes?

Yea, that is not right. Astrisk should be deref on the other side of the
left hand expression.

>
>> +        use_per_node_hctx: u8 {
>> +            default: 0,
>> +            description:
>> +        "Use per-node allocation for hardware context queues, 0-false, 1-true. Default: 0-false",
>> +        },
>
> formatting (rustfmt ignores macros)

This is intentional. The line gets too long if I pull it up, and I don't
think I can break the string in any way. I think it would require
changes to the module parameter macro.


Best regards,
Andreas Hindborg


