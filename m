Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941F2F1FE6
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985317; cv=none; b=QRxxnB1pjvNdqG7pjBA/MGVmBgDbxb7s9inqSfsy6waSVvWKB82nEnorQCHkoSMdPSERvcu0B0toR2bdcgvqwWDdjz5dQrdNWQK3SkdRZ3LIVIceOrQpd4rL0NQ00jL3DO5DRxDno9LaSKyi4uOXF40cA9YQsAoo05KtHrIppis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985317; c=relaxed/simple;
	bh=J/d4XuYbaNf/DrLUrMfdQh4DvdG2m4rdK7sWMX/3CyQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P8J0dBY3xP0I8rfz2HIDhg+hB4d29ou9SWw8DfmsAQUqACyh5E8YVSeO/qCG4mK2K2FXd8XM1gg9SsD2kitEKl62VJHNqquqrS7o3wA875rPd2bTuTirDl73SwG9c9pt19bsghvvWwGWmyab5ntPp7JzKpO/rxqmKxw1Q2wxxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=osIA7cLh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="osIA7cLh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350b1b9129so12419075ad.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750985313; x=1751590113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ga4jCRubMghEqDDw6M3zjjXONb4yHOKUQnMWlEQFChw=;
        b=osIA7cLhto6Oblc9aYALRmwlyW36zLr+Fubdj2cj8l/KgPObauERflhaWik2y0AdiD
         6DLuD5Hs97sPDLMbnpE0zWlP23KCvyiPvyc93Nm6WUJ7DiSxjvNAG19irN6jQTn2bwCI
         gCQ3KzHBK2JMY0gQiEpZACKxj041Qk0CuJ1Gp2SgFzInRQpa3SaAE4gYXYMNRpw949jD
         EGZQP3C4Z151YpAxBVdCuhJ8mSTHBPA1G565apZnnVsfsyi9ARAeRVHOdyTt7oI2ptg/
         4eYT5ZFNr6+G1E9dgdVgfRCdnGkdJTdNay8/I9MPChV7z6csT4zVCAkGonBvuEyoxgmz
         kNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750985313; x=1751590113;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga4jCRubMghEqDDw6M3zjjXONb4yHOKUQnMWlEQFChw=;
        b=QNB+C6DJA/5RMQc1L9rDb0tT0/LXqYUZh059aH25mXbY6ib/1xh8vX8JHVll1CZVEP
         Jz6O8acGuJjcWbioNbmB1KtVAaBZsqSGXzljBJC42KoRJ9MabQhKLmdLLH0l1qAwzn1W
         44VcIec0uKUcs3cGpLanQaRH2x109SuD7wtDtexdn2VzgIz487FhFU6PZ2dldCN0ka+1
         R9lV0ybGzFp1pAavKr1YQHvk25RPd6pQaUXRsYSQVu2f7j1rvtarqlxxyVmkgk43OZZj
         Zs05BNQvh84j7PgBBIq5f+/Z63sV/rEEmCZk2tU2SCiYtqWMW7J1Dh+Voo34bS61jOEU
         uaqw==
X-Gm-Message-State: AOJu0YxlNq3N3OXEYpy/PfPUn1xRHaDmXcGFaLyL/NLaXrIvA1uAraBK
	B+v6/DUGi2nMR8BCwJprTpq/svoY5HdvU1vq79TS2c15OPud+OVs4L6rtviWWexCBAx0w9h8Mmf
	M+NtY
X-Gm-Gg: ASbGnctZp6epCD9uSS9BL8WBbkmgdwey9odxd4Ha2gAgFg8hKpyA/dPeNnMo8CE3NcX
	c4htAjv2k7oBmyPfZsWEh6eFxTf9SDnKgJ8ugi5YO+whPp+GCV98XM//k7Dxm3H8SGHFHpMJCsi
	2CkvJkfG1aOlxbxVVeshh9kgPC8A8dmdtv6+CSGGMMSU/CDUY3UH+veG4hLpN3s7MI+2+x6vHe7
	Jtf5artpxzAUoO69uGDc0QIlZEhMJkjjbDcHjQm+dwnzZ/PEWGzE4zcOJbUBqqtY70B/S7ViksS
	AsXo5vHYmInbIGh8LSvxpfMRW6LDS4YsWUUYYL4gCBkSMOAraIlmgRH70A==
