Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BCC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 11:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A432065F
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 11:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bab6Uq15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgERLzJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 07:55:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgERLzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 07:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589802908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bYPv19dlypm02w8pxLkkDOLuFfUFPx0vbP628J02dc=;
        b=Bab6Uq15cLAa/mGpCvz6oGs55jrqNpD82JjGkyK67hV7Cz924PrNJyxJnBnWOtaFm3CYBs
        zCHrqgxPmrx5HmkGp2e1SKXDb/A8PjuzbJWI6Tt7c48bzWmy6go40v1FLX0jZ0oAEEgmKc
        ZUPN2maIKcaFKtBc+HgLlG9Jrl2/MH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-CMlDpOC-N6eeozz-YPh-nw-1; Mon, 18 May 2020 07:55:06 -0400
X-MC-Unique: CMlDpOC-N6eeozz-YPh-nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FD49872FE0;
        Mon, 18 May 2020 11:55:05 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42B5178B5E;
        Mon, 18 May 2020 11:54:58 +0000 (UTC)
Date:   Mon, 18 May 2020 19:54:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200518115454.GA46364@T590>
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imgty15d.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 12:42:54PM +0200, Thomas Gleixner wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> > On Mon, May 18, 2020 at 10:32:22AM +0200, Thomas Gleixner wrote:
> >> Christoph Hellwig <hch@lst.de> writes:
> >> Is this absolutely necessary to be a smp function call? That's going to
> >
> > I think it is.
> >
> > Request is bound to the allocation CPU and the hw queue(hctx) which is
> > mapped from the allocation CPU.
> >
> > If request is allocated from one cpu which is going to offline, we can't
> > handle that easily.
> 
> That's a pretty handwavy explanation and does not give any reason why
> this needs to be a smp function call and cannot be solved otherwise,
> e.g. by delegating this to a work queue.

I guess I misunderstood your point, sorry for that.

The requirement is just that the request needs to be allocated on one online
CPU after INACTIVE is set, and we can use a workqueue to do that.

> 
> >> be problematic vs. RT. Same applies to the explicit preempt_disable() in
> >> patch 7.
> >
> > I think it is true and the reason is same too, but the period is quite short,
> > and it is just taken for iterating several bitmaps for finding one free bit.
> 
> And takes spinlocks along the way.... See:
> 
>   https://www.kernel.org/doc/html/latest/locking/locktypes.html
> 
> for a full explanation why this can't work on RT. And that's the same
> reason why the smp function call will fall apart on a RT enabled kernel.

We do want to avoid the cost of any lock, because it is in the fast IO path.

Looks preempt_disable in patch 7 can't be avoided.

Thanks,
Ming

