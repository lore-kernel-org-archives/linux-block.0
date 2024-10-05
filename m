Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33D231C85;
	Sat,  5 Oct 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728121748; cv=none; b=Hfav/ZauMH+Ewg5ODj4QYvnbNyoqHGdrye5+As7QaBxqclgEQzFeorwRu37ql0qLRiSXqudLMB+JHTgVYmdRc8dC7JGWDesmA1pg3ulb4Vu9zFc54S6xFl9AS954p4AoVK1eEmxxkKYs9AyzMqUCcIZH2IngF5o9eaIO7LCp6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728121748; c=relaxed/simple;
	bh=Uw4lYBg8nf69CBDka22a/vAHDjtylMXhtmTDsQyIUzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pE0oqNMOzerKtTfptCqrMQ+MPEmnFvpOPD9Kq02T2ZTGnycueGixXZjU8zJ6Vmw4W1W/6WL4GZB60Gle2UXQJid9C9j0OOhOyY/W+19zjndajgA1aqUJulpxpSmubMK6YZGMcjrkdcRWoeTUC3Q/i7KKzMkw0vWjIdjN/+UvcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf5rx/zC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf5rx/zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3238FC4CEC2;
	Sat,  5 Oct 2024 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728121747;
	bh=Uw4lYBg8nf69CBDka22a/vAHDjtylMXhtmTDsQyIUzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Wf5rx/zCSbqR81gZC5oqEvpyK4nb8wijEjWO3ntJxFbVmKzV0ibOehnsKBAemeztb
	 4FWnxogzOPMC47l3bUKxoqimi51r61NKJr3XO5mpmGkyLK+AIeXUp0Mtc/xReNcuUj
	 MATV0ILxBVE81axLxci3QNLXIFdD2QoXd1QrPpqYzqYzZbcvhS7HPMWADlAyxOCumu
	 d4r000O3N/00lbYNW+Q6FUm4iTB9YNvtz6nRe6qTBYzxu60sElNGMUl4wr0vZHl/7Y
	 6pHMG3rvNnCLNmtP7RhYA/go/1RzpCc1eJ5BIjha+3V55MJoSbD5Eprni+yD1SFdI9
	 gA9og30k2qeDw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "Gary Guo" <gary@garyguo.net>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Alice Ryhl"
 <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Jens Axboe"
 <axboe@kernel.dk>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <2024100507-percolate-kinship-fc9a@gregkh> (Greg KH's message of
	"Sat, 05 Oct 2024 09:47:25 +0200")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-4-gary@garyguo.net>
	<OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
	<2024100507-percolate-kinship-fc9a@gregkh>
Date: Sat, 05 Oct 2024 11:48:53 +0200
Message-ID: <87zfniop6i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg,

"Greg KH" <gregkh@linuxfoundation.org> writes:

> On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
>> There is an operation needed by `block::mq`, atomically decreasing
>> refcount from 2 to 0, which is not available through refcount.h, so
>> I exposed `Refcount::as_atomic` which allows accessing the refcount
>> directly.
>
> That's scary, and of course feels wrong on many levels, but:
>
>
>> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>>      /// C `struct request`. If the operation fails, `this` is returned in the
>>      /// `Err` variant.
>>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
>> -        // We can race with `TagSet::tag_to_rq`
>> -        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
>> -            2,
>> -            0,
>> -            Ordering::Relaxed,
>> -            Ordering::Relaxed,
>> -        ) {
>> +        // To hand back the ownership, we need the current refcount to be 2.
>> +        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
>> +        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
>> +        // atomics directly.
>> +        if this
>> +            .wrapper_ref()
>> +            .refcount()
>> +            .as_atomic()
>> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Relaxed)
>> +            .is_err()
>
> Why not just call rust_helper_refcount_set()?  Or is the issue that you
> think you might not be 2 here?  And if you HAVE to be 2, why that magic
> value (i.e. why not just always be 1 and rely on normal
> increment/decrement?)
>
> I know some refcounts are odd in the kernel, but I don't see where the
> block layer is caring about 2 as a refcount anywhere, what am I missing?

It is in the documentation, rendered version available here [1]. Let me
know if it is still unclear, then I guess we need to update the docs.

Also, my session from Recipes has a little bit of discussion regarding
this refcount and it's use [2].

Best regards,
Andreas


[1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#implementation-details
[2] https://youtu.be/1LEvgkhU-t4?si=B1XnJhzCCNnUtRsI&t=1685

