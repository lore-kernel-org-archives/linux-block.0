Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0B1A6814
	for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774208362; cv=none; b=Ar7+DtsJZKGBZXfrRre5dy4YIK3KCu9PQab9AekvZWDlpSzojvqYRPcojpoTJ2J0LCX5K8OO9kh6X11/pU+OlMqu3ky48FyQ/gBxQL4Q7MzDMA0u0DvNbt0YsNpkks7CQwJ1CUHbs4a0SvxxCWSB5pJsSoEORBpmy+DbDl9p93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774208362; c=relaxed/simple;
	bh=D9E6Rr8nA+FXrztt1eze3WF8u8xyh8DQ7RYxR6Fg87A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvQEwfkpf3wbjhH/aO/JupW28FqIW3OwXNUF1M+F/0UHnkSvi75NjL3Rz/B713reaUNU14hazAWZLbamwtVa0dXxbATZyiysrkImaSgES7/tA5nlrdPhk1ga8j9WK8VgrF9qMZiO8jCenJWeIOZ3YI5FNvyX0R1sTyqE2vVTq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B2sl0sMJ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B2sl0sMJ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2546040fac.1
        for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774208359; x=1774813159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3DmNtLk1wf4jjtAROBFHuUNL5Vgccw8aS4NdR89/9E=;
        b=B2sl0sMJ/7BibgIEok2BykY2mvdYJfKd8+iIdUeHFo5SCROypn2Vpp04MQa9jAL73P
         ZBZeJ2P2F/Rk56a0gIpKgWsOB2sM9lLTIhnAnikYn4BZUmH9Vy+LI83gwLlEQIDT79Ai
         qgVz7959k70vYtbo2ec3qNwQ7uMUZP/Eyw0vp6qrye09TS5C7xnumxCcmW0Zo0yjOZln
         RTUMKtAdCyGK7+2aPLV2osASfbL6P6e5tRGXMAFJr+NZpN2vXYcCVbe3hljwn8tR7+/o
         8skZnVklC2mZYQl0f0bJMGzzDYx21MALYYhCXH8+/MkURDDXc6Iv/nTK4rVEJshhKEPC
         iPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774208359; x=1774813159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3DmNtLk1wf4jjtAROBFHuUNL5Vgccw8aS4NdR89/9E=;
        b=b1iMcU29iEZTaCDmrRVE14g5NdC4p2eO/YZyH3banVM702pTI/mj+HhXwlin/a0xjh
         N8dZjBhshbgot6id7/kvxjgLR8AVdnqw5hlY7anFVH//uMOlPga1Z3JXw+PDv713fVsa
         TD4XPJltkoQv9zDNbMFo+BTVYxnVMznntwxLZ565DWU/ZoG9d4Zh0fnFZTU0PLhTI9NB
         XNofXlBVofJj0HxkeMFMU1dzwXDyg4ync1INuYkbkGUu62HKYUmbFh9u1h4s18YFzheK
         ArqKPazoMQIlmVICgOGUxEr3jXCCKRsq2kePoOl7E7QrJ897NwKI6sRHApe3HMTsgqV9
         CIyw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZNNKY8zHdXe+O+gRt0rc61Bn9F8qwVAUPElB7D7gWqoK7cWAcKM1fgXcEhXnUA+wqUiIEqzOTQ9CCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvt4B228MtWFb3oyS2HkJTLbYW7Xw6txKnJvpxYkXQ55oZUbs
	bm6qD+tGlTrpB2RnTYhPwCngoELaCMxLoTmDSijNHJKXcneYjETPf2/UKTD5q60BreLvuzI/Icw
	cE6HaVVY=
X-Gm-Gg: ATEYQzz/gYmNrJXWRhLrCL3u4yTizj211FJOo77fuqJJlfBSmbQw6mLR5N5+33zl26p
	ltz/wmWj1JxQcp3HWGybM0IUTw2TgdCgxo58TpuBKl49pW3gmfrpwv9gTqla0pWQ/47FbCxvBpF
	JxZcQTBmnmw8fzdrApjWPXZAbm1r8uIudkTteYyHCgLpO04DMYS56N6paVRaPDIM+5XE/D54WSl
	AB2jjmkujC5WC3SJTC6NyhIRAnMxYNL+SatX0KNu7xXU8aHOHM5cyuWwh2MBT/kropaFPRjJ0tG
	sjjX/PMpiPhnrFeHVqKhppfjNYNoA8l3lCJSLUxc5349OdhaMmR48JTPx7JXBB9fi3cbibojrlt
	OqkSah2b8a9yTNIY6gBu6tkfggRc8KfEVYkotP58aGF20H5FLGevz4ncZnBkP1RdaHhU8kFNT1u
	v1AnrHq8E4B36hgf1JGfTLaCGh/u9tl38r0dhe8H62005S6q6dVTBmXpC7ZR44JStvmZ7k+4XcN
	huTpQXE7CDCce5IuteP
X-Received: by 2002:a05:6871:4085:b0:417:5828:ecd with SMTP id 586e51a60fabf-41c112a2057mr6839945fac.46.1774208359167;
        Sun, 22 Mar 2026 12:39:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddf9d4sm7787972fac.16.2026.03.22.12.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 12:39:18 -0700 (PDT)
Message-ID: <42871942-c61e-460d-af48-d10f4b947d8e@kernel.dk>
Date: Sun, 22 Mar 2026 13:39:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.1-20260323
To: Yu Kuai <yukuai@fnnas.com>
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 Chen Cheng <chencheng@fnnas.com>, FengWei Shih <dannyshih@synology.com>,
 Josh Hunt <johunt@akamai.com>, Xiao Ni <xni@redhat.com>
References: <20260322183911.2732398-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260322183911.2732398-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/26 12:39 PM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your for-7.1/block branch.
> 
> This pull request contains:
> 
> Bug Fixes:
> - md: suppress spurious superblock update error message for dm-raid (Chen Cheng)
> - md/raid1: fix the comparing region of interval tree (Xiao Ni)
> - md/raid10: fix deadlock with check operation and nowait requests (Josh Hunt)
> - md/raid5: skip 2-failure compute when other disk is R5_LOCKED (FengWei Shih)
> - md/md-llbitmap: raise barrier before state machine transition (Yu Kuai)
> - md/md-llbitmap: skip reading rdevs that are not in_sync (Yu Kuai)
> 
> Improvements:
> - md/raid5: set chunk_sectors to enable full stripe I/O splitting (Yu Kuai)
> 
> Cleanups:
> - md: remove unused mddev argument from export_rdev (Chen Cheng)
> - md/raid5: remove stale md_raid5_kick_device() declaration (Chen Cheng)
> - md/raid5: move handle_stripe() comment to correct location (Chen Cheng)

Pulled, thanks.

-- 
Jens Axboe

