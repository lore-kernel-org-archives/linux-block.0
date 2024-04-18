Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA416ABE3
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452952; cv=none; b=AEFq17OJlYTFLJUWCq2n6TWa8FXZxPev4CI6IkxSQTcovm4bnKrIaLRukeO/AEUan8PWPSxP3qRr93A9WmR00SEa5sa/ioSnH+FKcQsCilsQCkcxq+QHXBz1rA4/nGqIAuw0VInJ7bTjHxXSkuTzy5Y0qnKHtAVra/yQhHWNrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452952; c=relaxed/simple;
	bh=k+6r0GGg1vUggBFS1HFE+EGyXIm1V66bbTL8/78gpIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWO2oHltiCCvYjADwAT8PqunQeYV1/NOE+buCWiPELR/ImPXRryICqLb5hNkY3JE4eF8dN5z/nZJwP7IlcqtR5O7e1GEYPnYwlml490LD4bXxJ3k/20tRJgd7nBEr2xkWfYDWbhzS/dbFJW6uhoqg0FvekccWeQVKc22a+js2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B1LZJjoU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B1LZJjoU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ac074ba920so14810a91.1
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713452950; x=1714057750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9O3FV94jh7vQc95L9k9nvefdNDVfaT9ibGX8CYdkE0=;
        b=B1LZJjoUCtuOlGcn9U1cjNB8sFIjuVv1mQmVusLC7U5bSe2BDxPeb7PGK/33ad+bqU
         ko/ZJ8dY9HhSS6fdKjasdd4PV7gPyYyQgDlre+82dSCb/pmvMzXwQagxGYMz+Co+69wi
         ycdVvJKuCA3aw+qds9laOO3L3eEkCWoW7tdngejNkRT7gEqFxB0GuVo3ZLJ3lo8YqMgM
         2jTDaScUD5Ca7toegrIE/OZ7gvt6wBA2oikW4pt+IU8Pv3EK2PEVjm7d3x7QKGmKcxWI
         iucju/+lE0j7ZW+3LaMz7tFKFpMSJ92Q5E+fehRyMVRNx4LADj2qVaDI6fHUvlFNqfSK
         Of5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452950; x=1714057750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9O3FV94jh7vQc95L9k9nvefdNDVfaT9ibGX8CYdkE0=;
        b=IFdAjLv39lGYccZnUxlX2G7oPW+kAj6NZHCCE+1SuMQ4WC34ZIS+es5x3lE/ERcXEb
         pofNkiQ234CMLoTUSp/0TXVBkShwLzB+UJT10hsxMtW8Ag+8IOphoTv1tfB2/bW7Xm1M
         O2iAt/O2QjG81XiQ62sDIe/PcBlO+ad9NzQ7z7QSkuCQcIWPW/WY+8zlvbKaxARbiQYk
         pEKvUr+8HjY/sJRyY8Zo3HhS1ZjdYjEgjZmrefftjccgPSbybUqqRGyFHctVOfeWATUD
         nuX4/PBEs9n+nBPDjnfojG3Z/ByQQl7Vg8S/s9usXg6JWa9LQGN5zmVLCRzTb3W136dx
         uSuw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfwRv4cGP6hhPwRezNgU5MLWFt7Zzg4K0NXoS7VEbNGp4eaUijJtOv999hv9XyKHwciMVBr/EbHKsI1rbkLjzG7MMWsAUC2eGpVU=
X-Gm-Message-State: AOJu0Yw4nu9d64alIZYAvu+8OBTzRE3AIEq32TmOHo7V2fLCbJkU4jdS
	1yHOX1S7LgpgKWajx9tvKvbXRR7CA+u6g5zY3izfqyT0zqbZrHBCbM5jXpb7Fdw=
X-Google-Smtp-Source: AGHT+IEpDI3SLb6DK8eESf91mbfRxTkqd15fvUPDNtPee/hawli5VCPVwcKmvtkaX2PmBdDDW5btOg==
X-Received: by 2002:a17:90a:7e0e:b0:2a3:be48:23f3 with SMTP id i14-20020a17090a7e0e00b002a3be4823f3mr2885933pjl.4.1713452949760;
        Thu, 18 Apr 2024 08:09:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aa11600b002ab664e5e17sm1547775pjp.1.2024.04.18.08.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:09:09 -0700 (PDT)
Message-ID: <362c3c63-6fd9-401c-9281-e2e0c7efc14a@kernel.dk>
Date: Thu, 18 Apr 2024 09:09:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Mike Snitzer <msnitzer@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
 <ZiCoIHFLAzCva2lU@infradead.org>
 <5f3d434b-e05c-445f-bee5-2bb1f11a5946@kernel.dk>
 <ZiEyLvL6Pq_RB-Eh@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZiEyLvL6Pq_RB-Eh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 8:46 AM, Christoph Hellwig wrote:
> On Thu, Apr 18, 2024 at 08:30:14AM -0600, Jens Axboe wrote:
>> It certainly is a hack/work-around, but unless there are a lot more that
>> should be using something like this, I don't think adding extra core
>> complexity in terms of a special task state (or per-task flag, at least
>> that would be easier) is really warranted.
> 
> Basically any kernel thread doing on-demand work has the same problem.
> It just has an easier workaround hack, as the kernel threads can simply
> claim to do an interruptible sleep to not trigger the softlockup
> warnings.

A kernel thread can just use TASK_INTERRUPTIBLE, as it doesn't take
signals anyway. But yeah, I guess you could view that as a work-around
as well.

Outside of that, mostly only a block problem, where our sleep is always
uninterruptible. Unless there are similar hacks elsewhere in the kernel
that I'm not aware of?

-- 
Jens Axboe

