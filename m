Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A328EC1C
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297079; cv=none; b=tkf+X5cZQI28B1KWI6ATIjjmkHPK+xUoZ0t4Ig5oYGnR66sofhjjauOK2jvOq1VCF3V/hvTPMxfMWeci+kcScDCNlLUO0Ujrm7+kXo36TS6qTYqh1nUPzxzrHi/D2gTNLv4uAbysLEXm2Uq+2zS6urDYbrSO3kY5/ONl1h7vl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297079; c=relaxed/simple;
	bh=lbuI0MNBw9Awg9+tIphhpvGMwxZYpAzxVyJDZbeQoXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRGMlTrnEU1euEIGm4Iqv9TaU2vLI01w9bRGXjLqDXi49MONMEerQUTWqy7GJiS23Wf18frRjjHi8nM27WVvMsZbXjQ0awi+CGZtMMlX5WbswmPRmMplx5gzdfGed067CsK52I28wrGpsEqqI0Ccnr6IR4fZr+5hHhhUV2ve9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YgZtOR+l; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YgZtOR+l"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86d013c5e79so197833939f.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751297076; x=1751901876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPRvs6BnIIzqyFHxoXRAic5qy59WOr/RY4rg93qhMko=;
        b=YgZtOR+lzDrA0XeRuEuV+6gUmMd6oTRPydFPobFR7XFAvun1yx+JsW60dsamtlF0Us
         CkpwDU9ZGwaR1y567KMuM4hfxMb0BE4ycg+RC+HkAeAY5QgW0x6QgjnH/WjL/OhaiYPt
         7GS5+8ysXcH7IJFa8h/fQ2Nxqwbn90vnmOJ7idRY+KwmXc/yfycFYuv1VqDOfrSKRYOC
         rGsF29dskgMB6GspeaYq3DaH5L36crorhdbMeUEwkDSgB+n/B2QO0MnLEx8zL7hXetcs
         uIXcXqCD+dm9Sz5kGlqoM+WaV2gtFMHKfAvKSTViSBtZy2uuu2hLueGck6nAon+Hsimd
         Kftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297076; x=1751901876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPRvs6BnIIzqyFHxoXRAic5qy59WOr/RY4rg93qhMko=;
        b=YIOLQ8vo1BKbQB9RbD2wkOJKiqNtLAh46gnYgozwh/AeT91JJj5YZXd4cHYlxRQVLE
         sUVUR81qOZjNKWXrg8gX67Z5wUJw4HG+PYBWrWdI7bwC3JgCSr+gTfpIQuK4FbvzxAZk
         oy2qroK5uaMyw8bzI84oq3JlGedqObtz8Y+1rhC//W6fl9zg42km7eD7MAikmpx40BaP
         /6kqaSkHwEniHVJJPOw34+kOif5P/+JEpSkC3C2zi54dHTjbS3qRM3wJjM6QEG6Vb+jx
         DQgAH7sIuJLWbKCyYQcKM4L3I3hPGI5gS6GvsOGJ3Jf0QpYvEeQjA4BXaT1B8E0CiMkN
         ea4A==
X-Forwarded-Encrypted: i=1; AJvYcCXTuCpECbHySr68qxTgIvAT77MOvkKvE/iZ+qJhaoUbjzYGiZoPPL4MmIsmDoGotxznOcHorPOwXlLQhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMAYUhI7n1GXNIfUy47vJd51GlGS2vjEXQxEuVN7V1anH/DhT
	46mXh7DJnOTchSkMUFi2bqosVWR+s1BmB5ObvPaV8t/TG9ZeIjmR9Tun21zsL9/gAi4=
X-Gm-Gg: ASbGncuGy5cklD7hbphR9S3zPnCrV8LzvKq2OoF4ak77hS2Sz5boQScYClZKtFP5GrP
	6sAITgeuXMrY9r4QoAcda64Jc6lD9ojYErOTOGtUIuK7Wyt5744ACdH91CywFfenwLKoLZhepvL
	Z5VVHDH3AlGVTAUMWURE6nbzKbX6t+mfh9iD5sXkfyVkYElNvwAWN9PPJTbjXP1IbN2ofpi6X9h
	916aqgwMg6ylb0AspYbP96J22vyIoXH6aQiDuf+5jKLpdmldBbgywYidAHdeQYwQQzJriv4o1He
	PK9qLOvSOS78jDDdY6V2pAJi0sRD80Npqr0IwdTJFq0ulsb6ekZr4tjz5wCuRO//RUZs8Q==
X-Google-Smtp-Source: AGHT+IHd3tofctj6pJYpvoUcM5ehbdOu4b/Eo1F55IUk0N41h4uwH/j6fT8O4lxLh16JrhUtLfM4AQ==
X-Received: by 2002:a05:6602:1483:b0:876:7555:9cb4 with SMTP id ca18e2360f4ac-87688258c05mr1468322139f.1.1751297075914;
        Mon, 30 Jun 2025 08:24:35 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87687a18d95sm198418939f.16.2025.06.30.08.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 08:24:34 -0700 (PDT)
Message-ID: <eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk>
Date: Mon, 30 Jun 2025 09:24:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brd: fix sleeping function called from invalid context
 in brd_insert_page()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, yukuai3@huawei.com
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250630112828.421219-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250630112828.421219-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 5:28 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
> memory if necessary.
> 
> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
> it still should be held before xa_unlock(), prevent returned page to be
> freed by concurrent discard.

The rcu locking in there is a bit of a mess, imho. What _exactly_ is the
rcu read side locking protecting? Is it only needed around the lookup
and insert? We even hold it over the kmap and copy, which seems very
heavy handed.

-- 
Jens Axboe

