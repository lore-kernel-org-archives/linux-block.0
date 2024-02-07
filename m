Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C6208B2
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296945; cv=none; b=lYyQ5a07p0/3v7l1eb+pD+NgAQNypFeM01AOtSW8h/z/zdgLxIqg6jvrlpRcI+1SB6apJLJDWPJLyKmCeOWJh3A3MFyhClTDPkZShFnTbunk2zULnGqzuSpGF5oAhV+dw30L1Lgog9p1YlQpZUZlQHz1SUT1HHOwK65JUSyHbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296945; c=relaxed/simple;
	bh=xyb6XSX2rw0cO0dtyv7Tbh7XPxohWY4se8HFD4IGFIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnj+X727msrIXsMzfqrS+da+uBFvkbg5W7WwoRASs293g7bpSSkIsw2dk9fAYCdrWrJnWfFL0187whzWvuQFaWdKTjhyUjYCSZ0yjcmqzAcWzPdFLuhItQ21dxBaokGqAu8AumAkBMXFqyMToGpvqgFiulxEJ1appTBAmXfUcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iuJEcJah; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuJEcJah"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d911c2103aso2562895ad.0
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 01:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707296943; x=1707901743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jODr6cxPYhr2AZCIthfN0oFS1GjHga/6A2oQsTBVDlI=;
        b=iuJEcJahA3BvGqzogWjxgZg1evb0QA2s7V7K6hu7UP0zV0PqNaMVpIGNRvRQoYndTd
         xwJlBuoBBGSvfMQ2wCIlrf7KkYTPSIjFtVgMkbUd1kjHAf4xET1eNn6vrS0G9kob4LuC
         EjaK+lHQ/raUhQaDahpuCEKhEEwdJQxxC8BH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296943; x=1707901743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jODr6cxPYhr2AZCIthfN0oFS1GjHga/6A2oQsTBVDlI=;
        b=jZdH++gxyFINYRcMuddzx6IkQx545OfDXJycI876Zi2k1jSPD34RdN4+Ho3wEOJz/N
         iQuWrv9d/uBrjOb7nDAeE3CamDU6HGYje1SLvPZndS2TkHVIkngHPZUbgIqHYpkyyY5O
         nLMXAKoyeA2aco3RkrzLEMfyQSpcA96qIOmIn9Jsurr9N1IIGWW3gM8yMWSMFNnCY402
         Vwn33uQ7WA3MdthsV4DBUT7flvGyvWYJRiflPGbsgc1JsgELaU+XSTnS+6jT+uIKk+E5
         i2DynokTzmMEmatP4Q6xrWFUO9HvPRW7kqORC5IErBZlg33QOVFawmIPHHzsjcQNZvfC
         8Kvw==
X-Gm-Message-State: AOJu0YwKRXVYz3aOn8jW3HKQHd43OuURf8S352lFTdKnUX3zQSHNrI+b
	E5jMZWQcAPIE3lELiAOVxEu5ROK77gtX5EnysiJBlgWsVde/6SGyO8Q2m7nsNUribyp2d2VrMOo
	=
X-Google-Smtp-Source: AGHT+IHS2CFIdwOHhuBcp3CA1c4A6wHnklyZqC1U439w2hPuYbtkiza2h5WLqp/UlUMqrIJ16jGjqg==
X-Received: by 2002:a17:903:22c5:b0:1d9:5b75:4602 with SMTP id y5-20020a17090322c500b001d95b754602mr5345746plg.7.1707296943271;
        Wed, 07 Feb 2024 01:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXueprT99MxCl6fPyLLsM0pD2V1QJ/Jjq9t6icKQjmqSBE7nz6TP3tP08CmvX/zK9QmIKQGCOA7ZuFZnuOi5AYtn+sSP1X/S2xVWRcu3bQ++a463OLOm00pSM+RYLQRgOafePSydzSfvJms/Ad4xQ+FcSgllRc1+RU8V/Y5qRj6Jiw/dQ==
Received: from google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id jb6-20020a170903258600b001d8d04a4fa8sm918072plb.300.2024.02.07.01.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:09:02 -0800 (PST)
Date: Wed, 7 Feb 2024 18:08:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC][PATCH 0/2] zram: decouple comp stream and comp buffer
Message-ID: <20240207090859.GE489524@google.com>
References: <20240207065751.1908939-1-senozhatsky@chromium.org>
 <20240207084720.GD489524@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207084720.GD489524@google.com>

On (24/02/07 17:47), Sergey Senozhatsky wrote:
> On (24/02/07 15:57), Sergey Senozhatsky wrote:
> > 	RFC
> > 
> > 	We keep compression work memory buffer per-comp stream (which
> > is per-CPU), but we don't need that many buffers, because on each
> > CPU only one compression backend can access work memory at any given
> > time. Hence the patch series moves compression work memory to a
> > dedicated per-CPU area, reducing the amount of memory we allocate
> > for those buffers.
> > 
> > For instance, assume a 12 CPUs system, 2 compression streams
> > per-CPU (a default and one for deferred recompression). Before
> > we'd allocate 12 * 2 * 2 pages, after we'll allocate 12 * 2 pages.
> > 
> > NOTE:
> > The series stops short of moving comp buffers to a global per-CPU
> > area, which all zram devices can share. Compression backends use
> > CPUs exclusively (disable migration and CPU hotplug), so in theory
> > comp work memory can be in global per-CPU data. This can reduce
> > memory usage on systems that init numerous zram devices.
> > E.g. instead of num-zram-devices * num-cpus buffers we'll allocate
> > only num-cpus buffers.
> 
> And this is the patch that moves comp buffers to global per-CPU
> area, so that *all* zram devices and *all* comp backends share
> them. It also moves local_lock (which disables migration/preemption
> and CPU-hotplug once taken) to global comp mem per-CPU buffer.

That's a squashed patch. I also have an incremental one, atop of 0002
in the series. So first move comp buffers to device per-CPU, then to
global per-CPU.
