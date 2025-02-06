Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FF1A76AE
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872570; cv=none; b=sxatesSg9hSNDCfeGkz1teCMKNP+hUlFADUn93DmnvNtcF9GemMNOuf+vBdMp09a/RW7AS5Vj+EceMTYm1yO07qPoNV+E1S+WSqLlnTowzEEGrNIvgCU4p74obu4aUTwpn0S1eP8wBn9XVYyUkBEBlP1RnOHdJ5Fj8TrtU155h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872570; c=relaxed/simple;
	bh=IL9giDJKMXrTYJ03FKynQzs/VPi3W7a9dIIbM0LJRuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuogyFIeIRQVhVoThEgNP0nutphxo31tppyvvsZ70WyElHGVSCizHlAnWKtPsskKL0BLBuR40kQZ9pwMNJTA/llKhjGXHlOB5zEVfY7g+EbyxU3NMZph+7CDgo0aaEdZKa4+wZ90/V7irVVYbqBPId9JwwLvjlggUtGc2p65CxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IueFADSf; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IueFADSf"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so5667385ab.0
        for <linux-block@vger.kernel.org>; Thu, 06 Feb 2025 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738872566; x=1739477366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcYsnWMPE/NAsZ8BGEyZl3AkrSLMNwe71mS2eN9HVIg=;
        b=IueFADSf7dH2iOiNqZsk1tGCCCYP7YMGdTGiNfP2kv/v2RvPuZurSDWPqK+dZ9tTdn
         66EdbcGO5lyu0J1+H0O5WzbCgn6l7BSvtDyx8LvSu5c9NzYNslE6OoebQMMjDXfBVGdd
         VGY/7ri26E59RswwM27YPL1QENw7OZ5ZbaiQvxqDdxxdlUlN1eqxUU8sJ4C1yPIVaSgI
         MFTakc7gdAALc8lEp15/metFfUQOc7aCF28DDZb81h7eHys4b4/EbiH1UFLZhGFeTkDh
         Av7Yz3T8uoux4XCT/eb3gQ6KOZHJUh6YDR8Z3xwK3yjKfxMEB3FtqYNC+AXoNZ646e/9
         cEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738872566; x=1739477366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcYsnWMPE/NAsZ8BGEyZl3AkrSLMNwe71mS2eN9HVIg=;
        b=PmKufpY71wmA3DVwKDjQ9PirQOtmBIeT96VIG2t6FSDyl2aoZZSkbakrQ5sdfBRwnL
         r1w8qvGyjWfjbfwrGBN0d93jD7cR/0NkaPrAv3xDpKgi6YSmifhZmo+eh/A2JTNpN3yK
         ik8GymEDBxuj9GNJbJuXMiyK7lp++bj37EcPRcjtmSLs46Axn54llNJkyVOZQgQphQ9/
         cxo9zpKeezpp68zuWMyNPuKzbdGX0Du4/beLw6aJfpb00pAhokPHyDKW8M3eEMua1r0n
         iknjMUlTwfmQpRR0+keKqUTwS9gp2d6wAlliGYWbKFr06UJ1i7wWplDRat2zhKtdWTTh
         rwHg==
X-Gm-Message-State: AOJu0YxvaP5LFriMoOI4+TCb5Bml9p1P4V7ANlknqXvKuI83bZIonF9G
	SABmAs3Sm2Qz5rQ+1Up4GUW0mkNKpAL8/JO2lkciws3w97kBcX9Q+lAx+IAwT9I=
X-Gm-Gg: ASbGncu0m5i8db1TeHA05Km9Q297rHR/uf1LX9Ei814uDnH5exwE4XWFhNjjxXMroBL
	zui/FiMZ+qFZFEXsCfx66rVvu9yIiB3GcKV56AaNTGx+9LYQVDdtKWM1e30FXH9RMjGRiPOGa1S
	pSMxTKAQiWYfutsCBI9100yDc+4+Z7PQSj/ypQGj6XZvrE3vVhmfOa3y3sYS95p8iVx/BBdJPrd
	NguUJMhYbHwbcPZSnT4d40x6Dr8wfOWZbZT8DR/z0jcCAiJcFUq0KcQEyKpWSb/ytdTBj+b5u4Z
	33b3VBmh5LM=
X-Google-Smtp-Source: AGHT+IG1o6DgvocnYFu/AUg+c55lInkXy2sLF1Ey6Rhe1qtJ5ksFZKTqkg4oJZo/ywTcxF7NKgebjw==
X-Received: by 2002:a92:c0c7:0:b0:3d0:ba6:1b4b with SMTP id e9e14a558f8ab-3d05a6885dbmr35644565ab.7.1738872566585;
        Thu, 06 Feb 2025 12:09:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afde3sm409453173.9.2025.02.06.12.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 12:09:26 -0800 (PST)
