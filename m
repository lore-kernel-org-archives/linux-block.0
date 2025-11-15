Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC961FFE
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173565; cv=none; b=XcARoEFsiGqICfNOmVriG4elIh9HQp5Hd9YujgndrctkcKQwgATOTSVwbON0ZwZ/P+2OsBOjxvO0XnrfbGkyJ0LwrZk2xT7glGyyxXRaNSXsO71VEFt9CHJAAq31fJcwm8dvMm1aYgDI6YN5oT37jMxJ4LGzT7HtfI4OHRfUjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173565; c=relaxed/simple;
	bh=EfIbv215Kt4SY1TIo+8uK6qOfxJKFjYXTEd+gVNH8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgwZnvCYiWLZY3q9Q0fALMfeQSdt3qUN+GXNjbVngixU2So+eEu+bRIPDnbgzwpFgJA0ePTzps3eSXx2cEjUnty7qua1haPXSPjAXBQFCevN7gPl4gCDX93ifnaCdJ5YhTDRAdR9K1skNVFWqMC+NDkTM7/vGRo/HvLJ1pSyU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a4MgE4Jb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4MgE4Jb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297f35be2ffso38318875ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763173561; x=1763778361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvIo+2FZ6EfZjFDRwQfsjxC3rzbK6C8gqJLE1Fnuis8=;
        b=a4MgE4Jbh5hKevYmxcbCFhHUZVmsBGHttHIkxHmpAQJoI5slss2q/zato5d0iBoHJ1
         9Rxehve7iDV3mSBXnV0t1QHQCBg1nNaH92/2sfocBvR2OLF5xOLafzRSvp0fyliP3mSh
         F+4T3R1esx3ESCzcYBOIWU381F3y9Fqjw2oTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173561; x=1763778361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvIo+2FZ6EfZjFDRwQfsjxC3rzbK6C8gqJLE1Fnuis8=;
        b=vxgJ/OVSi50BQZTP4tJ+IWr3pLPVQlrk6kYSqWeoirUULLtH1IPfofRRvh07YtMl0N
         nI8Mxpu01boTb+e1kQtyhw8Fe+zjtn15h+8LKKBIwCrgFSFqJPEkIE7iT3Rdsm+40+Uo
         qYLbQB+yTDvnh4UvoRCL+McqO/CTmiJP04aWg2JViy5a8jYbU2UQ41XRop7fDjf7KfiD
         aU7Mk22FZpbSAkYXhSPWwjFMNZk1Zst+opFkuaDAxGR4f7P+J7MFAkfeQ5uY28FFxI+w
         4syFn1aNR+PNPQo7RR45PfqxGAksfayOaQgrY19BPV6JzdG8TDR40IuZaprzG/9rYiob
         5bBg==
X-Forwarded-Encrypted: i=1; AJvYcCVOT9pNMGRd8mHVztiFMCu9+rpFKWw8vziYCIkS/uI38wxOWZ7gQY0Jz7eRySn3dk3DXnnKgdGCwmiezw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCR8MIsZjt/L0pZik4Rgtre7NKcRU6Tb62Arf71IAtePLYXMVS
	A+TxNWlXkNeoi3vw6gka0g0qzRkDoKanhJh6GoQGOrNkt6EFMDvHfHq24njRYWLfTQ==
X-Gm-Gg: ASbGnctOFqZHCcGZgtY2hrafcujHnecQkMeego50P04VUc7nBjXKl1qi9p6G44Fq9Q9
	46vINST2Dll8iAkoSisFkTJbz7kX2/8CGYRqWMNTx4dUOKsMSMwbL/A6e1geLCHEmLrZJ2AEuZ+
	butS/ce/BV8fW5acfabJm6AeXu4w98X8eVmihK07E3/4PddkvEtGdOlcIYp+7QAhuAunfI3TVi2
	UmNWvfAbm9yROAkiaEm5MycLXO5YsbcWHXIep96dlHgLBVSnRkMaNhl7ebLcG50NiNdFLXOoSVP
	RQ4qdqKvxmoWTBJ1kUeEhJCoV6dk7D+XUi7fnq3T+GcPrmrxJL81/dWWBSNFIc/P/5nzWufuGBk
	9W7W3JhPTqtsTt9+s07ilfbS5yXtevLBFdXMTSj3G6EYKTuyFlTAhF8EBj8DuNJDjVQw0GObSYx
	9n/PpCwXUoqWVYSA==
