Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5A91842
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206953; cv=none; b=QKXQ9iR5KsywRV7xuseDD5qzjRZso3hntR1W2Yy5WpF7iMKY/5TMndSRmmMJuPhU3+iD16/OfrPKjp3zr5jmfUwCLcafz09HAo1XGr/3qH/hpHIqKZC985yX3skB8fEPMj07oCYp/SpIyfkWgvZoesQSpHXVZfVej92iwV3d+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206953; c=relaxed/simple;
	bh=AoH/Mtv3zQnhNk67KFqMgYLBiiZj48nfHsH8KTMxQqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzLKIWSpTBxbJG5YyW8TKZ70MpbHljizJhyA0sLIFyizItRdBm0zanQojFxUiBtc/vAxZqqpMTUz4in6NCg7OdmslefMULkfWKLURM7aT4wMBzTwsbJmx4k0WMBBseU0wODtFqqQadbQRhLNuXw7ljakYzxPZLuMAUCBJpW15cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XX929VuE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XX929VuE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so3064513a12.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710206947; x=1710811747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQazo96a+L5Swtskn/l7YLZCCsrfvH0lJ1JRRmYxbXw=;
        b=XX929VuEisLfsBGE8UvnG4RH87Vcn4iZSbYK2kDSUR62rSXXYmYsH/euSssLkLL0UK
         AQreg3JQ/CstKpMFx4zdc4/i82+ezATNzk8eMOCaM5LqF16bCjYxLQZqb9YiTleEibGE
         2uPZd896DqlO+rjZVaUqfsrsg5Jee6r38NkpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710206947; x=1710811747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQazo96a+L5Swtskn/l7YLZCCsrfvH0lJ1JRRmYxbXw=;
        b=Q8F2gfT4MjQRKeuYxMIW66QPit29e92aIw3htWXaM5Lw+jcZ/QJiz0+JJwRzI/Cp6z
         bacbpZfvx4KWCAukSlpdMzZUFvcpEv3kpl3xJ/0z/0HxSrfUWtNTg0emctno9T3iDtA2
         HqxJbYqXTaO6sR6vLxIOqrYVadI/CfQic87PwpWUqntL4/jlge5TLR/M1+mb6xyoBjCS
         GqM9IIMP7G/vGX8vs3Zxj27Zbh5g0aEPpo2gRWuSyBrKer4ygbu2GFxdHnwtOL+6g8co
         2IzkC8qXTeMaWoeF7BQ1DWwoYgNFoimNaG/0TZqqp6inM5DoLrBCaSadDDU7G3t01kSJ
         XCXw==
X-Forwarded-Encrypted: i=1; AJvYcCW1KX+OTUUjQcxFN19kVKpEmYedqRkqWuKEzIp8jFqFkcSpAmWLUiefC6NH4NF0nW9iBKYNsLmoqLbS/PDIhiVz0Cvb2lJzxwyhArc=
X-Gm-Message-State: AOJu0Yy8JjqnfHkIkjEuQ579q+Zao8vPrfic5mukAVeZSyNy5ZNu8pBZ
	jPdMRfsxJsE6HndL91/wjx0WD79r7sKFSkyPfVX/Ek9GrBi7VZbVWd/VJPHhXKnOgt1+B3R9cfp
	hItdFGg==
X-Google-Smtp-Source: AGHT+IGR41X4sBC4rwDWLUsIhyxjagkieEg6hAogSoIGe+QUo4PfiBiHgYkel3DZB+AoUxZ5oiHD4g==
X-Received: by 2002:a17:906:ac9:b0:a45:ac83:8743 with SMTP id z9-20020a1709060ac900b00a45ac838743mr5197342ejf.33.1710206947071;
        Mon, 11 Mar 2024 18:29:07 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id dn18-20020a17090794d200b00a45f545beeesm3315279ejc.122.2024.03.11.18.29.06
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:29:06 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so3592172a12.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:29:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoprIAjePG4o6Hkwohljwi5BF0LIN0kyUt2MlZhSvYlbu2EYNyYlO2GR7+52uAadmqyJQ/7tqrOaRSFklOKuOfLaSxj/uRwhO63N4=
X-Received: by 2002:a17:906:a851:b0:a46:3826:a8f5 with SMTP id
 dx17-20020a170906a85100b00a463826a8f5mr1293378ejb.38.1710206946316; Mon, 11
 Mar 2024 18:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org> <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk> <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com> <Ze-rRvKpux44ueao@infradead.org>
 <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk> <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
 <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
