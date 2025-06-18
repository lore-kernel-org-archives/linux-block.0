Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13E2ECD17
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263942; cv=none; b=DQAkvgLyL0uIc3lc/lI9AGSO3fNtuPOiZwEPbhdBYAQLoSQzTG9EFd4H90txHok1L1aIo1nYF+hfHL2I4iy874Dzv0L4V7jWG9gzafrDqsNFkMHTgI2QG4Frt505ubYCg1S1+GT/blwBS0j5w+f7YVYVT6f9RCEOPkzDZOnhvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263942; c=relaxed/simple;
	bh=ShRjdsaq0YSJizLisN8l/yg/jEDPS2vZH5tSHQicCvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3TGBeTAXOFdBTearn/VHEqjqcEhcIjUqJF6ioGFIEiEzfXTTsamGdXeVR6Q4axu98BO+1xeJEyqUzcSx8k3Yrl6Hp9RqMCM1CAOY8zuF443B2vVC/R9ql/jgdDXg+2zlvIxvWz3G4EetlVZfNvI7hE18FXXww3nWhIvatWlhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DF5TRUd3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DF5TRUd3"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-86d0c5981b3so243384139f.3
        for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750263939; x=1750868739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozpCgMsPDzzzXs9t/hf8mAtpedDuadFmlDFWjP16SDg=;
        b=DF5TRUd3kBQyQ6YtxeRrJ31DtO88Iw0BPeNklKib/O19jANENdTcNv4ZgYjNgOqhe/
         wMDpOciYzG1Ffko1KsL+SNa54MX3tV5EhcgKI00nPVSIxl7/sRN/pqV65TDAR4GV42a4
         KZ8js4tMGYNO8UGs++D/cS4WzTR3wg2NdsVwG/tKOroitN6yR0le+FR9lx8gJTVKrfCD
         sp1+JPHaUqfMC6/qZXhMjg0T7bmzH49JOvTQCqpDrPxOhihwO5ygx0KhusC38FyXMQNg
         wMnzTKbwnCR4rUlLKNHLpEoDpn9cZV3SQnZ3kY3GiA+D74oeQRZ49IulYmapAyztcQvf
         BVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263939; x=1750868739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozpCgMsPDzzzXs9t/hf8mAtpedDuadFmlDFWjP16SDg=;
        b=WlCsYUsrJmWEnmAeits1amVTSYeE+BQrgGTYfBOYdWqBfSFOGsRgCJU1DlEZkbtTg3
         A5VmgFedOxGWaUOKFU4eciZlDTugVFG96RNe2trg1Dlv1AUtdV2u/aAzdCM0aVsg04fJ
         35D6jUBqBRo6ouikN078yWrwS3iwg8y4gSZwBZS71jwU0wh0Nh6SuCzkjlZqgdAp3ZKu
         kIJ6zn5Dhptc3yQexb6PVvpCNkhav4YUGs8OuOlELwkwkzx+f8s3c6BSAhhTrA5YUFhE
         vLyIMdKW9gGB2Zbdyv+/ZHCHWf94bpPk2BIhCpfPxvOEKqne2k+fgN+izxUH7zBv3ue7
         4z4A==
X-Gm-Message-State: AOJu0Yx9PEZVp6XBX6d/Yy8SsYAdBKwUZ9bZRF2slX83O2lAmzEYiQSR
	1OZ+qMn5AnlfFO0kEd7hRi82BuF/QEJCPYny8Egsz7CSVpKQWq7F07SVV5zWUMiCQaPZN+RMkB+
	6eBz1
X-Gm-Gg: ASbGncuCWzG0qZ6Z6kZDWZ4m+vxpMJi8aK9L9RbkdYEbw8rsw/DLK5luzh+3JapGfsS
	yqFM9AXoryip23mXM3tx3LBd/KphL8r5vtOxKGsKVP81TJ8LuVTAwGVcDPFxlRgkasiZPQK8F5q
	l/OHUHNIxxLq8SXRVQVAkENiDY8pRVszVEUcykjIETXuGKKOZ+M6UcQ/8O7gTAfzMEalVpDV/fP
	FH1Y283Nf/QLo03ss8In3BhwIOrgwVXFbeb8lPk4zVUIrhTdatJAa4I0jm1P2X+DZ/w/DcPLUNC
	blRenVdbbhDW8yt8pQH3hoT6sDz7MSjsyXwP8/Pavth/+6FuNVSRyewVZw==
