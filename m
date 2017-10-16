Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:46329 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdJPODF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 10:03:05 -0400
Received: by mail-io0-f194.google.com with SMTP id 101so16163752ioj.3
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2017 07:03:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171016114451.GA14591@infradead.org>
References: <1507129396-20458-1-git-send-email-idryomov@gmail.com>
 <1507129396-20458-3-git-send-email-idryomov@gmail.com> <20171005171327.GB31208@infradead.org>
 <CAOi1vP_7EaNOBXup--HPPnOOvKKi_6_ksXUqE5YmGAicjz0oWA@mail.gmail.com>
 <20171006120526.GA19292@infradead.org> <CAOi1vP9P6TrVpMQr9C+YU07uT2dKCZLBfrnMWYpsqYzTQcxBzQ@mail.gmail.com>
 <20171016114451.GA14591@infradead.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Oct 2017 16:03:04 +0200
Message-ID: <CAOi1vP9Vm2qtjQi=T1S+ZbGkT4eNWa-RXeMi5gACfxXm+1Uy5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 16, 2017 at 1:44 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Oct 06, 2017 at 02:31:20PM +0200, Ilya Dryomov wrote:
>> This would unconditionally overwrite any WRITE ZEROS error.  If we get
>> e.g. -EIO, and manual zeroing is not allowed, I don't think we want to
>> return -EOPNOTSUPP?
>>
>> Returning -EOPNOTSUPP to mean "can't zero using either method" doesn't
>> make sense to me, because manual zeroing is always supported, just not
>> always allowed.
>
> Then thow the throw bdev_write_zeroes_sectors check back in:
>
>         if (ret && try_write_zeroes) {
>                 if (!(flags & BLKDEV_ZERO_NOFALLBACK))
>                         try_write_zeroes = false;
>                         goto retry;
>                 }
>                 if (!bdev_write_zeroes_sectors(bdev))
>                         ret = -EOPNOTSUPP;
>         }
>
> The important bit is that the structure in the current patch where the
> bdev_write_zeroes_sectors check is on the same level as the method
> selection is extremely confusing.

I see.  An updated version should be in your inbox.

Thanks,

                Ilya
