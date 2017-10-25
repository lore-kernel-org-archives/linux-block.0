Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:53900 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdJYG1F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Oct 2017 02:27:05 -0400
Received: by mail-it0-f68.google.com with SMTP id n195so12828953itg.2
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2017 23:27:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
References: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 25 Oct 2017 08:27:04 +0200
Message-ID: <CAOi1vP_-ycXO4hkedPmrdiZcUZchQzNE2gh-3Oq_F25Euv=ncQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
To: Jens Axboe <axboe@fb.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 16, 2017 at 3:59 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hi Christoph, Martin,
>
> blkdev_issue_zeroout() now checks for any error.  This required a minor
> refactor, so I dropped the stable tag, Jens can add it back if needed.
>
> v2 -> v3:
> - another code flow change in blkdev_issue_zeroout() suggested by
>   Christoph -- no functional changes
>
> v1 -> v2:
> - changed code flow in blkdev_issue_zeroout() according to Christoph's
>   suggestion
> - this required adding additional checks to blkdev_issue_zeroout() and
>   __blkdev_issue_zero_pages(), the latter is no longer void
>
> Previous version at
>
>   https://marc.info/?l=linux-block&m=150712940922089&w=2
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
>  block/blk-lib.c | 108 +++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 72 insertions(+), 36 deletions(-)

Jens, can you pick these up?  Technically this is a user-visible
regression (Fixes tag in 2/2), but we are late in the cycle so I'm not
sure what is the right thing to do here.

Thanks,

                Ilya
