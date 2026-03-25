Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C94405AA6;
	Wed, 25 Mar 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459604; cv=none; b=Jy4UusPTiwUAJ+wpkI1U7ky0oT4MeUy/F4CDiBXjzC75quFW2okmcwqTzFyNIHahCID0um8/qs8MTVMD775NZ8rCsUn3tPbBfSFPCThErHqjLV+8T3FyyDOfHP2XIvDruLmfOMlgNfXI290jVApBGxvADokSnUfAbqe5XYn0dvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459604; c=relaxed/simple;
	bh=8MKiB5e+7wU5JMRzvptDLH6dhESil3VUSqbtlMcTZuo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gO2iNtkVbvNhL0TvzE/itYhZUhIHCAx2hSr3LHU4REwgDukveiqT8ydKDh/6+4eeREWnMG52bO4ZVFQixwMICMGXjjaedGRmweWpyZbkKSndIFWq3ZLz4uspOhfNxRIdQWiddWh9XPDRJXUAXgQRhbTNCWdHgV7U2xL8bpwQ7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2KgyqFj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2KgyqFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38504C4CEF7;
	Wed, 25 Mar 2026 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774459603;
	bh=8MKiB5e+7wU5JMRzvptDLH6dhESil3VUSqbtlMcTZuo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=e2KgyqFjz6lx9UPb1Acn7jv987HppCSYpFVXquvg7iB4GYqk7WWOs56LHWoBcByjs
	 Q3qg9wuNNMfNmx4Z2zTreksSuBMSF0UENwBddzM2090FC7LQt+bFJD/EtqiXP851GJ
	 aZk+dFvepJ1z0vo4BV7ZVzHT4fKWL8LcX5WRecltj9jUDCOXFaLNTxH5aBlQt1BMtc
	 TknlxWKbaLm3FUTAC+vLNTYpSzdYh9I885rUnCspFKnxl0R5Mw7iFAWh3E9odMazoJ
	 W46alJmfyxn+HpyhEL0URuJuXoPbAWw9oppwa2x68JZ4PcemzOpJP2FJ73m/73PxLb
	 fTUgc/vPNYfmA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B705F4006E;
	Wed, 25 Mar 2026 13:26:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 25 Mar 2026 13:26:42 -0400
X-ME-Sender: <xms:0RrEadAZVvCcZD5UoJjuYkc2UKomG5u8aIZIDmA1aMvD_lsLgBYqxw>
    <xme:0RrEaWWxKLcDk3WpBUpYgfrTOuDupuNsqp659RvsL4oxBF5JTEErGLKsUy_Dt6AUJ
    irO6MRRGvhU1n8jRbGkhDkQfnIPTlL1T4FiuBYM0FJ5GSJT-UM44x8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhushhtrghvohgrrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvg
    gvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgrrhguvghnihhnghesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidroh
    hrghdruhhk
X-ME-Proxy: <xmx:0hrEaciY_Eefhlg7ZXsfQz56aA9-v4gO6O7hd1-ic03dRQdmbYqxqA>
    <xmx:0hrEaRmk_FfkqLRKZDroLRG6i3HcrWdtEbjgAnFWYWDYPEL5eGiPCA>
    <xmx:0hrEaYiNstqPBqa3noi3DhTwKjnmJW_03_WYtB1nHvbfdQ0VDq8yuQ>
    <xmx:0hrEaUF0AyO5FiQPVc94gS_2soX9DtEt6NO1xl20JQWZ56PZq3kXMA>
    <xmx:0hrEaau99OhYO1WQlm846Zq84gmzP4vVpFDK8bFF4TLPC4LTvGEz2ALD>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D77E2780075; Wed, 25 Mar 2026 13:26:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyMVdAmERJ9c
Date: Wed, 25 Mar 2026 13:26:21 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>, kees@kernel.org,
 gustavoars@kernel.org
Cc: linux-hardening@vger.kernel.org,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <cc8ff9a7-d7f6-4588-82ba-e77c99574e93@app.fastmail.com>
In-Reply-To: <20260303162932.22910-1-cel@kernel.org>
References: <20260303162932.22910-1-cel@kernel.org>
Subject: Re: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Mar 3, 2026, at 11:29 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> path. The runtime check in check_object_size() validates that
> copy buffers reside in expected slab regions, which is
> meaningful when data crosses the user/kernel boundary but adds
> no value when both source and destination are kernel addresses.
>
> Split check_copy_size() so that copy_to_iter() can bypass the
> runtime check_object_size() call for kernel-only iterators
> (ITER_BVEC, ITER_KVEC). Existing callers of check_copy_size()
> are unaffected; user-backed iterators still receive the full
> usercopy validation.
>
> This benefits all kernel consumers of copy_to_iter(), including
> the TCP receive path used by the NFS client and server,
> NVMe-TCP, and any other subsystem that uses ITER_BVEC or
> ITER_KVEC receive buffers.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/ucopysize.h | 10 +++++++++-
>  include/linux/uio.h       |  9 +++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/ucopysize.h b/include/linux/ucopysize.h
> index 41c2d9720466..b3eacb4869a8 100644
> --- a/include/linux/ucopysize.h
> +++ b/include/linux/ucopysize.h
> @@ -42,7 +42,7 @@ static inline void copy_overflow(int size, unsigned 
> long count)
>  }
> 
>  static __always_inline __must_check bool
> -check_copy_size(const void *addr, size_t bytes, bool is_source)
> +check_copy_size_nosec(const void *addr, size_t bytes, bool is_source)
>  {
>  	int sz = __builtin_object_size(addr, 0);
>  	if (unlikely(sz >= 0 && sz < bytes)) {
> @@ -56,6 +56,14 @@ check_copy_size(const void *addr, size_t bytes, bool 
> is_source)
>  	}
>  	if (WARN_ON_ONCE(bytes > INT_MAX))
>  		return false;
> +	return true;
> +}
> +
> +static __always_inline __must_check bool
> +check_copy_size(const void *addr, size_t bytes, bool is_source)
> +{
> +	if (!check_copy_size_nosec(addr, bytes, is_source))
> +		return false;
>  	check_object_size(addr, bytes, is_source);
>  	return true;
>  }
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index a9bc5b3067e3..f860529abfbe 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -216,8 +216,13 @@ size_t copy_page_to_iter_nofault(struct page 
> *page, unsigned offset,
>  static __always_inline __must_check
>  size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  {
> -	if (check_copy_size(addr, bytes, true))
> -		return _copy_to_iter(addr, bytes, i);
> +	if (user_backed_iter(i)) {
> +		if (check_copy_size(addr, bytes, true))
> +			return _copy_to_iter(addr, bytes, i);
> +	} else {
> +		if (check_copy_size_nosec(addr, bytes, true))
> +			return _copy_to_iter(addr, bytes, i);
> +	}
>  	return 0;
>  }
> 
> -- 
> 2.53.0

Ping: Any further thoughts on this? Al, Kees, Gustavo?


-- 
Chuck Lever
