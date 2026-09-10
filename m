Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78239A81B
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073729; cv=none; b=hcyKpH06U/FzSfSba4T2y3viyHfCKLVKGAtsxV1aeXbHIiN8yscgAcjvRWt4wTjUjKzNVsCh+CQK7coKywTrklkXI5y3oz3rGdXHbCauP9BEa/AiroJDwUaFAcfjbHM4J/cZ+Bylm6a5n+aJ6+dIrYOafgIfjuaqHj5/qVXDraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073729; c=relaxed/simple;
	bh=/A2Fwd+9+3agfDel93uvmLAzyFdulq2jHx373bRNuP8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mo51Ii5ZJZmFkXQ6TwwaL9Bx5FSb/Em4yCEFdntVuzU0nj1hvV8HWhTTcxhyU4Mrbi3JfsVa3hKuoHynsGdFlclfcyzs5UzFIrIOHj7F4J/iEjIwLZZ+bd0uAoND8N4Zrpghd0OTRVqKSnx4GN4MD7ejf5y7O+d9shkNTmoN99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=q3MR69iH; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="q3MR69iH"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f4f824de5dso109891a34.2
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073726; x=1789678526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WJxP3qg6bq1oKid3neP8OLauam4Io159DZHymfuNtU=;
        b=q3MR69iHn0RY8dFStvfBYLlIS711TnZP6i2obkEa4Tv+UcqUhErfE32yGVLx7KsNPZ
         byOPuN6dCUuUqe3/2ke0voaOgHQ15J3/TxvcWWR4CxSJOEpK2lr1SMfGnOaInGirOPoi
         U9+d3LfXKFyhZDll6x3PHgbEjT+cwcQHuy5x0TX6NRwWCTVQU3beZRDRVuAh0HA2/aBm
         hRUZMjdqg173YDLJS2lNLwhlVe6CdCPQXcqhDquiXxweFjiNGZq+83YorruH9lJIDIpy
         Loj4/drY7cGjraj7X3wfak0K7BuP8+V9NIoQl+OU3sqOd/vflIr+mbJ3Moss3e3ZrWoR
         5L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073726; x=1789678526;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WJxP3qg6bq1oKid3neP8OLauam4Io159DZHymfuNtU=;
        b=H2xll32LQWFLUYNKU+KsDvDYY/Enrm3U4af8OtIiGsGUyk009C3H/gEk+zgUGzifLM
         hQiKaNSgK0goQ9QL7xwJhMcobWxUp0WbdtZPrpaKJrc45sy5qD4zRc6DZiufEd/fWJtw
         RArg5aCUh6vnov7IEbZE5hTGoncD+09QXQT16mteXSEHLOfrJ/90UoqgKJb7zkESCoYa
         tSod7pGO3k/YD87uSPeAsd+Q1kxM0DlYqcO8JqVRZQOf+umuMBtmfftFBhytKzYq0O0B
         2wbTWGWjcxN5uqXsTCcUaZMZFesVH3vG9qaV13xo8IU1cwGx3JabC90FqC+8oscfs1yM
         +ccg==
X-Forwarded-Encrypted: i=1; AKwUvBx8nio5gdU/YexS5GIa+G4RNEbKh/RyXCkrhnhlYrd3RUo8148ysN6kYYopcVa0JwfnUEcToSpXtptPMw==@vger.kernel.org
X-Gm-Message-State: AFuF++nIbc7U5XYQYrWcvkxaGUSXA9I97H5BaLcytW7sGxXNyoNpvGqW
	CjyfcLiZWayK99FQfqi6mWgZPxjJPjo8pqHKSu6tiH+DevWde7O3D9OUsUzKJ81BLogVlEdKuQl
	nqwOETXs=
X-Gm-Gg: AYBFou308A4Tk4DTDbWVZMiFE2hGcyqA5dFCHh117jrHxBT9fhz9Q4+kPyGkHmuZCL/
	YoXDz28VHq7gQ0eXxZGStIvZ1yLisZ8DsAcjjlTriXQDnuaOQ73LbmpioOUlvFn0hdNn38vLl+n
	mXtXcA+f4DLKJfnR6g/mFrQsgUMCUpf/e7x8nFyGQZdaXXBrE0wLaHz/9Q99DiGTgyiirCYndsN
	3clHF9YXVdyOx7K2wkVlS+i+t4hgM/dETJjhj6tHtENtCp28Yh6WrDT1Fs150jFuhHHB8KYFw3R
	p0Soecv4tKcRCPk+Gdgy8H5+9awRyi1YCvCd9TTy6gqtDauTa3PB1klb8Kzn5niMwr++L/0fiR6
	353sXO+0E8hnBnWEiLgiP1YnaGXzdL8Ody8yDT2jzftw16PFUgvoBVPTlcAzCaYBT9O7zTxFSPd
	2xupntJM92NhQunQS9KH60n51cLr8524c+8Ynb4RtaBi9C4I/X971hMU2cNRvGXyEDyC455XeIl
	CKgj9Cp7G4j2aArJy91dTDmwFjos2Vxrvk21x6E8uIxoRlxp8o=
X-Received: by 2002:a05:6830:6abc:b0:7fa:ab72:9dfa with SMTP id 46e09a7af769-803ff447bcdmr479781a34.18.1789073725724;
        Thu, 10 Sep 2026 13:55:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260908-fix_gpt_entry_attributes-v1-1-a4dcb417e8fc@kernel.org>
References: <20260908-fix_gpt_entry_attributes-v1-1-a4dcb417e8fc@kernel.org>
Subject: Re: [PATCH RESEND] block: store GPT attributes as a raw value
Message-Id: <178907372482.484803.13802362688033738030.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 08 Sep 2026 20:58:26 +0200, Vincent Mailhol wrote:
> struct _gpt_entry_attributes currently models the GPT partition entry
> attributes field with bitfields. This is broken on machines using the
> __BIG_ENDIAN_BITFIELD ABI because GPT always stores the attributes on
> disk as a 64-bit little-endian.
> 
> No current code consumes individual fields from that structure. So just
> remove struct _gpt_entry_attributes entirely and replace it by an __le64
> value in struct _gpt_entry instead. This lets users apply endian-aware
> masks explicitly when inspecting attribute bits.
> 
> [...]

Applied, thanks!

[1/1] block: store GPT attributes as a raw value
      commit: 74ea55a6ecb3fd69b47b2b8a6f6979a6c79c7ce7

Best regards,
-- 
Jens Axboe