Message-ID: <1aad2e80-427e-4f53-9343-baf5bee8e88c@kernel.dk>
Date: Thu, 6 Feb 2025 13:09:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Block IO performance per core?
To: Nitesh Shetty <nj.shetty@samsung.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, gost.dev@samsung.com, nitheshshetty@gmail.com
References: <CGME20250206131945epcas5p23d932422bf2f172e132678b756516c0d@epcas5p2.samsung.com>
 <20250206131134.cqlq5fhem34eme2u@ubuntu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250206131134.cqlq5fhem34eme2u@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 6:11 AM, Nitesh Shetty wrote:
> Existing block layer stack, with single CPU and multiple NVMe devices,
> we are not able to extract the maximum device advertised IOPS.
> In the below example, SSD is capable of 5M IOPS (512b)[1].
> 
> a. With 1 thread/CPU, we are able to get 6.19M IOPS which can't saturate two
> devices[2].
> b. With 2 threads, 2 CPUs from same core, we get 6.89M IOPS[3].
> c. With 2 threads, 2 CPUs from different core, we are able to saturate two
> SSDs [4].
> 
> So single core will not be enough to saturate a backend with > 6.89M
> IOPS. With PCIe Gen6, we might see devices capable of ~6M IOPS. And
> roughly double of that with Gen7.
> 
> There have been past attempts to improve efficiency, which did not move
> forward:
> a. DMA pre-mapping [5]: to avoid the per I/O DMA cost
> b. IO-uring attached NVMe queues[6] : to reduce the code needed to do the I/O and trim the kernel-config dependency.
> 
> So the discussion points are
> 
> - Should some of the above be revisited?
> - Do we expect new DMA API [7] to improve the efficiency?
> - It seems iov_iter[8] work may also help?
> - Are there other thoughts to reduce the extra core that we take now?
> 
> 
> Thanks,
> Nitesh
> 
> [1]
> Note: Obtained by disabling kernel config like blk-cgroups and
> write-back throttling
> 
> sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n1 -r3
> /dev/nvme0n1
> submitter=0, tid=3584444, file=/dev/nvme0n1, nfiles=1, node=-1
> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=4.99M, BW=2.44GiB/s, IOS/call=32/31
> IOPS=5.02M, BW=2.45GiB/s, IOS/call=32/32
> Exiting on timeout
> Maximum IOPS=5.02M
> 
> [2]
> sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n1 -r3
> /dev/nvme0n1 /dev/nvme1n1
> submitter=0, tid=3958383, file=/dev/nvme1n1, nfiles=2, node=-1
> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=6.19M, BW=3.02GiB/s, IOS/call=32/31
> IOPS=6.18M, BW=3.02GiB/s, IOS/call=32/32
> Exiting on timeout
> Maximum IOPS=6.19M
> 
> [3]
> Note: 0,1 CPUs are mapped to same core
>  sudo taskset -c 0,1 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n2
>  -r3  /dev/nvme0n1 /dev/nvme1n1
>  submitter=1, tid=3708980, file=/dev/nvme1n1, nfiles=1, node=-1
>  submitter=0, tid=3708979, file=/dev/nvme0n1, nfiles=1, node=-1polled=1,
>  fixedbufs=1, register_files=1, buffered=0, QD=128
>  Engine=io_uring, sq_ring=128, cq_ring=128
>  IOPS=6.86M, BW=3.35GiB/s, IOS/call=32/31
>  IOPS=6.89M, BW=3.36GiB/s, IOS/call=32/31
>  Exiting on timeout
>  Maximum IOPS=6.89M
> 
> [4]
> Note: 0,2 CPUs are mapped to different cores
>  sudo taskset -c 0,2 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -n2
>  -r3 /dev/nvme0n1 /dev/nvme1n1
>  submitter=0, tid=3588355, file=/dev/nvme0n1, nfiles=1, node=-1
>  submitter=1, tid=3588356, file=/dev/nvme1n1, nfiles=1, node=-1polled=1,
>  fixedbufs=1, register_files=1, buffered=0, QD=128
>  Engine=io_uring, sq_ring=128, cq_ring=128
>  IOPS=9.89M, BW=4.83GiB/s, IOS/call=31/31
>  IOPS=10.00M, BW=4.88GiB/s, IOS/call=31/31
>  Exiting on timeout
>  Maximum IOPS=10.00M

While I'm always interested in making per-core IOPS better as it relates
to better efficiency in the IO stack, and have done a LOT of work in
this area in the past, for this particular case it's also worth
highlighting that I bet you could get a lot better performance by doing
something smarter with polling multiple devices than what t/io_uring is
currently doing - completing 32 requests on each device before moving on
to the other one is probably not the best approach. t/io_uring is simply
not designed very well for that.

IOW, I do like this topic, but I think it'd be worthwhile to generate
some better numbers with a more targeted approach to polling multiple
devices from a single thread first rather than take t/io_uring in its
current form as gospel on that front.

-- 
Jens Axboe
