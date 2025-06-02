Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAB1F3FD0
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887136; cv=none; b=V+ODYk5lYZdpyNQHh6C6WnHCkA5qa7gTFZOrAaP1O3re2FhnKiRBETKrFzAR/d4hPZMGPVbrs7V1fKMVHTmevothIM0fp/K0cZ2yKTrRDRIpt7s7iokUwTnuv104O/UB3DZbuWM66kSeYf/ajzB0pH8CEJjDCkID87lWsiJ6Thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887136; c=relaxed/simple;
	bh=JL23LbqzegILDrRiRuNypSdUhSR1QNudDYPRUm2vRKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpJSoKo3BGoa1U8zj09yYfmWy7fZSBF/w4QTcOX+jKwKdvraqH+0qmaCo0qck/rAZfhK6FchiavBWi3i9OYCioyzA/94eplR9uiGDonATfFqeSq9LvHOx0YvQkRfuG7T7jRXIbR0853gElcWJ3WH0juyqY/4tADndQtSWCzpIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aIdjVl4g; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aIdjVl4g"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d8020ba858so47111595ab.0
        for <linux-block@vger.kernel.org>; Mon, 02 Jun 2025 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748887132; x=1749491932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zuob7mBVCjEsPWMyyw41PuAwcHyNQ6vZCl220b5gjQ=;
        b=aIdjVl4gpzHTbvQRMu466BMd8F55INCU9WwDHhShvnRMqEweDVc+RaVFZUt4BPurpC
         BF7HENrOc4lJQImQxAUcTF5kZFqLkeqhbXDHLr0hN/i4uTyUTlgQEkUZ4iv0OHDYkHfa
         ffQ8KuAX+ZK2fPSTStbsis6n0sSseF0Uc8GaRNC1Q1gMPdg93aQQCQOsiZYa0uMC1Nt3
         kPs4wy8kw2OI3CzRy9puAHKFeU7kQw7zLsXlBgtLhb9gE6Coy4Z3oGzQxWQbC4JVBKsZ
         B66CCt7CNoJnejwdYgjrvKADOiBFHZkzzV2bd2b4bYZmNYg6578ds20zcQeVrnOO6CpK
         04Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887132; x=1749491932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zuob7mBVCjEsPWMyyw41PuAwcHyNQ6vZCl220b5gjQ=;
        b=pii/FEcJVRIdzNIYqJLKfIiXGBkW6ZKrID9rCJxLu1mXw55yq+VGd631ijZ8/0pCTS
         hUjT/u3wGHd1gs5txXJcp5yrQ9N2vKe5Bm4OdFpCZBIKf0qM26U7RbSS7GTNW1rEmZUn
         WTs2LlWLMjwwV3gzo27r8GdeT/4c0HuCP3wm6y2bK73HCwjfW85P6WNwPnyz8XJmZqu0
         h2AAnPrw+5TgExCDg7S9notasw6HXEM/KuxB5PJKUzKBA0Td5QEjlR5N48DoZMOu7zr3
         qYFa2mtUTCKYF/Cz9Wer2vdktR9BBgvGHHBWfcU3HvPAapXlhpyIbeJfuqBXk0DmLpgR
         0iAA==
X-Gm-Message-State: AOJu0YysGCHnQCM471CzWWaaBLtdS0h76DRCc0EAl2GCNEnb6RICSdmY
	+bvNxBwb7CQR3Uca1Jp7SDXgwHGpw+dxJ9zdQSH8xdclsUrKpyJFymrFBXYWfiGz/9c=
X-Gm-Gg: ASbGncvX+dIuHkRLB3KbJMt4YHzVyfWS+ZaIs5s/5UJ3jRpcV44GLtdtdVeTTguC8Qe
	vtCBZQL2kvpLnUfQmXxyHNH964ScsICSqJ6asC1FXlOCWLUiY4gtGkkNH6MjVZpgLWWiI46XOUm
	EQbmFb3ym+GQYBHg6t0QeOo9HLHZ5nhTzghddcRrd4iIw0dKMaHp1JtuhD9yXg0BxgLoiKi/wHU
	oIqhBoaWjOBBVLnbEgd0w2crHSQRYUNrGAafe7Niy6jJwtm0nFNtEuGRW9fhe/Q7bO574v2+ODK
	HMNfT/QzlRKARTFwdQh0CEl6LwhvWNmFOfgPv1w+T4+6+hk=
X-Google-Smtp-Source: AGHT+IFOUyH/ZpwlQXWPQYAVRAv/5za5Evr7AlcEasvz+Q0PGVcQUx9rVdPLFo9rg7xCfnfjzs6ocQ==
X-Received: by 2002:a05:6e02:1a4b:b0:3da:71c7:5c7f with SMTP id e9e14a558f8ab-3dda3388352mr87926345ab.15.1748887132277;
        Mon, 02 Jun 2025 10:58:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7efc8e0sm1839204173.122.2025.06.02.10.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:58:51 -0700 (PDT)
Message-ID: <a826f03c-3ce1-4561-a702-78b383ac3316@kernel.dk>
Date: Mon, 2 Jun 2025 11:58:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ublk: cover PER_IO_DAEMON in more stress tests
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>
References: <20250602132113.1398645-1-ming.lei@redhat.com>
 <aD3mOZSF0jVJnskF@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aD3mOZSF0jVJnskF@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 11:58 AM, Uday Shankar wrote:
> On Mon, Jun 02, 2025 at 09:21:13PM +0800, Ming Lei wrote:
>> We have stress_03, stress_04 and stress_05 for checking new feature vs.
>> stress IO & device removal & ublk server crash & recovery, so let the
>> three existing stress tests cover PER_IO_DAEMON.
>>
>> Then stress_06 can be removed, since the same test function is included in
>> stress_03.
>>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  .../testing/selftests/ublk/test_stress_03.sh  |  8 +++++
>>  .../testing/selftests/ublk/test_stress_04.sh  |  7 ++++
>>  .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
>>  .../testing/selftests/ublk/test_stress_06.sh  | 36 -------------------
>>  4 files changed, 22 insertions(+), 36 deletions(-)
>>  delete mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
> 
> This should also remove test_stress_06.sh from the ublk selftests
> Makefile. Besides that,
> 
> Reviewed-by: Uday Shankar <ushankar@purestorage.com>

Oops yes, I'll just amend the commit, it's top of tree still.

-- 
Jens Axboe

