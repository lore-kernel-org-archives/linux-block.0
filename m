Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F8DC4360F
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECB22173C
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VjW+JUp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfC1Txs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:53:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38079 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1Txr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 15:53:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id a6so14908863lfl.5
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYGWnhIks4l2MvbVr4OOzOvA1DR9kZHEkMjqKsutwJM=;
        b=VjW+JUp5Ow5m9ugk5lKNG7c/n8KEWjzx0UMl+kEyhgEl7A3xmAvyRKOSGjILTj4+87
         UE7mUw3gu9Z2gKO7K/ltJa/GA1xsUJSXm4ZD6DdtxBrtls9bKKCfKFOEyT1llNgDNgVQ
         0SRSECwP4XyBRt0ngrU3t/ySAuGyHYVxiN6gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYGWnhIks4l2MvbVr4OOzOvA1DR9kZHEkMjqKsutwJM=;
        b=gSAn/pSywvmWenQNKj3IfVTcq15sMd/n5ZYWnwSOIjj2c26Xdkj9P1rcvTRbFU/05L
         nItRMSp4NVBuiaUQ2cSw1fwF0SCsw+ONCr2hkd6aZHgBlS7VjbcBbkRqt+slpBGvWUvo
         j/qla2O7FhqMpKT+tJ1dgpneRaXRccfyFEVfd8gN/S0ob6ExQ9aYq/nE+2Df29icrT+0
         naaAZuLVbz4eTo8j8QwDMqqpqYgxbIVRt0mGNTLOM8GDF7ux14atei4+9e3X4F7mRc2q
         pn26UKnAbQ1rcPznPrSFzMb+Dbr3Y0U7+oB9reYVY7IfLqY72JrJwGm2nLWU6RdxRS7w
         trSw==
X-Gm-Message-State: APjAAAWzuDVs/MNGxInShFjrtCEN+EHqmlaGEqYw02g0QSExtGSGMbTU
        AtaIA5/auoLbIkhMOBP7B1JpxG/CzSU=
X-Google-Smtp-Source: APXvYqzvddxB7UGwDBTukZ78NTBGGJqFy9r1h166uo0Ay8qb5/4bJP5U5uB0dByRawoEKrkWsEkI5g==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr24085840lfc.107.1553802824507;
        Thu, 28 Mar 2019 12:53:44 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j27sm5162250lfk.97.2019.03.28.12.53.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:53:43 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f18so18757207lja.10
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 12:53:43 -0700 (PDT)
X-Received: by 2002:a2e:6507:: with SMTP id z7mr10807300ljb.147.1553802823297;
 Thu, 28 Mar 2019 12:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190327222841.38650-1-evgreen@chromium.org> <20190327222841.38650-3-evgreen@chromium.org>
 <20190328023650.GD19708@ming.t460p>
In-Reply-To: <20190328023650.GD19708@ming.t460p>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 28 Mar 2019 12:53:06 -0700
X-Gmail-Original-Message-ID: <CAE=gft7AXQ1t_oeJRpytD26A=hAPp3G-g5SY0MvxzZAGYJGaSA@mail.gmail.com>
Message-ID: <CAE=gft7AXQ1t_oeJRpytD26A=hAPp3G-g5SY0MvxzZAGYJGaSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] loop: Better discard support for block devices
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 7:37 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, Mar 27, 2019 at 03:28:41PM -0700, Evan Green wrote:
...
> > @@ -854,6 +854,25 @@ static void loop_config_discard(struct loop_device *lo)
> >       struct file *file = lo->lo_backing_file;
> >       struct inode *inode = file->f_mapping->host;
> >       struct request_queue *q = lo->lo_queue;
> > +     struct request_queue *backingq;
> > +
> > +     /*
> > +      * If the backing device is a block device, mirror its discard
> > +      * capabilities.
> > +      */
> > +     if (S_ISBLK(inode->i_mode)) {
> > +             backingq = bdev_get_queue(inode->i_bdev);
> > +             blk_queue_max_discard_sectors(q,
> > +                     backingq->limits.max_discard_sectors);
> > +
> > +             blk_queue_max_write_zeroes_sectors(q,
> > +                     backingq->limits.max_write_zeroes_sectors);
> > +
> > +             q->limits.discard_granularity =
> > +                     backingq->limits.discard_granularity;
> > +
> > +             q->limits.discard_alignment =
> > +                     backingq->limits.discard_alignment;
>
> Loop usually doesn't mirror backing queue's limits, and I believe
> it isn't necessary for this case too, just wondering why the
> following simple setting can't work?
>
>         if (S_ISBLK(inode->i_mode)) {
>                 backingq = bdev_get_queue(inode->i_bdev);
>
>                 q->limits.discard_alignment = 0;
>                 if (!blk_queue_discard(backingq)) {
>                         q->limits.discard_granularity = 0;
>                         blk_queue_max_discard_sectors(q, 0);
>                         blk_queue_max_write_zeroes_sectors(q, 0);
>                         blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>                 } else {
>                         q->limits.discard_granularity = inode->i_sb->s_blocksize;
>                         blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
>                         blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
>                         blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>                 }
>         } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>                 ...
>         }
>
> I remembered you mentioned the above code doesn't work in some of your
> tests, but never explain the reason. However, it is supposed to work
> given bio splitting does handle/respect the discard limits. Or is there
> bug in bio splitting on discard IO?

I've done some more digging, and I think I have an answer for you,
with some proposed changes to the patch.

My original answer was going to be that REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES are different. So I have an NVMe device that does
support discard, but does not support write_zeroes, and should mirror
those capabilities individually to most accurately reflect the
underlying block device. But then I noticed that this device still
prints the error log I was trying to get rid of when doing mkfs.ext4,
so my fix is incomplete.

The reason is that I have the following translation between REQ_OP_*
and FALLOC_FL_*:
REQ_OP_DISCARD ==> FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE
REQ_OP_WRITE_ZEROES ==> FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE

This makes sense for loop devices backed by regular files, and I think
is the right mapping. But for loop devices backed by block devices,
blkdev_fallocate() translates both of these sets of flags into
blkdev_issue_zeroout(), rather than blkdev_issue_discard() for
REQ_OP_DISCARD (since I wasn't setting FALLOC_FL_NO_HIDE_STALE).

I think this set of flags still makes sense for block devices, since
it keeps a consistent behavior for loop devices backed by files and
block devices (namely, that the discarded space is always zeroed).
However it means that for my NVMe that supports discard (never used)
but not write_zeroes (always tried), loop devices backed directly by
this NVMe should not set the discard flag.

So I think what I should actually have is this:

if (S_ISBLK(inode->i_mode)) {
        backingq = bdev_get_queue(inode->i_bdev);
        blk_queue_max_discard_sectors(q,
                backingq->limits.max_write_zeroes_sectors);  /// Note
the difference here.

        blk_queue_max_write_zeroes_sectors(q,
                backingq->limits.max_write_zeroes_sectors);
} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) { ... }
...
if (q->limits.max_write_zeroes_sectors)
        blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
else
        blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);

I can confirm that this fixes the errors for my NVMe as well.

What do you think?
-Evan
