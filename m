Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF1397691
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566679; cv=none; b=qW1unz1of5UzXbfoerJ8hTJkbYf9Pq81aRlsWDcLzNY1TthVdLa4NzKbVCIIyGhyFFug4guh658g2/TzNGa+wHwwJWBfm7ogCx+HHzpQ7B53lBZ8VOObW9OsDHy9MPcPnRTzICFQB8bEmsb5pmE5h8pNdmCEqMG4bGCT6uZhHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566679; c=relaxed/simple;
	bh=r07I1320FVffZUlAdSYrMpSdkuwDFwPlbxMaqOaCKJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl0xk6qAYeHOtr8fpAevWPqvSHPnXaQK/LpV3Oh666R7+lGnvQo+oJpzp3Ie+oYFlmh8ZA7phd8Inzh44UBzVOXZXzacvSg4xYnj0VwPLxyFOlG2l//GpEd/QpxmIdJLRFxvrxuQfs7w/lCgGqVtHw/AdS6YyDdwApCKjO/omnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=c119dpAp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="c119dpAp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43991064db8so6214916f8f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1772566676; x=1773171476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLA6/lNbnNrbFzoCMsv7/3TnmIMI00PpH+C/qr7USIU=;
        b=c119dpApB2/u/tQyzKD2eCGFhkWJq0gyVmvpurs8RRSy7g9iZxnRHUXcbaxNuv8yDn
         Ma4kgVWh/g72DsBC81uvWNP812DsMhZxJD2FlTZie1YfceFVP4/QsqkePxbNkZ+lK4Qi
         uygSdQ6lptN51nID2tSZIaoBGEpWIlUZizmAs5cC/UVAge4MnwPClZj4HMK8k/w8c/qh
         na9KhKkIgA1947LsxooTwj2qI6u0/aHaBkkVSv4xHkAYow1CmpmcjZ8giG1IBMkSm3G8
         1KRHikQW7fpKb85rh96A3xsg0QCsDen+7dbDnfAWyrPQKt/1sQhskA4AxeKFqMdpUKak
         k+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566676; x=1773171476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLA6/lNbnNrbFzoCMsv7/3TnmIMI00PpH+C/qr7USIU=;
        b=O6ZksGqk08g3MYRtYsdj/xbVVjjs7wKkYA0VLnTTQSpHRjjAwsTKWbCvUq8s5ITqYc
         iHVpny37byGONbOBgKMfbqfWCa2/y5MEipSdLRtiisV3ZDNjHZwTdAgoxiuUd7CTb5Xh
         yu3fXceEfuuFnAOzY+lx/HiNfbGttHrLjCyBu223MMCnSUPKl8T/Jly7lqzzD0MGOxH2
         jbYe7hEqK6QWWTiywETWNQa2ShhSo4x3Tzv51FBepubniUIQDFmOSwph5AfDcTZqJrGT
         nDWawoaTEBbjI1124XL+1mN2mxbUoIWRSFgWn0EBPNtpXpbOeOjFKuwlmBZ4krazAvZ0
         WYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxeOckMqnfId/z+k0vfuDkVbn+N/f4nwG8tF8K7akTg09WNT3bvVm1BThppFem9CWvbHZYOQafgEZ+ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9gZ2Wyn5l3J94WlFdC4ZnAiWcyCOd/5Abgk9NNIznZiEaTBN
	ftcNZVxniPB1kgoGoqeL+Xb2JNNgEfk6hydkLBeCpeSlfGpGEFt7rtJhfz8m4+ACOVc=
X-Gm-Gg: ATEYQzxVW9zAX1PQ+UNMjHQGcXk6nMncnFA9rxY/lFLnVPDk8NfY6xuWB6nuv1Mblu8
	BPAGWFNLVvso7C/jL1f8RqLVsDTXCjv+AEBO+X/ELj9pDBrMofrDdgGWi5emThQACZVRbGfaqHE
	im4sBV8mUo1xyINAWhNbxtqQYLQM6ZGc3JEtz/shphvMUiMDX5fE6WvXHEoqGNY/S+nOuZt1Zu0
	f5LLNPJ0xOtPW+65IxB311X9oGgbumoOd6L5/futqjlCU/GvElyMu2XYWGksH0BQSa6kkJ/4R1n
	CUOg1oZFtdsj/jxFivlhneaR6P/E30RM5Y2ygLnwysiUgCotNtSxTuIK09wR+NSm+pftYLkepY8
	3Ut50MFhozJdqP2/eX5Tj0GZxeJcfh+bNhqnWu2oS8SEMWUfy92GAq6I9nWZke6Q107sxP/LQvq
	0x6oJ5yho=
X-Received: by 2002:a5d:4b48:0:b0:439:c1b7:890d with SMTP id ffacd0b85a97d-439c1b7933dmr3930809f8f.26.1772566675967;
        Tue, 03 Mar 2026 11:37:55 -0800 (PST)
Received: from localhost ([2a09:bac1:2880:f0::3df:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm13526574f8f.33.2026.03.03.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 11:37:55 -0800 (PST)
Date: Tue, 3 Mar 2026 19:37:54 +0000
From: Matt Fleming <matt@readmodwrite.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
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
Message-ID: <mmlwwn5dgwzcg6svb7t6torq4py663fgqceea2t4y4ktiep2ch@qm2zw2k5njoh>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
 <aab0AFAgAzBi4jO6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab0AFAgAzBi4jO6@linux.dev>

On Tue, Mar 03, 2026 at 06:59:04AM -0800, Shakeel Butt wrote:
> Hi Matt,
> 
> Thanks for the report and one request I have is to avoid cover letter for a
> single patch to avoid partitioning the discussion.
 
Noted.

> Have you tried zswap and if you see similar issues with zswap?
 
Yes, we've started experimenting with zswap but that's still in
progress.

> Over the time we (kernel MM community) have implicitly decided to keep the
> kernel oom-killer very conservative as adding more heuristics in the reclaim/oom
> path makes the kernel more unreliable and punt the aggressiveness of oom-killing
> to the userspace as a policy. All major Linux deployments have started using
> userspace oom-killers like systemd-oomd, Android's LMKD, fb-oomd or some
> internal alternatives. That provides more flexibility to define the
> aggressiveness of oom-killing based on your business needs.
> 
> Though userspace oom-killers are prone to reliability issues (oom-killer getting
> stuck in reclaim or not getting enough CPU), so we (Roman) are working on adding
> support for BPF based oom-killer where wen think we can do oom policies more
> reliably.
> 
> Anyways, I am wondering if you have tried systemd-oomd or some userspace
> alternative. If you are interested in BPF oom-killer, we can help with that as
> well.

oomd is also being discussed but so far we haven't experimented with it
yet.

What's the status of BPF oom-killer: is this the latest?

  https://lore.kernel.org/all/20260127024421.494929-1-roman.gushchin@linux.dev/

Thanks,
Matt
