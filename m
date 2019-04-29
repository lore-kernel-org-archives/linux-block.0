Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DDC43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 03:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8832075E
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 03:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma05KDmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfD2DnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:43:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51575 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfD2DnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 23:43:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so11929162wmf.1
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2019 20:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5DxQcFdsOlALRirpWWbo6PtJugfnv3ooJCupaQ4sw58=;
        b=ma05KDmOQ94kydmJ+p12K6zGaQ3aXiffi5E7zGkKLcea4hAO7K7tqDvfB5o2szV08v
         wHHU0X28stjQF2R4SUTvEq4FwguLvSyrXD7/NwHIPzy7HR1FypKTK/t6FJyRMshFt2kq
         DE34Pi5y59pzXlwWr+vZhOtW7Rokwj2X6amsESR8L5Y1EFEH3bIKz397D+2SliBdEOWk
         PbteciLVA3hjWP2Viptqjz6TD4Szcba6HWmPg8PnYkQtFyNwt1LjT61QiiN6ZQTdPsAz
         V34hQOjUlw109g5B/+uhZEaL+f8JfL50ICW1922EduApXmwsSnMnrdzhyszrLJAvE/RS
         gdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DxQcFdsOlALRirpWWbo6PtJugfnv3ooJCupaQ4sw58=;
        b=QXNShLUh8VHBOLQSBC0E2Npat7+ifA84kc2RRzGUttBLXiAdrOn6RSc58Jy/27Ec0/
         21nC6hPno4smft2GQkWZA3hTJk5JLUMWgBnBWSCEK6Zo0R+pzq1thV6DNLRx76qY5mGB
         J5Cl77R0c0rx5QzVKv5LwMMpfMXuEXo9np5b0ImYjnGuX44fNbqk9UzT8qM7P/O6FOdO
         oLkLtPpSGo0ZvXNQwJGVQ4pekmxWfLNgNrVNSItT5eOp47M3HaHQhcHmNZKQpddrZfBF
         kStg4aofk3Aonsi6Khv8s3102sR/Di0v8er2jlE+LZgyFAXhG+orwXgUFSkMZcUZPiET
         pyng==
X-Gm-Message-State: APjAAAXZN3Y4iWnwnHmEF8eDNcLzTRttpU9wTp+VQbzZDYqBueLjMbdY
        qmput34EIBVQWnazMI864q/eoUb9zPfXeYJoyMs=
X-Google-Smtp-Source: APXvYqzT/FABpQ20HmAOuB46HAee/qY+sKz8tXt/IpCP3A5USfZwKJNLfO0HFV+Iom2TXFfso71KC1o7vaS22uK48Fw=
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr16345954wme.67.1556509382820;
 Sun, 28 Apr 2019 20:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190425102846.28911-1-bob.liu@oracle.com>
