Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFE38A71F;
	Mon, 23 Mar 2026 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269554; cv=none; b=JJ/P+1YsMIZ9uWgcpeyz6t9UAijx3Y+1m78EGHeUGWFKT/Mto+t3HIxlP8VM+qqyylD/6x02R6eLDaSphZx0wYZ8ifBvijAmWMsEdRenPIs3vcR5ibc5ld2lp1JbUc65pydcE6M/DX7OgQIXke2tqvZ9FGa06lOKafl985yt5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269554; c=relaxed/simple;
	bh=hCya/JTd/eEjRt8DiFveB4Mo2VALfaq0oo9V+wrFsjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB8I2nUlxuRaylYWYJZxdHgCi6PinjDfvXtiyNcAD3CbJNzHfTUA3f7YmGT90z2skqbJ+NV7fsIEwVwSLwYAxXuPL/e7qQYvMg35i6kA4l6cZLmCw7SZ2RHrppW1aKTk5HLT3P42qa52Oo0Z3h16XU9GRxTG1oAOJOfBOuUsEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3KgS6vY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3KgS6vY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4FFC4CEF7;
	Mon, 23 Mar 2026 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774269554;
	bh=hCya/JTd/eEjRt8DiFveB4Mo2VALfaq0oo9V+wrFsjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3KgS6vYBNuGdwvAlfWLLbvBZFRN9cRIrcX6fsLWb+gGFqIMiCO+4lMuN5P+ywk1o
	 fC3rdtLXyVyA7GsojNlRivLDcdxNwzbKyq8i4cTI04Tl+t2Uxu75RUiyrbUNqMglg9
	 A6cbmbbeXQ/ZS97S0aP30Lz1cWXc95mPe62D3dccqkpVd/A0mN+aW7Xy0Gnah4+A0W
	 0t/dNdZ4vHasfMz2s8vqd4TUaEJjAb9vBZtJF89MFoGKR2ZQp79dhSzRu1CouGbJRz
	 WmBBSS8Byhyl13wyLI/OSEpui00y2+oQJaorcjV+tyNoSWE+xh2HfAy8vazfizrXGY
	 aEKjzRvK/U0uQ==
Date: Mon, 23 Mar 2026 13:39:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] lib/iov_iter: fix misplaced parenthesis in
 iov_iter_restore() kvec check
Message-ID: <20260323-wirtschaften-mittragen-5217e168da05@brauner>
References: <20260313181038.30018-1-objecting@objecting.org>
 <20260313181038.30018-4-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313181038.30018-4-objecting@objecting.org>

On Fri, Mar 13, 2026 at 06:10:34PM +0000, Josh Law wrote:
> When restoring a kvec-backed iterator after a short write in a kernel
> socket sendmsg path (e.g. an NFS client resending an RPC call), the
> WARN_ON_ONCE guard fires a spurious warning on every first call.
> 
> The closing parenthesis of WARN_ON_ONCE is after !iter_is_ubuf(i),
> leaving !iov_iter_is_kvec(i) as a separate && operand outside the
> macro:
> 
>   WARN_ON_ONCE(!bvec && !iovec && !ubuf) && !kvec
> 
> For kvec iterators this evaluates as WARN_ON_ONCE(true) && false — the
> warning fires but the return is skipped, so execution proceeds correctly.
> The warning is the only visible symptom, but it is confusing and may
> mask real issues.
> 
> Found through code review of the operator precedence in the condition
> expression and confirmed by tracing the macro expansion.
> 
> Move the closing parenthesis to include the kvec check inside
> WARN_ON_ONCE so the warning only fires for genuinely unsupported
> iterator types.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/iov_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 325669b103ed..6a7959bfc849 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1471,7 +1471,7 @@ EXPORT_SYMBOL_GPL(import_ubuf);
>  void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  {
>  	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
> -			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
> +			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i)))
>  		return;
>  	i->iov_offset = state->iov_offset;
>  	i->count = state->count;

Look... the placement is intentional as is easily identifiable by
looking at the history of the commits. This clearly is AI generated
and you don't have the capacity at the moment to meaningfully argue or
present the technical changes you are proposing - if you are an actual
person at all. As such I see no reason to engage with this.
