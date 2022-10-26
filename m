Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21492C38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 00:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiJZAVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiJZAVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 20:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80382CAE7A
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666743700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJVTvBkVHMZ/lT8r9tRA2ACgcAQ2VeGXc5dkhOHZb+4=;
        b=X0D0hmZZQCFSlRd//3OUQwk+7Vll7/AjWcOKObR3/xlV15aUPjhzn+X+/C4ir0nec19vAd
        rb73R/rlAoC8+dHI5Tv9sPLSZZZ5NYAQkNuBDnPkK6THrJpNYg01GRh2mMZ5Pg9LVDz32b
        T7cj1oa1zLb+gFI99clI0GLZ/77+BcE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-MAUn63qdMM-rl5IPi0RQvw-1; Tue, 25 Oct 2022 20:21:35 -0400
X-MC-Unique: MAUn63qdMM-rl5IPi0RQvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 808CC3C10149;
        Wed, 26 Oct 2022 00:21:34 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F5E640C6EC6;
        Wed, 26 Oct 2022 00:21:27 +0000 (UTC)
Date:   Wed, 26 Oct 2022 08:21:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early
 timeout
Message-ID: <Y1h9fiY8TYD8HK5v@T590>
References: <20221025005501.281460-1-ming.lei@redhat.com>
 <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 12:11:39PM -0600, Jens Axboe wrote:
> On 10/24/22 6:55 PM, Ming Lei wrote:
> > @@ -1593,10 +1598,18 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  	if (!percpu_ref_tryget(&q->q_usage_counter))
> >  		return;
> >  
> > -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> > +	/*
> > +	 * Before walking tags, we must ensure any submit started before
> > +	 * the current time has finished. Since the submit uses srcu or rcu,
> > +	 * wait for a synchronization point to ensure all running submits
> > +	 * have finished
> > +	 */
> > +	blk_mq_wait_quiesce_done(q);
> 
> I'm a little worried about this bit - so we'll basically do a sync RCU
> every time the timeout timer runs... Depending on machine load, that
> can take a long time.

Yeah, the per-queue timeout timer is never canceled after request is
completed, so most of times the timeout work does nothing.

Can we run the sync RCU only if there is timed out request found? Then
the wait is only needed in case that timeout handling is required. Also
sync rcu is already done in some driver's ->timeout().


Thanks,
Ming

