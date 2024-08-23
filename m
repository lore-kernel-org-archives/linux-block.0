Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E971865F5
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419388; cv=none; b=lwxyylv2cWQQyyApz45rhKRbIK7tQCBARSBpuTEubC/0bLRRUvk1jkO0bl2uDkzLz3VBounsIRQF8IIHI4F1x0Mk7y93IfOIrZ3jDfHJZ8rtnRyntlrHGKXeAW6bvqEY/alUldSA14nm3Fd4nz15x/+cjYweVwJyeD05DueWFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419388; c=relaxed/simple;
	bh=XM6HmEJxj6EyPKid3Kb3NOSJyXdKUdl0YZ/v//OzdLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+zuoCGhxJZH6NTt+fUgVKg9gkm9omUjjtEXqE/7yn14Rf86iCR/ncZRG1bvzxeTr2kJGG02y6rXRhapO6ztTCxe40FOKsiD5q5WIwKDxFILfYtRT8VJvNgHS98IEoxJyF0uebjJ7LpdmpfjYVoaodKZZ5CvkkulzZm5TDKV6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Mxc/exIp; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Mxc/exIp"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f9339e52cso77047139f.0
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724419384; x=1725024184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sQ4rHVCuaeEBgkCad1ajOipG0bmLn0/+w11Ce8vn/Q=;
        b=Mxc/exIpkdAhCGojxKI7DYtBYKi9pR24FooLfcCBqfiwmCCE+qhOZaPiKWpH5OSAlx
         qzlwg457zrosKpxwegmcEkPBFkXt4mmB2AvGd1HxUPn+lQazCXc5eLcYDO3jAZ48fMCJ
         qyXlys9AUKkoLhWc1KW9MvgqaqcPeJjuyKVGlyB6Sqojy4cV5JKk1OAex/ZK/9ipDRLc
         BnVaQgYZkL4C1yI3PsaHYEbFPn5pKBLNJGl32WsmXP61hBD76Uj/LTSyiituDgBvx6CI
         t9sGpZLHkg+rgzwj9Gcc9tQP7lEPocnBegM4Nxog3zhXLNBi5bP7Kk/oQvgfhmkB/JUI
         tPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419384; x=1725024184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sQ4rHVCuaeEBgkCad1ajOipG0bmLn0/+w11Ce8vn/Q=;
        b=MkVW5ACSpmX+/PJBuzfDA+NdV6gellGxJbO+l9MFJ6Pt/IwySVSGIqcibVZ/srOYic
         qdiep6ryO9mpkP7I/JZKjkhO4Ai/rBNuR/l9MBYy1I9f5f2U2ac2JHrHuaBVclh5DYJZ
         +oGTH4wbN+9PMbjpgQ6r28M6Gw3JQU4jxKsoXtrHxwI2AFJmBomVV7wSPrfkVT8gRZhR
         uU4JsCHbzDQ35Xq4KZ1MJ9B96K9PodGSGeuYJTmD+nx/drx5RDK+qBxbnC5EXKxnl5QL
         5UQwp7JKwZjiNkM43MYHOblCc27WGAh04d7i6VSN2hBV/b8kZpkkpL/uQgsRfwRnTcYa
         RyaA==
X-Forwarded-Encrypted: i=1; AJvYcCUltGvGeTK/YUv5iqBK916BXuy3Bcd7iij2xnWuhXPNotwkKL+h/JVBFaOV6FNqDUUdDNema5xk7xpyyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRyJdX2lqCf6OK+hWBeP1milzRH+2xx+3SWEuK1LgIlh6dnsC
	N9iVT3fdVSmaRXZVc1PcKk4ixOQbpT51LyrYl6Po90jvlVUaN8eQL6wyAXogTNU=
X-Google-Smtp-Source: AGHT+IF7uzcrWaVhZ2hG2W38v2yp0g4ETQmvc/+nod5ukjF1aqg9oGSWxD6rxP/E2XtHC4UaaZMotw==
X-Received: by 2002:a05:6602:14cd:b0:7fa:56f0:ad87 with SMTP id ca18e2360f4ac-8278732f754mr287101339f.10.1724419383815;
        Fri, 23 Aug 2024 06:23:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8253d5cad72sm112166339f.30.2024.08.23.06.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 06:23:03 -0700 (PDT)
Message-ID: <1da3ce76-c55c-405a-a878-6633832bf541@kernel.dk>
Date: Fri, 23 Aug 2024 07:23:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drivers:block:Cancel debugfs_create_dir() check
To: Yang Ruibin <11162571@vivo.com>, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240823112246.3905118-1-11162571@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240823112246.3905118-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/24 5:22 AM, Yang Ruibin wrote:
> No need to check debugfs_create_dir() return value.
> It's safe to pass in errors that debugfs_create_dir() gives you.

Subject line is still wrong, as has been mentioned before for your
posting. If in doubt, just run git log on a file and see what the
customary title prefix is for a given file.

-- 
Jens Axboe

