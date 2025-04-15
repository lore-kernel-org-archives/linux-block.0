Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693B33991
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724752; cv=none; b=tneaI85eePAdxmjl7D5aRQWoEaUfjBIiBfGOb8uE2DFVwvaOECk8zUMDpNd8VqY8CcaqmaSrzi6vKrCceoQ0MSrwEPHWnhMbkhqpeOZxOAvpRTBBPZcLTm5YUw7WJ4C5NwNzDr4mu811Uwz1o0nLPNbej3cTrNlj/SQdHI7ovvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724752; c=relaxed/simple;
	bh=rXE3l2GglU3RtRieBCcheDgm2LsmMmtqbd8KZqVCbX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgTeYORFkUEea5zCSWEBydrIZGKImxJ9u2USedoXjQoN/yaKRo+4vlnQnXnyw7pABTimmtaLy61CPaAiIaBRlDJsbx6aYbFGFlGbERMo60fl7oZxF/2KnOantraN4dzCxJ9h+ytAKUkf3sqobyxOu0+spUzdubjBtSByocMzAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R5jA14LR; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R5jA14LR"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d8020ba858so15189735ab.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744724750; x=1745329550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNcrlM6tp+4sHuUS/CHQYi9bS1Y2/hmV8UYdxrvm+Uo=;
        b=R5jA14LRvvDRElrErQNpLNSpIdpYDnF+StMTkxWpN6Aj6eb283ja7QiIwR+Gr27Ibj
         KrxCUkYDiO9DjcSSnWJ7xvf2F6qNAVdV1Ynscbs4tV378dLD16T0GVQwib+5l4zZVPIY
         ELbafpd+gw+dA1E4sJlVI9F0SayHNu5VfcDH1H2ojwGcf4D/nPpPRWvOFrTEho7oIbjl
         RRcmAPMJrRNb7Zre4CIKN5Q1qNpD1p/1F0f3IbjT/tEFKVQmS9ABsGiqy0PcCF4hrFsU
         YNPK5kH+ThCK0FY3FcCmb5KNONq/wDUGS4XJuNOxq/E644Ri58n09i7q1KjC++ausicw
         iFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724750; x=1745329550;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNcrlM6tp+4sHuUS/CHQYi9bS1Y2/hmV8UYdxrvm+Uo=;
        b=C7vJ7voqha9pfYMnyaZ92S7N1pcI2oA1hPdd0qfgX3xOosisciMPl0ipYnozEQzTT6
         rRB/fwGtQFRNzMPKd7kMJYkZXAawCoMGCAsh7kQYQwPY9A+Mt+B/HJ9XaNr8ts+1LcjF
         LhZUAqZE1rma7AIiNdY6UIXlGsq9iEl5xVYLXOE8O+PGdZ3T+zxK8w2DYHD4gLcj/aWS
         GJG8VuGdyGHpi62I5GD1LoM2tbb8HcK17qLUUeC2VGGZdnNqJUw8goF+6wzmcbHJsFv1
         wGDCx6igp/pCWzLVXteJVQFA1ergQHRKmimcwKGNFDsXrqwsADYCSGA3arMQ9VILkHav
         e3/g==
X-Gm-Message-State: AOJu0YxlPB/zBAE3GGef0fF7Q1MJQG+PnxuAVJh9hrMBGWTzrTYKrru3
	o/9rnwhVo/U4eRG3H0j19sye+96iI1s7IzPOSkZubvIbgJu2Js193ERCUhBzQAA=
X-Gm-Gg: ASbGncvRtnvnGXGmmw9Wc5pP1zfc4uN884c0RjaMSgbW4MeH07MLxMCy+b7nb4P/t5n
	/Ic+Pe3zsj/N9Dw8exdAMWwnDuOFqJdI9OsLyetAu1yozJ2Sgk4F+dz7RjWEKudGjE9wFHMbqsI
	3B67dcD3LbZAY/s8k+BeyjuT/mvroukGg1AAMpQoOtuOhxlJZMbkdgrez+m3dlzQGUWhHkp1bPM
	jkqSiBLSgPfi9elDZ41PyTPX9lUByVhQT73k/WGyga4OlAael2mxcYeifBjbKDqXlb6TjjuZXQy
	1JPEXUeZuqjWlOfoHJTd/TYfHRDQeR/93qYZSlOVs3+g8MAe
X-Google-Smtp-Source: AGHT+IFejHFZGBiwz6/ELO3VmsNzwjNRkabhmkTyqTHC03DzXJjb1lXdKDU9lwgHCuSFdXY4BrKjXA==
X-Received: by 2002:a05:6e02:1c04:b0:3d3:f040:5878 with SMTP id e9e14a558f8ab-3d7ec27bdf2mr198797645ab.21.1744724750136;
        Tue, 15 Apr 2025 06:45:50 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2f621sm3102983173.113.2025.04.15.06.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 06:45:49 -0700 (PDT)
Message-ID: <9db33edf-8cdf-42e1-bf82-da9362100d83@kernel.dk>
Date: Tue, 15 Apr 2025 07:45:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] loop: aio inherit the ioprio of original request
To: yunlong xing <yunlongxing23@gmail.com>,
 Yunlong Xing <yunlong.xing@unisoc.com>
Cc: linux-block@vger.kernel.org, bvanassche@acm.org, hch@lst.de,
 niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com
References: <20250415054436.512823-1-yunlong.xing@unisoc.com>
 <CA+3AYtRRgL2-vPNm=1XBKd_PFuRcB5fZh96VGsfTO2VaAvqv9w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CA+3AYtRRgL2-vPNm=1XBKd_PFuRcB5fZh96VGsfTO2VaAvqv9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 11:56 PM, yunlong xing wrote:
> There is a mistake of Signed-off-by in commit message on previous
> version. I noticed that you had commited it in block-6.15. Could you
> please help fix it.

I fixed it up.

-- 
Jens Axboe
