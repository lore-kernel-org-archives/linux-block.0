Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1F36A038;
	Tue, 10 Feb 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733782; cv=none; b=rWuvcqum7Pj/gblkjl/7JNu6aOvy9tCl8XnEH7ZetWdW/clpe95jv8R5jQ/J7hQMNNdSQl29VHqYEhZopa6pWsQEWo2DVCQpcPdQSVlAv/zj7yFrRM9fJ0tMqVMfxsR61EsNjCt3sCaQcU9sWjxTRVuE20O6ss8LfpfxEkk0X4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733782; c=relaxed/simple;
	bh=734kScvBfFU3ME4eg77YKkJQ1tBcwDXlvijLfqxaYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8xEWwOvY6W2FXvIY3qbWv3vrvv4d9pUAbiW+R/Z6ejf/hksp358rnL5eI4cQgKG/z2JV2xNFZzpq0FUvrUUWUxlkeR2BI++A8X1K8IOQEbLCeJs/3dp7DlDYcjcCF6i2FJGUieFz1ybH2yuwQN0Po5Zzg4Xy2/q0wJEhQaRAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ABQU0gsW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ABQU0gsW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2yc81MQpBN4LWvgjP4zjKZns2TrXMgn72vRhBrffrRU=; b=ABQU0gsWucQOYM1NYmYhrEcOtL
	nYh5o5CJNDQxvU6f3eozUhcyF/Mxpr1e01JCOmARJLxG31rFdEDmC9sM8ore2htijbGla8C1oRkjV
	B4desCpo+oT8SK0sS+wUMNLaE8CGXLuOIkMEN8/hMYdIJWeCUmImZLCjE0KYqKDNS1Gcydx0ZQhdb
	SsoqkOstE3CywIMrkIpWY0xpwkyGgex2sXRf2NvBNGEt3LyVKZQmknM/Im03HK+w0y47uwXV04EXF
	P/+FWDxMyIPHvHU46Ndv+uw8sMcZSyNcXsPqqQ/JUXelywMvV0CsRzk9Ok6nB4uvIyeNQz2iM4xR1
	6HG1NgIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpokB-0000000BCcP-3Zsl;
	Tue, 10 Feb 2026 14:29:35 +0000
Date: Tue, 10 Feb 2026 14:29:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	Richard Chang <richardycc@google.com>,
	David Stevens <stevensd@google.com>
Subject: Re: [PATCH] zram: drop slot trylock and miss_free
Message-ID: <aYtAz5vQTod7DXqV@casper.infradead.org>
References: <20260210035045.3817297-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210035045.3817297-1-senozhatsky@chromium.org>

On Tue, Feb 10, 2026 at 12:50:37PM +0900, Sergey Senozhatsky wrote:
> @@ -1943,15 +1927,9 @@ static ssize_t debug_stat_show(struct device *dev,
>  {
>  	int version = 1;
>  	struct zram *zram = dev_to_zram(dev);
> -	ssize_t ret;
>  
>  	guard(rwsem_read)(&zram->dev_lock);
> -	ret = sysfs_emit(buf,
> -			"version: %d\n0 %8llu\n",
> -			version,
> -			(u64)atomic64_read(&zram->stats.miss_free));
> -
> -	return ret;
> +	return sysfs_emit(buf, "version: %d\n0 0\n", version);
>  }

You don't need the dev_lock any more to just report the version.
And should the version be changed now that you've changed the format to
not include miss_free?

