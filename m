Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F443C10DCE
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 08:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492032072A
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 08:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCS6TqYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgCFIN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:13:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52153 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbgCFIN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 03:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583482404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVYu+8yVZZME3XJ3w8UbZi+KNLFWU505zlC2k2m6mao=;
        b=NCS6TqYwaMJJ5cMwzLRc8fiQFr2Z4EsV3JUyaiA4vt2fg4W0HFr2AHZW2Hn8KvQ1oXaxRX
        A7tiBCd8krU9FeEYEcbZOqFSXkG4NroI4fEnZJz7/P9C4vAczqsYP9teVAHTWAlLWQirb7
        O1xA/eWtQV5n+gwd+ry3cfaNdHPPA3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-GSUm12KYM1OSDHwL9klyqA-1; Fri, 06 Mar 2020 03:13:21 -0500
X-MC-Unique: GSUm12KYM1OSDHwL9klyqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC69107ACCA;
        Fri,  6 Mar 2020 08:13:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5A161001B2B;
        Fri,  6 Mar 2020 08:13:14 +0000 (UTC)
Date:   Fri, 6 Mar 2020 16:13:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Message-ID: <20200306081309.GA29683@ming.t460p>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
 <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote:
> On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > Hi Shinichiro,
> > 
> > On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wrote:
> > > On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > > On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wrote:
> > > > > On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > > On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > I noticed that blktests block/004 takes longer runtime with 5.6-rc4 than
> > > > > > > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert passthrough
> > > > > > > request into hctx->dispatch directly") triggers it.
> > > > > > > 
> > > > > > > The longer runtime was observed with dm-linear device which maps SATA SMR HDD
> > > > > > > connected via AHCI. It was not observed with dm-linear on SAS/SATA SMR HDDs
> > > > > > > connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs either.
> > > > > > > 
> > > > > > > Before the commit, block/004 took around 130 seconds. After the commit, it takes
> > > > > > > around 300 seconds. I need to dig in further details to understand why the
> > > > > > > commit makes the test case longer.
> > > > > > > 
> > > > > > > The test case block/004 does "flush intensive workload". Is this longer runtime
> > > > > > > expected?
> > > > > > 
> > > > > > The following patch might address this issue:
> > > > > > 
> > > > > > https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@google.com/#t
> > > > > > 
> > > > > > Please test and provide us the result.
> > > > > > 
> > > > > > thanks,
> > > > > > Ming
> > > > > >
> > > > > 
> > > > > Hi Ming,
> > > > > 
> > > > > I applied the patch to 5.6-rc4 but I observed the longer runtime of block/004.
> > > > > Still it takes around 300 seconds.
> > > > 
> > > > Hello Shinichiro,
> > > > 
> > > > block/004 only sends 1564 sync randwrite, and seems 130s has been slow
> > > > enough.
> > > > 
> > > > There are two related effect in that commit for your issue:
> > > > 
> > > > 1) 'at_head' is applied in blk_mq_sched_insert_request() for flush
> > > > request
> > > > 
> > > > 2) all IO is added back to tail of hctx->dispatch after .queue_rq()
> > > > returns STS_RESOURCE
> > > > 
> > > > Seems it is more related with 2) given you can't reproduce the issue on 
> > > > SAS.
> > > > 
> > > > So please test the following two patches, and see which one makes a
> > > > difference for you.
> > > > 
> > > > BTW, both two looks not reasonable, just for narrowing down the issue.
> > > > 
> > > > 1) patch 1
> > > > 
> > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > index 856356b1619e..86137c75283c 100644
> > > > --- a/block/blk-mq-sched.c
> > > > +++ b/block/blk-mq-sched.c
> > > > @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
> > > >  	WARN_ON(e && (rq->tag != -1));
> > > >  
> > > >  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > > -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > > +		blk_mq_request_bypass_insert(rq, true, false);
> > > >  		goto run;
> > > >  	}
> > > 
> > > Ming, thank you for the trial patches.
> > > This "patch 1" reduced the runtime, as short as rc3.
> > > 
> > > > 
> > > > 
> > > > 2) patch 2
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index d92088dec6c3..447d5cb39832 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > > >  			q->mq_ops->commit_rqs(hctx);
> > > >  
> > > >  		spin_lock(&hctx->lock);
> > > > -		list_splice_tail_init(list, &hctx->dispatch);
> > > > +		list_splice_init(list, &hctx->dispatch);
> > > >  		spin_unlock(&hctx->lock);
> > > >  
> > > >  		/*
> > > 
> > > This patch 2 didn't reduce the runtime.
> > > 
> > > Wish this report helps.
> > 
> > Your feedback does help, then please test the following patch:
> 
> Hi Ming, thank you for the patch. I applied it on top of rc4 and confirmed
> it reduces the runtime as short as rc3. Good.

Hi Shinichiro,

Thanks for your test!

Then I think the following change should make the difference actually,
you may double check that and confirm if it is that.

> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  	flush_rq->rq_disk = first_rq->rq_disk;
>  	flush_rq->end_io = flush_end_io;
>  
> -	blk_flush_queue_rq(flush_rq, false);
> +	blk_flush_queue_rq(flush_rq, true);

However, the flush request is added to tail of dispatch queue[1] for long time.
0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entirely")
and its predecessor(all mq scheduler start patches) changed to add flush request
to front of dispatch queue for blk-mq by ignoring 'add_queue' parameter of
blk_mq_sched_insert_flush(). That change may be by accident, and not sure it is
correct.

I guess once flush rq is added to tail of dispatch queue in block/004,
in which lots of FS request may stay in hctx->dispatch because of low
AHCI queue depth, then we may take a bit long for flush rq to be
submitted to LLD.

I'd suggest to root cause/understand the issue given it isn't obvious
correct to queue flush rq at front of dispatch queue, so could you collect
the following trace via the following script with/without the single line
patch?

#!/bin/sh

MAJ=$1
MIN=$2
MAJ=$(( $MAJ << 20 ))
DEV=$(( $MAJ | $MIN ))

/usr/share/bcc/tools/trace -t -C \
    't:block:block_getrq (args->dev == '$DEV') "%s %d %d", args->rwbs, args->sector, args->nr_sector' \
    't:block:block_rq_issue (args->dev == '$DEV') "%s %d %d", args->rwbs, args->sector, args->nr_sector' \
    't:block:block_rq_complete (args->dev == '$DEV') "%s %d %d", args->rwbs, args->sector, args->nr_sector'

note:
1) install bcc package
2) pass the test disk(AHCI/SMR) major & minor to above script
3) start the script before running block/004



[1] 53d63e6b0dfb block: make the flush insertion use the tail of the dispatch list

Thanks,
Ming

