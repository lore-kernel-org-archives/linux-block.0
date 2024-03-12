Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBEC1842
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207432; cv=none; b=TqTjX+qE1Rhir+/ujRbsEshLJdm/warq/b7BMKjIPlH7QtysnhrS4eqBEj4++SrQyq7/doc4G983uyLthEW6W2pitHLyzGj8+uBbxnKLUj7UcZtvZZEvPgd7SHyHglhmhPlTC9fNQjvQ+P44Pj0YwslgJOezfITtX+Urk/WQ5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207432; c=relaxed/simple;
	bh=xRDxagDj2g4dx64HcKlkf/WtEWhS5WJXwe6axVsyQR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvmkfya4Qa+W3RrItpxYKu0giZO6z7WFQAMIFtFjvPFuG4DXFtdL+O/qWpQ2Hrzgh8L92zS0RNvT6117IHcIkXjisnyKLDMheysh0v5oDPXlUzxjjlohsbAYLI3jywYbe/CU9ziWhnX9AZ8Vb+pDr5YWCLgozUAU0bBvP5tDQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tGL+QF/G; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tGL+QF/G"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3be110bbff9so1330213b6e.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710207428; x=1710812228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpBivoMbxC0FxixceNTiUvPBecYlFXCF/KKDHHweAUM=;
        b=tGL+QF/GcRvRzwgpPxohN/Nw13+n0xh8/6lsvyjLw9a/Sc/+Nzsh6NIKZdII8WcrDm
         f4BXqITe8YGF5i/QscEutoKw7QEREf0uTXhmDulpj87Vfo7+cD4zW2YdjumizO45daym
         4IXJrntUEX/tqA82rCE0mKPDp4Jv4cKkCYW0oDbZ1LbP8BaPBgkFM/dJ8wd8eh+oknL/
         QnjedrYQUGdYCG1m3ptE0t7LCjA3VefguWJUAlL7ViNwpQRBtN67ST/Wl5L2ZzgnTXbb
         SfJFQ+UlwVcjMdRfhElsQ9rNpSycc0htQZA1C33B9c/TvH+l1QxLBsOlAejxhlIA+r0p
         qBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710207428; x=1710812228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpBivoMbxC0FxixceNTiUvPBecYlFXCF/KKDHHweAUM=;
        b=AH2lg/xvALq6UXbNfWR9Eh3RPM3DRR9qyK+3+HeQQJtnuYvQBNQBJfgz7oIDe9y66q
         9+kRE8BfyjFYxNGX5YxCp43o2maKqR7WZ60lNTPT1pKqSC0f6rH4bU0WAxw6gGNJrcOK
         DdfEN51oY0wADdfM1nd7RURRZyAebj5GJRbx0fQ3dcAWYUImVXa5rJHZ6z/cXnNatseF
         LTQ6QSLjo9m23hBZa8aMiH78x3QZN9piJ2Mjpnv9U5K89qsp+2CD5EFQSS8ctWr+FPZn
         SK2QBV+4wDFR5D7wvQuQnuYh8siDhfVIgFpequcULJeHsHVhyzfxr8NhfUfTmUBpAFC8
         wr/g==
X-Forwarded-Encrypted: i=1; AJvYcCVrBBLuR+MyLBNJjwkuMM6Z4kx6kcuvbKV+bs6N0/sRJrI2jMcoKqSi4/AB8y/jlIXMjXFsID/7oMRiO25n+FptLwy0JIiMRzI7cJ0=
X-Gm-Message-State: AOJu0Yxbk3hHJAbqTeyY0wOtSzsp9bvTYlJjTdY8jjEPl2vmvViQAmk5
	SPPMXa/exUqBbkLY89u6Fxew25ZN7CEqbSv81fK6+QldJ4fny1zngZeUhh3bls8M0JXYokrVDwx
	y
X-Google-Smtp-Source: AGHT+IF0Y9RlgrevFxnIrkvGu5WwmBrTPXtSamToZWuERTWGjdwFMLbO1VBg0ykljgkkzlB/SXAHgw==
X-Received: by 2002:a9d:774d:0:b0:6e4:f422:a512 with SMTP id t13-20020a9d774d000000b006e4f422a512mr9455785otl.3.1710207428520;
        Mon, 11 Mar 2024 18:37:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id c11-20020a6566cb000000b005ce998b9391sm4231329pgw.67.2024.03.11.18.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:37:07 -0700 (PDT)
Message-ID: <9b957380-42c7-42d8-a95e-88ac083e3ffe@kernel.dk>
Date: Mon, 11 Mar 2024 19:37:06 -0600
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
 <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
 <CAHk-=wh1wS2fvZjWhLSR6t2h1g+PX-fp=zD9e-Fke3FPWtrGXg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wh1wS2fvZjWhLSR6t2h1g+PX-fp=zD9e-Fke3FPWtrGXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 7:28 PM, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 18:23, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> What odd hardware are people running?
>>
>> Maybe older SATA based flash? But I haven't seen any of those in years.
>> Or, god forbid, rotational storage?
> 
> Christ. I haven't touched rotating rust in like twenty years by now.
> 
> I feel dirty just thinking about it.
> 
>> Out of curiosity, on your box where it broken, what does:
>>
>> grep . /sys/block/nvme0n1/queue/*
>>
>> say?
> 
> Appended.
> 
> FWIW, it's a 4TB Samsung 990 PRO (and not in a laptop, this is my
> Threadripper).

Summary is that this is obviously a pretty normal drive, and has the
128K transfer limit that's common there. So doesn't really explain
anything in that regard. The segment size is also a bit odd at 33. The
only samsung I have here is a 980 pro, which has a normal 512K limit and
128 segments.

Oh well, we'll figure out what the hell went wrong, side channels are
ongoing.

-- 
Jens Axboe

