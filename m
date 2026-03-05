Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CC218AB9
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673802; cv=none; b=LNBRMfwXIS5120zIaAsi43xWvlMIYbjlEoyUkKEs9gOnt+XQpOjyzzkGcl7wgGRewBmkzk2XLUtbhlQPDjzXFMoBRPO4wFhN2NOAxHkikUon4D60JgBfF0XsD+97ismRnneBr787KD9geO/0vzXPA8UsY/7uSnV5chHeFMVxjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673802; c=relaxed/simple;
	bh=xFS6aDogMQvEygP4vDkEPjf62ieutEBHGzDQbl63fNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYCIShm6S46CrsuQxLILe0szoDq8gwxTwkksxOXn6Y3DdGQO8KFX+udsCv3z8i+T0mlhTomkC32NlGkZxH4j0KCfKQ6ujxI9m2fe2SxUBUShKcJo/Ywwfg5arQQ43kcfW6nkVX2HOlOVN2lUyY8LNh/jJtAlNHGcxKEWES0xgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nE0fwS64; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nE0fwS64"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829759ca646so648965b3a.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 17:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772673801; x=1773278601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0CYJ1xpqzscmD4+oCsvdrJGpHt3ifBQVW0Si8bxj/A=;
        b=nE0fwS64c4qGKkP12Pvui46klkOwpRPIKP8XKYVQhRHfQmtcNYyDL+TLxvEbuPdi7v
         eIgqa1KvaIWrqjMq9ZX7tdYghwgLD0LbluVvLzehSKuCE8Q44Jmat8IzG3gU6nsauucz
         go0yr/PGtOMyr+teSgiutnV4qnhb2e62Qgw+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673801; x=1773278601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0CYJ1xpqzscmD4+oCsvdrJGpHt3ifBQVW0Si8bxj/A=;
        b=lqricsW+HRQ+gXt6SZotvYBsIw/sFhvPVnsi2ArMu2wN0vqwyVD0RyVBwYJ43IP35B
         J6gVO10fN6O5bxiwXJnJwobWC3d4q1p9FVVaLnbMEXQ7oKIxhlQgQWRp/YlP/ehwjJIZ
         blcCFhSK6rir4oBdiy4L/HPiMwaGa2kJps077mpTqbSafDTTZR3sI/y7lb580pSot/xD
         wuvJKSWKv71v6YjZAYDK8r4aMAxbNtxEiNpg5l0XwwZdCp3kHlZvKwKtTh6hVL6tfUIA
         Uk/GczFpkvqmA/pxxNcbYxmRc/qYffqGLKOSp/HkqG0D2HCJMrSOZG00VD2tF+j6pU8F
         X7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmcXNwCTPlFqpHxL42oazYtwJEDdOYVCL+sq3U53f6OPE2D/AhJ67+93fOjqZFTWHL8bN5cyeI/MeL1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIvLXj3qpMAllx7pVbkytjlUhadX0DdBGSs87231jvB/o+aCW
	ano1km6cQod3NTXLV9+S/1U8HzcZOTn+RZLP1fin30Qokc+4Bl/ScuHTQ8U1XHUdsA==
X-Gm-Gg: ATEYQzxwVBPK8wK28ov79BNzc6fkVhGos1LVxAt3XpuVUFveuoUjzV+2jcQeocphNL1
	SL3I5woMtEmkU3Buucio9UGt823XcC4DG6eQNdBC1DVT+LHqFwsQMeQs2TBX3Tl6VKJiwA2UpuA
	ccpE0rNM+17iM+So75a8EqMCv9/o7rspXwMH+rQ913JWfYBq+kUjhXx8Kf6NgsImZ2E1WCZr/dk
	z1NACvDko8fvzEVbvz/UkvLh9iDRF4ECCBu1GQ6LGmQDMODhh0zwgxKiX87+0zuxTmks5yjhQiz
	jhsyhRJLFADjQ9lwMswoxHiSoxKSeEvaKqSVsheIg0DudhV8mop02saDxRYzJmtS6rigDHHbfQf
	KDFsHE2WOgMW+1Vp5MeNx/XgjZa1krpYN2eTFt9CFmONtPrg4dGVZWq5cnzbqK9SONAxJzmYJAP
	pcpGKqZrD7W5qSDLtdhSC+706iOirIOWkD4tLdnL5TewkRir6qXbhRRH0EqPIGtSg=
X-Received: by 2002:a05:6a00:3a09:b0:827:2995:3ba0 with SMTP id d2e1a72fcca58-82972cd8cd0mr3233863b3a.32.1772673800601;
        Wed, 04 Mar 2026 17:23:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:713c:a5b2:ae9d:686d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82977a81e3asm2385001b3a.56.2026.03.04.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:23:20 -0800 (PST)
Date: Thu, 5 Mar 2026 10:23:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 13/14] zram: Add lock context annotations
Message-ID: <hy45shaokvtuwvq7cca2hnhykddijgi7eat27yyf7ynrbkmlt4@xvdw3a6qsct3>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-14-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304194843.760669-14-bvanassche@acm.org>

On (26/03/04 11:48), Bart Van Assche wrote:
> Prepare for enabling lock context analysis by adding the lock context
> annotations that are required by Clang.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
