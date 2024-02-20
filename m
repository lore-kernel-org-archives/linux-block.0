Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614C812
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708387408; cv=none; b=rEWVjr/jV6vB15WLPXt3z7cVgQX0FKuiHztv4Ex3Nu+/0Gw2IjUaDWWOvkiruvi7SI/6S8luCx983DpfT94TpndlUzBn02VYTDU7Uf3u/PcGDR3tYOjvbS74bJ3N9a/qHd55k1Axi9c7Enw5c5C84BE6QQ5yg7LhVj5YecOepog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708387408; c=relaxed/simple;
	bh=g+K1GjdA27v+0emh/uFAdJC+DXl5udJfp38W1FDg9Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO3ghFfwjk6da4i+HCULdgvcDVYsyWffV9quWg92Su6MmUEU9hBImDomK2i04nn8BmCACvcSR0nTZt7NQhyP/QZPAmPeth/cH7C1xn8laOmSGYbSGS2mwvbWw1t6wSUIoIPxUHyf7vpc4U0Rdw/UlmPFq9QwfPXy5nVJyouM7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a5qFwoER; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a5qFwoER"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbff00beceso2528375ad.1
        for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 16:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708387406; x=1708992206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxqRc1T0n/6Zj7sWH7VsJIMtzaqN1KEnhMRvfQm3mtg=;
        b=a5qFwoERLA49nrRqpHSb3brrFH3EeROTJy8Xczw4Kq2mMyH9bOS3nxwnHEG1UYWaNY
         tqHo5BeA50XnwQs9gXFJmos0qokZVk5fu1u0QLw6y/OsiajS2tUPnYdrKRlrJ4L1MObT
         odt5LwtRbtYkMv29Hog622NdXMF6Nx7SbML1xFrDpjEg5QxoAKIDejqZVpt1j9Tmlja9
         v3RHhMIoQNuliqruGNJk/RPZx31/Ls6grPAbOKOlBVXFJmvtAcOTs0XyhHmVgEIq6gLE
         KRnecmgIeGL2GD+Dtdn+U9cH7AbkFdGr07s4eyRcsGa4v1E26yuuhdshCxQ8P56Pw9sS
         fl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708387406; x=1708992206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxqRc1T0n/6Zj7sWH7VsJIMtzaqN1KEnhMRvfQm3mtg=;
        b=K6LW8IRSiIEX+tL+4CPfs+ktPgHRVTBU/dmAj+UxIcFEYae6BBKcKixM+U5uVnElDI
         UiogL7AOnnw/JoP0zPWZQS+I+qjj44SiNcvrNzd6j7RnlgDNofnORkKNRGY+fGApW2zP
         W1l3t4jc5xvCkPnUB87Sk1W2mE1DPIqRxqzh/hbF6z8IGM4R3pLWLNZ/bF9c5pmLkucS
         ZoWG7UXzm2eiz9vWgofx88bDszXZJ23JbKC8HE+weRQQrvY4FKmIAdRPuk4jZKbnhwUe
         mGa0NC092JxRYtVra3mGOMxs8L8UsJTOOg4OlRJprnD65rm5AFoDoa9WIJSnY/Xr0scP
         2whg==
X-Gm-Message-State: AOJu0Yz97O5HfYs3xS9GCTcMXsPIfCqpzthLeWr61diyo3jPRjwvLAV1
	wFfvEeGixGBbXZZ27CQwUMSxGylodG1+Yy3+5264kEVcfWkIPXVAeF7XM6Eso3ULj2irHE2DHtD
	P
X-Google-Smtp-Source: AGHT+IE1uhoRrhI4mg4WpUSeBlgG9xvYNQPH8H+VugytKaa7saC+fhbovWJ1kQAvKtrQn86/vbAsVA==
X-Received: by 2002:a17:902:b688:b0:1d8:dcd2:661 with SMTP id c8-20020a170902b68800b001d8dcd20661mr11809588pls.5.1708387405974;
        Mon, 19 Feb 2024 16:03:25 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001d720a7a616sm4903782plh.165.2024.02.19.16.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 16:03:25 -0800 (PST)
Message-ID: <e13b4780-0cbf-4876-a5fa-bd07bfc41eb0@kernel.dk>
Date: Mon, 19 Feb 2024 17:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drop bio mode from null_blk and convert it to atomic queue limits
 v2
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240219062949.3031759-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240219062949.3031759-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/24 11:29 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series drops the obsolete bio mode from the null_blk driver and
> then converts the driver to pass the queue limits to blk_mq_alloc_disk.
> 
> Note: this series sits on top of the "pass queue_limits to blk_alloc_disk
> for simple drivers" series now.

Patch 1 throws a reject in a hunk, and I don't have time to fiddle with
it for now. Would you mind resending the series against for-6.9/block?

No rush, mostly out this week, but will tend to things when I get back.

-- 
Jens Axboe


