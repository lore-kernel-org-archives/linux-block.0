Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71470387378;
	Fri, 28 Aug 2026 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887569; cv=none; b=sOfhLH39hiOliEySBCuC5oxv8m0MBnsO/Wmiql3c0eXVPw7wskoQWiHOS6HDiIFG9Qmec/NJQJx8dfA5WLq5Q/S5Jp1359DUihZatQ9adJ7eawC4RNdkqtJ1+AJFLa8tZy05DRbssXUG1Z2nDvCh+zR3i0LpEJCgpDTdv12nvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887569; c=relaxed/simple;
	bh=If6pFuI6QDQHA0hFfA38OqT4ci3nl2lGKZkVIxxUHFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h1Y1JSFc972G4nPbGL3yjXFCM4oELSaFNm4Mjc/zryhmQtNZWoJRaTmsRtP2ENxHsk/J3j805ipPRZxYJplxknd0HMMuaXqqpDK3pRIsRhdHtq8E8ziW6WYbv5ozl2VviirxBS9MZ8gXnlfIA9y/fFT6Pm2pGEsbXeeLoNjKy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PvU3CQ++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PvU3CQ++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9A21F000E9;
	Fri, 28 Aug 2026 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787887567;
	bh=II1URtKtPgW2aBnP2LnNfS7g5Xg8tEyvHqFapSYpJx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PvU3CQ++Qk4XMymJjAGZeEkfkCXtconpx83jMCKRI1hL0JlGRGyt0io0ASr91sd5V
	 J5UFAeLSoZbl3UPWm1EHZKcoVkL0PuM5Bgojx5VjcUB15+oWZOF5vkFdUlTZcr+Bnx
	 FnU599q5+LrB7mA7KOMcv7fou5CUrXN71aRFv75c=
Date: Thu, 27 Aug 2026 20:26:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Hao Jia
 <jiahao1@lixiang.com>
Subject: Re: [PATCH] zram: fix idle age_sec underflow in idle_store()
Message-Id: <20260827202607.3845123c74f438f8d2951a4d@linux-foundation.org>
In-Reply-To: <20260825092316.69658-1-jiahao.kernel@gmail.com>
References: <20260825092316.69658-1-jiahao.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 17:23:16 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:

> From: Hao Jia <jiahao1@lixiang.com>
> 
> After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
> idle_store() computes the idle cutoff as follows:
> 
> 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
> 
> Because the left operand is cast to a 32-bit unsigned integer, when
> age_sec exceeds the current uptime, the subtraction wraps modulo 2^32
> and the huge result is zero-extended into the s64 cutoff.  mark_idle()
> subsequently marks every entry as idle instead of matching nothing,
> breaking the intended semantics of /sys/block/zramX/idle.  For instance,
> running echo 86400 > idle on a machine up for only two minutes causes
> all newly written pages to be marked as idle and handed over to idle
> writeback and recompression.
> 
> Drop the explicit cast to perform the subtraction in signed arithmetic
> again, restoring the previous behavior: an age_sec greater than uptime
> yields a negative cutoff, and one equal to uptime yields 0. Since a
> cutoff of 0 is now a valid computed value, it can no longer double as
> the "all" sentinel. Switch to KTIME_MIN instead, which no ac_time can
> be after.

whoops.

> Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")

Thanks, I'll add cc:stable@vger.kernel.org to this and shall queue it,
pending additional review.


