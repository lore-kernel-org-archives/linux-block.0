Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C735FC2B
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436894; cv=none; b=sG2ln8np4nkIMrihhI6/3CSvG/mCu4dRkzWk3dzmBS/wBnalv7HBNygog+ApfO85xCOR7kI+wLPn46Juyd+sc0uAZHQ0cMWA1bXsuP+6hAFU1jpUQI/0yROg8QHU6iNfLeFBNGpNulJxcRPGSGzjwvlsXXWnXfdTKU85Pfovt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436894; c=relaxed/simple;
	bh=8moNhnCpo+ibfT8SqGcbY/meCeJlNxr0nFhr8dZUHrk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ffc0DsP62XIA9jqp3mWkzdMR1bATWk6S4emIAqC2xWPlPQVQQxpS52TnBXarDSHWuZJ+6k5hcHOn4AQYXWZF+GZ6L/Bl9iJa+Ctkk/HkEJyt//62/zitwdjETGSxsqThmWdtJbg0jHKguOc1k+PWTUM39ZIZhdRkzoMmS0tsPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z/7t+HMM; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z/7t+HMM"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88735894d29so211236339f.1
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757436891; x=1758041691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C49J9hT9+9MuoCLpopUPrwV6UOYV+5aUJs8NoPNanOA=;
        b=Z/7t+HMM/dSgYkv4vyzfnr6yQ7EEb9z2fCNucAGygTI4zyzpowZDclDftFrl0Zhguq
         iADqlgux2+ddhfKNN7pWuvsKArhD+1MKjiautODL1n6WI+32r7McmLkr69P8azgSDxJe
         T7Y0J8UH7bDznEakvfKLcYGGQkzyT8KvUcH0+jL8pPMFxX7GeG2QrAHDUAJEMsZdDGl0
         MtUiE4WulHmmuE009Df03+43OAeUqvNw/Gmh3o6YUVXbDFmT+c7AHao3eGXbn11XTwNv
         cOjEF7f+2CKt1pCNkVS1o+i0hqVdD/mRikk/9f//L5FsnaLOfB7bCtxQ9CaIN6/F1h24
         nQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436891; x=1758041691;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C49J9hT9+9MuoCLpopUPrwV6UOYV+5aUJs8NoPNanOA=;
        b=IS+WM7YAKTqNC1/Pv1tq0NWafPPk6IbfP3uYq2rePnxrh7J1+xKZOvikKfK0JUswSe
         dDLs8Jm+FczJQzg0qDgHyAS7YUNB3qX9P67aVPad1XaG/Rm3PdvKJ7YOVWyNrdrUx+gR
         3UCqYOI2qPIpcgulNTHnXqjRy5+QITTa6NuwR18zIEOkYe47PFSP5ElVqfqSZZuNCZ0J
         b0XvCigMozJFTxgv4YsclpKSjl/MC+yVdFEQZMtfazyjljW5CrzOZu6dlGhToQgWA+Va
         TPljDGpstfxuGUwk2NSq46jibQk4zNJGwIiZrHQMH+nj2PVT+sRnYpuIulKghnT9JzMF
         BPzw==
X-Forwarded-Encrypted: i=1; AJvYcCUxNkbIQ2oKEj1F9ZLCltzrmrkT96JuNG/PSkfQjeosCoF7KjmIyUmZp1irggNeip7BTKQy49+G1ZpdEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAq6xxLls+2nGzHrb762OZsBs3pOOkX+KgZRvIsCQXtQEKSLc
	tfm0Xy1ZJ8o6wbCRchtPxtAHbIyfM7vWh5nVGYgwBnHz7N3bKBqLA72o6trBC5XGZmo=
X-Gm-Gg: ASbGncsIKxG/+bftTcnzyvCdPS7q2MwwkJW/A96my+b2pBARDuNG06pal401+lcVdxQ
	CFC+ze58ZRMVgQs5cXGM7IJbAVY7feGBOdr0s8eWCFU3aoODVgsA72Pa9KpkUyErBjvknC6hB+H
	3GfM8+flGkUW2nUKI6fzOPRSly9CXclS5OyVP2wUWVgnvWSVHgMMmycY3qsnKuAJvfRA+wgrvHt
	ogoyUoOSR1EyHDTSSEiG5amc8i7IdtdBqEZx88JOVnYCzKwIvopI85vG1SJg99/dkHptVU5nZC/
	IZBUDJm3lpCQaj5siYH2QsxFsjBppXhwArznpjCwR9YwCH3ZgYayEV9xKekAWJFVgsMiRZ5KEDs
	57hZpUHTvEDWjNByrMUZ4gR0Z8JqH5Q==
X-Google-Smtp-Source: AGHT+IHDKi3qrGo3AIzAwShb1AAls6C6/eq7V17Dk9630yH3W5mGOBkjis9cwRpG+acfT+hqW6BaNA==
X-Received: by 2002:a05:6e02:2186:b0:3f6:5e71:1519 with SMTP id e9e14a558f8ab-3fd7e624d08mr195943645ab.4.1757436890884;
        Tue, 09 Sep 2025 09:54:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f3a96efsm10088586173.72.2025.09.09.09.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 09:54:50 -0700 (PDT)
Message-ID: <af63883c-2cfb-4cc2-8b9d-979ecc5187f5@kernel.dk>
Date: Tue, 9 Sep 2025 10:54:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250909
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, inux-raid@vger.kernel.org, song@kernel.org
Cc: linan122@huawei.com, xni@redhat.com, colyli@kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
 <a56b2c76-e254-48bc-86a6-8beb47ac79ff@kernel.dk>
 <fdfcb000-916b-4599-b75c-1b4680accca7@yukuai.org.cn>
 <16a63a35-9a44-443a-8f59-e60afbfbfff3@kernel.dk>
Content-Language: en-US
In-Reply-To: <16a63a35-9a44-443a-8f59-e60afbfbfff3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 10:51 AM, Jens Axboe wrote:
> On 9/9/25 10:44 AM, Yu Kuai wrote:
>> Hi,
>>
>> ? 2025/9/9 21:26, Jens Axboe ??:
>>> On 9/9/25 2:20 AM, Yu Kuai wrote:
>>>> Hi, Jens
>>>>
>>>> Please consider pulling following changes on your for-6.18/block branch,
>>>> this pull request contains:
>>>>
>>>>   - add kconfig for internal bitmap;
>>>>   - introduce new experimental feature lockless bitmap;
>>> Can you write a bit of a better pull request letter? It'd be nice to get
>>> an actual description of what the "lockless bitmap" is, and why it makes
>>> sense to have it. This is pretty sparse...
>>
>> Of course, details in be found in the patch 0 of the thread. I'll send a v2.
> 
> Please always write a decent message on why any pull request needs
> merging.
> 
>>>>    https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909
>>>>
>>> and this is a new source for you, is the above tag signed?
>>
>> I thought they are the same, I'll switch back in v2.
> 
> They are very much NOT the same. One is some random site, the other is
> the official kernel infrastructure. If you don't use git.kernel.org,
> I'm definitely not pulling anything that isn't signed by a key, and
> that key in turn has been signed by other people I know.

Oh and since I keep getting these, the last 5 pull requests you have
sent me have CC'ed:

inux-raid@vger.kernel.org

which of course doesn't exist, and hence the md list doesn't get
your PR emails, and I get failure notifications when I reply.
I'm assuming this is in your scripts somewhere, and I keep
thinking "it was a typo, hence a one time thing", but no, it keeps
being there every time. Can you please fix your script to use the
actually correct email?

-- 
Jens Axboe
