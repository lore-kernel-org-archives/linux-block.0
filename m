Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:49009 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLLHPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 02:15:31 -0500
Subject: Re: [PATCH] locking/lockdep: Make CONFIG_LOCKDEP_CROSSRELEASE and
 CONFIG_LOCKDEP_COMPLETIONS optional
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com, david@fromorbit.com, tytso@mit.edu,
        willy@infradead.org, torvalds@linux-foundation.org,
        Amir Goldstein <amir73il@gmail.com>
References: <1513062681-5995-1-git-send-email-byungchul.park@lge.com>
Message-ID: <55a0928a-4b62-70f8-577d-a63a21199279@lge.com>
Date: Tue, 12 Dec 2017 16:15:28 +0900
MIME-Version: 1.0
In-Reply-To: <1513062681-5995-1-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

+cc david@fromorbit.com
+cc tytso@mit.edu
+cc willy@infradead.org
+cc torvalds@linux-foundation.org
+cc amir73il@gmail.com

On 12/12/2017 4:11 PM, Byungchul Park wrote:
> At the moment, it's rather premature to enable
> CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS by default,
> because we face a lot of false positives for now since all locks and
> waiters are not classified properly yet.
> 
> Until most of them get annotated properly, it'd be better to be optional.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>   lib/Kconfig.debug | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2689b7c..bc099f1 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1092,8 +1092,6 @@ config PROVE_LOCKING
>   	select DEBUG_MUTEXES
>   	select DEBUG_RT_MUTEXES if RT_MUTEXES
>   	select DEBUG_LOCK_ALLOC
> -	select LOCKDEP_CROSSRELEASE
> -	select LOCKDEP_COMPLETIONS
>   	select TRACE_IRQFLAGS
>   	default n
>   	help
> @@ -1164,7 +1162,9 @@ config LOCK_STAT
>   	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
>   
>   config LOCKDEP_CROSSRELEASE
> -	bool
> +	bool "Lock debugging: enable cross-locking checks in lockdep"
> +	depends on PROVE_LOCKING
> +	default n
>   	help
>   	 This makes lockdep work for crosslock which is a lock allowed to
>   	 be released in a different context from the acquisition context.
> @@ -1174,7 +1174,10 @@ config LOCKDEP_CROSSRELEASE
>   	 detector, lockdep.
>   
>   config LOCKDEP_COMPLETIONS
> -	bool
> +	bool "Lock debugging: allow completions to use deadlock detector"
> +	depends on PROVE_LOCKING
> +	select LOCKDEP_CROSSRELEASE
> +	default n
>   	help
>   	 A deadlock caused by wait_for_completion() and complete() can be
>   	 detected by lockdep using crossrelease feature.
> 

-- 
Thanks,
Byungchul
