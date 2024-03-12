Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209F7C0A2
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257130; cv=none; b=IqFQzrgyp0xBlkLQVnp7404WFGhyA8ZDbbqhchjFnSsuV3NNfwrq0SrHVBEuZ8J97MHvRYZ+cvORpg+6VrXC6ZMJE26u5aZgh2FxZsoSQJpjNDUKT4uq1UfS+zSXu5oUo6cbSk3EcJmkapYi/d7wvfaz+J5+t3/YsKvQVd+UH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257130; c=relaxed/simple;
	bh=PEPmwln94NCGEcSeuFbj28c+FOxCUcenqNvHNwIUO28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHTylZuJdcekgnaw0PhrJl/3979LrcnW0tPcUb/Nj3JOhFBaAmKebgi1ihGjaV3yDYbSuueGJGfcvqxOGrS7SAd6vUKYYe7/UPwCREr+F/ZMRZsvuTsISoEGyz/9/WbGEqZKU3A1wJocNCxcLHQHF/8l2X1EtjMR2y0DiXJVZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oGSr+zcJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oGSr+zcJ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e694337fffso189955b3a.1
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710257128; x=1710861928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isqFkNkjh8M6xFgdr2JdEPP4vy/8+U7ze6WQ6bIRNPU=;
        b=oGSr+zcJaljPHYdpRa0ftDSdJjxWefKWf+mW/QbiXI6qB8GXsov6ObWHfQ3Bt2QCv/
         WR6nyCW3ooMzMhW2xVxDP0xAKQ97IjDsYy7/Iuaz8BrcilGUlEdlVJNnruB0/Bsr3nWt
         IAnXx8/y+CYmY1Szm5ozr7A7ENyR10T4/EsQQbjSz1+gFVo/GEzZKQK+kAL3Pqka5cK1
         8PYY5Kwjh+T6AbAOh3eUol7VwcXFuSyDN9mFCP+R9qwwMIAOJJasmN3xM2gojZpfp15G
         ZXPuNtmLKSd9jA0OfYCndG+3FUUrBFWtqPui8w/YjnYX2KCllsepOVCy8MLO4HyzmWks
         ZrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257128; x=1710861928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isqFkNkjh8M6xFgdr2JdEPP4vy/8+U7ze6WQ6bIRNPU=;
        b=nLwxu4nOWLQTSkhuKEm3Zx5+e5/wbrVrBrIkjZI4vNcny8SR5ZEtBct05ax/Z12a0g
         YpiuTBrtiOHkgvHSOVmlwph/m9ypebFaOOkM1fMe3tuwUV6BaObwS26g+V2cKzNzk6WW
         KnkZzdHoHvXZ9l5q+dwC6y1972IlFVfgJKZpa1H4rt0f4zu8rob6JLlzYzh+evDmOy6l
         WGw7WDvW4hMbLS+sxDeopLVOtF5WNZJmFsscHSv1fi5SIutEFxCaeRweLQzJqVTig75v
         GkqC958/SgiLkqq9S48Ze2trNFx+q99+qxRZAO+ZuuJvHTtD2Pt7BwTaXcTfCPlQcQaf
         gxVw==
X-Forwarded-Encrypted: i=1; AJvYcCX16zajTacOjpoVQMBwMod9RpohpbTAuM1Gi+1IlkKajjeYQKKTXDLue5pxW6vYFQ7PbaOMONIVDjDJ9ohZShcXu2/5Dqvuzu6og7E=
X-Gm-Message-State: AOJu0Yy3yMSM39O65RHelfj7vEDbYws1uAu7JducmMZuF9kuXG1iwnyN
	xfHiT6vsZ4bYOVnsbVzB2QNWNbiMLBgVVbVN7yHH16LsSKoCRte50HHIkeKm190=
X-Google-Smtp-Source: AGHT+IF2AhyqUSRGn7ICt11M/QQCwt/RqZb/W44/6GVoQxONm4pbO/Z0Aru2fLn/NafWfmgdXF7Fpw==
X-Received: by 2002:a05:6a20:9f98:b0:1a1:74c9:b66f with SMTP id mm24-20020a056a209f9800b001a174c9b66fmr13590443pzb.3.1710257128270;
        Tue, 12 Mar 2024 08:25:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z19-20020a62d113000000b006e6b2beb030sm320499pfg.48.2024.03.12.08.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 08:25:27 -0700 (PDT)
Message-ID: <1d0f724d-2460-4cf4-a2c1-cd9813856547@kernel.dk>
Date: Tue, 12 Mar 2024 09:25:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Snitzer <snitzer@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com> <Ze-rRvKpux44ueao@infradead.org>
 <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
 <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
 <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
 <ZfBCM0YWewr_KYyn@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfBCM0YWewr_KYyn@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 5:53 AM, Christoph Hellwig wrote:
> On Mon, Mar 11, 2024 at 07:23:41PM -0600, Jens Axboe wrote:
>> Various NVMe devices do have different limits for things like max
>> transfer size etc, so if it's related to that, then it is possible that
>> nvme was used but just didn't trigger on that test case. Out of
>> curiosity, on your box where it broken, what does:
> 
> All nvme-pci setups with dm-crypt would trigger this.

This is most likely the key, basically all test suites are run in a vm
these days, and not on raw nvme devices...

-- 
Jens Axboe


