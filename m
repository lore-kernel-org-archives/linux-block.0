Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C1C10F27
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832BB2146E
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 07:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExjqDPmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgCKHye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:54:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52319 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbgCKHye (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 03:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583913272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RICqELxaFZjRgrGSV/FBJBt2aKGZanN1QATUUDq2DyE=;
        b=ExjqDPmQuKrLU99l29KGCN8TfNGXChNRFOjRV/bQ2h+UkGnFu+1jYENSllPdnh6tu8ngcl
        rpoqIdiEiKxpm+2Swc+/AK3lsPOe8GMaVLYcM0bMA6Xhd6VLksdYtthvnAOlWZvEEtblrz
        JCFZUEh5dEl5QGio1TXq1R7tqoalJwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-q7ADwSXXN0OWXFBWM2WSnA-1; Wed, 11 Mar 2020 03:54:25 -0400
X-MC-Unique: q7ADwSXXN0OWXFBWM2WSnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E014013EA;
        Wed, 11 Mar 2020 07:54:23 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B67319C58;
        Wed, 11 Mar 2020 07:54:14 +0000 (UTC)
Date:   Wed, 11 Mar 2020 15:54:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Message-ID: <20200311075403.GA31504@ming.t460p>
References: <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
 <20200309161430.GA4871@ming.t460p>
 <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200310055417.o3jghx4sl5xtztci@shindev.dhcp.fujisawa.hgst.com>
 <20200310080744.GA7618@ming.t460p>
 <20200310110703.hvaek3opc67lcr74@shindev.dhcp.fujisawa.hgst.com>
 <20200310133724.GA25034@ming.t460p>
 <20200310143751.GA29474@ming.t460p>
 <20200311045922.swskt7kwfkawfhba@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311045922.swskt7kwfkawfhba@shindev.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 11, 2020 at 04:59:23AM +0000, Shinichiro Kawasaki wrote:
> On Mar 10, 2020 / 22:37, Ming Lei wrote:
> > On Tue, Mar 10, 2020 at 09:37:24PM +0800, Ming Lei wrote:
> > > On Tue, Mar 10, 2020 at 11:07:04AM +0000, Shinichiro Kawasaki wrote:
> > > > On Mar 10, 2020 / 16:07, Ming Lei wrote:
> > > > > On Tue, Mar 10, 2020 at 05:54:18AM +0000, Shinichiro Kawasaki wrote:
> > > > > > Ming, thank you for sharing the log files and analysis.
> > > > > > 
> > > > > > On Mar 10, 2020 / 03:07, Damien Le Moal wrote:
> > > > > > > On 2020/03/10 1:14, Ming Lei wrote:
> > > > > > > > On Mon, Mar 09, 2020 at 12:07:16AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > >> On Mar 07, 2020 / 12:13, Ming Lei wrote:
> > > > > > > >>> On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > >>>> On Mar 06, 2020 / 16:13, Ming Lei wrote:
> > > > > > > >>>>> On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > >>>>>> On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > > > > > > >>>>>>> Hi Shinichiro,
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > >>>>>>>> On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > > > > > >>>>>>>>> On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > >>>>>>>>>> On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > > > >>>>>>>>>>> On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wrote:
> > > > > > > >>>>>>>>>>>> I noticed that blktests block/004 takes longer runtime with 5.6-rc4 than
> > > > > > > >>>>>>>>>>>> 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert passthrough
> > > > > > > >>>>>>>>>>>> request into hctx->dispatch directly") triggers it.
> > > > > > > >>>>>>>>>>>>
> > > > > > > >>>>>>>>>>>> The longer runtime was observed with dm-linear device which maps SATA SMR HDD
> > > > > > > >>>>>>>>>>>> connected via AHCI. It was not observed with dm-linear on SAS/SATA SMR HDDs
> > > > > > > >>>>>>>>>>>> connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs either.
> > > > > > > >>>>>>>>>>>>
> > > > > > > >>>>>>>>>>>> Before the commit, block/004 took around 130 seconds. After the commit, it takes
> > > > > > > >>>>>>>>>>>> around 300 seconds. I need to dig in further details to understand why the
> > > > > > > >>>>>>>>>>>> commit makes the test case longer.
> > > > > > > >>>>>>>>>>>>
> > > > > > > >>>>>>>>>>>> The test case block/004 does "flush intensive workload". Is this longer runtime
> > > > > > > >>>>>>>>>>>> expected?
> > > > > > > >>>>>>>>>>>
> > > > > > > >>>>>>>>>>> The following patch might address this issue:
> > > > > > > >>>>>>>>>>>
> > > > > > > >>>>>>>>>>> https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@google.com/#t
> > > > > > > >>>>>>>>>>>
> > > > > > > >>>>>>>>>>> Please test and provide us the result.
> > > > > > > >>>>>>>>>>>
> > > > > > > >>>>>>>>>>> thanks,
> > > > > > > >>>>>>>>>>> Ming
> > > > > > > >>>>>>>>>>>
> > > > > > > >>>>>>>>>>
> > > > > > > >>>>>>>>>> Hi Ming,
> > > > > > > >>>>>>>>>>
> > > > > > > >>>>>>>>>> I applied the patch to 5.6-rc4 but I observed the longer runtime of block/004.
> > > > > > > >>>>>>>>>> Still it takes around 300 seconds.
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> Hello Shinichiro,
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> block/004 only sends 1564 sync randwrite, and seems 130s has been slow
> > > > > > > >>>>>>>>> enough.
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> There are two related effect in that commit for your issue:
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> 1) 'at_head' is applied in blk_mq_sched_insert_request() for flush
> > > > > > > >>>>>>>>> request
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> 2) all IO is added back to tail of hctx->dispatch after .queue_rq()
> > > > > > > >>>>>>>>> returns STS_RESOURCE
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> Seems it is more related with 2) given you can't reproduce the issue on 
> > > > > > > >>>>>>>>> SAS.
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> So please test the following two patches, and see which one makes a
> > > > > > > >>>>>>>>> difference for you.
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> BTW, both two looks not reasonable, just for narrowing down the issue.
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> 1) patch 1
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > >>>>>>>>> index 856356b1619e..86137c75283c 100644
> > > > > > > >>>>>>>>> --- a/block/blk-mq-sched.c
> > > > > > > >>>>>>>>> +++ b/block/blk-mq-sched.c
> > > > > > > >>>>>>>>> @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
> > > > > > > >>>>>>>>>  	WARN_ON(e && (rq->tag != -1));
> > > > > > > >>>>>>>>>  
> > > > > > > >>>>>>>>>  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > > > > > >>>>>>>>> -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > > > > > >>>>>>>>> +		blk_mq_request_bypass_insert(rq, true, false);
> > > > > > > >>>>>>>>>  		goto run;
> > > > > > > >>>>>>>>>  	}
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>>> Ming, thank you for the trial patches.
> > > > > > > >>>>>>>> This "patch 1" reduced the runtime, as short as rc3.
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> 2) patch 2
> > > > > > > >>>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > > >>>>>>>>> index d92088dec6c3..447d5cb39832 100644
> > > > > > > >>>>>>>>> --- a/block/blk-mq.c
> > > > > > > >>>>>>>>> +++ b/block/blk-mq.c
> > > > > > > >>>>>>>>> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > > > > > > >>>>>>>>>  			q->mq_ops->commit_rqs(hctx);
> > > > > > > >>>>>>>>>  
> > > > > > > >>>>>>>>>  		spin_lock(&hctx->lock);
> > > > > > > >>>>>>>>> -		list_splice_tail_init(list, &hctx->dispatch);
> > > > > > > >>>>>>>>> +		list_splice_init(list, &hctx->dispatch);
> > > > > > > >>>>>>>>>  		spin_unlock(&hctx->lock);
> > > > > > > >>>>>>>>>  
> > > > > > > >>>>>>>>>  		/*
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>>> This patch 2 didn't reduce the runtime.
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>>> Wish this report helps.
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> Your feedback does help, then please test the following patch:
> > > > > > > >>>>>>
> > > > > > > >>>>>> Hi Ming, thank you for the patch. I applied it on top of rc4 and confirmed
> > > > > > > >>>>>> it reduces the runtime as short as rc3. Good.
> > > > > > > >>>>>
> > > > > > > >>>>> Hi Shinichiro,
> > > > > > > >>>>>
> > > > > > > >>>>> Thanks for your test!
> > > > > > > >>>>>
> > > > > > > >>>>> Then I think the following change should make the difference actually,
> > > > > > > >>>>> you may double check that and confirm if it is that.
> > > > > > > >>>>>
> > > > > > > >>>>>> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
> > > > > > > >>>>>>  	flush_rq->rq_disk = first_rq->rq_disk;
> > > > > > > >>>>>>  	flush_rq->end_io = flush_end_io;
> > > > > > > >>>>>>  
> > > > > > > >>>>>> -	blk_flush_queue_rq(flush_rq, false);
> > > > > > > >>>>>> +	blk_flush_queue_rq(flush_rq, true);
> > > > > > > >>>>
> > > > > > > >>>> Yes, with this the one line change above only, the runtime was reduced.
> > > > > > > >>>>
> > > > > > > >>>>>
> > > > > > > >>>>> However, the flush request is added to tail of dispatch queue[1] for long time.
> > > > > > > >>>>> 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entirely")
> > > > > > > >>>>> and its predecessor(all mq scheduler start patches) changed to add flush request
> > > > > > > >>>>> to front of dispatch queue for blk-mq by ignoring 'add_queue' parameter of
> > > > > > > >>>>> blk_mq_sched_insert_flush(). That change may be by accident, and not sure it is
> > > > > > > >>>>> correct.
> > > > > > > >>>>>
> > > > > > > >>>>> I guess once flush rq is added to tail of dispatch queue in block/004,
> > > > > > > >>>>> in which lots of FS request may stay in hctx->dispatch because of low
> > > > > > > >>>>> AHCI queue depth, then we may take a bit long for flush rq to be
> > > > > > > >>>>> submitted to LLD.
> > > > > > > >>>>>
> > > > > > > >>>>> I'd suggest to root cause/understand the issue given it isn't obvious
> > > > > > > >>>>> correct to queue flush rq at front of dispatch queue, so could you collect
> > > > > > > >>>>> the following trace via the following script with/without the single line
> > > > > > > >>>>> patch?
> > > > > > > >>>>
> > > > > > > >>>> Thank you for the thoughts for the correct design. I have taken the two traces,
> > > > > > > >>>> with and without the one liner patch above. The gzip archived trace files have
> > > > > > > >>>> 1.6MB size. It looks too large to post to the list. Please let me know how you
> > > > > > > >>>> want the trace files shared.
> > > > > > > >>>
> > > > > > > >>> I didn't thought the trace can be so big given the ios should be just
> > > > > > > >>> 256 * 64(1564).
> > > > > > > >>>
> > > > > > > >>> You may put the log somewhere in Internet, cloud storage, web, or
> > > > > > > >>> whatever. Then just provides us the link.
> > > > > > > >>>
> > > > > > > >>> Or if you can't find a place to hold it, just send to me, and I will put
> > > > > > > >>> it in my RH people web link.
> > > > > > > >>
> > > > > > > >> I have sent another e-mail only to you attaching the log files gziped.
> > > > > > > >> Your confirmation will be appreciated.
> > > > > > > > 
> > > > > > > > Yeah, I got the log, and it has been put in the following link:
> > > > > > > > 
> > > > > > > > http://people.redhat.com/minlei/tests/logs/blktests_block_004_perf_degrade.tar.gz
> > > > > > > > 
> > > > > > > > Also I have run some analysis, and block/004 basically call pwrite() &
> > > > > > > > fsync() in each job.
> > > > > > > > 
> > > > > > > > 1) v5.6-rc kernel
> > > > > > > > - write rq average latency: 0.091s 
> > > > > > > > - flush rq average latency: 0.018s
> > > > > > > > - average issue times of write request: 1.978  //how many trace_block_rq_issue() is called for one rq
> > > > > > > > - average issue times of flush request: 1.052
> > > > > > > > 
> > > > > > > > 2) v5.6-rc patched kernel
> > > > > > > > - write rq average latency: 0.031
> > > > > > > > - flush rq average latency: 0.035
> > > > > > > > - average issue times of write request: 1.466
> > > > > > > > - average issue times of flush request: 1.610
> > > > > > > > 
> > > > > > > > 
> > > > > > > > block/004 starts 64 jobs and AHCI's queue can become saturated easily,
> > > > > > > > then BLK_MQ_S_SCHED_RESTART should be set, so write request in dispatch
> > > > > > > > queue can only move on after one request is completed.
> > > > > > > > 
> > > > > > > > Looks the flush request takes shorter time than normal write IO.
> > > > > > > > If flush request is added to front of dispatch queue, the next normal
> > > > > > > > write IO could be queued to lld quicker than adding to tail of dispatch
> > > > > > > > queue.
> > > > > > > > trace_block_rq_issue() is called more than one time is because of
> > > > > > > > AHCI or the drive's implementation. It usually means that
> > > > > > > > host->hostt->queuecommand() fails for several times when queuing one
> > > > > > > > single request. For AHCI, I understand it shouldn't fail normally given
> > > > > > > > we guarantee that the actual queue depth is <= either LUN or host's
> > > > > > > > queue depth. Maybe it depends on your SMR's implementation about handling
> > > > > > > > flush/write IO. Could you check why .queuecommand() fails in block/004?
> > > > > > 
> > > > > > I put some debug prints and confirmed that the .queuecommand function is
> > > > > > ata_scsi_queuecmd() and it returns SCSI_MLQUEUE_DEVICE_BUSY because
> > > > > > ata_std_qc_defer() returns ATA_DEFER_LINK. The comment of ata_std_qc_defer()
> > > > > > notes that "Non-NCQ commands cannot run with any other command, NCQ or not.  As
> > > > > > upper layer only knows the queue depth, we are responsible for maintaining
> > > > > > exclusion.  This function checks whether a new command @qc can be issued." Then
> > > > > > I guess .queuecommand() fails because is that Non-NCQ flush command and NCQ
> > > > > > write command are waiting the completion each other.
> > > > > 
> > > > > OK, got it.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Indeed, that is weird that queuecommand fails. There is nothing SMR specific in
> > > > > > > the AHCI code beside disk probe checks. So write & flush handling does not
> > > > > > > differ between SMR and regular disks. The same applies to the drive side. write
> > > > > > > and flush commands are the normal commands, no change at all. The only
> > > > > > > difference being the sequential write constraint which the drive honors by not
> > > > > > > executing the queued write command out of order. But there are no constraint for
> > > > > > > flush on SMR, so we get whatever the drive does, that is, totally drive dependent.
> > > > > > > 
> > > > > > > I wonder if the issue may be with the particular AHCI chipset used for this test.
> > > > > > > 
> > > > > > > > 
> > > > > > > > Also can you provide queue flags via the following command?
> > > > > > > > 
> > > > > > > > 	cat /sys/kernel/debug/block/sdN/state
> > > > > > 
> > > > > > The state sysfs attribute was as follows:
> > > > > > 
> > > > > > SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|SCSI_PASSTHROUGH|26
> > > > > > 
> > > > > > It didn't change before and after the block/004 run.
> > > > > > 
> > > > > > 
> > > > > > > > 
> > > > > > > > I understand flush request should be slower than normal write, however
> > > > > > > > looks not true in this hardware.
> > > > > > > 
> > > > > > > Probably due to the fact that since the writes are sequential, there is a lot of
> > > > > > > drive internal optimization that can be done to minimize the cost of flush
> > > > > > > (internal data streaming from cache to media, media-cache use, etc) That is true
> > > > > > > for regular disks too. And all of this is highly dependent on the hardware
> > > > > > > implementation.
> > > > > > 
> > > > > > This discussion tempted me to take closer look in the traces. And I noticed that
> > > > > > number of flush commands issued is different with and without the patch.
> > > > > > 
> > > > > >                         | without patch | with patch
> > > > > > ------------------------+---------------+------------
> > > > > > block_getrq: rwbs=FWS   |      32640    |   32640
> > > > > > block_rq_issue: rwbs=FF |      32101    |    7593
> > > > > 
> > > > > Looks issued flush request is too many given the flush machinery
> > > > > should avoid to queue duplicated flush requests.
> > > > > 
> > > > > I will investigate the flush code a bit.
> > > > > 
> > > > > > 
> > > > > > Without the patch, flush command is issued between two write commands. With the
> > > > > > patch, some write commands are executed without flush between them.
> > > > > > 
> > > > > > I wonder how the requeue list position of flush command (head vs tail) changes
> > > > > > the number of flush commands to issue.
> > > > > > 
> > > > > > Another weird thing is number of block_getrq traces of flush (rwds=FWS). It
> > > > > > doubles number of writes (256 * 64 = 16320). I will chase this further.
> > > > > 
> > > > > Indeed, not see such issue when I run the test on kvm ahci.
> > > > 
> > > > I found that the cause of the doubled flush commands is dm-linear device I set
> > > > up. I mapped two areas of single SMR drive to the dm-linear device, using dm
> > > > table with two lines. My understanding is that when a flush is requested to the
> > > > dm-linear device, the flush request is duplicated and forwarded to  destination
> > > > devices listed in dm table lines. In this case, a flush request is duplicated
> > > > for two lines in dm table, and both flush requests go to the single SMR drive.
> > > 
> > > Got it, maybe dm linear should avoid to send two flush requests to
> > > single drive.
> > > 
> > > Can you observe similar issue when running block/004 over the AHCI/SMR
> > > directly?
> 
> Yes. The runtime delta is smaller and I had not noticed that. Without the patch,
> block/004 run on AHCI/SMR drive takes from 115+ seconds. With the patch,
> it takes around 100 seconds.
> 
> I also took the bpf traces and counted flush commands issued. Numbsers look
> similar as those with dm-linear.
> 
>                         | without patch | with patch
> ------------------------+---------------+------------
> block_getrq: rwbs=FWS   |      16320    |   16320
> block_rq_issue: rwbs=FF |      17051    |    5866

BTW, you should count 'block_rq_complete: rwbs=FF' instead of
block_rq_issue() which may be called several times for each flush
request.

Anyway the effect is visible.

> 
> > > 
> > > > This doubles the number of flush commands. I changed the dm table to have single
> > > > line to map single area, and observed the number of flush commands (block_getrq
> > > > with rwbs=FWS) got reduced to 16320, the same number as the write commands.
> > > > 
> > > > This means that the workload I observed the longer runtime of block/004 with
> > > > kernel 5.6-rc4 is really flush intensive. It has two flush commands per one
> > > > write command. It might be too sensitive to flush command behavior. I'm not so
> > > > sure if this is the workload worth performance care.
> > > 
> > > The story may be something like below:
> > > 
> > > 1) sometime, suppose there are two write request(w0, w1) in
> > > dispatch queue(hctx->dispatch), and one flush request is just done,
> > > so blk-mq starts to dispatch requests in hctx->dispatch via wq
> > > 
> > > 2) a new flush request F is scheduled via requeue wq, and the flush
> > > request is added to front of hctx->dispatch, which includes (F, w0, w1)
> > > 
> > > 3) meantime, given there are 64 fio jobs, one of the jobs just run queue 
> > > and queue one rq from scheduler to lld, and hctx->dispatch isn't observed
> > > because of timing, so sata switches to NCQ mode
> > > 
> > > 4) step 1 or 2 starts to run queue, and try to dispatch requests(F, w0, w1).
> > > .queue_rq() returns STS_RESOURCE for F because F is non-NCQ command,
> > > so hctx->dispatch becomes (w0, w1, F) now. And the queue will be re-run
> > > after one write request is completed, so one write IO latency is added
> > > to the flush request F.
> > > 
> > > 5) when flush request latency is increased, chance for flush request
> > > merge is increased, so much less flush requests are issued to sata
> > > in patched kernel, then issuing time for write requests is decreased.
> > > 
> > > If flush request is added to tail of hctx->dispatch in step 2), one
> > > extra IO latency won't be added to flush request, and flush request
> > > can be completed in less time, meantime chance of flush request merge
> > > is reduced much. When more flush requests are issued to sata, more time
> > > is introduced to issuing write IOs.
> > > 
> > > Anyway, this problem is NCQ specific. If it can be reproduced on
> > > AHCI/SMR directly, we may need to fix it.
> > 
> > In short, when adding flush rq to front of hctx->dispatch, it is easier
> > to introduce extra time to flush rq's latency compared with adding to tail
> > of dispatch queue, then chance of flush merge is increased, and less
> > flush requests will be issued to driver/controller, finally this kind of
> > flush workloads is improved.
> 
> Ming, thank you very much for the description.
> 
> > 
> > So maybe we can add flush rq to tail of dispatch just in case of NCQ.
> 
> Reading the line above, I'm not yet sure how the fix will be. Do you mean
> to check if sata driver is in NCQ mode, within blk_kick_flush()?

We may switch to blk_kick_flush(true) directly, and I will figure out one
patch.

Thanks,
Ming

