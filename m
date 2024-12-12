Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2718B470
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029330; cv=none; b=W8zOXtJO1ZMtm8JVGTTA3fYMcxICFN0ntbxePRk5hjZMBCp/8BOB3vWP14OfRYwNbMvCVD5qOsVwLg3mn27z7r8fSOXROGdB3irDolE5zjOpfojcFks8ucCmFH7d7ut058WM1BvMsumloX65yzfTkQLpUqbr1+RS2BOIa/WRtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029330; c=relaxed/simple;
	bh=QKQL4MS5nZa+ROMEXkXGLP2EpoqfuvY8r+Y2F7K489w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m+tM4sBNgMVq83S34gRYF5M6/Q/uHf4urm2SNVC6gZDOMfSDmi1Q9CDm6BjvY6TG5S7HYv8n+usRzCaJGh62Ewr7yAHv5Rr5dusESJcpErB0daRTa0uvRPM+bFBygJAvr24HeDhRTjD+YGRm3XzM7BXdeN5NxXB6ciVrloc6e6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZGr9K8KF; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZGr9K8KF"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so38625539f.2
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734029326; x=1734634126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NEanoTkIUxCO+RPtP6A6ijL8u3YML6PUoYR1PXvvOM=;
        b=ZGr9K8KF6jzbh4QlihwqRMvktw/IL6nKVyTHU1qyW2/CU1xdPuAOV1PRyeVtu3tTCd
         zZJDaqZFsyRsYX6Pg6GzSppdxe+2q6jZQV387vx1Uw3NBjfMZ6qKuZpNc6TucqwahFtr
         ef7lZwP1DWziBEWUdeWRCN5mV+Gv9pCfHw3X3SIr0OAScNQ+d3ewVYRzGhPjlS0TVa79
         Kvc13rsbpWOfvxySgOm9zER29oZARlI6Wz/5uD0NDeWx3x685Q0Pqf+bp4DEpJD5+5Pr
         ND3e8pJ9CeW2L7ZH0o19oMohC8dP2X76W0c/AnerMrlc9g5X9xuKM+HZbF/cqe7qaj5e
         NwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029326; x=1734634126;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NEanoTkIUxCO+RPtP6A6ijL8u3YML6PUoYR1PXvvOM=;
        b=PTpOixdM4gvPpY2ilSWQKEQTADR3mWb8hAq8/uxBoFsUcn1UJauZs1Pg+7x+qFiamr
         HXwLThpk4Vm7MfUEf4BqYWby/dKDfRsC4eEvtACnvfS6rrVWdPcTMF4wWxjXqlb40K0t
         QC9/C+BpahA7gHkllueQ3LgF0NQe0j2Uawbzg/KQEklJMttDDX2oA/WxBJq5kHbgLBt7
         +c6Fbfn2n8jcj/zGBqaDj4XVoUV9LFMmfppJ1Tjahy6+BaARw3wgTm6taeH2qTT++sdb
         UspGijK3wqheTs9ULxZygmWJTCgQfaRgBJDeDK5lXEAeAY3HAEvAvXlJMeq7p5rkYzaE
         Fyxw==
X-Forwarded-Encrypted: i=1; AJvYcCX3lAkYnRB4y+7wQlAgeeqdnH6fRAE7zHwpCFHamBaO21qas8DfXzQ9HW0CjAXQeJI12LMiJmsD8u2Frw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrzCVuWgzc7GWBZlzgMZKUmkmOEwkGqcL6T16V7CFcbYgZQUc
	Z5+J5U+6gDXzmiCKDe2eQUGNQQKdd3ngdZGW9WdANwkEBW6Lsr5niiDYcqqPQYM=
X-Gm-Gg: ASbGncsykFgDemrOiqw4Obm4SCMCmBpNKyu1FBBqlfDtCVgf/5U/VIizWdtIjAIISqw
	gRLbRHZ0Rt5DSXsL3kO/tabROKzA9DiJGjrUVi9iusFKqjXEfltKVA7+DB9iit97mKtPs7/jJ0n
	jFF+EXazSMv2NdHxfNXZgLyGyN9qb3GW/CnM7VUc2b21o7UeI5v+J7vtMk2BlZxh5bV9nmxVcIF
	zoneqK6TIQM1F6JyWPOVdwqjSE0KUaDoMdxwo+K1Wk68Nw=
X-Google-Smtp-Source: AGHT+IGhhvkFg5+OlRRW7dAh+LXxFzeHxLNLeGbrpzVSX1Hr5klBw9D+P9RZ3N63ZKwQ7KiNLlXZng==
X-Received: by 2002:a05:6e02:1707:b0:3a7:fe8c:b015 with SMTP id e9e14a558f8ab-3ae5953b1fdmr15053365ab.24.1734029326669;
        Thu, 12 Dec 2024 10:48:46 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a819dd4ac9sm33682775ab.12.2024.12.12.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:48:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 David Laight <david.laight@aculab.com>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
References: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
Subject: Re: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Message-Id: <173402932544.982680.529127077152903218.b4-ty@kernel.dk>
Date: Thu, 12 Dec 2024 11:48:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 12 Dec 2024 10:13:29 -0700, Nathan Chancellor wrote:
> After a recent change to clamp() and its variants [1] that increases the
> coverage of the check that high is greater than low because it can be
> done through inlining, certain build configurations (such as s390
> defconfig) fail to build with clang with:
> 
>   block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557' declared with 'error' attribute: clamp() low limit 1 greater than high limit active
>    1101 |                 inuse = clamp_t(u32, inuse, 1, active);
>         |                         ^
>   include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>     218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>         |                                    ^
>   include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>     195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>         |         ^
>   include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>     188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
>         |         ^
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Avoid using clamp() on inuse in __propagate_weights()
      commit: 57e420c84f9ab55ba4c5e2ae9c5f6c8e1ea834d2

Best regards,
-- 
Jens Axboe