X-Google-Smtp-Source: AGHT+IHLahkaVVdjMsOTn7+3yeQBPjDmmpmXUw/rLgx5dt7lRHD8+ZKdsPV5/QsjbJvVePLYOt/YeQ==
X-Received: by 2002:a17:902:d488:b0:235:225d:3083 with SMTP id d9443c01a7336-23ac381734fmr14586455ad.6.1750985313220;
        Thu, 26 Jun 2025 17:48:33 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d35edsm2514205ad.257.2025.06.26.17.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 17:48:32 -0700 (PDT)
Message-ID: <25e5a0c0-f16c-4ed2-b734-6116e8047f15@kernel.dk>
Date: Thu, 26 Jun 2025 18:48:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] ublk: allow off-daemon zero-copy buffer
 registration
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org
References: <20250620151008.3976463-1-csander@purestorage.com>
 <175098525219.298187.9518585117655894766.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <175098525219.298187.9518585117655894766.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 6:47 PM, Jens Axboe wrote:
> 
> On Fri, 20 Jun 2025 09:09:54 -0600, Caleb Sander Mateos wrote:
>> Currently ublk zero-copy requires ublk request buffers to be registered
>> and unregistered by the ublk I/O's daemon task. However, as currently
>> implemented, there is no reason for this restriction. Registration looks
>> up the request via the ublk device's tagset rather than the daemon-local
>> ublk_io structure and takes an atomic reference to prevent racing with
>> dispatch or completion of the request. Ming has expressed interest in
>> relaxing this restriction[1] so the ublk server can offload the I/O
>> operation that uses the zero-copy buffer to another thread.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/14] ublk: use vmalloc for ublk_device's __queues
>         commit: d2bc702a8db21c9819f25737a4343f6dfc238582
> [02/14] ublk: remove struct ublk_rq_data
>         commit: f053751a413b232cecd5cb3d3d9c1f972a849310
> [03/14] ublk: check cmd_op first
>         commit: 6762d9c0b76e2a449a818539f352bd14a5799512
> [04/14] ublk: handle UBLK_IO_FETCH_REQ earlier
>         commit: 1a3402e31fca3dbeb915c34a077ca3d143b42e55
> [05/14] ublk: remove task variable from __ublk_ch_uring_cmd()
>         commit: e9415d3aee01b51c8633d38ca62f74f7071a74ba
> [06/14] ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
>         commit: 82293b83e42366d15ded8516a4d45f8d466e69ba
> [07/14] ublk: move ublk_prep_cancel() to case UBLK_IO_COMMIT_AND_FETCH_REQ
>         commit: 624006c145af20924624d4f2846da74f94aa9078
> [08/14] ublk: don't take ublk_queue in ublk_unregister_io_buf()
>         commit: 3e6b973df269180c22e024606585f8b4ca33ca99
> [09/14] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
>         commit: 73166f433b3c2a6acebb850f5eefea36c137f6c3
> [10/14] ublk: return early if blk_should_fake_timeout()
>         commit: 358f19d7cadbb5a7626cfd5822260aadead7f37e
> [11/14] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
>         commit: 47c894fdaaee8b424cdbcd0fe490a10ea89ab0ee
> [12/14] ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task
>         commit: 230c5a4cfc6f98d2432aff05bb3ec092fde519f5
> [13/14] ublk: remove ubq checks from ublk_{get,put}_req_ref()
>         commit: 21d2d986b5511ac017660720ed0016ce2780396c
> [14/14] ublk: cache-align struct ublk_io
>         commit: 456ef6804f232f3b2f60147046e05500147b0099

Caleb, please check the final result in my for-next branch, as
expected this conflicted with changes in master/block-6.16.

-- 
Jens Axboe
