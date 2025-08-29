Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91C310630;
	Fri, 29 Aug 2025 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492062; cv=none; b=EnG7anxX2lpDUpyVxDylLZ+O2QXJBDcocQYY4zzaBMqk6JpoEKYGNdOU85rQnV8Y/xVjwMdEbgqgTZdFNQlvv8WcGIk9ks+Z9vU2W4gCDqOJUYDv6OX4m5kGXcu2yk3duIaI0iLwG7KRW0XN+MkepE64yfY/3AeuKghWa+PBvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492062; c=relaxed/simple;
	bh=Rzyh/Fwr9GWnR+kDAxYDEuwfTqoreoGm02s5YBwLhOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXRlvvfM3YiCuebeMiZRC76acIf6fpzVtcJ3+p2xAt0bOdhTpMIyf3/IwtdAvXlDvpzmcj5o/pK1tcdi2bmMnPBnJFI+6r2iJtYwyc2NEb9JpVOF0hYsmIlrKsbRgjN2e8QvFywp5G/ZnsEgAmM3ho+iKL3qXD6dydYr1AYVNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wfjBOAv4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wfjBOAv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAB1C4CEF0;
	Fri, 29 Aug 2025 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756492061;
	bh=Rzyh/Fwr9GWnR+kDAxYDEuwfTqoreoGm02s5YBwLhOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wfjBOAv41h9wzzL60Ulg6ED6MmROGlLS0VxmKJKsaJjehuYmx330MdfnxEvA0m4fw
	 UfblAdiinGC6hMemO6Gh8asu0IVBMKpEbsjWFQV6sZiRoBEwynAkJRAttfvEKhPpoa
	 f9PzMX3bG7j7KrGhxxsCDspkCbNqSabO9cDD3tl0=
Date: Fri, 29 Aug 2025 14:27:40 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] rust: str: allow `str::Formatter` to format
 into `&mut [u8]`.
Message-ID: <20250829-famous-honest-pelican-7fe42e@lemur>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-2-581453124c15@kernel.org>
 <b2IkbJXRER5mLrLu1mpLMb6tjooPM_des2iveijPsIGSfUzKYRomwCoKPnXSJsidg1c-KY2R76d0TYb2DZmbzw==@protonmail.internalid>
 <15990453-889F-40C3-863D-DB41306E2A84@collabora.com>
 <874itqidfy.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874itqidfy.fsf@t14s.mail-host-address-is-not-set>

On Fri, Aug 29, 2025 at 01:18:09PM +0200, Andreas Hindborg wrote:
> > I gave my r-b on v3 for this patch IIRC. What happened?
> 
> I probably messed up. I'm having a really bad time with b4 collecting
> the tags.

Can I offer any help?

-K
