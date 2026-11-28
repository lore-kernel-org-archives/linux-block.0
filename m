Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830798;
	b=UxoUDoRk5/m5s6YWdFdzWc8FGKt6mZ2Yr3OYvfidzpLIUHxI2CH2yHnBQemkeJjZTh1X
	 xoYO68fnV3BsENDYxmfSlyd1N3mXvCJwBMnIEvfeNb4L5ni9geMYSH114Uv97FaexhUz+
	 IoZ9XMWqy7NomOH00fPD66IiuDT3Iq0MM0coIHEVi4rh48mGFGsCe/6HXEeEeC+JDhncn
	 w6XCiJwWKGONx18XcWtZwrU4EiunxFYWYUf2z++D3kyeiSOeKVwiyaITCetdOKKaf4RAE
	 mMwpvkkVoxuTBFjbSoW2Yu5zAt06l1/g/bkmlAm4niT1jdcQ/nD1ruuOl612/Qvpgww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hyZ/R6k/xIQG/tPusrclgUu0QXpjH1Ks1DGOLNZIqaE=;
	b=pixP4wtzQSXCzAEDROsYMNx3l6Bqh+uAxM1soZWwk9KOT5PKfZgUJKAgSN7tsicvDEKf
	 gYvA1bpDcmhtIufHcJVSDPAiM2lTshQ/WztjkeEIAtcIYRNCJd4stUfUt+eAirBgVd382
	 mpq/8QeH0DB+WvZq+lbo5S7s0KEWQoscMtxMIwUZtOZk7WOqHj4o9e0J8eKReA4sW3cWV
	 KhTmfa7xocPVx47fFS5XDmC8RPxgLAvFUPFKAZU0cONkvRx9JoIEdMCUTHqnfNCF0bXy9
	 39m788p8ywYQli2rUdOTjFRxbyyj71vcvTdysqc73gbCbo6s2fuB8TX5AUjQYgIg45A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Nxjnecsu;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD71606A31C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 01:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Nxjnecsu
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f01f296937so64573535ad.3
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 17:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795830797; x=1796435597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hyZ/R6k/xIQG/tPusrclgUu0QXpjH1Ks1DGOLNZIqaE=;
        b=Nxjnecsu6920Ks6n62WNYxsEUypFF6bQ4PVVqgMR71ygzC0qwyH71uv4eZqSNRSWY1
         9HZTHm0nxweCElYkCDv7qqBTmH71Rt34D/+DrKSqZuWa3AGay1gk+vlBW14bX7ZRG4Sj
         v+0UYv1j3SJ7rJYcmzjgk1eK3+RYZzcPWU98o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830797; x=1796435597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyZ/R6k/xIQG/tPusrclgUu0QXpjH1Ks1DGOLNZIqaE=;
        b=XQWr8i02HiH0eVEoEDqSBLU93K7vJz/8sw7dO82vI5druoktWfALrJKlpAFdXjymlH
         sOKi530321MpGlQGe9IOdssuqhMm7VHpcuLdGJde/ATDoyoOCiSDRHqGiCSReV9+jFS6
         j2m+WM2NP1IbhaCu9WoLZeSGUx4QtZ9BDnB8QzMlMaviBtLKPVJDje5vf2m14FfaJTM0
         DIgyFhNqu35U9M2Zbq6JeiQJL6WeFZtFnBCngPpDWuDoc0hcU+HllABZedQnyLJhKayB
         o3DalGFv273rRENhqO2uZUBAnLEtAzELoBKVEdJHYWXHTNj0cPj/fI/SdpUnEWqAZdz9
         5SDw==
X-Forwarded-Encrypted: i=1; AL+hErFcId+38l41hg9YOvfZNpaQ/8a9NQ2dOjY11EU0K/Ao/cFzWhqJS8VwRKybE4BXdeM+cZBSnTlYCDgr0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zmFMzgXNZAwuklhmMUoUUYSGSxmfG/JKlDUD4BVmI+30OVV1D
	Uc/DbIxI/0qGIiU0FO5rk8UG0vGH3wjmHYORAaGlMnhTXlFAVSwX/W0jhkuGmOpcHg==
X-Gm-Gg: AZFdTZdgprYg6rm3f36m7NwPlSt4W50p/0wdrg9Y/xsUPeIJxVxTDmDDTQ+1cIPADSn
	BnCFQ+68LuYcuSZcYJrmVnzF5zx8jmfjASG/y071vxBInkpZb1Wfp7RQ4sOVDdbQpRQoB7c/vl0
	baVqut6WyT7CSv832hOD5bNuFRozStI5FwP6Oqe0DWNu4C882TWH3t6X+FLuOy1zc+pMTCxx6RF
	YuoGgq7b3ugLnecVi16UMAntp4svlHdpwRo/lsmiOzP+E+yrcHttq1qe47mI9VhQeecsaqqnvUr
	ZBU9cW7r8CrCaB/ZCG2m4P48u0nLH1HC/ho6Q7LrpaD9OnGhN+bbMvWAJaQHsMx4p9zisnCWde1
	HLEqQLzxkY/tqlYqWl+T6yAaNOcU8v4wbodOitYdyg/1JJUREKjK9U4A/7XCRm8jPZgp77Va0lc
	g6keuUaBJpAlG6giARWy4YPIuKWuINInvo9QCla8/gRDvzpVH2xdcp7L1yjA9AKentqI/B7VyZP
	dlIE9BAl+n1+IizpTqvbyGWO/+Y3zKKbvMCv+nwddIjKaqVpUIqk8HFsRkzzt/N+01EUjGh5PNX
	vYXHa99p9KPDJrThFRFg4uNchJCFUr5HXhYZ5Zkrnra2k06OBesQf1izAzENqWOoARi54g==
X-Received: by 2002:a17:90b:3d4d:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3b41c90329emr26496488a91.30.1795830797454;
        Fri, 27 Nov 2026 17:53:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:6b7e:ff5:f0cb:5bb0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm24769916a91.5.2026.11.27.17.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:53:15 -0800 (PST)
Date: Sat, 28 Nov 2026 10:53:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: SJ Park <sj@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add mm and block lists to zram entry
Message-ID: <awozzzB7zkfAVBqE@google.com>
References: <20261127031658.2049871-1-senozhatsky@chromium.org>
 <20261127185347.87793-1-sj@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127185347.87793-1-sj@kernel.org>

On (26/11/27 10:53), SJ Park wrote:
> On Fri, 27 Nov 2026 12:16:38 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > Route zram patches via linux-mm and linux-block lists,
> > rather than through the generic linux-kernel.
> > 
> > While at it, fix a DRVIER typo.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[.]

> >  
> > -ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
> > +ZRAM COMPRESSED RAM BLOCK DEVICE DRIVER
> 
> Thinking loud.  I was wondering what is changed here.  I found it is fixing the
> typo: s/drvier/driver/.

It is mentioned in the commit message, the last sentence :)
