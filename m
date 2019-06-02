Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,TRACKER_ID,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2528EC282DC
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3BB27970
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 16:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QUi+5Ppy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFBQeF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:34:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43523 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBQeF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jun 2019 12:34:05 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so12301613ios.10
        for <linux-block@vger.kernel.org>; Sun, 02 Jun 2019 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=9O3lHjgPMIB9XFNWc5DaXwAN7zf+uTdR/nwh9VsWbtY=;
        b=QUi+5Ppy0UP3LLcUAD9tdGurOWGy3ls5BR0nTs9/8FUjmjyttqYHHgqXrC25qmeyKF
         RNXidcIaektfuiOucLOfJBV0DXKAHIeWh2p2WXjI23nnEx/PxfzEYZW7BnEeQ5FPGYYB
         E4E2JszgIAwqGvAYJ12mxsj36jRrCJNs/q5QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=9O3lHjgPMIB9XFNWc5DaXwAN7zf+uTdR/nwh9VsWbtY=;
        b=OAj26jjHJX8zJunjwQ491oWpxWV/74OR5d1p0FwVJEo3NmI2wZZ9aCsHvhx/OOLX2Z
         KI3OT9cyHwGGnVjRdJq+dG/hVn0Fx3DmJ0SOvOz4583CeXTz8Pync5xfvgIjHbyG9N2E
         eVylTUI66D51xDXZyWpWPWkPDr+mQ0akYbmyHfzjtLOPEmFmxxsEQTSD7YehUFqyZUkU
         +2tHa/GZil9b4nz9bxRAJeVyRRJ8AVYbI3CTvK3MaVNajJQG++Mlc50w0Lj8//H+ywHl
         cv5aPB2c+FE5Ig0qC5yotKhjMBWWUg8HE6IEXuieXI+GKkJPZJXOK/bBPVbXYS2jMwm0
         oa/w==
X-Gm-Message-State: APjAAAVQw18DXnmVsW077EVMKn63zn30IxFhLV8wit1Ao7NayDTPCcXM
        NBC54DkAqVwsmMfmRY7mAvj8SUA2mwI6SRy373MAXQ==
X-Google-Smtp-Source: APXvYqwGb4I8krclT5bhBwsYEdk9c7nxhHdupcoGECa1hx0l95JkmO/mOVsPaHGxf/SQ3rX1YSfZC282XmoVj0fzCvs=
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr6756127ion.238.1559493244167;
 Sun, 02 Jun 2019 09:34:04 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-9-ming.lei@redhat.com>
 <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com> <20190602064202.GA2731@ming.t460p>
 <20190602074757.GA31572@ming.t460p>
In-Reply-To: <20190602074757.GA31572@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQISV99IJucrELCJ7/TtkhttwnBgjgOGFSeuAhzMczwA7yMTbgJjyv4mpcZifEA=
Date:   Sun, 2 Jun 2019 22:04:01 +0530
Message-ID: <020a7707a31803d65dd94cc0928a425a@mail.gmail.com>
Subject: RE: [PATCH 8/9] scsi: megaraid: convert private reply queue to blk-mq
 hw queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Meantime please try the following patch and see if difference can be
made.
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c index
> 49d73d979cb3..d2abec3b0f60 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -589,7 +589,7 @@ static void __blk_mq_complete_request(struct
> request *rq)
>  	 * So complete IO reqeust in softirq context in case of single
queue
>  	 * for not degrading IO performance by irqsoff latency.
>  	 */
> -	if (q->nr_hw_queues == 1) {
> +	if (q->nr_hw_queues == 1 || (rq->mq_hctx->flags &
> BLK_MQ_F_HOST_TAGS))
> +{
>  		__blk_complete_request(rq);
>  		return;
>  	}
> @@ -1977,7 +1977,8 @@ static blk_qc_t blk_mq_make_request(struct
> request_queue *q, struct bio *bio)
>  		/* bypass scheduler for flush rq */
>  		blk_insert_flush(rq);
>  		blk_mq_run_hw_queue(data.hctx, true);
> -	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops-
> >commit_rqs)) {
> +	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs
> ||
> +				(data.hctx->flags & BLK_MQ_F_HOST_TAGS)))
> {
>  		/*
>  		 * Use plugging if we have a ->commit_rqs() hook as well,
as
>  		 * we know the driver uses bd->last in a smart fashion.

Ming -

I tried above patch and no improvement in performance.

Below is perf record data - lock contention is while getting the tag
(blk_mq_get_tag )

6.67%     6.67%  fio              [kernel.vmlinux]  [k]
native_queued_spin_lock_slowpath
   - 6.66% io_submit
      - 6.66% entry_SYSCALL_64
         - do_syscall_64
            - 6.66% __x64_sys_io_submit
               - 6.66% io_submit_one
                  - 6.66% aio_read
                     - 6.66% generic_file_read_iter
                        - 6.66% blkdev_direct_IO
                           - 6.65% submit_bio
                              - generic_make_request
                                 - 6.65% blk_mq_make_request
                                    - 6.65% blk_mq_get_request
                                       - 6.65% blk_mq_get_tag
                                          - 6.58%
prepare_to_wait_exclusive
                                             - 6.57%
_raw_spin_lock_irqsave

queued_spin_lock_slowpath

>
> thanks,
> Ming
