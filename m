Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E41D5146
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479703; cv=none; b=Fl/+NzAsRclKX69IGi9OssxPMpqV/mS3KRejcFtczdCppQUIIMIr5LIMfqk3IdVUkZkpFlxqI5tHMmYOxaNqPMGJG9twoSw6yIWeZdM86KOcVkN8BWwu70oRhZMEieoQgJ3P7kGnjA+89ux/xGPdbyjRiP41FtWmyuUWRTviG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479703; c=relaxed/simple;
	bh=nJEynW5dNGbu/Ll5y+AXc2bSvus1QUVI1K052cJKdIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyST1ksSYqrI/IJa5D+Vc+lOJoiXqJoZwSjHCwDGWJfYVsTMANXl5Bjn0fUJXxZhLDeZwIVT3bUVBIZrhZfGX+AY1p5k0A6/ETxcfMrbs43g5FB4IovYeechrYILIZRhM+RVWCIbNP0wq6waCsdN6FK1VFj5WNM1j/9Hf2OKwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XF1ntyvh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XF1ntyvh"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-433791d45f5so46209285ab.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763479698; x=1764084498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy8ULjxjFuJfynfZG1/W5PbyDBh/e9T+CN3YabDB0xU=;
        b=XF1ntyvhtQYCzxUXDSzyfQyyEx3AuaweY9SA8ybq2nU06VMR00vO5FLzlo3c9eu5l5
         WvpZf2Q7IJ9iPdBRahRI9lqc7SUiwlvK4qg9fuMXX+aflSZ32iEv4lhBC+6UMRp/QM8P
         NA26rVwIWMsa1+juhekTqRlUrnNLcg/XygbVrIv5wLJmVy5+FMjQLdGsJWs3NQqAL4yW
         SJ0olwvDifnVFEd9a+uk4MpPnDK3zgDwZBTb4zRZpYeQ1XsMe2XQN+YB0x7wGV/JLWld
         55w9cAsbnItmuKFGkPBJW33gOjav4NNVThQ58xN6e4d0RekqaNZbS5zEiJjRo6yQfYXY
         DJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479698; x=1764084498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oy8ULjxjFuJfynfZG1/W5PbyDBh/e9T+CN3YabDB0xU=;
        b=K8Qeylqy+B97ghjlIgsNIKc+yb7pq7TA+h4yyZsNSRJYrgZ08eszExQ5q7SJo0iLZF
         Ymhwd+/DsBKh+ny7j72gWVYN2e3GZdvUstD/D6pCkvU3t/ei4HnbLsBwN4HuIrgFZ1Bl
         aIQTsc2OW3R1BRf378bBJfSfh/PPLNMCsIzaEyel2M4HBYe6aJzpxqzotbMIh05FY6+j
         ngnyMmW6ucQ4uB/7sw6wbT4xlvysD2wntnaGLSlurQKuIsWQBge2e/eAaf8mAZqR1Iwx
         QSOC/o+1AqxsBTaMwVuGiixlvrRdbHF65f/1A/ut7LmNfA3Jeo8d1FS8gkMmU19T96fR
         l8Cg==
X-Gm-Message-State: AOJu0YzuYoYyHjHHyAVOCnZWLZ8KkyNOdEwI42AwEs0U3sR0xbVfLUVW
	Tk62r/zF/PLUvbToU8UO9GMDrZraInnS2JN+QczM0IxjaAbd07PB2MsC3FqSF1kJ1soCW55o9G2
	9baOI
X-Gm-Gg: ASbGncv2iuG4o+iOeTh8pvo6baQg9cgaHy6h10yPVtB/xdxq5P1f8ZJf/2xHI2S86/T
	PjRKvQswQqfCJYc7mKZWJLgL40ozJTLMIy7du9ThP4Z4jyG7V24bybJuHcJmNv0tmDQu5bPzn4F
	UZPMGGh2UZJYp0PaN+MfvMIvEPK2RVXo8vsXrovqviKBcyJLU2oGk1T7+oafqS5VieoeOq6LdrM
	ajcvydqAi/+s4spRkx8DwFcvuB3790hnRD/WOEwpxj1Ic28f4ByrpeCx3clIhVYistBsQWMFppO
	QS9922Myiyf4zXOmWr0Wyyo4K2cTwqEujKmbOKRBH6GLJdqyQFWD3N6vcmHx2Cbzq8/hiobmyE/
	0sYBL0kuBNwntr+V56bVctJo0RHHoYxjlSbsmGW6M7MVeefuNvE19hVvW45RTfKtfmkl+Qpxd0Q
	==
X-Google-Smtp-Source: AGHT+IEg6INd6zkATVXQT82BzcrUkn+uIH/mlcDhABBlbP6aaJ0CQ7Q6vUDVkgItY1xLHA5pJW5nvA==
X-Received: by 2002:a05:6e02:1c28:b0:434:798e:ce08 with SMTP id e9e14a558f8ab-4348c854671mr187644695ab.1.1763479698651;
        Tue, 18 Nov 2025 07:28:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839a4ac7sm83749355ab.25.2025.11.18.07.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 07:28:18 -0800 (PST)
Message-ID: <0767437b-3861-479e-aee2-d4f5cce9f6eb@kernel.dk>
Date: Tue, 18 Nov 2025 08:28:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme discard issue
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <26acdfdf-de13-430b-8c73-f890c7689a84@kernel.dk>
 <aRyPJtYJaEVRkBeM@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aRyPJtYJaEVRkBeM@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 8:22 AM, Keith Busch wrote:
> On Tue, Nov 18, 2025 at 07:24:59AM -0700, Jens Axboe wrote:
>> commit 2516c246d01c23a5f5310e9ac78d9f8aad9b1d0e
>> Author: Keith Busch <kbusch@kernel.org>
>> Date:   Fri Nov 14 10:31:45 2025 -0800
>>
>>     block: consider discard merge last
>>
>> This was just doing an allmodconfig build, using XFS as per the trace
>> above. The fs is mounted:
> 
> Huh, xfs was the only filesystem I tested, but obviously not enough. So
> the segment accounting is off now, I'll take a look.

It's all very strange - reverted the above commit, and ran into other
issues. So may be something else entirely and your commit is fine. My
for-6.19/block branch seems fine (?!?), but merged into master it's not.

-- 
Jens Axboe
