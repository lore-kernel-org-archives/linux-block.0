Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E6231A41
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263186; cv=none; b=EIWSpjp6CAjCLBfrM3/XGHdzVx0l0J2GfxavoKrOh1gyr4k6EnNm3e3dyxManfrsAWfdBv26kAVFA4XGdCewf+yzCT2Fbdsv9E07p9fweK9QbyfPxo5O36l6X76LCIfId7R7gbDtRqJj0apJLoa96tfqU8AOg1h+FK5C5QxdegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263186; c=relaxed/simple;
	bh=vPRAC1axTLwvGA80eSp026n67BLlQqS3TKlWdDh3aXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csLO1I24Yq//RL3XBT0CVg3/uDDEWY2+RNf5bGxpvcf6PRrr/zulGXIwSWM8Zmg+OJRVz6upHNV+7q2xawm/2+iaBRbiJNCmvcRdGdIEyyCHzYABQIiFqY9SYZ8krO2pVNCd5lIgvR/g2YgCmRrjI6zKPmYzJrR46nwP43Pn1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=toocp2hU; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="toocp2hU"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45eabce608dso345244b6e.2
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 19:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770263185; x=1770867985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vT3Y7AvzbLkrEs0Okn1/4K5cglwDEJDfwG1cMApl4s=;
        b=toocp2hUM/niTpnxr6zvXPIepMJirXYLOWv8fC/huI2DTR4dP9vnIolG+9nVSOaDAo
         E1z+H2GLhLB24cb+CVl49+yEpEdP8bxyYHdlF+d+WbOcd6hoqnk2o7XNC1bPDEMZb0+A
         Gy4Ks55CTv7X9ueJN8W+i1md2C86p9yECGHxgPddIck1KJwgrZBONpFtlJ48Qm4rKd0Z
         OoqbanC8H+jjoviEYdkoKWKojSdhAifaBoehI5NaeFZCcjqVGwgmKOvhcWuw0ozPehIZ
         x3R8HBy87vZP71zYbjafASRew9ZWoCL10rAezIUBg64YH19XDk/asbTx/xaZBO/g4zfu
         wURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263185; x=1770867985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vT3Y7AvzbLkrEs0Okn1/4K5cglwDEJDfwG1cMApl4s=;
        b=vgy7WFFYFhCfbvttQpKr43idCY/caDQLhiwUv4Hj6gLllmqUkUbwEGwhkGWSfFA/5p
         CxmeRRyAdOQxIEhzeMhef7FFY2AZh9ozOnmCrXurmEL4C91Sc3ZqZsOBWd84XEEwj39q
         Gv0dN3tq/VCgFPswvJZdwwaTvAV5+W2KCkR+UnqPxkSq0YbfsVBlOKFcZgjnAFyWnON4
         f/tyAS4Ccc0JH7508VWlIVzfKDcW9QXSDSQRitNlVrWIBleisu4n/6d0J3/hG3nZav84
         6egGvRFTiFeqtuBlHU0nxsOk7wFDFdISFS+GULcm69w3wPbEEPTrWQKncgblIdlwTNrT
         JS4Q==
X-Gm-Message-State: AOJu0YzyI7G300UqP7uVgfpPO3BgG2dvGaxuclpJoDGYOuT5OLbjpO5f
	QHao/DHx7m3yulV9Cqur3YVZ6fFZZds2rm0fY5r7kFhEuwQ+FRr3Wf16+ADaGzVbgxM=
X-Gm-Gg: AZuq6aKa2bmDGnVFGf1u3mEN52YHf4fziLCFFnweFClWFHYyZbtA9XNeWTimCV36vEh
	WiYB91YHuQaBkQQH2Hx5a7XUDnWdN+ke5WdAONbn7WU6jb/Ryu4e2SdZzAbamAcVW9OxtCESFwl
	KKX30+OXNkuI+pyCrLszNDxAP9ggpDT/ppenWtzJHP5nFvOMSjt33BMYvZ/vMUp9BKa2ACzPhGg
	gfQkycxGknk0N16FU3ApGiBFjXRouBmD4WoFH7Doe44EE4koyAMWFGVgihWhptlrhxcb6e5LTQb
	9qJIGk5lWmFxV+7m0ks8I2RTYzWORp/KbROCyHwxmmcPcC796n1kMVXh1u0GKMKS8d2KOt82aPN
	U/CIf/wjulGbpwWL42Hc/tQCli0OQUHE7ZH4YE74hhp7+OOBO392tW30IqjPqy+tJEid4kDmeRN
	bXzDePQ7SCwnDhl0anEcQjvrAieyMTUXh86ybpBBsopn7aSzbLSKIvaQVqMPlJ/DBTNslO+A==
X-Received: by 2002:a05:6808:894d:b0:45c:881c:e0c0 with SMTP id 5614622812f47-462d5a0d4e2mr2527686b6e.47.1770263184722;
        Wed, 04 Feb 2026 19:46:24 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6608caasm2415379b6e.2.2026.02.04.19.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 19:46:23 -0800 (PST)
Message-ID: <8c7399bf-76b3-4902-b257-b85c95543f6f@kernel.dk>
Date: Wed, 4 Feb 2026 20:46:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Samsung] bsg-lib.c patch for double-free error fix.
To: jonghwi.rha@samsung.com
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?=
 <jt1217.kim@samsung.com>, =?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
References: <CGME20260130091020epcms2p2d85af8781639a17ab517208feb270dbd@epcms2p4>
 <20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 5:04 AM, ??? wrote:
> Dear Jens,
> 
> Sorry for the excuse, also thank you for the response. 
> 
> It was my first time with the procedure, so there was a mistake. I
> apologize for the inconvenience. As you mentioned, in the case of the
> previous patch, there was duplicate code, so changing it to kzalloc
> would indeed be meaningless.
> 
> We have prepared a new patch and completed internal testing on our
> side. Without this patch, issues occur when using ufs-bsg.

This patch looks better. Can you please send it out as a separate email?

-- 
Jens Axboe
