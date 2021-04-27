Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD16C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62D4610A5
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhD0CqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhD0CqR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 22:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619491535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NH3Bcbw1litc80dcD//wh5iCmolM4HxV0+KAzfdKtSw=;
        b=UMVgpFS+ByApBV7ush7u8LFUquGEoLELgXeX93q4cS8DBc69VJmVS2BdYhaL8EuAgMRhxo
        WY5szZTcW8w1gNWCSPUe/wzlRIptPTMw38z5agQmXC/ZDRRZOcC2coybehmJtxIKM4IZug
        Mz0LeZhMSAyMROnULKVunm76cxS7KD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-xylSy7rxNBSYzyUXrHIy8g-1; Mon, 26 Apr 2021 22:45:31 -0400
X-MC-Unique: xylSy7rxNBSYzyUXrHIy8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8E6D8030B5;
        Tue, 27 Apr 2021 02:45:29 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A163A5D9DE;
        Tue, 27 Apr 2021 02:45:22 +0000 (UTC)
Date:   Tue, 27 Apr 2021 10:45:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V2 1/3] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
Message-ID: <YId6yAzoIeU/nVrF@T590>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
 <20210427014540.2747282-2-ming.lei@redhat.com>
 <e0cd9c25-60e1-507d-4fc3-f6ea4ac4ca86@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0cd9c25-60e1-507d-4fc3-f6ea4ac4ca86@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 07:28:18PM -0700, Bart Van Assche wrote:
> On 4/26/21 6:45 PM, Ming Lei wrote:
> > + * We grab one request reference before calling @fn and release it after
> > + * @fn returns. So far we don't support to pass the request reference to
> > + * one new conetxt in @fn.
>               ^^^^^^^
>               context?
> 
> > +void blk_mq_put_rq_ref(struct request *rq)
> > +{
> > +	if (is_flush_rq(rq, rq->mq_hctx))
> > +		rq->end_io(rq, 0);
> > +	else if (refcount_dec_and_test(&rq->ref))
> > +		__blk_mq_free_request(rq);
> > +}
> 
> Will rq->end_io() be called twice when a tag iteration function
> encounters a flush request?

It could be, see flush_end_io():

static void flush_end_io(struct request *flush_rq, blk_status_t error)
{
		...
        spin_lock_irqsave(&fq->mq_flush_lock, flags);

        if (!refcount_dec_and_test(&flush_rq->ref)) {
                fq->rq_status = error;
                spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
				return;
		}
		...


Thanks,
Ming

