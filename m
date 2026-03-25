Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CF328B77;
	Wed, 25 Mar 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474031; cv=none; b=Hq+s7/fqUEGbRiQL2DNFXfq+YcNBS66i68juoR1QQQWJenTWOHBlayJoE/QoEVd/XusMLcNx62d9ftr1KOImXwbyi871twIUVdlguAUW69w7hFh3QS3bOPIqvcLUhCb0u7yaBNvvg3DhBNwDm24sV5DoGazJNJbhD8+KcQVm3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474031; c=relaxed/simple;
	bh=tem1uJ+d7+Z0vsP46HAKKtW4172poK6lZ9yeRTLChV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/vrZAuYXy6fq7rfVlN8Pptfwg8OERvyIZCQc7qARW0acTz3GlXJifejJEh08jz01mNWlEUOWsQNZ7WtJN/VmSPo7nJtd/5LKVmiqVQ1Vq7vl3HlE52sN1ERuV3Ejxj2jb16xf4rsbi42/MO3bJRxlkmbRxsz2psKFmEnZAdwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEuVoIYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEuVoIYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DB3C2BC9E;
	Wed, 25 Mar 2026 21:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774474031;
	bh=tem1uJ+d7+Z0vsP46HAKKtW4172poK6lZ9yeRTLChV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEuVoIYLVtoftWWwyGrF475dMtCCd2poUDpOUzT8no5nL4N08asxy43Mq2KzZrp5J
	 pW1RHI/HokAxu2SOklZ3IAtzg3h+W+94V4XuZJtSt4Tlfr7lueaOVToJpMBEh2lmoO
	 mb8kf3olRxqz+zoRDeQ/kfKxhv+J5YnVk2xH6IG6+V3lCZReue51xXzKYcEsZhWf9W
	 xC9IxD3L+Itb1V8qheywILfid3AE7LLaGJXHdPWo+aXSPPg1tU1tIlztSby4YFbzPS
	 QFCtSA8dcYqWpMrWA03ypXzQqjH816tf7QEE6CWC+pBTjH/2eV+qX0ww6+UwCF9NVO
	 6iJus0BJMorQA==
Date: Wed, 25 Mar 2026 14:27:11 -0700
From: Kees Cook <kees@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
Message-ID: <202603251421.20D29E29@keescook>
References: <20260303162932.22910-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162932.22910-1-cel@kernel.org>

On Tue, Mar 03, 2026 at 11:29:32AM -0500, Chuck Lever wrote:
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

So, I'm not a big fan of this just because the whole point is to catch
unexpected conditions, but there is a reasonable point to be made that
this case shouldn't be covered by kernel/kernel copies.

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
> @@ -42,7 +42,7 @@ static inline void copy_overflow(int size, unsigned long count)
>  }
>  
>  static __always_inline __must_check bool
> -check_copy_size(const void *addr, size_t bytes, bool is_source)
> +check_copy_size_nosec(const void *addr, size_t bytes, bool is_source)

"nosec" is kind of ambiguous. Since this is doing the compile-time
checks, how about naming this __compiletime_check_copy_size() or so?

>  {
>  	int sz = __builtin_object_size(addr, 0);
>  	if (unlikely(sz >= 0 && sz < bytes)) {
> @@ -56,6 +56,14 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
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
> @@ -216,8 +216,13 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
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

This seems reasonable with the renaming, though I might come back some
day and ask that this get a boot param or something (we have a big
hammer boot param for usercopy checking already, but I like this more
focused check).

-- 
Kees Cook
