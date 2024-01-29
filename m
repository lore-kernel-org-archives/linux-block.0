Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AC4F1F5
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568417; cv=none; b=YJpICsA1fU194Gn2RTPqA5J5E81prwpHsvpOzzmHoFiiBlDpRk4/du5G8CzDS4jGhdkuaNSWoNsZy0CdyuxSboxQrYajQUIZlIulNBJD3qDxjmXTykgCgv4nus2UXIgkSy1hH4MYHBKGbGFrWKsK5k2tGRlqCGXOOs0p6G8WN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568417; c=relaxed/simple;
	bh=z4i3/tfWy/FJa7/iha829M+16JqzAz4CEfvIfR+Zbvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlJzsrjzxV2phjCDcfJWlpUEhRxUYlhsIKvL3gpWpKgT/aK92/LKiv5RvxHVgNZatvPe4b2K9LAlR7LQBk9nZiSJrpo6+3kAdG4NzqgzlVEfQMC7WAAsAZE9Eg1HrYWJlSW0i4kHtMjCgQgEtCswhIKO4aoziRPjgyVlQDHr8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-429d7896d35so34317341cf.3
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568414; x=1707173214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y1TC6ozjJZpDR660NrUM2DmjgjZssr5RPk8k265VkY=;
        b=fLhB0J6NIyjedIrVFXNJ0xUblzEqFzrwu/E1l8GGWTODEtWzRpbhzXTdXZZ0VUsAs2
         OC1OqdDz0OHQjNDymFOyjU8cIYa23CdhKt1EP7kvGyUzMUkNFNfrbmZngzU8Yrag+weq
         YsFe8xyGDy9rnbl8IpwRO0yts8g9jP9sqj7ONxDiRvnsvcmj6pb9ppqbrFYiG0bqn8D7
         9wSAamw+7Pgj2kIUcFrjcccDlhKlskdfuLrdtC9cr/FyStPMkJpCKsJSwQw80yXis0GZ
         /Gu/+jWBLRoJycygRtEKk7JXGfIsJOIH7odoGanFt6FkCCnNUgO8gbq6cjf8k9YwISry
         Jspg==
X-Gm-Message-State: AOJu0YxBH/9K9IPDeF+XeAmGrFfT6IiQGVrX7sxJTbK8s1cHSyQK0GuJ
	B2KLfFV+5lz6L1ia7eR86bkf14s+LOeqKYEK95cicPnlLzfmFzu8H2doEdCP7A==
X-Google-Smtp-Source: AGHT+IE6sdw2UMPyjdmSHO2Q/aOZ/VKQc/wBLWuOWcfTwiePWMJWreri2G4nKR0FgOPeREPo2MLweQ==
X-Received: by 2002:ac8:7c4d:0:b0:42a:b4c2:e71d with SMTP id o13-20020ac87c4d000000b0042ab4c2e71dmr293866qtv.70.1706568414455;
        Mon, 29 Jan 2024 14:46:54 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bc6-20020a05622a1cc600b00427f1fa87e6sm2079280qtb.56.2024.01.29.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:46:54 -0800 (PST)
Date: Mon, 29 Jan 2024 17:46:52 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ming Lei <ming.lei@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <Zbgq3B8nmMuJooEl@redhat.com>
References: <ZbenbtEXY82N6tHt@casper.infradead.org>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbfeBrKVMaeSwtYm@redhat.com>
 <Zbgi6wajZlEkWISO@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbgi6wajZlEkWISO@dread.disaster.area>

On Mon, Jan 29 2024 at  5:12P -0500,
Dave Chinner <david@fromorbit.com> wrote:

> On Mon, Jan 29, 2024 at 12:19:02PM -0500, Mike Snitzer wrote:
> > While I'm sure this legacy application would love to not have to
> > change its code at all, I think we can all agree that we need to just
> > focus on how best to advise applications that have mixed workloads
> > accomplish efficient mmap+read of both sequential and random.
> > 
> > To that end, I heard Dave clearly suggest 2 things:
> > 
> > 1) update MADV/FADV_SEQUENTIAL to set file->f_ra.ra_pages to
> >    bdi->io_pages, not bdi->ra_pages * 2
> > 
> > 2) Have the application first issue MADV_SEQUENTIAL to convey that for
> >    the following MADV_WILLNEED is for sequential file load (so it is
> >    desirable to use larger ra_pages)
> > 
> > This overrides the default of bdi->ra_pages and _should_ provide the
> > required per-file duality of control for readahead, correct?
> 
> I just discovered MADV_POPULATE_READ - see my reply to Ming
> up-thread about that. The applicaiton should use that instead of
> MADV_WILLNEED because it gives cache population guarantees that
> WILLNEED doesn't. Then we can look at optimising the performance of
> MADV_POPULATE_READ (if needed) as there is constrained scope we can
> optimise within in ways that we cannot do with WILLNEED.

Nice find! Given commit 4ca9b3859dac ("mm/madvise: introduce
MADV_POPULATE_(READ|WRITE) to prefault page tables"), I've cc'd David
Hildenbrand just so he's in the loop.

FYI, I proactively raised feedback and questions to the reporter of
this issue:
 
CONTEXT: madvise(WILLNEED) doesn't convey the nature of the access,
sequential vs random, just the range that may be accessed.
 
Q1: Is your application's sequential vs random (or smaller sequential)
access split on a per-file basis?  Or is the same file accessed both
sequentially and randomly?
 
  A1: The same files can be accessed either randomly or sequentially,
  depending on certain access patterns and optimizing logic.
 
Q2: Can the application be changed to use madvise() MADV_SEQUENTIAL
and MADV_RANDOM to indicate its access pattern?
 
  A2: No, the application is a Java application. Java does not expose
  MADVISE API directly. Our application uses Java NIO API via
  MappedByteBuffer.load()
  (https://docs.oracle.com/javase/8/docs/api/java/nio/MappedByteBuffer.html#load--)
  that calls MADVISE_WILLNEED at the low level. There is no way for us
  to switch this behavior, but we take advantage of this behavior to
  optimize large file sequential I/O with great success.
 
So it's looking like it'll be hard to help this reporter avoid
changes... but that's not upstream's problem!

Mike
