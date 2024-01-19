Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417156748
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695610; cv=none; b=I4SHv9EjXbJ0Jnm0Ja3DGNiboW+HtIJ48XvOya68YLuZs6tlmKOiahLIDl75q4KUfi/RXr+OrLiT4dRSdD12umenvdF5bMbF4B7FiQlYyYnmiOVGTTl8DRbtXkgfxnOlPLZP8LzkF7bqkSNbNhiYJxB048NCvu9kVROVJd/qNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695610; c=relaxed/simple;
	bh=25mz0o82Jy3aLuCIMzS7v6P1CB8SZY2Ww2EoRgOuIJM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1HagGZIYqOpWsIdIr7KtwBtzMNBCUHAKlM0Cg4HMOPoC1pCnWRb9nLtERwXnQr2frTiIj0rOiy1oTAMdYl0lw7zkHGDa4RxYf9z6X0Bst7nhSl3RUY9DHE1aulgGID3UY4Jmco4yzkighfv1UapkjJ/wrzWPwaCSzUVi0kRIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wkblauQB; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wkblauQB"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bee01886baso15858439f.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705695606; x=1706300406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhvriKPgl9s4lfkMPxwk9myhtKbT/z+svBvh0IYvttM=;
        b=wkblauQBv1WpcFPHlXltmDjs4AzMrWGynEz7jxaYVvAyM1wT9D7To0aA2hZTgfhuEs
         p/fAS72KRw+7vpaearSgYrbESJ+WkX+pjjlG742vAMWl+mh0U4LZVxMpTd0FC0hjH3tf
         /x9+1+dntXXu3niW7SRpnsdYNyvzDMyxF5wpXrYy721ZG5BFjNLnOxhHAIk5fPLhXKGF
         L43USWgAuo2mXyibL8ugRHL2zNnfdagR8Ks3by0KOOuBu7Ud8YP3tgdv3+Cakd8Gp6te
         NzEzV7Fu63y9edbbMUVsQsBnogExxZhOA5u8feibpCqCGzKgMeKnooHA/4E+fk1Q1qPN
         ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695606; x=1706300406;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhvriKPgl9s4lfkMPxwk9myhtKbT/z+svBvh0IYvttM=;
        b=UUEyqiGadtDRYKhHU1RXjmiPKao8fa8JUZmMQN9YGG9JStv9TibUwtUPq9h7jMxEdy
         YGYkqQLY/pMTjLKl1CwJFreED0vkFCzbz+bEmHpTHSyxeo9xzT9+4xjWS1pH5Jz3rIp4
         LMdm5oKBKjeq1JhpPdF9tSk98awcZK4QnviMaK8ZcA3Lgbadkjl4KVcX6A7UGgpjWRoj
         IfEAVVAl2PLD+rq2eo9HYDOLJC2tOEUwx/JUmkR7eR+DvndjFd+yHG79er7xz+WDcQ/i
         0ho8EZY/CCph1bvL0+tXukYLoyjNx1heJd5L6fZUZZKFCYsxib6HfsxQaZoWbLeHDD7C
         1hAw==
X-Gm-Message-State: AOJu0YzJKbYv2KkD1xIazPcvaQwykD0cq0RKtY9ecWsZkwJ/2MWr6Syr
	oo4XzyJ0NYlcW/5WgB7eKcsfTd/AY9seCY70aA680gIFIwgMfdJuLZ7WpJzRxb4=
X-Google-Smtp-Source: AGHT+IEIsYLEbuxrZbKbguUwtUq5ajxguzBO+wCEwjp34rxbZIksC08UPLnw9jmQ63S4RZo2RutH0Q==
X-Received: by 2002:a5d:9bd8:0:b0:7bf:7374:edd2 with SMTP id d24-20020a5d9bd8000000b007bf7374edd2mr561964ion.0.1705695606235;
        Fri, 19 Jan 2024 12:20:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k21-20020a056638141500b0046e9bc44846sm1761035jad.17.2024.01.19.12.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 12:20:05 -0800 (PST)
Message-ID: <3469483c-baf9-4df9-93ca-e5d8a1350511@kernel.dk>
Date: Fri, 19 Jan 2024 13:20:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unnecessary unlikely()
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240119163434.1357155-1-willy@infradead.org>
 <fe1f4fe8-48d8-4b09-bd50-36e8fd8e75cb@kernel.dk>
In-Reply-To: <fe1f4fe8-48d8-4b09-bd50-36e8fd8e75cb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 9:41 AM, Jens Axboe wrote:
> On 1/19/24 9:34 AM, Matthew Wilcox (Oracle) wrote:
>> Jens added unlikely() thinking that this was an error path.  It's
>> actually just the end of the iteration, so does not warrant an
>> unlikely().
> 
> This is because the previous fix (or my attempt at least) didn't do the
> i >= vcnt, it checked for an empty bio instead. Which then definitely
> did make it an error/unlikely path, but obviously this one is not.

Just out of curiosity, I did some branch profiling on just normal
operations of on my box. Of the ~900K times we hit this path,
10% of them ended up in that branch, and 90% of them did not.
While it's not an error path, that does seem rather unlikely. Sure, for
single entries, it'll be hit 50% of the time, but for most normal IO
it'd definitely be less than 50%, and as per above non-scientif
profiling, it's around 10%.

-- 
Jens Axboe

