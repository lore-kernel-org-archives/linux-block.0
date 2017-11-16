Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39968 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757299AbdKPJCy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 04:02:54 -0500
Received: by mail-it0-f68.google.com with SMTP id 72so5082365itl.5
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2017 01:02:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
References: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Nov 2017 10:02:53 +0100
Message-ID: <CAOi1vP-W1+UKDf4C9zX8QGD8YBnEPSrjbVcnLf7tyryBiW7Afg@mail.gmail.com>
Subject: Re: [PATCH 0/2] block: enforce ioctl(BLKROSET) and set_disk_ro()
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 9, 2017 at 7:44 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hello,
>
> I was doing some cleanup work on rbd BLKROSET handler and discovered
> that we ignore partition rw/ro setting (hd_struct->policy) for pretty
> much everything but straight writes.
>
> David (CCed) has blktests patches standing by.
>
> (Another aspect of this is that we don't enforce open(2) mode.  Tejun
> took a stab at this a few years ago, but his patch had to be reverted:
>
>   75f1dc0d076d ("block: check bdev_read_only() from blkdev_get()")
>   e51900f7d38c ("block: revert block_dev read-only check")
>
> It is a separate issue and refusing writes to read-only devices is
> obviously more important, but perhaps it's time to revisit that as
> well?)
>
> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (2):
>   block: fail op_is_write() requests to read-only partitions
>   block: add bdev_read_only() checks to common helpers
>
>  block/blk-core.c | 23 ++++++++++++++++++++++-
>  block/blk-lib.c  | 12 ++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)

Ping...  Christoph, Jens, could one of you please take a look?

Thanks,

                Ilya
