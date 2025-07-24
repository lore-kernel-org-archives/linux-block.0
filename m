Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCF1DF98D
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329365; cv=none; b=XkUOjPPVA78Ex7JaeRVyHQYuuPY+ZU9tsJ3ejfSoTLA9OGlp/Yf6Z8AqMUgwFWcmp6rQRWxSn5vZxpToOzlhX7lu+GMWAJwo7izWCp1VzILIxOhrReVGgFDdKYdniwM31TCtkhCG4BHqHFU0Pk9So+9mOnsJTE36t6WC7JaOAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329365; c=relaxed/simple;
	bh=3gqm5ZtqZHl8gf6wHuaAtEAgFFykS1nRMws95vTVtyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZE83ZRZXh5yYpncEly9JNFszmFb7LPs2IhYYUr458LwcI+jSmVcdSON4SAScHusZ3NdlAqkf3v6qSVksJP2Cy1OFXwUKXGndruicy3Bc8wPzVrLUW0EX+nosBhpuEOWSwYgi/NrRlskT3lnmK+7C64LVyuhu1c7bT+V/0BwgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U2ZTEnQL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2ZTEnQL"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso675016a12.1
        for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753329363; x=1753934163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZmKPeiidC8bPFTnJorLU8st0iI1TCGghPIfpYVMexI=;
        b=U2ZTEnQLiijkiZlu06H185Lb1IGJzv5KmegpX466zc19+HLOs7LEXFE1TqKQnYcDMl
         bLEWTzokEfOChhYzK9+21rrQZsM6/K6ofnA0WfT1IzFWKhxvtx1vnT5MHT26QZLAVuBq
         TsaWfOUXeQ7AJvIqWatt+or0M4nZulGN+dems=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329363; x=1753934163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZmKPeiidC8bPFTnJorLU8st0iI1TCGghPIfpYVMexI=;
        b=DmFUjrrCrJcKGdKDrPKc3cWlxhD8cxki1vUUJneYj4KkBrvHgWObkGRNTf+jHwxf8e
         DUyoyKB8Op/cZuQbofz17b/Nq0NXE6vUtVgg4uTrbjDhw+BpN7R6DMVlgdBf2AbBI8CF
         nEIFxHPsyQYIBvfJIV22v6UxvOP1Yu3mrsQfcwuZm4XxWq8/mXtvPRX7lFh3R0fZtDL9
         HyNYWo5nmakHHSZTHfbrI/eqhxKeo1/c2H2LOeu2LI7zfFquW2iO4H58PGijSb8ig4qc
         b1QdAtxeyyDIXtXp6koF4jiz73Y04yXFxVrTligVRW02PnRiELhoIztxIj2JWh5BQ+N6
         0FJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbBIiRungFf2tJzL0k148HC9gvHRXy9NUWmKpF+EyM61FufHxrALyu2SdLp5m8FXUA6DZQUJBDb3/nMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XZRelvISyB0tx4WxOVs6d/mcLR8AaK9obpEy5DMpiW/UbDon
	LldKtqpaV8nX3eSllWwp287KqsllR6UPbf2mKx4OdZwYd/7sW7byDZXD32iNUQXx0A==
X-Gm-Gg: ASbGncv2UHE6G3O8sUECmlH2pLguBZ5oCx9/vMCU0g3pDQWnepYtam9nq+E/1I7LbIc
	jirojBgaSxFIEPjPhjMaxzHKPhhwWguqJz/CkZp3JOaYHRyDpHevPev+HXASKKATaKLvBSMEiBT
	/Db5NlcMt+fb052X561LHuBx7MzcOYFk3+bAHmZun0a9kniDJSiGvMFKubPZheJNmUQoO/OWwzQ
	ak36trvvB+5OjOIGeWerUhojcu9BnolkeApAAtDhZnanRdbpqVn/0zl0pbmPOqmzJ/xh29tG0OO
	mAJCKlPtSBjIegWGhyz4N9AmD2Q4G+stlaOPOhtrnrR3tU1gPbCL40QYKE+3ISXBpHtEuuCQDSa
	PyMhNZ/hNBkLIgLTv8ujdlHpoeQ==
X-Google-Smtp-Source: AGHT+IEQexJYzjwxqVrxwZjxP1gbkcDLxTxNm6ahZFwgKyB8heHmzJk5RUldS7RABlkdClyAvOZLcw==
X-Received: by 2002:a17:90b:582e:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-31e506fcaa7mr8263922a91.9.1753329362687;
        Wed, 23 Jul 2025 20:56:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:23e0:b24b:992e:55d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6626994bsm240171a91.7.2025.07.23.20.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:56:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:55:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>, Phillip Potter <phil@philpotter.co.uk>
Cc: senozhatsky@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] cdrom: Call cdrom_mrw_exit from cdrom_release
 function
Message-ID: <r6r6gudppkfojg53oeo4cexelg6cxszd26zjgqwduphy4kmtqq@r5w6ojwk2uar>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
 <20250722231900.1164-2-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722231900.1164-2-phil@philpotter.co.uk>

On (25/07/23 00:19), Phillip Potter wrote:
> Remove the cdrom_mrw_exit call from unregister_cdrom, as it invokes
> block commands that can fail due to a NULL pointer dereference from the
> call happening too late, during the unloading of the driver (e.g.
> unplugging of USB optical drives).
> 
> Instead perform the call inside cdrom_release, thus also removing the
> need for the exit function pointer inside the cdrom_device_info struct.
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Closes: https://lore.kernel.org/linux-block/uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Link: https://lore.kernel.org/linux-block/6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk
> Tested-by: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

FWIW,
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>  # with LG GP65

Thanks!
