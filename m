Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274399;
	b=eG+9/vtm/fzPVTvMquwP3ea0VVDC4QlWFbd434IkQr4ZoQu0of6YTGXKC3hNZGTTrQPy
	 kdPwvpYa0va8hwJF6F0Mx+87t5KwWrGxQmrhw2WTI+efFlCBdMe5h/iOx/4Zh0fWrESrh
	 l7RsoHOXIsaJUMMs3PMo12sL0X8KkzUSx0BL2XCu8jjQ5usXurh6PNOT915s0jwYjzofJ
	 iNCJ5zo02MtSVTN1ZSr77122Mc0NZiu0OviMbfDHzE1OFiCVb54r+yUtNyFEwUBZ0RrR/
	 mOlMsWFcCc6N4LBcr7wGesX0T5xR6SDkfgA0wWEyt/jxNWYCCUJ6twPckcVNKWE1YQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=d3tI+lsKyAfo2SvveMIf16nV49egeDWrXlEVyRU8qIQ=;
	b=YAYxY8+tdarkmkrM8un3yr1aTU2DfMrMdC8Wp9N35z20gqD+eYzcYRXZqs/IleE66DM1
	 ayxY4OsomuCyj8FUJJiAcv91HTOWUoUpXHS6gKUdncoyuKvQic6TxQy2xppNdR2rh7v8x
	 A1BBqS0FiTJzB+EdK/tg9zkv5cCUMgdcG0oXzG/fLvIUoPQapAUUFUQunlD7q6OU9tYkj
	 VRu70VWcvtTUftVeKAAcCH9D1Xp3aMMEANCeUli0LvPZ5B4nE1+rtyKHVm+B1W+wJNkPh
	 WHvpoPZdO3pRkkauY71XH/cAx8yqZILGs8wQtEgeufDBgmYm5KBXeb2X3PP0OaeSlpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVHGU9Tl;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D6606A325
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 01:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9D6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVHGU9Tl
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-843ea301d60so836954a34.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 17:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794274397; x=1794879197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d3tI+lsKyAfo2SvveMIf16nV49egeDWrXlEVyRU8qIQ=;
        b=XVHGU9TlCNvn8SAG6DT6WOXE24tSSOdY7Yd54yFIcu7jisGEApBnVZrvrHK64dCFPO
         mdfCax0KkOeN7fRgNTL3zzXk4waBuQhuPjKPkYUz+PwmPKIZBY7aRroR8HQj7ECAfyrc
         c9jbN+Ob3ehQIQNLnACmUlk71fN6mFqVMLEQkqn2FaW8e44hSLuK/6sb2o/3YvFmwAp7
         1PwvKvydQ0PodW18+InPS1Vk8+3c60dT7bjoS14XSdDRoSnxrFw5v0bJrE2u9VsnsYtc
         UWydCUPHZKyy/HkDOfNsWpoHLN3tyxOfR+aBfO7CdC8n5h0QUBbZ4kczyMBiZl/vXLsp
         cPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794274397; x=1794879197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3tI+lsKyAfo2SvveMIf16nV49egeDWrXlEVyRU8qIQ=;
        b=TgC70UCbGQRHZD/KjKSs5XCZBwsPLPp1c87C49Y9h+BMXHZmtl4IQYjfFDWv6u2ZJP
         J5oSIVUzgrQ0zuRRvmDzQFdyGG3mDZgnUO1Kinqkcf9nXvY+D2ynL7vhvZvgQpWgb1oE
         M6VAkzzfeRFbkfSOwZWm3xv4Aif4KY2l97ijASsMeHsZC4KVP/J3Q7cihiqPxenOxBfV
         +FqmwYVoXOg2yAE7bsou6GxAarGreOK3/fQscB/v3TSXcSS5R0a8Tz7wKpuBtc6zDLTp
         MKL4bLPjv04tP9DCIq19qrSeNJHi1tyuOMU+0v/WQRUQ0QenCFONqkFWeh6wXGu8IDev
         Bosw==
X-Forwarded-Encrypted: i=1; AL+hErE54cKr8DLlmIDImFI9uuDR4JjBLc+3BREGfggu9EQdSm00SvFGUEYybalKuzqKuPtZIM9Gg7sXqFHKjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+I2sB2ux/oEgRMZCMpL0MI0O1S0+iOYTwrDhKRtouexRy7Zisj
	bvIxzuDs+MpaEWrNOV085A9XvWrm0809EMuaaHJmWLD+kL3nQtyepp2E
