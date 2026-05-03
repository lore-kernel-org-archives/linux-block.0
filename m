Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2D221277
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777820522; cv=none; b=qr9fxWcevbRs3cFikN1ZiXTepp9IPYDJD6b40SlNXYpx08wFsgZ9utz5Zmd88CIl28U9a+Bq2IrHuN83meMHf/d8KOacDoIZ08BNQAb2ybFNIiFNEzrHcIhUb82KiU3FKtWOCxUaTmqZFTxVx2ohSqDhelgNDBV/30iywK5awzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777820522; c=relaxed/simple;
	bh=mxiuTSM74D+CaLeXfgdYtfifPRbcHdaHlRBKwbBo1qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTBMeODHqI8q0uHyF29KuBNdmwfqOi30UeLJggItbCF56jhW3chBY2Z7KMU50DjDpYBu9Tcl/7O7Fd7bqjxSyPrLwcAL9VzHEfHTNVkqt63LiQGkUMvk2+0/ZNLM0eKYCl5oh5iOTn+85/DXQ/BPhce7nrRG7RmnHUufOVF/XGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezzCAw2O; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezzCAw2O"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso22545ad.1
        for <linux-block@vger.kernel.org>; Sun, 03 May 2026 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777820520; x=1778425320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnGRoHJD9DIK5jxS2cgW0aYU1wp8JHRLjsfyg7b6pV0=;
        b=ezzCAw2OfpHY9PBHeNatHTb21QbIJoSO7qETLbtH7vL4gjJT9wuFEq8UqmpWSznkQ8
         m0Y4fUj5DX+NCz8zqj7g6V1/0CI9v9cmlQf7L/0eGa7vWO/dv/y8ViLJ+ddBVJZsHpuB
         wRVgCUjXOj6I0iZj356emwZQ6tJkzm/5LEG6iUFc6AUIqCpEHpUDQ+k4TfH/LiwK5fZv
         RaXs8E08Ljt0DhCAz139jbKQnDLU5Kf/bHjyxEV+jnWBKnUODfBgGGVoOQkEY5Umh7vq
         /CpmA33/cbvt3/ITUs2XtcKXZTaKxZjXi9MPGzp55xLsJBsTiGRFuubZ63iwjZ40tfUM
         6DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777820520; x=1778425320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnGRoHJD9DIK5jxS2cgW0aYU1wp8JHRLjsfyg7b6pV0=;
        b=Ow76dszp35aTYXCBeI7iBicH3pxCuU9dygl1fzcf+Zhzqyazn3mEQjyPr7fB3mBs+b
         mONOQLjiGOIEONZkdko3ZF0HD3rw3YWMUxlxMIA4cAiqmuMqLodA8xu6LdabaB5qgRiW
         WcOp4G88uimhWTnuXFYcMkULFeiD9d1HLn2nc+xAcqBqGNa9+9POtYq6BBwQezQj8TVE
         MqdX4LURjdsgdv23yPDIaqjz7DWH9mkG8kYlDaiACntWPf0gnrfjZEtpPgSufAuAKI9u
         oUJ9MF+BjdXA6bXWl8SYwo68qFyhvM4vbjqRUHYwbwkEswkW729Q0OCd3M4CajuShgFY
         AxHQ==
X-Forwarded-Encrypted: i=1; AFNElJ900oP0ydKN5Ij2xtmL/mhaq5MNyC1rN/TVWaYkOAQR1m+3NNNubXPcrcOjLytvGRFzw7YY/f2iHw0enA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1iGa4qknAEyjDe7ZE6+Zo4G/gEZvECoiQNjItOf/M++IBQkZ
	0uek7QNa6VzJtywXEqtQ0HNdByG7b6hAKdqbCo5dwHwn/D9IoJuXfzlQ/SXJNphfYd+40F84y1k
	yDetlRw==
X-Gm-Gg: AeBDiet737K13keAXqyMWNI+oXWm9sz2V31SVr8tn+Ya2mBcNhXwHLuFgz/DraaZD8z
	tyOlyOCey7KyOLBFbka/5MuvcpWsLhWkw/W+y90539HL6Tb5B4lHagZpzZXmsfimmtMZEBx+6J2
	23nejXpfNF9VNziFnm5lGm0j8PTeH7yFHdjdWGadhZOLY8fDR4hLwhaS4E4c6APJsTGAnXN4HVP
	rFEfwE9/Zz+TcNdp4AZKeQzuUCFwuyY0p2BS2upDCmah8upmBfWwka2bXceBz3f2tmgv7NZBNEq
	ESEPGg1zoVmSzNm+hpr83gfkzWlHXrKNMUj/7TbDHIWZw6BMBuyvrrao6Q4D/mnvrmqSCee1TgE
	MIOsd3H4l0UQEJ0nNTf5oAbXmCP73TQ1mrI2kckA4G3rqrOGZfxeeYdu0QczAQhuypY9dzz9R9r
	ybMFA9Awo89y7ZUrqsCMhiGccvGcStB8N7bD1aLA9ovk+E6oEWyFm7VMeicFK4QRo7zYS6Vtmoc
	5W9O/EIfp6mxsg1sdSa7pTwYkD7C5Xto1d92/5nHNa6d25cqR82RaNS7b/6Qpx6zy7Cd2/84n2e
	6g==
X-Received: by 2002:a17:903:3c2e:b0:294:ecba:c8e with SMTP id d9443c01a7336-2b9f5801b67mr2523835ad.3.1777820519037;
        Sun, 03 May 2026 08:01:59 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f488df2fsm3665907a91.6.2026.05.03.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:01:58 -0700 (PDT)
Date: Sun, 3 May 2026 15:01:53 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: restore mempool reserves for non-block
Message-ID: <afdjYQ1szt_ovq_k@google.com>
References: <20260503001734.858296-1-cmllamas@google.com>
 <d8a4d967-ca1b-421c-a452-d440df9535f2@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a4d967-ca1b-421c-a452-d440df9535f2@acm.org>

On Sun, May 03, 2026 at 06:26:48AM +0200, Bart Van Assche wrote:
> On 5/3/26 2:17 AM, Carlos Llamas wrote:
> > Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
> 
> Hi Carlos,
> 
> Please help with verifying whether this patch series is sufficient:
> Christoph Hellwig, fix /dev/sg allocation failures register, April 15.
> This patch series can be found by searching for "b520c4eef83d" on
> lore.kernel.org.

Hey Bart,

I did look for fixes but I totally missed commit 7b03c93d2beb ("scsi:
sg: Don't use GFP_ATOMIC in sg_start_req()") from mkp tree. Sorry, this
patch definitely fixes the issue I'm facing. Thanks!

I actually started with this same approach as there was no apparent
reason for using GFP_ATOMIC in sg_start_req(), there is even another
might-sleep call with scsi_alloc_request() a few lines above.

However, it seemed odd to me that after removing the check added by
Christoph the mempool allocation would succeed. So there was something
else besides a failed slab request that made it work. That is how I
eventually found out about the mempool reserves.

My (very limited) understanding is that mempool_alloc() attempts to
allocate in the following order: (1) from the slab cache, (2) mempool
reserves and finally (3) sleep and wait. In this scenario, we now that
(1) has failed and (3) is not an option because of no-block flags.
However, mempool reserves are still a valid option.

Anyway, I just wanted to point that out in case the check needs to be
revisited. I'll cherry-pick the fix from Martin's tree for now.

Cheers!
--
Carlos Llamas
