Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nwRgB9Hu"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4AED41
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:07:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so227470a12.0
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700770039; x=1701374839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfdEJhC271cbxBv+hBWLsnJluLmtEoy4VrNVAQBJi3M=;
        b=nwRgB9Hu6ARcpp0B1prx9lra8cd4mdRRO61xCIgWucAyhNZ5ohwyO3Rh/uLw2ee1Yh
         kTh7BB0gPKf+bU2kSKAIZUXp+omZ/19EyDRpEC0CXBpA4mCvFmEeZdWyX3Y4ZotH+zBX
         xpNvUzSUbw753OAevCnfhf+f1K1yGWlF+deztCviHk2iT6GoEt7AiX9AnMWzU0tmdY/n
         c0YtY7qnkplR7fBM2D9NLijhn6EihXs+HvqZ3NEP1RbOWb1RcA98PiO3X6pFy/QDsXRy
         FOlPylqMrZecX54JA7K0+tqt6URzTVCEtpz0ZDmyxIoEWEbmv+hnFsiNqyfFm35tpAy4
         lA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700770039; x=1701374839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfdEJhC271cbxBv+hBWLsnJluLmtEoy4VrNVAQBJi3M=;
        b=p0KyK3Xlh0SpBRD8tAw8AsRfegsqCheP/WED2Y2xVPpCg6Z8XngoW05fKRDbOOUcBD
         tDSl1wXeLnrTF+2WCQOlraaPp7MTZS3CVAvrc3iRvSyeL84Pwl8ACkJpPDjU7buQzP6j
         rKuRPNzwExb4SLwC+8ikAK4p3lKzXhuZeqCjLsJizHP0gvIGA4ld6z9x50G/sJj9sbnO
         fndPpDSWW3T0ChtcKvUDB35p+gOg3ZKJkV/PyszZZXSWuJHo3Nw0bIMmY2+8Vwu/+2u3
         eefjBXU8S8L650/3tF7qHFQYqmUCDhv8jJ2aYw7bIDAqw8qQkRoaUxbmWFAfevSGFR5I
         PeDw==
X-Gm-Message-State: AOJu0Yy4XfsQj6gUXL0lzTC7mppEyGxlKpBmuZKlrs1WrDpDGOMHvmfi
	T78NP4Nu1t/t95VBeOsiL44p2g==
X-Google-Smtp-Source: AGHT+IFTPpjmAoO7mHCMyiVLaGERGVqV1dK3Csr5qLeS/yTiBNffUyx600lOHnpSMIXQpFRjyGMQWw==
X-Received: by 2002:a05:6a20:e11a:b0:185:a0eb:8574 with SMTP id kr26-20020a056a20e11a00b00185a0eb8574mr910592pzb.5.1700770039066;
        Thu, 23 Nov 2023 12:07:19 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id az22-20020a17090b029600b00280a2275e4bsm1937779pjb.27.2023.11.23.12.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:07:18 -0800 (PST)
Message-ID: <9184cfff-0b2a-4b74-a5aa-4a1357003a41@kernel.dk>
Date: Thu, 23 Nov 2023 13:07:17 -0700
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
To: Christoph Hellwig <hch@lst.de>, "kundan.kumar" <kundan.kumar@samsung.com>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org,
 Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>
 <20231123102431.6804-1-kundan.kumar@samsung.com>
 <20231123153007.GA3853@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231123153007.GA3853@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/23 8:30 AM, Christoph Hellwig wrote:
> On Thu, Nov 23, 2023 at 03:54:31PM +0530, kundan.kumar wrote:
>> -	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>> +	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)
>> +			&& !blk_rq_is_passthrough(rq)) {
> 
> && goes on the starting line in the kernel code style.
> 
> The rest looks good, but that stats overhead seems pretty horrible..

It is, but at least it's better than what it used to be. Here's an
example from my box, you can pretty easily tell when iostats got enabled
while it was running:

[...]
submitter=22, tid=645761, file=/dev/nvme22n1, node=6
submitter=23, tid=645762, file=/dev/nvme23n1, node=6
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=119.09M, BW=58.15GiB/s, IOS/call=31/31
IOPS=122.03M, BW=59.59GiB/s, IOS/call=31/31
IOPS=122.01M, BW=59.58GiB/s, IOS/call=31/32
IOPS=122.02M, BW=59.58GiB/s, IOS/call=31/32
IOPS=122.02M, BW=59.58GiB/s, IOS/call=31/31
IOPS=112.72M, BW=55.04GiB/s, IOS/call=31/31
IOPS=108.43M, BW=52.94GiB/s, IOS/call=31/32
IOPS=108.46M, BW=52.96GiB/s, IOS/call=32/31
IOPS=108.58M, BW=53.02GiB/s, IOS/call=31/31

-- 
Jens Axboe

