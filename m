Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5438643E
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660711; cv=none; b=JRRrp+Si3uEmO5Ilvvk9RV7ZhkK5VPV7cIgW0qSGoz2RkN0Bw5jJLbLNToh2j2mqW5HD5YhBee87GTJyfMyORwuwK9Z14SkqkewL8GEvhKRdUzzkJD44Lm0SHtlw4f2Y+d7RNpKaQ2xvr0eTZ4nptOHHM/w5m67SiqPdPERza2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660711; c=relaxed/simple;
	bh=45CuDvqPZ4PRapoYQc5Ywl8DFQTOMg+OZJYGloyAetw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1kxZdsntJAw3LfTdQPNdgrY34+vHiBDP8SajH8s5N5/G6gxXbwS0o1quDGk+WHWdf5OUcOIfBLGCxTQZP89Mtm4aZXH3RWdwEaRTE3wmhvUIx0JmOEVqmALSFkq7biiwisNKRcpS5W1Lp0LgnzHtKYj6XaBRXRxWe9kkrfuCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzOQls55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzOQls55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F05CC4CEF7;
	Wed,  4 Mar 2026 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772660710;
	bh=45CuDvqPZ4PRapoYQc5Ywl8DFQTOMg+OZJYGloyAetw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzOQls55G9MYcUZOWlcRol4oxPTnAmXP8bpU8oHUuDMA/Eya5Gm0P2NpISsCccqt2
	 DPms+FJs3Qb3KLcg6bYu/3ke2bRYUBFUMaFsw0Hk0nT399zWl3Ps6DyGzmvRqsm0u+
	 zteyFB6uTKUhFCeUchDH/IOInjTAgZzspZsKJmXhBVABHrCdEbkn2yJvSziCgWBTOb
	 0TeAmk2pmBN1CzvVaB5WyFwHuz3E0eUhDKwY6N4SeiyRRMtaU2Rb4wcvdE/C/+Eg90
	 JDhwXtLc+0xnc+rlFEL/bxb62UEZVhWVzDQspSD66+Qz11yo0aGkrts9EfnTXeAvPl
	 22NqxHXhGMNPw==
Date: Wed, 4 Mar 2026 11:45:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 03/14] block: Make the lock context annotations
 compatible with Clang
Message-ID: <aain5U1gMQpwJXXY@slm.duckdns.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-4-bvanassche@acm.org>
 <aaiP-EE4M0iywHzc@slm.duckdns.org>
 <dfa02afc-b517-43cf-a136-4c5d464fc457@acm.org>
 <aaic_mAZCuC0wZdX@slm.duckdns.org>
 <159e66de-5934-4d60-862c-de4dce9afc7d@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159e66de-5934-4d60-862c-de4dce9afc7d@acm.org>

On Wed, Mar 04, 2026 at 03:34:12PM -0600, Bart Van Assche wrote:
> Here are specific examples of what is possible with the Clang
> thread-safety analysis and what falls outside the scope of any code
> review software:
> * Documenting which synchronization object protects which member
>   variable (the __guarded_by() annotation). It can be very difficult
>   or even ambiguous to derive from code which synchronization object is
>   intended to protect which member variable. The Clang thread-safety
>   support allows to annotate member variables with __guarded_by().
> * Whether or not it is intentional that some code paths unlock a
>   synchronization object and other paths do not. The Clang
>   thread-safety annotations include __acquires() and __cond_acquires().
>   These annotations not only enable compile time checking of
>   synchronization calls but are also useful as documentation to humans.

I'm skeptical that the overhead justifies the likely constantly diminishing
benefits. I suppose it's upto each subsystem's choice.

Thanks.

-- 
tejun
