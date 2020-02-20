Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE4C11D05
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3795D2068F
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2zhQlP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBTOnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:43:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40415 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTOnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 09:43:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so27736858oii.7
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFW2KjG5+75TiWLh4iQzgFS8bAb/Lc6z+obLCDWHWtw=;
        b=a2zhQlP5MSjYqUuxCpz+AjQFDBRDFUZcYkbGwxXaDI345uFLK9EJ284IAwmFlYR4PN
         n5wOGNy/HSp/XfbdfCVB22ZUnPABdWAy5dkOwiDHnUbeVhJFSRD6csiqGRxmpeIhz5/9
         pCwmbmrkxtzuo1b+3icRjhlDUC6JaG1sG5eD8FLgam3EbFanH8H1XyKbbopmFp0S636x
         09QvtSb49jYS3nRzLOIVC08HgJYzjLuKPdnLt2kugo6duO+X9eqL/1mhzyspJXyZdEfF
         kFvNbaNZYpevkHPB0Wlk7IaSf6NaM/02ht0qSHHhj/bOubBQXKzwMla27pBVJ5SJMhes
         TbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFW2KjG5+75TiWLh4iQzgFS8bAb/Lc6z+obLCDWHWtw=;
        b=Iy36OGkVV0Q+80U1buY7gxPJ5IkJzOQWbz46XDySr33kuALlSaKGymrQU0TIgcKrIf
         mzymRDRV+473lZlG0Vt3D+vu7ttvdQFQlZvkwtomabCBQWdtNNh0SRf2f4gLsQ2mSblT
         cZOB8ML1b+uPclX/+7h8TZl52cRdF8k3BqdOVANzCwKtUFpXGWWliqQ8IRAcoZQf3km6
         xs5tTeZ4BdvdQqieR09ALnKMWpBLjvZPdB+ZxvHBts/Z/i1x/uFVKXwK8GumgUTwt+zJ
         7beSl+QrbHJlrzKZYHlIELwp+tZNfAwWhJ2e0m7pxUdBeqb4i9QfZW0rAXOaAvblluKj
         K8xg==
X-Gm-Message-State: APjAAAUYkUG5uO/1JXiiTODgy4xWfgysffpKZ9mwxar5qzCt9CsBzCiX
        4Etwz6hVcYwfjbib8tRdoCh2nvITFUr8Ryy0/PpH2A==
X-Google-Smtp-Source: APXvYqzwqsWtqU9lPmBXLgV4AuSMePUHHTI+bRljxUl6NSOsbJ0rAP0pZG1JJbUaMBSTyM2ScPicJ7ge6k3kbgdFHMc=
X-Received: by 2002:aca:b80a:: with SMTP id i10mr2180881oif.106.1582209793296;
 Thu, 20 Feb 2020 06:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20200220120527.15082-1-ming.lei@redhat.com>
In-Reply-To: <20200220120527.15082-1-ming.lei@redhat.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 20 Feb 2020 07:43:01 -0700
Message-ID: <CAJmaN=kZrE7FNPd3Fv4nxc1qYhGo=V3uZA-zyPxzqRYq6KABrg@mail.gmail.com>
Subject: Re: [PATCH] block: Prevent hung_check firing during long sync IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Salman Qazi <sqazi@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yeah looks good.

Reviewed-by: Jesse Barnes <jsbarnes@google.com>

A further change (just for readability) might be to factor out these
"don't trigger hangcheck" waits from here and blk_execute_rq() into a
small helper with a descriptive name.

Thanks,
Jesse

On Thu, Feb 20, 2020 at 5:05 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> submit_bio_wait() can be called from ioctl(BLKSECDISCARD), which
> may take long time to complete, as Salman mentioned, 4K BLKSECDISCARD
> takes up to 100 second on some devices. Also any block I/O operation
> that occurs after the BLKSECDISCARD is submitted will also potentially
> be affected by the hung task timeouts.
>
> So prevent hung_check from firing by taking same approach used
> in blk_execute_rq(), and the wake-up interval is set as half the
> hung_check timer period, which keeps overhead low enough.
>
> Cc: Salman Qazi <sqazi@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Link: https://lkml.org/lkml/2020/2/12/1193
> Reported-by: Salman Qazi <sqazi@google.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 94d697217887..c9ce19a86de7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -17,6 +17,7 @@
>  #include <linux/cgroup.h>
>  #include <linux/blk-cgroup.h>
>  #include <linux/highmem.h>
> +#include <linux/sched/sysctl.h>
>
>  #include <trace/events/block.h>
>  #include "blk.h"
> @@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
>  int submit_bio_wait(struct bio *bio)
>  {
>         DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> +       unsigned long hang_check;
>
>         bio->bi_private = &done;
>         bio->bi_end_io = submit_bio_wait_endio;
>         bio->bi_opf |= REQ_SYNC;
>         submit_bio(bio);
> -       wait_for_completion_io(&done);
> +
> +       /* Prevent hang_check timer from firing at us during very long I/O */
> +       hang_check = sysctl_hung_task_timeout_secs;
> +       if (hang_check)
> +               while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> +       else
> +               wait_for_completion_io(&done);
>
>         return blk_status_to_errno(bio->bi_status);
>  }
> --
> 2.20.1
>
