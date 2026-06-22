Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A6175A85
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149473; cv=none; b=sLA872Y3vQqWABgL3UYi4lz5xJKKpg0lbHYjk5Da2+pH3Dx3d7mZGiC4uzMhKRMV3zntV/PwnY610UWNFCvak5h1mtgCwF+yMI6Eptc+WTGqIlXopzonk6GgAukSBdMZSPFLgTB7ZAvPO87PMmtsDg72h0dzRK9wTZjPMGKkmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149473; c=relaxed/simple;
	bh=A64b8u1vEy1l6uw7Ax4fjzMCJUAxW0tqM0cg5+IjHho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pogp+7sYIhUl50v8dsDj8HyTs9yxB8403AaPqLHjt9sgFQgSmUg9FjLa+mIioG76W5ny05Y8D+AH6Mb0YsGZNGx+TZ7gSwbG5feBCpwuKwYigMiJgpkidrXK2geSTShEAy1gQ3rm6laYWLH6fOYjPyFGttQ/84uN6jelDi6SZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20251104.gappssmtp.com header.i=@osandov-com.20251104.gappssmtp.com header.b=DALXKMot; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20251104.gappssmtp.com header.i=@osandov-com.20251104.gappssmtp.com header.b="DALXKMot"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bf5a207a6so269923eec.2
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20251104.gappssmtp.com; s=20251104; t=1782149471; x=1782754271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7o12M/FCB176LvmUOh5Rciwk4R7hxZjTYhxxjcHmnE=;
        b=DALXKMotFHX2uViU28RhuGZZz+POdw3U1AbkF5sVhu8eOdJ5GkxozUIm+QBNaGW79q
         el4qqU/TuJwfRy2Owwn9b3QB7NptwUMMqxmbyPwui92OUFMbKrv7kajcztQdWfpnshZ9
         E/fOXJ1kjrtG1Mqr8T2NwNw4OIMvOXPkcrgUS517uN1I9GBglulrovMVfqD037b7r9lq
         4gl/GZ56Nb/02fbeeiNJQuLoDrSvJrq/1ZsteMhRF152iOjGMDzyHyN1qeDbgWlzSBGM
         f9ZkjtWJlUk7c4rB3/lOjEdr9WZdDaM/yWlVdI6yjZgMu2XslUvMcBFQoO+MGQbg2FYy
         GTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149471; x=1782754271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7o12M/FCB176LvmUOh5Rciwk4R7hxZjTYhxxjcHmnE=;
        b=Js4PX/82iP3hKlgj9d0AetEuD1oHUtBZEFFsQwcXZADOKQgQhK0YBpxmop0YZ5uKp6
         43yxSdSQrpKvdIko1s1TEhAP1gmnMd+aCudDLsdftbMGPl7DoHyliRrsy25ZtmBmyvnY
         PvWrjqzZQLOMnYw/7mqa/OA/tIeTTDPFE+z5l6E5lTywycK0UV5o+Gs7Lc1Srf866dgr
         ge55Ow7gPhgWG8uuWL5f04c4T/tSlpVC9fhl4Te8dXrIqlMjY2T8Xq9Cr6VjttIDj0SH
         PgRMI7AQKX8LJRE28LWgX5kSJWXo6WLR7Mis9j2yO+wvpEHjQ9ZgBLwmvG4bagyakoIM
         11lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3NX6q4VjyOPWJ9bU3jalTUISAxfmqGK3heWNf60fCaOUrbtxA9EzYstuT1MdYILLU+tlydf5cdbgzJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRUXrkHprYOEqoCFybxdI/D5Al86znY/rOjKQfKHLQtZQSghA
	Ihco6JJSsU1GKUTqiE+ATM4jfoOy+pk57VjJpo91ImLxzRJHwE7RMAnj+kzHbTfxOAo=
