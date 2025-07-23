Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFCD279DDF
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269887; cv=none; b=tYCRjSzLettZtk3OVEDhdzmWbU1fakhf+UAQWjXnsEQRJNqAYZaKm0qf4zHVQuZ+XzAmojA2KV96kmx3I+vupCe2gihU8kdkGRlh1v6t+o0g9DWZ6ioCSYfz4ehs+cgKZbV5ifnIexroLdWGFI2oVGnFJYubYG/q0BK2ZFShRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269887; c=relaxed/simple;
	bh=ltbN6s7Tmo2BYFYRumKAtVqby7x25UOvdcAzEdEvrrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pleKt4YTo2qnvDzu+/9yxsRoFCcuzB7De9I1hrYqecwas4eVGWOW8fGd5xuLJmBciu4XJTYI0w8wnZkNOJ8P+sMxffwwYOfDYYDXSOFOU9BnkmwFS4+8wItRKWNgnW/TNURQEke3gZxAYXertUXOoz1YH9qJzBbVbqhw+P88nzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeUisogG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeUisogG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B176C4CEF5;
	Wed, 23 Jul 2025 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753269887;
	bh=ltbN6s7Tmo2BYFYRumKAtVqby7x25UOvdcAzEdEvrrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeUisogGCFbSpgwfIcb9F6sTAopnZ357HCljwKM9e0BtZ4vqBunvi95gVakKGr4tV
	 vdJXdiEYPAy5Kw1k2iTcN0fayB49+LBlvgsR/2m16HcBOTGj0/dVfJx2SZ0tyR9b0/
	 msNIDVNV3Z/ac+DHDORktiukq2ER6mYXD1Gf29P4hwDx2xZIpxjuVVbbCHoMv7eF5G
	 c5yoGJS4yq/94dlsfRJbpPPC538FUaNR7sZYU5Hf4PJyRKmGg96SfmbWkEW4eWwnnc
	 A77Ef9aMQj1/H05/d2ZoxLGA5/5GAz1tqij1VZQFLf/FmIjhyUJJVKxOo6hznXnyS4
	 pXpmNjw0RUXPw==
Date: Wed, 23 Jul 2025 19:24:40 +0800
From: Coly Li <colyli@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kent Overstreet <koverstreet@google.com>
Subject: Re: [PATCH 3/5] bcache, tracing: Do not truncate orig_sector
Message-ID: <6qwngbewg6exkavqy764j2mfjaqgb3gu2ijh4urhz3ailxmmv4@slhnftlxhwhe>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715165249.1024639-4-bvanassche@acm.org>

On Tue, Jul 15, 2025 at 09:52:37AM +0800, Bart Van Assche wrote:
> Change the type of orig_sector from dev_t (unsigned int) into sector_t (u64)
> to prevent truncation of orig_sector by the tracing code.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Fixes: cafe56359144 ("bcache: A block layer cache")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Coly Li <colyli@kernel.org>

Thanks.

Coly Li

> ---
>  include/trace/events/bcache.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
> index 899fdacf57b9..d0eee403dc15 100644
> --- a/include/trace/events/bcache.h
> +++ b/include/trace/events/bcache.h
> @@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(bcache_request,
>  		__field(unsigned int,	orig_major		)
>  		__field(unsigned int,	orig_minor		)
>  		__field(sector_t,	sector			)
> -		__field(dev_t,		orig_sector		)
> +		__field(sector_t,	orig_sector		)
>  		__field(unsigned int,	nr_sector		)
>  		__array(char,		rwbs,	6		)
>  	),
> 
