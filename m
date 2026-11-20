Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177650;
	b=yFPuAkQ8fNETlXC8FfJX0Jiy2AkztdSLiE1KJahwpFgxJuLZbOFA4LgGZp/IaXRrCHiC
	 qccqMtWBD4RDdcVOuKYJXRFEIZoMM/NAU9kQdY4ojdy1IPK825bpuxPabjQr4lqm3IjzW
	 8lhb4wM3h275q0LsSIIyTHmaSJjCupdLBL5l/CBn4OeXnwl/oYVMw1M9W0+DhLh/WAuMP
	 P6Oee8IbRewD4sdK0j6PhSmxQG6y/EttiLlQskL7jKln1COcK5VW4bumLfyc+fBWXLufc
	 2cdnniSfCUWKt+yvco14ixqeZE14gtNX7J7DUp9kQ3t2OepNgs66KZQJEg8M2lzEAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kvgctjI9KPuDJg2N/GrQ1LU6SS0k8fTXknYzvILwoCo=;
	b=3LEW3HV9UFnCQ12xfJtx8F1cACuy1nTQPQYxcPyi+EWNZAvPJnroupogi834wpDvS9ae
	 cJAd4C+uiYnLiD7zE1dTL02RYXS548REN3sfChjnSnW7ITEO1iaGB/YmLoq9SkV1U9WO8
	 X+9GCt7+nNUAoou5DSCJWIXInxzGkf2OkWVYj/Q7Gg0kuk5PFe7qjkc2YJ+MpY2tLiD3O
	 8YukxEC6iNDTHiL1gWGU/1rUFrkFB23zlQ14a7NxzncfwCtRcDORc+QKlGb01QKWI1HwP
	 V6Z6aR9A6YFnoiKM59Dm+rvZR/B3EuK0pr/7XuROrL0K5GzGJb3vpv1bH9U/sDcAigQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkHvcm6l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B3606A320;
	Fri, 20 Nov 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkHvcm6l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F061F000D2;
	Fri, 20 Nov 2026 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177649;
	bh=kvgctjI9KPuDJg2N/GrQ1LU6SS0k8fTXknYzvILwoCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YkHvcm6ldyMuVWFZeilRQvbC0SFtOpk7wJkjBou4AE06ubZzK69ombKyI/ooJlYzd
	 ErIf4j/lFGSVAnvHczKm0eI17hf3pJuERUi7U8E2ESO9DqLvn6PMtleLSCe9Cve0fq
	 AWSUoz8UHqQ/d7BRVIgiC30zqiCe9QJkAGIMthYbFTe92rQcky6XrKdDpVlXRsWOhX
	 0pzCJu4EIP1hV6vXUdjase903T46dqNiYxaha5yhjQvrVHuX9toRESiahKB4iuznc1
	 P23Qhua+5WMnDD/kf7zGp6iM2UWNuAdyH8RBbYHkA+QFPiTzJKnB1jbudMWfjEZCOX
	 G775gDDCYG7Qg==
Date: Fri, 20 Nov 2026 13:27:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH RFC 0/3] fs/pipe: copy a run of pipe buffers in one user
 access section
Message-ID: <20261120-kochbuch-dortig-schaben-2a60fb232a2e@brauner>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
 <avwYnDc2Au4mnHTd@chrisdown.name>
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
Content-Disposition: inline
In-Reply-To: <avwYnDc2Au4mnHTd@chrisdown.name>

> Based on that discussion, I'd think that the better way would be to make
> x86's unsafe_copy_to_user() use the rep movs body from patch 1 for
> larger copies. Then copy_bvecs_to_iter_full() can be written with
> scoped_user_write_access_size() and unsafe_copy_to_user() for every
> architecture, without the #ifdef.

Yes.
