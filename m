Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB3C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9571A20821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV0Qdu/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfAIDHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:07:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAIDHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 22:07:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so6096782wrt.13
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 19:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmHJmSGQF9qRCyO0l54bRywO36lCwl/wYEo9L5ldb/E=;
        b=uV0Qdu/4tUBJqfd0MDKQXeZ9FU2VMW44d8nN1eAtAzcq/gIjxauKkjXcA50LgZd/px
         1J5u2Df8wYeQbXukbDbsoyJfXg6JSXZubuxzhPG4ZgWMeBe5KvycNK73MgWcKZ+tFNyc
         lkqh+T0rUkRvEYP+bRKiEY8E3HBEEU+L8J1qAx8ZvfOogOxiDFhufiS9BupUr7e4Iyeh
         FIuxWwmt8lxcTwmTorGsvrqzfPS/mDL7GhmGwPGcEB3T9Zl6VtFvDo1bREEYP23yJ3+l
         IBLAo9JKjcPh0Z3tWdpaVCUjvES1PsvMiRdH+xWTm4F75X837PgS4hE+7xwmzLGI2LaF
         lNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmHJmSGQF9qRCyO0l54bRywO36lCwl/wYEo9L5ldb/E=;
        b=jYP/DhVhwvqW8PaCZtAvRClgxxvWXfcOrmKdJdl8Rt9G2o5UVWn4OnasQYxnDJX7DQ
         NhBYVOpXNv31ysHyQAZcqozUQ8oTPtBbHMRNm8Pf0DOV1oaG0yFunKFzqDQ+FSa0b6dt
         TlNop9EtdLKcNX87VMCiHX4pjD7S0QiwZMZOfqP1K7NGlDaX0WsAidU7EOrJOTr0th/a
         ocCwCswowf6q/afJdWswwTtQPwwI2x0yYPXGE+5bunzs/iXzgoD5ecotPah1Ga9i1DZl
         Wvzocebux/0kc5rG+tzhu51J7kkOjQ0cJYeAnLpU9UfFkFSMxiXmpwQMvz7qoCJ4uVo3
         RDuQ==
X-Gm-Message-State: AJcUukdYgQCeZ2Lb4XfiuCvS6sZSMmGmCYYAqhJP5NbsFrSUTend5cW2
        NCifL5xWd4W7ErT2bZoOTpIlQ6KEVfMTAdsZySj9D3kq
X-Google-Smtp-Source: ALg8bN4Tr6qKxF+mkaw74CC0S739UwnqgQ4HoWnYeLnOZSa9iTvfl0GNMUgc6VEx8hTk3G3wVE9GcbGJ6H0RYqMuLpk=
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr3107679wrn.104.1547003252757;
 Tue, 08 Jan 2019 19:07:32 -0800 (PST)
MIME-Version: 1.0
References: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 9 Jan 2019 11:07:20 +0800
Message-ID: <CACVXFVOEdHAnm9h-CywX1sgW=wc+PDLcttn9OFhL9eVpRiDEuA@mail.gmail.com>
Subject: Re: [patch] block: clarify documentation for blk_{start|finish}_plug
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 9, 2019 at 5:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> There was some confusion about what these functions did.  Make it clear
> that this is a hint for upper layers to pass to the block layer, and
> that it does not guarantee that I/O will not be submitted between a
> start and finish plug.
>
> Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c78042975737..f2732f106a2e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1683,6 +1683,15 @@ EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
>   * @plug:      The &struct blk_plug that needs to be initialized
>   *
>   * Description:
> + *   blk_start_plug() indicates to the block layer an intent by the caller
> + *   to submit multiple I/O requests in a batch.  The block layer may use
> + *   this hint to defer submitting I/Os from the caller until blk_finish_plug()
> + *   is called.  However, the block layer may choose to submit requests
> + *   before a call to blk_finish_plug() if the number of queued I/Os
> + *   exceeds %BLK_MAX_REQUEST_COUNT, or if the size of the I/O is larger than
> + *   %BLK_PLUG_FLUSH_SIZE.  The queued I/Os may also be submitted early if
> + *   the task schedules (see below).
> + *
>   *   Tracking blk_plug inside the task_struct will help with auto-flushing the
>   *   pending I/O should the task end up blocking between blk_start_plug() and
>   *   blk_finish_plug(). This is important from a performance perspective, but
> @@ -1765,6 +1774,16 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>                 blk_mq_flush_plug_list(plug, from_schedule);
>  }
>
> +/**
> + * blk_finish_plug - mark the end of a batch of submitted I/O
> + * @plug:      The &struct blk_plug passed to blk_start_plug()
> + *
> + * Description:
> + * Indicate that a batch of I/O submissions is complete.  This function
> + * must be paired with an initial call to blk_start_plug().  The intent
> + * is to allow the block layer to optimize I/O submission.  See the
> + * documentation for blk_start_plug() for more information.
> + */
>  void blk_finish_plug(struct blk_plug *plug)
>  {
>         if (plug != current->plug)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
