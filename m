Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFF470EA5;
	Mon, 28 Sep 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586204; cv=none; b=hZbxNmuulqctMubrxqjLMdtCmZsH2uf52htHItTrM3SBWC9Zqz25UKnvAEp3/DQA6JnbVTDZmczW7fC7hss2Uh5LsWU0Hdu/HUMALoN2oQ5fkOUShlUMYfx2vdvoQBZ7bFaEUxxfRSposiCYQtfkz05uiqNwiMzWYvPJQKuxzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586204; c=relaxed/simple;
	bh=S/4yCn5luKLcY6Dpp3DuOsQxBwSp+1YYeEAg+LLvahU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxEEgWzFuWKmUpUTNpTipZZ3jckBAUiQkfFsevdKZEO03BEHOZzPM5uULpnJsYnR2Jl9BO91CFTZmbozYvL/iaoOkLPkPd0CZiTcteKl9Ln9ESETUVLmZa/fmGD4fmdS55sQsSq81/t0+LUHIMweIsxNLnE/gOxtM1op0FKDBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUsDtbN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUsDtbN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D511F00898;
	Mon, 28 Sep 2026 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586202;
	bh=ybuC18kPg8rfvVY+whEpd4VHMaUEXm98hwIhJsveAq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NUsDtbN5NTpkMxsok5k+u6P7KTfFC352t3TXpdYSFCOHM+WoTU4kwT3nyaQmZzfFZ
	 YSYpOc9R83DgAz4y1LFSkeOb2UNrP3ohW7UCOX3nqJImffre5tW23B+m2V0yl9gYDh
	 71Z7s+cUtigVVOSeAiZDnlJtRyq4YRGD9Vx5zB1pbEoBMYJJ8QyBu3pCoudwczrA3Y
	 oIoFSbCD/J3AzTJHk1egML6Os8Jy/vfZ61IsBzhSYtA8BMP3Hp7HJd6mK23hGvr4Ht
	 S/82BETuKLBkoojlDhiHg2BzdHux3w4tuXWaPXBMAazAy39wf1oO3gPYrlCShJBRFg
	 S+EfW9l2VgvwA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D2EDF40066;
	Mon, 28 Sep 2026 05:03:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 05:03:21 -0400
X-ME-Sender: <xms:WS26agw-HF9YgDM5sVq3kTk4Vxgbo46ZdEbug6r2JHtJ6jdQ2I9ITA>
    <xme:WS26ah8a6YKR271s4S2vmMFd2v19FRZ0m-VCNozWo2q3-GKPeOhGuPZGpOw4nnVQa
    ItqhHayHHlvs2CXq42HvQYln1i9JQ-taKsXTpLb2OmKQsOTfnOn>
X-ME-Received: <xmr:WS26akHjvnQnxcQrsY2qpGzqZSahh0zVKfdacEzx6ZohoGGoFhAwYU8ULgw4>
X-ME-Proxy-Cause: dmFkZTEAF6v69J6aSg1nda2y3oxb5zOfzY1BetxYf0fwBbSLe2SnKh5y7tMZ+ILsbeyE+0
    esG5dalupHEynPqbVgQFD+lFafFzJz+aX11klo2l27aYzHk1VMD8bSOALHkAB1Nex/nUff
    +LDZywo0MP4b7XKfjnZBQ449SX/qJA+pCuVzOJRZdMaQGPH+jEKiazQ9f/tsvqdkc+3030
    6I6sRXD1wkncQFiQe7qtJlBiCjJjKUcqcn5wTWJ3+5Kwx5lBMRW+X/13nxmyDQ61thn0zN
    Lux3lKVqPjZ7QPSgLv4rUiLqKDzFHSUlvHv9Ipfc525IFHaaWGZSRjOBk6QqlW78O9BZRw
    VAVmCgy1EhvAdYcsUUVdSsTtySDEvrIGEdc5QQgFdG2IU9IPGOaQuq6EFK5FfhpL+P5WYm
    XID0KkjQkVLpCJn0f0ZGmwikymC+iNRQ6gNaCK5lWnRA0YBRpI3c6ZoURUNpy0c8Idu/Yc
    3CsRHvNyYkbVwgmwnbmoX+G2Qzsv+5hFVOmCzs9rWqaXEB10qCCXJr+0W81e0/R3ZpVcT4
    EwPu6RjB04zcztr1LAM7VLhpoZRhOdQqs1MJSafq4rGJua8Rbiv6piUeXhhWwEM7nIdi3F
    lxVVN7ZXykCi01NI3kow8sIap6XvviwqjwKoIjKiyC218jHZ2HdJPwYyLM2w
X-ME-Proxy: <xmx:WS26arDhyo41dT6ltEPK3sp9Puu3fsmv3Ve0DYScffTlQKumSAokig>
    <xmx:WS26aonOwYEQIul1TXqP8G4eXzAulh8VqzTv4FV5Dd3F_w3ioTVIDg>
    <xmx:WS26auQnKp2bZhGt44Reoe5cHZlZv-BH9duSJPxGMOHc7nK3r6oecg>
    <xmx:WS26akKICBPUJB4DmNU0inmE_r6UIYlEzx98RmHekMh2GIwpRgAtnQ>
    <xmx:WS26as9dnxw2qbVH2z10d_g038mHJbs6OnRBQLftx9uZV8y0WO-1tQ4A>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:03:20 -0400 (EDT)
Date: Mon, 28 Sep 2026 11:03:19 +0200
From: Boqun Feng <boqun@kernel.org>
To: Mohamed Osama <mohamed.osama189110@gmail.com>
Cc: ojeda@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
	longman@redhat.com, lyude@redhat.com, linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] rust: sync: lock: use DropGuard
Message-ID: <arotV9Iszgg-Z1aE@MacBook-0RXW5>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
 <20260927104528.103881-5-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927104528.103881-5-mohamed.osama189110@gmail.com>

On Sun, Sep 27, 2026 at 01:45:28PM +0300, Mohamed Osama wrote:
> Replace the ScopeGuard usage in the Rust locking implementation with
> DropGuard.
> 
> The guard preserves the existing scope-exit cleanup behavior while using
> the DropGuard API from the Rust kernel memory module.
> 
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Reviewed-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> ---
>  rust/kernel/sync/lock.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 10b6b5e9b024..15f9cbe76c8d 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,8 +7,9 @@
>  
>  use super::LockClassKey;
>  use crate::{
> +    mem::DropGuard,
>      str::{CStr, CStrExt as _},
> -    types::{NotThreadSafe, Opaque, ScopeGuard},
> +    types::{NotThreadSafe, Opaque},
>  };
>  use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
>  use pin_init::{pin_data, pin_init, PinInit, Wrapper};
> @@ -242,7 +243,7 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
>          // SAFETY: The caller owns the lock, so it is safe to unlock it.
>          unsafe { B::unlock(self.lock.state.get(), &self.state) };
>  
> -        let _relock = ScopeGuard::new(||
> +        let _relock = DropGuard::new((), |_|
>                  // SAFETY: The lock was just unlocked above and is being relocked now.
>                  unsafe { B::relock(self.lock.state.get(), &mut self.state) });
>  
> -- 
> 2.43.0
> 
