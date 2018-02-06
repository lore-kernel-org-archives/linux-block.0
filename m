Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44767 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeBFT1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Feb 2018 14:27:34 -0500
Received: by mail-pf0-f193.google.com with SMTP id 17so1054713pfw.11
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2018 11:27:34 -0800 (PST)
Date: Tue, 6 Feb 2018 11:27:32 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Howard McLauchlan <hmclauchlan@fb.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] block: Add should_fail_bio() for bpf error injection
Message-ID: <20180206192732.GA16027@vader.DHCP.thefacebook.com>
References: <20180124232258.17164-1-hmclauchlan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180124232258.17164-1-hmclauchlan@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 24, 2018 at 03:22:58PM -0800, Howard McLauchlan wrote:
> The classic error injection mechanism, should_fail_request() does not
> support use cases where more information is required (from the entire
> struct bio, for example).
> 
> To that end, this patch introduces should_fail_bio(), which calls
> should_fail_request() under the hood but provides a convenient
> place for kprobes to hook into if they require the entire struct bio.
> This patch also replaces some existing calls to should_fail_request()
> with should_fail_bio() with no degradation in performance.

Reviewed-by: Omar Sandoval <osandov@fb.com>

Jens, can we pick this up for 4.16? The necessary BPF support has been
merged into Linus' tree.

> Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
> ---
>  block/blk-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b8881750a3ac..5e73c996d338 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/blk-cgroup.h>
>  #include <linux/debugfs.h>
> +#include <linux/bpf.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/block.h>
> @@ -2050,6 +2051,12 @@ static inline bool should_fail_request(struct hd_struct *part,
>  
>  #endif /* CONFIG_FAIL_MAKE_REQUEST */
>  
> +static noinline bool should_fail_bio(struct bio *bio)
> +{
> +	return should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size);
> +}
> +BPF_ALLOW_ERROR_INJECTION(should_fail_bio);
> +
>  /*
>   * Remap block n of partition p to block n+start(p) of the disk.
>   */
> @@ -2141,7 +2148,7 @@ generic_make_request_checks(struct bio *bio)
>  	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
>  		goto not_supported;
>  
> -	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
> +	if (should_fail_bio(bio))
>  		goto end_io;
>  
>  	if (blk_partition_remap(bio))
> -- 
> 2.14.1
> 
