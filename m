Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D2203708
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523199; cv=none; b=eRSamug57LhM1azemFXDj6zGznGgDU1yRPurnERWUACfXpwLRCMTdBqwSVVOMkP4bvdUNHIap1TYrRwvH+pyGawYF2lAxmrJ6dsoWleH9yHjIvQbooo+0TcnRAWISysNg5hEwEhf2NmXp4AuFq+qVqMdujvPkVmBIa+OqG5ulBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523199; c=relaxed/simple;
	bh=2oozyG9UXwFWfpyRebPhngHz207nrqCB7dySSeD1/u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvjMmGAELj+QaHR/MdE163vHLrmGTZ1v7ZbDdTuwB5RfaGh64DwioYQZIXnb9ZfG/VWac8JC5QgmFnSulzx+bIwZmXunh176ECqQXjV8nDWmp57eSkqWtsB7gDpksa5o7ffF4eGVSdKjfG+NB0moKo31zBt0tOLdeMfgeXICCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t4uyjy0B; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t4uyjy0B"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee645cf763so2272023eaf.2
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523196; x=1732127996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=;
        b=t4uyjy0B5Aj6iDtnrraJnAyhKwczySCCW5Mw1q+I/zpXOQTdm+icnYteLDSTwawV4N
         XZnSXbYEyXPwSP9HPWJUYKppbFD2YMHOhL4Xkk4G6elv30iv6tnR5E/G39tVYTBwaA8j
         Q9wZdw91hIFkz5J4Tv9PtUvKXE3EVBArUVq4sauqt3dYBuh3NZaxl7lt19wvkjwCujzU
         GCsj8iohPtn+3sZMNYfLbwRuVX7hqiddohT+G/3KIMMpPdOwZY8yLbUgiswrED+EBnZY
         210m97AHwGFxi/cYouPgL2OX8rQZh2xMUpo4j1rOeqtO6NFTW1gFYgAjcGLBQOOrKhfn
         uQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523196; x=1732127996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=;
        b=Wa0uozs09nwbFaIe+bv+fMy3fyskSc6AIYP6xtGEjl3i46e4sqHCaketzCF+cTiMLT
         h7ArioNHn2mP0cTDoizgzj6rGVGJgx3aqS6CR8+0ie/p7KbL3Y/33LNI63VfoRySAXwY
         j8vpre5JAobISkFY4fE5uu1DeAtP0YjRXA/i8rvrrh5zzXb2usKrZYq0J45dfYJy0jHz
         xEJCOnT7HPZfxnIgPTGRzyfTxeAtgTIv23gG9p2v5alE6vRZhxLRHDaUIWK/4IPRCJkP
         aCYktDd2j8jGZmwAVrPJRINcSobTSlcayRbiuBTjWqwg+TfmTsy+oAwI857q9e2KVNny
         lC5w==
X-Forwarded-Encrypted: i=1; AJvYcCUWgFCecveRiyYf4Xl0eN85f1OYfUtw2wnuhzoCci/1p+4YEYhuvRqWFv23wHAZoH3npQEO3ndQ78ueFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23RtxeYlMteTxiC+Ed0nQDvQ/r6NZ4o+t3EFwyGv4XDTBjW1O
	ViXLlkMCN9ZoMDsYK5AeT84rgyIS7elSehBz+cnRjpfXx32qJHEpebV5k6Qv3jU=
X-Google-Smtp-Source: AGHT+IESBxgtKu/tqS069ieokYdQsF86VTGk5XXSX9JBOM6NYNLoE/FOQHmxs2aJ76kIzJOEXUf+Gw==
X-Received: by 2002:a4a:ec4c:0:b0:5e1:cd24:c19c with SMTP id 006d021491bc7-5ee868b0bf0mr6129208eaf.0.1731523194524;
        Wed, 13 Nov 2024 10:39:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4950edfesm3141888eaf.14.2024.11.13.10.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:39:54 -0800 (PST)
Message-ID: <ffe1f8e9-5484-43f9-a410-2927d0c63659@kernel.dk>
Date: Wed, 13 Nov 2024 11:39:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 11:33 AM, Bart Van Assche wrote:
> 
> On 11/13/24 7:20 AM, Christoph Hellwig wrote:
>> currently blk-mq reorders requests when adding them to the plug because
>> the request list can't do efficient tail appends.  When the plug is
>> directly issued using ->queue_rqs that means reordered requests are
>> passed to the driver, which can lead to very bad I/O patterns when
>> not corrected, especially on rotational devices (e.g. NVMe HDD) or
>> when using zone append.
>>
>> This series first adds two easily backportable workarounds to reverse
>> the reording in the virtio_blk and nvme-pci ->queue_rq implementations
>> similar to what the non-queue_rqs path does, and then adds a rq_list
>> type that allows for efficient tail insertions and uses that to fix
>> the reordering for real and then does the same for I/O completions as
>> well.
> 
> Hi Christoph,
> 
> Could something like the patch below replace this patch series? I
> don't have a strong opinion about which approach to select.

I mean it obviously could, but it'd be a terrible way to go as we're now
iterating the full list just to reverse it...

-- 
Jens Axboe
