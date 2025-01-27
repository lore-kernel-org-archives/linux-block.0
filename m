Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119D18FDD2
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013504; cv=none; b=l/kK1WUqvvpeN+vHoj24aa061d2HVzgQUicWZrkEh+bjF67VctU8+wxpKZC7E4ZgZZDOEYzlhiIVH/mwMeDeERliEkXo57Yv1KQTbuG9mPrCUOTl8dR6WMqOQrEhDoN05HSKXO6PjlYh5JmARqiP6aJ+RyeVLt5HZ+/BJOkSdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013504; c=relaxed/simple;
	bh=ZYvCZbtUoAT5JiJuAg8XDR0w4hfFoWqTwv+bLVbN1yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGqfwiyud6JTXPix2NSHSzthIISf5DRLqrgCywzWi6jN4UQyts4TviCflpdzBg+aU6jTX8BhJFPgNovyjG5kUCM5NJpu+oar4lQALafeKoyMnbYWW6zqqTt/uCYVxM+mGhb7bzI+LAyWxsr/ZiKB46/gZzZaTIdnJ1v+tIhhAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7Knc/0R; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7Knc/0R"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab651f1dd36so979202366b.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738013501; x=1738618301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8Ix5bawk3vcAfD33vhDdhZSL9A70/0kQOyvn23giZE=;
        b=i7Knc/0Ri7mm2CzQS8Rj9VD2/C2YNWINpS9KgGhmw6h7JDEGvNlq3VQDTzeOC62ML3
         XqImrkFkXenr4izoFMv2r+H8xcUkjokozoPKkh1aeERjSH9c6gLpnEYPT74g+4glEBNA
         6kphCYyRN2KxvP8XNS+ka6sDuuRm4W1nNn1hrLiRNpsJVy/xWHENaGUVtqEu4JHcDVCu
         LubUczN8dyed8Jyyt03pwmTK9liIZfXgB22dkowAxRqr+RdY5Fck89PalOvqGUfUYLy6
         ho/LPaZAtk8a7xZRopEjYE4rNwWUK23TYR1LOp9/GGWVMjdnOtRx7jiA8EPPiWEy7jt3
         jqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738013501; x=1738618301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8Ix5bawk3vcAfD33vhDdhZSL9A70/0kQOyvn23giZE=;
        b=LXiHFIJhw+XfxxGxMkkcoDjnR37oB3LfXKWYj+0EtGEBvj5yaOIZ78cgb9Qu/1yU2F
         /XA4LGadrD73zJJNgbF8Yx5MOPeu240ZdRWnjCzwsfmnYfNqUrPF5yGus1y6+NFFNJIH
         bruxrV0PqivUuju0tbZiS8+zS/jxvbRtU8ttzFMQ4Eef4uEIRkbuBEmPXEZ5sKTc5XSe
         Crz4pTwyceGnCh3DY85/cUoiDjwAriQhGVR0T2+2QSLhY6aKHp/aWwx+SaIkOBi+I5lo
         9+OMkioueU4Tb5LFDNr2FtQ61hIE3piainYTBWP4qTlm6xNPy46im/vygz/FT2Ly+Y5E
         BAzw==
X-Forwarded-Encrypted: i=1; AJvYcCVH5zCH8oXwCrDUhWmAfeNZR3i1fgV6QD8xiAg0lUdwR8EIBvF6fLPIyTCDXYpTKCk6ZRNFsd5OsPTt2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCI0O4huf5wJhCbbCPGSx/TY0ljSrdJ66F5T01ordkLMt/9oY
	jwxEaeyILlWN7IsK4mk0lr0ijId4Y2u7SbCo1hAYEFCQRhraXlCB
X-Gm-Gg: ASbGncteBEgliEKv7DKBjznuldBmbiZ2C5mEJQPzMngQrX/nrhtBMYPybIaQueq8Z9u
	ZUJDPtKhz3RY+7OkDyx+dqg1lppcc+CfZF63wVp48pby0eE7n+yMNKfzbJeJvDsIcTp5tEN3tJW
	YIx8PPRuiLXWDwU7yIM8w+n5whdg7TLzzMAGDK6NlzbjgYtLqv0EIUBcBazOjYjte6t3fDvzF17
	Clk3+6z2P2lGQgR7Q5VN++aH5nsgqWEiHmQ2IW9Fo2cwP1M5znJRoxWHuc663/yJgfKnP3QqxsB
	V/uPLXjzK6OGJw==
X-Google-Smtp-Source: AGHT+IHVJPLDwM6pv2kJlP80pKtzffSY3kmJQHtOcyku7NWQen1NwlAloUpu1svNA6mHUq0uRNRsxA==
X-Received: by 2002:a17:907:3da1:b0:aa6:8bb4:5030 with SMTP id a640c23a62f3a-ab38aedf0eamr4227794166b.0.1738013501094;
        Mon, 27 Jan 2025 13:31:41 -0800 (PST)
Received: from [192.168.8.100] ([148.252.145.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fc485sm646346566b.160.2025.01.27.13.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 13:31:40 -0800 (PST)
Message-ID: <31cfafe8-c6bb-43fc-883b-356a23d4f434@gmail.com>
Date: Mon, 27 Jan 2025 21:32:03 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Jens Axboe <axboe@kernel.dk>, Andres Freund <andres@anarazel.de>,
 David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Jane Chu <jane.chu@oracle.com>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
 <6ulkhmnl4rot5vrywoxvoewko7vbgkhypcwxjccghdu26kwsx5@bnseuzrsedte>
 <108b6ae7-a272-482b-b3da-60f1fc6617ee@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <108b6ae7-a272-482b-b3da-60f1fc6617ee@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/25 18:54, Jens Axboe wrote:
> On 1/27/25 11:21 AM, Andres Freund wrote:
>>> That's precisely what io-uring fixed buffers do :)
>>
>> I looked at using them at some point - unfortunately it seems that there is
>> just {READ,WRITE}_FIXED not {READV,WRITEV}_FIXED. It's *exceedingly* common
>> for us to do reads/writes where source/target buffers aren't wholly
>> contiguous. Thus - unless I am misunderstanding something, entirely plausible
>> - using fixed buffers would unfortunately increase the number of IOs
>> noticeably.
>>
>> Should have sent an email about that...
>>
>> I guess we could add some heuristic to use _FIXED if it doesn't require
>> splitting an IO into too many sub-ios. But that seems pretty gnarly.
> 
> Adding Pavel, he's been working on support registered buffers with
> readv/writev.

Yes, there are patches from last year out there, I'm going to pick
them up and, hopefully for 6.15. I'll keep you in the loop.


>> I dimly recall that I also ran into some around using fixed buffers as a
>> non-root user. It might just be the accounting of registered buffers as
>> mlocked memory and the difficulty of configuring that across
>> distributions. But I unfortunately don't remember any details anymore.
> 
> Should just be accounting.
> 

-- 
Pavel Begunkov

