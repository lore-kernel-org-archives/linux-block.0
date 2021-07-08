Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8DDC07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 07:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F66261CE2
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 07:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhGHH0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 03:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhGHH0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jul 2021 03:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625728999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aoZiGpC6Kf/0gFWXqlk5P9SaFK1vqVElFixbZ4rq5Zo=;
        b=SlC5NB+A15cqCbUwmA1YEP7ldwc0MqT3znBXrlhxo9zoiJESn8Dk9r0Yh9UQ0/QT1t/laC
        C+QsiQMXSRLB2u2OlunF65g3ZZpXISaOX00Fp3gv46vbrzzkCTIGde8CGO5H+cFvP+qwkg
        R3rjms+7pZp5EgFfAZBuLsNeahT+5bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-3mKM26BrM1SyljauJIAMtQ-1; Thu, 08 Jul 2021 03:23:18 -0400
X-MC-Unique: 3mKM26BrM1SyljauJIAMtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7775E1018721;
        Thu,  8 Jul 2021 07:23:17 +0000 (UTC)
Received: from T590 (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3612D5C1D5;
        Thu,  8 Jul 2021 07:23:10 +0000 (UTC)
Date:   Thu, 8 Jul 2021 15:23:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 2/6] loop: conver timer for monitoring idle worker into
 dwork
Message-ID: <YOan25RwpSs/A27W@T590>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-3-ming.lei@redhat.com>
 <20210706055227.GG17027@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706055227.GG17027@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 07:52:27AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 05, 2021 at 06:26:03PM +0800, Ming Lei wrote:
> > +static void loop_free_idle_workers(struct work_struct *work)
> > +{
> > +	struct loop_device *lo = container_of(work, struct loop_device,
> > +			idle_work.work);
> > +	struct loop_worker *pos, *worker;
> > +
> > +	spin_lock(&lo->lo_work_lock);
> > +	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > +				idle_list) {
> > +		if (time_is_after_jiffies(worker->last_ran_at +
> > +						LOOP_IDLE_WORKER_TIMEOUT))
> > +			break;
> > +		list_del(&worker->idle_list);
> > +		rb_erase(&worker->rb_node, &lo->worker_tree);
> > +		css_put(worker->blkcg_css);
> > +		kfree(worker);
> > +	}
> > +	if (!list_empty(&lo->idle_worker_list))
> > +		loop_set_timer(lo);
> > +	spin_unlock(&lo->lo_work_lock);
> > +}
> > +
> > +
> 
> Double empty line.  But that whole fact that the loop driver badly
> reimplements work queues is just fucked up.  We need to revert this
> shit.

Can you explain why work queues are bad for fixing this blkcg/memcg
issue?


Thanks, 
Ming

