Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC052E0934;
	Thu, 10 Jul 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145299; cv=none; b=T5wIwkPYXyib+EQxI243AeCV8PHB2qRhV6LfzW9d6NdV8+rsz9czQG2gyZrMoKPLz0y/q1inzi7TFtbYR0AfhlsTn30hpHO32Lmy2ktkN9HUT+TPkrK4/DNYr+YJjvIRjN0unv7Z4EXXtWZKY8xOUWYD1M/qamR+dK5wwEvd5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145299; c=relaxed/simple;
	bh=X71JMXi59Za+IKf0pTlfsK0EprH85uHIYSj1WhXz/OM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njYmNeCMgEPQg5Wyr4pc533WA6xyKqng1MAoRr0WVidXes5V1zyNx70O4moDZIOOOKltp0xqLu/Ycg1cHQAlRp0E4rgTPSTGZ7WLai0B9xcbql2GYTPbVuqLiiPrXxZKkmuQSyJ8Sg2ri1ilElDt0JqcHqfJYfWboIE55klcNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LePMbE8Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LePMbE8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64753C4CEF5;
	Thu, 10 Jul 2025 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752145295;
	bh=X71JMXi59Za+IKf0pTlfsK0EprH85uHIYSj1WhXz/OM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LePMbE8Q4VnqzJJQd40yodb7dF/PTBBhs9eEMSvxIjQrm4trIcfk4sAWOdLaMB7RA
	 Yiwzb3tZAGvZD9ILyO/NhNc4ePVGcJdk4Y+2aNDJj6JTypCauGULJ161xwZW7gx8EN
	 TG1tN+2IXYq+JperkhtY6KPpWwGWYlCKJfgMQRPOSw8yJMc498ilc0eo73Lf4zNhjC
	 as5/Giku0Wh8CWNs5D9rLIqhfTeSXarjg3codZcvMvQe+m1ZRwrOSO1eoL3a13K8uM
	 Ihty9yfOsiHNG0WQ+bdMTBIeWAbh5HJsbS16gXQVU4LtFAoZb30jIinUnoEdR/zkfc
	 TkfpEKl8D4lQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Trevor Gross" <tmgross@umich.edu>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Jens Axboe" <axboe@kernel.dk>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/14] rust: str: introduce `NullBorrowFormatter`
In-Reply-To: <aG9-MAwbNbjuoR0i@google.com> (Alice Ryhl's message of "Thu, 10
	Jul 2025 08:47:44 +0000")
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
	<20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org>
	<kpVk60lBMPJ_b4glgS0w-BfbIjN1cMCDSKDoM0RAB4p1Bg1BNfIdA4YRuOu70BbSZjlserkd8EJDwy0vVmR7yQ==@protonmail.internalid>
	<aG5tObucycBg9dP1@google.com> <87qzypjrdm.fsf@kernel.org>
	<RQVk_m5qeMyxOBjTkh4S3_hAqUB-GPrIS_zYnBx8fEWS8FDk95TR9IiWfmJA5hZxswqj4h-cYUqEIjlHf6srEg==@protonmail.internalid>
	<aG9-MAwbNbjuoR0i@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 10 Jul 2025 13:01:24 +0200
Message-ID: <877c0gjomz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Jul 09, 2025 at 05:49:57PM +0200, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Tue, Jul 08, 2025 at 09:44:58PM +0200, Andreas Hindborg wrote:
>> >> Add `NullBorrowFormatter`, a formatter that writes a null terminated string
>> >> to an array or slice buffer. Because this type needs to manage the trailing
>> >> null marker, the existing formatters cannot be used to implement this type.
>> >>
>> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >> ---
>> >>  rust/kernel/str.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 59 insertions(+)
>> >>
>> >> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> >> index 78b2f95eb3171..05d79cf40c201 100644
>> >> --- a/rust/kernel/str.rs
>> >> +++ b/rust/kernel/str.rs
>> >> @@ -860,6 +860,65 @@ fn deref_mut(&mut self) -> &mut Self::Target {
>> >>      }
>> >>  }
>> >>
>> >> +/// A mutable reference to a byte buffer where a string can be written into.
>> >> +///
>> >> +/// The buffer will be automatically null terminated after the last written character.
>> >> +///
>> >> +/// # Invariants
>> >> +///
>> >> +/// `buffer` is always null terminated.
>> >> +pub(crate) struct NullBorrowFormatter<'a> {
>> >> +    buffer: &'a mut [u8],
>> >> +    pos: usize,
>> >> +}
>> >
>> > Do you need `pos`? Often I see this kind of code subslice `buffer`
>> > instead.
>>
>> How would that work? Can I move the start index of `buffer` in some way
>> without an unsafe block?
>
> Yes. I think this will work:
>
> let buffer = mem::take(&mut self.buffer);
> self.buffer = &mut buffer[pos..];
>
> Temporarily storing an empty slice avoids lifetime issues.

Ah, that is neat.


Best regards,
Andreas Hindborg



