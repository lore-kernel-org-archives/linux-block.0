Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5FCC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 06:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiAJGU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 01:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbiAJGUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 01:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641795653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4UJGQxN4llUmBgJPrZBfXyF/mKlQ560GlFfyJVtdhC4=;
        b=ZH3951dQMs9qeqAyFk1nUM60kQsJAEQif6hUdDgqIgRa6KIqkrY682MC4Xhn8J7V8XHRUN
        aIBp2S+9yRysEsMFzriEStWpPyTOsdJF40OI5oZ5t2mhfD+HEtRW7rW9SPaZp1uc7zCJI7
        9ck8NXk1L+xUjDbUO39/PEnrXitPP+o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-ti7AUWZnN6G56gCUHtf8aw-1; Mon, 10 Jan 2022 01:20:51 -0500
X-MC-Unique: ti7AUWZnN6G56gCUHtf8aw-1
Received: by mail-ed1-f72.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so9273925edb.4
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 22:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UJGQxN4llUmBgJPrZBfXyF/mKlQ560GlFfyJVtdhC4=;
        b=GBPP+hBE9YFB+5M471zwh5o7/+lAWqI/MyhU7+tHYclL6mBoCzVOSjcBx77esDpDPJ
         1503h89j9yno6kocxd+g5/MdTg9iEVzIIkUlO0P5cM/3vAs9EJfWV+D8Aj28Citomfw2
         uLVZxNt4iZfg8nRZEeiamp1QxbrF7OtN17kkk8O9C10xjSLh/tISwpMbj4f7XoRbRFxM
         qO7dY48lUN90P0GLYno+1WNyFn5N+fmg8PcTN0bDzU1hlllSC+L0ol3l00QbNE8uQjzv
         oXYmYSM+JckylKSd9yXpHpckJs1QJbYidB1w1XBL1ccB9WBLPPGuuYiM/smY52KQ2FYm
         UPyw==
X-Gm-Message-State: AOAM532Qgkd00oGrSKcc7nMJ2NKTCwYWixrdtgjRjT11MaIgcbCMWvAl
        FmiBONpKREKHnRAYy3uYQUqDa4h0flevD2mMsiJhUiw2/y6jcfHDk14Y+0SZlByPHj7lcpPvhw4
        NMWwKcPPV4gLhf1eNZRxmrjuoexYx12JA8aY+sOU=
X-Received: by 2002:a17:906:5d01:: with SMTP id g1mr57520301ejt.219.1641795650530;
        Sun, 09 Jan 2022 22:20:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHKP8/xjNW4WyuXNqZMO1X/n21owYLDUnRvikz9y+BzXAsQLDT5sBIwn6BHfp1ZA2MwAaVLBo+tXxytMNG0Cg=
X-Received: by 2002:a17:906:5d01:: with SMTP id g1mr57520292ejt.219.1641795650302;
 Sun, 09 Jan 2022 22:20:50 -0800 (PST)
MIME-Version: 1.0
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp> <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
In-Reply-To: <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Mon, 10 Jan 2022 07:20:32 +0100
Message-ID: <CAASaF6wVsX=tkrTr6fst=7VoC1Bkr7rUQHUEr5oneyik4XLS+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 7, 2022 at 12:04 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Jan Stancek is reporting that commit 322c4293ecc58110 ("loop: make
> autoclear operation asynchronous") broke LTP tests which run /bin/mount
> and /bin/umount in close succession like
>
>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
>
> . This is because since /usr/lib/systemd/systemd-udevd asynchronously
> opens the loop device which /bin/mount and /bin/umount are operating,
> autoclear from lo_release() is likely triggered by systemd-udevd than
> mount or umount. And unfortunately, /bin/mount fails if read of superblock
> (for examining filesystem type) returned an error due to the backing file
> being cleared by __loop_clr_fd(). It turned out that disk->open_mutex was
> by chance serving as a barrier for serializing "__loop_clr_fd() from
> lo_release()" and "vfs_read() after lo_open()", and we need to restore
> this barrier (without reintroducing circular locking dependency).
>
> Also, the kernel test robot is reporting that that commit broke xfstest
> which does
>
>   umount ext2 on xfs
>   umount xfs
>
> sequence.
>
> One of approaches for fixing these problems is to revert that commit and
> instead remove destroy_workqueue() from __loop_clr_fd(), for it turned out
> that we did not need to call flush_workqueue() from __loop_clr_fd() since
> blk_mq_freeze_queue() blocks until all pending "struct work_struct" are
> processed by loop_process_work(). But we are not sure whether it is safe
> to wait blk_mq_freeze_queue() etc. with disk->open_mutex held; it could
> be simply because dependency is not clear enough for fuzzers to cover and
> lockdep to detect.
>
> Therefore, before taking revert approach, let's try if we can use task
> work approach which is called without locks held while the caller can
> wait for completion of that task work before returning to user mode.
>
> This patch tries to make lo_open()/lo_release() to locklessly wait for
> __loop_clr_fd() by inserting a task work into lo_open()/lo_release() if
> possible.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Jan Stancek <jstancek@redhat.com>

v2 looked OK in my tests, thanks.

Tested-by: Jan Stancek <jstancek@redhat.com>

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v2:
>   Need to also wait on lo_open(), per Jan's testcase.
>
>  drivers/block/loop.c | 70 ++++++++++++++++++++++++++++++++++++++++----
>  drivers/block/loop.h |  5 +++-
>  2 files changed, 68 insertions(+), 7 deletions(-)
>

