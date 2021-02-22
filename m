Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCE5C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F36864E21
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBVXDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhBVXDi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 18:03:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF2964E07;
        Mon, 22 Feb 2021 23:02:56 +0000 (UTC)
Date:   Mon, 22 Feb 2021 18:02:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     axboe@kernel.dk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: remove debugfs file dentries from struct
 blk_trace
Message-ID: <20210222180255.1b117616@gandalf.local.home>
In-Reply-To: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
References: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

I guess this goes through your tree.

I'm pinging you in case you did what I did, and confused this patch as one
of Greg's stable patches (which I almost archived as such)!

No, this is an actual update from Greg, not a patch that was backported.

-- Steve

On Tue, 16 Feb 2021 16:52:47 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> These debugfs dentries do not need to be saved for anything as the whole
> directory and everything in it is properly cleaned up when the parent
> directory is removed.  So remove them from struct blk_trace and don't
> save them when created as it's not necessary.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/blktrace_api.h | 2 --
>  kernel/trace/blktrace.c      | 8 ++------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index 05556573b896..79979d33c140 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -23,8 +23,6 @@ struct blk_trace {
>  	u32 pid;
>  	u32 dev;
>  	struct dentry *dir;
> -	struct dentry *dropped_file;
> -	struct dentry *msg_file;
>  	struct list_head running_list;
>  	atomic_t dropped;
>  };
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index fb0fe4c66b84..67c730f0b6ef 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -311,8 +311,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>  
>  static void blk_trace_free(struct blk_trace *bt)
>  {
> -	debugfs_remove(bt->msg_file);
> -	debugfs_remove(bt->dropped_file);
>  	relay_close(bt->rchan);
>  	debugfs_remove(bt->dir);
>  	free_percpu(bt->sequence);
> @@ -544,10 +542,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	INIT_LIST_HEAD(&bt->running_list);
>  
>  	ret = -EIO;
> -	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> -					       &blk_dropped_fops);
> -
> -	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> +	debugfs_create_file("dropped", 0444, dir, bt, &blk_dropped_fops);
> +	debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
>  
>  	bt->rchan = relay_open("trace", dir, buts->buf_size,
>  				buts->buf_nr, &blk_relay_callbacks, bt);

