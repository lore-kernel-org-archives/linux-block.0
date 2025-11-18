Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345D21FF33
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437645; cv=none; b=BKzXDzz+okyDV1j/tP2MYBmVCcX8uwcEE4nQWy+Zs7kfe8vNE5uEDdQngxWntx1bB3wgrVeqfIufdLivwtqbo3YiYXbhrfa0bPc2K5YCIzuVYfjvITeZgLFwH4cLUX/peUo01h6K03ioJMI06hEpWDFl+pAkoq4N3l1galt8v5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437645; c=relaxed/simple;
	bh=RJmqJT+1YXpdaH+yrpEAKloAxtwkmlQBjTbZQ8AGbC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyVTaUzf5uLJy1EENNCKbydHYS96AnbSXM7CckkStErfp6Tg0Slxaf6fjGcnpsjEfGJm/63B5zbicvff9mIJ7oddXBSrZS3kkV1V0bPQ7hudmd7LxhpyjnFSh0u5tqsElr6wnFFW++mVexuYzl6LlLWceSLc1k69EKmQYObSO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DcrH754G; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcrH754G"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34101107cc8so4439167a91.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 19:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763437643; x=1764042443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEq4jkpDrS/8x8zOSTD+sdvZrjiLgYoxLssD/Mj00wQ=;
        b=DcrH754GDZffYqxtBS8+VHMJFoyXNhAG8jBi1LeK4CK7g1lL9BnD4U/RA7GJieXN+E
         xjndA5kV8pvOhbKJYbCXjBl2Sz7kD9WgZiwiYUbXuAcf7yza6L7RmqWgpPeHry2ImoTL
         R8m26otofsnM2pEqTI+gjREaXIe8KKlJH72c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763437643; x=1764042443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEq4jkpDrS/8x8zOSTD+sdvZrjiLgYoxLssD/Mj00wQ=;
        b=GaE1dMdtrRzQJgMuv6zBUPS7KWXNdX2RDttCRud84KLABKgb5o2ZH7wo2lDG4jzErz
         x9a/ddWfZs8ZdRLup7AB+J3YcGjaVvxvmvM3rTM/tuuh/S1VeHM5N84mXvxzkOirMUVy
         fjsDoVEBftVYTiQZ40R1iA+Fulxe5vdM1ib89E6cAOHXeSc7p20wRNyPVX2nnhJBu2Z0
         /0J2/oGkWl2evZJBpcofBqB9op4PEWCiXefr6efqjUHGBeDBcZGLjKwjs027fkiTWJXg
         0LCdCfrWUwUZ9EKqQZGLfuMB4B/RU138OqHfv6pTCMD4FqfvMsA96qK1ZjMKCmxt3xK9
         mp/g==
X-Forwarded-Encrypted: i=1; AJvYcCUAcrtrpgHwQEzMRfr2Xyw3GbGguzb2WGrbhLD+IofGXdutZjnc46gr8jdKQ+d4hxubxVlHFZ/DHg2IeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdL/JOpwdGSUQ+MgRZEW02m0CVVvTcmiNksk9AsYcN/Wdlfr/m
	7d3k0sZgWRcCMsDwWLqGJDQ/JYyw66ijiHco9k9kgisdb81P7J6JQsEJDftTXoohVw==
X-Gm-Gg: ASbGncvZ+tcusdLD07M5aAA5cVp/iq+VYE/diz6OehSMAE0e3nX0ocJUQ2j4aIpCr+Y
	NJoeUbhPhKDH2m4hF94djD3RwZLnhVQpJI5J6gKDjLeUWgsb4qRWGRjScQArgBn2KjWZ3REMP6c
	pPrqJTYbeCEuY5ot4NwwTHV0uDKwtZI8R7roipNbZflIjSXh2ea7mc1vyuFFsUJCBH4VuuEZlyg
	PDuvx8UOvMIVZUFxUcXsI5jQY89NI+t1JqBUFXA2xw+CPKp6LAh6f26fUoOgwCzKUxR9gwK5J8q
	oBNeLAHQe+xwFxaHSYfJ3VMPIB6keWp+rasq3+J19wn/3W42mHReGnpCeepHHO6bnIXTQ2bkLvw
	bJtd3oaBmKqVdSJI2wU+9RLfdFRnNO6MdUGf5FwlkeCvKKLF6YaZ7NpP6v249mlB2AgYiOBKE+1
	LFFhZO
X-Google-Smtp-Source: AGHT+IHnpK1ryIze/dfKJb+3lNvusJ/r2/c4HUclDB5JaPM+8XASmzJpE5qTgYhWf0sAgR2kSDaSyg==
X-Received: by 2002:a17:90b:554b:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-343f9ea58c7mr16461750a91.13.1763437642955;
        Mon, 17 Nov 2025 19:47:22 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07b6dacsm19932738a91.14.2025.11.17.19.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:47:22 -0800 (PST)
Date: Tue, 18 Nov 2025 12:47:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@google.com, minchan@kernel.org, 
	richardycc@google.com
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Message-ID: <ysxyj7q5fuwfbvbh2o5ewsl4plzaaw2wcvn3qemjgzz43hvboq@d2k736awhhpi>
References: <3nqzi2v72dsef2dte7iqe7wahrbzam33druh7klsh45zvefdm3@ab6stznzdxmh>
 <tencent_900337D4388F6BEDF9525EFA974CD7669106@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_900337D4388F6BEDF9525EFA974CD7669106@qq.com>

On (25/11/18 11:36), Yuwen Chen wrote:
> On Tue, 18 Nov 2025 11:18:56 +0800, Yuwen Chen wrote:
> >> +	/*
> >> +	 * We release slot lock during writeback so slot can change under us:
> >> +	 * slot_free() or slot_free() and zram_write_page(). In both cases
> >> +	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
> >> +	 * set ZRAM_PP_SLOT on such slots until current post-processing
> >> +	 * finishes.
> >> +	 */
> >> +	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> >> +		goto out;
> >In this place, the index may be leaked.
> 
> To be precise, blk_idx may be leaked.

Ah, I see what you mean. Agreed.

I guess I'll just send out v4 later today, given that we have two
fixups in the queue already.

---
 drivers/block/zram/zram_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0a5f11e0c523..8e91dc071b65 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -886,6 +886,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		 * (if enabled).
 		 */
 		zram_account_writeback_rollback(zram);
+		free_block_bdev(zram, req->blk_idx);
 		return err;
 	}
 
@@ -898,8 +899,10 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	 * set ZRAM_PP_SLOT on such slots until current post-processing
 	 * finishes.
 	 */
-	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
+		free_block_bdev(zram, req->blk_idx);
 		goto out;
+	}
 
 	zram_free_page(zram, index);
 	zram_set_flag(zram, index, ZRAM_WB);
-- 
2.52.0.rc1.455.g30608eb744-goog


