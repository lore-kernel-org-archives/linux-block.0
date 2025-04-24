Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545119D890
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504413; cv=none; b=J2RQvr/NJPbpzjGVeFEh4Bo5VYGoGbdVmI18AOcboZcKPoDU4QjAMlD44i36a7/Y1phIcHp3jfpMJ5mgjzqKzrPFSrDHV0r71vGSRxa3Uvkp7msSkx1NG6nQloiirZu1pdnmrInJk0m5YrJn/SEivYEC69FX27cQYEw5Ye+0+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504413; c=relaxed/simple;
	bh=E/HfRhUv/vN50Kixio/MbazHdJokuFjRRDR+3/M0SKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubTx982/aADl7OPPzbbp329x6wqmUalrSvI76OqYm9QhIX1cMtDjpil8HuR3B+ZUW6wY6eX/9D6xaSaPhov2LqAMIw/aThVmxW9xhXw6QZwvwgDlJcGkgTtkTNEh9V0T3RtMsrXMKEiAt88o9/0OToyESutAShtspZ/9TcmEM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNh+psi7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNh+psi7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5f619cc01so17388385a.3
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745504410; x=1746109210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Wl/701O0YiDCZmHuscPK+uRrUMN8SkqfHmcaGCKw+M=;
        b=mNh+psi7AH7+kaArOu6KLAEUcKRMHPNC818VU6kr5q+QOmrUk+ptC0aSYrRjWxvns7
         NQIfc2P+OaPucZzCWGUYR/NTfx20hk2m+cMMj9qfRrEqIBdMFY3oVExjC4o9haqOO2SD
         E1wq/o3Xjbalw/l0ABiUOCT6vQU79Us2Ua12mGR2PhnU40ahVTtQ/bj5/E+LRzuubshN
         3Bzko3FE1OrYVpfTxpngpIiwiDus2VMHCWrn//p6vP8jr/U9RRDPAErtMTrqk/t5z4+m
         EWVIP0fTdBsW5pcIvkDad0UC8iB9pO0VOKgIkPfP6gCZyGbb1BZhct/6H8jlT9Le/85U
         ejvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504410; x=1746109210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wl/701O0YiDCZmHuscPK+uRrUMN8SkqfHmcaGCKw+M=;
        b=EOpaS9eeYw1DVBEDK8tHi1nMySDuOxb7EZfBgG+q8c9xv3jHSI9u9+NmesRQYAY5jq
         8leK1x7gCqZYcskri/ezBg+hUzcnUUPRGjZo3n8ESy5cqZRPj65HEPhmDuDX7nGvj6oe
         BcHzeEAGkzXBZFhYCISXYYfKbkegj3NQBOf54xgGsmtYjt1RU/hru01lC7DFzct5QqnP
         aJR2c6J0HqYQ5Vgaj4uJ0+GF/Yx6TK8iX2WeYoqYr6ytfsaGvyJHZDA9fH/y8441WEVe
         dMEcSwV4SsBZ1w34sEm6DGic97WSO7OQsYYud+N9KNcyNOEJAPuioeJ9Z3jhmIaWyIC3
         hwzg==
X-Forwarded-Encrypted: i=1; AJvYcCWtWUzNNI9u59Rr2BX7wT1vJtSkLELa5auGidt/GUzyDskBtQcU6zTtg1yts8J8pIwsBhLSGz06f6uCvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6yLuucQAPj8SVtO5/9qp4ltSPAUiOHOawyeeYosjr+5+GoV5
	TlsKQlTKR3kHCXhty3hWyZJqN9oqb6Gn4+vpYMtQ+OyWxf/CHuvo
X-Gm-Gg: ASbGncs2LHM1tTEawv7GCz46LLO+yGSrVzynKrUjouqL+um4VdpD71gLwwTeDzZBXtL
	MzmR6wAyVfwcSwVBEM/CeMPC95fTpDZspdkiWGbXYsEpJqC9ewZpsLPRt6NJLuIEp8jetB1NDXc
	LUOEUqzd3D2hymyY7CMMxVci0JXnhjuRLqUlEFYaRZzLc7C8y6EMJrkhVsrweMCWp3t5+0+OmK4
	Kl574Ff6E44kS4Irx6L93E01yWlU31pGKxNj7Ccb39B2lE0xaWpvo40+ZhvrLJMKiI5QJ/OJz/l
	xyxKHT6G5SK7L9yAbEHnGhQ6UaveTYaU8kLQVJEg6EWfb17qj2H/NOBiG63XYT3DXr3lub6M7BO
	nR4wAsj0uPgDlZyl1
X-Google-Smtp-Source: AGHT+IHbp/yFIlfYQPfvprqUH9LFqmXIbjUmDQTjDf/7c/0h2NTcZKkXeulgy7qCQtKH6rEiWjmsUQ==
X-Received: by 2002:a05:620a:28cc:b0:7c7:aee7:b959 with SMTP id af79cd13be357-7c956f9b389mr156143485a.15.1745504410504;
        Thu, 24 Apr 2025 07:20:10 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c6dsm92080985a.71.2025.04.24.07.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:20:10 -0700 (PDT)
Message-ID: <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
Date: Thu, 24 Apr 2025 10:20:09 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Content-Language: en-US
To: "hch@infradead.org" <hch@infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
 <aApFcW-fsdUP4Ztj@infradead.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <aApFcW-fsdUP4Ztj@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 10:06, hch@infradead.org wrote:
> On Thu, Apr 24, 2025 at 09:56:11AM -0400, Sean Anderson wrote:
>>> As a similar idea, how about to skip the test case if the test target device's
>>> zone size is too small?
>>
>> Why would I want that? The test passes with an appropriate block size.
> 
> Because this is a completely stupid device that can't actually be used
> by any file system or storage system designed for zones.  Why would we
> make a mess of our tests for a highschool science fair project?
> 

Because the test is trivially wrong.

--Sean
