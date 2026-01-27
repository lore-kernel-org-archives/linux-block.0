Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523253101AA
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486997; cv=none; b=OVc+4G/N0riDnXjQzjIGCZWjYNy+sQxIitWGMBU2QUdigG2rBWKCf3S5kScXuQtFaggTfUX7dVhddUOXNdpOqHWQjULJd4qK5G3oNjEzbZ1DqECHyNl1bhoBMi5Ed3lzX/ThbmdXIpS4ezvrn6eHHFiBc0H5OJ3Zvx+gUSLJFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486997; c=relaxed/simple;
	bh=BN3CAgnxqnEVrtlsViIXiKiOWir2E20j7eD9eVJlRYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpRyBnR78+eXUq0TJSVqWwusqPBTdwjARqg3P0y6fD1Q0irCUDscNP/40PeKilUGgFtwDuz2Olj0qTJdEGRa/r36Ms9djaQt4eVPOmBe/yzydqL9n5/xFXVlhKPomxSfhoxLzshTWxBlbsEaV6MFatSo4w+UP7r3/LmFuNQ/5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oqGmkJbr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oqGmkJbr"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014f383df6so45186541cf.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 20:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769486994; x=1770091794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mP68NfFM7IQRhODpoTkfedHKfb4Sf8/+j40FdpDcgU=;
        b=oqGmkJbrnmQ0Tv/qsbV7BYAbczE3kq+nT6ejtsXTgYVmZdH+Di/Ml4nSkJW1+YvC7/
         xD1RoqE6zPIp2o1Etqcu+QF0H9ps5wI0/zmtzcIodfC3GJCUr9GUQWamfDAcaY+HeXIZ
         CFi0ZkD84kusdd6F9Jh4Eq/s7jhOFz2HmuisLMBvXrbCalyqEv+51ZY2Ic31xytgwX1J
         lV7SLTHnKXrXfqT8yZ4RTJNpp7ZRf3P1t0TqnG7C9gnV/P8dB7dmvFYXCYUfUw38T+7t
         1bPyaDMTIiwS4eDtKalnIieJQyNPGSZ+nlnEoT+MLiUV3cdew+GogNqvxZoeqOwFva1y
         9kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769486994; x=1770091794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mP68NfFM7IQRhODpoTkfedHKfb4Sf8/+j40FdpDcgU=;
        b=xRGg2/qhJrLmViEWxpFGcVjzbnas0xtmihZWvRl80tEo/8FD/c2VGWOrJBUcnQFQMM
         SztFAlmsBzZ8Pm/xEGSuIoLJ1J7nFobKoe8UsydHUjguL724veSzsXGkNOj0PVFhcglS
         /mAVPg5bi9bQLbn3UoBsVdriE7iLGj7kpmxYuwbXarkQgdteDKus2LKobhmaW2pGlzr5
         SZNb1QrDqCzlaJaqrZmq72wEgEGn6iI7yJtAw78KvSMT9V9/jdc/aPukvOyw1ju06FAd
         H/sldNkPFwmKP1LNCgf4h3soc2tqkCuMu2XCrCxfPt9stqT/lUw1Xxxv4BmR5J2EEgrw
         KGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgnLLpxPUJOWx9uPl+niX1m7F6/I39fyKRp0Xn8hDh88aa8UMChVQ2KafcAZSi9rIevt0F2kb1oCD7Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTJ7tkCejDalDZiWJo8mUm2m5vV41+1KIvNyqkirOGHRemq5Z
	tNcKfumY8ebCrJJZptCvId4wz2yD+23rHfYfvpGfbO+eUw+KDsrGUIH6ocuQDDXv0G8=
X-Gm-Gg: AZuq6aJite3QOFLfz81KLTbKOfFgDcrg3v3fzBLXKIkLjb/447PZ09O8PGASuDAbM0X
	P1RTm7AfDcg0M4pTH8KAb/phrVd/VOOancS9TZrN34CV5OzrCUNXI6o4BG38V3BnKlUJkEbgFeM
	QgZ0EmOirDNARD6zGCWFMC+shc3vPJsc2fQZSjgERIL2YHhToCkCSdUVCSuPn/1QGATthZXUev6
	4u1jiaBSuezWmnpkk1N5+WwPWbk3+UrQrvadpjRU8uLKWzUkRrX2VG4EF/2jXjW1jGSNwoJUdXR
	bqCi43HVj9DI2hGzJjVwT4O4r19fUAe9RricCLL8l6HRJ64gpBECEU7MjnT6wYOG4elQZMlIcVo
	0M7Kv6J2FZ6c9xcHNeafW+UCgq5rUtZfOXz3oPGG1CZl+D7ijLwvkmkGDKAZR/h1+RnYM1ZWBXw
	ByFlQGfopUryzeEo0eo1/C3TvRPQuV+jLQT89ik/zi9LFQTBJhZdnXlZczgghiqS7ZMt/kFbU=
X-Received: by 2002:a05:622a:38a:b0:502:f07e:8565 with SMTP id d75a77b69052e-5032fa02f2amr4531251cf.41.1769486994326;
        Mon, 26 Jan 2026 20:09:54 -0800 (PST)
Received: from [192.168.201.17] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f9cd9esm94354071cf.33.2026.01.26.20.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 20:09:53 -0800 (PST)
Message-ID: <8a6842a5-864d-4bde-9a9b-1af9368b1a5f@kernel.dk>
Date: Mon, 26 Jan 2026 21:09:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.0-20260127
To: Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, heinzm@redhat.com,
 jiashengjiangcool@gmail.com, jinpu.wang@ionos.com, linan122@huawei.com
References: <20260126172008.343807-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260126172008.343807-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/26 10:20 AM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your for-7.0/block
> branch.
> 
> This pull request contains:
> 
> Bug Fixes:
> - Fix raid5_run() to return error when log_init() fails (Yu Kuai)
> - Fix IO hang with degraded array with llbitmap (Yu Kuai)
> - Fix percpu_ref not resurrected on suspend timeout in llbitmap (Yu Kuai)
> - Fix GPF in write_page caused by resize race (Jack Wang)
> - Fix NULL pointer dereference in process_metadata_update (Jiasheng Jiang)
> - Fix hang when stopping arrays with metadata through dm-raid
>   (Heinz Mauelshagen)
> - Fix any_working flag handling in raid10_sync_request (Li Nan)
> 
> Cleanups & Refactoring:
> - Refactor sync/recovery code path, improve error handling for badblocks,
>   and remove unused recovery_disabled field (Li Nan)
> - Consolidate mddev boolean fields into mddev_flags (Yu Kuai)
> 
> Improvements:
> - Use mempool to allocate stripe_request_ctx and make sure max_sectors is
>   not less than io_opt in raid5 (Yu Kuai)

Pulled, thanks.

-- 
Jens Axboe

