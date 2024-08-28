Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF73199FB9
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856605; cv=none; b=GxZhPTs43ns2vz+YfKBFBRxUgzNiLs7SvKN4/Ws3oBXfcS2sd7JvrEglLu9CVXBQZsKvDAlMLzjFbSequ6YnLrh7cw47MGU76eCD7jlKQUVNj01RKGSovoOtwJOgEY5GW8jRxK4M8/UxWe6yZfFF3ZJM7kfA4h6Xq1xwhW4sX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856605; c=relaxed/simple;
	bh=J/jwHT4zbJgGObXt+D2j/0zzLiAWfKkvbdM+Ta6bS7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJuzrnrT1G0RTBQLlsWSPp5OgV/4RztzdT1HcjxzpdlZw0I3+ONcI3r3tntwIWsFVDOlUCtkpA14Yp5jkobmMlxDfvlTyaXva/bOD2QjpPB8UmkyJQrT3kB54bcQMxP8Jp1T+5RS1sLWhK1JPhbii3TOHJQ6h9V9q8mEHTSM9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TjpLr7zm; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TjpLr7zm"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d21fdc11bso24032055ab.2
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724856601; x=1725461401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkLMtpGIw3Y/dhXXuYhIUT4xTca0Ie89HWp40We3Xeg=;
        b=TjpLr7zmxDKYik9nmetyJQTPQ9slqpYnCX+aBlaLqojZBLk7IRhTLRpbZEP3Q/pTZ1
         ebGzhjX07IssLxwUhGJ8Kl13VjMprmSiPuZV+sf1UTpkn3Vn8BGewden42zQkJJFVLuk
         0jOr4VgnEQnr2nLyhDhKB8DwLq53k9VxkNlo1mO4Sshpr9BRe7a1fFT9jOX17l4beRKV
         g/Lwhcc+uCFPAXq5o/i+uK7tih8uZTtFTW1aMNZs6RXkC+5g40SBWlPr9PlBEAOGgV2n
         M448MMMOd7lvgdpHrdNJv5UcLLZkiLEorqY/Jj349ybOM0uL8I/cQSmto3/GpoMdbfyS
         qoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856601; x=1725461401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkLMtpGIw3Y/dhXXuYhIUT4xTca0Ie89HWp40We3Xeg=;
        b=jDhvfQwzgbbWYTjPy+QO03LlzkQsg4c1nYt2kGmJPwHBgP2g5HWSiGYLPXNHaD5lY9
         1bAOJcQycCViwAV/w+qQmzIN+1Fmfcawhm0K8n89FFYczqYC9EI0SqSMKRw4SCi6EJjO
         0wxRGHBwwjYJYeU1F12TPtAiNr7BrevqZPpuMfvA1URz96+BbXM0yFAZXy3rhA/CUnzj
         wlx3T4XrmCDHkF//4EJa/oOLibmHimmUX8peUzmuOkrD3ziK1e4gHuQoIe0SqkJ8a5qI
         BpkhyJ/qo2XmmOiMuqxUv+pfQdxvnqBArJUNlacswTaIUgvOFk5EjEtTU7nBjpNFiDPy
         wM4Q==
X-Gm-Message-State: AOJu0Yx3rf2rVBz5oSxjp2uDP7ywzM9MK8i1FthsU8WWE6a8wpCf0qKq
	8K/VJGlmKvauA/aXhjwqnnLic7wnWjbzrCrhcMOp8ePYTVbwfJW1zwOnD/JZ6KU=
X-Google-Smtp-Source: AGHT+IFBscc8IYAxjJLTBWjrXmkHgdjkc3wJmP/EHCRSuAoFvcdmRkkoVZFsL6zQmmMKLOgkxkhFgQ==
X-Received: by 2002:a05:6e02:12cf:b0:39a:e9ec:9462 with SMTP id e9e14a558f8ab-39e3c976ba5mr195862795ab.5.1724856601103;
        Wed, 28 Aug 2024 07:50:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f376ff875sm34085ab.42.2024.08.28.07.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:49:59 -0700 (PDT)
Message-ID: <bc192dc5-5db3-4cbb-90a7-91b13ea7d0c7@kernel.dk>
Date: Wed, 28 Aug 2024 08:49:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240827185616.45094-1-pstanner@redhat.com>
 <20240827185616.45094-4-pstanner@redhat.com>
 <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
 <189ab84e8af230092ff94cc3f3addb499b1a581d.camel@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <189ab84e8af230092ff94cc3f3addb499b1a581d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 1:10 AM, Philipp Stanner wrote:
> On Tue, 2024-08-27 at 13:05 -0600, Jens Axboe wrote:
>> On 8/27/24 12:56 PM, Philipp Stanner wrote:
>>> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
>>> the
>>> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
>>> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>>>
>>> In mtip32xx, these functions can easily be replaced by their
>>> respective
>>> successors, pcim_request_region() and pcim_iomap(). Moreover, the
>>> driver's calls to pcim_iounmap_regions() in probe()'s error path
>>> and in
>>> remove() are not necessary. Cleanup can be performed by PCI devres
>>> automatically.
>>>
>>> Replace pcim_iomap_regions() and pcim_iomap_table().
>>>
>>> Remove the calls to pcim_iounmap_regions().
>>
>> Looks fine to me - since it depends on other trees, feel free to take
>> it
>> through those:
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> Thank you for the review.
> 
> I have to provide a v5 because of an issue in another patch. While I'm
> at it, I'd modify this patch here so that the comment above
> pcim_request_region() is descriptive of the actual events:
> 
> -	/* Map BAR5 to memory. */
> +	/* Request BAR5. */
> 
> 
> I'd keep your Reviewed-by if that's OK. It's the only change I'd do.

That's fine.

-- 
Jens Axboe

