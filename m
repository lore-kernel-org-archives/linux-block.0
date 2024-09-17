Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CB27442
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579164; cv=none; b=tVJdCWJ0ueS5RusCCq9qQfJDJkLYZZJTp34wLUYlW/Lso9OBWvn3bu5AjbpOnA2RuqGErwS0bXpdphfmT09sm29XUWiMGUweGmXbD2kbxnK0uXL4HQRExLglUzbe51kuijS78nZZ2bes3/1yLeeBlxul7x28QI1RRZRgpGzuaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579164; c=relaxed/simple;
	bh=xvzyl5Tii0TZ5qMfgT80igmAtogEy2vZ/X10F8N5HDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHq0TCEkOpstSSTnkgrdPW3J/RkIivOJ639N8GfFQypPD/5Ylez143RhLbaq/QniaV4CBbO/951zX7ycn3j5FnmMqGjJOeOV9JkGyDHA1KTXWVwzSwazHTLLUtOf5S22P/Adjrpk6FnMRp2ml4D9MdZXihOeMKldWn+izBMMlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KrbY+wjD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KrbY+wjD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c180d123so2646235f8f.3
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726579160; x=1727183960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27jNzME+/7fttCtxjTnp0jfof/BjROPqxd8CF4lpuO8=;
        b=KrbY+wjD94HI++WG7/D08IK8QyImiFQeO64ngARpGuIYJNNJwC5DO3sLCXgwyvHo+j
         hjfMHrybIYoLPMHK0S9FrytoTBAWaUGejlayjqDTVcieaWGwSIk8YLy+NTSLYp7mh4UN
         nNAq7e/7utYALxhxTGWVwBEjeeVv+fRcqVFY01N6EIvQ56oQ8VzdRvn/lgQKIsBVhPFl
         lYrjOht8qC//PK8V+UE++hyd+p/folLvPmfXeQU/yKZoGUmKwPLGaauqKWMV3q1AkitL
         1NKdQ3kYvE6P7q/Sw679hWYq3x2Cp47UpI207CYN3avRULHwBxW2FCA3ezGQwi49JqoY
         1avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579160; x=1727183960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27jNzME+/7fttCtxjTnp0jfof/BjROPqxd8CF4lpuO8=;
        b=dKLOMYTaCiiMJHQXxW+Z2K5xpmjOHhGtncsj5Cjwwi5Z33o7W6wVjPK+WWhnkwypAe
         OO0OfOu0JDr0tlmjNe4cQ362pGJCnMtRyideYgTNNHq2ykPrDuDKcQBRYnwgvf29feKT
         tLSGSFER9traR/tRxmjRqAGSBTC80npHkSoSYaD5eVcl0jKKPo0OBX6PVFYDUhCGyBxH
         M/JE17PD9LD9x2MBfoOiLe7LkmoAPQCFRS36j4jtTL8ZOHI1a9HrfKBO+s/JzGm9GyS2
         RflBhzYwvKh4TkoY3sEDkaxkTHdZ82PVGWfzw+24dyBYDXBPtRPL3s2F2rTQxROTuhzf
         SITw==
X-Forwarded-Encrypted: i=1; AJvYcCUJaWMm1nuWFRrOapUOHY5MkI+8CSjJHjXG1H9pWUSOx/B1mmrfkvaGrs9sXiILiWmtXzjyA39qLE9Iag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+UWs6HwgnOkSWfYzKKQP6LyXJ31UGaD2Wv+bq0Cxq/eKVfOt
	YvmgzTPeyOcN1rxrvHBpmxABgTuso3T3jjkJOAOpSsuk0qVrjpcIUCeRcPRKvQE=
X-Google-Smtp-Source: AGHT+IHu8f313IeBe0UZ5MIETHyTb4+67djwyZqabX9mkC2ANBI4B+suCOw/2HAhCZHM7utf7BPwCg==
X-Received: by 2002:a5d:5f56:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-378d61d5073mr10101968f8f.9.1726579160382;
        Tue, 17 Sep 2024 06:19:20 -0700 (PDT)
Received: from [10.130.5.220] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7809e0fsm9535998f8f.110.2024.09.17.06.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 06:19:19 -0700 (PDT)
Message-ID: <d22d787a-6810-4e2e-8807-4144efc220a7@kernel.dk>
Date: Tue, 17 Sep 2024 07:19:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 "Richard W . M . Jones" <rjones@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917053258.128827-1-dlemoal@kernel.org>
 <20240917055331.GA2432@lst.de>
 <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
 <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org> <Zul97FvBsVuC1_h3@fedora>
 <20240917130518.GA32184@lst.de>
 <274ec9f3-b8b2-4a0a-bb13-f3705ddc349f@kernel.dk>
 <20240917131450.GA367@lst.de>
 <3a93a3ac-18d3-4031-ba16-ce172d10e7f4@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3a93a3ac-18d3-4031-ba16-ce172d10e7f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/24 7:18 AM, Damien Le Moal wrote:
> On 2024/09/17 15:14, Christoph Hellwig wrote:
>> On Tue, Sep 17, 2024 at 07:11:22AM -0600, Jens Axboe wrote:
>>> Whatever reshuffling people have in mind, that needs to happen AFTER
>>> this bug is sorted out.
>>
>> Yes.  The fix from Damien will work, but reverting to the old behavior
>> of ignoring the request_module return value feel much better.  I can
>> prepare a patch, but I didn't want to steal the credits from Damien.
>>
> 
> OK. I can send a v2 ignoring the request_module() result, as it was before.

Sounds good, let's do that.

-- 
Jens Axboe

