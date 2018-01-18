Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:40733 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeARLQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 06:16:52 -0500
Received: by mail-io0-f193.google.com with SMTP id t22so12246292ioa.7
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2018 03:16:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
References: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 18 Jan 2018 12:16:51 +0100
Message-ID: <CAOi1vP9wnt5jtevQs+FbkGMEdL-jCbDyZoLjs__J18RcOu9Zxw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] block: enforce ioctl(BLKROSET) and set_disk_ro()
To: Jens Axboe <axboe@fb.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 11, 2018 at 2:09 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
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
> v2 -> v3:
> - lookup part only once; combine read-only check with existing
>   should_fail_request check
>
> v1 -> v2:
> - added unlikely() per Sagi's suggestion
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
>  block/blk-core.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
>  block/blk-lib.c  | 12 ++++++++++++
>  2 files changed, 50 insertions(+), 18 deletions(-)

Jens, could you please pick these up for 4.16?

Thanks,

                Ilya
