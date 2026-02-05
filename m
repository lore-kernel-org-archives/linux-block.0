Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16816426690
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306668; cv=none; b=gdVdLQh6Sg3gECcLrR4cAj0dZjsiN1JcFHYtgkkGancYRFNXxIwrGFxietQuTNrtaOrODDAPhemCulhg803v7yEpbLno3DqzA6CH0VmfXVELMbmdkncVBkedw+qzrQfczkrbQPInTsRGscA+qVfyU7e59IXKOHVcXa9dn/HiR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306668; c=relaxed/simple;
	bh=4YPW+3wB18ioNumpqlycypYjvI90HW2o9FBOJh8VZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir+7PAwuds4UWkZSBuO2hTFvBxJO86Z5pPW1TWJklPa9BjeldxO3LhOpFZGVivxIvDxXtjYcbDKzC6aS61ZTA3MmSWdxnitXKE02U4lWO26sFpO/5cJ6dz2i5wqyu2rgOZt5qycxaEFg/6PHZppWhqzvuJSxpHtzj4ljebn7YCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W1S7++cy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W1S7++cy"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4086661715cso813873fac.2
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306667; x=1770911467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSrWcFty1sjoYZPVolSaDN6OMume40OggjC+fPQE8k0=;
        b=W1S7++cytREQZ4m8lND5sNSMj2onqAZe/Xw2Ri6qw3VeAhc31w/5x4N7o+LguiJRWg
         PYXd6mENVnFP+iNtxTjvdGZgUnh6SWKfMIgoAy65ww/sElwupmfbt9e8t9kA8V74URHs
         OK4KPuCIXeMyhax1wFkxHFgiUho+UbEdqDvpAUiCAhkmXTqNO1YConqAOreM7n38DMON
         hIVHKrplXhzGLN+eUy2aoyuoL+sa4CTZeFwFoP7Z+8I39VwHQxUxAFW0Jw3I3c9yPpR4
         fwWDVkTr7hUvDAayb4k8042FvmlGC/+ClT0ClbHWclbKJGdDGCuGDKbRS48u3gRM6hy9
         WvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306667; x=1770911467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSrWcFty1sjoYZPVolSaDN6OMume40OggjC+fPQE8k0=;
        b=PJG24pXiRQGINQdmWtI/ak1rUqx8T+pRvHDAa+HvHI9lv0/UoKKtss7WX+r72dolYM
         ejtDUr3kEPtbSrBsUs+HabEky+MGLWSb6jPTEdNjxoP+BVFWevIg8gOMJOu+3Iy1uMVo
         2R9DCoV+P8ZmMvFE0lA7jgLcIbjCp85kxdAuXsFQ6ElMBH9iNk5MNo8jd7wkIhFXMMli
         dfD6I/v09t8OgPxEljsEEf44Uo8leMbQKIzWT2GoA2ikqcZZ9NSfhhJNNaQi/OE2EUCG
         rrZ+CVzE/9UNnqjXybpeDMmH4PbgxBBVywje1VLprdbwFi1rFKbovuIbLP7hGDFMK+ep
         D6GA==
X-Forwarded-Encrypted: i=1; AJvYcCWkXhFatPoBm+f25ywmrtM9Dele+1UX8g9gv7d17lkjrJ1Kcb23cxIRjPdfS3EUA1j+DBhK2m+2RDZr5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAByTVIxtRSvj3LVTsQ+A1pf962eStPcJQsrxuNbm2MKExlWNC
	DWBOHDwNLsU/zsP171LfJL/oTwdfeczu5wCKVEAUCoIs6GL6wvLkojPkL9vdirYqPug=
X-Gm-Gg: AZuq6aLDNDhqYY+3e3D9v1aQNAEQr9d6NHLpxAwbEg+QHEZI437CXJCxHurit5/66E7
	zL0lDmXJfKVU3qVuRKL4gY1s+UX11Nk3Hrm9X5v3g8w0h9BG7iuAAyAqb4OHVcVhnZGujsEdwkf
	zoh+lUketkELa61L4iz/LoN5FBJztxN0tSPw9hFmSHgxbA0G1vByL2wf9fITevi8pyHCEk+R5F8
	kOy5lj4Kn4cXAEW4gL/CUXspfOvcDkK+wvgk+Ni/yg3s5JMmNW5pLfpal39owQdOpC+0h5bGXCS
	DpgFpHYTntZs+FwRAUlvzdgZ5U9INrM0P0wWzB+j4RycyIoj4doRAaq9RnAa+D7nSAnlLeIPf+W
	vEoiSWcOEm1aZAMc1o8ISpPMxUxm3oA4M0zx/UuiG9RtThEKWCxMSGYfQFiUnD9CEGSOgrRV/wF
	X4Tav+gknHGUUXD8OhWaIz7rumffe24vUjoZgITBz0ztkECym9SJM14DvAXSg9de9gYCDOXg==
X-Received: by 2002:a05:6820:1624:b0:663:f65:1c8a with SMTP id 006d021491bc7-66a2297948cmr3272210eaf.44.1770306667002;
        Thu, 05 Feb 2026 07:51:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a3d3e5705sm3207979eaf.5.2026.02.05.07.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:51:06 -0800 (PST)
Message-ID: <6fae59fb-0dd3-4447-ae2e-e03f06255231@kernel.dk>
Date: Thu, 5 Feb 2026 08:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
 <20260205154922.GA28226@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260205154922.GA28226@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 8:49 AM, Christoph Hellwig wrote:
> On Thu, Feb 05, 2026 at 08:47:48AM -0700, Jens Axboe wrote:
>> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
>> will trigger a compiler warning...
> 
> Must be compiler dependent, because it does not for me.  But yeah,
> it should go away.

Probably gcc vs clang, gcc often lets these slip by.

-- 
Jens Axboe

