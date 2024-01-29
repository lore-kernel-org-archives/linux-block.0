Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4B158D7F
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545841; cv=none; b=APRxkCdibhUv0pLQLqjUBWD7Jy5odZ4EQkJ0XX/AR+zGgjn4bWjEV0EZdLKCFshXY8gf8K0acEo/kMhb+FHTuqO1SrUrMVvBdkTQPnrLCGKeDD5MtBp1EnRK4NmQTI2Zn+698FI8tyYfz2CqhzTXMg7N5vZ+HvT8HQ8H+rp3M+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545841; c=relaxed/simple;
	bh=WQvHEqtJJAbG6V1Jxx0Sb+/DITE+U7c0dJb6PuSbslA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxOquHKZJyNMF1UtnyOzbBeHYZxkLIr51kIVja+HgR1xeHMDX7B8aZFT2gRdOCX/2W1lW9+DuJJGSpJx04iJgc1xCkEWPplSiA7ZHadDJvxok2AwYH7MssUAVMBd65NQZ9UcMXyfajpOhSNLbYC03bfsInte3THHfRuyAT06d7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a8af3c10cso22084201cf.0
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545838; x=1707150638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNaphXz3Eeu2a2aMd3YFBIKcgOTJh1+i5qv0A1L1mn0=;
        b=MSS7eu/OC4d3HDGGHtW5E2C0FyuhOuKbag17EysKJ3u/pGvICHGuWG0z2dYWFxwNN9
         xLw1vKKeYKgdnDG+yy+XG9xF6yT0+ioABYZyYad6c9nbrrwLaciW8AUnLA4VvujSidfz
         oxAyeAodinVl0mcM6AkCkERgFvQ4DoGxY6HOmQT8SLJ6eJkE6199ayKEwOU1l40aG+sH
         sIcvJgYRV3QuRK5Rmp904s2UD19a3zOeAEcFfXkXYBoeer0GIuF+j0H2+sVOAaxlOm8o
         xTZkOeIn+x6BW7I6mkqf129WgrEj956cnG1I/KVksHY6SC0nXjZ+zsnYA2UsmNMlufKm
         WBvQ==
X-Gm-Message-State: AOJu0YyU2UTbi+O2Wn8JDfRcGWaJ2FGVFkky78Hnhy97xHKF8+CW97L9
	r3e0pl1FuZVXTvbq27HZy//3i76JxfCZlv7M+73sRYCcsYM8VvrMjZ5r5kWtAA==
X-Google-Smtp-Source: AGHT+IF4Y1L+vF00eH3w9yEp9lpeF+3O5MhCmMlkCMEWoJuvklUpcahfYjAD7nytEyD1AK/gb/N15g==
X-Received: by 2002:ad4:596f:0:b0:68c:5c6e:3bc with SMTP id eq15-20020ad4596f000000b0068c5c6e03bcmr125903qvb.107.1706545838729;
        Mon, 29 Jan 2024 08:30:38 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ph29-20020a0562144a5d00b0068c524a70fbsm700637qvb.66.2024.01.29.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:30:38 -0800 (PST)
Date: Mon, 29 Jan 2024 11:30:37 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, mpatocka@redhat.com, axboe@kernel.dk,
	ebiggers@kernel.org, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v8 0/5] Fix I/O priority lost in device-mapper
Message-ID: <ZbfSrcVm4c14D5MS@redhat.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
 <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>

On Wed, Jan 24 2024 at 12:35P -0500,
Hongyu Jin <hongyu.jin.cn@gmail.com> wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> High-priority tasks get data from dm-verity devices via RT IO priority,
> I/O will lose RT priority when reading FEC and hash values via kworker
> submission IO during verification, and the verification phase may be
> blocked by low-priority IO.
> 
> Dm-crypt has the same problem in the data writing process.
> 
> This is because io_context and blkcg are missing.
> 
> Move bio_set_ioprio() into submit_bio():
> 1. Only call bio_set_ioprio() once to set the priority of original bio,
>    the bio that cloned and splited from original bio will auto inherit
>    the priority of original bio in clone process.
> 
> 2. Make the IO priority of the original bio to be passed to dm,
>    and the dm target inherits the IO priority as needed.
> 
> Changes in v8:
>   - Rebase patch 1 on commit 7ed2632ec7d7
> Changes in v7:
>   - Modify patch 4: change dm-verity-fec.c
> Changes in v6:
>   - Rebase patch and resolve conflict for patch 1, 3, 4
>   - Modify patch 4: fec_read_parity() follow the priority of original
>     bio
>   - Update commit message
> Changes in v5:
>   - Rewrite patch 2, add ioprio parameter in dm_io();
>   - Modify dm_io() in patch 3
> Changes in v4:
>   - Modify commit message by Suggestion
>   - Modify patch for dm-crypt
> Changes in v3:
>   - Split patch for device-mapper
>   - Add patch to fix dm-crypy I/O priority question
>   - Add block patch to review together
>   - Fix some error in v2 patch
> Changes in v2:
>   - Add ioprio field in struct dm_io_region
>   - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
>   - Add two interface
> 
> 
> Hongyu Jin (5):
>   block: Fix bio IO priority setting
>   dm: Support I/O priority for dm_io()
>   dm-bufio: Support I/O priority
>   dm verity: Fix I/O priority lost when read FEC and hash
>   dm-crypt: Fix lost ioprio when queuing write bios

Sorry for the delay.. I've been consumed with other work.  I will look
at this patchset for consideration for the 6.9 merge window (we still
have time to make changes given we're now squarely in the 6.9
development window).  So I appreciate getting you feedback sooner
rather than later is both useful and important.

I see Eric provided his Reviewed-by for v7 -- that really helps.  BUT,
for some reason you didn't add his provided Reviewed-by to each commit
when you rebased with v8...

Mikulas, if you beat me to providing closer review: great.  If not,
that's cool.  That DM requires such care (with sprinkling changes
throughout DM core and targets) is unfortunate -- but	could be
unavoidable all things considered.  I will look closer "soon" (if not
this week then next).

Thanks for following up!

Mike
