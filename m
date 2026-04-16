Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144F3BE62B
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345622; cv=none; b=rE8XTLmgClXNiJE39oraLHtqeqNe+RqkdCLRleDG/kLyXwMZ4baR+udANUjt4ATFpEGnAcAHCJmDBJIlkZ4wGTtJHsSAaMB0SiLq21Lh8hYxejnWlT6RI6QoMZSLooWgEaLgK133JaSLkmBXwdU9eIl76RuVY9cSuaW4GSkIC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345622; c=relaxed/simple;
	bh=DkIYUSpKe7jeaZ178LSFSOgcubIwbKrV49RbSwMEWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHjXjIFJQ8Puk5aNuLap59B1ord/9l5YulPNYoMPt+Ai0tqW8shcP07Koq2fltvHRwp2usTl17/9ntLixsO1Xvc/RDqtR36n4dYVWOKwY/q7sTjMtB+RKRFv3uKS57a6t0S3LoImEEXOJaHRRZAaCjppmflFixlY6yL+h2v4yCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSN6RN03; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSN6RN03"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso4753238a91.1
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345620; x=1776950420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t1yzRKBX/1TtdEuoU2BlElGUfEgB24GKs57W5FriPs=;
        b=cSN6RN0351G5NSr0amiK2tkTJqZnEP+x1Tc4clkcPme2Bakp0O3FrD59ESWswsFqKu
         jMgxjq63P0mWHFkZMOuVjJBVsD31RILdA/fy84Qwr20VV0FfowYood8EJ/l+49Oee5FI
         1lfbO4yZn0YcCwAvmeg6tzWBLrDxUiB/ULHmEl/pKrKrl8MLyo1ACLV5HvYTO0nx/K0D
         UDl6cXaQQg5gCxD6coKewg+Go8LF5srJpL/JHCH3+RNiq/IcEov0TrYAlkzLU7i2sr9u
         ySEqjYOZJ+JoOXXLWFr2ObXu5DVJ0a4ER7ry0azD5DpcJc0JSH6dVYwBswtGGeHBMqdx
         lQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345620; x=1776950420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t1yzRKBX/1TtdEuoU2BlElGUfEgB24GKs57W5FriPs=;
        b=DX+NEG/I0XIK6OnPnDjk8eGGFaIc6aEO5og1A1ExF9i6l37c4EHpE/GYF5pnvFpNmQ
         gPzqhi6x3w1bCYrMs/GKZjfv5y63HDfceFm+LT89ad3NwP4pfOWb9MKIIvOc78Li0m4+
         D9e1tfMD3clvKbt5wK4zsFsLOjQxcZXUA9a9qkX6H2Zvb1FM+nlI1gfjz+1FOFThSEPS
         5+QbNQ3r71g9v1DBlUx0TsxlIcH1qIz+N9kCtAGz1UHDkpR+9tZqlmS3d7hBZ3De5svU
         qIqCEKkOR1I3xG67xyfwgW3uB8KXr4jdXnpZNGTpY6syaH7yUU4dRh+28/OvLs0a9YkI
         gQQw==
X-Forwarded-Encrypted: i=1; AFNElJ/PYIxt9Cc284zR1JQaJbgoxggNxhGKHKLrlbxdnM5857CpXYNuuB8Am6weNG7n58mVZGqWWzYXZKBUXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/FZrm/MsHaJlTZwCauRJgbBiR8lDCxvfdncl91FLHgM1tr3k
	SMiSHKwMQPdaQEKVbWe3t7GUN5RNPItgyOAmXWLPHyKiFG4WVDfnoA0U
X-Gm-Gg: AeBDievOkwTeSLqJCiNebQZhsJ9M25gumjlcyNLyGll9TSIdzRR6FmxcHiIzwFhx471
	6aInRjKf2AlYng0VJ2Zozi/grhuHUdQAyYtkqi1QYiR5xYFhw0+9dXmpc69voDIcmF73URIrr0Z
	xgPESfFlxT92qIIDFVFbB262ivoA54ff6vqrgwGPhRuQWYNmurS7eQzBNU55Y15lZ20VbdsWy1H
	/Uj1TnFXDIIrX9hJn0isknM/n7aHnFxBAEvajubIhRiVtia/7LriRDy+R2BfpOspW2NL+Kg/2LN
	QXII2Sly5ZTHPu661hN8rxudwn6fEguJeT9Wk/kn4/cZzB3qS9InqMF9DtNSdhktlt5D9Ij/Bwu
	ktOkuISfyPPermjz1KrPdbvu0dATLfLPkhShpyFhapFOEhNaJ/VoX/lkb0kfqP9Q6sUDOhw5sny
	af5+71s/3GtL+Z8JE0gi1f3k8URsdnne1H5tXjgeCjV1bGQgI=
X-Received: by 2002:a17:90b:390f:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35e42749271mr24597965a91.12.1776345620366;
        Thu, 16 Apr 2026 06:20:20 -0700 (PDT)
Received: from localhost ([154.39.63.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cb874fsm2572877a91.8.2026.04.16.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:20:19 -0700 (PDT)
Date: Thu, 16 Apr 2026 21:20:16 +0800
From: chenqiwu <qiwuchen55@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH] zram: add accounting for incompressible pages
Message-ID: <20260416132016.GA3562@rlk>
References: <20260415104356.82248-1-qiwu.chen@transsion.com>
 <aeCKbSou1_JZw9UK@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeCKbSou1_JZw9UK@google.com>

On Thu, Apr 16, 2026 at 04:07:59PM +0900, Sergey Senozhatsky wrote:
> On (26/04/15 18:43), qiwu.chen wrote:
> > 1. Rename write_incompressible_page to write_huge_page since huge page
> > could be recompressed with secondary algorithms.
> 
> Please no. "huge_page" is the most confusing term that zram uses.
>
So what is differece between ZRAM_HUGE and ZRAM_INCOMPRESSIBLE?
In my opinion, the slot is marked as ZRAM_HUGE if primary algorithm
cannot compress the page. the slot is marked as ZRAM_INCOMPRESSIBLE
if scondary algorithms failed to recompress the page in a way that
condary algorithms failed to recompress the page.
The huge page could be recompressed with secondary algorithms with
a certain probability, so it should not be defined as incompressible page.
> > 2. Similar to huge page, add incompressible_pages accounting for current
> > incompressible pages, and incompressible_pages_since accounting for
> > incompressible pages since zram set up. The accounting value can be showed
> > by mm_stat.
> 
> What for?
Add accounting for ZRAM_INCOMPRESSIBLE pages showed by mm_stat, so we can get
how many pages is incompressiable in current system.