In-Reply-To: <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 18:28:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1wS2fvZjWhLSR6t2h1g+PX-fp=zD9e-Fke3FPWtrGXg@mail.gmail.com>
Message-ID: <CAHk-=wh1wS2fvZjWhLSR6t2h1g+PX-fp=zD9e-Fke3FPWtrGXg@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 18:23, Jens Axboe <axboe@kernel.dk> wrote:
>
> > What odd hardware are people running?
>
> Maybe older SATA based flash? But I haven't seen any of those in years.
> Or, god forbid, rotational storage?

Christ. I haven't touched rotating rust in like twenty years by now.

I feel dirty just thinking about it.

> Out of curiosity, on your box where it broken, what does:
>
> grep . /sys/block/nvme0n1/queue/*
>
> say?

Appended.

FWIW, it's a 4TB Samsung 990 PRO (and not in a laptop, this is my Threadripper).

                     Linus

---
/sys/block/nvme0n1/queue/add_random:0
/sys/block/nvme0n1/queue/chunk_sectors:0
/sys/block/nvme0n1/queue/dax:0
/sys/block/nvme0n1/queue/discard_granularity:512
/sys/block/nvme0n1/queue/discard_max_bytes:2199023255040
/sys/block/nvme0n1/queue/discard_max_hw_bytes:2199023255040
/sys/block/nvme0n1/queue/discard_zeroes_data:0
/sys/block/nvme0n1/queue/dma_alignment:3
/sys/block/nvme0n1/queue/fua:1
/sys/block/nvme0n1/queue/hw_sector_size:512
/sys/block/nvme0n1/queue/io_poll:0
/sys/block/nvme0n1/queue/io_poll_delay:-1
/sys/block/nvme0n1/queue/iostats:1
/sys/block/nvme0n1/queue/io_timeout:30000
/sys/block/nvme0n1/queue/logical_block_size:512
/sys/block/nvme0n1/queue/max_discard_segments:256
/sys/block/nvme0n1/queue/max_hw_sectors_kb:128
/sys/block/nvme0n1/queue/max_integrity_segments:1
/sys/block/nvme0n1/queue/max_sectors_kb:128
/sys/block/nvme0n1/queue/max_segments:33
/sys/block/nvme0n1/queue/max_segment_size:4294967295
/sys/block/nvme0n1/queue/minimum_io_size:512
/sys/block/nvme0n1/queue/nomerges:0
/sys/block/nvme0n1/queue/nr_requests:1023
/sys/block/nvme0n1/queue/nr_zones:0
/sys/block/nvme0n1/queue/optimal_io_size:0
/sys/block/nvme0n1/queue/physical_block_size:512
/sys/block/nvme0n1/queue/read_ahead_kb:128
/sys/block/nvme0n1/queue/rotational:0
/sys/block/nvme0n1/queue/rq_affinity:1
/sys/block/nvme0n1/queue/scheduler:[none] mq-deadline kyber bfq
/sys/block/nvme0n1/queue/stable_writes:0
/sys/block/nvme0n1/queue/virt_boundary_mask:4095
/sys/block/nvme0n1/queue/wbt_lat_usec:2000
/sys/block/nvme0n1/queue/write_cache:write back
/sys/block/nvme0n1/queue/write_same_max_bytes:0
/sys/block/nvme0n1/queue/write_zeroes_max_bytes:0
/sys/block/nvme0n1/queue/zone_append_max_bytes:0
/sys/block/nvme0n1/queue/zoned:none
/sys/block/nvme0n1/queue/zone_write_granularity:0
