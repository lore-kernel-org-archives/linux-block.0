Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA61E892
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880756; cv=none; b=CEuKOTNtoT5+Uy2RZ6ia0rgaOOLkv8IHidRW6scemANkJ8Y07MTpwB9Qc4ovHushCDvtFV74p14BLboWZ35CV95MX/VVxF/EexLA7P3z3EgdM0nsRWNkYIVKDjpw74EvHfAVuMxZWUDvCf8ckl4K2d0CC9+5/WjnIGQJZcIM1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880756; c=relaxed/simple;
	bh=7Eecab9W9O8J2c0mz3Jjl0PiWNnIAHMdaQcGLACoUWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Req77VD6IJUWofXC8LHIpsdb1WKEscelPLgsi0YGdW7y/rTtR0hbWc9paXYyScdEL5M6omIeE8WOmPKBM7xdUzLgO0ZxcRKdwo+c6FOOb10MtLJpNURMgd+vxc8YGkNYNAxRS4OTC2ZysTdZXK6nSUDlrAE7ehyLQJqen1xfiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=muXarhqC; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="muXarhqC"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa6be8457so33693739f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727880752; x=1728485552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RE3jwLRIcca02DnRrcz1K5ebgHznFKMdpmHOaNwDBuQ=;
        b=muXarhqCavX7PZEbmBI3vs+V5X/AVVG7JxqG02h2HslyhOUIfRtjdPMzJb7WKpoaBI
         cAU0E5FDdTooPJL9DSVwyzZg5jd7MyJPyJ1Q17aw/GcQoyoP3VRdb0a0vISWy9UTVG7V
         /RobB4y9HihRm1gwhu0JYl+d3FW+QIlFdofZ3SQPcTawFjLu9+pQWp5LR18qOSluTQyP
         dBkSgjoMxgjGv8Ceb3+aiPsVEcW16y8Qoud63xWwnoslcrRIFoOk3iZbCU6BuO8rdr/w
         PNY59Tspd63+gqIoRU2KFtQ/5C1d8hDruIHTPT6heyiZNjhhcvzfzzk9gkbkN8x1hL3k
         BFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880752; x=1728485552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE3jwLRIcca02DnRrcz1K5ebgHznFKMdpmHOaNwDBuQ=;
        b=gzujgL9j6/0bQt/AQOeCN0fZjsxXUrHyyLooh9OcfFpNipCGbPcrVfCSFrE66NPfmP
         X03UYQFRUkWoHNA05ofcwgxenRdl2MIjlLDBfeT2YCl5qii6CYLXFcdcaNgKZ/GR9cPZ
         RGt5Bl78h1KWN9VuhRU3B83eRtcJ8DtWEFTtgibk5bDcrq1+YmrC+T0eyqsh42pbBPUT
         BJHivMTdTYMPk6daWOnopa5+dcfj3yvHVdAO62+DtPQowtF+MG12xYtsio5k/pbFCF6k
         1Peas6pw5bM0SozuP/L3yL2KjwAtxArqlIqvpQuhy0yd3h8uBoQii6awWGxba0chhxYO
         Sw2w==
X-Gm-Message-State: AOJu0YwHcH2gco7O/+LxlDJK2rDmvcsUcYfnzQIX5ATng9SGFXLuhKeW
	RRtLtjQi5U8gURi9NKl+4EpC4mnt/bkVslcDBCPCQ0JHUBiDT+YnxZsE09xM5LSAK3gIKq5UUus
	HZaY=
X-Google-Smtp-Source: AGHT+IFxDrN1Jh9fL8m84ZZezCHROf22HJJ0i4yAlQJwKsDHcgLHrPVrxXpUs+W4KsPCS/Gzvt++tA==
X-Received: by 2002:a5e:d709:0:b0:82c:da1e:4ae7 with SMTP id ca18e2360f4ac-834c839aa54mr506574639f.2.1727880751887;
        Wed, 02 Oct 2024 07:52:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936cd3c6sm332234039f.13.2024.10.02.07.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:52:30 -0700 (PDT)
Message-ID: <b8fc402d-11d3-400f-ac35-f2b4f8538abf@kernel.dk>
Date: Wed, 2 Oct 2024 08:52:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Applying "none" for io-scheduler causes coredump
To: Fred Richards <fredr@geexology.org>
Cc: linux-block@vger.kernel.org
References: <CANPzkX=nUnDGZjVrJmmJZgeeqAdDacbZgvUxptLuKTpVJ53oHg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANPzkX=nUnDGZjVrJmmJZgeeqAdDacbZgvUxptLuKTpVJ53oHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/2/24 8:45 AM, Fred Richards wrote:
> Hello,
>  Mainline kernel 6.11.1 on my archlinux machine with several disks, if I apply "none" as the io-scheduler, it core dumps.
> 
> Startup script rc.local has:
> 
> echo none  | sudo tee /sys/block/nvme{0n1,1n1}/queue/scheduler
> 
> Causes this in the journal log -
> 
> Oct 01 14:39:06 tor systemd-coredump[987]: [🡕] Process 980 (tee) of user 0 dumped core.
>                                            
>                                            Stack trace of thread 980:
>                                            #0  0x000079b6a0ca43f4 n/a (libc.so.6 + 0x963f4)
>                                            #1  0x000079b6a0c4b120 raise (libc.so.6 + 0x3d120)
>                                            #2  0x000079b6a0c324c3 abort (libc.so.6 + 0x244c3)
>                                            #3  0x000079b6a0c323df n/a (libc.so.6 + 0x243df)
>                                            #4  0x000079b6a0c43177 __assert_fail (libc.so.6 + 0x35177)
>                                            #5  0x0000617a0fb4e3ec n/a (tee + 0x63ec)
>                                            #6  0x0000617a0fb4a34f n/a (tee + 0x234f)
>                                            #7  0x000079b6a0c33e08 n/a (libc.so.6 + 0x25e08)
>                                            #8  0x000079b6a0c33ecc __libc_start_main (libc.so.6 + 0x25ecc)
>                                            #9  0x0000617a0fb4a665 n/a (tee + 0x2665)
>                                            ELF object binary architecture: AMD x86-64

Should be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block?id=e3accac1a976e65491a9b9fba82ce8ddbd3d2389

which is heading to 6.11-stable.

-- 
Jens Axboe

