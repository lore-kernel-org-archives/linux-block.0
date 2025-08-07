Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFFEED8
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754533153; cv=none; b=QNlXbj9q5C/Cckc9zbjllslWg2XWbB7JfdeH3vxvrj1GKotDq1PAIeQGstw1fUpdYtcPX+gJR50Rj9d0JEp+QxU7x6fF0o+kWSSCTY2IPiYL+PeMWZ6gKCEhyHCLHjqD/NeXSUG3RhYgcZzI5WZneu8o+7OjY9XD4lio+lAriwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754533153; c=relaxed/simple;
	bh=FgZn0ARQQS7XwZ3K8kkGoyAKS/jcRfRt37uxZJLcqKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNYNffBAGHXpFbBlykl6Dwuy8k313sSwL2MaXW5DHZzyYKHcZg3ICXMZAW3LUaMjVaX2y4+YD2B8IZ0ZcFMWcSHbWdPwu2RsCbdeJHVCEjdVlZFQNY5uCKlzi3pUqimCplCFWVxZNXd2u4JHne+AYpkUwtBrTkv9wGHnOvWtcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Rc2HRveE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rc2HRveE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23ffa7b3b30so4223765ad.1
        for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754533151; x=1755137951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83sd6PCmkNwpnDM6Yeh1ANcUc7ticTzZNGY/Dmbpuig=;
        b=Rc2HRveEvy0TSS4s5nbvDaO2YUxkVmYpQlRQkuTFCZJCZn9fwCHqqQ2DM5fJ1BxeHP
         bcrxWW/Udzp2/gI4eQhF2a60se1W1PiolcoowKUmBYtrf04Cp9BGyyMVYhJYx/nEu2HP
         SBy+vNTWPgo+8ISXGaVN79xnW91BdbnviY9rFRMWYLRMNvmcBo6IIwF76IC5kF9ozYnz
         WvtI5pnp7OK2NSG6tQcyzC7lXrTU5ufUpf/UT2BvQGGOWWgs+iUg4GZsLiMt34FH1Vju
         ATxQDfano2MVxHItE75iZwWBckA8qs+kOeuRVpmg/SLXOdlXs5v31KkvXjCmloGPWzSc
         Gz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754533151; x=1755137951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83sd6PCmkNwpnDM6Yeh1ANcUc7ticTzZNGY/Dmbpuig=;
        b=otD5OYwaxq0JYNpDazA+fmCfxtLi+opRHMUD9PtbClAvApkSsv5QxS4GUvShLTLF4Y
         P+D30g8jg+NqZz5XnYaYakeEnGZiFomifpj/MOsKenMRl8f0YXxXG0XPL5i8uDc2rK2s
         He1L4JyySdI8hkwJOEGTaIQ0uCJfNqvsMUs0Rw325BvRVSORGLh6jaNNvXji7lzj8Ox7
         jRoB2gJkaXWJ5XxTBxFWug40hAwlbHzzp6wt2RaWTpUSj44Ob53gpEyYdcT82F4eQVGI
         d/Nd2HFZqVfH8vmYbgipb515OOD09irjrESso88a/iSMGrKj0ssaepAdyNYsuwOXRTTW
         3jhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5QusPVrJNh8mhRmde2tT3T3ynlcqPZ7yVTjGrqdk8zptzO47mZy9P8cpgLiUajHajyhuxbeAI2Uj03A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7z2P1SErlW2N9poISwVlcacI3VhgslaVfcwZKdh9CYNiHmFi/
	W1tM3YqYWYYSgX7hVMrTmgp1VnzoaoAOkw7DU6NXnyY5Eux7C+f9unrVa2kOvqKP/CI=
X-Gm-Gg: ASbGncsFy6SPwwXiaCoBcOVRXz7jURiirM3qFPfOQ6GkunhYhIpn3a84M/ZrK20tJ5t
	2DyVj46R2NjqlLlqCKkZqX8RI7pgD4MOnVXDrPwMlQQIz+xv4ZIXSxvhIOZ2kHH/+moFWj//+CG
	TGiUk/yGYP18LUPqX9GEN0xNOcgENoj78jNVLJQ1To7bA53QVNZ6FQwdpHRqIKUp3U8OjXe8OBL
	NrHy6wpmiJv/md4LyRNYtdreRWw50G7ZUrVxxa0PioEwon+NSz4A+uj0nSwQ1GzHRHeax96L0JH
	ctc/53Sh3EEsmV9xFHyfNojwRAjYkzdpFMKbBcL5H8N+pls1ZfHDwpxjDGPvSHDFo3oug5vtisW
	Av97mx4APwEkCI3dftxYjHgdL12B31mA=
X-Google-Smtp-Source: AGHT+IHJkCOHPE4vj/BlDybTg1YsT19M7uHIHqiHIRYNEuidJTNydsrIVz6RcyzzfBLtxZFvDlsLFA==
X-Received: by 2002:a17:903:1a68:b0:235:779:edfa with SMTP id d9443c01a7336-242a0b3e4c6mr94146195ad.32.1754533150912;
        Wed, 06 Aug 2025 19:19:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769absm171958365ad.80.2025.08.06.19.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 19:19:10 -0700 (PDT)
Message-ID: <98e3bdfc-41ed-40b6-92df-4aacab3d92c5@kernel.dk>
Date: Wed, 6 Aug 2025 20:19:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: Yu Kuai <yukuai1@huaweicloud.com>, kernel test robot <lkp@intel.com>,
 akpm@linux-foundation.org, ming.lei@redhat.com, dlemoal@kernel.org,
 jack@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250805073748.606294-2-yukuai1@huaweicloud.com>
 <202508061722.0vTVFHLe-lkp@intel.com>
 <7d2b0108-4d16-97fb-5de9-7438414d9ca4@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7d2b0108-4d16-97fb-5de9-7438414d9ca4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 7:30 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2025/08/06 17:41, kernel test robot ??:
>> All error/warnings (new ones prefixed by >>):
>>
>>     In file included from ./arch/sparc/include/generated/asm/div64.h:1,
>>                      from include/linux/math.h:6,
>>                      from include/linux/kernel.h:27,
>>                      from include/linux/cpumask.h:11,
>>                      from arch/sparc/include/asm/smp_32.h:15,
>>                      from arch/sparc/include/asm/smp.h:7,
>>                      from arch/sparc/include/asm/switch_to_32.h:5,
>>                      from arch/sparc/include/asm/switch_to.h:7,
>>                      from arch/sparc/include/asm/ptrace.h:120,
>>                      from arch/sparc/include/asm/thread_info_32.h:19,
>>                      from arch/sparc/include/asm/thread_info.h:7,
>>                      from include/linux/thread_info.h:60,
>>                      from arch/sparc/include/asm/current.h:15,
>>                      from include/linux/sched.h:12,
>>                      from lib/sbitmap.c:7:
>>     lib/sbitmap.c: In function '__map_depth_with_shallow':
>>     include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
>>       183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>>           |                                   ^~
>>     lib/sbitmap.c:222:20: note: in expansion of macro 'do_div'
>>       222 |         reminder = do_div(shallow_word_depth, sb->depth);
>>           |                    ^~~~~~
> 
> /* The unnecessary pointer compare is there
>  * to check for type safety (n must be 64bit)
>  */
> # define do_div(n,base) ({
> 
> I didn't notice that under specific arch, do_div() will require the fist
> paramater to be 64bit.
> 
> I'll wait a bit longer for people to review the solution before I send a
> new version.

I think it looks good, so please do spin a new version with that fixed
as that's the only thing holding up the inclusion right now.

-- 
Jens Axboe
