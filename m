Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA3C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJUA6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJUA6G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 20:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AD220F9D
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666313883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qG8591Xly/v0qWxUjLRp/EASy0SBvAr2VHzhz10020A=;
        b=gPUYnCJInxVv3Rb7vv+hGQPadmmzvPBTczmo5rcEFeB+IPW9uGsrF/Cmi8ojzbrW7E75Eb
        4S5D5m7PSWll+VhfVDrhS7rD3Tozm5SSbU5+XqCBOLIugRmx6y9pKOw3C8JVDMlzL4mqYU
        MQnpDDj3NtKlcV/CTjf4dzUyn9c9CVo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-0wpCcC_WPSy-6gDMJBGIww-1; Thu, 20 Oct 2022 20:57:57 -0400
X-MC-Unique: 0wpCcC_WPSy-6gDMJBGIww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62761811E7A;
        Fri, 21 Oct 2022 00:57:57 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CDFB40611D;
        Fri, 21 Oct 2022 00:57:50 +0000 (UTC)
Date:   Fri, 21 Oct 2022 08:57:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        djeffery@redhat.com, stefanha@redhat.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1HuiFXyQ1k+OH92@T590>
References: <Y1EQdafQlKNAsutk@T590>
 <7d5eae39-3a56-df7d-eb72-3cb910c2b802@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5eae39-3a56-df7d-eb72-3cb910c2b802@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 01:26:48PM -0700, Bart Van Assche wrote:
> On 10/20/22 02:10, Ming Lei wrote:
> > [ ... ]
> 
> Hi Ming,
> 
> Fixing this in the block layer seems fine to me. A few comments:
> 
> > +	/* Before walking tags, we must ensure any submit started before the
> > +	 * current time has finished. Since the submit uses srcu or rcu, wait
> > +	 * for a synchronization point to ensure all running submits have
> > +	 * finished
> > +	 */
> 
> Should the above comment follow the style of other comments in the block
> layer?

OK.

> 
> > +	blk_mq_wait_quiesce_done(q);
> > +
> > +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
> 
> The above doesn't look sufficient to me since .queue_rq() may be called
> while blk_mq_queue_tag_busy_iter() is in progress. How about moving the
> blk_mq_wait_quiesce_done() call into blk_mq_check_expired() and preventing
> new .queue_rq() calls before the timeout handler is called?

blk_mq_timeout_work() records the time before calling
blk_mq_wait_quiesce_done(), and only handle requests which is timed out
before the recorded jiffies, so new queued request won't be covered
in this time.

Thanks,
Ming

