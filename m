Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BDFC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 22:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20988222C8
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 22:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeWdyNFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgFSWiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:38:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729229AbgFSWiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 18:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592606285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKuitHgDPYShTwVDBSPWX6rDgM+R9fFbQxKkuH+aFJY=;
        b=FeWdyNFQ17N7ldkslMu6y4STA//NuBAR66XadVdGWf98w1eDcudlE9xTLbum80i5pJ1u+d
        jIG1XPtwmT2adGUPKb4Vtc9OkcQCsTNUf4T8QPFL1VktzfWOD69f6dFc4nLUA3LVnP106d
        tDp2vKuDE9CLKnV4ujGDWpZpnNw3irg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-xcoEw7QqMhuIsnHFLK6Pqg-1; Fri, 19 Jun 2020 18:38:01 -0400
X-MC-Unique: xcoEw7QqMhuIsnHFLK6Pqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1CA3EC1A0;
        Fri, 19 Jun 2020 22:38:00 +0000 (UTC)
Received: from T590 (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9BEA5BAD1;
        Fri, 19 Jun 2020 22:37:49 +0000 (UTC)
Date:   Sat, 20 Jun 2020 06:37:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org, axboe@kernel.dk,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Message-ID: <20200619223744.GB353853@T590>
References: <20200619084214.337449-1-ming.lei@redhat.com>
 <20200619094250.GA18410@redhat.com>
 <20200619101142.GA339442@T590>
 <20200619160657.GA24520@redhat.com>
 <20200619174040.GA24968@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619174040.GA24968@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19, 2020 at 01:40:41PM -0400, Mike Snitzer wrote:
> On Fri, Jun 19 2020 at 12:06pm -0400,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > On Fri, Jun 19 2020 at  6:11am -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > Hi Mike,
> > > 
> > > On Fri, Jun 19, 2020 at 05:42:50AM -0400, Mike Snitzer wrote:
> > > > Hi Ming,
> > > > 
> > > > Thanks for the patch!  But I'm having a hard time understanding what
> > > > you've written in the patch header,
> > > > 
> > > > On Fri, Jun 19 2020 at  4:42am -0400,
> > > > Ming Lei <ming.lei@redhat.com> wrote:
> > > > 
> > > > > dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
> > > > > remove the check.
> > > > 
> > > > It'd be helpful if you could unpack this with more detail before going on
> > > > to explain why using blk_queue_quiesced, despite dm-rq using
> > > > blk_mq_queue_stopped, would also be ineffective.
> > > > 
> > > > SO:
> > > > 
> > > > > dm-rq won't stop queue
> > > > 
> > > > 1) why won't dm-rq stop the queue?  Do you mean it won't reliably
> > > >    _always_ stop the queue because of the blk_mq_queue_stopped() check?
> > > 
> > > device mapper doesn't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues.
> > > 
> > > > 
> > > > > meantime blk-mq won't stop one queue too, so remove the check.
> > > > 
> > > > 2) Meaning?: blk_mq_queue_stopped() will return true even if only one hw
> > > > queue is stopped, given blk-mq must stop all hw queues a positive return
> > > > from this blk_mq_queue_stopped() check is incorrectly assuming it meanss
> > > > all hw queues are stopped.
> > > 
> > > blk-mq won't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues for
> > > dm-rq's queue too, so dm-rq's hw queue won't be stopped.
> > > 
> > > BTW blk_mq_stop_hw_queue or blk_mq_stop_hw_queues are supposed to be
> > > used for throttling queue.
> > 
> > I'm going to look at actually stopping the queue (using one of these
> > interfaces).  I didn't realize I wasn't actually stopping the queue.
> > The intent was to do so.
> > 
> > In speaking with Jens yesterday about freeze vs stop: it is clear that
> > dm-rq needs to still be able to allocate new requests, but _not_ call
> > the queue_rq to issue the requests, while "stopped" (due to dm-mpath
> > potentially deferring retries of failed requests because of path failure
> > while quiescing the queue during DM device suspend).  But that freezing
> > the queue goes too far because it won't allow such request allocation.
> 
> Seems I'm damned if I do (stop) or damned if I don't (new reports of
> requests completing after DM device suspend's
> blk_mq_quiesce_queue()+dm_wait_for_completion()).

request(but not new) completing is possible after blk_mq_quiesce_queue()+
dm_wait_for_completion, because blk_mq_rq_inflight() only checks INFLIGHT
request. If all requests are marked as MQ_RQ_COMPLETE, blk_mq_rq_inflight()
still may return false. However, MQ_RQ_COMPLETE is one transient state.

So what does dm-rq expect from dm_wait_for_completion()?

If it is just no new request entering dm_queue_rq(), there shouldn't be
issue.

If dm-rq hopes there aren't any real inflight request(MQ_RQ_COMPLETE &
MQ_RQ_INFLIGHT), we can change blk_mq_rq_inflight to support that.


Thanks, 
Ming

