Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F491D1F55
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892645; cv=none; b=Q4UmV3GXZzZSqoYzTl3mzN1sEuDNFQ+VKlP0/8EYHoe4bk/HQBKATRf4+uLkkgFb038+n2DtJu1SIhpo/Sbdc/2OAheKghr/kH1HMA4Or/FT9P/20Ag4way0fZLA280t4y4bZSkjGtz3b8JbKfG7fqkeeTiVEt7Qyp0W4lC7+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892645; c=relaxed/simple;
	bh=DK2MUVdAtluMDn/IwETewEanduQqhHxMYakPpg2sRc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK7cKPg2SIsaWZd7R9TLKHDS8ZcgXjSgyeWXAX5RwON2235IqZaS66zZZnCqFEHVFthoj3fWiahYEvh82M9sQodp9NKsSAJjiYQuhRwPpKKdi71MdM2a91zothOQKZmhd08dnkLtxjvHQyQL8CPWTsh/g05Of1qe4aX4myS3ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBkhD/0b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBkhD/0b"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so152375e9.3
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727892642; x=1728497442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGG8QMel29fIDf2AnAxKpn/d8hnp2TmaHrAszFN82PE=;
        b=QBkhD/0bHd6wPrT0PPMh6ixOMyQJHb7CoaCfFFXFhHZueDdjLow9Jm+AalUtT1tPMS
         j5WUj/X+Cliq5zbPLdZRpryDQCmDpek7CFzroQsoaO7c2gj1nQ8e2fSKuXqVS1+l0xMl
         VCdN2PYBTbum0CEr7FvG/9iQZnh1SbPqAv4tdLnxo0rece6MX4Tu81HlWKEYpUiN7BdF
         IXCpgcD/6gbsJZQ80tfV55rg51TepV2VsM2Lxv7NrzRYFioKtSYGH/zioYgAsQ9WjIRQ
         Ge+IrGpybmhU4MQcSkGCFr6Cqbh0AgbrLoRISW9z/hAri1uPVSaFsYu2oZoWzfCtV+uG
         azXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892642; x=1728497442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGG8QMel29fIDf2AnAxKpn/d8hnp2TmaHrAszFN82PE=;
        b=OQ+ibb8wLRb7Gp11jcPEephaxV1gczzXwWdXpA20cAYGIjTfgkq1fkuv2mgNKlcwY9
         VaPjsNoz8vXXqmOv7SGAuXroKUZGNKSqUTnWxA/Zp5X+MtinpmpYMRSXQDew+bYuAyLk
         4UOk4VTREvBirArxhKzfWq+eET0PsNqD2Q5ly5R2VNL1YI/m7XYE8tjhEDnzd1Xb8DmT
         c1aDyLN89opB1rjNfWeJURhb7X7yVT/Cq5yau6tMt8dld1mEW4nLRsRauh9r0dXvXh57
         k1NS8EXnlo04n148dsjT40yJeAGSvd9XVkC4L0QculZCf9F4cnzz316ZbzE7vOzSo2A0
         5XPw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ruca3AW6hMCA8rsFr33Pr3f8uSccunC4Nhf9oNX8pt/sUM/a/48s3X/Avfqjx6CyZpGrg6rCMrGEAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9KhNwczaO6UCzZWt26D7fmudwn3gI4Cq+DzFsVRLyWXA4Nze3
	yfVhvTKrYeNwshaSdim1ixUul7IPMfDfkFFkTqRot7NPsYNso0F2VJe/WQQCR80=
X-Google-Smtp-Source: AGHT+IG4L90gOtT2GIPiJck56b9/qGOnFxKwX8Omp1g3PHVDmm594jaN0gFUKmmSK7OJWNmzkks2bQ==
X-Received: by 2002:a7b:c384:0:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-42f778f2bc8mr31431265e9.25.1727892641539;
        Wed, 02 Oct 2024 11:10:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7728b382sm19659855e9.1.2024.10.02.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:10:40 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:10:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waiman Long <longman@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>

On Wed, Oct 02, 2024 at 01:49:48PM -0400, Waiman Long wrote:
> > -	spin_unlock_irq(&ioc->lock);
> > +	spin_unlock(&ioc->lock);
> >   	return 0;
> >   }
> 
> I would suggest adding a "lockdep_assert_irqs_disabled()" call before
> spin_lock() to confirm that irq is indeed disabled just in case the callers
> are changed in the future.

It's really hard to predict future bugs.  I doubt we'll add new callers.
Outputting this information to a struct seq_file *sf is pretty specific.

If there were a bug related to this, then wouldn't it be caught by lockdep?

The other idea is that we could catch bugs like this using static analysis.
Like every time we take the &ioc->lock, either IRQs should already be disabled
or we disable it ourselves.  I could write a Smatch check like this.

KTODO: add Smatch check to ensure IRQs are disabled for &ioc->lock

regards,
dan carpenter
