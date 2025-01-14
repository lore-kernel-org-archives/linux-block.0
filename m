Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F02155A34
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868318; cv=none; b=IZhPXVYa2v+jAdb5YK5/DYQaesNnPqX8asn44ouoKKK5XY1NMpOvOeDDtLd+Bms2mL1otXG2MVp0ib2NjysZsORxfVoSMvQgauMakojiCOocDUE4wG5Lt+ULLQ9VkJNB8O/AWc05PIA3GdQhHpNEXNlfxz86bCXDA3i49QHJjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868318; c=relaxed/simple;
	bh=bfYihCfAIigf4GfbI86CDwscUaj/dr6QORIh9fL1WHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGskHhW4AzhvXN8gCcGSKbHg1uh7ZXc2EYRvflNBzoZmB3LpuaRpDUDxRFhy2C3mlSq9pVydGwMyK5SHVsjBNDiNJlFXtpl1488/cxaPr/ggAfAb/dx8LLDSu6KbkLjnaEBKoPdBLGYL21Sp9HPEF7Yh4U7c88YAtVSB9qO/hcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DGN+KMOE; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DGN+KMOE"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cdd57060acso18490835ab.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736868314; x=1737473114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+1Lu+c4d+CZfkxxtpb+u7W/NPbLrNX6Z4fG+B04hbI=;
        b=DGN+KMOEpMJphLFL3Hj19J9zSa7DC3nUazi0Dx6qp6KUB58NprtnUPGRlyHR/9G7yb
         /T7KZO1kMdZ26UGLbIaw6QCW40ePUTImssP84MSBXE0nUW+U7ZTZalS37KpgE1KCxEv8
         zwM48keCglnJJQC3/evlZgqtSPDggU8twNJSQntQAqFMaKMNiAmR72pWPPgMgsGacPSF
         qZBYPViDW5YBUBPEBJJ6M33Y1ns03AahrntSev8JVqBTMdkE5BKcJeOps1/w/AIFQB0k
         K/2lTZ0yXUjJC6r1wCNEoKosdr5fQU+DdXnr1R/vXcF68+Tm19/U32MjN9P1+6kjePN2
         Ng8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868314; x=1737473114;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+1Lu+c4d+CZfkxxtpb+u7W/NPbLrNX6Z4fG+B04hbI=;
        b=LcjdO8ioRU71ISkRJpfE4j/g1q5Z9VLh6IrkMADH8v1FwnZruCbFyjRopU+BK96Hlb
         FEuVRsLV9UYxPv+QdAAIZ5N5aN29TEB+QjJQGxKhNRSMkFD5A+4GJeTQRIZ7pD0+z6n9
         We6Co03fWFZY6GYmu9HPAQd1miGTdDB10TTZZHNeQGL6QrAbDf2szi2LmHLOpNL36DiB
         lElmUxWKtjEQ1ru9upCueqWfa4aDLHOUDGn9CZ7Xovef3Sk9fPI5ppe4cZ1wwY5M3FxO
         ckqbMDSdVK3DcdtGEkNznGeWWw/SWNd5OGvpXgLT/P4zsUs9UU7lB+yWXJaTqGz9g66y
         9juQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzoAxqmYQGSEoB+q7q8PgyWq6R+/8vLczlHpUa25A1kL5MXnrUqqP8JE8pLF8aYXgOo9hAWqlmd5iiYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBryoEYLyga6DCdoYdEb6smSU8EuUQYQluSRk05WKDsrRvYTE
	8E8V8yRpCBR2YgiZ2jABvkUoYyoC3bU/9k1m6A7ayr+yh9U108vKpgrupB+coqk=
X-Gm-Gg: ASbGnctTDHhTrbu41x8p7qTlTEYhT8S//UIKp3HXXcIBpk7uzhQLMpTh+nPhl/tHI6w
	VqyhYkUWx1n/UnGSxcAo/R5RSadg2Tj78AhpIhA5RVJLzonmC90ZPKZ/qnMpUHrljXKr+M6LAfV
	czpLuWj/K8l8YyBHPzNwounsrtgF5n8QQric78GPrEI1MUPXb9qF9ox+mA9ULANZ96eehSuoRIz
	fPT/skajOGKicYprw0o1xTbiu7pqJHjNHJwzTq6oxYVOTWFcJFD
X-Google-Smtp-Source: AGHT+IF8LamTOlS2aHRZbet7Phl2C57F9X7NDOwRyxc5onvJqlq3yKESwAxYurSfcbjuvtoQHrJY2g==
X-Received: by 2002:a05:6e02:1687:b0:3a7:85ee:fa78 with SMTP id e9e14a558f8ab-3ce3a9c190dmr195163205ab.18.1736868314572;
        Tue, 14 Jan 2025 07:25:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4af56569sm34515995ab.63.2025.01.14.07.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 07:25:13 -0800 (PST)
Message-ID: <2df5c0d7-cf9e-49ce-a39a-4e3d50c6df0c@kernel.dk>
Date: Tue, 14 Jan 2025 08:25:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] block: no show partitions if partno corrupted
To: Edward Adam Davis <eadavis@qq.com>
Cc: hare@suse.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <813564af-a67a-4feb-ab32-1ca3bb41edfb@kernel.dk>
 <tencent_A26C4964E3A9444A17685771A6D2F367A305@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <tencent_A26C4964E3A9444A17685771A6D2F367A305@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 8:15 AM, Edward Adam Davis wrote:
> On Tue, 14 Jan 2025 08:02:15 -0700, Jens Axboe wrote:
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index 9130e163e191..3a9c36ad6bbd 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -890,6 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
>>>
>>>  	rcu_read_lock();
>>>  	xa_for_each(&sgp->part_tbl, idx, part) {
>>> +		int partno = bdev_partno(part);
>>> +
>>> +		WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
>>>  		if (!bdev_nr_sectors(part))
>>>  			continue;
>>>  		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
>>
>> Surely you still want to continue for that condition?
> No.

No?

> But like following, ok?
> diff --git a/block/genhd.c b/block/genhd.c
> index 9130e163e191..142b13620f0c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -890,7 +890,10 @@ static int show_partition(struct seq_file *seqf, void *v)
>  
>         rcu_read_lock();
>         xa_for_each(&sgp->part_tbl, idx, part) {
> -               if (!bdev_nr_sectors(part))
> +               int partno = bdev_partno(part);
> +
> +               WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
> +               if (!bdev_nr_sectors(part) || partno >= DISK_MAX_PARTS)
>                         continue;
>                 seq_printf(seqf, "%4d  %7d %10llu %pg\n",
>                            MAJOR(part->bd_dev), MINOR(part->bd_dev),

That's just silly...

	xa_for_each(&sgp->part_tbl, idx, part) {
		int partno = bdev_partno(part);

		if (!bdev_nr_sectors(part))
			continue;
		if (WARN_ON_ONCE(partno >= DISK_MAX_PARTS))
			continue;

		...
	}

-- 
Jens Axboe
