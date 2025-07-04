Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E471D435F
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594034; cv=none; b=bysQ9y3II6pBc6TeJkLDbpEwy3lZPgafqLTwxPrbl99NAEOn3X6MtWY1WqILM9sLjTtbvoJ/ewP0CdDze6w0xf1muRjosxczckrR03v2AnH3wtUbfxjtxfQa3OUn0QeECYBaMBxcypso3VZ03vKPWvu8GX03WxYFIUqvmCKSzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594034; c=relaxed/simple;
	bh=IUMF0hGdyx2upyKxeDRqselmMwuKI0v+FfCyIWW4URc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y76ffpv/Hl/qPHCl4eqh+xfGKDslzyC9rBw7Hj1jXvve7dRZvfn9wgdcRNHVYrJRdcl2pk8P33TCUJfSh+cPojbhhkDHn3Pygt+XgyFVRVQagOCvyovPrrj7vzCrxHQ6gq0m2ppc21JprVNDXVu0T0nI2kfXfnUlbFLiFgULaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z28ygIIS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z28ygIIS"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3226307787so347864a12.1
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751594033; x=1752198833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAQ6TVq16tZQ6x8pz/0CtqrKxJ7X+TGiOhIJo9QOyHo=;
        b=Z28ygIISkRVr9FffNX90JwVXNbBkCGFKcB9XvfwCzeiRZ7JoZx/WrVY0hpszkKqEM+
         oYC4uDx6oZU9gIgincrQ0ctD3xabE9O1hNbCT6BW/fsCyyYgXt4NWXsMSNlXnsCOh5S6
         mJZTKvni3OfgDhdnU+0Q9jzR+1y/9dOoe3GnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751594033; x=1752198833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAQ6TVq16tZQ6x8pz/0CtqrKxJ7X+TGiOhIJo9QOyHo=;
        b=CDMvPLgFCcysKySAwAzfO4khJZel8Fww4PkAO2rzGNq12DjjqtMvcx/dE0aL5zMoUA
         vVAi76nRLgOlPxb5ZzgT0yLPFipuikJ3uSnncJapjJv85fDjKZq/J2e/QcCOWVlIFhoT
         ouZXl7MTGTXVTUDRKnvRTOdbXMQq+t+p0RV4nLTluRGjhLNWJxGCCE/vDqE+jm/h7qv0
         S/xECZ6WEZFGGJayFK75gZoOPRWQAc7ySxWJkHXeYTpUojidoiGSfsCcJ+tMD7/LwMkZ
         MpS/jh2uRRie4DuvwLnQytLJllmW3D9YQVEpZupCvDyOTiM4EqlGGtJYAxIgyIPmSRTB
         bkfA==
X-Forwarded-Encrypted: i=1; AJvYcCVgahzSmHxupV3ku+2EMTDNpfCt785IoHR4IBghWwTFTlvBDhx04JHYNGiHdAF1cffqMTig+1KfGDvqXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqWaaq/a709Foz/IdLmwfgBg2LgmRd0caKn3nQkQsOKUKJBbN4
	bLdWgvKbdjwk7bnhyhTdNy+oObq8MWdFGwJniJV5mGPVHY+Ed5y7rvdBrNxZpnu34A==
X-Gm-Gg: ASbGncsH51YuIherxcKsP5GdL2qWjTeXwa8lcYNDtlLbODrUkMrJmabljZqxrMqKR5J
	XL7aLxrH5vBjHbtEzEi5AcRnHzPelak/y9AE23p/ByHM4kojnLDkbZQfg0kSi+3tcb7HgvH3MsQ
	HRDJkR02GDm8rk7oHTORDrTEzej8QfqxvP5zf8E6GgkritS5I8XFMbbH2dB2yyzqct7jXeJkEXW
	jQ5i012dRbbNHT6HXqqRF5qq1saKdgPdzmGxuD7WXanMpsudNqXj4VkF/+cMa+f/xl5EuYxr9IU
	aFqK8VdOpt5UuKKoGZujESlym3QWBFqHZFDMpgveItUR2mWi4stkkxnlTBgB/l+0Nw==
X-Google-Smtp-Source: AGHT+IFU4hNoU+sLjwVd0pcP0UOZs85uDhW3yq5YhMO4v88MqVeHKE4G9GMzITqjnfTVpsq+dB4Blw==
X-Received: by 2002:a17:90b:3890:b0:314:2bae:97d7 with SMTP id 98e67ed59e1d1-31aadd43c66mr426877a91.15.1751594032745;
        Thu, 03 Jul 2025 18:53:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:20ef:ef86:780b:d631])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm7578975ad.149.2025.07.03.18.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 18:53:51 -0700 (PDT)
Date: Fri, 4 Jul 2025 10:53:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>, Rahul Kumar <rk0006818@gmail.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: pass buffer offset to zcomp_available_show()
Message-ID: <tgqiahkbc6u6w75rivbishixxq64wfzx6tucscaa3yyt5u55kc@ur62ahdhq4ew>
References: <20250627035256.1120740-1-rk0006818@gmail.com>
 <20250627071840.1394242-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627071840.1394242-1-senozhatsky@chromium.org>

On (25/06/27 16:18), Sergey Senozhatsky wrote:
> In most cases zcomp_available_show() is the only emitting
> function that is called from sysfs read() handler, so it
> assumes that there is a whole PAGE_SIZE buffer to work with.
> There is an exception, however: recomp_algorithm_show().
> 
> In recomp_algorithm_show() we prepend the buffer with
> priority number before we pass it to zcomp_available_show(),
> so it cannot assume PAGE_SIZE anymore and must take
> recomp_algorithm_show() modifications into consideration.
> Therefore we need to pass buffer offset to zcomp_available_show().
> 
> Also convert it to use sysfs_emit_at(), to stay aligned
> with the rest of zram's sysfs read() handlers.
> 
> On practice we are never even close to using the whole PAGE_SIZE
> buffer, so that's not a critical bug, but still.

Jens, do you feel like picking these 2 up or should I route
them to Andrew's tree?
