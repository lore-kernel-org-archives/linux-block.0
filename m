Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565908;
	b=NhA8ie1b5j4v16cYe4NhEKcIW82uC2yNlsVH7pxuBTjpK74QZIFsM0MCrh2RV5jMpKT4
	 ELsu9FYp3YazfEI40qByGsUhj4/ht/eu0jiX39ZMEZtGBisUhPJp2gB6gMBlJcAZYN6PY
	 7lJKwQ8rgiokM6RouXuEGR6rBcChqbJfcw26Y+fubBJU2AHYVaILJMGlpLq8LDJz7liAg
	 fdf/118JhNAg7ir2DVPFKmYK/egsgVLNWXjhHqBI2FK/aoTaqugUk2xEQHAqeZkhaMuy/
	 IS9kaIaZmcAp1X4usipBvJfeF1NaR+cXCjqW2lrMCnX7325HpJNwlJhm/Zm/122VwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565908;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer;
	bh=eMV3fy5t0VpY/FSLcuKHKvnqE+X2qfbYOgi2HRBKryk=;
	b=CZpVSC3Uw9/RY0L8bFLHOUACxq3ShUW5/0Cw2rvMDD3vhd//H8bVtPpWB/7iHXr2LlMn
	 Rh6xcy7+SX8rDWXedgL/wo6j56OWGlWmhL2L49UcF69CV/Ux/95z2qR59zsM11qHtJHpw
	 J24gBNzH2Nt5ATqfQnTBoqXQSR0uPzEjLYmXlLZ4aHrYnradY8aE64kx1H+0KaxAQxDnh
	 jhGFiBULohBkKpnEeZNBLfUYy/bylZ92ek96CajH7e6zIkHIbjdbr04TQwvpYGs44GnV1
	 o8o3yy/7M7MeAq6egDrPT7hA1chvL6nX5/7F2JdDuvJ4Gwi53fwuegzAQQ88AX0cfpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Czea2v3j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A30606A321;
	Fri, 13 Nov 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Czea2v3j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F301F000C4;
	Fri, 13 Nov 2026 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565907;
	bh=eMV3fy5t0VpY/FSLcuKHKvnqE+X2qfbYOgi2HRBKryk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Czea2v3jA1Slv9RRTOWAVO9Uct8INCn23GMuIBv4jdVZnuMTZhH+mKFAI18oOIRCG
	 RKxdKzNbRyXyym3ldge//q0+JToLF2dxXYMy9NI/N/VpwkRTQCPGX7ooWAF9VfsbNK
	 tezH2L5GY4rOAYpuTb9VdBOkzXcOQxdQRHy07gDv4VcgDu+OE1z7MJpra6X3lV0NWW
	 Yzgb1PvG38+iVnu/NyB6q5K/Gdx+l31J+vCgYE8Xr/9tI8KQ2ttbnLVwk3zteVwdLC
	 k24zS6sonl4BYtTnlA1PQgclXefzp55DEWhnJ2AyPcz0M7cjvM6746fEoPRcva7OZs
	 DyGYwIS6inIPg==
Date: Fri, 13 Nov 2026 11:31:42 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Arthur Simchaev <arthur.simchaev@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi.Shchislowski@sandisk.com, Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 0/2] Support for Multiple Atomicity Mode
Message-ID: <20261113105333.3-da.gomez@kernel.org>
In-Reply-To: <20261103093839.203841-1-arthur.simchaev@sandisk.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com> <20261103093839.203841-1-arthur.simchaev@sandisk.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird



On 2026-11-03T11:38:39+02:00, Arthur Simchaev <arthur.simchaev@sandisk.com> wrote:
> On Tue, Sep 29, 2026 at 01:17:10PM +0200, Daniel Gomez wrote:
> > While I think this small feature is worth having (hence this RFC)
> > for users sending atomic write commands that are contiguous, the
> > question I'd also like to discuss really is how to also expose clear
> > MAM semantics to userspace for users who can send larger commands,
> > so they avoid syscall overhead [2] and splitting, and still get the
> > atomic guarantees in the LBA subranges. RWF_ATOMIC currently exposes
> > SAM semantics, but I think MAM may be confusing for users, as it's not
> > simply a larger atomic write but an atomic carrier. Thoughts? What can
> > work best to leverage MAM from userspace without conflicting with SAM?
>
> Hi Daniel,
>
> I agree that RWF_ATOMIC should keep its current meaning: the whole write is
> untorn. Letting it accept larger writes on MAM devices would silently weaken
> that guarantee for existing users.
>
> If we want userspace to send one large write with per-piece guarantees, I would
> keep RWF_ATOMIC unchanged and add a separate opt-in flag that describes the
> guarantee rather than the device mode, for example (names are placeholders):
>
>   pwritev2(fd, iov, 1, pos, RWF_ATOMIC_CHUNKED);
>
>   - statx reports a granule G (e.g. stx_atomic_write_chunk)
>   - the range is split at file offsets that are multiples of G
>   - each piece is untorn; nothing is guaranteed across pieces
>
> If G is tied to atomic_write_unit_max, a G-aligned piece never crosses an atomic
> boundary, because the block layer already requires the boundary to be a power of
> two no smaller than unit_max. A SAM device could then implement the flag with
> one atomic bio per piece, and MAM would only be an optimisation underneath. Open

You mean a "fallthrough" for MAM while making SAM path an iterator?
I was thinking in something easier to start with like simply not
supporting SAM path in this RFW_ATOMIC_CHUNKED flag suggestion, and
return an error like we do today if you send a non atomic conformat io
with RWF_ATOMIC.

The "interesting" thing is (for NVMe MAM) that you can send a large
command and it will be atomic at the chunk boundary anyways. But I guess
users may want to have guarantees of their chunk atomic granularity.

> questions would be the semantics of partial completion and errors, and how
> filesystems keep each piece mapped to one contiguous extent.

Thanks for the suggestion. I plan to work on it after this series.

>
> Before adding a new flag, though: with this series your fio example (io_uring,
> iodepth_batch_submit=4) already sends four 16k RWF_ATOMIC writes as one 64k
> command, so a single large write would only save per-I/O work in the kernel, not
> device commands. I understand real MAM hardware may not be available, but that

HW is available for those who need it. FYI, I'm currently testing this
on a real device and post more details in a new revision.

> cost can be estimated without it, e.g. by comparing host CPU usage of a batch of
> small O_DIRECT writes against one large write of the same total size on any NVMe
> device. Even a relative number (e.g. % CPU per GB written) would show whether
> the remaining overhead justifies new uAPI.

100%.

Thanks Arthur for the review. I talked with Keith at LPC about this so
I was planning to resend it. I will now, take your suggestions and send a
new version.


