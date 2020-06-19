Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8849C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CDE21532
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzjAdDqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbgFSQHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:07:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48354 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392075AbgFSQHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 12:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVZfiM/+ZxLNLKJaElbS7LuEpwS96Yl3jOTXFRnUgWg=;
        b=dzjAdDqoV+1bVVRx35+gGnWsit9pQS5qc0Ign1ZOm3CZmTaOLHz0mzJhOkdP5HaaxJzvXq
        mFhV6N6OMCk1DYH6e63E+Um710hMzI2NLDgJnlBzOTi83buxtfvYvBAoDWLic+xA5NCbsZ
        vQG/hjq/ddhJ1vjTi2gS2qN7xey2Fto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-i3JkU1XGP3OCo6NOhkl5OA-1; Fri, 19 Jun 2020 12:07:12 -0400
X-MC-Unique: i3JkU1XGP3OCo6NOhkl5OA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EC411030C28;
        Fri, 19 Jun 2020 16:07:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADA8419D7B;
        Fri, 19 Jun 2020 16:06:58 +0000 (UTC)
Date:   Fri, 19 Jun 2020 12:06:57 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Message-ID: <20200619160657.GA24520@redhat.com>
References: <20200619084214.337449-1-ming.lei@redhat.com>
 <20200619094250.GA18410@redhat.com>
 <20200619101142.GA339442@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619101142.GA339442@T590>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19 2020 at  6:11am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> Hi Mike,
> 
> On Fri, Jun 19, 2020 at 05:42:50AM -0400, Mike Snitzer wrote:
> > Hi Ming,
> > 
> > Thanks for the patch!  But I'm having a hard time understanding what
> > you've written in the patch header,
> > 
> > On Fri, Jun 19 2020 at  4:42am -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
> > > remove the check.
> > 
> > It'd be helpful if you could unpack this with more detail before going on
> > to explain why using blk_queue_quiesced, despite dm-rq using
> > blk_mq_queue_stopped, would also be ineffective.
> > 
> > SO:
> > 
> > > dm-rq won't stop queue
> > 
> > 1) why won't dm-rq stop the queue?  Do you mean it won't reliably
> >    _always_ stop the queue because of the blk_mq_queue_stopped() check?
> 
> device mapper doesn't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues.
> 
> > 
> > > meantime blk-mq won't stop one queue too, so remove the check.
> > 
> > 2) Meaning?: blk_mq_queue_stopped() will return true even if only one hw
> > queue is stopped, given blk-mq must stop all hw queues a positive return
> > from this blk_mq_queue_stopped() check is incorrectly assuming it meanss
> > all hw queues are stopped.
> 
> blk-mq won't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues for
> dm-rq's queue too, so dm-rq's hw queue won't be stopped.
> 
> BTW blk_mq_stop_hw_queue or blk_mq_stop_hw_queues are supposed to be
> used for throttling queue.

I'm going to look at actually stopping the queue (using one of these
interfaces).  I didn't realize I wasn't actually stopping the queue.
The intent was to do so.

In speaking with Jens yesterday about freeze vs stop: it is clear that
dm-rq needs to still be able to allocate new requests, but _not_ call
the queue_rq to issue the requests, while "stopped" (due to dm-mpath
potentially deferring retries of failed requests because of path failure
while quiescing the queue during DM device suspend).  But that freezing
the queue goes too far because it won't allow such request allocation.

> > > dm_stop_queue() actually tries to quiesce hw queues via blk_mq_quiesce_queue(),
> > > we can't check via blk_queue_quiesced for avoiding unnecessary queue
> > > quiesce because the flag is set before synchronize_rcu() and dm_stop_queue
> > > may be called when synchronize_rcu from another blk_mq_quiesce_queue is
> > > in-progress.
> > 
> > But I'm left with questions/confusion on this too:
> > 
> > 1) you mention blk_queue_quiesced instead of blk_mq_queue_stopped, so I
> >    assume you mean that: not only is blk_mq_queue_stopped()
> >    ineffective, blk_queue_quiesced() would be too?
> 
> blk_mq_queue_stopped isn't necessary because dm-rq's hw queue won't be
> stopped by anyone, meantime replacing it with blk_queue_quiesced() is wrong.
> 
> > 
> > 2) the race you detail (with competing blk_mq_quiesce_queue) relative to
> >    synchronize_rcu() and testing "the flag" is very detailed yet vague.
> 
> If two code paths are calling dm_stop_queue() at the same time, one path may
> return immediately and it is wrong, sine synchronize_rcu() from another path
> may not be done.
> 
> > 
> > Anyway, once we get this heaader cleaned up a bit more I'll be happy to
> > get this staged as a stable@ fix for 5.8 inclusion ASAP.
> 
> This patch isn't a fix, and it shouldn't be related with rhel8's issue.

I realize that now.  I've changed the patch header to be a bit clearer
and staged it for 5.9, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.9&id=06e788ed59e0095b679bdce9e39c1a251032ae62

Thanks,
Mike

