Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738581E515
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336066; cv=none; b=cyhjFKYLRLBlwtaJ3mrY5PcpMjMV9iohbVuwTylm1C6SWETzm0JpocF2Zi6pSIRBl5h5w2M018RUw9APUoH2BmX2U3DiR0orZ3faBBrqjDb7L7hYhi0ysoEatq8rl42/pR+vIu+rdTdev+aKKwwK0oFQHZlh19ny9Wc5T4IGgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336066; c=relaxed/simple;
	bh=b6/6kQZLOmW/jGj6ClVdmoZdHhmuoUmiSRFTjBWmovo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/A0gTbnF0R9S732NFjm4HL44XTAup8p+RooMNkj7I1PKQfRJTQRwmr5SlUwbtdO/5sXxG4alM5spwG0epiA/DwDtaS41ReXPQqmPm2VXYy1ikwpQ7UQ9mgJVZn/PXYe8Ci4+fE2OQjNHHK2CimNHk3J3GNQCk+ZLDTrwe+uxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nHL5YDK6; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nHL5YDK6"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86d00726631so62868739f.1
        for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751336063; x=1751940863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/HjIOEc/BM0B8cn4Xyb92GYb5jlSSXO88MIcfOIgfo=;
        b=nHL5YDK66t8GbAAuFprNAM9qCvT1a2rg/mx4hB8jujc53i5RwkxPWfQAIHDGgwQEPu
         jxYiZD3ewjHuBjtf0E1g+zTD8GdD6qB0e+cWehcT3O9b1lHW+9yvRKk7eKoTTkVTWCAl
         LKyGfxQABCFF6VIkFALfihFvhxOJpnLnOnvpb8wLxcublvsGy/SYcmFZzaG/TBhXDn6L
         BBvv/u1WxggQGkw9u/jxBsJ/zZF6dELHqUwFO04/ixPHQjOV81wECGz290+khM1xduPW
         d9//JzpCCV7x992bUk1BNhJFcHmjJsOEeinZqra+KeqWWCaEltdh7Vad0SSHx+zrho2S
         jGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336063; x=1751940863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/HjIOEc/BM0B8cn4Xyb92GYb5jlSSXO88MIcfOIgfo=;
        b=m+dQiMp1XQ6fwudNC3TkVcQzKpzh9NdpG+gpzWi+1wG8XW7iCq2ZFsDM+PpfAnYAXI
         o+bV1NGxjQa6aKWGJfSbKZa+pQkSyeIg+116sf4ZG1EPyjtv7BFp4jvEoatk4HI9Ky3p
         5IczjkpKeLwPoZKi/T/6li25PTRZNp1l5BmkMpvrvafm0q1W5L/C0Q+5sxVMBneE1TX1
         A9T087t+PX8vHDTvDpt4RCZFNHnYJViaipccvJtproPW1jy20QaGbXJMQrfXb7UL46KP
         8LbMdM4cVj39Ob9cvGMy/Nl2WCAEKS7DjhSIYwyp1d0IFVbGwiwVkNarNVdiFlPTsbwE
         7C4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+tFr8Z3qYEferWn0AXz5V1yu8yAEWmDEda6VN08yBfo7nD9wDaIfFlHq7nBc55WvAxffvnTV7cYew6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrImQeIPwVTWE0ztjRAgibSSrksJcqictoRYonk2nfIdsHFqQ8
	CuvSQSUgpkvaDYKx7PrJ05+JT+0mlNpkF+so60oP2DPbOY2H3KXxoCOCkI3oXfmc3+U=
X-Gm-Gg: ASbGnctadFfAMKzdo4SqHONYCtVBs/Io+vEm8Rj9dKVXK/LSYcWzi+vOHqtdEZRpwsA
	YCV4ZSn51loDJXacvRnnH5+2/TZIjmPZdGiFwQy14+fG0opGt359E95sdB0OWo2DmqVM9+m8mJu
	hDp5sH3l3DmxiVnHaLdAi+nbbHajQfU2Ezq0k3Dxv+RXL9Z4PRkD1vyWYpJQzXH4w3APClWcBWP
	PcZCiKFvWJ3VansPcdc3/6kQNLVYXS/7oJdy+6KaqM/bSHuqM0ppDo8VKSjr7pQgLgtkh/mxIh/
	b7/yQXPM/kz4J2ErVS1UjycdN+LA2G6TYzqwYqnsulStRIuC9AbdljV2OCE=
X-Google-Smtp-Source: AGHT+IH9OqIsWWgtBTK0sF21pFdM+5Z66WsppQ9Wa3k+OJ3eKQnx+BeFbEfgPub+Bo65pB3HCU3B1g==
X-Received: by 2002:a05:6e02:168c:b0:3dd:8663:d19e with SMTP id e9e14a558f8ab-3df4ab85aebmr156253155ab.10.1751336063467;
        Mon, 30 Jun 2025 19:14:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df4a0b54a1sm26846255ab.63.2025.06.30.19.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:14:22 -0700 (PDT)
Message-ID: <7bee66e3-42db-4d07-b6ac-45bdde864d92@kernel.dk>
Date: Mon, 30 Jun 2025 20:14:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.17 block tree rebased
To: Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <dd82e081-a508-4b55-9ba6-36bbb54a2c2a@kernel.dk>
 <aGNBu1jngH4r-SZ4@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aGNBu1jngH4r-SZ4@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 8:02 PM, Ming Lei wrote:
> Hi Jens,
> 
> On Mon, Jun 30, 2025 at 04:08:29PM -0600, Jens Axboe wrote:
>> Hi,
>>
>> As per discussion last week for ublk, I've rebased the block branch
>> for-6.17/block to be based on v6.16-rc4 to avoid a bunch of issues on
>> the ublk side.
>>
>> For ublk, could you folks please check the end results?
> 
> Thanks for the rebase.
> 
> We have merged commit 4c8a951787ff ("ublk: setup ublk_io correctly in case of
> ublk_get_data() failure") to -rc4, commit c5adc2714c2c ("ublk: move ublk_prep_cancel()
> to case UBLK_IO_COMMIT_AND_FETCH_REQ") becomes not correct any more, can you drop it
> from for-6.17/block?

Done

> Otherwise, the ublk rebase is good.

Thanks for checking!

-- 
Jens Axboe

