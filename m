Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09722264A7
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224618; cv=none; b=esCHIKamUMpRpWLiL1x4N9nX50iRIzW/Ol5RFmj3rtf+GDkZuZRP5eLii17NQKXonp63tEn+Y0qL9LJDdZb6c6Te2TBpDSpXC8UABvWSVWhYf8KnZ1ea4TZ8d4cgs7Hhb5fJzECsvyJ80uuV4pwTWwNQQAO8iAAH8Dd+hclsqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224618; c=relaxed/simple;
	bh=vOJqPmQkRkbOLf0gmDwYFkcgFT0zo4AtNOFmV8e0+Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwOY+ytgP5ozffDMQ0TFPNo78326ba3z24G5IpEQ4uuUKFbNGKUIlelqOkxWLEkOyNX+5ER7TW5Cp9kHX0e6T2HjWvkNZXQ9w8B9m/YisVkrxfWQUkeEr4GKqVMl1f4OCOcHjpwdDhTgy2QNygsGBtgPSon4V/pqqm5PtsneQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=z2zEBVaY; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="z2zEBVaY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so8591184a34.2
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777224614; x=1777829414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxacZ9XFE3eGRFLBp6QTAhdBcotyZaHUpMQ6viY8m9M=;
        b=z2zEBVaYNvjDQYDZd462zcw1vUsx+HFo1QbmikuUNrsUC4m8hBx1LPtbHQAkQZoI6H
         /alJm/RUnuMHzEikcKZYwlPSgcR0Jufdga392RnLNLF+bxx2MdoLFpyusTTVZyfzquJE
         I1hYRn+S4+p6yFvaWFQnbN5NdFxQPgyJUArm9vTqeM3JyI5aS/mvJLgzHjCUyLdg+SmT
         TyEHQCBZe6HjnYoJxJr41JpjgkbMplgf/mC1AnKDA9Rd1x0K1RXCyaYKXYPix4C35PtC
         mCxiCXFiUSisijJRW7EQw21O47SX8ErwCmvtd8CpktHxcwKcCojj7f+CeoBelknfU+JD
         ZQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777224614; x=1777829414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxacZ9XFE3eGRFLBp6QTAhdBcotyZaHUpMQ6viY8m9M=;
        b=SmvkUt1/i/S55zKmEjFl/EdmkQ5ReN4MxlawYTdgisn10jpJwGzwQv9bsjAhavjTqH
         uTEV0hsaSaUrL2y1c/S5SvmY3qO5biKl8SHqQmRmRNpTyv1AyNl5cIHOaeJoDrhjXDaR
         BDVNEYQI1qGHZZrAmqZhhv1gtZlyJ4U5sJQlB7WYPKJl71q/9Hgqe4vZzcHZy+RsxOv3
         lat5Fme1scQIbGm5M2fgYwwoX4LvxbJCF14w3IdeU0HFeOsulFT10b7EsqcRBQtVo2nZ
         gQYVyipygajbVJ0x8W5yV7giGSW10XAoAGvBtF7/Uw1ZoD5Vmzwe1ixs/FQYKzKTmLLG
         BTjQ==
X-Gm-Message-State: AOJu0Yw99aDOaChx3RvNotZC78nV6KtHQlKPUCS6AgI4TFijtS2X3lkq
	2d7z9jN4OYF1Fs8rtieDc31OJePrHbBXAK5EOKudqhXgotxZQLSm9sFcISGUm18gJuo=
X-Gm-Gg: AeBDiesJVjwW75eQTcF8qs7brcQdMet2kB1JqlpMMoloevyhV724ic8XP/THx7o1WtV
	YMOpADOgcM5cmkGHBZSZyyWrziVSbEvi0dkrHkncT6nKb6fK2Eaoza5e6J08jgL3OFaJDVTYK9v
	8qvGG3fKcewijb3MLFAwyUy7S2HSEj/V7cWQ5AhDMHOa8LUWXbsT6SMBgKEhq7ArTbtTckCFZMf
	Y9qvSYYODNibRc39Zpy2l5XXoQBLFBt3RsjE9BUCBD1LOH6yMshzv/+Rjc56+9hrxH9Sm5hLT5J
	JThmdNL2jNMN1PaAEyDXiaEGvuMmohxK1h+FADjNPAnGzj4M8QK1sHZzbntwqCYam07DPvI01TJ
	IpNws3p4uitNkUZr+uMs73byKQiTnsccuQ1fpILn2VkofnZv0FVQljU1/qPOBsUjXPilT6u/asm
	n/zVWZK3XQDbs8YdATW+RdhMt/lZliDtbCljH2M9905HBpq+hT+tKgqeEctkvc97hb1yIoWfB2K
	1nl5boSVaeXepz3zdmL
X-Received: by 2002:a05:6830:411a:b0:7d7:eab6:fb23 with SMTP id 46e09a7af769-7dc951fc6admr24522268a34.22.1777224614407;
        Sun, 26 Apr 2026 10:30:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc953e39asm18097128a34.15.2026.04.26.10.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 10:30:13 -0700 (PDT)
Message-ID: <b18b61b7-36d6-441b-a666-e38a5e57b37f@kernel.dk>
Date: Sun, 26 Apr 2026 11:30:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: fix infinite loop in badblocks_clear() and
 badblocks_check()
To: Ramesh Adhikari <adhikari.resume@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-block@vger.kernel.org, security@kernel.org
References: <20260426145527.589804-1-adhikari.resume@gmail.com>
 <20260426172641.629158-1-adhikari.resume@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260426172641.629158-1-adhikari.resume@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/26 11:26 AM, Ramesh Adhikari wrote:
> An infinite loop can occur in both _badblocks_clear() and _badblocks_check()
> when BB_OFFSET() equals the start position, resulting in len = 0. This causes
> the update_sectors loop to spin forever without making progress:
> 
>     s += 0;         // no advancement
>     sectors -= 0;   // stays positive
>     goto re_clear;  // infinite loop
> 
> The bug exists in three code paths:
> 1. _badblocks_clear() at line 1100 (start before all badblocks)
> 2. _badblocks_clear() at line 1153 (behind overlap check)
> 3. _badblocks_check() at line 1240 (behind overlap check)

1) please calm down with the repostings
2) sit back, actually take your time, and find all the spots. this
drive-by-development is not useful.

-- 
Jens Axboe

