Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB924C33CAF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 10:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C78224125
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 10:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWKX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:23:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37490 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAWKX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 05:23:26 -0500
Received: from [154.119.55.242] (helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tyhicks@canonical.com>)
        id 1iuZdz-0002Zb-Ck; Thu, 23 Jan 2020 10:23:24 +0000
Date:   Thu, 23 Jan 2020 12:23:17 +0200
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Stefan Bader <stefan.bader@canonical.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
Message-ID: <20200123102316.GB7611@elm>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123091713.12623-2-stefan.bader@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-01-23 11:17:13, Stefan Bader wrote:
> When device-mapper adapted for multi-queue functionality, they
> also re-organized the way the make-request function was set.
> Before, this happened when the device-mapper logical device was
> created. Now it is done once the mapping table gets loaded the
> first time (this also decides whether the block device is request
> or bio based).
> 
> However in generic_make_request(), the request function gets used
> without further checks and this happens if one tries to mount such
> a partially set up device.
> 
> This can easily be reproduced with the following steps:
>  - dmsetup create -n test
>  - mount /dev/dm-<#> /mnt
> 
> This maybe is something which also should be fixed up in device-
> mapper. But given there is already a check for an unset queue
> pointer and potentially there could be other drivers which do or
> might do the same, it sounds like a good move to add another check
> to generic_make_request_checks() and to bail out if the request
> function has not been set, yet.
> 
> BugLink: https://bugs.launchpad.net/bugs/1860231
> Fixes: ff36ab34583a ("dm: remove request-based logic from make_request_fn wrapper")
> Signed-off-by: Stefan Bader <stefan.bader@canonical.com>

I helped debug the crash with Stefan and I think this is the most
straightforward fix (and is trivial to backport for stable kernels). I
looked at delaying the queue allocation in the dm code until the table
load ioctl but I decided that was risky and doesn't help the general
case of preventing other subsystems from making this same mistake.

Tested-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

Tyler

> ---
>  block/blk-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1075aaff606d..adcd042edd2d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -884,6 +884,13 @@ generic_make_request_checks(struct bio *bio)
>  			bio_devname(bio, b), (long long)bio->bi_iter.bi_sector);
>  		goto end_io;
>  	}
> +	if (unlikely(!q->make_request_fn)) {
> +		printk(KERN_ERR
> +		       "generic_make_request: Trying to access "
> +		       "block-device without request function: %s\n",
> +		       bio_devname(bio, b));
> +		goto end_io;
> +	}
>  
>  	/*
>  	 * Non-mq queues do not honor REQ_NOWAIT, so complete a bio
> -- 
> 2.17.1
> 
