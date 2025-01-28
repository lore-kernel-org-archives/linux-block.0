Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534D125DF
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738025592; cv=none; b=oGWQVKO6aMMYLsH3TeriKxZhUbUsJvQ9hUEaO5vu4t6EL1NRgO7m4oHdm5t3vE0LMCqycxz6Jc6TR6JqE9iRucWQH/wLrK0iQdbXZk48h56T2OVhFiv0O972UgXxnQBE3G79M9ZQschZtxE9blKc6d0MpFERX0EHDOWubTDbaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738025592; c=relaxed/simple;
	bh=V8hCmqSu648rjGj9uef2mOgFY3g/hPMBNN/V/Gn2vkg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mQ9+TePfjZbM54HDSUXsQzw9JPlpTLQ//k9KypC2qLypvlN50SUuoScErNOMvFyD0CTPWKP/YDIKF7qNFExoVXdh9DxPvUbtJwkG+u6ejwINh7WfGdyFuGrwOYxn1SYPiOk9+J4NzKryfa5nMXB791S+NjIdy8WHSHzd11YvBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PsUE3hI+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PsUE3hI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B665C4CED2;
	Tue, 28 Jan 2025 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738025592;
	bh=V8hCmqSu648rjGj9uef2mOgFY3g/hPMBNN/V/Gn2vkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PsUE3hI+T7bp7NhvLcEykdZQ8RJk4lCsCeT9XhOeZUT5LHHMC2yAV4/rdLc/i+l6j
	 T6rvaDuvbUlzDUBv1xLHbWbWHl+eAmDcvnzcIxuQsQ5tcUY/LL8zDtlYzw+MxZu3vx
	 o7LXMuDnFwQ+fiDNw0hKtQY+KBV9rD8+UrIZ166s=
Date: Mon, 27 Jan 2025 16:53:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: sooraj <sooraj20636@gmail.com>
Cc: linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH] mm/bdi: fix race between cgwb_create and conflicting
 blkcg associations
Message-Id: <20250127165311.f51b98290b548aff1df92a81@linux-foundation.org>
In-Reply-To: <20250128075250.11500-1-sooraj20636@gmail.com>
References: <20250128075250.11500-1-sooraj20636@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 02:52:50 -0500 sooraj <sooraj20636@gmail.com> wrote:

> Ensure cgwb (cgroup writeback) structures are uniquely associated with a
> memcg-blkcg pair to prevent inconsistencies when concurrent cgwb_create
> calls race. This resolves a scenario where two threads creating cgwbs
> for the same memory cgroup (memcg) but different I/O control groups (blkcg)
> could insert conflicting entries.
> 
> The fix rechecks for existing cgwbs under the cgwb_lock spinlock after
> initial creation. If a conflicting cgwb (same memcg, different blkcg) is
> found, it is killed before inserting the new entry. This guarantees a
> 1:1 relationship between memcg-blkcg pairs and their cgwbs, preserving
> system invariants.

Thanks.

This looks sensible, but it would be best to bring it to Tejun's attention.

I assume that this race has been observed in the real world?  If so,
please fully describe the circumstances under which it occurred, and
describe the userspace-visible effects.

Probably a "Cc: <stable@vger.kernel.org>" is appropriate.  And it looks
like the offending code is so old that a Fixes: won't be needed.

> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -723,24 +723,39 @@ static int cgwb_create(struct backing_dev_info *bdi,
>  	spin_lock_irqsave(&cgwb_lock, flags);
>  	if (test_bit(WB_registered, &bdi->wb.state) &&
>  	    blkcg_cgwb_list->next && memcg_cgwb_list->next) {
> -		/* we might have raced another instance of this function */
> -		ret = radix_tree_insert(&bdi->cgwb_tree, memcg_css->id, wb);
> -		if (!ret) {
> -			list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
> -			list_add(&wb->memcg_node, memcg_cgwb_list);
> -			list_add(&wb->blkcg_node, blkcg_cgwb_list);
> -			blkcg_pin_online(blkcg_css);
> -			css_get(memcg_css);
> -			css_get(blkcg_css);
> +		/* Re-check under lock to handle races */
> +		struct bdi_writeback *existing;
> +
> +		existing = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
> +		if (existing) {
> +			if (existing->blkcg_css != blkcg_css) {
> +				cgwb_kill(existing);
> +				existing = NULL;
> +			} else {
> +				ret = 0; /* Already exists, treat as success */
> +			}
> +		}
> +
> +		if (!existing) {
> +			ret = radix_tree_insert(&bdi->cgwb_tree, memcg_css->id, wb);
> +			if (!ret) {
> +				list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
> +				list_add(&wb->memcg_node, memcg_cgwb_list);
> +				list_add(&wb->blkcg_node, blkcg_cgwb_list);
> +				blkcg_pin_online(blkcg_css);
> +				css_get(memcg_css);
> +				css_get(blkcg_css);
> +			}
>  		}
>  	}
>  	spin_unlock_irqrestore(&cgwb_lock, flags);
> -	if (ret) {
> -		if (ret == -EEXIST)
> -			ret = 0;
> +
> +	if (!ret)
> +		goto out_put;
> +	if (ret == -EEXIST)
> +		ret = 0; /* Lost race, another thread created the same wb */
> +	else
>  		goto err_fprop_exit;
> -	}
> -	goto out_put;
>  
>  err_fprop_exit:
>  	bdi_put(bdi);

