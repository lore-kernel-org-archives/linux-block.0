Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA493EB80D
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450648; cv=none; b=pPa6gmCMYhi8PzPOcmaceZY4ggrJlrpLLd7Y0wfTVgyJx73jcRjLIlTM0MO8qPOh/bE9LzCanPzrZVtFs8j5KwuMYEmzmrCbiYaGh9COIR8fJ8SD3HHd8asA42jY/tuD0g1rjvJkyurz6/LpTzCILuManpwCpluRF+MQo5t51lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450648; c=relaxed/simple;
	bh=AK4dCqbAUhcU9U9zlTHsFM/7J9ww7ux/Ay+/TPUm1FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkm7bLemPOoFbYTFm9H/1FI5ZVonQrXV+b5DpfUCB5r9PF8tyYyf21gQ0yUgWMk6xLfFfxac1S32rpjOutRC65RpBbQhYDConjAP5SW2yWJweS/xlNw6AC9jW8cnfBLylqZdVG672vlk5wxTiPrJ/j7Zms59XqypBi4+DTEH0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGrfQuJM; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGrfQuJM"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-484ba8bc89eso4941916b6e.2
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779450646; x=1780055446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMvBHRXbHamfcvIBIjqq3V6B+miqzf3EJtFmf2UQX6g=;
        b=eGrfQuJMctWNbYww51GskatdzBghOaLkDwGneWysOkfcUXefJtrn/ifURRmBg2WDPA
         Ol5UdoNOqM3uObVwGVa9yu4wLiGm8c/+bVW/Wctb4inSh2SjhiSHDRb4Cd5MGtmiEwDY
         VdovRo7TIbXIfH1rdKp/H2IVgJvJsM1ynwNFGvKeaYHkqwsvhkPiMel7lpBeOCeE7ulo
         tfjMUy9PSdZb+ZiNsZjGldwtzgpOe8Lr3hv0Gwu0fc4D47kk0A1TnH7qT7HPO/rtHfhI
         P1mfE1DTEFKaPTGVppMHIrvtMLNLnYGF1HgaN+4h3q324/ODZihBP+F39TLp7ncLEe8C
         QbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779450646; x=1780055446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMvBHRXbHamfcvIBIjqq3V6B+miqzf3EJtFmf2UQX6g=;
        b=insc2Ra+gBVVLfpvMoZ4tpgmB7D3zyPWhXoymzO/n1zKHe+nT7/NDHVG7KsrNlQ1jG
         YesV1SvMQzwQc3iE39uc1VXsYXryq06WckefLyyvDvBY2eMIJsEtOydCIynA3Sf3/11v
         o8jLfPVbvTEn8RtoEaDnuyIQg15YLY5LkHNWodInoKz8wFPsVZFZmahVrQucTr+I8cYh
         2WOglbQV8Tfe+mjI8/gSD3XD/pN/dF1rLlnkInsyETzwibv6Xg88qonVCQmOPPqfWvp7
         ub9Bm5x9RG1SHxVrRlSg8Oo6h0aunL6M65WYGshlZveX6vYD2vVxfwL5XSoxJdAD2IgT
         6cBQ==
X-Forwarded-Encrypted: i=1; AFNElJ996bxy7o2mcslPql7iPuf4bGhN1axtyfIoCi8fhrfzVSbsJH+yyTWn6Hx0lJxwGsc+id6S1Spb31RwsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4SMRMykBxEkq8LUcuCPBcMffTJtAdid92/0CYAUs7ygufyRv
	/tW4+wHc46fvJowYlUX8V05OwzgML/4dajVSlousv7+Mk15nksarC9fS
X-Gm-Gg: Acq92OEuu25YXhGmw5Ujo912fkPM6plV42PWyU6LygZHQEC2Z5JHmpJ5CFbsgmJb69C
	gLLLmtXHq5d3cc7xGFw0AmaF9DOfJtJlIEJCHHGXA9+FpCZRfLYMjeWCZ4ucLbYuidWb9H/ZjHl
	aMziSKJ6pzeRCOq7pI8fZzIm0fhCQbo4YiqR0y9+z8n+kg9t1O5HxiCH6VFxeQ1tohqpA5F79Dk
	pCiv+ZSMHj4BZOuPW5b0xSUfsIiP/Wj9qM59vdwtrLo3BNoqrTHaHyHFOi7vArg5xD5J0jeFvZg
	FagrEf1NI6q92GCAzKa03pLT8xW7G8X8sJf6E6t1TJfV0myTUEvNc3L5iFOzDxmAuDLwLO8pbDv
	0aID8Q4MVV6bQ9wt6cqYwR/IyrpVL1FwmWZpr6u41tt1maC1UYPHDkthqsml4/1d271j4DSG1kg
	b2tMv1pt52EF1plP0PAWzyFbztp+CgV3mxaTA8spvs6fJfzGg9lHP3bf+Yh+hIcfkzhtJKvtGND
	SM3TE5iK0E2xil2rmsf
X-Received: by 2002:a05:6808:3a06:b0:467:112e:4590 with SMTP id 5614622812f47-4854a3fc839mr1789834b6e.46.1779450645872;
        Fri, 22 May 2026 04:50:45 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485545093cdsm418082b6e.6.2026.05.22.04.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:50:45 -0700 (PDT)
Date: Fri, 22 May 2026 19:50:38 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] loop: add sync_blockdev() in __loop_clr_fd() to prevent
 UAF
Message-ID: <ahBDDhq5FHIGgTia@fedora>
References: <20260522025451.845068-1-tom.leiming@gmail.com>
 <e4deece5-d866-4a44-9097-eaa1e2727c0b@I-love.SAKURA.ne.jp>
 <ag_RZc908B64hTFG@fedora>
 <7ef76131-d077-4cfc-80ab-69720a214a5c@I-love.SAKURA.ne.jp>
 <ahAjBvh8IfPCreRG@fedora>
 <3001ff83-b48c-47d0-aaf3-81a8d58a0a44@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3001ff83-b48c-47d0-aaf3-81a8d58a0a44@I-love.SAKURA.ne.jp>

On Fri, May 22, 2026 at 06:54:39PM +0900, Tetsuo Handa wrote:
> On 2026/05/22 18:33, Ming Lei wrote:
> > Please do take a look at the commit log of this one and commit 1fe0b1acb14d
> 
> My question is what commit broke "->release is only called after all outstanding
> I/O has completed" in the patch description of commit 1fe0b1acb14d ("loop: only
> freeze the queue in __loop_clr_fd when needed").

oops, 1fe0b1acb14d ("loop: only freeze the queue in __loop_clr_fd when needed") is actually
correct.

The issue must be from somewhere else(writeback?), given blkdev_put_whole() does
run blkdev_flush_mapping() before calling ->release(). If you or anyone
can reproduce it, the following debug patch may provide some hint:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..85f140c7f0a4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1855,6 +1855,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
        struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
        struct loop_device *lo = rq->q->queuedata;
 
+       WARN_ON_ONCE(!lo->lo_backing_file);
+
        blk_mq_start_request(rq);
 
        if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)


Thanks,
Ming
