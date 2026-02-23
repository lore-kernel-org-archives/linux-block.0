Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0E29A1
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857929; cv=none; b=G44BvliGauTdgFpJ0p4Y4SZl8D3tyU74Gh+kfAnG4KL97JgvVBKHCs4uBJ4pc2m+/AkRKDfbCK0DVMWMICt7iO3D8skVwdI+yZst/fjy4wkRE9HJfErVlR0ONB10FQ3NqC5C5BiO2IN5k0hHmmD1h2p/B0Ac8EVESNhmDrvVhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857929; c=relaxed/simple;
	bh=HDYcZUSPWzr4EyxlcAcF2TO+c/EsDVGTlJ/4XVu9bKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpZxjOTnxAZcMyjAfEiCrwDCyDBpl5tq2so4Fi0PrtH0g+Z8Zgvka9tqhXrBi/lq5Xw6ni+oUeozvcpJRCrY5zOlrhC/DfCuhSyGe6uQKDDXAuQMAdPTIcSfAaUBMjDQwXI2Diqaq3Z4Q7VdVIgz5MqKtHd7I6WWfppc5pLHCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gvPA+MB/; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gvPA+MB/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771857916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrdY52taT3U/NZQPuGXBlMxO3l3XijeN4kwKfbf/UaA=;
	b=gvPA+MB/3rPZe3/+/xAdy7rLGGsuixZx+6Lg/SFcdvj7Pne2gcTVBzuqWYk6/eSywKtBCg
	/+sZ+33MMW3OoWIFucMMZgXUSMYkPwnWDirsMg0jvpEzROz4AOTFePeJ+p4rAiMfDKgcVO
	5d9tzkSlI2GvoE75tBd7urtM5+ANWj4=
From: Usama Arif <usama.arif@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH v1 01/11] relay: zero page->private when freeing pages
Date: Mon, 23 Feb 2026 06:45:06 -0800
Message-ID: <20260223144507.3065618-1-usama.arif@linux.dev>
In-Reply-To: <20260223032641.1859381-2-ziy@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 22 Feb 2026 22:26:31 -0500 Zi Yan <ziy@nvidia.com> wrote:

> This prepares for upcoming page->private checks in page freeing path.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Yushan Zhou <katrinzhou@tencent.com>
> Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> ---
>  kernel/relay.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 5c665b729132..d16f9966817f 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -131,8 +131,10 @@ static void *relay_alloc_buf(struct rchan_buf *buf, size_t *size)
>  	return mem;
>  
>  depopulate:
> -	for (j = 0; j < i; j++)
> +	for (j = 0; j < i; j++) {
> +		set_page_private(buf->page_array[i], 0);

Hi Zi,

Should the index into page_array be j and not i over here?

>  		__free_page(buf->page_array[j]);
> +	}
>  	relay_free_page_array(buf->page_array);
>  	return NULL;
>  }
> @@ -196,8 +198,10 @@ static void relay_destroy_buf(struct rchan_buf *buf)
>  
>  	if (likely(buf->start)) {
>  		vunmap(buf->start);
> -		for (i = 0; i < buf->page_count; i++)
> +		for (i = 0; i < buf->page_count; i++) {
> +			set_page_private(buf->page_array[i], 0);
>  			__free_page(buf->page_array[i]);
> +		}
>  		relay_free_page_array(buf->page_array);
>  	}
>  	*per_cpu_ptr(chan->buf, buf->cpu) = NULL;
> -- 
> 2.51.0
> 
> 
