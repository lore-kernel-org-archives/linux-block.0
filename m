Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7218133C
	for <linux-block@vger.kernel.org>; Sun,  6 Oct 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728249069; cv=none; b=YLJdf5ILLPEUqTGuILJCTAdgFReFMrVUWhvkNHPffOtGXZVkAtYZvmpUb2DcFGNMCAqUdu8S99UaSx9LiEBeOvPj6UtDPsXw5UABU+WQgFT0ejhMGHnXjtdHjCPIFvXeuBNcHCYB8CgJA/P4BSyzv8dT7eS5hpqJsULSqS289XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728249069; c=relaxed/simple;
	bh=+eFNjWgForNGlvpFra2igXT/QVdi0Sq1+iPGE7JoouQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xonwvj2wdxjBT0ITz42kz0k9zrvGxY0LMScdGEd/xhtOcm7mcHBM5exQegA6WZm1BV44Czs1TRMJUgOcuaHgTlMU6AUpilK200wufHKzyRblhsJLGpDfyeS/hJnUxeLblcNKHjoipdYjnFn1bV/lLeRuQWrpHHi5tFvAcIAz0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HyH0gkK6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HyH0gkK6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b7259be6fso40961425ad.0
        for <linux-block@vger.kernel.org>; Sun, 06 Oct 2024 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728249063; x=1728853863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dloADBbuZWGn70AvE4DrbcMS4omNC91HnOyXDRn/hGE=;
        b=HyH0gkK6NvUTRUDvfutCXgvc+Pu+in1kbRa3cKA8f2Fr+ppvNnCjmmh/qxoz+XFhy/
         XuBDPUu+zngTSKPF/S8cdA6Of7RRqTEm3kyxQTz0Ic9uHo1sA9vlCMVzvlGpL9QewSxL
         r5PQ13gUUxUoy+aIawLXjChgdUcUe6k9UwzTt/QLsjrEzBPe71iwOkJLFRMzfijOYozV
         W10aZOgKiknqANRW3ksspHqSvOYbX8gBAr3rmodSkwSSYVgCP3Vjog6QGR+k+vhhmmWV
         6tfbwyLJZWCep2y6xEStzuqaASUqzXHq1ADYtyfMBF3iWr017+04fgfStqGfJx54d3pA
         T2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728249063; x=1728853863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dloADBbuZWGn70AvE4DrbcMS4omNC91HnOyXDRn/hGE=;
        b=vY9OGZ0yxZuug+wYdEoOEu4N1xX6oqzfn2wmMyr6BLjS3invZqIPx4aIX4qMeoco2x
         w+K08WLpKRQwDrMsmVaF8Lf0dxrAXAlM+GMcWjDY8FNZkO9wUIeb8azt5fZfj86t0vyh
         upd9hN2HZg9erLjjxAtNXJxxCtGxIyFtoBADym4EL+SBrNFQJfGMqiwYs3J3yxdw1V0r
         HzBnhoNMhAUBn2YvvixZ+W3nBvHVlsY0s3sz+8cpA7F40TbcsUMy11T7TtCPE6jrtOCV
         DqFYHgUSb+TKHTK0645RF5JiAtoUkCJ1CdFN7phuZoj4zwB200kL72KbXmFbJ4Mnolj3
         zeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfxDPeH7MvFAPKfJZFNZlzMRqdN8Qt97h4IYjVwECzReZbm/34Oo65IKLa3qrRjywnyGx+5cMWpQADMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5MrS6y+IzjzDUIXXUPLcmRHD2mljh4CyZf5Een8ofEH+ANp8
	G9MGxn7GjbvrV90jAaGInGcw9Ak0zFSKyqCRlC76+VV50vIh7pTfEtVBK33+2s2h2JyOt0b9HXc
	HHP8=
X-Google-Smtp-Source: AGHT+IH5NNQf1Ie+vUj3S5amCK5fUOP7CYBZC8wQD1o0NC1Am1NwNpRLmuyhZ7iS6+THJDSgH8BYHg==
X-Received: by 2002:a17:902:cec7:b0:20b:b238:9d25 with SMTP id d9443c01a7336-20bfe2a4109mr165129215ad.38.1728249063495;
        Sun, 06 Oct 2024 14:11:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13969477sm28488985ad.194.2024.10.06.14.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 14:11:02 -0700 (PDT)
Message-ID: <d2f5b906-d721-426f-a469-891eb2220eff@kernel.dk>
Date: Sun, 6 Oct 2024 15:11:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: move iostat check into blk_acount_io_start()
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org
References: <202410062110.512391df-oliver.sang@intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202410062110.512391df-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/24 8:07 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "blktests.block/024.fail" on:
> 
> commit: 5b0b8be85f1ca1c11566890f5d4564ee97cf2d41 ("[PATCH] block: move iostat check into blk_acount_io_start()")
> url: https://github.com/intel-lab-lkp/linux/commits/Jens-Axboe/block-move-iostat-check-into-blk_acount_io_start/20241003-032648
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> patch link: https://lore.kernel.org/all/550fc8a0-3461-49ac-879e-32908870f007@kernel.dk/
> patch subject: [PATCH] block: move iostat check into blk_acount_io_start()
> 
> in testcase: blktests
> version: blktests-x86_64-80430af-1_20240910
> with following parameters:
> 
> 	disk: 1HDD
> 	test: block-024

This should fix it:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e75e3471ea5..9cbc0262ad19 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -331,7 +331,7 @@ EXPORT_SYMBOL(blk_rq_init);
 /* Set start and alloc time when the allocated request is actually used */
 static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
 {
-	if (blk_mq_need_time_stamp(rq))
+	if (blk_queue_io_stat(rq->q))
 		rq->start_time_ns = blk_time_get_ns();
 	else
 		rq->start_time_ns = 0;

-- 
Jens Axboe
