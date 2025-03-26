Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EC253B43
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021970; cv=none; b=TYNfLhWaNhGNJsJ2P6LY0BMgWby29x6NaLV8TwmlBWu675PoVV19ODzX05huFteOm9JHPONATMIpIixYjYke2NEL/6F1/CuqSEn+VRlz9NjH3UUsnNNMSO0pZgkYAyD39I5wFHtT2WQ7ucnlXM0xJqMD4E5vPXzIhGYyaiqfmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021970; c=relaxed/simple;
	bh=0fffkpb2/dTnrDBMgXFpfQbnuIh9s/gxDQH3AhTGbzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ7ck9PUjMijquHZnFLyuFZR5w6CTe13TmtrWVq0hDPXkGuO/T+/tI9Z12n7IJ/OtN74N3/TRjLXecf8mDXrWafPUG9yPHCVeMnzQGBrnTx8kYwOqtb9pOUqCMNSj4G63G3zuvqZPwbPtivy/dvxXj879P6Cbewt7NXJFGUK4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NgWlZ/+8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NgWlZ/+8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224341bbc1dso6353755ad.3
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743021968; x=1743626768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0DxjNG0t0sEawU75w2W9OviEBnYSuXggXRVCOAy4Bs=;
        b=NgWlZ/+82sL4aGEzJML4+KrqN9COuLeIGR4rcrWVVAM7ytwjvVv2ptAc7moSi8P1IY
         1n0uGkoMT9tAH4zgSt81QlG4iBBW29xfWjfr4+W19MxhuX9JAlceCXtu1sxijMUFC9Jb
         vn99TUqvxW/wXWWHKBQIiulYUJYBTV1CfrPewlN2i8p383FDdZplRYopFgGtqKD699b3
         2hThlA1aE0OOpEpMnWs8tqLNQaiB64sTvVA/rBy9qE4HZxf6i08gged3pRCUefLQLN7Y
         2neksZtsHIlRwJhBInsNsjRXjC+WLEL4ShRwQIAb41GOI7YTiOwnEl2Ffy8Gdp1rZFNn
         vH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021968; x=1743626768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0DxjNG0t0sEawU75w2W9OviEBnYSuXggXRVCOAy4Bs=;
        b=iCcOx7PRF1j8BF8545hY7ltW8U6sAt8QLegIs5yah+9CqMoSAJFsoUkm1ifUfNlxlg
         RbFf5q3+6Mx/y4+IqmGFRizBgqeSvHOEfpBA8+C6T/30Py8aR/BJjeS3tFWpNfh1PvDp
         3CGqQeP4XZ6SzArjbSTXj968ZI1DwHTlhFjDyZ1amLpJOpqGy+b/Yx+dNPrf4avoQZ5/
         ebUnIYz0/TWJ+IiwVchSgrBhQ/717ndNHANuKnVpAfeYio6kLwscudN8TPu+9zavCjSW
         pNYqlKDdJ+EhVa/Ko1PBwv6HiCrenWZpsBKPIBgUgyy05wQyiGyu3Dp1obsNCU3GibLR
         O8ig==
X-Forwarded-Encrypted: i=1; AJvYcCWNsPto8dZ5hWD584Ef0Zed6o60hOqJr572tXp/M68uV2DGUPJ0vK0JX42AfEuAwhfqjqCpptPROvvJVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMTWToE0cJgDXFdUaF4j9lc1fzOvXmvv9mDJBKDRbAGWlc/cd
	N/93k7wINii2vURrjZSSCI8gRSPtvYzVKfQYxba5w/Bk6SewcaLE35F/i1dJTLo=
