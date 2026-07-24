Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B03175A7D
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886619; cv=none; b=REYrD9YdlMyM2zA/D+SoESSHLdILsXKhgnK78yFJx49HevIiwmn0x70ru1sx4QzNdAy1nUiFgELjzV2M++oFxbp1dcq98cbm7/kEFmD4kww+WKhk/cE8gz0GoxJjMmlfZ8QkQWtTKscvmOr73eTPBI3FJW1qe5ZGKmgO17UjZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886619; c=relaxed/simple;
	bh=DSB2j5zRw5Wrw4WWDQ926oNnv8nTcdm2byoZxkmdNh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmZqV6a1tMXN77oYImJRjnNXOoUFBVX3Uy9vLuwwIMO+6dFCOP6YrJizf6Zgrs8Cr6ZN07/Hf1SvZYjcon/n6oRR5F4l2fl0QhLTTqIPr/CJrV9jjIpZan8YPRDurmevwcmaS7nWYTDDslhoI/FDLhKdEYv7JKd5oUjXSBJeR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yicuwnl9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yicuwnl9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad8076b01so2535375ad.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784886617; x=1785491417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z1qfXAfno9u568akIQ6LKVlDVTQBpnzriwuZ0Ed8iD8=;
        b=Yicuwnl9uLWerSmC52dSEJOwGa4bS3UK1SUo5SWIn5/V+zZZ7jARHfRVvXGcf0gB+8
         7R0FuFUP0Th0ViVjaqQCQekSAfUODyl0N91CoJz9faoy0/FLWyzhcfkJeWXTdtmSUF6I
         52EI2Er4qAG0jkLhhMpG5y55rtVP99WgLls4TWmargZOkxpCbnwJCe2/0kTKx/lwcORo
         wP7M/ppgXPqH1rSznimnDvwygBAcz0IspVYTrD9YYoCR9jeIrSH4UvkNdWqtiRlrBdpC
         luOmB9dPFAWsZwsRnX/gyPsUF4hvCHuKtP7IajNzsNNu+r4DeXDqHdsiGTdSCc6SSVlB
         toPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886617; x=1785491417;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1qfXAfno9u568akIQ6LKVlDVTQBpnzriwuZ0Ed8iD8=;
        b=kSvHp6PEapNIWm4iREqzpQ816Iq04Y/cxHGcpdzVLobnczrKAvRGz3FGA0/Ibas/a1
         VKAE3E0mWQIRhQOI94fLNrvJb4s66piiBUeWgced1Fyhj1fusZd+9dSvxG8H3LSOM0x8
         sWQ4hqdTEmHi5ilAxejifUo23trVpCEPIpUDXNR8fHkmZ7NjLLYcWSFOweGP9XLduQ0k
         HdN3qnCT198Oh+M/bMp2E969Xmqs1x9loTcyO6+5UmVcaSyLW0sbS3bXV0fhyE8uZA1K
         4ijTzw3HB/W6Sum/bV90Dn4xd0/0l1KFwD9OlbSIXUCuyesRPriL/rCh5HQ2ubF0Mj+/
         nGcw==
X-Forwarded-Encrypted: i=1; AHgh+RoigRIc6Huig1r2erwd7M+sG+FFLkz1YChWFbAbz4O+CHSHvqM0bIt0cBVTn0TSQryd3nFUw88Dy6lqYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d8tEmZ/tHPHph8elUQ/QITKTkKmSP9V3xik+D2p2eKIZDeVu
	Kq8LmomSdHsxwnZPM5X020FZP6KGqDK8oLsnfEuVAUyQFGY8LbYYCwMK
X-Gm-Gg: AR+sD10sTie8o68K+kRfyl23RbwjVH3NSFSj/wS/veK7kzjznZBJK8z6rd0dvdTjvTp
	pCn7bbKrmB96WzM/sQ3Qj4Xz3Bm65REbGD5AHaX+Pyvno96ES+U+Lj7BJ/9q1Y+HDmeYXYzs7YD
	UrnxyItS9b52zwVLnjp7JNiqRcj5SW9daI+OegXmCG6aunwwPCWya4LdgWplNC3DbFnXWsDIoqa
	0485d2XSy3/6BE0T2MScEn0I4/m0v05vOUNEJmy2ruQ20Lace+HKwNbBkpml/hDEmRTjdSKXsCg
	ehkCm+l+aaw3GY08lKtQbYpx+jLf0Cd+HPptzDEuJJPIJle2POCPoNZ3z1MB9V/ieKNvmiDWVhU
	/SECed6CFqin00vp+xNGzS+ACYsihQ5WowcxwgI4qNtwXQPfXUK5UKww0ZdcRtB9vwHbYjSf9aK
	7xjNRmLKtpbH18fuC3TDfB
X-Received: by 2002:a17:902:e94e:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2cfa730eb86mr81227195ad.4.1784886617363;
        Fri, 24 Jul 2026 02:50:17 -0700 (PDT)
Received: from [10.0.97.235] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd8a9csm48683895ad.30.2026.07.24.02.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:50:16 -0700 (PDT)
Message-ID: <ef221ce6-89c2-49c1-8029-fa129cb1b851@gmail.com>
Date: Fri, 24 Jul 2026 17:50:14 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-wbt: Always change enable_state to MANUAL when
 setting latency
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: yukuai@fygo.io, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk
References: <20260717125021.88825-1-yizhou.tang@shopee.com>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <20260717125021.88825-1-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 8:50 PM, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Commit 1e56f30a73f3 ("block: Make WBT latency writes honor enable
> state") compares only the boolean enabled state in the no-op check.
> Writing the current latency value while WBT is in WBT_STATE_ON_DEFAULT
> is therefore still skipped, and enable_state is not changed to
> WBT_STATE_ON_MANUAL. A subsequent elevator switch to BFQ then disables
> WBT through wbt_disable_default(), silently discarding the explicit
> sysfs setting:
> 
>   # enable_state = WBT_STATE_ON_DEFAULT, min_lat_nsec = 2000000
>   echo 2000 > /sys/block/nullb0/queue/wbt_lat_usec  # skipped as a no-op
>   echo bfq > /sys/block/nullb0/queue/scheduler
>   cat /sys/block/nullb0/queue/wbt_lat_usec          # 0, WBT disabled
> 
> Skip the update only if the stored latency matches and enable_state
> already equals the exact target state: WBT_STATE_ON_MANUAL for a
> non-zero value, WBT_STATE_OFF_MANUAL for zero.
> 
> A write that passes the check then reaches wbt_set_min_lat(), which
> performs the actual transition to the MANUAL state.
> 
> Rename the helper to wbt_lat_changed() to improve readability.
> 
> Fixes: 1e56f30a73f3 ("block: Make WBT latency writes honor enable state")
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  block/blk-wbt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Indeed, this edge case was missed. Thanks for catching it. The patch
looks good to me.

Reviewed-by: Guzebing <guzebing1612@gmail.com>
