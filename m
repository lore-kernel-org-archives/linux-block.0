Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5D149C76
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330566; cv=none; b=RXlrzVYz7uCRbUIroMAv2iXDg0EZ5Bn67128xwzmEr+AEl4qkB5QI7dnHjmm2SdYG0TQteJgO3qH1haoWAJ23LoFi/qowa58hRBCp0Edy1ugUdan6bubUol8hNP41Yr6zkuFdFyQWPj/16sCgct8oWfGpx9Fd2rXJLzLPg5ojTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330566; c=relaxed/simple;
	bh=8nWwEq2ntT+Dqohk56mJ7pAAMGqg8K8/guMKbVvo5Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbiAschQKannNeha1HHiwwZ4c1V7H0APKlrGIuTo9NbMyyOEF4e9eLKoznqjy+l4DtS7pNLdGzjtx2au2Xk3X/rIqyQZ8CgIJOCSjOiZgrGiVim2TP00uiWXfCCfQMcj7tE+sXr46Y58DV9jlTPQgnOeF8evJnTUJJXR+GG/y8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YTg0Tv2v; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YTg0Tv2v"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36d92f4e553so1885745ab.3
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716330561; x=1716935361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3ipvX0xL3/TSRpu16p7KEJot9GPEyiFqR6e4Ssxi3Y=;
        b=YTg0Tv2vK0X1HvsBIN4TrTNowXWhwV33S1GWkKpDHnrCXYm533NUpSXPc0e9bJKSs6
         LES8+qvNhlkZYQ7HNsOJBdGW9sw+LHoQZZTUK92iCAR1ex1r8A/VZ7zO4YqPLLPSubcf
         CoQ8gcHHfiKYublRuD3ibeXy5jh4fCgmoyqqgBH0SSLzs0KnnCYB/j2OjmuY/NzNFFcw
         SYSgqxRQOOo7nY8XImANlOZ410Em97vGFxXU93lmeziE/QJMzRcByJQ3cdAjij6SpolP
         3HkkCsvuCLdOXGeN5cLQHWp6wmp0rrnd9BIMk5nKqpHSDOghuyr7HhnBB8Ch5kmGsi1x
         oQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330561; x=1716935361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3ipvX0xL3/TSRpu16p7KEJot9GPEyiFqR6e4Ssxi3Y=;
        b=inqVYYntvm0ul5xOw338dzu5Tcx84fXbfd2hqGDxulDjxkQKFlmP+i+nSgCB8vSIo5
         038igA7/qzOBuxgcB+3kTLbqTSe9kJubDuIy0mRZ0CZwqTU+dmzLeOgKPWHrq1MIy8EX
         eI1W3wggQQoT6lxisGfy7BhmLjCsoJAuFS6aBgkXM7VjDbOYaScIDp5sBqFN0FpJjdEI
         xeoNGPb/VHpolCAbhAiaoDKcTXv7fS48lvkmOQ5hj7Z8957BWYEIDHuMdBxwRrzkpa6Q
         PoowHPNaohCcvffbOOtoFGfypXZqK7/0oXVHB3an847Y39hThwLRQeC44zCr8gaMmR3l
         Be9Q==
X-Gm-Message-State: AOJu0YyZOS9/a4aiSbObD2h8ygBZv06ebMwS9t4S686kU3YK2Td7q/7b
	/b7zaMsIknXlphBnMv1kyhJWHht5p47srCiAveYvZaUCeIWUl85RQA4NWsAmBmTmI7dNDpyZeaB
	v
X-Google-Smtp-Source: AGHT+IGyfrbM0ogKINwVvzAJcyHYAaS0ti9CF/pmEU20Af0ExG9KOXPtUtn+3e5kJk++37YdZEVdBA==
X-Received: by 2002:a05:6e02:2188:b0:36c:c86b:9181 with SMTP id e9e14a558f8ab-371f3f374bcmr4701465ab.0.1716330561187;
        Tue, 21 May 2024 15:29:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b3493asm21281071b3a.191.2024.05.21.15.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 15:29:20 -0700 (PDT)
Message-ID: <d60cdf6f-38cc-4939-a43d-890eeb3c7fcc@kernel.dk>
Date: Tue, 21 May 2024 16:29:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove blk_queue_max_integrity_segments
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240521221606.393040-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240521221606.393040-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 4:16 PM, Christoph Hellwig wrote:
> This is unused now that all the atomic queue limit conversions are
> merged.

I'll queue this up post -rc1, the 6.10 block tree doesn't have all
the bits in there yet.

-- 
Jens Axboe


