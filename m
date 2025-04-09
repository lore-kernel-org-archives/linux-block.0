Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F72459FB
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197030; cv=none; b=aOR8ZqKBgnifYvjzl0es0S1NwTJBLZjcZsTvL0QMUh3rPwB7avrMzwgX9Khz3TXhINbAPPqgiDjzr1YHEA/pFpd0bfhi8np+peYgP0FT7Cdm1kfjwp7L6IBNxtgaWa3nRZ2tefbcVIqjmlPTyDwOHf8Y1U1gmJepyzsT/oetPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197030; c=relaxed/simple;
	bh=1cRD+Q2EoGSHOsD44Cq0W9nkSKnhVJaA4hp6x6u/kEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7xYRjOHqtdRtMHMaZWflRh1KFsXflQsOupqOIwkMXSuevbC2YWFR5nTDLcLQ3qsCQq6YY3h9NTDGfc8yl7r4g66rrMxWKRvneD964Lp3Z7DLF9/0aSBA/aUXwACmYfMEiuzpxq/X58VoQORgaC1/I0Gem+gCgGV0KVrz1xaOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TusZ+bex; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TusZ+bex"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2241053582dso84715365ad.1
        for <linux-block@vger.kernel.org>; Wed, 09 Apr 2025 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744197028; x=1744801828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cRD+Q2EoGSHOsD44Cq0W9nkSKnhVJaA4hp6x6u/kEw=;
        b=TusZ+bexpNNEZYaKkjwOZ3nCoYWkYW6ILEViYBMKxbjwBW+muwIGt+WHK64kmbJssL
         c3QMn4E/Z7MV4uQTgHR5mfxyZ2/zOVjulXqHBTLGfboQHlAbPmsgaibqdLq3d1abE4nr
         QDgiUDwColfI23yHs39rg3pqWp3RZvb6MhAYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744197028; x=1744801828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cRD+Q2EoGSHOsD44Cq0W9nkSKnhVJaA4hp6x6u/kEw=;
        b=ZgviGjCZLgQAumAMuaRheUmQuhA2+EQRAQFiY2lwwHTVFP7Rfj84wPar8K7Q6DUODw
         6iKM/downzxbAMB6qQBP/G7DIA15QNXLeWr/PWEOoPvp37yP7K+PFhMJ902vISKIz/MI
         NRismdrsvXLkTCSMBgnMZ3AOFEgy5j8gWV6O2JXAScjsVqMs8/k371KZ5lcUadjdts6l
         FNfYdjhLfbudLGwW0YAm1qZqF0DjMxTtPeu/dIUzq6u/pSO+7pmlyGv+7mG9E2/+Qe+n
         H95pObvQptrkv9PeOZrM21QZql6ahlW66AvBqiX1Mt9SlcUYJSaggnwKtlntXqs9hU8k
         nanw==
X-Forwarded-Encrypted: i=1; AJvYcCWI4DYCe8ccJPZdc3L0gViPtBQPESXuE+RkdGPc8Rkk6vZi44RpXPO3E2fD4PctS3TeaggvKuSf1TeQQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvzr8wisL5BLfxET7Mb6/1ZfybfLH3XYHS9a+VsyW6PZ/rBF5
	8mrpLhf0FnYDBu14fEhKskFpvyCoZazs9y67sCA8vJHwmeJUHUqiRzeqZR3pVg==
X-Gm-Gg: ASbGncttLWnxKvyKxE/T2vhmeuXhpSE82Rf2jjNoICD3Wgn0GHoU8O7NetWGyIly6HY
	Cae6JuBmsAEw2ZBKnFIL/UnG7jg83jFHujcKuDg/pQMbWbwie1XkHEezLwTwcrPUYbc5ZwTYT9A
	9DDgcVIJ48dWvVn758OJFqTAWlQItz5etmLU+9jyIVC9kFPJ91PkB1fL4eQZXvlq2nvBhbVEz8e
	ROl6rMwy/24jtlu6inIRbpTAD8AGwHRDNfmszDTZwDUBzLwRoaRo9gLlf9NYaaokoTfdI0wqwXd
	aO6XC3UG2yN/HwIp6ul8yBS8MBGGz8qNHNBixYNOGo1t
X-Google-Smtp-Source: AGHT+IH6fxmgITIb/nhtffS9HlLl7QIjWlAJGMs05n4iRReuayhWjvcGq2N3FOP8fHxbYwcNMgiypw==
X-Received: by 2002:a17:903:1b28:b0:21f:7e12:5642 with SMTP id d9443c01a7336-22ac3f6df3dmr30398605ad.18.1744197028206;
        Wed, 09 Apr 2025 04:10:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:eb5e:c849:7471:d0ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c9c747sm8987785ad.130.2025.04.09.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:10:27 -0700 (PDT)
Date: Wed, 9 Apr 2025 20:10:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Brian Geffon <bgeffon@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] zram: Fix uninitialized variable in
 zram_writeback_slots()
Message-ID: <osj54aiqi3b3dtgyfituj6tqpar5s7trkkx7hytfozl4cifc63@mu7bb5pyse2n>
References: <02b8e156-e04f-4ab3-9322-b740c1f95284@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b8e156-e04f-4ab3-9322-b740c1f95284@stanley.mountain>

On (25/04/09 13:58), Dan Carpenter wrote:
> The "ret" variable is only initialized on errors and not on success.
> Initialize it to zero.

Thank you Dan.

> Fixes: 4529d2d13fd1 ("zram: modernize writeback interface")

This is still in mm-unstable, mind if we fold the fix in?
Or I can send a v4 with the fix applied.
