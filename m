Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36368 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdJBG0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 02:26:00 -0400
Received: by mail-io0-f196.google.com with SMTP id n69so2654790ioi.3
        for <linux-block@vger.kernel.org>; Sun, 01 Oct 2017 23:25:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
References: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Oct 2017 08:25:55 +0200
Message-ID: <CAOi1vP8Ef+V9KaozCWNC3TwYn16k_yGd9Btj6z+ZkdbtqHubyg@mail.gmail.com>
Subject: Re: [PATCH 0/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 21, 2017 at 7:12 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hi Christoph, Martin,
>
> blkdev_issue_zeroout() now checks for any error.  This required a minor
> refactor, so I dropped the stable tag, Jens can add it back if needed.
>
> Previous patch and discussion at
>
>   https://marc.info/?l=linux-block&m=150471953327942&w=2
>
> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (2):
>   block: factor out __blkdev_issue_zero_pages()
>   block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
>
>  block/blk-lib.c | 85 +++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 53 insertions(+), 32 deletions(-)

Ping...  Christoph, could you please take a look?

Thanks,

                Ilya
