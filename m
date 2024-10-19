Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E21940B2
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729377978; cv=none; b=rd4E6XQ8qE+tpq8Xb0NPRD71Vwf1v+Nv1YkeWpFqy6LJCLzUmyHRWlxWUDPbbxeFvhnNpgPkM/+AADtiLuOHj7aBwO9O7NCmp4Xts8yayIiLRnSfuYnYxidcNqkhgXySUi/rsWrzx0YO5//axGD/eIazPkrfdRwnggZ75vM+dUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729377978; c=relaxed/simple;
	bh=60nHuYUWcZyZExj2mMMxW+cTxwSQrLwrfHPM7VEmH6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZJT8tz0dQAhWlHZGifij0riqA29WZAunZbcFQu17EV/6D8h0ghj0lVhKXU76vmB+SU5ZLmTiMSPBm7tCqp2PBoakRui2vrHFEreBs7YrhYkbOPr3tzF4dp0+Ou6MyEBw16wrnkYDPg7O/pa5xwxAO+rMRqQzKjprUjVyo+lvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eQBeNnWG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eQBeNnWG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c6f492d2dso38520265ad.0
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729377975; x=1729982775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mdf6YzsO4nTgcVKpH3rhXBK3CfpFHyz2LX9CF7OnOUY=;
        b=eQBeNnWGuTvYEp92xOmSbbGFFqVy1wNAHVeF1b6xJ6b8aQHRsC1UAOECGvr2+iGhz4
         rX5jyXd3TqSpp4F1Z6e/g4FnnfpbQnbgM7SosS5kk2zVEhbPs2Q92zlFQcygQca67EEj
         a/12j9IhgTaegkiAXjANPQD309cfuSBrYj66RzJLyRb8fE5LU0KIBa224aLQEi+nDM4K
         XNyhobsZ4gKLOz5aDXGVdARaxJ9SgtvvgX937soahVv9o4KR4hI3IHpl9443+/Wg1MEQ
         hKfnlJipnvuV44hm+4YkPYcIQg0h9gkCsbiVD74Q03rB1XQb48hVUWd8iBzK60kG0EUh
         Ryhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729377975; x=1729982775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mdf6YzsO4nTgcVKpH3rhXBK3CfpFHyz2LX9CF7OnOUY=;
        b=a1rHlHWQlz/7m//yDW0YsZKtc12kWLcTk2Z2n6GhL5I6YJjIUZabD1pW8GF6cTSOE8
         NCWsv3eGaqscKpp2ukldbn6jx3HvZQRmSd7lW29bBlzP796fLKs/PGmxZnBp/ca+gTN1
         5x7iWN7dHgzZKVAAvJrTqyFGD+2cyK9eBeTpdiuiaBilc8MKkg8iG6azu8eOYnMARpyx
         k9YbzDJeCpxRCNnETAKaGpn1AUgH9bcsj4EFFJKqHWTa44U1k6xteiGMSg1g23TOGlmG
         iKUV8LnpUIKmvzDX83NPEP/jX+bY5BhFmaF8QfJ3vnxFMTqeR42gZ81hrwdtTb8oAh6M
         TxlA==
X-Forwarded-Encrypted: i=1; AJvYcCXWdORgO2ld6iFBq8pLfTlWHUzwQ46Wow2tm71rLkP+PQss0oZbBJjMkjAPjLIkJq+LO2HwpDNvoUN5eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZRFPTmm1D0rO4LN6Oi2vxCDT69LY57ucM6G4TsJA2n5ew4+I
	imqDJRb3fn/84081WFfQeHbRxy6eDtnelJqL3DTYHj1354aJbfpqCOSYYwDRHxYy72Pxy/89MCw
	H
X-Google-Smtp-Source: AGHT+IHmFlLyLKe1kYFQ+SL5oO+4D2N6e3aCp9LFAAgrVT7D1A0/q8/cPgdIimmqGoDNzNkTqBQUSw==
X-Received: by 2002:a17:902:e892:b0:20b:bd8d:427c with SMTP id d9443c01a7336-20e5a792e28mr90015595ad.23.1729377974645;
        Sat, 19 Oct 2024 15:46:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd2e4sm2061635ad.170.2024.10.19.15.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 15:46:14 -0700 (PDT)
Message-ID: <4f4cdf6a-e1d3-4e0c-bb57-9cbe767ac112@kernel.dk>
Date: Sat, 19 Oct 2024 16:46:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for supporting
 lockdep
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018013542.3013963-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 7:35 PM, Ming Lei wrote:
> Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> and blk_enter_queue().
> 
> Turns out the two are just like one rwsem, so model them as rwsem for
> supporting lockdep:
> 
> 1) model blk_mq_freeze_queue() as down_write_trylock()
> - it is exclusive lock, so dependency with blk_enter_queue() is covered
> - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently
> 
> 2) model blk_enter_queue() as down_read()
> - it is shared lock, so concurrent blk_enter_queue() are allowed
> - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> - blk_queue_exit() is often called from other contexts(such as irq), and
> it can't be annotated as rwsem_release(), so simply do it in
> blk_enter_queue(), this way still covered cases as many as possible
> 
> NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> blk_mq_unfreeze_queue() from different context, so it is the only
> exception for the modeling. Add one tagset flag to exclude it from
> the lockdep support.
> 
> With lockdep support, such kind of reports may be reported asap and
> needn't wait until the real deadlock is triggered.

I think this is a great idea. We've had way too many issues in this
area, getting lockdep to grok it (and report issues) is the ideal way to
avoid that, and even find issues we haven't come across yet.

-- 
Jens Axboe