In-Reply-To: <20190425102846.28911-1-bob.liu@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 29 Apr 2019 11:42:50 +0800
Message-ID: <CACVXFVN04jHhLxXL5_RTo9TwQx9JXgGW6rmjsEEREXZ3O=hR8A@mail.gmail.com>
Subject: Re: [PATCH v4] blk-mq: fix hang caused by freeze/unfreeze sequence
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        jinpuwang@gmail.com, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 9:21 PM Bob Liu <bob.liu@oracle.com> wrote:
>
> The following is a description of a hang in blk_mq_freeze_queue_wait().
> The hang happens on attempting to freeze a queue while another task does
> queue unfreeze.
>
> The root cause is an incorrect sequence of percpu_ref_resurrect() and
> percpu_ref_kill() and as a result those two can be swapped:
>
>  CPU#0                         CPU#1
>  ----------------              -----------------
>  q1 = blk_mq_init_queue(shared_tags)
>
>                                 q2 = blk_mq_init_queue(shared_tags)
>                                   blk_mq_add_queue_tag_set(shared_tags)
>                                     blk_mq_update_tag_set_depth(shared_tags)
>                                      list_for_each_entry()
>                                       blk_mq_freeze_queue(q1)
>                                        > percpu_ref_kill()
>                                        > blk_mq_freeze_queue_wait()
>
>  blk_cleanup_queue(q1)
>   blk_mq_freeze_queue(q1)
>    > percpu_ref_kill()
>                  ^^^^^^ freeze_depth can't guarantee the order
>
>                                       blk_mq_unfreeze_queue()
>                                         > percpu_ref_resurrect()
>
>    > blk_mq_freeze_queue_wait()
>                  ^^^^^^ Hang here!!!!
>
> This wrong sequence raises kernel warning:
> percpu_ref_kill_and_confirm called more than once on blk_queue_usage_counter_release!
> WARNING: CPU: 0 PID: 11854 at lib/percpu-refcount.c:336 percpu_ref_kill_and_confirm+0x99/0xb0
>
> But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
> which waits for a zero of a q_usage_counter, which never happens
> because percpu-ref was reinited (instead of being killed) and stays in
> PERCPU state forever.
>
> How to reproduce:
>  - "insmod null_blk.ko shared_tags=1 nr_devices=0 queue_mode=2"
>  - cpu0: python Script.py 0; taskset the corresponding process running on cpu0
>  - cpu1: python Script.py 1; taskset the corresponding process running on cpu1
>
>  Script.py:
>  ------
>  #!/usr/bin/python3
>
> import os
> import sys
>
> while True:
>     on = "echo 1 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
>     off = "echo 0 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
>     os.system(on)
>     os.system(off)
> ------
>
> This bug was first reported and fixed by Roman, previous discussion:
> [1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
> [2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
> [3] https://patchwork.kernel.org/patch/9268199/
>
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
>  v4:
>    - Update commit log
>  v3:
>    - rebase to v5.1
>  v2:
>    - forgotten hunk from local repo
>    - minor tweaks in the commit message
> ---
>  block/blk-core.c       |  3 ++-
>  block/blk-mq.c         | 19 ++++++++++---------
>  include/linux/blkdev.h |  7 ++++++-
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a55389b..fb97497 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -433,7 +433,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>                 smp_rmb();
>
>                 wait_event(q->mq_freeze_wq,
> -                          (atomic_read(&q->mq_freeze_depth) == 0 &&
> +                          (!q->mq_freeze_depth &&
>                             (pm || (blk_pm_request_resume(q),
>                                     !blk_queue_pm_only(q)))) ||
>                            blk_queue_dying(q));
> @@ -523,6 +523,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>         spin_lock_init(&q->queue_lock);
>
>         init_waitqueue_head(&q->mq_freeze_wq);
> +       mutex_init(&q->mq_freeze_lock);
>
>         /*
>          * Init percpu_ref in atomic mode so that it's faster to shutdown.
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a935483..373af60 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -143,13 +143,14 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
>
>  void blk_freeze_queue_start(struct request_queue *q)
>  {
> -       int freeze_depth;
> -
> -       freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
> -       if (freeze_depth == 1) {
> +       mutex_lock(&q->mq_freeze_lock);
> +       if (++q->mq_freeze_depth == 1) {
>                 percpu_ref_kill(&q->q_usage_counter);
> +               mutex_unlock(&q->mq_freeze_lock);
>                 if (queue_is_mq(q))
>                         blk_mq_run_hw_queues(q, false);
> +       } else {
> +               mutex_unlock(&q->mq_freeze_lock);
>         }
>  }
>  EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
> @@ -198,14 +199,14 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
>
>  void blk_mq_unfreeze_queue(struct request_queue *q)
>  {
> -       int freeze_depth;
> -
> -       freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
> -       WARN_ON_ONCE(freeze_depth < 0);
> -       if (!freeze_depth) {
> +       mutex_lock(&q->mq_freeze_lock);
> +       q->mq_freeze_depth--;
> +       WARN_ON_ONCE(q->mq_freeze_depth < 0);
> +       if (!q->mq_freeze_depth) {
>                 percpu_ref_resurrect(&q->q_usage_counter);
>                 wake_up_all(&q->mq_freeze_wq);
>         }
> +       mutex_unlock(&q->mq_freeze_lock);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5c58a3b..64f7683 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -535,7 +535,7 @@ struct request_queue {
>
>         struct mutex            sysfs_lock;
>
> -       atomic_t                mq_freeze_depth;
> +       int                     mq_freeze_depth;
>
>  #if defined(CONFIG_BLK_DEV_BSG)
>         struct bsg_class_device bsg_dev;
> @@ -547,6 +547,11 @@ struct request_queue {
>  #endif
>         struct rcu_head         rcu_head;
>         wait_queue_head_t       mq_freeze_wq;
> +       /*
> +        * Protect concurrent access to q_usage_counter by
> +        * percpu_ref_kill() and percpu_ref_reinit().
> +        */
> +       struct mutex            mq_freeze_lock;
>         struct percpu_ref       q_usage_counter;
>         struct list_head        all_q_node;

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
