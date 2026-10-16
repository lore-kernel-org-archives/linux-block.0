Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B728376BC1
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120426; cv=none; b=r+8D61lxvaQ9GLQqI99pw0dAlyEa449yAr0e7gvw6WP7ay8T+IT8T/4HGqSE935g/EptFeqEwk60AdWj9cUfmYyYrjWO2XGBdz3YXnamvJFA/MuyIxpdrNdnZoQd2Exscni9pYR9ENkb0AEOeaX6PYbgO5zLOVW9/6LxrhgK0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120426; c=relaxed/simple;
	bh=wleMGtmNrjSRnjejVtlXOJUIdjEEXlRsTfBv/1SGjqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A84u4+agfsc9Zze+gATwNZmI/aZ7UmqCYTLSMUmM2+SX2sPlXUQIYLrqVcaxVYi10+DZ+aflpLsJ/vs+3Jjr4OysebZjIYyps8PKZ9q0qgLrt56TZUoTZzExL8MgfgkS6p6GkALoDLoObwNsBQI6p3UqOgfHdR40e6hGPfvDXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KIUgBDBP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIUgBDBP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8897e83332fso390435b3a.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792120424; x=1792725224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kncXSXLqdZsNjreOv88DLkZuZB0aSQpv0A/ER6BF3zo=;
        b=KIUgBDBPJ7rpEDaORQ+17932OpplA8zMrI+rNMLATMBC/N+5+iGgpx12tfGI2n96qj
         lri5vFQAAp4l+CYznJpto75ymAbgAcYCErP7f7iwwzRSEo/jTkA0ulCY0Ycu2EGN9OcD
         jKhO/TnQnbn33HRL7QFmLvIr1ZVKxHu7/as+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120424; x=1792725224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kncXSXLqdZsNjreOv88DLkZuZB0aSQpv0A/ER6BF3zo=;
        b=Af2Tk4Ag9XHdK5sSZOUged36QxRgXS2LYYl3pjeehh8YZmDT+fLjGnikcJCK7aPcMx
         mVWNNBzzSPTU5wg9vNL5JPQcUPyiMSL7gN2gwdhN34s8/Z6Uf+BbV/zVFSr2b2HD1zOc
         qJqvvq4e5BfysPcPiPCOO8NjjaKDFaRths4MLalsBwO18cfjwgNMt401flZJ6Xpeh7Pc
         A0mkLDvr+dZRByBc/lu7pX7/L6g9Amp8TM6zK+tPj1iJeP4+geo1RC8NdzRv5EyP5aYd
         wAVfmsihCjfuqtvE9bVojldNauNEvKWSHhmFJ77+ioAukEIihfYSlILqcw8A4jbtTK0s
         M0gA==
X-Forwarded-Encrypted: i=1; AKwUvBwhI59bv4GDhL3Fk0xCIq9tV3sLQUoby3QbkSCYTE2hTmQAeqU78LwoLv/go2W07j++3bwujtImMaISuQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLej24d+Js5m5XKPilosNe5umaeAIHU6kjZRZ9kbaFHZ7LgCC49
	paaXP0MDZFXTy9ak3Cmq3+7nHFh6WES1/1FtBu2dNiYXGg5HfixRPEf5Nu523JhukA==
X-Gm-Gg: AYBFou3bBCZo8Q9SsXjAKFVdP90sak2/EHB29LpoCrSGG9Je7jNchb2Oxwtx9xEYtY5
	9Cb5gp59O4FutGwPOf6eDMc8vcy0VoQ/H0AOnAh8BOrcz/Mcx0fkzlOCdziAbc5SC8tHBH2d9zB
	RXaYfr5sMcz4HZbkvarxk+spCvCjJEZFoLGHD1U2+BaUlQHwxFo8eGuUxolNoBkpI4m1K1vOTPN
	qBDUH4Tao+0cSY5R8C9nQwvdvJwoQJ+hGBi0kpsUWMjjXNHFOzWCSPjZ0h6UDwItrtFMfmZhmq5
	AeVoEMiX7ctvz/LuLIdxmksEYcxHzZzrVhAUHEaspsiQ/0c6rfd8w52lWen7beNTiocdqbiNRQb
	VSAVetwIWv+4PQxOIpwLozxYO/WbzndHKcptlgw9+lqEAGfbaWDFKDOqLFYNpfJdZva1gCEe0NZ
	Yt9Tfbq8+g2Xjpjjrft4FeSkwjp92tY2XEpfP27n6x8iRrWm5xUU6dPCdli1AFH0sF4rai8bQwQ
	TzHIZ2W1zjBxmvl0SIhpUYxc10RuKpWYgzp5s5JLmYGHy42esTPaOrPYObg++cgbAzlI8m4k3qs
	FBqledqmvsNTNKjU25bO
X-Received: by 2002:a05:6a20:3d19:b0:3e0:da23:8743 with SMTP id adf61e73a8af0-3e201efbf5dmr1523172637.23.1792120424479;
        Thu, 15 Oct 2026 20:13:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f54b2eec9sm406056b3a.8.2026.10.15.20.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:13:42 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:13:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <baohua@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Bo Zhang <zhangbo0325@gmail.com>, akpm@linux-foundation.org, bgeffon@google.com, 
	minchan@kernel.org, richardycc@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atGWIBSUdnwJ4sTX@google.com>
References: <atBh9xfpOji_A7A_@google.com>
 <20261015112440.1491168-1-zhangbo56@xiaomi.com>
 <atGPwJL6XzlRaMva@google.com>
 <CAGsJ_4weqqSGH2JCh5EThtU8N3e96kRnhLtd9Fotia1t+7YqxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4weqqSGH2JCh5EThtU8N3e96kRnhLtd9Fotia1t+7YqxQ@mail.gmail.com>

Hi,

On (26/10/16 11:10), Barry Song wrote:
> > > I applied the kmalloc+memcpy variant on-device and re-ran the same
> > > Android A/B. It removes the exclusive path entirely in our workload.
> > >
> > >                       9+10       9+10 + kmalloc fastpath
> > >   read contended      ~1,959     0
> > >   read wait_ns total  ~12 s      0
> > >   read wait_ns max    72-96 ms   0
> > >   shared              76.7%      100%
> > >   exclusive           23.3%      0%
> > >   dpin_contended      0          0
> > >
> > > Every decompression now takes the shared (down_read) path, including the
> > > cross-page objects that previously had to go exclusive. The ~1,959
> > > residual contentions on the exclusive path are gone, and pin contention
> > > stays at zero, so the full read side runs concurrently with no stream
> > > contention.
> > >
> > > Read-side contention end to end:
> > >
> > >                  baseline   9+10      9+10 + kmalloc
> > >   read contended 24,749     ~1,959    0
> > >   shared         0%         76.7%     100%
> >
> > Thank you.  I'll include kmalloc patch to v4 of the series.
> 
> Hi Sergey, Bo,
> 
> I assume when Sergey sent v4, could tag for the patchset with
> 
> Tested-by: Bo Zhang <zhangbo56@xiaomi.com>

That would be great.

> also, Bo's data can be put in cover-letter?

Sure, I can include it, along with my numbers.