X-Gm-Gg: ASbGncuRaUZHVgOtk2F5oz6MYsPygUq2paNGM/XR6SfRePpXq/O4lbNxJ3darw/lyKE
	Hbt9GFRYBuuhhRC+G2He3bsU5PqQpoMpGTL/lpom2A1CDkLkR/Z8UhjD9pjcksOku3mkoUrTMWZ
	P3xKoIIedQilpvFkmd/ZsiAPGoj4Y8ozPt/B0QLKJ0v258CZIpO0GeNzwHHsduSr1zRV4anD1Ck
	M18bBYY5vZgDZsKeB6dFRKIteLZC9iUhFFQhLimVD/ohNXVHKZVQa/fA5XlePjBOVw4HfdcmXq7
	YXzVQn5LSuL/w4z4z+MrjryPsSsdtqwP0Ve4dkt2WNEJtVO9K66+dRb4WkHNVDFyFuA7vCtrE2L
	A7TBdXSHVq3xBmcuveQ==
X-Google-Smtp-Source: AGHT+IHYC9faJMfvw3S3nDn2V7wFInikoEkVJnJUgRfyAHRL+/TjLMdCvBBuENH2adHdN+PgG4A1eA==
X-Received: by 2002:a17:90b:2c84:b0:2ff:6e72:b8e2 with SMTP id 98e67ed59e1d1-303a8e76448mr1592314a91.31.1743021967688;
        Wed, 26 Mar 2025 13:46:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039e60f81fsm752510a91.48.2025.03.26.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:46:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txXdT-00000000gYk-3LF2;
	Thu, 27 Mar 2025 07:46:03 +1100
Date: Thu, 27 Mar 2025 07:46:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	jack@suse.cz, apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF Topic] synthetic mm testing like page migration
Message-ID: <Z-Rni3UhAF4RB7AY@dread.disaster.area>
References: <Z-ROpGYBo37-q9Hb@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-ROpGYBo37-q9Hb@bombadil.infradead.org>

On Wed, Mar 26, 2025 at 11:59:48AM -0700, Luis Chamberlain wrote:
> I'd like to propose this as a a BoF for MM.
> 
> We can find issues if we test them, but some bugs are hard to reproduce,
> specially some mm bugs. How far are we willing to add knobs to help with
> synthetic tests which which may not apply to numa for instance? An
> example is the recent patch I just posted to force testing page
> migration [0]. We can only run that test if we have a numa system, and a
> lot of testing today runs on guests without numa. Would we be willing
> to add a fake numa node to help with synthetic tests like page
> migration?

Boot your test VMs with fake-numa=4, and now you have a 4 node
system being tested even though it's not a real, physical numa
machine.  I've been doing this for the best part of 15 years now
with a couple of my larger test VMs explicitly to test NUMA
interactions.

I also have a large 64p VM with explicit qemu NUMA configuration
that mirrors the underlying hardware NUMA layout. This allows NUMA
aware perf testing from inside that VM that responds the same as a
real physical machine would.

$ $ lscpu
....
CPU(s):                   64
  On-line CPU(s) list:    0-63
    Thread(s) per core:   1
    Core(s) per socket:   16
    Socket(s):            4
.....
NUMA:                     
  NUMA node(s):           4
  NUMA node0 CPU(s):      0-15
  NUMA node1 CPU(s):      16-31
  NUMA node2 CPU(s):      32-47
  NUMA node3 CPU(s):      48-63

This is also the VM I'm doing most of my performance testing and
check-parallel development on, so I see the NUMA scalability issues
that occur when trying to make use of the underlying hardware NUMA
capability...

> Then what else could we add to help stress test page migration and
> compaction further? We already have generic/750 and that has found some
> snazzy issues so far. But what else can we do to help random guests
> all over running fstests start covering complex mm tests better?

Use check-parallel on buffered loop devices - it'll generate a heap
of page cache pressure from all the IO, and run a heap more
tests at the same time as the compaction is running from g/740. This
often overlaps with g/650 which does background CPU hotplug, and it
definitely overlaps with other tests running drop_caches, mount,
unmount, etc, too.

One of the eventual goals of check-parallel is to have all these
things environmental variables like memory load, compaction, cpu
hotplug, etc to be changing in the background whilst the tests
running so that we can exercise all the filesystem functionality
under changing MM and environmental conditions without having to
code that into individual tests....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
