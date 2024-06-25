Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9429148FFA
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305160; cv=none; b=rKnB7EPPUZFcJ5FmGa+TkpRWT8Tkqo2zZ90XBw6zqlyLMt8ss7tCNM87pcLq9rAJT0H9wuOrudBD3F/TpHm0T7zCjvmCOXUakSgpXFD+jsdJbJKpSmOlYTYh8ExLKveoUMg+dQHc5+cv1LjFcEbdo/G4FBr6Qpqc/wxSz/3Llks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305160; c=relaxed/simple;
	bh=hVv70ZQILi2lefYhkeMmF4UQIbUq3fpWDHl/jMl+DvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G18vlf9DfYtXZ4FMD//sOJwp1ZghPvVQAOuexAw8nQ4GhuSS1pOeOORXi+jR7anBIWoCF9DCQDTwHEgnIx4QexidtAcQfia5oJW60VpnB7KFxqdnyRIiK1qKq8VPsx3lKM+F93cWnV2SdoNODBpKsbg5glIOMRMywx0jALHzHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jh73R0LY; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jh73R0LY"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-80f6521eeddso1145739241.0
        for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1719305157; x=1719909957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g56+XRF9QGFax5i2ZEBOjZix2dumVKph2ax/brL9KaE=;
        b=jh73R0LYP0y+sxR0De3Fsk1uZq2v9wBEXkh8nuTR1aW0mGpwNUGS3cAu88fvLbQUhV
         6neNqXAubB0NUWF+JcB+5WkLCpofKCFoNBLUQBxOULmoXTK03hpmD07R2XR3OP5q9CLx
         TrGugDHMdZYbF68qjAkkH14r/DCDg3B1M+AZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305157; x=1719909957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g56+XRF9QGFax5i2ZEBOjZix2dumVKph2ax/brL9KaE=;
        b=Q0jCOEcPzBYcFOgCKDKiD+6eu9d0zCPQjGkZuANg1b75JfPT3flyR2/b7xU/l4khp4
         0Pz9fDTITO6JkYHo4zsWn2q161r/5OyJOMmvLPumopDjfOK2a34UCx1MSsl8p7EVfgtX
         RHKW/tttE/CGRzNNrV4jAubD8i6RUWAcI81LemLJYMH9+af8BGYtNy4gUDTiZQoiOimt
         bmjQ/9tGcM2r953Uscucf5a1ErVhAspxW0a8Jwd33NF6YaAx46XRxkbMbhffVOhcYknl
         no/I8HNKH+ot9DtQJEESvsbAe+6np2rfZVnJB6HRj1nvnsEJVYYt1jUUOU4jW4JlMfZN
         cyRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZiaLgPWYOZQFp8/oT2W1wWGr3+f02W0qndF+7N/YCc0jmXY7EyUO+FvyhKx4FF6kIq83GarzjmXDuaNbkLFNtFHxgsqmy6uUWWwU=
X-Gm-Message-State: AOJu0YxjTo9ELlJDgTppTQchrC//xYNH6PbQd8jP7TyO9d/xwnbsWdA+
	qCvZ+iId/LEC2oEVWDVgs5CbRds94yOn+JywsnurmdaQ1sgBzircckT73yMnJR+o3uIixXp/3gJ
	O
X-Google-Smtp-Source: AGHT+IH0MfSZCdGKMabk40+auVyUctI7c/cU4UkcPOH97YW3mfjjmX4BCPuh/WV68LtaDi5JbfPV3g==
X-Received: by 2002:a05:6122:9a8:b0:4ef:27db:d206 with SMTP id 71dfb90a1353d-4ef69ec006cmr5271895e0c.0.1719305157550;
        Tue, 25 Jun 2024 01:45:57 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52d82377dsm31721876d6.19.2024.06.25.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:45:57 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:45:55 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: jgross@suse.com, marmarek@invisiblethingslab.com,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	Rusty Bird <rustybird@net-c.com>
Subject: Re: [PATCH] xen-blkfront: fix sector_size propagation to the block
 layer
Message-ID: <ZnqDwwXgwDlggHgH@macbook>
References: <20240625055238.7934-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625055238.7934-1-hch@lst.de>

On Tue, Jun 25, 2024 at 07:52:38AM +0200, Christoph Hellwig wrote:
> Ensure that info->sector_size and info->physical_sector_size are set
> before the call to blkif_set_queue_limits by doing away with the
> local variables and arguments that propagate them.
> 
> Thanks to Marek Marczykowski-Górecki and Jürgen Groß for root causing
> the issue.
> 
> Fixes: ba3f67c11638 ("xen-blkfront: atomically update queue limits")
> Reported-by: Rusty Bird <rustybird@net-c.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for debugging this.

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Roger.
