Return-Path: <SRS0=Rcc/=XO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0904C4CEC4
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8648208C0
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H1uh6tTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391407AbfISPsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:48:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36411 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfISPsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 11:48:45 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so8890359iof.3
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2019 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=sGuJwTkUKZTTIppFydy4dVb0dOofTQ9YNUC+RHizbW4=;
        b=H1uh6tTeQvcqRMiDMacwkAvJybDmAwzqWhpza18jAgIg5oGePBgBU81TLXMgPleCjc
         0LUay4sMWS/8zUKWQ0UzLm2vEhMkmSXhWu65U/dDNawYbFnPcgUTBoBpKRQdz0rNem/L
         GfNyHnzFzR/cx2dbbHoj7s1WOEa4TDTqzd7qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=sGuJwTkUKZTTIppFydy4dVb0dOofTQ9YNUC+RHizbW4=;
        b=R9b0nkfI/PlvGJXrwIJsWK3hN+/M5tM7Bwqx88tpK0oqNZICn7fWhiUcCL7ATojqzg
         N1og9AA7LVmbwNDJ//mqRfVv9/KuY6PczTdyf+vfpB/COQp7TcYj5sRoeu0MVJ+4WScj
         RIErr43KxyXr8WLzgmd4jLewxv3OSfAj0HPsF8l2NG+uIbXfY08iuX7ayMhPE6V1r53/
         3SKuaIx6kjtxNjpYwrozaiftD6gcqy5WC7zWUirFD1KFcKPQ37ujsxKJZvOsB/rcFM1F
         H3Jfouj9U7VUJC+yF1XwVpsMSI2a4OrMt21FdVBzGH37CnUsOCXXcjijsJR3b0VgkLBJ
         I5Ng==
X-Gm-Message-State: APjAAAXfIbeRjVkVCmsy1Wb3n4hd7y7To1STlyqw4/2eCFlUXBhRCqbp
        Nf3vpXVOztyvE2De8RdhHnJAVkdlFQ/lxPyzg0k7gA==
X-Google-Smtp-Source: APXvYqzaL1CHa3QCLMAu2cD0hKlff+E6KljbvzgfOrcVWHCNl2MlYP33C8nXYgRiO/7fp3C8dpzr6DrJiTnKySnMfz0=
X-Received: by 2002:a02:69cd:: with SMTP id e196mr13266694jac.84.1568908124519;
 Thu, 19 Sep 2019 08:48:44 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190919094547.67194-1-hare@suse.de> <20190919094547.67194-3-hare@suse.de>
 <BYAPR04MB5816F1F98D8F408D23C1AF47E7890@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190919142344.GB11207@ming.t460p>
In-Reply-To: <20190919142344.GB11207@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQF0tjPls8xLc25lED+FK+pMiE7AYwF9UPQwAaQlFP8BKIXAuafSRYEw
Date:   Thu, 19 Sep 2019 21:18:41 +0530
Message-ID: <935518233f147da073414dcbcdb2abb5@mail.gmail.com>
Subject: RE: [PATCH 2/2] blk-mq: always call into the scheduler in blk_mq_make_request()
To:     Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > -	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops-
> >commit_rqs)) {
> > > +	} else if (plug && q->mq_ops->commit_rqs) {
> > >  		/*
> > >  		 * Use plugging if we have a ->commit_rqs() hook as well,
as
> > >  		 * we know the driver uses bd->last in a smart fashion.
> > > @@ -2020,9 +2019,6 @@ static blk_qc_t blk_mq_make_request(struct
> request_queue *q, struct bio *bio)
> > >  			blk_mq_try_issue_directly(data.hctx,
same_queue_rq,
> > >  					&cookie);
> > >  		}
> > > -	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
> > > -			!data.hctx->dispatch_busy)) {
> > > -		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
Hannes -

Earlier check prior to "commit 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8"
was only (q->nr_hw_queues > 1 && is_sync).
I am not sure if check of nr_hw_queues are required or not at this place,
but other part of check (!q->elevator && !data.hctx->dispatch_busy) to
qualify for direct dispatch is required for higher performance.

Recent MegaRaid and MPT HBA Aero series controller is capable of doing
~3.0 M IOPs and for such high performance using single hardware queue,
 commit 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8 is very important.

Kashyap


> >
> > It may be worth mentioning that blk_mq_sched_insert_request() will do
> > a direct insert of the request using __blk_mq_insert_request(). But
> > that insert is slightly different from what
> > blk_mq_try_issue_directly() does with
> > __blk_mq_issue_directly() as the request in that case is passed along
> > to the device using queue->mq_ops->queue_rq() while
> > __blk_mq_insert_request() will put the request in ctx->rq_lists[type].
> >
> > This removes the optimized case !q->elevator &&
> > !data.hctx->dispatch_busy, but I am not sure of the actual performance
> > impact yet. We may want to patch
> > blk_mq_sched_insert_request() to handle that case.
>
> The optimization did improve IOPS of single queue SCSI SSD a lot, see
>
> commit 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Tue Jul 10 09:03:31 2018 +0800
>
>     blk-mq: issue directly if hw queue isn't busy in case of 'none'
>
>     In case of 'none' io scheduler, when hw queue isn't busy, it isn't
>     necessary to enqueue request to sw queue and dequeue it from
>     sw queue because request may be submitted to hw queue asap without
>     extra cost, meantime there shouldn't be much request in sw queue,
>     and we don't need to worry about effect on IO merge.
>
>     There are still some single hw queue SCSI HBAs(HPSA, megaraid_sas,
...)
>     which may connect high performance devices, so 'none' is often
required
>     for obtaining good performance.
>
>     This patch improves IOPS and decreases CPU unilization on
megaraid_sas,
>     per Kashyap's test.
>
>
> Thanks,
> Ming
