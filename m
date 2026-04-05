Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD821B9F5
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775388564; cv=pass; b=F91HuxKqfOOIHCmu3O5jb7OEe3o0z9/OmejtkqfB/q7iu/scNIbdSZDmiGBpMXmAZIoba5xG0b26fqb/hLSo5FJsLNlMAbjiujSYBmQbQy5JU5mU5RI6hnNnnn+g9NbJc3CTRYTdlJ4Q4/y6M3Bz4DabO0lxpyvOERnXFw5rKF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775388564; c=relaxed/simple;
	bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRP0Lh4Osx6Z6bsV02PNIRtQ7gdvEtOilXvt3uMQTc2XCi5N0zupkAR4BtKvxCqQ1Tqf3LaP8W/uheKgc8jY5leCY2esn4ZcfoIU+mgLesyNiDceJQbZf3bAPb8vlQDapqOscRP7l4PP+8I5xmpn7kTU0p+7j6neKTuBznajN6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRwA5s6U; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRwA5s6U"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso668103866b.0
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 04:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388562; cv=none;
        d=google.com; s=arc-20240605;
        b=JRMoeDNT3kmHVz08dAQRGZnne+5hin+BRRJgBx3/rgWrPAv7lkHAlJyPD/KDD04AIH
         +rFAMSNboYyb+wfYD4G+2SuXoCenqnIHgZSEAPtBqqKNix/6jrbE8MWWWR8vZNBTsZWd
         XJz8CWVqNGRAgRYUmB6l1fspFelDdQxZGaO25daT1S1+xjvp1q2ayS1YGhuW1KfJFMI3
         FfXluFAXetAe49fFYqB0SCuhZz7eCrD17UPMFVSJyd/RBVAOgDyR5ZG2SE47Sjyah1ng
         PqAO404VGYFMSnHbctYdnnvSAycQlrFuNtj/2nzjgWtjDMnGHyrKbpAMzJrt3+kR2GCw
         K8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
        fh=cnlMi0Q4nCOIkmRiWnIk6Pc8b8WWoEZx4Mn4n1/UYnQ=;
        b=RGVn28ozqyBQEXG0SWRlRE6Zd27X0xU8ArLethikvfYJ4tOl2RMlpPdVZbIgGYKhsN
         5xEplSb1M7FoLyboST7iCW4JyUr7gDXgEu3kTryuQT/o8/1Fu+1oBsOtUZd4A0VQL6IV
         VsqJpEHcdIZEWexCepbSTPEC3udk4pWG+JIXgK9lkLVmsOfm3vwOp4rdqs3achnelvA8
         AYdizN1yIjCgj6Vzq/XQiWsEFYSJACzExnHqtm6DWLHNvWiYCEvIiACncLVWspnDn7gD
         z3qY0OasPAQiYQt611byk0PFv5wO/yCVG9Y+nfJi8tfOFbk37m8EuzFRGMwcEFfuPWGS
         8Y0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388562; x=1775993362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
        b=JRwA5s6Ulbe0lLrICQqrynQmDhtzK61AF5XFyUCmO6fy/fO1YsALAQe9WI+BMKVe3j
         RsUkW72bGHd42EfGq+3Sbg8RWfHn6QYDc9nD5axgVL8VuZM1Rf9ubELQUbqMfuh3l4GK
         AOHbwJHX4oLILy6EySOwINOllVqC4nJdt1JdxAWlHJBaQMAuDoZc7I7LPpVLhkyg0qzW
         cCSe8hLKbtmHjg4l6ylW+RN7yiEzJSpWDssteT7WzIicA3m5Blv7oigqfqeATzWh1cJK
         QgRQGxkbUh/ujn4QA4tBhI3nLBEVABlq8J2TiSwDguWL8TXFEpOm6YH5Im0f3oKSuu2n
         c2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388562; x=1775993362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
        b=CV+LEKklec0Qf3tuQwrfnoarSTzG3vIVoV5MGWHrfbMDQda+3JnBKRp37sk57xrBhf
         07DtAumB2Zjvkfdr+sZuuQ00TNxvK/vpKAGJcz2mJJ1ezolCqmji6YMF59JxWaeazLlP
         zIqTuHFQUzqiL3C8xmHZ4x/TDnGyFEBoUiHHZLIbLLbP65jTI6tjqBI1SNYaoxkiPGHL
         T1s8dJKu4bMW1A/CkOnVevTvCq0Km5nj6gSxuRTmw1ggynMUgmsoN1WDmmIvkWuBGDvU
         wvgXS6l97F1fj73131g0pujaPMzjsonKa2lkcGkLJyBcfyA/0FfJnpQaFVHrPP814ovK
         yUNw==
X-Forwarded-Encrypted: i=1; AJvYcCX2phQLbpxmhYLLqf/W3lBoJktQkrSPcMrLHrOVlv1I0k7pXR42wKEbFgmFnDFTZjaVSoTR/qAveGEr9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpmlR1llMAQqEPcuNrUWY9wAsBBF3BSoxOpIESNgcQt8BL7eK
	qu5p4dYjFg5eCcMPvgDxgTSLDwnv5+H+NXusqL9Fof16xXzZZ2p9Jq2udz5tRnxFoEC1gjU4M2G
	Wfvxy6PQ6ZL9EoRGUEgXPkk9XRR2rZw==
X-Gm-Gg: AeBDietP4c6eeAMuCKD+3y1sdbiKUO8Me8a12hVVowVnBz7/ciYqufJ1kXov0Ccb8hS
	zEsdn7vIpGAqqFOeILM7gjf1RRR96D0ewDkVRh1+WOqHpytxUcMmxqpm7DC383D4Pprktna9TO0
	xS+lJ8RbOBzaWU+gQCv1bvtJRfheROuyLbrjfaJij4cvpfrGHGB2y6uwwf+eKZE/t41fULIFgdX
	uc4qaMM4bDwie1hMwWjwz3yHD3WPMWmnR/Mh0Q77PhVS4buiHZjHVsMXsr3rsx5Wx7Fb948bNBS
	FzqGJIfa74w81yYR2fXSIeOdhjnbdaVzYuKxHqFX4vxykDcHdNLhpIw/RFwx2vliQEB1RQ==
X-Received: by 2002:a17:907:96a0:b0:b97:b149:4e72 with SMTP id
 a640c23a62f3a-b9c4713a360mr613633166b.28.1775388561627; Sun, 05 Apr 2026
 04:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-4-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-4-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:58:43 +0530
X-Gm-Features: AQROBzBzw9s6pxMkbcgpTMX5W8n4QANeXDJvCU5tpcGpnilon7LOxG0WvSR_FnA
Message-ID: <CACzX3At16V+ZLqoWh4UNEJ6p60x94x66HxzTtPUuJ+KWxs4AXQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] bio-integrity-fs: pass data iter to bio_integrity_verify()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> bio_integrity_verify() expects the passed struct bvec_iter to be an
> iterator over bio data, not integrity. So construct a separate data
> bvec_iter without the bio_integrity_bytes() conversion and pass it to
> bio_integrity_verify() instead of bip_iter.

Good catch!
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
