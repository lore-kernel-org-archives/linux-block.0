Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9451232452
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866941; cv=none; b=bqpw086g/XbtXEl3QINh9XZEc529RF0tXfud5F6Mv0V1NbrdLn6YqxxYXNaSDxS69OVhp7QsueNcqYPHFPJuWvumzHYl0HcccuMjRrqD4cVgrir2ET24HTSoRA3KuMUim0Y3mIV6srlpBT7Q+Qb1rxLS0QoxNceb3j2r1kGcvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866941; c=relaxed/simple;
	bh=xYkAundS7aywhrA8ujzvdAb/50xm381VeRt1rW0JMbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plljTbdh5IFQhSUGSM4Wkq6YBYdrlTdg+8UtK2S5RBFEOYJE1WnM7SyAL6GderHO9/5W2rGwc3PPYEKcFCXLEcMIugCfS5tlppF4D5xEyLTZNI7IQ24ffOFJy8P6f8E/Y0ErDs+wJ6UuLOWlrLpAUGz+fkdq8MGBXMDZfPN4muE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RXcmKW1P; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RXcmKW1P"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce464e52bdso15782445ab.1
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736866937; x=1737471737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6pc0vLVLOCl99oWfrGPrMAsQjTqC2jWiI5iyztHgH4=;
        b=RXcmKW1P8vAa8XFu2IjTchgMwrrExwzrW724Z/7OwjSm4zB3i9spLhNJ8bnVXG4Z7R
         gaDESVPaf7QJRfFC6pVOouY+VTQnZHjZm9SruYHc4JcQuq570L8Q4G/Qad4Qy5+CfcVm
         BG4LwmFY6CqFFhmPLC9HUr79Z+CtaX+yyGUvftqM+B4SdkHzuMVmMgVSOgnI5DAkUvIY
         ZMC7NR84dOa3VpuqBmWyenUb+N4s9O2HdN8pcx6rmZPF0rBQ3pY8JUcG3AMcFJjaeMFB
         B4j0Xw31+dUi0Twe1J7lmPrhn52fLEVBGOGt8bp/fTkWYXDY0uOXjNNUgkurYWRG32GL
         qSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866937; x=1737471737;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6pc0vLVLOCl99oWfrGPrMAsQjTqC2jWiI5iyztHgH4=;
        b=K9S9W0I/pA7uNco6en+8njmN0x1//l4igSJzwaWB8aHu5fnzzLdmtc0dLOnP+zQlLx
         bAR8PAlLvQYkBZaYKCF5axRFdpmAZDf3tWzSDahFDf1joSnBOFDjY/AlT+IBEZRweTCN
         c9xHkhf8cz4GRaFxr31IxygyGP/+GNSTy7D/GAB0r6tnDh/lXtZY/gHh96DsTRUV7avt
         dpunzU6OdJj6V9c+TFpv3a2Miwox4biV81cr4OoKbdpMlENaaNwUjJ7ABsPakhpBVD8v
         uGrB1oCk9yqEOmODzoo1pwsVzXIzrmGu2zhide7l48LrvuqFS8YSTKQwhMlNQZlfzr1/
         j9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXmQtzundCxF4rvjYDEd0bKg4JGhQILbDLb1y+xeWk/bFiTFHnCWZ9Dx2/GuiD1yB4CgNwbmJ8iUREnqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5m3/JGohvqC8ZdjI+UzWA/WeUYnHbMZ6zF9HzY3RKqdaXKSNY
	CYtFOPj2pTKhJLQOG0i48lU27YEgPVgSQcSfQ2dhrk1/zKlHND2lKqwff1Dmtgo=
X-Gm-Gg: ASbGncuWBR0Pn1iLArk5apq9AVcmfQWYrv6Gt6HnQed4aerzhfQkfYkARdArcU6kfR8
	xprN8WXXjuArRyeEKyrfqhHR6/88si5U/7tJQKLaC/lFyLJUrGPN/rrCycO+O7S9iYifyNi+Ux5
	jyMacbKtPKp5KA732VdmhRT69x3L2npaubxupa1Ud8xrw5a8KM/sZcwkb4xCXYo6GlJkkHbA7+a
	SafhhIE/CoxwnYZsUZXD2v7rrfVu2Y6v+CWhqvY06clEaOlq5vs
X-Google-Smtp-Source: AGHT+IGb57wDMTkPiZESOxUOeBWmJs6yV8Cs7lY/DlXIX0vxP6EzoDYWxfogTtZueVLZ8bKUcu+5Cw==
X-Received: by 2002:a05:6e02:12ce:b0:3a7:9347:5465 with SMTP id e9e14a558f8ab-3ce3a9a6200mr196772985ab.3.1736866936736;
        Tue, 14 Jan 2025 07:02:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce6c1fc60dsm17460395ab.7.2025.01.14.07.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 07:02:16 -0800 (PST)
Message-ID: <813564af-a67a-4feb-ab32-1ca3bb41edfb@kernel.dk>
Date: Tue, 14 Jan 2025 08:02:15 -0700
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
References: <d384b565-0be8-461d-ba8c-0185842c9d9c@kernel.dk>
 <tencent_7C8CA167C306EFD2EAC6590982EEC5AEE406@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <tencent_7C8CA167C306EFD2EAC6590982EEC5AEE406@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 7:58 AM, Edward Adam Davis wrote:
> diff --git a/block/genhd.c b/block/genhd.c
> index 9130e163e191..3a9c36ad6bbd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -890,6 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
>  
>  	rcu_read_lock();
>  	xa_for_each(&sgp->part_tbl, idx, part) {
> +		int partno = bdev_partno(part);
> +
> +		WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
>  		if (!bdev_nr_sectors(part))
>  			continue;
>  		seq_printf(seqf, "%4d  %7d %10llu %pg\n",

Surely you still want to continue for that condition?

-- 
Jens Axboe
