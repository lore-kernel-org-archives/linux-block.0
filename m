Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06C34E74D;
	Mon, 28 Sep 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588947; cv=none; b=n4+XGlwvYs8/1X1Is9qAEtKPsQq49wh4GwGsjIoI1WWV6yoOySZJQG+RzpQra1n5r78tKXg8XI7UCNtpq1Pkg4PuGIZaOUf9nTAr+PUdiCfAkE9XIi4QPA0n1l1ArqsUXHOVQtvX9CDXTeu8VFxRViAzfQk3/r5EBUkv7SQupao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588947; c=relaxed/simple;
	bh=nzAZZ2Fk+XIGsb3KlY06fjh+7wlpZcldmo/pO/kliBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/TayKA3cjI8us2aG2sNEJxSiin5WFSTZ2V51d5POUA2zv7keBhaZLGEJwGUpTm5IRzpi5TQEVnDjnV5fECZlkl+jvak8E9uRrELRceRFVgR91iS7j9BGXcqEHY+Avy4SWWGcidLUr2Vk8ucBqSv50DFV83YiPpwbYInMakrGE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaxnBtga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaxnBtga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF321F00898;
	Mon, 28 Sep 2026 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588945;
	bh=u/ceWRkV6k0XpJ9HztqNGZY/3VP1HvEl02HVs2m37J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WaxnBtgaqLl6uz5EKkZU53Lt9nbpti67theGVWuB2OHleAksZ0NLaGiJ0K+uvlzKO
	 SlRqTCefHDpe5ABUjvwPdA1Yz36qIP2oOV2MbB0tqlR+YIe9AZ3B2iQLabjamB++Vy
	 1jyiIqd/M1AgwmsYR4OcwjF495Wlnk99wKmAFD8WnymoOxRaoE4Bo8shGpRsVZiEsp
	 f2vGwq6ZgRBCfac4z4WNLNDVke7pLmBY1lDUQm13puirmvMP5RKKEpIbelIRg+La4/
	 JebPKQJ4Jw74GWZKi0jtEPxd5XvqqNlVWLcok8su9o/96Lh8alJs8SEqKJzx3Xb/Ha
	 10oFqzYMQVrfg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Mohamed Osama <mohamed.osama189110@gmail.com>, ojeda@kernel.org
Cc: boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, longman@redhat.com,
 lyude@redhat.com, linux-block@vger.kernel.org,
 linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] rust: introduce DropGuard
In-Reply-To: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
References: <Dch07wH15t-1WtaVQW4vdfmtJuwC_4-JLvrWSB8Pk4vfEHO6mQk1FpYG-tCYBllTB3RbpOXpdyNZp84w4PFl1A==@protonmail.internalid>
 <20260927104528.103881-1-mohamed.osama189110@gmail.com>
Date: Mon, 28 Sep 2026 11:48:53 +0200
Message-ID: <87jyo5u2nu.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Mohamed Osama" <mohamed.osama189110@gmail.com> writes:

> This series adds the Rust kernel DropGuard API and migrates existing
> cleanup guards in the block, serdev, and locking code to use it.
>
> DropGuard is vendored from the Rust standard library and re-exported
> through kernel::mem.
>
> Changes since v3:
> - Vendor DropGuard in rust/kernel/std_vendor.rs and re-export it from
>   kernel::mem, following Gary Guo's review.
> - Remove the DropGuard KUnit tests and Kconfig option since the
>   implementation is vendored from the standard library.
> - Keep the existing ScopeGuard API unchanged.


Could you allow for at least 24 hours to pass between new versions of
your patches?

  40 mins. ago [10/10] Mohamed Osama, sashiko-bot@kernel.org, Boqun Feng   =
 [PATCH 4/4] rust: sync: lock: use DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
  Yest. 01:53 [12/12] Mohamed Osama, sashiko-bot@kernel.org, Gary Guo    [P=
ATCH v3 2/5] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
    Sat. 18:46 [11/11] Mohamed Osama, sashiko-bot@kernel.org    [PATCH v2 2=
/5] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
  September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH v3] =
rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
  September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH v2] =
rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
  September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH v1] =
rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
  September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH] rus=
t: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)

I'm confused about your versioning scheme.

Could you include links to earlier version of the series when you send a
new version?

The b4 tool handles most of this for you. I would recommend checking it
out [1].

The first v1 has a link to a github issue. Could you please keep
including this link? It is helpful for context.

Best regards,
Andreas Hindborg

[1] https://b4.docs.kernel.org/en/latest/contributor/prep.html

