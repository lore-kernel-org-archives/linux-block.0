Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733F2E8B9C
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555320; cv=none; b=EW2YnqoJ4hVgKPx+VzVzoYIjNZ10bLYoU+M3d+2Fc0xIZHX9Gm91rtLUWbFbCFCTCSY7hebFoGt+1ybTq/cWcg1y1QRsNZicPISOzJ2Z7P2SF9spig3uTzDqDSO8p4gn2Lz958QGifzF/46vR71jnJpL1zM8rqbjzy/7r4tUJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555320; c=relaxed/simple;
	bh=qly9kqbEdOY/OsWO+YZOzMEXhlYjLJ59xALOuljk0/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y05nZASZsNWMounWjxMY46hJxupqh7cWofd15WKD25MsZ84q1QXMVLAEvTmwOHpgXkWAeB6kOj51Ym3E++Hp3rPR85dLmfjILs7cgsbD1u9PM6F4Kf7BYTFEVo5JHiACbc8pTX5KdOUOKnxxcc+KahJUCgzlJ7Dl0f1nEwnu95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WaRC0Iwu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WaRC0Iwu"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d601859f5so35953397b3.0
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758555315; x=1759160115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2bE/MKkrgBEbAv3+EiUnj2VATLc85Ddsqpr/9B5N4E=;
        b=WaRC0IwuqBVJgh4RPlM56IsANb0Hgzl0cqjS6eIRvM9/s7Cm8oNXIkscaJE2q3vjUZ
         gWlUw2hhSDlHQdFBWfcMu8Nnzkx/VG8g4IyE7yG9ZKsBghs2JPpG6cSydJcinu56qNtb
         FB6KpsI//kcxTRLlgPSDPPKMjajKdQpB9gtIjHisDD0kvFOjPWeTFVEbsi6yq68flnEJ
         2PZ/e1Gkw2oETahlmQBu/ElPbY8wzmzyaWaHgxTbnhNlIAiQASImzuR64CII88gMIE8u
         S0yGcVIsOyG/lLEjl1DJpQs+CdEl8gKutJp9K4UUujDvXIyhNnVJ75LOS4PNCkdjAIIw
         QxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555315; x=1759160115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2bE/MKkrgBEbAv3+EiUnj2VATLc85Ddsqpr/9B5N4E=;
        b=jwAvB/M5dLiYJoYrKdSJTTe9P27telzIHB4EkCTUSrivEutrMEl197nJxHs08+vXiT
         YPJHBPU1zfk3LKvwfydXJgkHOTx36GXaelS9yW/8UdP/wGcYPzzfh4TKUV1bzftWlWrT
         UlfSVHivjHsHS/VyQd5jpI/cZX0lz2kPuWkcZ58K6dqliKt72cX1Vmk7upqETfzDGaPu
         wWz5oPfNMplK3XQXx2hXSDLL8sNlYNtNiCcZa8pyJDeRT430ORZ3xmFsck2YvIMnKgbp
         J26/cA5XkVD+Cc6VwzznZssXGThPfDLQ2s8Aq9uv9i2VAsuhbSFz3gSVTzqhOHZQQ1CQ
         hj4g==
X-Forwarded-Encrypted: i=1; AJvYcCUlQoFjJVMzc76OS9J2CrCOziTxJv5CdTVSpi/RqfWRhrpBQnYaM/7DeHe8lPIYQKtaQES3KlE+RD58Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki98q60VeEp6CWWIQAEHl5mlCcLWzPtEJSCo7N3qiwNKrAT9G
	5ZmpdZLfZTrclzWQ/dc1jNdYy3miy5Pcscf95STZCvwMc5mZtAe0xdbfZnwfPCUJqk0=
X-Gm-Gg: ASbGncsgugviGGAvFAhVzaFJKyXD3rp0hcuTrggQLMQT/20DuSKuyU4mKSFFemYTMb7
	tGvEfz8L7XihxRbOdsciYs8xedUacOKP7i6c+D8dfRVShRD59px4sEVp2WMSppYNOAi1zTZn91t
	H4x4+tPzkQIzMYrjgAsEoNwEZo9MXxg88L2oU44JaIvmGYDrIeZAiqTVzedY+eQ6tY1swL/AjMT
	1s74XQn4DgTrgYXLXwxb6EVdy2Tjg8Wfj2dE8O+F8HVoDTDKENa6wIPE71V0eESxu+7AVEzdfUX
	k1lJ1rX2VwCsoWfHuD7grI+u52vQY1q4cvcNgx1ZWepmXW2ShfXO5Pb6jtcI6GGm4YivBNaaK4a
	eSZ2vb/tlv55KbCeUJ+VQ
X-Google-Smtp-Source: AGHT+IFjzky2r/fXchNxGCfIUbXvUrgFxIssF7cyQ2YC8pa4w01EIYuF6e3b3ClVjG38tm36GHFqoA==
X-Received: by 2002:a05:690c:48c9:b0:73e:376:9119 with SMTP id 00721157ae682-73e03769d7amr111755817b3.49.1758555315327;
        Mon, 22 Sep 2025 08:35:15 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718adb9csm34148077b3.58.2025.09.22.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:35:14 -0700 (PDT)
Message-ID: <3fe024f6-ebca-49fe-9443-8abc45eed13f@kernel.dk>
Date: Mon, 22 Sep 2025 09:35:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix EOD return for device with nr_sectors == 0
To: Sahil Chandna <chandna.linuxkernel@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <855243b5-1226-47d5-9ca8-c023209f5ee7@kernel.dk>
 <898a2fff-54a0-461b-84b9-07c08e6d1f9e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <898a2fff-54a0-461b-84b9-07c08e6d1f9e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/25 7:48 AM, Sahil Chandna wrote:
> 
> 
> On 9/22/25 5:28 PM, Jens Axboe wrote:
>> A recent commit skipped dumping the usual "attempt to access beyond end
>> of device" message if the device size is 0 sectors, as that's a common
>> pattern for devices that have been hot removed. But while it stopped
>> that message, it also prevented returning -EIO for that condition.
>> Reinstate the -EIO return, while retaining the quiet operation for
>> triggering EOD for a device with 0 sectors.
>>
>> Reported-by: syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com
>> Reported-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
>> Fixes: d0a2b527d8c3 ("block: tone down bio_check_eod")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 4201504158a1..a27185cd8ede 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -557,9 +557,11 @@ static inline int bio_check_eod(struct bio *bio)
>>       sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
>>       unsigned int nr_sectors = bio_sectors(bio);
>>   -    if (nr_sectors && maxsector &&
>> +    if (nr_sectors &&
>>           (nr_sectors > maxsector ||
>>            bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
>> +        if (!maxsector)
>> +            return -EIO;
>>           pr_info_ratelimited("%s: attempt to access beyond end of device\n"
>>                       "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
>>                       current->comm, bio->bi_bdev, bio->bi_opf,
>>
> Hi,
> I tested the patch and it *does not* reproduce the original syzkaller bug [1].
> Tested-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> 
> [1] https://syzkaller.appspot.com./bug?extid=4b12286339fe4c2700c1

Thanks for testing! And for reporting the issue in the first place.

-- 
Jens Axboe
