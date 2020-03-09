Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D08C10F27
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE882464B
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUf4kE9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgCIQOu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:14:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgCIQOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Mar 2020 12:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583770487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0Xiu7IRQaKNKP/O5s3aWII1g2SCEmHfelOCyirW1PE=;
        b=bUf4kE9Ly5OlSoX6gJCBRt9pQPD16hDlEgALetjS2gzR+TQ8aT8WznTfWTJHinMtbBwpFY
        kGyjioE6+rNAGbb0d4cimQzNJXjg4+w2zbhcwl7qVO7vZPim3eTSKZRDoHWYUeI0pYqYgB
        Woh+ffI0xUy67D4f4ybK0cCCKEFLWHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-8aXOo6HZMsCqo0Y1OhvW8g-1; Mon, 09 Mar 2020 12:14:43 -0400
X-MC-Unique: 8aXOo6HZMsCqo0Y1OhvW8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73436107ACCC;
        Mon,  9 Mar 2020 16:14:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2331BC6D;
        Mon,  9 Mar 2020 16:14:35 +0000 (UTC)
Date:   Tue, 10 Mar 2020 00:14:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Message-ID: <20200309161430.GA4871@ming.t460p>
References: <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
 <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 09, 2020 at 12:07:16AM +0000, Shinichiro Kawasaki wrote:
