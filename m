Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE84C004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72902054F
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 16:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZAgBKk0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEGQz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 12:55:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43396 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfEGQz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 12:55:28 -0400
Received: by mail-io1-f67.google.com with SMTP id v7so8420769iob.10
        for <linux-block@vger.kernel.org>; Tue, 07 May 2019 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWTcC3K3Nu/SMUmuigxcpBE1n1Srz3+InaoHGAS0US0=;
        b=ZAgBKk0c5qL5FHQqkjp7nmToPCYYtI7Zf2AAgdCa6fkexw7TAFbxpwf3A1DWC1FFUW
         xk667tBcqeee4P5HGHfWRJ7hC/FxM8umoC3nz0lRjkCe7ReT09URoeYT0eQ6FbLY9iV3
         bYxmicA5E6e7r0eKMJGqZxGkWuJ6cAV7DhmTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWTcC3K3Nu/SMUmuigxcpBE1n1Srz3+InaoHGAS0US0=;
        b=sA/N1RYHE+FFgvBSgbf1eUKul+7mB3oizxcS1Bn7uKKrpS3+NUHw0L5N0/sgzXR2pE
         RWCWXrd/4Oqqhe3HbxyOw3IwYtxqN1fMRxPopbtD92itNgLMxadUwlTpiISFAw+aXHTz
         QJ2+fplosZOffkasfpu4Eew9TGFCzn3ajGqOcKBf4IZFfWHM73uTjmHTuhwhXYhxRqod
         MAlp4jNfo4YzmMTtRHuenLqQGT/Gg3mdEfq6K80hUnnXCy/TOLVUxkuqxfsIEttvsKEc
         /Ob8uEsouih6NE8WcVgyRpgsbN+7HGFJ6iX8GW2S3cjKlaZYGWK+IqzsqEs6agB3Uiou
         g82g==
X-Gm-Message-State: APjAAAVwhh8jf4dS0PNXsNxFLlUXjWLQ4IIt31v1+WsNSFOrRQE0yaVf
        I1j2x7WyB4XqXTi5ONZ9WxS82dA1l11gKdDmUuGR/Q==
X-Google-Smtp-Source: APXvYqw5tayKkhD9cFzQVv3H/x0RxPTbOFxHnGnENXVN5L3H0wc8b8VbmbfjUH7CId9yNQ49Rj1AVDrtLaG0WWZSxyA=
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr15118561iot.192.1557247641118;
 Tue, 07 May 2019 09:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190506182736.21064-1-evgreen@chromium.org> <20190506182736.21064-3-evgreen@chromium.org>
In-Reply-To: <20190506182736.21064-3-evgreen@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 7 May 2019 09:47:09 -0700
Message-ID: <CAPUE2uuGM_JgD8CFkQcjMeVk_q17sO3Jfpr8OO-N9h6aNUwqBA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] loop: Better discard support for block devices
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, May 6, 2019 at 11:30 AM Evan Green <evgreen@chromium.org> wrote:
>
> If the backing device for a loop device is a block device,
> then mirror the "write zeroes" capabilities of the underlying
> block device into the loop device. Copy this capability into both
> max_write_zeroes_sectors and max_discard_sectors of the loop device.
>
> The reason for this is that REQ_OP_DISCARD on a loop device translates
> into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> presents a consistent interface for loop devices (that discarded data
> is zeroed), regardless of the backing device type of the loop device.
> There should be no behavior change for loop devices backed by regular
> files.
>
> While in there, differentiate between REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES, which are different for block devices,
> but which the loop device had just been lumping together, since
> they're largely the same for files.
>
> This change fixes blktest block/003, and removes an extraneous
> error print in block/013 when testing on a loop device backed
> by a block device that does not support discard.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v5:
> - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
>
> Changes in v4:
> - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
>
> Changes in v3:
> - Updated commit description
>
> Changes in v2: None
>
>  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bbf21ebeccd3..a147210ed009 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
>         return ret;
>  }
>
> -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> +static int lo_discard(struct loop_device *lo, struct request *rq,
> +               int mode, loff_t pos)
>  {
> -       /*
> -        * We use punch hole to reclaim the free space used by the
> -        * image a.k.a. discard. However we do not support discard if
> -        * encryption is enabled, because it may give an attacker
> -        * useful information.
> -        */
>         struct file *file = lo->lo_backing_file;
> -       int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> +       struct request_queue *q = lo->lo_queue;
>         int ret;
>
> -       if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> +       if (!blk_queue_discard(q)) {
>                 ret = -EOPNOTSUPP;
>                 goto out;
>         }
> @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>         case REQ_OP_FLUSH:
>                 return lo_req_flush(lo, rq);
>         case REQ_OP_DISCARD:
> +               return lo_discard(lo, rq,
> +                       FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> +
>         case REQ_OP_WRITE_ZEROES:
> -               return lo_discard(lo, rq, pos);
> +               return lo_discard(lo, rq,
> +                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
> +
>         case REQ_OP_WRITE:
>                 if (lo->transfer)
>                         return lo_write_transfer(lo, rq, pos);
> @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
>         struct file *file = lo->lo_backing_file;
>         struct inode *inode = file->f_mapping->host;
>         struct request_queue *q = lo->lo_queue;
> +       struct request_queue *backingq;
> +
> +       /*
> +        * If the backing device is a block device, mirror its zeroing
> +        * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> +        * by block devices to keep consistent behavior with file-backed loop
> +        * devices.
> +        */
> +       if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> +               backingq = bdev_get_queue(inode->i_bdev);
> +               blk_queue_max_discard_sectors(q,
> +                       backingq->limits.max_write_zeroes_sectors);
> +
> +               blk_queue_max_write_zeroes_sectors(q,
> +                       backingq->limits.max_write_zeroes_sectors);
>
>         /*
>          * We use punch hole to reclaim the free space used by the
> @@ -861,22 +876,24 @@ static void loop_config_discard(struct loop_device *lo)
>          * encryption is enabled, because it may give an attacker
>          * useful information.
>          */
> -       if ((!file->f_op->fallocate) ||
> -           lo->lo_encrypt_key_size) {
> +       } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>                 q->limits.discard_granularity = 0;
>                 q->limits.discard_alignment = 0;
>                 blk_queue_max_discard_sectors(q, 0);
>                 blk_queue_max_write_zeroes_sectors(q, 0);
> -               blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> -               return;
> -       }
>
> -       q->limits.discard_granularity = inode->i_sb->s_blocksize;
> -       q->limits.discard_alignment = 0;
> +       } else {
> +               q->limits.discard_granularity = inode->i_sb->s_blocksize;
> +               q->limits.discard_alignment = 0;
> +
> +               blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> +               blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> +       }
>
> -       blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> -       blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> -       blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +       if (q->limits.max_write_zeroes_sectors)
> +               blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +       else
> +               blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>  }
>
>  static void loop_unprepare_queue(struct loop_device *lo)
> --
> 2.20.1
>
