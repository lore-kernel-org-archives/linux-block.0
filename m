Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D93DDDCC;
	Thu, 11 Jun 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176849; cv=none; b=YbvLCrCGIXVps1Ory4e3t7Qk729Hadq/BpA5g4v0aDCihhM359Zezx/uY2L7VDfBfD9+4EkHHJsbXRhjJNhq5dJOnnaw+aMOOIqgrD404poxHIwoSoLiHSNWeMMUhiUsdHw7NghBNlMaShVhZ4xBOeraIVrud9GAhM5ZCbt1iYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176849; c=relaxed/simple;
	bh=uANtolZsK/i1HvbTyMriqu1AMAi3Xc2bYpt6H9ahGt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFv445weAR9yk1gerVuXMNZclX6ydtzb5uIOQCOp2n6CwFuna8g7/KKW02rfeA9rgiFSPj33TSr2fsgBed+EnR7ttT5/IIj0Ch12IzHDz5sFk66MCSkSHuasICHPGmlsbG7FRcpYCq5iBS3gzwwdKJkiG4VIPTl+ZiV7MhuRf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0oqBLon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0oqBLon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F6E1F00893;
	Thu, 11 Jun 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176847;
	bh=uANtolZsK/i1HvbTyMriqu1AMAi3Xc2bYpt6H9ahGt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J0oqBLonkxa8Pm/JBKAAQNoPcpeOXApE8vnSTtNGPqTn2AVrN5Ye3ghETxQbcTKMZ
	 UngqAQsBC5Jf/no/pkP6OrFuOTBtC0gpe1dl16sypdOVdC8fHqO/xPVRmfLqetfYjN
	 9TH4Q27M8M7eJtM7jL4gWBOCPCmgTX6K4+Otx6pR3+bALNaJRyE6cNWstFKvAQrgUS
	 CInUBvvyIKs9TghP2jacQ5sM34XU3g9leDmW1b57Se0CPPC33S1LnRNgA4JDnnd66o
	 36AqFehwQt7SoY+hoVChP+7m+s7msZeIzORoksa9qNZzmep8tNkKEfsV4zP1jK+HL5
	 +E5fy9Dar+0Cw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Daniel Almeida <daniel.almeida@collabora.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: block: require `Sync` for `Operations::QueueData`
In-Reply-To: <CANiq72mGmRTfauU-HUOyBVSG0GM7q39=6aP8p1djN2cHr5C_Kw@mail.gmail.com>
References: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
 <CANiq72mGmRTfauU-HUOyBVSG0GM7q39=6aP8p1djN2cHr5C_Kw@mail.gmail.com>
Date: Wed, 10 Jun 2026 20:02:34 +0200
Message-ID: <8733yugtol.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Jun 8, 2026 at 10:25=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Fixes: 90d952fac8ac ("rust: block: add `GenDisk` private data support")
>
> Should this be Cc: stable given the hash is old? i.e. 6.18.y+

Yes it should have cc stable, sorry.


Best regards,
Andreas Hindborg



