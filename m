Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F54C04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 03:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7C02081C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 03:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7C02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeLEDDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:03:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbeLEDDK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 22:03:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96845307DAB6;
        Wed,  5 Dec 2018 03:03:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74CC418E30;
        Wed,  5 Dec 2018 03:03:05 +0000 (UTC)
Date:   Wed, 5 Dec 2018 11:03:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181205030300.GG17845@ming.t460p>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013736.GD17845@ming.t460p>
 <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
 <20181205022716.GE17845@ming.t460p>
 <227a40a3-6599-9fc0-ab58-674f063e9c3a@kernel.dk>
 <20181205025801.GF17845@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205025801.GF17845@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 05 Dec 2018 03:03:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05, 2018 at 10:58:02AM +0800, Ming Lei wrote:
> On Tue, Dec 04, 2018 at 07:30:24PM -0700, Jens Axboe wrote:
> > On 12/4/18 7:27 PM, Ming Lei wrote:
> > > On Tue, Dec 04, 2018 at 07:16:11PM -0700, Jens Axboe wrote:
> > >> On 12/4/18 6:37 PM, Ming Lei wrote:
> > >>> On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
> > >>>> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
> > >>>> we queue the request up normally. However, the SCSI layer may have
> > >>>> already setup SG tables etc for this particular command. If we later
> > >>>> merge with this request, then the old tables are no longer valid. Once
> > >>>> we issue the IO, we only read/write the original part of the request,
> > >>>> not the new state of it.
> > >>>>
> > >>>> This causes data corruption, and is most often noticed with the file
> > >>>> system complaining about the just read data being invalid:
> > >>>>
> > >>>> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
> > >>>>
> > >>>> because most of it is garbage...
> > >>>>
> > >>>> This doesn't happen from the normal issue path, as we will simply defer
> > >>>> the request to the hardware queue dispatch list if we fail. Once it's on
> > >>>> the dispatch list, we never merge with it.
> > >>>>
> > >>>> Fix this from the direct issue path by flagging the request as
> > >>>> REQ_NOMERGE so we don't change the size of it before issue.
> > >>>>
> > >>>> See also:
> > >>>>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
> > >>>>
> > >>>> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> > >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >>>>
> > >>>> ---
> > >>>>
> > >>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> > >>>> index 3f91c6e5b17a..d8f518c6ea38 100644
> > >>>> --- a/block/blk-mq.c
> > >>>> +++ b/block/blk-mq.c
> > >>>> @@ -1715,6 +1715,15 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
> > >>>>  		break;
> > >>>>  	case BLK_STS_RESOURCE:
> > >>>>  	case BLK_STS_DEV_RESOURCE:
> > >>>> +		/*
> > >>>> +		 * If direct dispatch fails, we cannot allow any merging on
> > >>>> +		 * this IO. Drivers (like SCSI) may have set up permanent state
> > >>>> +		 * for this request, like SG tables and mappings, and if we
> > >>>> +		 * merge to it later on then we'll still only do IO to the
> > >>>> +		 * original part.
> > >>>> +		 */
> > >>>> +		rq->cmd_flags |= REQ_NOMERGE;
> > >>>> +
> > >>>>  		blk_mq_update_dispatch_busy(hctx, true);
> > >>>>  		__blk_mq_requeue_request(rq);
> > >>>>  		break;
> > >>>>
> > >>>
> > >>> Not sure it is enough to just mark it as NOMERGE, for example, driver
> > >>> may have setup the .special_vec for discard, and NOMERGE may not prevent
> > >>> request from entering elevator queue completely. Cause 'rq.rb_node' and
> > >>> 'rq.special_vec' share same space.
> > >>
> > >> We should rather limit the scope of the direct dispatch instead. It
> > >> doesn't make sense to do for anything but read/write anyway.
> > > 
> > > discard is kind of write, and it isn't treated very specially in make
> > > request path, except for multi-range discard.
> > 
> > The point of direct dispatch is to reduce latencies for requests,
> > discards are so damn slow on ALL devices anyway that it doesn't make any
> > sense to try direct dispatch to begin with, regardless of whether it
> > possible or not.
> 
> SCSI MQ device may benefit from direct dispatch from reduced lock contention.
> 
> > 
> > >>> So how about inserting this request via blk_mq_request_bypass_insert()
> > >>> in case that direct issue returns BUSY? Then it is invariant that
> > >>> any request queued via .queue_rq() won't enter scheduler queue.
> > >>
> > >> I did consider this, but I didn't want to experiment with exercising
> > >> a new path for an important bug fix. You do realize that your original
> > >> patch has been corrupting data for months? I think a little caution
> > >> is in order here.
> > > 
> > > But marking NOMERGE still may have a hole on re-insert discard request as
> > > mentioned above.
> > 
> > What I said was further limit the scope of direct dispatch, which means
> > not allowing anything that isn't a read/write.
> 
> IMO, the conservative approach is to take the one used in legacy io
> path, in which it is never allowed to re-insert queued request to
> scheduler queue except for requeue, however RQF_DONTPREP is cleared
> before requeuing request to scheduler.
> 
> > 
> > > Given we never allow to re-insert queued request to scheduler queue
> > > except for 6ce3dd6eec1, I think it is the correct thing to do, and the
> > > fix is simple too.
> > 
> > As I said, it's not the time to experiment. This issue has been there
> > since 4.19-rc1. The alternative is yanking both those patches, and then
> > looking at it later when the direct issue path has been cleaned up
> > first.
> 
> The issue should have been there from v4.1, especially after commit
> f984df1f0f7 ("blk-mq: do limited block plug for multiple queue case"),
> which is the 1st one to re-insert the queued request into scheduler
> queue.

But at that time, there isn't io scheduler for MQ, so in theory the
issue should be there since v4.11, especially 945ffb60c11d ("mq-deadline:
add blk-mq adaptation of the deadline IO scheduler").

Thanks,
Ming
