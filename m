Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C73112B2
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667496; cv=pass; b=QOY2lxzOCW848j0pPSE0BRsvzfBLzi7zzw8arMN8YNM00WXbbjDfi9P0SWNNevtwiNXjWR266Xw7gezHj1tH5tTlCDz5+5TW9w6DgyP6olSkPaGQPZo90YU2QT0NphWXNErktn/CsI+o6o0zLQQ7v6Tn3wY05pvDMn4kX//lFAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667496; c=relaxed/simple;
	bh=1yTH6q/Zk3xLhx171J07NxWvGjiKAaCvxSCklaLl/10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOfMK5Klqy84xxh5MEdNLv/siPaQgmxtwP9PsttVq242eBw/KjFtHNw3KtPKh+WaMFlHgmHs1AgVeg0bqc3ECqsMXVTWW8FvQIbO5wupfB21GNgtMqoR7bXmBcBuXt6FfDlWN6G4+B4+ZWvthsobe59iXa3FPnX1Nu0wo/9kYS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXYJt38k; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXYJt38k"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39657d28132so39652921fa.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 20:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781667493; cv=none;
        d=google.com; s=arc-20240605;
        b=h6xf6Hleo+o/uzU9HyU5ztQ8xkZ8tNURLhTu2kQhxCtd13wY+DZvFFR6ml1Q9BGtI1
         tKw8rR+L4U+/6B6JyylkrRG59/kAnrnswq9dFn/A4KoUiIg3PrEH+RGp2huqia4frjqM
         fshXktJU1GCt47ICcfaK1XwvcSWkD0Gt/Et3FAyTxsygHrAQSwi4Q5orQjsKTZU0lGHu
         XhcmChqKEFV1Q3bIQhsUv1NlqxsTkETg2Ppy6bIes5/WQq5rXWVnZiqhI2+sRvVjgw0R
         dexaRetzrVd9u0uTCXOITzKOvADsFQPFMdv01IeCGk8iIKOScCOTmIsj060y4E+gkzHq
         rXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ml3xcOh2MxfIz5ly++h37MpYhzCflCK0dlrikZM10nE=;
        fh=ojBzWGV/KQZon5vB/wFAR6Od0SB+LP81XTt2xyB+A7I=;
        b=NHgh7eWca23hcLzVPNpMi9AjXmW0F5f1ECPMY2+etkoTCQpovF9DJtbpQW0LmR9tbf
         SJuFMdQCepqh+Qdws2lNt3DJ5qDVSAEmHws2znaV7Jtf+fUiI4tadR7lc5VsxsBzKZrc
         Wg3BJgfCc6nzMl2dQAVKM9OT9ua/fZ7nJpWyA9iDGb5ICqvcqUxKOUqVy/yIrIKwdGx5
         6mzO3oZydZgMPeE3XpmxivXlSCpMHavBhB9ri8wOdBKCZ52IQ13HBSuy5l2yQPSqxTei
         ZC1FRyC24v8V3ofROdZqiBd8R0Q2iRVKur8Udd3wH4sYKp1ie0c74mgm3+7xRMvDnLgp
         pfig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781667493; x=1782272293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ml3xcOh2MxfIz5ly++h37MpYhzCflCK0dlrikZM10nE=;
        b=fXYJt38khkmWe722WONWLmEGwvPXRATReoUQ7bMUORtbLjv7adU+Cf2ro+yGg2qTLc
         DhcOdhxKtO5r1QR8v5740T11YNpv4iNzfxOY7F9m4kgGAP7YlS8seIhMPi+wKTer5nwH
         XPSSZGnPMSZPTuoauB97M4YzBVaZPgIlzL6omsDF/kYPK7dFwtdvPZ2cf05TAV7FeOtl
         Lx4dnvFNNB413JD+t/U2g3EEoY9s5QbwvsiuhNDxMcMpY4hC7NvnWvQYdavuVS0EsKoi
         YF308RtlxZD5a1gXA2XQFJWXYEEto8tYQOy2Y2LqNG04vamME496yFoGUZkFaa9+hkKg
         Eycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781667493; x=1782272293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml3xcOh2MxfIz5ly++h37MpYhzCflCK0dlrikZM10nE=;
        b=FGBFpeOu4wMIC+X15LUkMav5WE7JMMj4KCW5zBkL3A3ieCKrL26ah1aYwkfW5egoF2
         07YsQyQYXTMu/lf1RAl3iEjWDagBArrUMCXS7wcZPVmnlSSCS5YofpHrWuMirVBJzivY
         Nuaf5k5rnNUyjjT9h79Tkh8GpluvYLlfvSG2cng9vfpZUrJP399/IOTfZYRR9HU5r6k+
         HvbBAxRedldXtnPPBMnTO2u5Il+KZYibVZm421iiUeiZ+l6shXye00iuDuUQ1TKthPNB
         sG24eFLsT0R8h82JU1NY6sg1uzafm8fqvAHttqGmHTq1No363vZzEUsFJkYFIyq+TLPn
         Ed7g==
