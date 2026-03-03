Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B951390206
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578081; cv=none; b=DSokgXGOm5dD3vBM1RoIeOmYnd9ss/4Hio1Y0XJS/TGeWrJbq2MSQS4TQeqPQ4h/Z/O+fSCacB39AWVxrWVTX8e5X55TXRJEz8a2bZKSI/9wA6N2UnK2qHu5T7fMwdrR56QQaQ64fS0fsACDeBzlo7sPcavm6SkkPmiLQsk52uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578081; c=relaxed/simple;
	bh=ICZIz7yhJOHKhJyTBDJc1zOquwlbCKbIXlhXr1pWiVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg6HylOPvPAKsQIYR/kqr6Umyg0V1sRHJnSyD5NemkgBGSAVOtWUSCgOcGTGSCrgK6nGmJBCcLwBg1ZD4yw2AC7BvT1Y72SvY56cvEd4x9TrPv42ppoyc0A7QV1gdN3HqicghBUV6sQFyPqZV0x8Hnni+OG69OBqSspweQTBL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EVq7jMda; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EVq7jMda"
Date: Tue, 3 Mar 2026 14:47:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772578066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKkcFIW0rZcSJrQSa7i3+w3BkUEejorX4Hk2Yq5/aOg=;
	b=EVq7jMdaPB3N4r5uSZRYVIPkomqpvsSxY2BUZ6LiuO2tjTYzIX7DuN/l9d/d9LTKNzPfw+
	AKH+o5wincI51CR5s72Vn5GloyOkWyItpVWsQuSU7ctXGKmMF8Tk4JTIG5zqAaTg4aXaW4
	2NuYaMixy112qoj2uMHs9azQ618/pLI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, roman.gushchin@linux.dev
Subject: Re: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <aadk2GKKMpMqvFWo@linux.dev>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
 <aab0AFAgAzBi4jO6@linux.dev>
 <mmlwwn5dgwzcg6svb7t6torq4py663fgqceea2t4y4ktiep2ch@qm2zw2k5njoh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mmlwwn5dgwzcg6svb7t6torq4py663fgqceea2t4y4ktiep2ch@qm2zw2k5njoh>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 03, 2026 at 07:37:54PM +0000, Matt Fleming wrote:
> On Tue, Mar 03, 2026 at 06:59:04AM -0800, Shakeel Butt wrote:
> > Hi Matt,
> > 
> > Thanks for the report and one request I have is to avoid cover letter for a
> > single patch to avoid partitioning the discussion.
>  
> Noted.
> 
> > Have you tried zswap and if you see similar issues with zswap?
>  
> Yes, we've started experimenting with zswap but that's still in
> progress.
> 
> > Over the time we (kernel MM community) have implicitly decided to keep the
> > kernel oom-killer very conservative as adding more heuristics in the reclaim/oom
> > path makes the kernel more unreliable and punt the aggressiveness of oom-killing
> > to the userspace as a policy. All major Linux deployments have started using
> > userspace oom-killers like systemd-oomd, Android's LMKD, fb-oomd or some
> > internal alternatives. That provides more flexibility to define the
> > aggressiveness of oom-killing based on your business needs.
> > 
> > Though userspace oom-killers are prone to reliability issues (oom-killer getting
> > stuck in reclaim or not getting enough CPU), so we (Roman) are working on adding
> > support for BPF based oom-killer where wen think we can do oom policies more
> > reliably.
> > 
> > Anyways, I am wondering if you have tried systemd-oomd or some userspace
> > alternative. If you are interested in BPF oom-killer, we can help with that as
> > well.
> 
> oomd is also being discussed but so far we haven't experimented with it
> yet.
> 
> What's the status of BPF oom-killer: is this the latest?
> 
>   https://lore.kernel.org/all/20260127024421.494929-1-roman.gushchin@linux.dev/

Yes this is the latest and I think Roman is planning to send the next version
soon.
