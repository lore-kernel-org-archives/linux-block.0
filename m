Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F791F76A5;
	Mon, 11 Aug 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898579; cv=none; b=kSH36nwpsbMHhghNoc/DVxfMPqIoyeAC7TLwEc8GdQ4cJjJwHXM+bOGI+tX0+jKN2uxREiPhd0oIwZmAKXqqkVEyQ3xaUv9rShDhct2rsi80qmNlsfkKaY21f+YjS7+iLVEqYy81lqz01Wjaxk1yVw1AdvHeOcFm/l1vKtQTAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898579; c=relaxed/simple;
	bh=obXcfu770nMVidxk73qNra/bKfWCOjeYA+F0vhuy/Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ngR2MvK+cTsbak5CfMScvgvHFhx0pEHjGm4iS1R97kiK+Ho2ekitHOwgpNRd04wPKPg+ImJUPYWlG7i3TFa2vooekyYDJFk3KWH5fU6kG606TDNFplxrM7vKrWnTjHiJRpsjuwMH1eo68ey/6DZtL99RmIOCdqBkzdGPPt5Dxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOuKRCCm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOuKRCCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C8C4CEED;
	Mon, 11 Aug 2025 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898579;
	bh=obXcfu770nMVidxk73qNra/bKfWCOjeYA+F0vhuy/Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EOuKRCCm2LlEvfMg72vKt8Que7zNQvjwjILf7+0Lz3OtPmi+Zw39fOAOBPGWKjhPl
	 lHI12YSShHuUkFvtZYI29FuEQuCPYujI8z0VRre080ovzo3VTIkNzNluyK0NG7zsfR
	 NBqmL2nIU+67H+UiJNhDlo3yy1Ca+f3b7o9Kz5y6rsko6ltYSRW0X8PLX9IUc1w9Lu
	 XvO8NZBVIga0LEe0c7c66bsbER7QieyOHWhERLJ1rNxcaLevD6lUj4q7ZDmbKFLyog
	 7iI9O3HwnVC/MxoXH+0/iUb02h9aOxypmkTGkEhdzS3NuYrZHrp5Iv3tZuXNXoLejr
	 fWQkwyFV01qmw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Jens Axboe
 <axboe@kernel.dk>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted
 imports from sync::aref
In-Reply-To: <CANiq72=Yb=APVFiJbdveVD45=fwmAbXR3vUXLTBfqu_n-BpcOA@mail.gmail.com>
References: <KnSfzGK6OiA0mL5BZ32IZgEYWCuETu6ggzSHiqnzsYBLsUHWR5GcVRzt-FSa8sCXmYXz_jOKWGZ6B_QyeTZS2w==@protonmail.internalid>
 <20250716090712.809750-1-shankari.ak0208@gmail.com>
 <87cy965edf.fsf@kernel.org>
 <iuNf4uKy1tAU76PDHMl0imyutwtKX6ih6M-JYDuYoQFmEx6VPeRH-YmY7Y76fWS6ORuhrquUVGELY7dj0r1MkA==@protonmail.internalid>
 <CANiq72=Yb=APVFiJbdveVD45=fwmAbXR3vUXLTBfqu_n-BpcOA@mail.gmail.com>
Date: Mon, 11 Aug 2025 09:49:30 +0200
Message-ID: <87bjomguwl.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Aug 8, 2025 at 11:53=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> I think you can pick this one, i.e. the idea was to allow changes to
> be picked independently.

Jens is picking the block patches directly from list. I would prefer
sending a PR, but that is not the way we agreed on doing it.

@Jens, do you still prefer to pick the rust block patches directly?

Best regards,
Andreas Hindborg