X-Forwarded-Encrypted: i=1; AFNElJ+bU2X+9p5sxBES32lTUiMyvwY3zNEARqT5rQbHcfKtCf1Cb/6EAzKtonMRRprI4kI8jbSlryfYZ0gBlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tc6PvALDnEFwYwEC50OR/o400sqYL1O3QKsPSiaG6iRKLfM6
	3Z1xu5Dp//L4Iglg6O75xYuvQeckuAKj52Cvl5OUO7UIss2kmmhOr+yDx46fR0Y9QdAWtiJbztL
	3ERcUCyZX+Fso2vMBOH3H3AVW4f/gapA=
X-Gm-Gg: Acq92OG07aPxS0V0d//CIhsAUhpPyEsgHhVLxWfiGPpY21UgZQn4K8x1dzEIv1YdXfp
	GVaRhYyK0C35g3J3JCSsDeDMODDTECqopLOdc5cz944bVxx4CDFkrAF4RZacnggkQchlmGJlE3f
	9woYTu/bJQMrGoyx4fuhs9DlOW0zeCkrZLm/oP4dy24MCQbwL/1rHvYJxb5SInBgLhjSY09TMAb
	innWhhRfRzQP0BJ6NmwUG88NPQ4QUyYSmSn28v8AM6+X8Kb9M7B7E8eAb+8KS8Mjla1Mst+WecD
	M2En5WYt/Kz3ExCniMTExTSW2w==
X-Received: by 2002:a05:6512:3990:b0:5aa:500f:7bae with SMTP id
 2adb3069b0e04-5ad4701aa1cmr506325e87.35.1781667493023; Tue, 16 Jun 2026
 20:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260616123646.GB21024@lst.de>
In-Reply-To: <20260616123646.GB21024@lst.de>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Wed, 17 Jun 2026 11:38:02 +0800
X-Gm-Features: AVVi8CciGk9AEKRBRV_ut2Q8RKhgWQ0siGiHzajgiKnai1OCYfaSoTtY1t2d4Zw
Message-ID: <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

Thanks for the feedback.

> I fear this is going entirely in the wrong direction.
OK. I was trying to build on your swap_iocb / swap_ops rework
for the zram swap path, but I take your point that compressed swap can
be handled more nicely.

> Yes, we have to keep zram around as a legacy interface for now,
> but the right place to deal with compressed swap is in the core.
I agree compressed swap belongs in the core is better, so not only ram,
but also the block layer can use it.

Before I rework or drop the RFC, could you outline how you see that
core-side model working? In particular:
  - How should a compressed backend like zram or future block device
    plug into swap_iocb / swap_ops?
  - What role do you expect zram to keep while the legacy block interface
    remains: current block swap only, or something else?

I am open to reworking the series toward a core-based approach once
the intended direction is clearer.

Thanks,
Jianyue
