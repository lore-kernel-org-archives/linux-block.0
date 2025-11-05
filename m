Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D7315D48
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355045; cv=none; b=mVv4aCDlnd64nKy6ctSAxgPicMZB78YWhd9V8v1FmP34H3KkbWwCgtZjUYWc5M+UWIw8B9gOh/7whoaQ00nCwr5R0LX1NyrSBjrCMslgXjj6UiDa8l2bLRX05I5YU5pE9HRlMHxbuvAW3k2UCLtiNDMhCS9rwfLHHURmBQlleUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355045; c=relaxed/simple;
	bh=DwbkR7GNTcK8S7mNNNtUjgZf5V2Rsdo7eULVd5Q9fLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4zMxMLENvndcShE4t3ZaxY+/7N+iN7nR3p+R17zsXp+s4Irr1+YXygDA9EC6lnl9VoIP9BorKEp0GmvaVXiBnCJWdUV7LvekynEwWlpKLj1UrzTL7zkLOqK1P7wjwWEeww4hP0QYCrzn9FhtuzACEVf3Wr5v4xke96MfRwaNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XbuCGRHz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XbuCGRHz"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-431d65ad973so27152135ab.3
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762355040; x=1762959840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EA1igfeMg6bszgg+lueg2P9pgXqokCVOCGQfM0bVb+0=;
        b=XbuCGRHzv6ZKRwLKhZG11R/nCAGiWMk5HPuZxkzW9rlpq1H5j7zOXby1ZpFaLbhHVD
         XtM4jMz2RtJOqfieP6W+K65M2ESqfQMM4BuUY8QtsLTV8318vYGah8fuMBzSeAAvVVid
         v3DyucK1QLPlw04TJxRuHevfAWJxEFP2nBsv3q8Qqeq0ed301zpeYbDP74OE8NIy18/O
         iVXMqqvAF2IAmJggVN4l/9k2c01z/vQdACE4C32PZtXmUUfK8kKAZ9V2A+EaKUMHxPeV
         cTUWOrVWQKDeq4pSpy0R8Xj+v+ydrEHOV5t00+Yaoy0R7d4o4A7O9MI2+TpkDmkZd7Fi
         M8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355040; x=1762959840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA1igfeMg6bszgg+lueg2P9pgXqokCVOCGQfM0bVb+0=;
        b=woQMmkBdzXL9caGYfpiy3qULTYLatkd9ecMkBWvFfbGt151V8kyAP8pUAMHRXlyd94
         CPlFWzOUH0PE3jZOx95aXLPScZct8jMEPsxaAcV6xXjzU8aNnrvXiMslhoCVxGoG6wr6
         RDOf8FE2ZzO/70Rp6iQqMvsLbSjm3VSKKEQzh/Fz/EkJeyf3dShFrgDIiobN35PxYMih
         lECHZFpF5FJEcqHohcH3JYh3XLR202B135/D5oGmGx+0fmdQat0GfFxyRL8bhB9BOHs4
         S7rJndSF2gOuf7k06pPAAHTdsOMUWARq6PGJlODqIt+FCuRY3Cw0ierQ1/lRcqgJ8QbT
         EsmA==
X-Forwarded-Encrypted: i=1; AJvYcCUi0iwd2KCLq7hMXZp/ZCGI6ubD3peuh9U4RQVCVbFUUZZIhjH6UB1n3XkAOw4tXlx0phuwSqCuw1Kjcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+XPCFBASXzoKD4S1UprBCzQdRR1aQZkq6cZyqndk/iXSFwdB
	HSCVWppKJ/kd2DyH5IEOmYNiSPJxb/FsXQvCkv47FKKY2uA7pvioT+olusU+76WUxnuHWpPSUwD
	BD7My
X-Gm-Gg: ASbGnctDTIVdKyOQYDWIR0kGMeGffM0/+QBx5V5UOfSEERDX7+OfTwQroqy+Z9B0yeC
	53tzs5vB8a0krDwjZ8w2vCPD8QurdPofZseDvES4XE6XgaTDYlP1Et8qdIfWkHDe7z6BCXpOGDp
	Vox/rgBNNbt3d6oCgahQLEuKp50J/GOSnGvWGCLgOMb8C++Yk3U+DsKFpHJLhJEBUvWXKkaQb6Y
	CjkIV/vRxCmwYxpEc2vGMr7I9cbLUkQarZ/3TEVw/5hZEcOOEmDqIBDC3n0yO2uMeknmbOvRdx7
	ak4gtgLBbIUkq7XYgSQFvsqvjcB78zUGht/Vq7hbkVbq6A1FOJpBuDJpZlmH2KWyuGp2jm2SwL1
	jmXsgQX4EwD0jzTqGUgGOsEMWz2y3zJqpk3PEZuhTOHYpz3ezFyRlVaqeeU2UbUhnXyLBTlTef4
	p19v2a8N8=
X-Google-Smtp-Source: AGHT+IH4rUVIAn7WhbduucThdexnznJ9hly1B+tB9VI7hBWCDEzPPkabcFLafzvU5hZx3Q3JC9dOYg==
X-Received: by 2002:a05:6e02:308d:b0:42f:991f:60a9 with SMTP id e9e14a558f8ab-433407a6f55mr37339875ab.7.1762355039349;
        Wed, 05 Nov 2025 07:03:59 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72268dc04sm2431280173.37.2025.11.05.07.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:03:58 -0800 (PST)
Message-ID: <a18092a0-da9c-430b-80a4-5951501f94ef@kernel.dk>
Date: Wed, 5 Nov 2025 08:03:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make block layer auto-PI deadlock safe v3
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org
References: <20251103101653.2083310-1-hch@lst.de>
 <afe10b17-245b-4b21-81ee-ff5589a7ca47@kernel.dk>
 <20251105132345.GA19731@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251105132345.GA19731@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 6:23 AM, Christoph Hellwig wrote:
>> commit 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a (tag: block-6.18-20251023)
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Wed Oct 22 10:33:31 2025 +0200
>>
>>     block: require LBA dma_alignment when using PI
>>
>> which is a bit longer ago.
>>
>> But why? Surely this is 6.19 material?
> 
> This is 6.19 material.  That's just a heads up that you need a merge
> (or rebase which I was hoping for as of the first round, but it's probably
> too late now)

But why not generate it against the 6.19 tree then? As-is, I have to
first resolve the conflict in that tree, then resolve it again when
merging to for-next. Not a huge issue, just don't quite follow the logic
behind generating it against block-6.18.

-- 
Jens Axboe
