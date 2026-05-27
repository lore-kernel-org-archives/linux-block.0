Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D6390CB7
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866519; cv=none; b=uj+GyFVxbYXpziABIeDdvE6GW7Gc99pZaWY6APnViYaf6bRo2EC1U6/iyoFl8UfjWzOUaIw4EvYK19opwMhaBe37UWT/56M/VKMamkA9iNCAlVk5T6wKylIxkUjm8pMcpyfSsNTCPs/NAAGIvMHMzLmSXXs0gSKLGXdjL19zcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866519; c=relaxed/simple;
	bh=a8s7JtOphjdlMjvBprTXjUUvcfayNfid6SMNJ6WsphY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVW6cQbrxNKlWY63uAvJfdoJ/Af6NFm+P/pJswQuArfg7i14N9wxWgcYqCwGGjgr7iJ6M3OVjk+BSIJE4kKE0ifFW9LBKGFyiftkY39YMd6qiDYSiCmqcuNSQSvDiZG2fZ9bRk/sMXYWbp223x1KiWVAbz5W07+x0hEo127i65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kiGDWlL0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kiGDWlL0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8379e010b01so4927130b3a.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779866517; x=1780471317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbeQ0cOV/xX8qRCoZ0tY0TlvEmEpG2Jpa9wLZjTTDgQ=;
        b=kiGDWlL0Mw806Fe952FxMerCCBA69LXrFLx5lZqxVieDf7NuLGuSZ3EOzf74UHPFas
         NbObQ/BhaPN+PEi6JykiCRWLa08Ahve75Nwx8bHc6Hc1J9mhOn6NBAWLzMB/uUyGK2aM
         Si+hMj9tvtNkbVxiNpXFGgIlEnb5v5VUzHXv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866517; x=1780471317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbeQ0cOV/xX8qRCoZ0tY0TlvEmEpG2Jpa9wLZjTTDgQ=;
        b=kv1enEiUISFuiu5kxs05koQJQGLQfSugoOyqP6YurnuOxF67EsqnK+cULThOqY7z6e
         AQhEfzeBp1qnbv+UemFIAS8EJzqfYygVVb6RItEq4YH+U+pDv+tN7uF3Du6948VPiYEq
         401+coAzK1jsKnAFukfh0a12u92GrR9n0eq64fmUqZSAlY1V7On2zQaq8sPTxPTN4RC9
         is9twA4zASn7D9Ttkv6lmkUb8okQw4/Inx0taOjjIXjDpKv5KbE10h7pHzbvFDJimpJC
         nH8Cjf9wT9zhVDma1mgRXPXhJqIIKZcSTpWdZLdqAd9D8ASksOgROWSrcxuFY8XQ94LU
         f+Rw==
X-Forwarded-Encrypted: i=1; AFNElJ8AzQl/t0mQbTKFFENpa/NbflQB9g7veQlFF+lUrp4dN25x6AmCTrggGvAd661yMS0iafIHKk8mTkBOpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUnBCtba3+W3c7uRu7kGJv3fzNWNqC0Bzusyl4pwn++/LNK93
	xw3Gxj9WgIp57n1oMUXfvGrkGsrMVlSoebKutPxJ/vvegsL5ft/oXyJeZgsbofL9bQ==
X-Gm-Gg: Acq92OHltarnQwGcnzn0pjx7hiW2j0FAydCDeebu5XMSKfgL7TUGDuqEAC82Psc64se
	anvM+IqGsh+vedczTix24Y01nlL+MQwEXDesgZlfVnx5N9K48Ool0V/DYWpVfZSstsEGkMCCGe3
	HNhfaKvIym4Gu4rV7dqMCdQkk3/kigvz5JOcBWJL2cxyfDgxTNDJUR+pl3AKYGaOl1yHfm2AHhE
	7RJtLyUetH3ZTAgI+Pm7jtmd2OMmvDNDNX1w0Y5Sv9YsvJTHqdti6O5o2TXp3oecH23C5AXi7nG
	yQ7nqMM1BZTyS/gSBgcc2vDRk7vGE3TbPtUBKTJzvzrKQ7zanq+bG60VBR0xFrUyFA25InBcuAC
	lxdFccW2sflk6ftIat1Mi5oX2Ag3h4b2KXESKxARhH12IL1gt2M5LsYp9PdTPpjkIfHAzuSJ9MZ
	zKSIiP6M0DbsJDKIkLqbbCJum614f8Auw4EWcYY9t/y+ufVZGkE23uIKMxunthWJI=
X-Received: by 2002:a05:6a00:a383:b0:82f:21ee:270e with SMTP id d2e1a72fcca58-8415f6d0bb4mr21703648b3a.42.1779866517012;
        Wed, 27 May 2026 00:21:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:140f:40ed:a6bd:f680])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bf92asm1369996b3a.31.2026.05.27.00.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:21:56 -0700 (PDT)
Date: Wed, 27 May 2026 16:21:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] zram: fix UAF in zram_bvec_write_partial() and
 drop dead bio plumbing
Message-ID: <ahabSU6QcGJ4T4ZP@google.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>

On (26/05/27 12:49), Cunlong Li wrote:
> Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
> happens on PAGE_SIZE > 4K configurations when a partial write hits a
> ZRAM_WB slot.
> 
> Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
> from zram_bvec_write_partial() and zram_bvec_write(), no functional
> change.

Did you test it?

Looks reasonable (unless I'm missing something):
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
