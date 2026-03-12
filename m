Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E035F16A
	for <linux-block@vger.kernel.org>; Thu, 12 Mar 2026 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284712; cv=none; b=Q9jVx0jdv8Vk2XCySf3ErTDt9eOyLT0TJMKZ+4ieJff250oQXq6A1iF9SJ8FJX6ieQVHfMVmvawoKlBXyNL7S3aJPJ7qnzv9Qy638svXEJ2zxu4uceQhyaiE6NKwBJXQA9+Mt5sFj/pfpUx8/15OPuOolil6ydPvjfgPkqxVfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284712; c=relaxed/simple;
	bh=dGFz8514oramdsBkwTcwYD/hiDqRmCZrlC34M6uwzuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWR272LBXhNV8ynXot+g2bwXE4RGLpv1ih22CUWxjFjn9DRWBxa8DCXzfV7M1yShklZGZR/1pLTlN+Afhk5wLUc+IhYFqEOW2yUuIE83+ctc3s2r+9y66yw7lHi7UsmRGTH1JnjLWnLCXRff18/1x9TXCEmoPh2N0Rcnn1HENSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OR6eQYQR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OR6eQYQR"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a02ed9cbaso270661a91.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773284710; x=1773889510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVafNQGOmqCBcaIXAXRVtsYI4i0x2w5zQE36DJ2wfDU=;
        b=OR6eQYQRYXab6yY3BMm65DqWXgFqNmwFKx/uzescs5IblwOvz/wj6kSR9gIY4OyTE0
         /XvffHMDk9cYtNM3YNiJuJ83vTQEHDVHblvvHUtuIavr1D/B+awxUDFYkklnB0cCKEWh
         QaVmlHLYk0cKGrOoLDiTSdhacBfBSO7rfmmE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773284710; x=1773889510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVafNQGOmqCBcaIXAXRVtsYI4i0x2w5zQE36DJ2wfDU=;
        b=fNvbfGCjEARA/yPgPe3RJC84sGO7mjGuwuAI0DVoN3smVXkwsYNPpssuRsmYcWvfAS
         81ylQyNO3h6zrnBDKw4u+g3O4Uoia3xpioVJLOJQdIBwqDY4t5YwtPvueYBnDe2B5sw/
         XGhssPyBeE5tI/mhvWp/Nh9RdNGqfmtA+jzZQhI9DR0pXaZ0ReU8AwSHWFadi7Tov8kr
         CDNypBlnfaueMc0GiHWSUcW+3YT2HZEugFOFJkhVlDFbgnQQ1+HWGdoPxttmTMrDUp5g
         /zLqq4Oa+mUB+swhoAjAua7d1PA5mFE4UrZwBAbofwdsyyIYSjDysnGPAsHrJxqgUyYj
         dehA==
X-Forwarded-Encrypted: i=1; AJvYcCUE09B5BV/lRyPVVvML9zw7gBr4tGJ9h52s/Q0XCblzlIfj7f4ro73fWD98lcyXEOWkQrEsFrpmpX/mRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6G9y82MUYYUBqjbwpQjsMMwSoZzTyIXtDnMTGPRAC8qYcPlLp
	HFWIxzBq3ZxJQXwMwAqndwBhM8LTqxb267VIy17XhuiOFuckCWi38m6VmsJcGvzYrw==
X-Gm-Gg: ATEYQzxZGtHsTbqLO1nmLZMhMJVWpDUE2i/DyQwyFTGH7NDx8fNS0+XZPgTGs8Jh82G
	H6V/FnU1DfdNxd61BEOMBruYAUwt1NpsSwzXSl9M2GnXaBqZ7P70yiVGcPvD5IWmrMZ3asSbJNG
	ucdwA7eCkIGpZAxfkn2emSf29OyqSXUyYTvUogJ9Pa9BYcDgZgy3y3syCjrI6xxs/G00/kN9Gke
	yyNWiIVKFSr/8IMnXHJo+Glwv4PQNmLTWffJEx0SfbscU2uYG0/9HHR/uKkAGscEnYFUJuXbjrX
	DnKCPvFKdQc6KMdQBcmI8LK0MFneUo05HLK5EiIVMUd0+Cw2EjhPzCdmfmZ/agWLQp0uOq4NuNR
	b3I8K61O14giGlzDnJp6DuF/MUJL9NZ1qj0klNY7jAEg1OZTXnwR/VGqH0lr048BkvHFsckb1ap
	mJpZzFMCa6L6RRqrrq8Zgf0jmIe1N90a+euqSZgsq8yik7+IixyUvKFIxp7DnWSDQ=
X-Received: by 2002:a17:90b:1d92:b0:359:ff9f:916a with SMTP id 98e67ed59e1d1-35a11a06aeemr1634661a91.8.1773284710478;
        Wed, 11 Mar 2026 20:05:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8bb8:36d7:daf6:bf85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc8465sm3647444a91.9.2026.03.11.20.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 20:05:09 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:05:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <abIsoZHvJExS6A3b@google.com>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303115358.1323188-1-matt@readmodwrite.com>

On (26/03/03 11:53), Matt Fleming wrote:
> What about mixed swap configurations (zram + disk)?
> 
>   When at least one disk-backed swap device is active,
>   swap_all_ram_backed is false and the current behaviour is preserved.
>   Per-device reclaimable accounting is possible but it's a much larger
>   change, and mixed zram+disk configurations are uncommon in practice
>   AFAIK.

There are also setups where zram is configured with a backing device
(a real physical device) to which zram writeback pages, effectively
releasing pool memory that they occupied.
