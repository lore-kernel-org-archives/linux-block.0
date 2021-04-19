Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11621C43460
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57EC610CC
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 08:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhDSIGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 04:06:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238092AbhDSIGv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 04:06:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9A59AEB3;
        Mon, 19 Apr 2021 08:06:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A4B971F2C6A; Mon, 19 Apr 2021 10:06:21 +0200 (CEST)
Date:   Mon, 19 Apr 2021 10:06:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] blkparse: Print time when trace was started
Message-ID: <20210419080621.GA8237@quack2.suse.cz>
References: <20210113112643.12893-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113112643.12893-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 13-01-21 12:26:43, Jan Kara wrote:
> For correlating blktrace data with other information, it is useful to
> know when the trace has been captured. Since the absolute timestamp
> is contained in the blktrace file, just output it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Ping Jens, can you please merge this blktrace patch? Thanks!

								Honza

> ---
>  blkparse.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/blkparse.c b/blkparse.c
> index 911309e26a15..dc518632ebf5 100644
> --- a/blkparse.c
> +++ b/blkparse.c
> @@ -31,6 +31,7 @@
>  #include <signal.h>
>  #include <locale.h>
>  #include <libgen.h>
> +#include <time.h>
>  
>  #include "blktrace.h"
>  #include "rbtree.h"
> @@ -2797,6 +2798,7 @@ static void show_stats(void)
>  
>  	if (per_device_and_cpu_stats)
>  		show_device_and_cpu_stats();
> +	fprintf(ofp, "Trace started at %s\n", ctime(&abs_start_time.tv_sec));
>  
>  	fflush(ofp);
>  }
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
