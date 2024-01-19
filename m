Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999657898
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699329; cv=none; b=Zi/4w7l7w1QEGfk3MipEsHVeP+Oh86V692W5hl8Md4+25YDylWVzaaCXoI0bAhannlL/UTn/hinSeH5prnKF1kp70k4n5Dm5S2SwqrumcBYmmDU1bryvIYpw2BQWWq/OsYIa0yeC/9UjpbwxlEHtrHgeHpuMRASU8oAbcTxYhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699329; c=relaxed/simple;
	bh=sPGlgEPqyfWmZ8BYf2d0lG1R1fXgaJyVnL6kDWoOcPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJt21XPv6Pk02FHQdf87IpapmFMROo3B+iWZ0HfL+08BtWwAaHSLE3TqZhr6BboSz8vtYzDw08AfZPm7FInxN9mnXrabQIPkPS1nItPr+NfcaEpQGZU0kQJzUWC+U94pm9Vi7Bti828XYaHiiiwkzyUbn9YGaWqwlHteenXNblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L0/tgKDl; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L0/tgKDl"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso13606239f.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705699326; x=1706304126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMqalDxMtWXRWw8mRuYXoI3Qq2FQfasx9rH0LZ2RkwY=;
        b=L0/tgKDlF1vioWBaZtBljCQRPyzrNW2kVWpwt/cW7jgoVZI/1UzAPr2WUI5bnJXnqc
         4cCwhy5PvNWju6lTK0vVU9LqaVdcaetYCgOjIQOJzPCJ3vIhGU3Gn+fVKDkoCDh/vrs9
         05abD9UzSDXtD5WaS5ZHH/TcNw3TpGaRxvI/UOGPSp8YQ5LmAzdBKcsPBhkgpB5qSRVH
         NAN9EYirmLqRxRTxu7WtVDADUsaM5CSzQ5UVnMct5G4LSVqu87u1kQZnxVxlVc1+bq8L
         2VhS7md+0K8KWjoZhm7IQDtyPPRM7loVDPaTlZwFgSctQ80JD2uXpEoQoyg3+cweyAZe
         WfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699326; x=1706304126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMqalDxMtWXRWw8mRuYXoI3Qq2FQfasx9rH0LZ2RkwY=;
        b=MJtP28Mvyh8sHETCksrGhZcoaIWz3IgYp22C/eH99c0XigfjCJntseQVgctwuLHWkm
         lWucES5TRgOXApXOk0EITe+a+i/mZnrI7uWIiYwxZQ+Bg2SwlxQzXo9jl3wO/Si5xseQ
         uzxJU0sPwVRjNMjJ1u+LWmWo1RSQmOI6jViJTcnufaQqhOcsojZbOciFQ7/RmdGMOhs1
         MM9p4L72+H5y9013RZNU/LlruXtcMQ2wP/dGXAkC07nCMXxkI8ojxad8zN0BKP1N3inY
         Op/ORZkQFcYQNknMr8nhg/UHueumy13qD4QDu7g/LuVv0PN0mJaPnJ4by8Lo1hBbdPP3
         tn+g==
X-Gm-Message-State: AOJu0Yz/UEoBvfJU8X4+YnYVa9LqEDv8tJ729suUx4VFSHEn/kr+Alu0
	OimCz+Wr+JpHi29LMMVSiHr9P5SAeir+VQ2u/8JK7YhwdBrldfs/SjGAAFQX48qE8s56bY06/B9
	VPiA=
X-Google-Smtp-Source: AGHT+IETOhplWLP41h6xBUC+m/7v+gFVgoTG0pk5jIAa7NUtVmlGHwni76xjxsx+S3umlrFezQ54QQ==
X-Received: by 2002:a05:6e02:1ca2:b0:35e:6ae2:a4b7 with SMTP id x2-20020a056e021ca200b0035e6ae2a4b7mr941831ill.2.1705699325824;
        Fri, 19 Jan 2024 13:22:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t11-20020a92c0cb000000b003606dc5804asm5634663ilf.65.2024.01.19.13.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:22:05 -0800 (PST)
Message-ID: <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
Date: Fri, 19 Jan 2024 14:22:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME with
 BCACHEFS
Content-Language: en-US
To: Mia Kanashi <chad@redpilled.dev>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <54fcc150f287216593b19271f443bf13@redpilled.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 5:25 AM, Mia Kanashi wrote:
> This issue was originally reported here: https://github.com/koverstreet/bcachefs/issues/628
> 
> Transferring large amounts of files to the bcachefs from the btrfs
> causes I/O timeouts and freezes the whole system. This doesn't seem to
> be related to the btrfs, but rather to the heavy I/O on the drive, as
> it happens without btrfs being mounted. Transferring the files to the
> HDD, and then from it to the bcachefs on the NVME sometimes doesn't
> make the problem occur. The problem only happens on the bcachefs, not
> on btrfs or ext4. It doesn't happen on the HDD, I can't test with
> other NVME drives sadly. The behaviour when it is frozen is like this:
> all drive accesses can't process, when not cached in ram, so every app
> that is loaded in the ram, continues to function, but at the moment it
> tries to access the drive it freezes, until the drive is reset and
> those abort status messages appear in the dmesg, after that system is
> unfrozen for a moment, if you keep copying the files then the problem
> reoccurs once again.
> 
> This drive is known to have problems with the power management in the
> past:
> https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
> But those problems where since fixed with kernel workarounds /
> firmware updates. This issue is may be related, perhaps bcachefs does
> something different from the other filesystems, and workarounds don't
> apply, which causes the bug to occur only on it. It may be a problem
> in the nvme subsystem, or just some edge case in the bcachefs too, who
> knows. I tried to disable ASPM and setting latency to 0 like was
> suggested, it didn't fix the problem, so I don't know. If this is
> indeed related to that specific drive it would be hard to reproduce.

From a quick look, looks like a broken drive/firmware. It is suspicious
that all failed IO is 256 blocks. You could try and limit the transfer
size and see if that helps:

# echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb

Or maybe the transfer size is just a red herring, who knows. The error
code seems wonky:

> [  185.384762] nvme0n1: I/O Cmd(0x2) @ LBA 105272408, 256 blocks, I/O Error (sct 0x3 / sc 0x71)

-- 
Jens Axboe

