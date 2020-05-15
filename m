Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6906FC433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 05:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE3206F1
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 05:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAYhO/Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgEOFU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 01:20:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgEOFU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 01:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589520027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RLwEWphyXpszEwZoXwBBQJ0iHEkVj3U/lfVkRLc0jOg=;
        b=bAYhO/MeaOnx2SguBSv/izJwYf7RwY2vuBZAGHBtqC3cg8S7hbRLKFA+StcVS6KvRJtcm5
        raJ4UI1rk4Hers8GjsOWLND1wEL7MNFqWP0dex3P56IfylpoivRUzjSgtIJYg0XiUL2+io
        wnnTp49ykFgm1Xr6oy/orQ4EF1C1iyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-sJroh9WXNrSqMxS0ZGknTQ-1; Fri, 15 May 2020 01:20:24 -0400
X-MC-Unique: sJroh9WXNrSqMxS0ZGknTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A361107ACCD;
        Fri, 15 May 2020 05:20:22 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B0F2E166;
        Fri, 15 May 2020 05:20:14 +0000 (UTC)
Date:   Fri, 15 May 2020 13:20:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/6] blk-mq: stop to allocate new requst and drain
 request before hctx becomes inactive
Message-ID: <20200515052010.GA2291470@T590>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
 <20200515014153.2403464-7-ming.lei@redhat.com>
 <f9af5f96-aa46-629d-0193-7ce69ac8781a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9af5f96-aa46-629d-0193-7ce69ac8781a@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 08:55:34PM -0700, Bart Van Assche wrote:
> On 2020-05-14 18:41, Ming Lei wrote:
> > +	/* Prevent new request from being allocated on the current hctx/cpu */
> > +	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> 
> What guarantees that this change has been observed by all CPUs before
> the blk_mq_tags_has_request() loop finishes?

We don't need all CPUs to observe this INACTIVE flag, and just need
allocation from the current CPU to observe this flag.

The current CPU is the last online CPU of this hctx, so:

1) any requests which are allocated from this cpu will either be drained
by blk_mq_tags_has_request(), or allocated remotely, see blk_mq_get_request().

2) for any requests which are allocated from other offline CPUs of this
hctx, their tag bits have been committed to memory before that cpu offline,
so the current cpu(blk_mq_hctx_notify_offline) can observe their tags bit
reliably, also each cpu offline handling is strictly serialized.

> 
> > +	/*
> > +	 * Grab one refcount for avoiding scheduler switch, and
> > +	 * return immediately if queue has been frozen.
> > +	 */
> > +	if (!percpu_ref_tryget(&q->q_usage_counter))
> > +		return 0;
> 
> If percpu_ref_tryget(&q->q_usage_counter) fails that means either that
> request queue freezing is in progress or that a request queue has been
> frozen. I don't think that it is safe to return immediately if request
> queue freezing is still in progress.

static inline bool percpu_ref_tryget(struct percpu_ref *ref)
{
        unsigned long __percpu *percpu_count;
        bool ret;

        rcu_read_lock();

        if (__ref_is_percpu(ref, &percpu_count)) {
                this_cpu_inc(*percpu_count);
                ret = true;
        } else {
                ret = atomic_long_inc_not_zero(&ref->count);
        }       
        
        rcu_read_unlock();

        return ret;
}

If percpu_ref_tryget returns false, that means the atomic refcount
has become zero, so the request queue has been frozen, and we are safe
to return. Or my understanding on atomic_long_inc_not_zero() is wrong? :-)


Thanks,
Ming

