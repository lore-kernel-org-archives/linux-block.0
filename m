Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA243DA55;
	Wed,  3 Jun 2026 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488573; cv=none; b=qg8FXIEnDbopo5BYwuYDeslxAwViMXm0HFTDI+OG8zflSdP7UVClwzTIi70gop0alEYFWpMAjcBINwhUx3Vw+HGAUu82cIha035MR97xVUcshs13bqVeETcUJAESFGLoSYiZdHDkTA5B/prsxzIzxE3pkUhfUK/tDgfjvdoUJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488573; c=relaxed/simple;
	bh=/AVS8+IasBd+d0ZAz5wyS8dLMDp95xsMmOPLp6VieFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hTT9LpIcWYOkr4cAPAt4FxIn0DilwyOF74ZTSHYysd81vQpRkRT8GzGdiauyoN2KgR3gXYxWlGwnK3GJxYcUGH5hkElv58vD0lPr1cBkcEq2TxxXcMc80upeWni2adAa8GhiuLCbn6SD3WAhsMka2GHFKVgNJKS0jTUiS9SnUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSN1iWB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSN1iWB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CC91F00893;
	Wed,  3 Jun 2026 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488571;
	bh=/AVS8+IasBd+d0ZAz5wyS8dLMDp95xsMmOPLp6VieFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gSN1iWB2z2uYsbqLT/cA9xdLVkwZDaF6xhL+8a7opfqs+UP7pcl4tUR+kR3i1la7A
	 8dSDZXr1G438gduJPHbO5dX+kXxjyD1gLAfc3AbCfXrOxfRZxURXuLrP+4b95Bka54
	 j0SvIt89mU+J0w3NE1DkLJ/IIQR5gHAyGJtnUB2o8R+WCEGQ9i9BFzeUfpchTQrugt
	 8luds82brSLd7Upq+m2oNVLaBZvSfOw0Vp/NBElO4bs30bQkIso5teC2+XYiRi9TAG
	 Mi3xRTu9QvykmaVbKbDgIvAOWzRmnSVu713FkoqRfGQw8/DqW7G+z3Y47lEoTLlfOq
	 MzmxFal8Owc2A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config option
In-Reply-To: <CANiq72n5+JadJUW-GO0cwQrq9eJW7cB3ZK7zx4J484RzjxmYEA@mail.gmail.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
 <Y7WTRL6v0WsR-DWju2vumM1EBu4KZgQzE0VJul7mK3pUwD6ba0UuQO8sclDzOaeLGGh9u3WG5iSKq9T3kQqH-Q==@protonmail.internalid>
 <abfe2LbhLzXiGCkA@google.com>
 <87cy13swpw.fsf@t14s.mail-host-address-is-not-set>
 <CANiq72n5+JadJUW-GO0cwQrq9eJW7cB3ZK7zx4J484RzjxmYEA@mail.gmail.com>
Date: Wed, 03 Jun 2026 14:09:11 +0200
Message-ID: <87h5njkeqg.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Mar 16, 2026 at 2:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> This is intentional. The line gets too long if I pull it up, and I don't
>
> Do you mean you don't want to go over the limit or, otherwise, that
> something else complains?
>
> i.e. the limit is not a hard requirement -- exceptions can be made
> where reasonable (as long as `rustfmt` is clean), and moving the line
> to an odd position doesn't sound worth it.

Yes, checkpatch was complaining. I'll keep the long line then.

Best regards,
Andreas Hindborg



