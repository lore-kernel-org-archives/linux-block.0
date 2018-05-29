Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:60374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966957AbeE2WHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 May 2018 18:07:09 -0400
Subject: Re: [PATCH 12/13] block: introduce blk-iolatency io controller
To: Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-13-josef@toxicpanda.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <99a187c9-668b-d27c-3d71-bc799b853791@infradead.org>
Date: Tue, 29 May 2018 15:07:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180529211724.4531-13-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/29/2018 02:17 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  block/Kconfig             |  12 +
>  block/Makefile            |   1 +
>  block/blk-iolatency.c     | 844 ++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-sysfs.c         |   2 +
>  block/blk.h               |   6 +
>  include/linux/blk_types.h |   2 -
>  6 files changed, 865 insertions(+), 2 deletions(-)
>  create mode 100644 block/blk-iolatency.c
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 28ec55752b68..a4e800f57688 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -149,6 +149,18 @@ config BLK_WBT
>  	dynamically on an algorithm loosely based on CoDel, factoring in
>  	the realtime performance of the disk.
>  
> +config BLK_CGROUP_IOLATENCY
> +	bool "Enable support for latency based cgroup io protection"

	                                              IO protection"

There are currently no occurrences of "io" (standalone) in block/Kconfig
and it would be a bad precedent to add one, so please use that shift key. :)

> +	depends on BLK_CGROUP=y
> +	default n
> +	---help---
> +	Enabling this option enables the .latency interface for io throttling.
> +	The io controller will attempt to maintain average io latencies below
> +	the configured latency target, throttling anybody with a higher latency
> +	target than the victimized group.
> +
> +	Note, this is an experimental interface and could be changed someday.
> +
>  config BLK_WBT_SQ
>  	bool "Single queue writeback throttling"
>  	default n

-- 
~Randy
