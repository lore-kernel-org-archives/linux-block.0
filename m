Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D074624;
	Sat, 18 May 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715993585; cv=none; b=GxHFI9GSLFZDbD389K01GWlRT/MEzn24ZmJZpnnsMY34R784hGMqp2mVcoLad83RdxIOZPMArurteDW5unzvTxk0HfY6who+udyIc9YoSq/6ZOhu3myTqdk6fbxtIkeEmwm58EejLzwXO78XKktW2LDbnlSCHihSGmbCl7PC7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715993585; c=relaxed/simple;
	bh=kxpNGd21aNnFsS8Tun+x1viqQNqfEmOXf6AfWQzZkhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilpl/AyuZkydrvBkgVlMyXxxC7Svh2LgQnt49zjz52KvomPDDpTtT82ZOr7mitsFbBF6VCASHdRwugAvTl3m2ztz/K9NCN7I8rtkDoXzQ8BWFIgraVFvUFZWNRZu4Z/TYlN3C0QJd/CN2SyjdY3M4jedzl4bwb7aBbtUslK6lKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/nnhePA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/nnhePA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso28224975ad.0;
        Fri, 17 May 2024 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715993583; x=1716598383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bIw/FmfmnY1dbtLfrsgC3aPpzWY8ZVFcFhTBEtvdIg=;
        b=g/nnhePAhxOUQ30UjmlpTybAIr67vBG/a/ehPy/h/RMbMy8WnNsNr3rOi5rgnzqXzp
         DDn9/04+1HSJ+aByDOixbwCqeOWT1zrVwL1Vxy6pGPUXaTUIrybIZBfIusjZ3Op7cRZY
         B6rRQ+0yOQaDzd+3qNtWL8SklX54DCui7UHtSutRAezBVjamqjIy0t/1tZqJjXaV3y8x
         9tvRGZzuhEmrwB1AUXv5/z4s15aE8BXxKyDStuigkKQzGqDYL7pxgGe/1OnXR1aQCA6t
         EC9W8PKtvVCG58c36lKD4ountfTHmTuO6EKWmyJV+zt1yvsk24mf62RmKfAgpCe8a61e
         6J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715993583; x=1716598383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bIw/FmfmnY1dbtLfrsgC3aPpzWY8ZVFcFhTBEtvdIg=;
        b=FGKgaG7CTXfElp2EHbxTgBmZfYpEeimBi+lmUARX9dw/FUF/AJGluYKAhbDD9+xdek
         NO6wd4EBpiw46xhPHVdIReeLpuFDcObwAe/eXFe1fSZd0WDAvfV1Q7zqtG7vjGQs5n4I
         Q/09+WOZ85XegtFAD01LBfMYk/wMB6xDb/zZpTXSqb6lhO7T6O37XSP0dNUmBJ7nAdcj
         vwcjTG6qKuRqRFxnydRptbc+kRXAlPT3ENZO/3YhoLQxnOgqGpzoEG+oRFLuoixapm88
         M4ScC5R2D0HjGUjOI00nY+XNgK9ppU4uEL/gf+ZYXtnmY+KQZquLPDJ825O5cX3j5ZqY
         Q+zA==
X-Forwarded-Encrypted: i=1; AJvYcCWFs0TXP8tMzLf3BaaYtIElFhNeOH13ykt6F/K4x9a6jfJeamCFdJdNmAIWBbQZfqwe97aZkU/ZFtCCq9gznGwC73/l13JGwOK0RV+TezMEgnbGORb9bQlIHuZyO3uX8w3QC0TXxQckodnkFz8BcGrZXuwNlcqWqOeHvuO+1M2ytwY=
X-Gm-Message-State: AOJu0YwufMuElQzGoRozoEOejeAZBBHgn7vwPvTmhKkCsTTLmHfhAoVF
	eV6i0buvvTeHpBld5Q1mt/02YWBcHFtw/qz1/VOH1fJRXcB9kw41
X-Google-Smtp-Source: AGHT+IHKWMGs9nZ9glGJICXGp/lnk3zbLGPv06pwuWoh7CMFd7JnCV+l588sA4B0uKWcpckylTUjow==
X-Received: by 2002:a17:902:e5d2:b0:1e2:a31e:2062 with SMTP id d9443c01a7336-1ef4404a35dmr306433475ad.53.1715993583310;
        Fri, 17 May 2024 17:53:03 -0700 (PDT)
Received: from [192.168.50.127] ([147.78.243.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c0374ffsm162886825ad.220.2024.05.17.17.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 17:53:02 -0700 (PDT)
Message-ID: <a65ca1ef-1c9a-4d40-8e11-d9dc2cc75e1e@gmail.com>
Date: Sat, 18 May 2024 08:52:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] block/mq-deadline: fix different priority request
 on the same zone
To: Bart Van Assche <bvanassche@acm.org>, Wu Bo <bo.wu@vivo.com>
Cc: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <a1c24153-007c-4510-9cb3-bc207e9a75e8@acm.org>
 <20240517014456.1919588-1-bo.wu@vivo.com>
 <a1da2c7e-1b29-49cf-a45f-255d3b8b0da2@acm.org>
Content-Language: en-US
From: Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <a1da2c7e-1b29-49cf-a45f-255d3b8b0da2@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/18 01:53, Bart Van Assche wrote:
> On 5/16/24 18:44, Wu Bo wrote:
>> So I figured this solution to fix this priority issue on zoned 
>> device. It sure
>> raises the overhead but can do fix it.
>
> Something I should have realized earlier is that this patch is not
> necessary with the latest upstream kernel (v6.10-rc1). Damien's zoned
> write plugging patch series has been merged. Hence, I/O schedulers,
> including the mq-deadline I/O schedulers, will only see a single
> zoned write at a time per zone. So it is no longer possible that
> zoned writes are reordered by the I/O scheduler because of their I/O
> priorities.
Hi Bart,

Yes, I noticed that 'zone write plugging' has been merged to latest
branch. But it seems hard to backport to old version which mq-deadline
priority feature has been merged. So is it possible to apply this fix to
old versions?

Thanks,
Wu Bo
>
> Thanks,
>
> Bart.
