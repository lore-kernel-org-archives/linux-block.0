Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SFnuuT4g"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F6C170E
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 06:31:11 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d05a2307a5so693865ad.1
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701441071; x=1702045871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+ZZ9Fdpem6RBs6tyqgG/JrSfDMosdnUH/FBZ+sqWVo=;
        b=SFnuuT4g5S9jI7rDwlPwtOg8T4h7ufBeWNmyk/bTVS7IboVhlYNgqsYM9oUWHzSqtx
         xdoIMRdWGhxqYtGvMFN8+cH1NBVNSqsaNNViGY6QGpNt4CJgxoQdHCbKHldQReY0TLbF
         +FpL1hTS346akbRzzaLk3xMFPrPzVsr57wMsnCsyp76MP5hi486J94ayDRt7KoumxhHH
         er7+J3SbjNIAZEg28pT/sPMm+FhQrbqOqqqouOrZ57fewfxo91kYxurP+02RC/Xkh180
         5Mj/8x1ei24yJoyLAju9Jj8F8tjbteYmM6Eo3eBHEcu3QEUrOGtakENFO4fqJvi8WmSL
         sfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441071; x=1702045871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+ZZ9Fdpem6RBs6tyqgG/JrSfDMosdnUH/FBZ+sqWVo=;
        b=D9y1IQ5K6s8gk2CPmK7SwW97U6AzcyiXOb5+eaQ28B8IJEqZ9MwRMnScOl8EWEWifn
         lFOtyvGRaXJnUPTbc2dTk/JlrdbDKNMaPJrrNSYaoKkEmUtloIsEzGc+9nrlPaBaokMR
         zBYim5p9NZZoivvgyRJ6wB6ZPKjON2EG7/kGgcboQp3PTte2Pk2dwuDOBTIvxtKDBmDF
         2gAqH+7QiiLVcGU8PDzc1pMyN86PtVK7qL/fmt7l/rbv38DN7HKYC66uhUEi4IXs2WqO
         80aJQYql5IflBBgeNGwuicOfEMwnlKaYSd0Dhod70tHKmfb6PCgdPwfJEIyuOmhZNOWt
         kCJQ==
X-Gm-Message-State: AOJu0YxAg3v+6sMscAuULzRmzxNJv0H+CClaIJVv1tTR4Eo1hXUP+FoX
	nWsiEvTc2YNR07y8C7eBqB05WA==
X-Google-Smtp-Source: AGHT+IEi5SKoi8OKj7hhkEs/Z0hIoBqgB8zSLVO9Kw792WuLMa9AnTM6QnyUM6aSC0lq9o7hDA39Eg==
X-Received: by 2002:a17:903:2308:b0:1ce:63bf:e4c9 with SMTP id d8-20020a170903230800b001ce63bfe4c9mr28473261plh.0.1701441070984;
        Fri, 01 Dec 2023 06:31:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001cffe1e7374sm3382875pla.214.2023.12.01.06.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:31:10 -0800 (PST)
Message-ID: <50b81e9b-2585-4aeb-b182-93ee089b9d6f@kernel.dk>
Date: Fri, 1 Dec 2023 07:31:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough
 io
Content-Language: en-US
To: Kundan Kumar <kundanthebest@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 "kundan.kumar" <kundan.kumar@samsung.com>, kbusch@kernel.org,
 linux-block@vger.kernel.org
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>
 <20231123102431.6804-1-kundan.kumar@samsung.com>
 <20231123153007.GA3853@lst.de>
 <85be66ad-0203-6f81-8be0-1190842c9273@samsung.com>
 <37d9ca26-2ec2-4c51-8d33-a736f54ef93f@kernel.dk>
 <fba18f05-ae51-4d46-932a-5f4f9d2aab07@kernel.dk>
 <CALYkqXp36aJbu+2PgHQhSaXh38zTtcnVza+pexqJyDEDaq=V7Q@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CALYkqXp36aJbu+2PgHQhSaXh38zTtcnVza+pexqJyDEDaq=V7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/23 4:28 AM, Kundan Kumar wrote:
> This is what I see with your changes on my setup.
> 
> Before[1]: 7.06M
> After[2]: 7.52M
> 
> [1]
> # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 \
> -u1 -r4 /dev/ng0n1 /dev/ng1n1
> submitter=0, tid=2076, file=/dev/ng0n1, node=-1
> submitter=1, tid=2077, file=/dev/ng1n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
> Engine=io_uring, sq_ring=256, cq_ring=256
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
> Engine=io_uring, sq_ring=256, cq_ring=256
> IOPS=6.95M, BW=3.39GiB/s, IOS/call=32/31
> IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/32
> IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/31
> Exiting on timeout
> Maximum IOPS=7.06M
> 
> [2]
> # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 \
> -u1 -r4 /dev/ng0n1 /dev/ng1n1
> submitter=0, tid=2204, file=/dev/ng0n1, node=-1
> submitter=1, tid=2205, file=/dev/ng1n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
> Engine=io_uring, sq_ring=256, cq_ring=256
> IOPS=7.40M, BW=3.62GiB/s, IOS/call=32/31
> IOPS=7.51M, BW=3.67GiB/s, IOS/call=32/31
> IOPS=7.52M, BW=3.67GiB/s, IOS/call=32/32
> Exiting on timeout
> Maximum IOPS=7.52M
> 
> The original patch avoids processing throttle stats and wbt_issue/done
> stats for passthrough-io path.
> 
> Improvement with original-patch :
> 7.06M -> 8.29M
> 
> It seems that both the optimizations are different. The original patch is about
> "completely disabling stats for passthrough-io" and your changes
> optimize getting the
> current time which would improve performance for everyone.
> 
> I think both of them are independent.

Yes they are, mine is just a general "we should do something like this
rather than play whack-a-mole on the issue side for time stamping". It
doesn't solve the completion side, which is why your patch is better for
passthrough as a whole.

I do think we should add your patch, they are orthogonal. Did you send
out a v2 we can queue up for 6.8?

-- 
Jens Axboe