> On Mar 07, 2020 / 12:13, Ming Lei wrote:
> > On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasaki wrote:
> > > On Mar 06, 2020 / 16:13, Ming Lei wrote:
> > > > On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote:
> > > > > On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > > > > > Hi Shinichiro,
> > > > > > 
> > > > > > On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > > > > > > On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > > > On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > > > > > > On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > > > > > I noticed that blktests block/004 takes longer runtime with 5.6-rc4 than
> > > > > > > > > > > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert passthrough
> > > > > > > > > > > request into hctx->dispatch directly") triggers it.
> > > > > > > > > > > 
> > > > > > > > > > > The longer runtime was observed with dm-linear device which maps SATA SMR HDD
> > > > > > > > > > > connected via AHCI. It was not observed with dm-linear on SAS/SATA SMR HDDs
> > > > > > > > > > > connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs either.
> > > > > > > > > > > 
> > > > > > > > > > > Before the commit, block/004 took around 130 seconds. After the commit, it takes
> > > > > > > > > > > around 300 seconds. I need to dig in further details to understand why the
> > > > > > > > > > > commit makes the test case longer.
> > > > > > > > > > > 
> > > > > > > > > > > The test case block/004 does "flush intensive workload". Is this longer runtime
> > > > > > > > > > > expected?
> > > > > > > > > > 
> > > > > > > > > > The following patch might address this issue:
> > > > > > > > > > 
> > > > > > > > > > https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@google.com/#t
> > > > > > > > > > 
> > > > > > > > > > Please test and provide us the result.
> > > > > > > > > > 
> > > > > > > > > > thanks,
> > > > > > > > > > Ming
> > > > > > > > > >
> > > > > > > > > 
> > > > > > > > > Hi Ming,
> > > > > > > > > 
> > > > > > > > > I applied the patch to 5.6-rc4 but I observed the longer runtime of block/004.
> > > > > > > > > Still it takes around 300 seconds.
> > > > > > > > 
> > > > > > > > Hello Shinichiro,
> > > > > > > > 
> > > > > > > > block/004 only sends 1564 sync randwrite, and seems 130s has been slow
> > > > > > > > enough.
> > > > > > > > 
> > > > > > > > There are two related effect in that commit for your issue:
> > > > > > > > 
> > > > > > > > 1) 'at_head' is applied in blk_mq_sched_insert_request() for flush
> > > > > > > > request
> > > > > > > > 
> > > > > > > > 2) all IO is added back to tail of hctx->dispatch after .queue_rq()
> > > > > > > > returns STS_RESOURCE
> > > > > > > > 
> > > > > > > > Seems it is more related with 2) given you can't reproduce the issue on 
> > > > > > > > SAS.
> > > > > > > > 
> > > > > > > > So please test the following two patches, and see which one makes a
> > > > > > > > difference for you.
> > > > > > > > 
> > > > > > > > BTW, both two looks not reasonable, just for narrowing down the issue.
> > > > > > > > 
> > > > > > > > 1) patch 1
> > > > > > > > 
> > > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > > index 856356b1619e..86137c75283c 100644
> > > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > > @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
> > > > > > > >  	WARN_ON(e && (rq->tag != -1));
> > > > > > > >  
> > > > > > > >  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > > > > > > -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > > > > > > +		blk_mq_request_bypass_insert(rq, true, false);
> > > > > > > >  		goto run;
> > > > > > > >  	}
> > > > > > > 
> > > > > > > Ming, thank you for the trial patches.
> > > > > > > This "patch 1" reduced the runtime, as short as rc3.
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 2) patch 2
> > > > > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > > > index d92088dec6c3..447d5cb39832 100644
> > > > > > > > --- a/block/blk-mq.c
> > > > > > > > +++ b/block/blk-mq.c
> > > > > > > > @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > > > > > > >  			q->mq_ops->commit_rqs(hctx);
> > > > > > > >  
> > > > > > > >  		spin_lock(&hctx->lock);
> > > > > > > > -		list_splice_tail_init(list, &hctx->dispatch);
> > > > > > > > +		list_splice_init(list, &hctx->dispatch);
> > > > > > > >  		spin_unlock(&hctx->lock);
> > > > > > > >  
> > > > > > > >  		/*
> > > > > > > 
> > > > > > > This patch 2 didn't reduce the runtime.
> > > > > > > 
> > > > > > > Wish this report helps.
> > > > > > 
> > > > > > Your feedback does help, then please test the following patch:
> > > > > 
> > > > > Hi Ming, thank you for the patch. I applied it on top of rc4 and confirmed
> > > > > it reduces the runtime as short as rc3. Good.
> > > > 
> > > > Hi Shinichiro,
> > > > 
> > > > Thanks for your test!
> > > > 
> > > > Then I think the following change should make the difference actually,
> > > > you may double check that and confirm if it is that.
> > > > 
> > > > > @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
> > > > >  	flush_rq->rq_disk = first_rq->rq_disk;
> > > > >  	flush_rq->end_io = flush_end_io;
> > > > >  
> > > > > -	blk_flush_queue_rq(flush_rq, false);
> > > > > +	blk_flush_queue_rq(flush_rq, true);
> > > 
> > > Yes, with this the one line change above only, the runtime was reduced.
> > > 
> > > > 
> > > > However, the flush request is added to tail of dispatch queue[1] for long time.
> > > > 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entirely")
> > > > and its predecessor(all mq scheduler start patches) changed to add flush request
> > > > to front of dispatch queue for blk-mq by ignoring 'add_queue' parameter of
> > > > blk_mq_sched_insert_flush(). That change may be by accident, and not sure it is
> > > > correct.
> > > > 
> > > > I guess once flush rq is added to tail of dispatch queue in block/004,
> > > > in which lots of FS request may stay in hctx->dispatch because of low
> > > > AHCI queue depth, then we may take a bit long for flush rq to be
> > > > submitted to LLD.
> > > > 
> > > > I'd suggest to root cause/understand the issue given it isn't obvious
> > > > correct to queue flush rq at front of dispatch queue, so could you collect
> > > > the following trace via the following script with/without the single line
> > > > patch?
> > > 
> > > Thank you for the thoughts for the correct design. I have taken the two traces,
> > > with and without the one liner patch above. The gzip archived trace files have
> > > 1.6MB size. It looks too large to post to the list. Please let me know how you
> > > want the trace files shared.
> > 
> > I didn't thought the trace can be so big given the ios should be just
> > 256 * 64(1564).
> > 
> > You may put the log somewhere in Internet, cloud storage, web, or
> > whatever. Then just provides us the link.
> > 
> > Or if you can't find a place to hold it, just send to me, and I will put
> > it in my RH people web link.
> 
> I have sent another e-mail only to you attaching the log files gziped.
> Your confirmation will be appreciated.

Yeah, I got the log, and it has been put in the following link:

http://people.redhat.com/minlei/tests/logs/blktests_block_004_perf_degrade.tar.gz

Also I have run some analysis, and block/004 basically call pwrite() &
fsync() in each job.

1) v5.6-rc kernel
- write rq average latency: 0.091s 
- flush rq average latency: 0.018s
- average issue times of write request: 1.978  //how many trace_block_rq_issue() is called for one rq
- average issue times of flush request: 1.052

2) v5.6-rc patched kernel
- write rq average latency: 0.031
- flush rq average latency: 0.035
- average issue times of write request: 1.466
- average issue times of flush request: 1.610


block/004 starts 64 jobs and AHCI's queue can become saturated easily,
then BLK_MQ_S_SCHED_RESTART should be set, so write request in dispatch
queue can only move on after one request is completed.

Looks the flush request takes shorter time than normal write IO.
If flush request is added to front of dispatch queue, the next normal
write IO could be queued to lld quicker than adding to tail of dispatch
queue.

trace_block_rq_issue() is called more than one time is because of
AHCI or the drive's implementation. It usually means that
host->hostt->queuecommand() fails for several times when queuing one
single request. For AHCI, I understand it shouldn't fail normally given
we guarantee that the actual queue depth is <= either LUN or host's
queue depth. Maybe it depends on your SMR's implementation about handling
flush/write IO. Could you check why .queuecommand() fails in block/004?

Also can you provide queue flags via the following command?

	cat /sys/kernel/debug/block/sdN/state

I understand flush request should be slower than normal write, however
looks not true in this hardware.


Thanks,
Ming