X-Gm-Gg: AYBFou1vM7T4toN+IGz7mLBfgrMn3/cXzQco5l78b625C93QNwkQgoE4H51oZ7BISiL
	e2GSXpbAqHB/AwiQl7zkbBIeJFkvudn4wKK5Yh/WnIk49M4wVHWHtq/ipF6tRlUwBX45eNfrV6P
	kkMcZxLYdErvf+j8JKZ7aq75kzHIlchKGSgSQsTddQaGxfeqg95nLXYvZQoEV1ZuljM0xUcZrcW
	6ouB4S/17xBPMZVIqXlIG1ZRZnaScaCfaL2OhOL1PKryiWoQdnX2GCFGUVjXG9Jzhi/ZCnpfFrG
	jv4raU1PpVtvEDT9luQH4tvoffbwzPhdu2ln64+CIwBgQh/Z2Wydj2mQA4sqkO6d4vyMfKzgqYH
	rPT9RoExkKl6+UVRNvk8/UtG5nWG19wrcZIARTet4mHflXqs5LpIcwMhRRHhG4QrShGDDqbjbsg
	wxJii8POX6F42KedCrGlhA9X3j22SU/ZjSXfQL6GwiYu/U1vvekVSBINFTosSlRrvVwtK4VkpKf
	qU3OmgfAZ5GSdx7bsX18cxIUJv57+HMJV489eMiJqAj4SbSkLDsDm8RMHM919oQgjXXzb1cgtBS
	ALKUQR5V3hFGgEzmcY0WYC6VBJRUKgaxL8H1HYW+1kV/BRVeD5+oSUEFt9bTsGDWZulSzDSE1Sr
	5KYDn6iyv6cE4tRJQMcs6788r8QrN12A=
X-Received: by 2002:a05:6808:2216:b0:4d6:90f4:48b1 with SMTP id 5614622812f47-5683cd641efmr969958b6e.51.1794274397045;
        Mon, 09 Nov 2026 17:33:17 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504e7dasm802773b6e.5.2026.11.09.17.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:33:16 -0800 (PST)
Date: Mon, 9 Nov 2026 19:33:10 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: propagate recovery worker failures
Message-ID: <avJ0Vn9G7XhZv-XL@fedora-laptop>
References: <202611092358134332uegNg75loROSwL53Em6A@zte.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202611092358134332uegNg75loROSwL53Em6A@zte.com.cn>

On Mon, Nov 09, 2026 at 11:58:13PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> The recovery tests update ERR_CODE in background subshells and use wait
> without PIDs. A worker can report a failure while the parent still prints
> PASS and exits with zero. Calling _show_result() from a failed worker also
> removes shared backing files while other workers may still be using them.
> 
> Wait for each recorded worker PID and aggregate its status in the parent,
> keeping failures ahead of skips and preserving errors across batches.
> Return worker and device-creation errors without reporting or cleaning up
> from the child, so the parent can finish waiting before shared cleanup.
> 
> Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
> Fixes: 533c87e2ed74 ("selftests: ublk: add test for UBLK_F_QUIESCE")
> Fixes: 63276182c513 ("selftests: ublk: add user copy test cases")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on native x86_64 Bash 5.2 with the recovery scripts and common
> helpers from the unpatched and patched trees. Device and I/O operations
> were replaced by test-only stubs. Single-worker failures at every launch

Please run the real tests next time, it just needs one kernel with
ublk enabled, and stubs can't cover what the tests are supposed to
verify.

> position, multiple failures, skips, signal termination and device-creation
> errors no longer produce a final PASS or a zero exit status. Successful
> runs still pass, and cleanup follows all worker exits. Prerequisite skips
> still exit before preparation. The 71 scenarios passed their expected
> checks on each tree. This does not exercise real ublk devices or I/O.
> 
>  tools/testing/selftests/ublk/test_common.sh   | 23 +++++++++++++++++--
>  .../testing/selftests/ublk/test_recover_01.sh | 20 ++++++++++++----
>  .../testing/selftests/ublk/test_recover_02.sh | 20 ++++++++++++----
>  .../testing/selftests/ublk/test_recover_03.sh | 20 ++++++++++++----
>  .../testing/selftests/ublk/test_recover_04.sh | 14 ++++++++---
>  5 files changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
> index af2ea4fa1..c5adb4d29 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -379,6 +379,26 @@ run_io_and_kill_daemon()
>  	fi
>  }
>  
> +# Collect recovery workers in the parent before removing shared backing files.
> +_wait_recovery_tests()
> +{
> +	local pid
> +	local ret
> +
> +	for pid in "$@"; do
> +		if wait "$pid"; then
> +			continue
> +		else
> +			ret=$?
> +		fi

Nit: the above can be simplified as:

		wait "$pid" && continue
		ret=$?

Not a big deal.

BTW, test_stress_*.sh have the same issue (ERR_CODE set in background
worker + bare 'wait'), which may be handled in a follow-up.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks, 
Ming
