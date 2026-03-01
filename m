Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679A1DE3B7
	for <linux-block@vger.kernel.org>; Sun,  1 Mar 2026 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332353; cv=none; b=FL+0CnEg9sAB1W39YgJyhauLwn+KLrwkZupo6k345by2YlUDBpTCIQQNqS7phcJe83wgoBJr/Xw3/4/HiP0gVgu/fQyQUmZfrFt7Dzk6dFlw3SYMnbf8RKuELTlTqZ/xaOs/ONdrsA4EofIxSmZlJAAQTjGoCSLzkBCQ9pX5sSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332353; c=relaxed/simple;
	bh=5tHPwb2e/izTj3Q493jmeFKidyfj9OfoL6YRqGJfV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy9hwyh9SkAwiYRXBno2vwWM6rbgOFoLuv7vvcVmYS92kfZIz32uirBKsCUIfBTtfSLDIb20cPOtW06fPJQuMzDq3W7yo2KEkY5cA6NJhPk+O+S8AfdFELFE3zl6bInHcMsvE6SOay2UWs2uMkWW2+LpG5+1MCr3uNk9bWAkt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9ukLKBD; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ukLKBD"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3192520eec.1
        for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 18:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772332351; x=1772937151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFmASH9t3VnZs3JmetqH7z59S6tUzpkAkdGYc5lgV0o=;
        b=W9ukLKBDu6izz3XFVEmgT38hmAEk3V3DEvKmoWV1WcdgIDCjn9O3RLSPP/KU97+Bdv
         lSck5blOK8zflSIKyatyD9xaW7uGLvYH5utI7H6tyAygGZ7wCgI9uw/8+2laiY2M4ZyT
         QU7PbiyFeiKue2pROWZwLBvHSruAIs2E76PYv4Sy8RKENeU5+VuOh6RODl3SFSdLRxRH
         5tva7My4xRvjluqQ2AVrO30m8lw0TeDJ4BNb54MAzpuY17CJ2pscVxL4Nv7IUGrebKtR
         6o/0XNnEQktHCrx+haAGNRi7aM+zmvJGk5G2TPXXr5fkhWlzLrE1/eR5/vc1B9kGt+x5
         wXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772332351; x=1772937151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFmASH9t3VnZs3JmetqH7z59S6tUzpkAkdGYc5lgV0o=;
        b=Sn8tr4WiYFqsvP7nltLeW9OG+MjaaULK9nOg4Ws4xVbLFT+lyoDeIBD5WR5MANDObN
         mPvfKm5Cfq4A0W/gqXUtFxUk7NrZJoDNqGF/5PxsMOhNzJ40cue0mPfAKFqzrCNT0meT
         MyJm65ug78QvDTyP8yBoWcHJZQuvewBxd1P1hbA/Swl7jnd0g9gvF687i2d9DOgtA1Nu
         8o9xVZHWMIq5jq0lZGiI4w4CM6uyQF9nOYIBDhdtxcOVNXYJ2S8HowTz3ZBLF5qreDhy
         5yL0+Cx8o/SSPlMp3g2HQ3p0LjjAqqL9Z+wS9p4/ghW1ucDOx3i/ko8Cz3U1D2Q6X9pR
         lGzw==
X-Forwarded-Encrypted: i=1; AJvYcCU/jD5uqCaQU+bDSsced0xuYXtuOPUgHW2JTi01Pk+nKOfPICEGKJQt5w4iHPje8GzDA7fSfcu+bc6vfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Vw2hXChZCErGbV2lPfMJooyjCBZ/v2Gh9GFaci5u1SM3g9sL
	tAIi/ClSFg5obVP3hy3eqCIGXJI8TolZV/3SUh8qH8WHUrc3K1oiIsP4cFG5jQ==
X-Gm-Gg: ATEYQzwGlPzYRd/4cZ+p2bXuy0LlIOpAnsBb1EJQOR/fn37on+Z7rJw4o+8au7E+Fve
	GlhVM7j/wmhrQfEPI4OLP5a5N+4bjqNfKy/LU1GBYouUhQkQdkFdbLz4YYO5yZhwAJekeALZtUY
	diIvwUeIpZNH2El3zOmmUN6sR1Y059+OvJkugiLExdBQurvIVUdSorTj3C2E29w9LMCqu6OzrZg
	RkKmnxReHnglpIuz0386M+pp9Evpgw8vUhzwMHP6iYEGE/nkU/F/KrRkCM+83TeVlCNRVHQNovR
	eX+lwNCTVB6OQxPBlBzvC8qEStB8kLH58wjb6FZVFZNc94p9ivuslLZ/Z4+3eJWu3Dxefvvto5I
	0H4ovSnDfOQ4VZjMsV7EoQfS6MKr9dxSBsVB1el4O+Wv06b+BpeWzjx0MjCIXZOdjDGMM+6lcOG
	o8IvAQZql7sf6cpALqT76GZ5nTBZfmNA==
X-Received: by 2002:a05:7301:1f05:b0:2bd:f5af:62bc with SMTP id 5a478bee46e88-2bdf5af6e2cmr1357800eec.25.1772332351517;
        Sat, 28 Feb 2026 18:32:31 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:1e56:f0c4:e708:15be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm7589514eec.9.2026.02.28.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 18:32:30 -0800 (PST)
Date: Sat, 28 Feb 2026 18:32:29 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiao Ni <xni@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
Message-ID: <aaOlPXCM/ecbrTj5@pop-os.localdomain>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>

On Thu, Feb 19, 2026 at 01:38:46PM +0800, Xiao Ni wrote:
> Hi all
> 
> I'm doing some work on user-space RAID recently. I'd like to propose a
> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> space using ublk and io_uring bpf[1], particularly focusing on the
> challenges encountered and potential kernel improvements needed.
> 
> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> with the goal of leveraging io_uring's zero-copy capabilities and
> BPF[1] for performance optimization. The implementation includes:
> * RAID5 stripe handling with configurable chunk sizes
> * Multi-queue support via io_uring
> * Degraded mode for single disk failure tolerance
> * Integration with io_uring BPF struct_ops framework


This is very interesting.

Although technically different with RAID, how about user-space LVM?

I need it for the multikernel use case:
https://lpc.events/event/19/contributions/2074/attachments/1776/3957/Multikernel-LPC2025.pdf
(slide #19)

Relying on the in-kernel LVM is not ideal for provisioning since ublk is
already there.

Also, it does not need to be a complete replacement of existing LVM,
a simple ublk-defined storage isolation is sufficient.

Regards,
Cong Wang
