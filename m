Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF081CAA82
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743106972; cv=none; b=TAMuAgfjhvhG/7pZuhLLY2BZSzbQQ6t0KiceEdEwcbPAhQk3pNGfnuvb1saeXxVrr3XhCrtNWvJaYcGZg36zTy7X/FRHsgiEgqXEnmHtiDLVnrlPP+TTzVN+R7obhj9NOgBv/VJmvGLFntPPD0QZg7MxmPUH2DjEJF/ycGVCZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743106972; c=relaxed/simple;
	bh=hWsoNvNHVfFmyq/J/uqEJxexZfkLwaAkkAF8jkhLaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BktnjkZBrr5AOmq7hMJX7SSyHTn/RZILCUv37hCs8Lu4X540gHUdRfXi/DPnJ7goBD/3O2xNbziktxA41HncApsehUnwVVQKc5lCp+Slu8kP1HbemuyzEMt5pEbPiFH/nxCblABThQycnXVkCZO40CyN/MVleraUIfyFYnxa5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Yh1gb2Zn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Yh1gb2Zn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso1765205a91.1
        for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743106969; x=1743711769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f36YSwLPJ313+jNbvLdd5CTUY7LI4BTt4o8yr4k9tM4=;
        b=Yh1gb2ZnrNy735DzwOlU3+UeOzHLxvl1Wb5ane4aqeOfcHK66mfgwm6jRq8g2Mci0y
         fsB9O//bu8gMK8wWck8pnjXMGbPfcQ71l0U06OGY9365oRHu+cFGp8Hs2SFJV0cGH+Wg
         CDz6uZOsl0eSnBhvaqlVjvRRSQq0sxLTT6F2AU34L+nr1iL0eeHy6RAfYbE3h2KxbQyR
         50hI1DWM+pVstGaVg6bgMDOwwTHBL8wKjNRX3so/g2BOSOGvkiU4Pm2cvQOWy4aWi36S
         AqkWKThqJOw8L0IhrglTZlymMVwRrT2uNXnH2GE6cVenjw7AOYYDlq484S1/wvVEJt6T
         YRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743106969; x=1743711769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f36YSwLPJ313+jNbvLdd5CTUY7LI4BTt4o8yr4k9tM4=;
        b=u/Itz7R/6NwEjj1Ot5pNGUpmUowdSLCkFEcujKjLfCIWR7bwT0GDADEP2NQ5Zy02od
         b3LS38q3GCmIFbOjP1OZzmolcDEoWPD3Z8wQfwFUSG9S9tW37vYU10xTFLzcWlCD0vK/
         F741pyJUhW2IFyyWsvasVjFVuO4J7GtlHZujcJqCffSJ1oUQuW3kPI8bvm6dz6RJpoB4
         d6mq7aiQtr93voTuW1BnLGwovQBXXBDHat7fSfI0xS9ImFucQ6yBpNYzob0dKWVrIqr5
         MMR1wIFaPRrRGOWQwn8/Zi+3nkKBHnAD3XJi0FGOmY9qdmqwQ9f2tdJNY9oIbCjQ1IA/
         ounw==
X-Forwarded-Encrypted: i=1; AJvYcCXhSqBiLYQgLdRh7ApoVnm9cP1Exz21VaLdsIZ/nzjeUhfBnJq6KOMAvMgxV9CztVw8IZl11IAy0IVfEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9fwrBC9XIF6AqWXSGrTF03b4dsTdEZ3H2IpEHCjOnD+xNzfX
	rwbl6QJ1WA2EmBlb6kvMScs4UXP63NrjMPZsUzbdMY795UU4ftDhic/llhLIN48=
X-Gm-Gg: ASbGncvjOt6ti0lCuuMAl2vWc/1JLtGgcCZm1VT5oJ/Psidp11rIqHPXKC/XKCsmaas
	iO4Syu7kvVFPCyoGwHmEruo0Ys5gav0lcmbh3S94vs52T46EfUjGYStAPr626ahIW/oPUi2o9sS
	BaiQjiMKLBhetB0S3BIsKGb4XqkCQerA/paaiBP7Zx+PuSsnkWVQgTh4PVNLBwxjTuyyzLQ2kVg
	qHFlOVphgkrruNdJ8ALVsRbUF+wLOVa225yuY5tXqecKjraYrBvzWvCKJ2AxIyLhJ6tvVMQgLUh
	qpQlmiw16VGjY8OnHnzPV5Taus9slTLq6faPXWMMa9ZQnun4CWO/TwVgu9DyoS2caoFTihWIKrE
	05tFjyeE9G5fUK9Rb2Q==
X-Google-Smtp-Source: AGHT+IE04slap1s8okAKEtulK560I8Pk5y4yI9BiST5ZRxIXZ4EDqBdpcK7KvdffOC2kSZ2m8M/JJw==
X-Received: by 2002:a17:90a:c2cd:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-303a8d81d2bmr7055953a91.27.1743106969072;
        Thu, 27 Mar 2025 13:22:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0529sm2964573a91.16.2025.03.27.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 13:22:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txtkT-000000016eh-2SQ3;
	Fri, 28 Mar 2025 07:22:45 +1100
Date: Fri, 28 Mar 2025 07:22:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: Re: [PATCH] generic/764: fsstress + migrate_pages() test
Message-ID: <Z-WzlUN6fSciApiC@dread.disaster.area>
References: <20250326185101.2237319-1-mcgrof@kernel.org>
 <pociwdgfqbzw4mjass6u6wcnvmqlh3ddqzoeoiwiyqs64pl6yu@5ad7ne7rgwe2>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pociwdgfqbzw4mjass6u6wcnvmqlh3ddqzoeoiwiyqs64pl6yu@5ad7ne7rgwe2>

On Thu, Mar 27, 2025 at 12:53:30PM +0100, Jan Kara wrote:
> On Wed 26-03-25 11:50:55, Luis Chamberlain wrote:
> > 0-day reported a page migration kernel warning with folios which happen
> > to be buffer-heads [0]. I'm having a terribly hard time reproducing the bug
> > and so I wrote this test to force page migration filesystems.
> > 
> > It turns out we have have no tests for page migration on fstests or ltp,
> > and its no surprise, other than compaction covered by generic/750 there
> > is no easy way to trigger page migration right now unless you have a
> > numa system.
> > 
> > We should evaluate if we want to help stress test page migration
> > artificially by later implementing a way to do page migration on simple
> > systems to an artificial target.
> > 
> > So far, this doesn't trigger any kernel splats, not even warnings for me.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> So when I was testing page migration in the past MM guys advised me to use
> THP compaction as a way to trigger page migration. You can manually
> trigger compaction by:
> 
> echo 1 >/proc/sys/vm/compact_memory

Right, that's what generic/750 does. IT runs fsstress and every 5
seconds runs memory compaction in the background.

> So you first mess with the page cache a bit to fragment memory and then
> call the above to try to compact it back...

Which is effectively what g/750 tries to exercise.

When it's run by check-parallel, compaction ends up doing a lot
more work over a much wider range of tests...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
