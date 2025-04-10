Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2701E7C19
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298989; cv=none; b=kTlieGUSsdzEpyPKHM67ihfEGnEvInRTOGMSR4Zk2r9y25/ucqzkZhb944ZHXHjtAQVSGYNkze6EemqSeatPfUKK5NUEQdYAi+g7o2+Wt6bJKXtJ7d2/jNlRMLkrLWeveW1BoX1hbjEXedD0u8fr4gixHH8CbNDhg6pkuoD8QXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298989; c=relaxed/simple;
	bh=QFOQiBO8CwYyCHcvNeyoSi/M/BZt0+uPhj9eHI8vUgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8No83eh/83rQj2Ix0aU5q7W4Gesa6JLpy8wcMgMyczjW5axIyVTHULaoQTqXMtw+gVOwXmORJ/1xiMIB4z4RmcZDy4ujDyCHcZQ/q4tlxQRzz9KKSOegYWfpsefPglMzU25Qkd+sQHfknwIhGDQ14R4NiOSSjm1jX1EG7UB+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F2kzIPwB; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F2kzIPwB"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85517db52a2so17809239f.3
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744298985; x=1744903785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6j20ZC1moE0WGHDxvSjsYEeGfnUUYsPAAQJslP73hnY=;
        b=F2kzIPwBe9YDZk9tVFkVyPKTJgBxfQGrPtyNtSSEuoCU/Nkk3l7aUVkZRUl74V+a9p
         VGk92+B3AGWYfNobm7eitSRCEYURAZ0xJKjJXvxf9TJHiPGTDv6+wICoDI2iMa6hh4OS
         jN/j8+iQdPXJnCNxy25F8SlqeI6qmo3gXBmOR4ytiQW1hXZdWSrLil2FobAFAjm6dF0m
         tNUAmlyjqAFi3HNH0MkbOrYnqTyIUqap3V/JxJDja8U8JadgbLQdiYyRq+b31tVD7NXN
         c9jaLGlazKJ4NLfB8uZ66jIYCkbEr48pX971zHxhQA0tJdLi+lT1QRKXJwrTyagOzGR2
         WK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744298985; x=1744903785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j20ZC1moE0WGHDxvSjsYEeGfnUUYsPAAQJslP73hnY=;
        b=bcUb/WrIwTuEBTCnmIbQkdx1zCKKHAc/39wuc7w8Sl8Vyd0D37CKv4s0D0VjamWLWt
         xw6sxKZSDr8mXpoSRIkhiu9+fI6hVlcpcjMUWDCMI6D6bOnyTZD6nBM2oKO8PRkVHdSo
         2xr2TfOFB//+U0ccxBkpbv309vfm65GLhIMsEsrAlJa5Aue/BUaGjJgkXHbWz9jbUCj/
         j5ZfH1+QFWNmXIMbnyyldXJoS3BuxvZSrXskGaoOta/yBPi03B63kzyV2bDpk7x9buEU
         I/rg5a2fDPvm05V7hLrua5GNZ71iNwFfu/EnXz8KZS6JvYAM9w8lIdMYnJd97avNsP/b
         vQtw==
X-Gm-Message-State: AOJu0YyZdRylKszXbfGgmM2EWfX3bAI6sfT5O+bR0J1wDviRBi4eP9ft
	Bk3bQI68yTNl+Rr23nFm+peqT+gPraee2FksxQek3xtIFqmyoFNkQm+fyD1eRlk=
X-Gm-Gg: ASbGncsd4/xuY9Qh2pfPmDsv1YdkRlJu4XnJr2pPm46di0LG2XeBZGpNA8dtpcl1n5Y
	ygIg8s83HPKGJ5W0UtEq5v4XI7J501H2Gb2LBLDS6SoeXSrxEXlZ9ZjY6Egnyzl+wq/MNyJUSiy
	qBWrkTN2WRFrkpybZCwpSV9KXxX94guY5380g259pVJoVqLMNH2sQispN1eB3wREVHrGcdfJtu7
	AaqgcEF5HHWS6axU+65v4XJjym9nifeMGvX92OlGvKBuXjOEWWZZzXfu5UXTLoHVsE7UolU82Pu
	WqUibxJ+OCEYWV2tjeuoYLoXVNfZ03CQNuj6
X-Google-Smtp-Source: AGHT+IHnZ8Pp+hFpdn5IIg5PuaMTmrdjSIv5C6fTzZV5leQmTGeLKqtAIE5/gAeY0VFHa0wzpgfTaQ==
X-Received: by 2002:a05:6602:4894:b0:85d:b7a3:b850 with SMTP id ca18e2360f4ac-8616ed0e13emr374828639f.5.1744298984710;
        Thu, 10 Apr 2025 08:29:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861654295d5sm62197939f.19.2025.04.10.08.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:29:44 -0700 (PDT)
Message-ID: <e613a857-fba8-4e46-8879-d791d37095b0@kernel.dk>
Date: Thu, 10 Apr 2025 09:29:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <Z_fdSjFqscMuzxYq@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z_fdSjFqscMuzxYq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 9:01 AM, Christoph Hellwig wrote:
> The following changes since commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040:
> 
>   selftests: ublk: fix test_stripe_04 (2025-04-03 20:13:38 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10
> 
> for you to fetch changes up to 70289ae5cac4d3a39575405aaf63330486cea030:
> 
>   nvmet-fc: put ref when assoc->del_work is already scheduled (2025-04-09 13:03:56 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.15
> 
>  - nvmet fc/fcloop refcounting fixes (Daniel Wagner)
>  - fix missed namespace/ANA scans (Hannes Reinecke)
>  - fix a use after free in the new TCP netns support (Kuniyuki Iwashima)
>  - fix a NULL instead of false review in multipath (Uday Shankar)

Pulled, thanks - since this is late, it'll make the pull next week for
-rc3.

-- 
Jens Axboe

