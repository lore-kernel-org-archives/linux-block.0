Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C138F22D
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141872; cv=none; b=H9G+aElbF+DjjT35os+WJGDZzDFJhCakNAKTLKEQH7k+/QrlvGwDdf5koUp3PWFvUWXhzQ4ogwkwf4ffZ8qA/L1E2rNdX8ALnQ4OhGUqgveyCAUmSksbQ11iKNRd0dlav4so4yCe9NwCipLxGvuRwfdf/czh0aIc5+NtXtfhE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141872; c=relaxed/simple;
	bh=YnR9ffm9iDsrmTnrSK+BYOMVVbIYhuRYPyQ+kiew8v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/dzxGNAbPP8EadKwP+GZInR2MtlIzd4MsWshP9vLW8opYRt0YvJsNSCSWdJZTLKWnJqtTHa2skbl4L4hxDSCUJH3JHUJQFmui8llPI7isq+yepU0f44FSk1s0Uaq7MCIQ9w9663Ngi7H3CHx0mZfYZ5LBPUZ4l2wu70pRWT6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkT6Ulij; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkT6Ulij"
Date: Thu, 26 Feb 2026 13:37:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772141869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DcdznLUrOcDmYG/a2OAhCexa8EAGJv2HXxaM916vS+4=;
	b=gkT6UlijS0Kh4njOGpNrZHm+ANe8rI2Cfxg81HEL5UhvGGvUPTXaIXh3IrTkVbBbG9NWJj
	68Jj9R6Hw6VPjJ9g3PxxpSnXd0NymJ8vQQwW+MZKFEEzZ52nGcpYQI/r9l/TJ31Tt7PL27
	x7gwr5+lsU0JMaAUQ8VduP7e9/YsZL4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jens Axboe <axboe@kernel.dk>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/8] mm/zsmalloc: Introduce objcgs pointer in struct
 zpdesc
Message-ID: <aaC80TsqmKpwFzQf@linux.dev>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
 <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 26, 2026 at 11:29:26AM -0800, Joshua Hahn wrote:
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -20,10 +20,12 @@
>   * @zspage:		Points to the zspage this zpdesc is a part of.
>   * @first_obj_offset:	First object offset in zsmalloc pool.
>   * @_refcount:		The number of references to this zpdesc.
> + * @objcgs:		Array of objcgs pointers that the stored objs
> + *			belong to. Overlayed on top of page->memcg_data, and
> + *			will always have first bit set if it is a valid pointer.
>   *
>   * This struct overlays struct page for now. Do not modify without a good
> - * understanding of the issues. In particular, do not expand into the overlap
> - * with memcg_data.
> + * understanding of the issues.
>   *
>   * Page flags used:
>   * * PG_private identifies the first component page.
> @@ -47,6 +49,9 @@ struct zpdesc {
>  	 */
>  	unsigned int first_obj_offset;
>  	atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +	unsigned long objcgs;

Why not just strore struct obj_cgroup ** instead of unsigned long? You will not
need to do conversions when storing or accessing. 

