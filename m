Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAD41D651
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203935; cv=none; b=qEsXRbq6xPW05UZo2c/yswXgyp742cItVfvBceChzEGyCMgcfoze8rzJF0yezebR2E3ajaQU3L6TFBUYgXAs59qOuxYGlJukDhydfJ3vzWY84qHIR0LLfWPYktHmfG3Bw0jzvYPKBPxexaCiW4057gfHKOgbXyXeoKT6lkiXI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203935; c=relaxed/simple;
	bh=4sK+rVhJMsiMZBjjFR6oxGaaoRlSwoMnXO3Z9YOD7kQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WqP8Ppf+5zOn+b/zWuFvjN+UQuiR1+rzoTNZEKASogkOuVxcVy1vNosP7EIRxw5AayCIzg3XtlC4RZhbl6gVgE6NEhJJGYJWGYsf3lX89FzdqTzFbUnpABVDeYln3WhizM04ngaf9nRf6+CS8hNDdqAOQKMIczr/orTzBcu0828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WCIzml55; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WCIzml55"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a38d83a480so89099eaf.0
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784203932; x=1784808732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LgT6UXnammseROnZRY84NmFkEb/mPNcqE7w8XOWc3go=;
        b=WCIzml55zRL/KHBF9Mo4mtU3sItCGp6UYIma+irso8pj7BGw6P8x7cpEreJEx6cGZX
         mKLdRs3nZMMhZqHxuQ+RH6KkHubhWbsrY5yM1ckLsJp+fc41ddzZChH27hokoZTWZVuF
         Sli5WIB5N1MJClegWLjVdf25X47OYr3ZC/ek3AUDiuae/yrWoAAbdftJYqoP+pix3mVr
         O7HcokX/16HRonbl+0xF9l6kJqvkjZAXDj+i5UUWtCsnsZo8S/xEdp7QhaZCLIcSCbtb
         UiJsjs7sb6AX57tAaspVhxSI41V09yK8xj3ODSExyz+EvVbcsXkkDEGfD9usV37lerW7
         GUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203932; x=1784808732;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgT6UXnammseROnZRY84NmFkEb/mPNcqE7w8XOWc3go=;
        b=VA6uxTxbflXPQEyqZd6F2PaAAHu2P90UDGzfwPGWfl6CuhxRU4D8i43yH+hWqryQIh
         eFqxiDYGvdq5/dXmeZjyPVK0HfcIFSECgvHWVLal+EKrWsizACoJ7bHLSMU1+q8dJxte
         D3BA1k4jRcdXhcKUiTnhXNthqa/1gFqrHktio1sjlIbFjoraKG9djCFvep2KaHowp1Rd
         x8EUIgfJfNtjiMzUpiuAjQDjjTQvf0j/O8mhiUBLRA07vTv/kJ8civ48sMyn0wNmWZGW
         V0ms6dB4YtmG4TKrJ1nFl37MEKnBInLNUTn4ggZCrtDkF+VHgr5dOfR+dQpqVYVUxBNF
         z6XQ==
X-Forwarded-Encrypted: i=1; AHgh+RrP8+6Inq9Sx9FpblUiYOIj3NTxiOYYA2hF8RinoZ9Ox8ilxEmjWMdRWz1j/BNmo3ZcL9BCFSKM4T3pCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDiKxUoC0D/DtdLMF6rzLvWAeo64RizzFUUM4ZVaat+xxfD3s
	2xWr8srEkl7K7ebRVWO+2Mm8yGyHV6maUs0YS6eXLMbppLpTNVBHdsDpvSRT/7atCzm6QknhNms
	UObnZrjc=
X-Gm-Gg: AfdE7cm/DnoosAuQpk4qW43myTtGyIJRwp4JGD2DkTdxWBcMN/J46gjG25y6t03mTV8
	0GNhr7/um0Nz5r9FaBDJ059WLZ/yyJKJXr00Qxl5xhgO8aeIL/U+RM4+qkypZkRQDAj7DuhZktY
	5r+JDLWfTIHSpwjHJARZcXTz+HMnChT9pn3mPQ3DuX5cteBIREQKdtiWCO99huwZNiwN0EeHwCA
	VOLWWL9guZwDqLgNiKL8G5Y3VaUmp8fI5ubRZ16pWesSQ2s/ea7Ji79UkUHKbtnMjwOragM3wla
	iPNNbKfzMb19TV5vBNhGn3GW+IVVKN0eG6MS90CdgsAEflOk9M3J90LmzIgM3mEsKkzSNwVNVJg
	xyJSkHrrvAacyrehnhmEcbkgEbPr42ENumPRYi8IY1VbAuGeJ6akaObruuA5BlB+3E4izHYDKA/
	8GqVzrl3tNNINedBLpNqfwrx+yjoNxr8peysjOdKdsDmyg/Pbj446sCls=
X-Received: by 2002:a05:6820:2913:b0:6a3:77b0:f762 with SMTP id 006d021491bc7-6a3ecdc2705mr1307550eaf.25.1784203932643;
        Thu, 16 Jul 2026 05:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38a4bd734sm11627050eaf.4.2026.07.16.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:12:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Baokun Li <libaokun@linux.alibaba.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
References: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] block: try slab allocation in bio_alloc_bioset()
 before mempool
Message-Id: <178420393089.282740.17903652811430880504.b4-ty@b4>
Date: Thu, 16 Jul 2026 06:12:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 09 Jul 2026 10:01:45 +0800, Joseph Qi wrote:
> When the per-CPU bio cache is enabled but empty, bio_alloc_percpu_cache()
> returns NULL and bio_alloc_bioset() falls straight through to the mempool
> fallback:
> 
>     if (unlikely(!bio)) {
>         if (!(saved_gfp & __GFP_DIRECT_RECLAIM))
>             return NULL;
>         ...
>     }
> 
> [...]

Applied, thanks!

[1/1] block: try slab allocation in bio_alloc_bioset() before mempool
      commit: 447cfed6d700bfbd5a7120f8ea5821a0e1191667

Best regards,
-- 
Jens Axboe



