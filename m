Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DC143C67;
	Thu, 13 Jun 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284385; cv=none; b=t+oAD3M7tmkkV7c2gZLDCtjDOesfHfm+vXD7aHayd4BK8NtAlGHJmRAiZgqDuRF5hZPAe/WxMWLFlT26ncob7lG/UzYrJLkEpsCkd/F+FvE9W0NLpWE6weFNlm3k6N/V0n6KD14WlrcIjePah6JFRW3K/yPZJIT2piMykQ+NMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284385; c=relaxed/simple;
	bh=kNVg6hB3W8Ii/Oj3Os+AjniHpIN6BBnVmAS6GNrz1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0Ot/XYyQSriOjnnvjj4EIXZpVgpmjOTLaYyjJSDlai/DmR9hfEVu1+cPAwYHhUvCFMHJyJAbUqagvldWWZ79fEgjcThng6AtLDT0eGcoiHp7XJ420Dj+jzOhOEygz8Ugp3428cN6UT6WaXQAyOLJh0wI+9+FTKoPSk4LPvoj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZk4d1co; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZk4d1co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927CC32786;
	Thu, 13 Jun 2024 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718284385;
	bh=kNVg6hB3W8Ii/Oj3Os+AjniHpIN6BBnVmAS6GNrz1BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZk4d1coZpAUddGWJ8gYqQ4YEdJ5gsepRTel61MxdLvcgw3qwxEEdIJHRdHmDr/9t
	 nugkWbCIIjPBu+brQIWXpO7KJZXFEwdJqmKEzpe9ef4dwODRyn2qFIU9Ts79G+5gRd
	 47YmWMIpaN/AiiyEnRyvzqIsyfzJ4YoeXJo3LXd9ddiw6iMLF8fsBK2y+aB0S5lUCI
	 0E4SxfZoTYZ/khfuLMiXfIuiQS0cKHoZp9SSIlARy+4xl5HNZqKqmhY74KM9oMUmUd
	 K77T+UYmn0YSRMiYkKFb5ObRzVWn640ZfTju3bpu9I0+8mkEVH8FK4VeioEzEb5zH/
	 +0kGe434Eqchg==
Date: Thu, 13 Jun 2024 20:58:55 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <ZmrtD5NsKcDkY4Ll@xhacker>
References: <20240613000422.1918-1-jszhang@kernel.org>
 <20240613031731.GB479513@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613031731.GB479513@google.com>

On Thu, Jun 13, 2024 at 12:17:31PM +0900, Sergey Senozhatsky wrote:
> On (24/06/13 08:04), Jisheng Zhang wrote:
> > commit 42e99bd975fd ("zram: optimize memory operations with
> > clear_page()/copy_page()") optimize page copy/clean operations, but
> > then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
> > aligned address") removes the optimization because there's memory
> > corruption at that time, the reason was well explained. But after
> > commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
> > alloc_page() instead of kmalloc to allocate a page, so we can bring
> > back the optimization.
> > 
> > commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
> > back partial optimization, missed one point in zram_write_page().
> > optimize the full page copying in zram_write_page() with copy_page()
> 
> Is copy_page() really more optimal than memcpy(PAGE_SIZE)?

I think yes copy_page performs better than memcpy(PAGE_SIZE)
commit afb2d666d025 ("zsmalloc: use copy_page for full page copy")
also shows the result.
