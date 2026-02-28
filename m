Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C951DF980;
	Sat, 28 Feb 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248798; cv=none; b=Nk/CC9I7ND8MDeUUO9ZEKifIcC4112oZYzPZsR0+0IhgmK8c1t5mV3W2c3pbDc9oeDr3S6Vb86WENu821aGIB0bCCrQ8m4m3fv57hZmUDgfTjGlxon4LQ+aeQ+UlVkwPZkn3U3oRs2iYrXxEGHjBMHQj5Exqhr+ZtzKScYte3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248798; c=relaxed/simple;
	bh=jAaTl8amz6NojQ8tNyBlQViGuePzEjqJZ7SlMppHCuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0TkzMVQnUU8JDFBCBC5LeCcQcHuRpKNFzBdxZ/n/7tzxco9bThGGZX1gC6y6vW4U3W7nr4hvhAfhOEgoZlLs4n7/b4CwcKnE4PxCaj2I+F2y/IEmgzBeCBT1MUdK0bQi6AOmwyinYFmaqB18/258tZUrzpL0O+JQoyk8UrQf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk3xxCe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk3xxCe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10876C116D0;
	Sat, 28 Feb 2026 03:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772248797;
	bh=jAaTl8amz6NojQ8tNyBlQViGuePzEjqJZ7SlMppHCuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tk3xxCe9/xYjrflhO5Ellc9EE+aDKPaKTveLIc4SfXEEHOO9Xo6Q0GfbS+MVrnfx6
	 CHgIkw3FxADDIaZqbzhGmxQvZVaKxB1Ar2r8S4eozjwPhv9S0Gkf1uSHpEFyOAzEIM
	 ZwxCvxNgRml8f9zUi2SzOqOP6W8+rcTnA0puYNrfx5ZvfjcaEDRh1ALKBjBNc2SWlG
	 2FpGw94Oc0y+7LVKvDYlrcUAl6dDl82x+gPgTKvhLEGv1SzEI7QmRHx2mLjGTXQzDu
	 4XaDopUI61PFEwOPbt2ymGTuL526avgXaBvFpIsSG71f9os9Hnka/JweQW3+1GN/CB
	 sndgjtFbb/1PQ==
Date: Fri, 27 Feb 2026 19:19:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, David
 Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org
Subject: Re: [PATCH net-next] net: datagram: Bypass usercopy checks for
 kernel iterators
Message-ID: <20260227191956.56539ecc@kernel.org>
In-Reply-To: <20260225162532.30587-1-cel@kernel.org>
References: <20260225162532.30587-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 11:25:32 -0500 Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive path.
> These checks validate memory regions during copies, but provide no
> security benefit when both source (skb data) and destination (kernel
> pages in BVEC/KVEC iterators) reside in kernel address space.
> 
> Modify simple_copy_to_iter() and crc32c_and_copy_to_iter() to call
> _copy_to_iter() directly when the destination is a kernel-only
> iterator, bypassing the usercopy hardening validation. User-backed
> iterators (ITER_UBUF, ITER_IOVEC) continue to use copy_to_iter()
> with full validation.
> 
> This benefits kernel consumers of TCP receive such as the NFS client
> and server and NVMe-TCP, which use ITER_BVEC for their receive
> buffers.

If it makes such a difference why not make copy_to_iter()
check the iter type? Why force callers to check it?

> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..e83cf0125008 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -490,7 +490,10 @@ static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
>  	u32 *crcp = _crcp;
>  	size_t copied;
>  
> -	copied = copy_to_iter(addr, bytes, i);
> +	if (user_backed_iter(i))
> +		copied = copy_to_iter(addr, bytes, i);
> +	else
> +		copied = _copy_to_iter(addr, bytes, i);
>  	*crcp = crc32c(*crcp, addr, copied);
>  	return copied;
>  }
> @@ -515,10 +518,17 @@ int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
>  EXPORT_SYMBOL(skb_copy_and_crc32c_datagram_iter);
>  #endif /* CONFIG_NET_CRC32C */
>  
> +/*
> + * Bypass usercopy hardening for kernel-only iterators: no data
> + * crosses the user/kernel boundary, so the slab whitelist check
> + * on the source buffer is unnecessary overhead.
> + */
>  static size_t simple_copy_to_iter(const void *addr, size_t bytes,
>  		void *data __always_unused, struct iov_iter *i)
>  {
> -	return copy_to_iter(addr, bytes, i);
> +	if (user_backed_iter(i))
> +		return copy_to_iter(addr, bytes, i);
> +	return _copy_to_iter(addr, bytes, i);
>  }
>  
>  /**

