Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BD7E2
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206626; cv=none; b=YQVKcgSeWyY1hzKcfdOcSBk4f+51pu1TmSznmmYFtmvPHPH19/ohnauQxpsIfQCoumuWxCXkyrCQbO67qWJKsYZDh8Rwbm4KGNzV/Zzkc3XzjRFkB90u137ZRyp8bBI/aN+izpjsZshHGAwWFpbd4yZgNtT8ToIB3A8Us/T8Ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206626; c=relaxed/simple;
	bh=exjgPMXoma8aLaufwMRyswe+2/cnOy3HOcgHjpry5EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTQtPYn1ImX7W4nQ1nRpE9/kky4We0Qg9Os9BkhhFjY92GCb+XB5f0Waf/02ApoMqN+e7I0oHFVczGFDgpVTBUhyaf9EEzyiNMqHsFxaMZUigF4grmOsJTbG9YuHZDrcwNip7e4iEgu4kmSAEu+w7cFGJ8B3kW4a5qmWoL+Uhv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LzvR1S1v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LzvR1S1v"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcc0d163a1so10678655ad.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710206623; x=1710811423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dB97wSMwuvG5q7IYfJWXB3Zcy4rfTgiBt2qq/cGjoQE=;
        b=LzvR1S1vcGcdtGpy0I4gc1gB/N/Y2feTy0Aq64NbkyRt/lMMRJTtNw+2YpPlvqO7Mr
         wuuju57w9os2+T2j/Yh3ydaF6pJ1oAqKsq6yMPTM0k7ARWkdg5NPQ4M1iPqOaPWkUV7n
         7kQPf8Dtjv9xnzxtqqS3lRrBo7epuyiLgGFAcsDcFy6uOxT6YdeLiM2Tzr7fWkVbfqxS
         lecgMch1foXFeLylXgCZiG9rIrEONDi2FEjbt+d0IupzKqFv4qz8pavG3jhfI2isV8cE
         IJ25288s+RMzqLyPjgl9dC66GLvz24q79YgNdnJxyJbEEhRuRiHGVe+Z+pjsL2fLMygz
         k5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710206623; x=1710811423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB97wSMwuvG5q7IYfJWXB3Zcy4rfTgiBt2qq/cGjoQE=;
        b=trBYrFGegJ1mjzj99DqMek27qxKdmZuCnA+kbfsDl58yVjPUZJYWjxw7u/uLF/Xusy
         d8t7lIErKpWSOsmz4SINR6cm8VtGbDXrO4/lPuQ0zOlppHitiS8HM1IzpKSMBGtTMcSA
         5YOVewpDc6DUaXRWjVLQDQiFc0aVf5oS0LqBPrktI2xxFB0lefpo6aT5mfNY6PLYzPhg
         Ll+BM90HSv/JAQ7QSIRN6Ktoq945s9P+6u0dA0Dqm88ceW0cgzhPmcR8Cg5bHTKQPqaD
         w3XRXskJ9toornpQFKNeAi7xHWGnsDIY614gsURYEKKrvmM1uoxK1fwo7Xa7wFJPBpQ2
         VOqw==
X-Forwarded-Encrypted: i=1; AJvYcCWN8fuocHllXJYkCYrfMB5Y/ynK9/NrCq4sjJ04itoDWeIEKyGNhqwBSPjqLp30WpOzlwpzyrAwmYg0dev3CGKvypPrEAVSQRklMgQ=
X-Gm-Message-State: AOJu0YyZoJCo3P+X4U4VifFQQ5g3p5ASQnd+CtoPW3D0dsx0tM/BIwhh
	noTZoVM/GUUFkpuPM8GxN0okHsfMgqSrre3x96FUHDKY6qTbQafqNtMXcy+tGMc=
X-Google-Smtp-Source: AGHT+IFBRlWTOAh2TUExTSCoBp9Tdmf8G9ZQzluPr8gcPoWbNXdbzQ0TF0aLqjygX8zxg0hq2DERFw==
X-Received: by 2002:a05:6a21:3a83:b0:1a1:6a7e:6b58 with SMTP id zv3-20020a056a213a8300b001a16a7e6b58mr10455607pzb.4.1710206622979;
        Mon, 11 Mar 2024 18:23:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090aeb9200b0029bce05b7dfsm4382114pjy.32.2024.03.11.18.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:23:42 -0700 (PDT)
Message-ID: <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
Date: Mon, 11 Mar 2024 19:23:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com> <Ze-rRvKpux44ueao@infradead.org>
 <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
 <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 7:20 PM, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 18:17, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> That does seem like the most plausible explanation, I'm just puzzled why
>> nobody hit it before it landed in Linus's tree.
> 
> Yeah, who _doesn't_ have nvme drives in their system today?
> 
> What odd hardware are people running?

Maybe older SATA based flash? But I haven't seen any of those in years.
Or, god forbid, rotational storage?

Various NVMe devices do have different limits for things like max
transfer size etc, so if it's related to that, then it is possible that
nvme was used but just didn't trigger on that test case. Out of
curiosity, on your box where it broken, what does:

grep . /sys/block/nvme0n1/queue/*

say?

-- 
Jens Axboe

