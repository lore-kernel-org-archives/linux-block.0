Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592D3FA5E7
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105840; cv=none; b=ZrgPwO1fGDG87TiWbZKl1hudPEg/XuaBsYvIwQBWQl4i8bMQaB36e5/bXGzvFX8GSoFW0jfFu2lMnGe9rC5PZvkynzmMKvtk3yEG8c1r9ETWU9ZPiUHWdmmkFT4FRBOR4qjez9AMCtJqjl+fN7FQGNYMCqhsS19EPv8Vbk4nl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105840; c=relaxed/simple;
	bh=8JPamgXnw42msGc4C8S9n4Yawf25tSB/nrLCULrTdn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOEWSMyn1bfBW9kwZskFKq8WZ2/DuG8Ky7OIS8qSDORiBea2Fz2Ho6D3Hw5y8aavgnwbQUs8W0WmVNfuS1aWR4nE8ydKt04UhxLUWHHrugrbhuit1BMvJ8EgAWQKbRDkDfpyGj5SuKmm4F3F3cZSL7sQfYqth9yRsK9RgDXuytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csYYJ6cE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csYYJ6cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3C01F0089A;
	Wed, 10 Jun 2026 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105839;
	bh=VJFW0UIl++hCG2YoLN1CgYYeXLAYJ2aqtcmS0TI4Xas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csYYJ6cEZrG9yqL7JBuom62dJyV8fWI+sRr1hX4Br2YGH0jzI9TnmPXs0o5jgyp4a
	 jmhGo1HsnPSEqxtG8oz03XzXm1pdsM0cir3/gk+AkmVjxjRfx1L6pewxDWEDgRHKJf
	 vStlvMA3tc4z/7TwHDVCgBKNK9ilItrNR7QWqS7t2yN0aZYzDkV3hC0mLF24SS7at/
	 GyDPGEz4gcdzMUr5AcGoS3bqGRlATeI5QQRGikdizi/emrKmh60cXs/9/d36Qx/bxJ
	 ooT3GswKiSVi6/yj1AdTlBc0/Uph9QF17lBwCKTjydYgBdqvkiA7UzOeW4DG61kHUa
	 FF5VlQB37TUUg==
Date: Wed, 10 Jun 2026 09:37:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: brauner@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <aimErft1NoW-4Map@kbusch-mbp>
References: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>

On Wed, Jun 10, 2026 at 05:27:42PM +0200, Carlos Maiolino wrote:
> The DIO alignment check has been lifted from iomap layer to rely on the
> block layer to enforce proper alignment when issuing direct IO
> operations. This though, depending on the IO size and buffer address
> passed to the IO operation may lead to user-visible behavior change.
> 
> This has been caught initially by LTP test diotest4 running on
> PPC architecture, where the test fails because a read() operation
> with a supposedly misaligned buffer succeeds instead of an expected
> -EINVAL.

It's not supposed to matter where in the stack we determined this be an
invalid request: it should still fail if it's misaligned. Could you
clarify how this is succeeding?