X-Google-Smtp-Source: AGHT+IErNbdNIWz3yRgr2AVKBX9ONMzdwgKUAcvQOJAS+HeDR5jF0B3ToxhaPZ0vVdrGWcO8Z2zZRA==
X-Received: by 2002:a17:902:fc86:b0:295:f1f:65f with SMTP id d9443c01a7336-2986a7414c9mr50925375ad.31.1763173561010;
        Fri, 14 Nov 2025 18:26:01 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8e2:bf91:1dd0:a9c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245e04sm68472305ad.38.2025.11.14.18.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:26:00 -0800 (PST)
Date: Sat, 15 Nov 2025 11:25:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 1/4] zram: introduce writeback bio batching support
Message-ID: <rgbcwa6rcfxpyf75k6voinza7ba2fnsht45kb6ittv4qrbrmyb@i25srryjss3i>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
 <20251113085402.1811522-2-senozhatsky@chromium.org>
 <aRZttTsRG1cZoovl@google.com>
 <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>
 <aRd_m00a6AcVtDh0@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRd_m00a6AcVtDh0@google.com>

On (25/11/14 11:14), Minchan Kim wrote:
> > > How about moving structure definition to the upper part of the C file?
> > > Not only readability to put together data types but also better diff
> > > for reviewer to know what we changed in this patch.
> > 
> > This still needs to be under #ifdef CONFIG_ZRAM_WRITEBACK so readability
> > is not significantly better.  Do you still prefer moving it up?
> 
> Let's move them on top of ifdef CONFIG_ZRAM_WRITEBACK, then.
> IOW, above of writeback_limit_enable_store.

Done.

> > > How about 32 since it's general queue depth for modern storage?
> > 
> > So this is tricky.  I don't know what number is a good default for
> > all, given the variety of devices out there, variety of specs and
> > hardware, on both sides of price range.  I don't know if 32 is safe
> > wrt to performance/throughput (I may be wrong and 32 is safe for
> > everyone).  On the other hand, 1 was our baseline for ages, so I
> > wanted to minimize the risks and just keep the baseline behavior.
> > 
> > Do you still prefer 32 as default?  (here and in the next patch)
> 
> Yes, we couldn't get the perfect number everyone would be happpy
> since we don't know their configuration but the value is the
> typical UFS 3.1(even, it's little old sice UFS has higher queue depth)'s
> queue depth. More good thing with the 32 is aligned with SWAP_CLUSTER_MAX
> which is the unit of batching in the traditional split LRU reclaim.
> 
> Assuming we don't encounter any significant regressions, I'd like to
> move forward with a queue depth of 32 so that all users can benefit from
> this speedup.

Done.

> > So we do this for post-processing, which allocates a bunch of memory
> > for post-processing (not only requests lists with physical pages, but
> > also candidate slots buckets).  The thing is that post-processing can
> > be called under memory pressure and we don't really want to block and
> > reclaim memory from the path that is called to relive memory pressure
> > (by doing writeback or recompression).
> 
> Sorry, I didn't understand what's the post-processing means.
> 
> First, this writeback_store path is not critical path. Typical usecase
> is trigger the writeback store on system idle time to save zram memory.
> 
> Second, If you used the flag to relieve memory pressure, that's not
> the right flag. GFP_NOIO aimed to prevent deadlock with IO context
> but the writeback_store is just process context so no reason to use
> the GFP_NOIO. (If we really want to releieve memory presure, we
> should use __GFP_NORETRY with ~__GFP_RECLAIM but I doubt)

Done.

I wouldn't necessarily call it "wrong", we do re-enter zram
	
	user-space wb > zram writeback -> reclaim IO -> zram write page

it's not deadlock-ish, for sure, but still looked to me important enough
to avoid, so that writeback would be more robust and make faster forward
progress (by actually saving memory) in various situations, including
possible memory pressure.  Changed in v3.

> > > I didn't think about much about this that we really need to be
> > > accurate like this. Maybe, next time after coffee.
> > 
> > Sorry, not sure I understand this comment.
> 
> I meant I didn't took close look the part, yet. :)

Ah, I see :)
