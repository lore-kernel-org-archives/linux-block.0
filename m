Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43B8C07
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107635; cv=none; b=ctMpX98nDnMURuGxFh/hpPfRyyVUKXWaWQp4PUPjBhPkzkyC+oO5akwoilxYpbDchHh5dOVcA6VhoiaPZYdFES/5Dc8fhGlpb2+PIgsTr4uW19kugQHLI1EeTrPLTEYxUEtylNTycsApJYkXv6+R7+nkja0+E3SAhLVe3g5m9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107635; c=relaxed/simple;
	bh=io0wtu1A1TSf7wRAKGNdxYAnt/sSmQJGme+MaTWCvTI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDV5jK63yWnLX46eWtzcaNPv1Zwj4BCHcjFwr/Cx2RZThauhqUw6yrZseNBA+h1w3NqemxswMe7wD8JhMQygw5oSjEuGWCVem9Fg1wA0boyC33bO4YITzq+EZnaJo+FqIKq0ECU1oCorGwUIOcn/thG13ChzBgcTnbAgWQIONF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bRanfLQ0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bRanfLQ0"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20551e2f1f8so51811375ad.2
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727107634; x=1727712434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luVqXc9KhZ7w9GnaoZ8AJsYpfSpZXWCjEZPblg+iJTI=;
        b=bRanfLQ0X9n6wbYLCW+OIt6B3c/XIVbcVyPMqlAjos+CLR1TSmiGLwzYr8kiRAeX10
         a75dwNe4mYHs6xvnrAGToOyhGfGP1iK6/LqoeXlCApuK5X2I5H6ZacKq+iBaMtwPdAGN
         jHtmp1Yx6D+xDGTMTW2IAE2eYRxJxhpqM5EHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107634; x=1727712434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luVqXc9KhZ7w9GnaoZ8AJsYpfSpZXWCjEZPblg+iJTI=;
        b=FN2aOqblxA/nKQBQBlJfMw7JpNy21RNgbKD+Z3wGTM8fgA9mzUVW6umFAx/S/Lr+d5
         jaGmMXfBRtgnBQXHy/Snr7KLcABGRU2cWo8fOE1TCutaMvE7QoSrN0hpfiVXZ5GOdRD0
         aapfRibZdtVifqhkMze7edXxYgyJcaQFVM5FUEzU1nqBOlmZgKLN6daWDjwKE1AIR+t+
         kbTlGWVEo4qHC8zlXlZcamnvF9Q+tDcOhalu46yIzDOjj9wLKDg8SctMdHuOTZhOaghG
         QG32TQosAkGFTDwbDQ93KDFjeqlevHPRbdd+3N11Q9ngMcD5NASmQZYJl2wfCtngUCIj
         M58g==
X-Forwarded-Encrypted: i=1; AJvYcCWMoffnLEqS41zqYXdBKHiUzMSfuZrQd+a+6PihSonP4GsLZSXPLVqTPqwGvx0q+DZrq5RGJk3bu3jmKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuoquhWI9+kSKUCKL3BCuovo4TMuJdPvuEyzMebzegt8TlyTU
	623xQ3grqVTD6L2pFkn/YL1xgPgZSE0CDRJmJhgWAipZ+rOb5PWJ0Kbj/Ia9PA==
X-Google-Smtp-Source: AGHT+IEpWt+Yy/foLprnpWvGJjXJMBC5m7xUsq8mQSapGDmYrszgCQYOF2JuiDfYnXM1Attzl0G3Dw==
X-Received: by 2002:a17:903:1c9:b0:206:99a8:525f with SMTP id d9443c01a7336-208d8338b2dmr229794215ad.4.1727107633696;
        Mon, 23 Sep 2024 09:07:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946016cesm134680625ad.97.2024.09.23.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:07:13 -0700 (PDT)
Date: Tue, 24 Sep 2024 01:07:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <20240923160708.GF38742@google.com>
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com>
 <20240923154738.GE38742@google.com>
 <ZvGPWaXm26iq-8TI@skv.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvGPWaXm26iq-8TI@skv.local>

On (24/09/23 18:55), Andrey Skvortsov wrote:
[..]
> > Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
> > so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
> > Yeah, that all makes sense now, I haven't thought about it.
> 
> yes, I don't have CONFIG_ZRAM_MULTI_COMP set. I'll include your
> comment into commit description for v2.

Thanks.

Can you do it something like the diff below?  Let's iterate
->comp_algs from ZRAM_PRIMARY_COMP.  I don't really mind the
"Do not free statically defined" comment, up to you.

And the commit message probably can stay that: on !CONFIG_ZRAM_MULTI_COMP
systems ZRAM_SECONDARY_COMP can hold default_compressor, because it's
the same offset as ZRAM_PRIMARY_COMP, so we need to make sure that we
don't attempt to kfree() the statically defined comp name.

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c3d245617083..ad9c9bc3ccfc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
                zram->num_active_comps--;
        }
 
-       for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
-               kfree(zram->comp_algs[prio]);
+       for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+               /* Do not free statically defined compression algorithms */
+               if (zram->comp_algs[prio] != default_compressor)
+                       kfree(zram->comp_algs[prio]);
                zram->comp_algs[prio] = NULL;
        }
