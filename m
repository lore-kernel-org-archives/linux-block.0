Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58772E1730;
	Mon,  7 Jul 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900300; cv=none; b=UFOcNPbzgbJVDdydDHs/aFMXvc/0P0vus9wfguBEzgGImrS71zFTOkg1jVEyKKQh29r5MWNG6Hg9wA00CP9O9MIWZIT+JrOpa7Agm7nEGXq9tAJVVOYP+dSWJX6sov3Vfd3z/x1/UdZHNNX7nksPTYGCE5ohltOvolOPGEYqhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900300; c=relaxed/simple;
	bh=PhN12gIU8BIJ5VKiBnTir2bDTMuW0pc6OzWU1moQax4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S8t77TJWq5vAratTxhtW98mSFBKMd/dGunIWYFj5OyU+4iL+vqFleQpYF3+vujLncs4NiPoIRyKhHHjJVn9aCAQ9tFwZ9JtxmkuYXmL7QUKYZCjKlSXJqlFUoPGiE1jQOncX0FcCQlEl8gPJr6o3AWYOehAJrZfM8TxYhZl95ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE4LfnzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE4LfnzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3398DC4CEE3;
	Mon,  7 Jul 2025 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751900300;
	bh=PhN12gIU8BIJ5VKiBnTir2bDTMuW0pc6OzWU1moQax4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pE4LfnzDkmD442B5l+oZOIrTprN4zD/ARoX0ruGGAdbpGolBgjhgC/F+vVUk+V0ik
	 TutR/i4p4dYO+XnY1tMUxvokNDeQc0fl7hc66xdknBFLBYO4NWMvJVgGqVIq0R8usd
	 Um1G0mFhuH8c61sDTkRqRWx8z8KK4s8FdMmAAUl23/mNaw0fx0vj6VDu9eR2jOcjZm
	 l10oH8NaD6DXl7JwPIv6fEhLeNtDDo/+NuZc0XHvKUrzBlYE5i2UkNLxe/FufqmJpe
	 kTgXGqSkx656sX7FymFZ6smj+LJmwrL+h4dfnPBH2r3r+B9pwziTmmgDrvKHEOih7p
	 XwyEGPC3VEBRA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Jens Axboe"
 <axboe@kernel.dk>,  <linux-block@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] rust: block,core: rename `RawWriter` to `BufferWriter`
In-Reply-To: <CANiq72nfeGwm17kp8OsmpgO-U6xMsuL9KBNwX34Rt1xz-Nxa1Q@mail.gmail.com>
 (Miguel
	Ojeda's message of "Mon, 07 Jul 2025 16:18:13 +0200")
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
	<20250616-rnull-up-v6-16-v1-3-a4168b8e76b2@kernel.org>
	<bpbFNIoKHyMEJSNSRBaq96hzfyrWNtFJIotbYdqEAcPhLhPf_sg-1kNlty_Uj-1tPs0ZQHcGrT-wlVRHYbANqg==@protonmail.internalid>
	<CANiq72nfeGwm17kp8OsmpgO-U6xMsuL9KBNwX34Rt1xz-Nxa1Q@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 07 Jul 2025 16:58:11 +0200
Message-ID: <87o6twoxoc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Jun 16, 2025 at 3:26=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Rename the `RawWriter` to `BufferWriter`, wihich is a more suitable name.
>> Also move the module from `block` to `str`.
>
> The prefix should probably be "rust: block,str", or just "rust:".

OK =F0=9F=91=8D

>
> (This patch would be ideally first in the series rather than in the
> middle, by the way)

I'll move it.

>
>> -pub(crate) struct RawWriter<'a> {
>> +pub struct BufferWriter<'a> {
>
> Since you are re-exporting, can this be kept for the crate?

Yep.

>
>> +    /// Create a new [`Self`] instance.
>
> It is not a big deal here, but when you have a "move" commit, please
> try to keep changes to the minimum, e.g. type renaming could be done
> before or after.

Will do.

>
>> +    /// Return the position of the write pointer in the underlying buff=
er.
>> +    pub fn pos(&self) -> usize {
>> +        self.pos
>> +    }
>
> This is not mentioned in the commit message (and should have been a
> different patch too).

Right.

> By the way, cannot you use `{Raw,}Formatter`? You could add a
> formatter that null-terminates automatically and/or that tracks the
> lifetime, but we add the null manually elsewhere.

I'll look into that. It looks like I could just use `RawFormatter`. I
don't recall the reason for `RawWriter`, it's been years and it was
Wedson who introduced it originally.

>
> Speaking of which, aren't you null-terminating manually anyway in `gen_di=
sk.rs`?
>
> Ah, no, you are adding two nulls -- one at the end of the buffer, and
> one in the middle. So the current code will fail if it needs one final
> byte (i.e. when the last null would have been enough).

The null insertion at the call site should be removed, it's a leftover
from before `BufferWriter` handled that.

>
> Given all that, I would say just drop this one, and use the one we
> have. Then we can add a fancier formatter later on independently if
> needed.

Will try that. Thanks for taking a look.


Best regards,
Andreas Hindborg



