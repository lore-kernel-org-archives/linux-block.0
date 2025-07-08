Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CB2BE626;
	Tue,  8 Jul 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964285; cv=none; b=b1LaFYgJtdhQaRVdWZZE4WkIv4DQgNIi3vXdGuxQlyjmMxciwsBwWAI4HInNQrLusgJ9hW3auGKbGxum/GR+WWFO4E/rMMntI+W3kG50olwKLZhuQhBK0CIDZGsh258tfCiQFrr5/8IOvDeIISe8i5tpQmKfRrT3EP/aU/rhI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964285; c=relaxed/simple;
	bh=k1SPmXB5+lk94ERCX0iCOSE7q/kATspEm3dKYBqOT3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPMaG9Vj7pTVOTRdlGELJri08z7QYUhBe/YZd3oOeB8qoE7DNqGxbbU2mDGyxyBEIQrRjM0EsPKJQEbqbA1qpxVTZiUzeevXXcAxHz/Hs0NIzqMI5An2CiSiMcSYSey6WTSIJBXKfAcshr4Ah01fZxwN1f2TUbM7xkw3ebqW484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwuNKy9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwuNKy9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C339AC4CEF0;
	Tue,  8 Jul 2025 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964284;
	bh=k1SPmXB5+lk94ERCX0iCOSE7q/kATspEm3dKYBqOT3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CwuNKy9w+yk8nmAAK2eZGO8yOFr2E7OFXXQz2IrSGDV4+SngkFxQKvFAVQ9xdw6jG
	 Ji85XMm1KGhiHWh8AM/L3X0GZWI1mgfSZBNJLyPdUq5RnRAA+L02rMOwv7NwQW65lE
	 us7eb7vZ+7jo/56ZFyAzovCNk1oKq1NwLHG8NDX/eWjWgosgANEeYROsZAEqutWPeT
	 dJ/IPcpu98i/Xhj4ybYLB4bp1UaCchOsPbzacB0wAdW2cYKC30NHRh4i/OuJykwuaW
	 sAvkh/5T1IyMrNQDmTwkE3FnGgRVMVGQq9mg2R8FTdj6jh5ivxBhyvuU3aQQGITEUr
	 GKocRuoYmSImA==
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
In-Reply-To: <CANiq72kcR2Mct=uTzDQrWzAFOePsxG8Y=pS_6aGocbAe+Xaimw@mail.gmail.com>
 (Miguel
	Ojeda's message of "Mon, 07 Jul 2025 20:25:27 +0200")
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
	<20250616-rnull-up-v6-16-v1-3-a4168b8e76b2@kernel.org>
	<bpbFNIoKHyMEJSNSRBaq96hzfyrWNtFJIotbYdqEAcPhLhPf_sg-1kNlty_Uj-1tPs0ZQHcGrT-wlVRHYbANqg==@protonmail.internalid>
	<CANiq72nfeGwm17kp8OsmpgO-U6xMsuL9KBNwX34Rt1xz-Nxa1Q@mail.gmail.com>
	<87o6twoxoc.fsf@kernel.org>
	<snLGzUjHdzR0CIkyYFQU_2xo43YPtNEaZkf26_cO9O82_NKvYEg2upJVhQbuea50Rnunu5Yd-uEA43fwfHbsWA==@protonmail.internalid>
	<CANiq72kcR2Mct=uTzDQrWzAFOePsxG8Y=pS_6aGocbAe+Xaimw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 10:44:34 +0200
Message-ID: <87ikk3oyvh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Jul 7, 2025 at 4:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> The null insertion at the call site should be removed, it's a leftover
>> from before `BufferWriter` handled that.
>
> Just in case -- I think that if you do that then you would only get
> the null terminator at the end of the buffer.
>
> i.e. the one your formatter (`RawWriter`) places is really at the end
> of the buffer, rather than immediately after your formatted text, so
> if you don't have the one at the call site, you would end with garbage
> in the middle unless the disk name fits perfectly into the buffer.

I'll be sure to thoroughly check everything. Thanks for taking a look.


Best regards,
Andreas Hindborg



