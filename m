Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2C26FA6E
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014286; cv=none; b=qpz5/fPsp46QZsS7fnunBAv39m3zXMRpmU36vMualb9GzDnqCVmVdXdJ7e2braKXyDNZKI58UpOpP0xF4iI650LzVlLMfJ3Z3kesZ77WBngWBSuL2KNpeIyYndxKfzmZNKm9E1MP1soBr+nO7GWjlZ24Kz9YioKB2V4uRXKdkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014286; c=relaxed/simple;
	bh=14nh6c/AcOaAhtljMvSmOFuRFWYKTbrmCYuK0tWzQ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKhjz06D2k/2HfKLH79ShTKjexSfs59h9wEWzXL6A/zLJIzvnsoI6cQ29i70RZPIrlT070tK/zTN1Yq4//RW1NdswbsqKDrVTi+0hSCsBmIGGG6be7IqXRAedX+ctIzKVQ1Yimio+HYKMAwDOQR4f+eNEkD0CpleoS5i/sNloFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BWUNM/Rz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BWUNM/Rz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2964d616df7so5392915ad.3
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763014284; x=1763619084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LqphD8tGRygLilDfD3DdZsx92tK0p16bJTr+js2PHc=;
        b=BWUNM/RzYfVS7Wt+F9K6vRvFicJ5XkMGF9bqK1GEfzlfRaqQAGEmRvu4YsxnTTB0aL
         nducuswDOBp+9BwBpKOPIGZg0ZB+AiV4WN2BXfZ5sDqklB/nq2iFIXZMESlhvj8uUF3R
         UJ97gpLDjvkUi1QnT5FK5kuSROHe2rrVkwEy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763014284; x=1763619084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LqphD8tGRygLilDfD3DdZsx92tK0p16bJTr+js2PHc=;
        b=gHMZUfMbdVzBteD+qR+qQiULPOlJ4BP86HifSIvVD/+qvLty1jA32v/BmBgbckqhxg
         eGkd+1CnOzB+lcmrg7fDOKeROfH/E+L3Li7kEzTxEf98T2Asugo8Khiq53fcytkAj6R4
         s4VuR17o2Kk86+s38xKd0082feAwd4+y4ztZBELGqqPRkI77yPYmENYFb5lzEX6nYfbh
         gIv276XfXevQ4ZbpZO5BqjA8kSrhDmkuws+h6pXUFmBH5vx4PsN/QMtSueVm/9faP0kx
         /ohm8Ap/U3Z3PVLLWohAFWaP8LhXgONoI9IpiiBbyqeZ8fLeGib7PemHOhWxyg2yX949
         8/4A==
X-Forwarded-Encrypted: i=1; AJvYcCW867jeEyIA5Obp2oHBEFddoBPELuxABrsCfi/dgV/Gg27EU6KobcZSTNHw8CUjH4MSp1APqo27uyo0ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rde8e2v9nT6yAy2Rm/FJ4LkHumU2yr/UAC668GwY7d/zR7Oe
	teAcpz11B8hxEqi6CVJFFj5h+nAT5hsW6MSagI3/C/5bamnSxrxv49pxyubB4QpkBg==
X-Gm-Gg: ASbGncsbgcnpYOKHLghtpqvV2p1R2ZF/GTbXM53x1D3UNqcUThE4AJg1uVYePwDujir
	qzT/oSxrknlOFUn8F1wt788BZFibEERygzL262WDfFto+lHhUAss1XWuyNTZPVcNmPy6ohCyCab
	v7XYaAUnHP3pF45RqnUQwaQtFtgzQMnb/2VC1vPuvQNRh5rEUwkqU6jfrU7Lh1m74oJAkp4eN/O
	pFt5mjD/3V/21zdTFYMIbhBwnjhpbJQqo9lBEkiZ8Au69GoDmlHA+GQW7MyQniAh2chDoiAmsMi
	89tJAP9vWHabQZhpyOrg4KLxdOPs7G8fkz9JzyHvbmBvVUwzrabKlLOq1hXbja+hy33EYhOi0s1
	gBGDAu8PWgXGNrGDRnyQCgJgEDgvDXWEzy4HrRK/XSIhF1/SwIOfP85jumggFEPsCAfNmYL3m1G
	7p9IqKRwGiO7LkzRo=
X-Google-Smtp-Source: AGHT+IE7hQS37m/XPXlVQ4Foh9+BFb/rN2BBQKZCymZyiayaTIgspcciVj3iEqly3oeCkfBztppdXA==
X-Received: by 2002:a17:902:da4b:b0:297:d6c0:90b3 with SMTP id d9443c01a7336-2984ed6c342mr74657745ad.23.1763014284214;
        Wed, 12 Nov 2025 22:11:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed23sm11944775ad.87.2025.11.12.22.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:11:23 -0800 (PST)
Date: Thu, 13 Nov 2025 15:11:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: add writeback batch size device attr
Message-ID: <otnmm7behvnsbcqmknx45pgonsdvk4fma4o72qui3bjidwfc35@aurhln6nfyyz>
References: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
 <4b7b8f9c68f1a05ec6ada8aa7be9b735eae57446.1763013260.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7b8f9c68f1a05ec6ada8aa7be9b735eae57446.1763013260.git.senozhatsky@chromium.org>

On (25/11/13 14:59), Sergey Senozhatsky wrote:
> +static ssize_t writeback_batch_size_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	u32 val;
> +	struct zram *zram = dev_to_zram(dev);
> +
> +	down_read(&zram->init_lock);
> +	spin_lock(&zram->wb_limit_lock);
> +	val = zram->wb_batch_size;
> +	spin_unlock(&zram->wb_limit_lock);
> +	up_read(&zram->init_lock);
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}

The ->wb_limit_lock is not needed here, a leftover from an earlier
version.  Will fix in the next iteration.
