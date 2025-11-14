Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAE239E7E
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089695; cv=none; b=akdLe+1FinqoRpd5B5+rB/r0OQKuN/u6aq9Go93WEywe0/guCxjCqT7TLQNyLrPbw4wnRwcP17bGFx7bwPPbswhp7ftFLODaoE1VS0UBb6UVMrH5W0RMr0Ux9im6nbv1tVyZ3JJKvBOV9p2E9A4/fr15y6P3WuFqiTqYYe3e5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089695; c=relaxed/simple;
	bh=7FZl7eElwQMx4f8NPRo32crCaO9/CGfGbqfm7oXz0ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1dixWNFCq5+14hu5H67oRs7FYavFi1BmJbV6lwM8qz4935E4xULs7/dKhBDvFBzIb3aYlv/B77Yu3f5xmccZd9EM+uIXks9PEBm4fYSQVNAaoSQK4lwAXabe7q1jtxCrmM2YuPqFihEnGOloxufzyFEHKfS1shIdqvL6v94DiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W6zvfygf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6zvfygf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298039e00c2so18691525ad.3
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 19:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763089693; x=1763694493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIB9sVFAZ4r1CL2qSAT2AmYZKBmONBzhrUY9z+AGXrs=;
        b=W6zvfygf2NGYMxDbdF3c9C/DjyyBfUNqKZidIOwKxpHp6BCOjG5kEOvSzSLxW+bHwh
         lAt0bvpGbUuDvRSKRxBeGQOefoUT52Krvoh2D/7Jntn/Nrcgcfj0yhvlt8EMwEzPb/SI
         nfHJBBCbe+EoYypIScti90B91oCuLuWsol/MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089693; x=1763694493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIB9sVFAZ4r1CL2qSAT2AmYZKBmONBzhrUY9z+AGXrs=;
        b=Y+JncoHBsbEnpUH6LjsRX0WiFS8ysurDUhLym80Q5aHG972iYCbCUfnnWbttz79TDo
         Tz4kkpWR5K/fcb0n5BOtYFuZtdDRg+zH2IgQ1X0uEZJpn4dTvqqSQed8K73wdvaRBJWv
         PqoHIQC5n5I20b3siQaHRy8Pk22CJ1e/PB4PB1XfmNl//xZpJneW1yia/0kTFzaXJfQJ
         jvWZMucH5srOAHa8zemfgo8YaT0AdpRec+kwpQgDJ7QT4/EFxfwvXRezKkqZ1AspLZtY
         DQYXir07hX5X1uaCzGmJWxD0aJ3P0rzE+29p5FZbb90myaGuaSlX1SOppHpEpoXsAo+D
         kOwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0FvHJN3XyCX4T9+qPUzs5qgAHGfLvX6BKvFMzvVdBaqjK+WtcEACk0AXtXrakFXXu5Un2cHPMRxOpiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbe9RRT/S8dSY09ZywrYoD+3Syvi39W2PX+b0lNQoLpo0cUvJz
	ju1XBPVIk4vMWwx1q2f+ut3iTfThjTkYH0+yBy8IYQ6gRJLv1HfLIG0MQqNJsJWmEg==
X-Gm-Gg: ASbGncsLHiwk/OYv39McwLvuI/NAPoY/1tXOE7WEUAqS843PDi5WxB4GKAQxGxG+Ju6
	Q+S+gbTHH+P2NMJbgN6KpAEb5H0MjRVWkaYsZrKy4L/gNG2qa85IBShTQnBb6zVoIRleZZ8PsrN
	lAKJbJoMzJvi8u1elMLA/H/OoNXNBd58ruKdiBpHBwqWX4wt+4JhPXIy/8OihwQYQ2ME7qaDnEp
	v4k+YEXazN5ggJmP/NlcOMjeVfS/JJ172MaXiq+YnHNJ1RxidtTrd3xU71AIESU9DdnVi0kpWhh
	wfbOxqexNOqQGfwWZdIqs35q4B6lXCsxuOVl/V4nK5qJldXQNtsbTmEY+7F3eH3IE/A1bgWVUnh
	EDbgC2pTAe6c5EshfGXHApMxM4N/bJ+VrbLiV5+vv4e95eMSrWzR19HF7aH0sGzTi+i5d1tw6ly
	+/qHVcuGlvLNB/whCtxvJ2+wku
X-Google-Smtp-Source: AGHT+IHh41/ZcRo9qIekYBD3OLGDCWUcF227dtgzH8Svbd49yvbPTWE1o1kN6DltieX08rnQbG5c8Q==
X-Received: by 2002:a17:902:e548:b0:294:fb21:ae07 with SMTP id d9443c01a7336-2986a6d692dmr15139705ad.21.1763089693528;
        Thu, 13 Nov 2025 19:08:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8e2:bf91:1dd0:a9c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf0d8sm39740115ad.85.2025.11.13.19.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:08:13 -0800 (PST)
Date: Fri, 14 Nov 2025 12:08:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 1/4] zram: introduce writeback bio batching support
Message-ID: <uzmauds6u53bauvwcycu4uphsrb4fg7rvm2b5x6uqyukqq4wwp@vhugu2qv3uaa>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
 <20251113085402.1811522-2-senozhatsky@chromium.org>
 <aRZttTsRG1cZoovl@google.com>
 <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>

On (25/11/14 10:53), Sergey Senozhatsky wrote:
> [..]
> > > +struct zram_wb_req {
> > > +	unsigned long blk_idx;
> > > +	struct page *page;
> > >  	struct zram_pp_slot *pps;
> > >  	struct bio_vec bio_vec;
> > >  	struct bio bio;
> > > -	int ret = 0, err;
> > > +
> > > +	struct list_head entry;
> > > +};
> > 
> > How about moving structure definition to the upper part of the C file?
> > Not only readability to put together data types but also better diff
> > for reviewer to know what we changed in this patch.
> 
> This still needs to be under #ifdef CONFIG_ZRAM_WRITEBACK so readability
> is not significantly better.  Do you still prefer moving it up?

My intention was to keep structs definitions together with the static
functions that use them (which are under big #ifdef CONFIG_ZRAM_WRITEBACK
block).  So that CONFIG_ZRAM_WRITEBACK parts stay in one place and are not
scattered across the file.
