Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448A274656;
	Fri, 15 Aug 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246572; cv=none; b=SUVV/lckcIqQCDs0bq/cm0r2SH/AKr1Fb/U2E0TIvCiOQsBT+5nfg+KKbE+dlrf8luW23gWBa0+8SR7yfayGmPrIw1FEdlBuzq/hAA3aSE6kRYsBieWcbnJjb311hwNkkzO6kY13/OcGyC7NJQ0LKCf6fSZty79U3b85UfSkMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246572; c=relaxed/simple;
	bh=VxcsBOeu1J5e/lJVVvb1LNtN8gXPTdrV3QJ7TZwEt3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tej0CKIAsg0YZsL0Wj5lPItkWW7XT4QsRO7MGm4WYiJs/PALEa7es4s+H2st8YOE5ZtIvt9krDMgpY4XsNEdiyPCXzMCwVt6XK9gZkO2HmkVsH08zrcV0iocTKdBaa2VcEwUG4hWrg8AUBn3I2ZwoTyssOw/gWwsZfHMMXqnpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+HhCZw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+HhCZw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73CFC4CEEB;
	Fri, 15 Aug 2025 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755246571;
	bh=VxcsBOeu1J5e/lJVVvb1LNtN8gXPTdrV3QJ7TZwEt3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B+HhCZw30dw+stsBXNqRhZlm5vriSXWGVsysJE1U9167SxNHHYEVcV+gmz/tdXRYj
	 D0zegd8d3oR7lXaUr0b9B/oEOOi62ZX4Xl7zNr4YjtwcB3qPPWHtgu0Azb/A1QrBQ9
	 VbxzXGHarp2/DSwH4pPjTmOpiN85Tk1oZS/ITYj9S8wpBlrGj0QdVsT+zx7RgWC6bM
	 4hhdYuZKrURi/yNYnPvdOeKssPJeJSI/8dm3lXQ4JKmvXgxCR01SOr92mdpLZv/RjT
	 T1D3bwOcu7gJPxqbwqX9c9o7YOnmOcQkUiWLEcBJc3Y1RVq13/m9iROh//w7MK67lA
	 fROYAjX85byDg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/18] rust: str: introduce `kstrtobool` function
In-Reply-To: <aJ7oY9pxlrnfAv8s@google.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-5-581453124c15@kernel.org>
 <pgjDvgv_zgXpw__-x9lGE-DPbTDmrZqXuCOxL5pHZUrg6cbqMjfGmapEWAXq6nLueznXP4NwV5Uauc92SoufBQ==@protonmail.internalid>
 <aJ7oY9pxlrnfAv8s@google.com>
Date: Fri, 15 Aug 2025 10:21:44 +0200
Message-ID: <87o6shdmg7.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Aug 15, 2025 at 09:30:40AM +0200, Andreas Hindborg wrote:

<cut>

>> +pub fn kstrtobool(string: &CStr) -> Result<bool> {
>> +    let mut result: bool = false;
>> +
>> +    // SAFETY: `string` is a valid null-terminated C string, and `result` is a valid
>> +    // pointer to a bool that we own.
>> +    let ret =
>> +        unsafe { bindings::kstrtobool(string.as_char_ptr(), core::ptr::from_mut(&mut result)) };
>
> Using ptr::from_mut here seesm excessive IMO. I think that function
> makes sense when it replaces an explicit `as` cast, but now when it can
> be done by a coercion. This is perfectly readable:
>
> let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &mut result) };
>
> Or if you insist, you could directly create a raw pointer:
>
> let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &raw mut result) };

Oh, I'll do the implicit coercion then.

I was using `&mut result as *mut bool` but clippy told me to do the `from_mut`
instead.


Best regards,
Andreas Hindborg


