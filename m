Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71631B6D01
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655606; cv=none; b=pFKEOprdoe+o+tQXwoIj71prxXpQZn5d0c+o9mzRXJZ3N02J8b5drvCKkd/kPEqlYJk5FKT/dOJbbpv/5shgb3fC3vW92kuzsgvY79Bxv/2cQmTsdBef9mj8M+Ud7Ui6NamovhEZBIDd0YTu92AzHuwWnSsVbyJurOfhuElK1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655606; c=relaxed/simple;
	bh=Zclb6nP9tKkJil/hrncF8At7GwOesOJIVfldb1hH5Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT/QUApoMcNus9KxDqyXCbpVRU15iJYCmuXTJ1nwWw28cHJTZiIeH2RRvQtaI+VCxlck1/VDwmXMQjW/cAKqO6DWaULqRq6yLRAqUjJwfH3eZJq0YEAKf/CPlzy4t5HnovKM950QZfGuCbFle3UtGJnb+PsbPeElwOMTAtqGpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E8VFAdOT; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E8VFAdOT"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-874a68f6516so169784939f.2
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749655604; x=1750260404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=;
        b=E8VFAdOTu+z7NAH3Y9NFWPox06EIuHK/dw3gj7rHm+qecwZF01BLOFMRbYXcDDNVDv
         YO9fn5kdmEku+d8ANek+tYGF3vb7h1wN/Hfy2Zj/vzHCCysf+WqoVGLz0miCgGaGOhQC
         tpoiFMhp4uiHzIZtrd6JtKxPBfaY50y+s53WotNLrwzkhY5+pg47NGs0bKnd3XWmuYZ3
         mesEXznMEeAGV8devH5qRRaH1M7DUDpEkhc4KjDXPmvOBbYEfTFyicgRFwtFyM1kw3tx
         kMhoJvPIAV1odxZKkslbZRSZgnOfMsQR3alnr5hM5/1yf7pvn2Ik1arzmoJEPOD3mW8C
         EziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655604; x=1750260404;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=;
        b=Q317ZTqDXky1qd8fIB50DZH85V1IlN665tRzOuO0WnZfPi9of0++1Ab7hzpvG7L7ft
         l3tHiLpXaeU06Uu59F15MsCBkqic59Y17wVXu7VShXh31Ira580V5yIifkGfmOGxh4ql
         OGtEJ2QZHTOjzKUyZwwnRQ5IAY2TWa762maPVMT8NG0W8wzAH0bOA5bI22nM8kFubFTk
         QiPAq5riADkmbAh90myT+vOwR5vBo1tPAu5K8AhbIdl5auEVNBntjE/bXV4/SEa4Imf8
         vST2984qSpG12c2y9osL4Po/nYIe7LMwMtAKDxg9c1sp46pvQKNpBsCkF5/863xxf63/
         uXow==
X-Forwarded-Encrypted: i=1; AJvYcCW3mm+zBWmfOaLdV6/eXP125MZrv5KYqDnPaqdFjol9o6n4KHerV6O9FTVf0SqmFHRI+b6iI71vI08AGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4D+xM23qCymSPuQX3vPZtKqBU27p10JvO/i7VM0ASZS2xmlRi
	kva60mm/+1mbOh1p/FFWojl6KNaAU2JWHks9KV2Cgsi+hVqamWaXzWqSsn2EAdQIdvg=
X-Gm-Gg: ASbGnctgH2JflRCQQO/EeMQZD3S+vEeaV8LNX24qPMJEmvBc/46fxZ6IcPsgVcwEEe9
	MbvsG/AhSNT5/inviQoJeZUw0gjFzBjIxYjErgKUoTKSjUwMNyPfaCKaOAYZTneOH/XS4hJ9/39
	d+ki0cUVtiTdcYvU3YEZfYm3r1qCfQm6DodP+t0BDOsV6xfcPWL5vbOmKM+aR7fxfB+ujejkuww
	/JHwC9a4n+L1kkzoxo3tRacqAt1DgxemVVtC8ypMNnTvx3hIMfOCuMhTe7YYKJL6c5hZQk+P41V
	0NuDiOIOqSyreApL8pLxuG3VGa+ppT64rAAdm7SQ5z76PXPJVvzAClHUgA==
X-Google-Smtp-Source: AGHT+IHaxfT+O57Vn8979jdX84yGSFMet3prL9YRAAW17QgstqoINM/JBUR9h2E/1+qlZME9XacRsQ==
X-Received: by 2002:a05:6602:36ce:b0:85a:e279:1ed6 with SMTP id ca18e2360f4ac-875bc472084mr439890139f.11.1749655603849;
        Wed, 11 Jun 2025 08:26:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc5b4294sm44276539f.14.2025.06.11.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:26:43 -0700 (PDT)
Message-ID: <afb8792b-a78d-4886-bf9a-23121510dec5@kernel.dk>
Date: Wed, 11 Jun 2025 09:26:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Ming Lei <ming.lei@redhat.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <aEmcZLGtQFWMDDXZ@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aEmcZLGtQFWMDDXZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 9:10 AM, Ming Lei wrote:
> On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
>>
>> My benchmark is:
>>
>>     fio --time_based --name=benchmark --size=50G --rw=randwrite \
>> 	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
>> 	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
>> 	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
>> 	--group_reporting
>>
>> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
>>
>> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
>> --------------+---------------------+--------------------
>> 6.15.1        |   362               |  2KiB
>> 6.15.1+revert |   660 (+82%)        |  4KiB
>> --------------+---------------------+--------------------
> 
> I just run one quick test in my test VM, but can't reproduce it.
> 
> Also be curious, why does writeback produce so many 2KiB bios?

I was pondering that too, sounds like a misconfiguration of sorts. But
even without that, in a quick synthetic test here locally, I do see a
lot of missed merges that is solved with the alternative patch I sent
out. I strongly suspect it'll fix this issue too.

-- 
Jens Axboe
