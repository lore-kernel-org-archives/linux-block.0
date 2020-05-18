Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072B0C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 03:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D399E20715
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 03:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcjbIzLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgERDzM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 23:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgERDzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 23:55:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B466C061A0C;
        Sun, 17 May 2020 20:55:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so7970870wrx.3;
        Sun, 17 May 2020 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+ioUsr3C9wFKdQ6xauhHXnALW1yh7UmY5k+3vfdYmA=;
        b=PcjbIzLzaBQ9JrFFfxMKyULVMVL9AP5DXNie92cQSqVhlNQu6SzNtbNa8BRyrAPiY8
         d/NGAtPW1ig9UKVfrbkJSZ+m7MSZazjq31htI3S8rape4tFuC4/+n99On0cHIMAKLJXB
         s5P/pjnXlLaSgg7NExZyRzjM1PO4R/IwfUbXsPmg56ZM9C5yfD7acSOFHXBwfpqUluf9
         xsHcK2jWUvXk3SePNX8qaPsN8EW6rlGvyDSDdW4Ul3tBabfrh5GdP5cRGNEMzSkZAD4d
         GJVEFqIggWL2PTX4L0Y7il5qG4mo5aMmQfch7MKxli6zHAgvxbQkVTvS1ahvFWYXKlDM
         XuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+ioUsr3C9wFKdQ6xauhHXnALW1yh7UmY5k+3vfdYmA=;
        b=b4F5Aqgid3tG+CD1R6lWmMMNWkPg1sZkq8Kx7ftnwXwjdUndrW+UO2G1qvAKUqt0bV
         7V9VW7GXaFtlBC3ovOOl01LfQYsqa2GOYX9AAas7MepwqTww3YC5nvvqjG9ULHQlem/Z
         O+qbKcNB3CIjfmoeu2bUfqRvCxSd5NN9qgkL0WJDNnUU03W/c6VDPyYz8aU4MNa0MokV
         MGSnZ7SsgewPO/ZKCdx7n/FJxg/tNZ0gWw8O0YrRmJt4+1d0ciYYfxg89oKfK5JyaxCp
         asn8s+dwq1cPrDejZhI0KsaEQu/+n9L4Za+1EOrKb8uDq66apnhuzlsotVI7cADPwim/
         CY4g==
X-Gm-Message-State: AOAM532f5/bb4t8sbFx7PQFXBdIggXbQTG3A7jk4aa+rtVJxDcfYB07Z
        r3gzlc6Rkh1pGlZAeFufc43iT2sgkHYCjVdP4fM=
X-Google-Smtp-Source: ABdhPJx8umEEW2sRX1xwtQOKzcDv0QEMz3+P8xKy7FmtI9Jb7gKrjiZCTYMLAxH4p9DJDJYi3qWN1+Gr6/K4RvrgCt4=
X-Received: by 2002:adf:ea05:: with SMTP id q5mr16619703wrm.87.1589774109214;
 Sun, 17 May 2020 20:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
In-Reply-To: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 18 May 2020 11:54:58 +0800
Message-ID: <CACVXFVMy_2QF0zY2LdgF85e=9qVLozLSLyOrhyB0NFvkEWmi3g@mail.gmail.com>
Subject: Re: [PATCH] block: Remove unused flush_queue_delayed in struct blk_flush_queue
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 17, 2020 at 7:51 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The flush_queue_delayed was introdued to hold queue if flush is
> running for non-queueable flush drive by commit 3ac0cc450870
> ("hold queue if flush is running for non-queueable flush drive"),
> but the non mq parts of the flush code had been removed by
> commit 7e992f847a08 ("block: remove non mq parts from the flush code"),
> as well as removing the usage of the flush_queue_delayed flag.
> Thus remove the unused flush_queue_delayed flag.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  block/blk-flush.c | 1 -
>  block/blk.h       | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index c7f396e3d5e2..b733f7ac75c7 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -258,7 +258,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>                 blk_flush_complete_seq(rq, fq, seq, error);
>         }
>
> -       fq->flush_queue_delayed = 0;
>         spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>  }
>
> diff --git a/block/blk.h b/block/blk.h
> index fc00537026a0..6cab33a11f90 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -19,7 +19,6 @@ extern struct dentry *blk_debugfs_root;
>  #endif
>
>  struct blk_flush_queue {
> -       unsigned int            flush_queue_delayed:1;
>         unsigned int            flush_pending_idx:1;
>         unsigned int            flush_running_idx:1;
>         blk_status_t            rq_status;
> --
> 2.17.1
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
