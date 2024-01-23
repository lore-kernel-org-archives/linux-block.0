Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327780021
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037360; cv=none; b=ql4aU5tjGDW3s+mnFIiEMuVQiYr3Vce1EGxTIcXJeNj38E9a4zZawaNk1+wzbIuFLZ7kHGRxNQtJZV++T25BI2kBPPOvcJ70xL3m9N90WrItS9xAq8bYekWMdRNoCMangCSQSqxsjLcuoNmvHd9NPC7r9dqyswWkLHMH96WxUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037360; c=relaxed/simple;
	bh=C9VuE0opHyBTM9izpvu7+cUZQbCOwl4cNpryO2ar26Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJpOwPPM5+G9rg250DoVtvwQlk7Gt2RQTlRvRL26e5p/Kbui1m4/NLGmDIt0O5uZHJBdoaRC1C/kCmnaB9fAs3TbZavTBR77lSq+FMsVCkqK6msSqsdxY0VqDqYUyLFk1XsItd3AYpRycdjNJYDq3mdQS91lbci66RvfKL9xPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pnWK+fU1; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pnWK+fU1"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bee01886baso58778639f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706037358; x=1706642158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Fsx6I8Izi8B3v0vTTTixgXYDtfLKf3hLJxeAvGwfj0=;
        b=pnWK+fU1eGq5yui9HX1kYIFAjIatJKWHkkdcN36hHvU8Y8lvBeNtm2KqD/CEWESPVj
         aYbsSe8aRTFPJGOS2s3RJyw1BKt8ZCMlXMFh7owdXUwjm00xYWCRjQZJL70nuQew3Ksa
         sTApAYZ7FWvTm9Zk7+4IlQowYd4Gfdq1rZW2Q8zHF/64OrWzOjJzsFakhfbqyA+H0iXv
         ycm4sYl+MIHmFLCZCY62H3vn+lgEq9exUxVRg9fJiSWPD7RC1VVJeKvQOLi04GyJxrk1
         CVwUjFA24gigTMyHTIAu44/9uwaqO5uUkkmI4gi3BJ7q0Nq0oBEPy2POmkxy/OqVcePW
         HiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037358; x=1706642158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fsx6I8Izi8B3v0vTTTixgXYDtfLKf3hLJxeAvGwfj0=;
        b=NFPHxmzMu9Jcm46+qeeNDi8dD3DVuNIhaJeTEyGcV3h2dp3BnVSs8GM5AK8L9VEY3/
         eQJ66d5LX+l6iUOkvC6jCdWK5xlhVulZK9OXKc5OZHhHUUBWLjX+qzEyo2gieOg63fxi
         yea8xPl9pv7h2UtRKzBA5Q2sXNFUCQ0Wct2pI+0NDq9mV+TAcB7c9ljV4VQo8nKcNSuV
         fVQRkVzeJGZFoQJ9rXARB/RmrjccR2ltOiAU2I+MEhT8THrN8Hj0Pl+iwWyS0hVEz7JQ
         KsivGgPIch+atyO7BDJUouk0YhDijN0t2vRdfzjFSpN10jpTSJz0AGBTcmD8B/Hp/AkH
         eeLA==
X-Gm-Message-State: AOJu0YwuKPJ2QNnWijN4I/ZrhMSUvDVlehHYa2cdN/1nfG9fv24NochV
	7TU2XLw1Vpp3ihOFxQJlD6UXuvZH+f9xlcrQJeJoqZ0DEaQNCwbL/SkQJz5PPgk=
X-Google-Smtp-Source: AGHT+IGBAKhxOEnS+4pbTbTAy665pq9de0BbDWPxLlAj2zqUfSFTHmWZw3VoJw5mgkp8rgO9Q5gC1g==
X-Received: by 2002:a05:6e02:1caa:b0:35f:fa79:644 with SMTP id x10-20020a056e021caa00b0035ffa790644mr10965876ill.3.1706037357775;
        Tue, 23 Jan 2024 11:15:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a056e020e4400b00361a956a57bsm3445104ilk.53.2024.01.23.11.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:15:57 -0800 (PST)
Message-ID: <8273c2ed-c22e-48f1-b595-a1e124232a1a@kernel.dk>
Date: Tue, 23 Jan 2024 12:15:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: update cached timestamp post
 schedule/preemption
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-5-axboe@kernel.dk>
 <Za_9e8zEw94UpkBE@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Za_9e8zEw94UpkBE@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 10:55 AM, Keith Busch wrote:
> On Tue, Jan 23, 2024 at 10:30:36AM -0700, Jens Axboe wrote:
>>  static void sched_update_worker(struct task_struct *tsk)
>>  {
>> -	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
>> +	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
>> +		if (tsk->flags & PF_BLOCK_TS)
>> +			blk_plug_invalidate_ts(tsk);
>>  		if (tsk->flags & PF_WQ_WORKER)
>>  			wq_worker_running(tsk);
>>  		else
> 
> I don't even know what is in the 'else' case, but it doesn't look right
> now that you added another flag to enter into this block. Before this
> patch, it looks like we could assume PF_IO_WORKER was set in the 'else'
> condition, but that's not necessarily the case with this change.

Will add an else if for PF_IO_WORKER for that case, to be on the safe
side.

-- 
Jens Axboe