X-Gm-Gg: AfdE7clJ3FM1WRL/mZDWj/oiU+ltL4sWNZnd9D8eA9R7xhSlPSmlI0CYotEB9JHYH4+
	ni20j8xBC3qydL+p7JXRiHpG95vcTnCyN1gEQ+4OETAMbhCDhrJR9YcKIQ/9w4ZxUj9FXNd+6pf
	mJ0oRFBO9uywFVynQCm13mBTLqa6qrhMCyvc4AmgOmlKVAtjiaueNk3pGPBcOI/GN/rbTEwi/go
	XdtgoNMGjQL5QVC8CJ6ksyRVTGOjZsSB/yUCag0CZ6JoApS+Spe4cQFt4Bxp0Gm5z2npjPDO7iv
	GGO8Syl77UmHBf/tnpN5w6k5YdKL8WP0DC+6lgbz5abRuj3ocMrE5z+J/5l4C2+5g6IvnATv3J8
	S4RVLpqmvKi0yrHZvKyGAfF7edWHTHYHjLaMjSI4y3Fvnznb8/lVbn/Dxjcmv4qXSBx8SVzdwQe
	uv9ewPUWpUmsgRI1xqQDPjAegzwXNBEw==
X-Received: by 2002:a05:7300:acae:b0:30b:c021:5045 with SMTP id 5a478bee46e88-30c5232edd4mr286950eec.5.1782149471087;
        Mon, 22 Jun 2026 10:31:11 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:500::2:dcf7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm13544658eec.23.2026.06.22.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:31:10 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:31:09 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jeff Moyer <jmoyer@redhat.com>,
	linux-block@vger.kernel.org, kch@nvidia.com
Subject: Re: [PATCH blktests] Fix _get_page_size()
Message-ID: <ajlxXfgpMQJ4qlRR@telecaster>
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
 <ajXmBu9lDZwgMG7_@shinmob>
 <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
 <ajYabLMbEo6zyOWh@shinmob>
 <089e0281-4df8-4358-91ce-1f5cc0f0ec4b@acm.org>
 <ajkeGQd-0LnKJbHN@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajkeGQd-0LnKJbHN@shinmob>

On Mon, Jun 22, 2026 at 08:38:48PM +0900, Shin'ichiro Kawasaki wrote:
> On Jun 20, 2026 / 09:11, Bart Van Assche wrote:
> > On 6/20/26 6:51 AM, Shin'ichiro Kawasaki wrote:
> > > On Jun 20, 2026 / 05:55, Bart Van Assche wrote:
> > > > On 6/20/26 3:26 AM, Shin'ichiro Kawasaki wrote:
> > > > > This is a rather fundamental change, so I would like to ask opinions from
> > > > > other blktests users, especially Omar and Chaitanya. What do you think about
> > > > > the idea to add getconf to the requirement list?
> > > > 
> > > > CONFIG_PAGE_SHIFT was introduced in the Linux kernel in February 2024
> > > > (commit ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB
> > > > definitions")). Older kernels had CONFIG_PAGE_SIZE_4KB,
> > > > CONFIG_PAGE_SIZE_16KB, etc. This means that it is possible to derive the
> > > > kernel page size from the kernel configuration file for all upstream and
> > > > distro kernels, isn't it?
> > > 
> > > I checked the commit is in the tag v6.9. My Debian bookworm system has kernel
> > > v6.1, then the config file at /boot does not have CONFIG_PAGE_SHIFT as expected.
> > > But it does not have CONFIG_PAGE_SIZE_* either... I'm still afraid that kernel
> > > config file approach is not reliable.
> > 
> > Right, for older kernels CONFIG_PAGE_SIZE_*KB is only available for some
> > but not for all supported architectures.
> > 
> > It is not clear to me where the desire to avoid the dependency on
> > getconf comes from? As far as I know it is available on all Linux
> > distro's. Since it is typically included in the C library package it
> > should not introduce a new dependency.
> 
> I think less dependent is the better in general, and wanted to confirm that
> it is fine for everybody. If there is no voice to object, I will create a
> patch to add getconf to the requirement list.

I agree with Bart, getconf is ubiquitous enough that it's not worth
trying to hack around its absence. In my opinion, parsing kernel config
options should be a last resort. If anyone complains about the getconf
dependency in the future, I think it'd be better to add a simple
src/pagesize.c file that uses sysconf(_SC_PAGESIZE), but I don't expect
that to be necessary.

Omar
