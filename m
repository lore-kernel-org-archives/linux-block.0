Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063872F39D3;
	Mon,  1 Sep 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715193; cv=none; b=qgS3nBjZz7Ge7pQQ+r9M2rNKD/sRIJh1N6TxkxFN4aacbBkm/ObFIA55TrL9xIQcBIWyz/KFIhRDlbsZtbbZZylgzz9vOZxLikQycXSVg9Qlh0O5zcElEQ8CVoPy/CwdbwAIdY6T54fAXG3hDcJZIqnCb7D/qw3BxEIIRkAho0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715193; c=relaxed/simple;
	bh=aVR/FswJp3O9rSq3s/eLXFgb9gOuX61s72/nCUCCKWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gigGjgZE+tf3IA6x5DaT8lJ+tNdEaf0N74A85ewrcov8zheQbCd+s7VaA/gTF5IvKJj6NIpGK+mWTAKQZlg00bPQVVnjbyouHOizDRlbcj7ygfV66/+nth+V8F6cUq+o7SXcKY6xscL6fbu6RYeM2vrID2VABsm1hRAJ+sSJUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owGyHc2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owGyHc2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B495C4CEF0;
	Mon,  1 Sep 2025 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756715192;
	bh=aVR/FswJp3O9rSq3s/eLXFgb9gOuX61s72/nCUCCKWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=owGyHc2lRNfNC/7qqcBJtw+EQGlG4Eqcxbum1PxbnaTY+YKC9KXVC0HWQAUAZlFFG
	 hrEaqFxgrLdMYmzostT5sa0nFVAqqPsfn13MCaPS87/gyOeiTSEOgz77TcUfd27JF/
	 goiJFLKJZhDn+uNMeRU9FAPw8eO4E/YFO191+URByuDBnvY4vfNiZFi6tViFpLo6d8
	 na6w0cQuCmY6+B5AB6EeZO+m+sUHyMoYuIZ3rey5xwDrTXz73/mZlw88BvU03awWhh
	 RiANeCot23bvThsVKZOsXNxNC3KpJHv7BX0SIKcdCC6tLfFKAXsNrRyQYR8hMZpyrI
	 A2uz5MlKNXWSg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao
 <leitao@debian.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
In-Reply-To: <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
 <ZBoeX_r35qOXEuhUBHIR76laiY4GzAGN0v-K_LUT4qRPkM9SqYVWUIYeGClJCCJ4F8QSYVLKIqvP8teny4R1pg==@protonmail.internalid>
 <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
Date: Mon, 01 Sep 2025 10:07:27 +0200
Message-ID: <87y0qyh9z4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:

<cut>

>> -    kernel::error::to_result(ret).map(|()| result)
>> +/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool=
`].
>> +///
>> +/// Only considers at most the first two bytes of `bytes`.
>> +pub fn kstrtobool_bytes(bytes: &[u8]) -> Result<bool> {
>> +    // `ktostrbool` only considers the first two bytes of the input.
>> +    let stack_string =3D [*bytes.first().unwrap_or(&0), *bytes.get(1).u=
nwrap_or(&0), 0];
>
> Can=E2=80=99t this be CStr::from_bytes_with_nul() ?
>
> This means that kstrtobool_raw could take a &CStr directly and thus not b=
e unsafe IIUC?

By design, the input to this function need not be null terminated. My
use case is parsing the contents of a configfs file, and I would not
want to change the contents of the file, or allocate to create a null
terminated string, before calling this method.

We could add another function `kstrtobool_cstr` to do what you are
asking, but I think that could be a separate patch.


Best regards,
Andreas Hindborg



