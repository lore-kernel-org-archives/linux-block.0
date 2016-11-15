Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36529 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755161AbcKOBDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 20:03:16 -0500
MIME-Version: 1.0
In-Reply-To: <1478865957-25252-9-git-send-email-tom.leiming@gmail.com>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com> <1478865957-25252-9-git-send-email-tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 15 Nov 2016 09:03:14 +0800
Message-ID: <CACVXFVOSRBGATu95CmP3YW+exAwMRTmTvCY1B5UigqH63uzHTw@mail.gmail.com>
Subject: Re: [PATCH 08/12] dm: dm.c: replace 'bio->bi_vcnt == 1' with !bio_multiple_segments
To: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "maintainer:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>,
        Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 11, 2016 at 8:05 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Avoid to access .bi_vcnt directly, because the bio can be
> splitted from block layer, and .bi_vcnt should never have
> been used here.
>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  drivers/md/dm-rq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index b2a9e2d161e4..d9cc8324e597 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -797,8 +797,13 @@ static void dm_old_request_fn(struct request_queue *q)
>                 if (req_op(rq) != REQ_OP_FLUSH)
>                         pos = blk_rq_pos(rq);
>
> +               /*
> +                * bio can be splitted from block layer, so use
> +                * !bio_multiple_segments instead of 'bio->bi_vcnt == 1'
> +                */
>                 if ((dm_old_request_peeked_before_merge_deadline(md) &&
> -                    md_in_flight(md) && rq->bio && rq->bio->bi_vcnt == 1 &&
> +                    md_in_flight(md) && rq->bio &&
> +                    !bio_multiple_segments(rq->bio) &&
>                      md->last_rq_pos == pos && md->last_rq_rw == rq_data_dir(rq)) ||
>                     (ti->type->busy && ti->type->busy(ti))) {
>                         blk_delay_queue(q, 10);

Hi Alasdair, Mike, Christoph and anyone,

Could you give this one a review?

Thanks,
Ming Lei