X-Google-Smtp-Source: AGHT+IGYvc7KmhpVgw8CUbD9OCxWguWmto2GTymeiOYZAJ4lER5z1gHVRFjhbAlh/tDcwdwrNsbtSA==
X-Received: by 2002:a05:6e02:2583:b0:3dd:d18c:126f with SMTP id e9e14a558f8ab-3de07d50c73mr187517625ab.10.1750263939115;
        Wed, 18 Jun 2025 09:25:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a4f3c0sm30305685ab.57.2025.06.18.09.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 09:25:38 -0700 (PDT)
Message-ID: <0bbb87cb-5774-4d50-86d3-eb118ebd3f1d@kernel.dk>
Date: Wed, 18 Jun 2025 10:25:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] block: The Effectiveness of Plug Optimization?
To: hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20250618050409epcas5p48f60d6022d148a22fc9fd4a025cc45ca@epcas5p4.samsung.com>
 <20250618050401.507344-1-xue01.he@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250618050401.507344-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 11:04 PM, hexue wrote:
> The plug mechanism uses the merging of block I/O (bio) to reduce the
> frequency of I/O submission to improve throughput. This mechanism can
> greatly reduce the disk seek overhead of the HDD and plays a key role
> in optimizing the speed of IO. However, with the improvement of
> storage device speed, high-performance SSD combined with asynchronous
> processing mechanisms such as io_uring has achieved very fast I/O
> processing speed. The delay introduced by flow control and bio merging
> may reduced the throughput to a certain extent.
> 
> After testing, I found that plug increases the burden of high
> concurrency of SSD on random IO and 128K sequential IO. But it still
> has a certain optimization effect on small block (4k) sequential IO,
> of course small sequential IO is the most suitable application for
> merging scenarios, but the current plug does not distinguish between
> different usage scenarios.
> 
> I have made aggressive modifications to the kernel code to disable the
> plug mechanism during I/O submission, the following are the random
> performance differences after disabling only merging and completely
> disabling plug (merging and flow control):
> 
> ------------------------------------------------------------------------------------
> PCIe Gen4 SSD 
> 16GB Mem
> Seq 128K
> Random 4K
> cmd: 
> taskset -c 0 ./t/io_uring -b 131072 -d128 -c32 -s32 -R0 -p1 -F1 -B1 -n1 -r5 /dev/nvme0n1
> taskset -c 0 ./t/io_uring -b 4096 -d128 -c32 -s32 -R1 -p1 -F1 -B1 -n1 -r5 /dev/nvme0n1
> data unit: IOPS
> ------------------------------------------------------------------------------------
>              Enable plug          disable merge           disable plug
> Seq IO       50100                50133                   50125
> Random IO    821K                 824K                    836K           -1.83%
> ------------------------------------------------------------------------------------
> 
> I used a higher-speed device (PCIe Gen5 server and PCIe Gen5 SSD) to verify the hypothesis
> and found that the gap widened further.
> 
> ------------------------------------------------------------------------------------
>              Enable plug          disable merge           disable plug
> Seq IO       88938                89832                   89869
> Random IO    1.02M                1.022M                  1.06M          -3.92%
> ------------------------------------------------------------------------------------
> 
> In the current kernel, there is a certain flag (REQ_NOMERGE_FLAGS) to
> control whether IO operations can be merged. However, the decision for
> plug selection is determined solely by whether batch submission is
> enabled (state->need_plug = max_ios > 2;). I'm wondering whether this
> judgment mechanism is still applicable to high-speed SSDs.

1M isn't really high speed, it's "normal" speed. When I did my previous
testing, I used gen2 optane, which does 5M per device. But even flash
based devices these days do 3M+ IOPS.

> So the discussion points are:
> 	- Will plugs gradually disappear as hardware devices develop?
> 	- Is it reasonable to make flow control an optional
> 	configuration? Or could we change the criteria for determining
> 	when to apply plug?
> 	- Are there other thoughts about plug that we can talk now?

Those results are odd. For plugging, the main wins should be grabbing
batches of tags and using ->queue_rqs for queueing the IO on the device
side. In my past testing, those are a major win. It's also been a while
since I've run peak testing, so it's also very possible that we've
regressed there, unknowingly, and that's why you're not seeing any wins
from plugging.

For your test case, we should allocate 32 tags once, and then use those
32 tags for submission. That's a lot more efficient that allocating tags
one-by-one as IO gets queued. And on the NVMe side, we should be
submitting batches of 32 requests per doorbell write.

Timestamp reductions are also generally a nice win. But without knowing
what your profiles look like, it's impossible to say what's going on at
your end. A lot more details on your runs would be required.

Rather than pontificate on getting rid of plugging, I'd much rather see
some investigation going into whether these optimizations are still
happening as they should be. And if the answer is no, then what broken
it? If the answer is yes, then why isn't it providing the speedup that
it should.

-- 
Jens Axboe
