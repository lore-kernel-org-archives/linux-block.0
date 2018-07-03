Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jul 2018 15:32:18 -0400
Subject: Re: [PATCH 12/14] block: introduce blk-iolatency io controller
To: Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-13-josef@toxicpanda.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e1f98f78-bf01-272f-3121-02612d01d57e@infradead.org>
Date: Tue, 3 Jul 2018 12:32:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-13-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/03/2018 08:15 AM, Josef Bacik wrote:
> diff --git a/block/Kconfig b/block/Kconfig
> index 28ec55752b68..074c6099c31f 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -149,6 +149,18 @@ config BLK_WBT
>  	dynamically on an algorithm loosely based on CoDel, factoring in
>  	the realtime performance of the disk.
>  
> +config BLK_CGROUP_IOLATENCY
> +	bool "Enable support for latency based cgroup IO protection"
> +	depends on BLK_CGROUP=y
> +	default n
> +	---help---
> +	Enabling this option enables the .latency interface for IO throttling.
> +	The IO controller will attempt to maintain average IO latencies below
> +	the configured latency target, throttling anybody with a higher latency

	Could that be:                            any process {or any task}
	I don't want to see it throttling any bodies.

> +	target than the victimized group.
> +
> +	Note, this is an experimental interface and could be changed someday.
> +
>  config BLK_WBT_SQ
>  	bool "Single queue writeback throttling"
>  	default n


-- 
~Randy
