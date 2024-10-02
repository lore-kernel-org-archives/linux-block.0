Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9341E7650
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865969; cv=none; b=ECdd7vHbVmzxBSlsTM1IoZk002HAHWSNbiz1AQl72gqeiwZkrawoxUHJ5Vre2VNdawwgHlTpPakj5uZ4N5S71zd1iBGOEYX3Li0vHiGQp1xw1Pb3qfb8m8aJwCl8XT34RHvVO8Lq9+Z/NfzHeZiVzYWJhO59AJGyVpdXJOVwb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865969; c=relaxed/simple;
	bh=j1jipKhBpX/FlRTd/1TIChevsQmJqofboK5tmbX95yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeBduZ9nDwr/EyrzEpn9C8Nu2WeANR4O6tE9tx6mBi9+tEhk3Z26V+rCe5OEMdwBnDQ0amL1c2UOD7iC/yBTlUmLrtYXHWFtbuebs4zGrernwawBDbAhxzgHcPfilQRcmJJWhpxHOGT8cum6ABjx5b1k2GqyKDznUEpsNNW2Kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxS7cprL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxS7cprL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so5046367f8f.3
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727865965; x=1728470765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk5hvgS0hGjJuo5sxC+sNtdExW//wukSgwsI+Pq5YRU=;
        b=zxS7cprLvBQqL3tgqg7e0S+2wKvbGTQEfS9z9nNGe2Tc3IizJEbNAEnVNV1BlQhLSz
         RzcYh04yDi87YUbNQrQdgPB/hN3BYsIlQdX0270iJXOAO3+DTIkRHEC5VrVKAaZfcSnl
         ZeHwu8vVY1abgPLG0XT2rpOdiK+x8PlmiLJKONsdnjBDBg7gC6H3AApIkigiBxg1sLZX
         q3rxSdJWExV4PaR7hOqY8bjdNpB/2BQ6IhyFM/1EEeNyOPeCPJSmOByi60JatiPKt+24
         vZXCHgG0j4F2I/I8S9uW87H8AqH98d2luVrGd0sP5gmFmDQFibnI4Av8Mumkl7zd/2re
         ohbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865965; x=1728470765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk5hvgS0hGjJuo5sxC+sNtdExW//wukSgwsI+Pq5YRU=;
        b=U5j2/mMVx/2CYEKkwo0hA9jcnZ2o5Bjh7zoJ9qERQoFoSxHrqRyDg7niN6pFtmhuxz
         xFYyTuVcqLIdVIl9mw/yUBwcbdlA4lPnx8xJeGtmfmxgIzHRZsN3jUfwHVVo0fxKH+mo
         6f8hYLhmKZCDUB8tiA/FwRAmljcEpCqAWoAO468D2ApKhj75MYi8U7ii+QVQfbDvDqyj
         eV3aUoff8BsP2lQxu1d8wsJsTpUsM+chJLAynsSyzhZN6qo/YhUxV0Bo11ndSwZUUIUY
         eX+24SeRx4lnnCGpzrr+HyyVoQwVdldMvRGRriI3wWVf46XF+c4O4S/GQT1oRaNmhQ7v
         aE9w==
X-Forwarded-Encrypted: i=1; AJvYcCXjajWq7/IzQ2C1nuPq0S6ZRzVAcBohXNFSgREebVGKSCBFeef+eWRbSdyAWdXm3dxX5F19Nr3AVmgn8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YybdRAJlmVOl3KHIkxJ/pMBn5TQ8iFcMfWEw0Jsf+L3bVJKIroD
	rAH7bwCe/Gez75s3etFN+0SQep2xBTcT52Coh6V/rEyG8n/omxXQQ1lQkDTFLKw=
X-Google-Smtp-Source: AGHT+IF/EJDPE+HOPHXbRDSTkeiUO+hzHFC+iz5emuBJaiUOpXAfIJKgswRfUyuHfngLDtPziZdOUA==
X-Received: by 2002:adf:ec08:0:b0:37c:d1fb:82f4 with SMTP id ffacd0b85a97d-37cfba0a6cbmr2320172f8f.36.1727865965374;
        Wed, 02 Oct 2024 03:46:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a00bcb0sm15117345e9.43.2024.10.02.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:45:55 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:45:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] blk_iocost: remove some dupicate irq disable/enables
Message-ID: <7962c626-87d3-4c6e-8fac-16653cd2868d@stanley.mountain>
References: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
 <Zv0MtvYFTHlff_zT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv0MtvYFTHlff_zT@infradead.org>

On Wed, Oct 02, 2024 at 02:04:54AM -0700, Christoph Hellwig wrote:
> s/dupicate/duplicate/ in the subject.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.  Let me fix that typo quickly in a v2.

regards,
dan carpenter
