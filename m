Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C51940AA
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106140; cv=none; b=Uwae7c7LA8BPeFYjpL1wLPUKHzOWKv8kt1zL38LHYcSnoefqkjKQUBV1hmZvdWKwLB+mTk1DtYqIY7ok5Pf+U+4sLlBQAXGZPnI3r3XIgn6eraG8xtAgFarOoYOrAOCnikCyuqliy2c9SbZrk8Y0LzagDDmtxYysSndAM4h3P4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106140; c=relaxed/simple;
	bh=3Q5rxwHj3JGxVIbkrTDsygr7k3PWWTVyU46YCgH2IqI=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jj6hZ8LuwUBwgJUdsHni5Ug5ueVhzQzK5xJXHsqTiK1Wh5GeYZl9g7TxRdC3+Zkyo6Cpt7xA9GguEDmOSjQ14RjOsS9b4uyv/5cEZ6eud2NTUBz/tCMNz7j1pZW68tM8Pu9acKQj1okNiiQt9TdrGRGs1ooIufjqv1VR6Uq0yD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LLD8bCkJ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLD8bCkJ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-277f35c01f5so2263225fac.0
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727106137; x=1727710937; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4psRH9uvTvZ+EcppbtddhdemTURw3wm4/GpZ5POPFI=;
        b=LLD8bCkJOvqGj9e4bMiyRufcefLoRwR2QV4ScCqvboHFKIrlsITBln7+VQ3WcDsQnz
         mzXxb3SJKZqYYpQ3I5Yk72WjoFzu08K0Mr9QAGRyKa2stTASES7yxA188jBLNsse413D
         3oVibPmYUY36iOpKlHny1PHmRq/DoqQy5bb6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106137; x=1727710937;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4psRH9uvTvZ+EcppbtddhdemTURw3wm4/GpZ5POPFI=;
        b=U2xoxTF21ufS3DrsuOkfg3i22aqj6u7qmI2/VS16fQF4/V9qDVulxz+xQIgeWvDSIm
         EaN1SdjyMieBRx6jtQkBqhsUNTAYSRp/oBzRkIPzT0fpc06RHz/BYDmvjM+7UXVTiwx5
         KNfv3VaCldHKE3JylutcsvA6+SluIhA11fRjP1oU6FlvCP5EUquKcZZavwdE2iN10KOy
         suiYy2Y0SkZpQVRX9DSjTNYmutp6QlOknHR5iC4YmHuYaSd1hbzloTnE88zZR2ayUqeQ
         5kF0t2Y1R17zdrMP3sP+uZ8NoMwebRBAD/5k9XAI6uqn7tqe39Wdmdb3iyy5QH1kF1LY
         nSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwAFE6nS0b5SMcHs8ndD+Oj5ub2/nHg4LHmi0dS2l/ppeA0N0LAlsE0DkiF1Mlu7B8A0fXM+vdbyHZoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3pq98fx7aIaN/ZDzY8Z0H2sZacgNEMYf1MDBXLm1C0zGIpXz
	OwUoIxF2v6RPGchtKbOcsfkVVlYWwNQz6DQSWGD8QXJJ96h3KqFSd/INW+LoQA==
X-Google-Smtp-Source: AGHT+IGLrt1SdhW3xWs5HczP5HQsxOV2tK1fkasmItJ6/En3/5xyUcP+o7dkEkQDL7Hn6T6uDllS4w==
X-Received: by 2002:a05:6870:344b:b0:277:e868:334f with SMTP id 586e51a60fabf-2803a7b8503mr9722097fac.34.1727106137629;
        Mon, 23 Sep 2024 08:42:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498fb730sm15502664a12.28.2024.09.23.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:42:17 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:42:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Message-ID: <20240923154212.GD38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bcc: 
Subject: Re: [PATCH] zram: don't free statically defined names
Reply-To: 
In-Reply-To: <20240923153449.GC38742@google.com>

Cc-ing Venkat Rao Bagalkote

On (24/09/24 00:34), Sergey Senozhatsky wrote:
> >  	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -		kfree(zram->comp_algs[prio]);
> > +		/* Do not free statically defined compression algorithms */
> 
> We probably don't really need this comment.
> 
> > +		if (zram->comp_algs[prio] != default_compressor)
> > +			kfree(zram->comp_algs[prio]);
> >  		zram->comp_algs[prio] = NULL;
> >  	}
> 
> OK, so... I wonder how do you get a `default_compressor` on a
> non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
> 
> I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> and below.  As far as I can tell, we only do this:
> 
> 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
> 
> in zram_reset_device() and zram_add().  So, how does it end up in
> ZRAM_SECONDARY_COMP...

Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
Yeah, that all makes sense now, I haven't thought about it.

Can you please send v2 (with the feedback resolved).
