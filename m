Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C14F70
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764509612; cv=none; b=POfK1Drm1Azu5Ep+cWegV8OnaR77boaKgSSrWM1sIQZPMCrxgjrEMTh66I7kWlg8EM6oftfoJSOSsXj4zgPcDSKUKJmxg3X739ZFkHLh0aAFGcDBMwHKM87ijoQCEqtROE6BpUr6TSb6Lr82/g0KbLstTvvww9XmUiP6p1KZywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764509612; c=relaxed/simple;
	bh=Zkt4szfcjXQpdS0Kyi9aT8siaek87I1lRU8rr+TdT7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHqliqG9/f41jimJ8E2IfIe3MwIiLihPnBJYnslmY9a3/yRY8XJqm4OOyRNDIHyotIeCXzFD1XLCIUb4Ci7AwopaI2VqY65vJP3MOG7evHeZS76RkZAoW9v/LqxPUE+W1vy/GJm8whFKdpRwdEQKN+1WUzc9om+Fi2QRvD8Wyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rTjWR71X; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rTjWR71X"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-94903ea3766so122306339f.3
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764509609; x=1765114409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTU1/x7Dfi7RpaKWDbcpvMWRGnF9c2LffZ90taw7x9M=;
        b=rTjWR71XR2p8j1JgZ8rZXPp6q/ZpiqkhHLaZNEsqsURLaEnTwYrbdQ42R7CbjSB469
         es2UPupOdf4DL4nW8GZfN3R1qZxUYRSxpotgY+M5r/jA+DTj1X8jfHQRost4bWnTV6Cj
         60rp6g1in2N+sepK6hig54IpcGOSM/i5XG/2EpQWbnfWTnzatj7iKNfTKHHEEWiefnrt
         LU4mBVeO9s7zuToHQFzTsx8yM31j+6DcoHERSveo+8TyddK9aYmSyZZzfrdqphVE1JPI
         T38ydBzNK8WMWtm8B3dHPFzUF6HMLulQpU06Tw35uuiLTmPOXvhfKWEtSbBtcNtAt64d
         ctfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764509609; x=1765114409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTU1/x7Dfi7RpaKWDbcpvMWRGnF9c2LffZ90taw7x9M=;
        b=aEY6wOsSsT0Frzfrl36FMbjvlEKcij0n9Rzl9iXKxVSjmzUAAngCCQBZ2MRY8XuYqZ
         fXOqL72Gdp/YEr1CToLxpg0kjTzTeQKcr1KzogjqKRHsZEPHXARi5ILcYcJIGwl+oNmx
         SmOOjKjWIDKb2F1/tHfxZZCzyj+KUPYgfg5+cEdWUpZWL9ToTB14yi/ipC5To+DPjcxr
         aGBwLKbBAP0lHhq2C/U2COPEYrD8mzLUao7WRkxlY0Y3ConTtbK+bjpoWKH7GHQgCVNn
         t4QgHmjjfExu0Nz5ZdWuyulYcag1kLH1ZGk3PSN/58ZA5nXplmfKAtxlp9wN6zWkm9HM
         eV1A==
X-Forwarded-Encrypted: i=1; AJvYcCUuyKqVB6aS6n+4SVaVSZDhf3dvW74oNp5UeHmS3Jli3qTh+ipCyJIXqFJJw6Hmi8dZ53uiW4/UwCbmoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRY3EM/zmqHQBd3qAMO0yl1a3qtIB+Gxl36tvVfwbLaTQuB1fW
	cDJBbbA7Mj3LPdI9YO0Zpc8O0aOVs2WMLfHt3GvviBLHBubsqHQS14+eTCSAydzlbo4=
X-Gm-Gg: ASbGncu7akdBLxaUvpsO1Uu9MoUi/lcPbwV123mvlEo3KEJuXCfxkK6bhPAnkbPPSu7
	YcnSvUwcek2eKuDn6HL2V6aoieWy9pESJqR4r8pktVOxuazwTaZRglt6Ck7/M0FpE3kQ0wWi0zS
	Qb2rKdoKjELiNKCgQCSbND13KtTi5Qly+ZkqvZuCoaEoKYerbCorrWpKOi8LV3vgHutdedfiWGl
	Ip8Qj8eR3QEuyd4N7JEaBKqb9Md2F7HHaS0KmWl4nTdNfuhqrhrdMGJrmjBu+rseLgHtcyfDwqj
	7tU46rzqw425HpPS8pAlWZm4NtB8+NPq5t53f2ObkD5HrRqzTd/x0/1OHPYYQ8PiLBqSYm8UcFQ
	qdGkPRZp/mJ7kv+LlAciUSU1owOIqnz3X5PjaUrsUPbQoJikxcXKlEJc3ViU7ZKOBZqUmEsoQN4
	f74uCAOk/v
X-Google-Smtp-Source: AGHT+IEvv02cH7Vlkoj6zC4v3f5s15CRrLwA+XHiOAO3o4Gb+7fiYXTJRfgjgxvm7W1M5ld7511cSQ==
X-Received: by 2002:a05:6638:8106:b0:5b7:c66b:a3f0 with SMTP id 8926c6da1cb9f-5b99976c8f1mr14535060173.18.1764509609421;
        Sun, 30 Nov 2025 05:33:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc30f928sm4723806173.6.2025.11.30.05.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 05:33:28 -0800 (PST)
Message-ID: <13fdf4c3-5a3c-438e-b607-294c8ea032cf@kernel.dk>
Date: Sun, 30 Nov 2025 06:33:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.19-20251130
To: Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: tarunsahu@google.com
References: <20251130030653.2302439-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251130030653.2302439-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 8:06 PM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your for-6.19/block branch,
> this pull request contain:
> 
> - fix null-ptr-dereference regression for dm-raid0 (Yu Kuai)
> - fix IO hang for raid5 when array is broken with IO inflight (Yu Kuai)
> - remove legacy 1s delay to speed up system shutdown (Tarun Sahu)

Pulled, thanks.

-- 
Jens Axboe

