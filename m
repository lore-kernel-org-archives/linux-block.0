Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5111664D6
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035079; cv=none; b=iuz/Vshv4Su0dGv47JtOn6Ol38ETKrqAkRqsKKobJ+wR4G4kjfKQ9zXS/zz4JlzS3MlVECP4sd+uXIMSFQkgCJRrQUT0jJldscokpYxxLuG+wou3ymUHarnGI//DKQAZOCBLENdq727eLgaTpbL3J/Yzl7lDfEoukFFUP5lU1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035079; c=relaxed/simple;
	bh=Eu8CDiibY9z8/y9SRW7cCOVzKgZs179swI872qxI/Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LlY2dMFGD4lPLh0nm1nP7lyfzdfaf6sI2Acsi37zNTfBGRZQyPu7W3JjaXsWGSsJtE3U3T/rxCZhXm/42pU5b/V+pGEbx64BPvVPuVCdjfQZCeXtgK2qW3GAb85G2RvTFdlB1LnEq4u3JizvG5h6dQCniIcimXw/KAhKq06MJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71e24845aso26585155ad.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035078; x=1706639878;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu8CDiibY9z8/y9SRW7cCOVzKgZs179swI872qxI/Xc=;
        b=a+A9gQYHB1IBxGf15K0nG+cfwcP/BNE7g1cE2/VxqGpbtvxoRcxdEIA3X6JjMhqU9M
         0FVGqi4FhTrXNwGWRHNMV/HGu8Oj+nXORoRFSDZ5ZoU+1bXA9oOIsLnL9/SpHhAQlSQ7
         twtOv3Q2MgjsmcUOAax2iESyAc26Oux4WoHbpjKWrizM8ryvjDEDSpJmr2+wbEtET6+1
         JnPv6jQ4VhXZX5oT7nV/TA4a4RqsK4yL4KWhsazJX4DBN0SpEY2AdKJJZ5GUqgNF3eyS
         HkH+51wH41L1vyBfNqHDk5hbDgM4wLDwHDmdCMVFE4pF1uFaVnnHWzcCDJmzHXjkE13c
         smcw==
X-Gm-Message-State: AOJu0YyEf588H+9jj1XYzkTNuzLrrD05bjRK46zernTE5El9viWoBsRv
	0wF6nVw2558TZd8vVeRxbRz6f7bHM1Y/9+43tBzuRSWfGs2FhVuvcjry7iva
X-Google-Smtp-Source: AGHT+IGVxCtFnTBpmBO4uqxGqilR6T4gJP+SEZt30iOYW4KMUutdczooKS5QGjGMXWNEJVpC91dbmg==
X-Received: by 2002:a17:902:c40d:b0:1d7:1213:e8b0 with SMTP id k13-20020a170902c40d00b001d71213e8b0mr5144713plk.116.1706035077886;
        Tue, 23 Jan 2024 10:37:57 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d766749e9bsm2090141plw.156.2024.01.23.10.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:37:57 -0800 (PST)
Message-ID: <2bb118a9-137d-46d9-a632-acca6642b80d@acm.org>
Date: Tue, 23 Jan 2024 10:37:57 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block/mq-deadline: use separate insertion lists
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-5-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123174021.1967461-5-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:34, Jens Axboe wrote:
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> [axboe: expand commit message with more details and perf results]
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Not sure if this is necessary or useful. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

