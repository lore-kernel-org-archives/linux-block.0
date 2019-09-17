Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CECC49ED7
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4625A20640
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 00:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfIQAuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732054AbfIQAuo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 20:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B0893082132;
        Tue, 17 Sep 2019 00:50:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44FA35D6A9;
        Tue, 17 Sep 2019 00:50:36 +0000 (UTC)
Date:   Tue, 17 Sep 2019 08:50:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@infradead.org,
        keith.busch@intel.com, tj@kernel.org, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
Message-ID: <20190917005030.GD6199@ming.t460p>
References: <20190907102450.40291-1-yuyufen@huawei.com>
 <20190912024618.GE2731@ming.t460p>
 <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
 <20190912041658.GA5020@ming.t460p>
 <d3549c6d-ca07-efa9-af15-7cee61ce5ff2@huawei.com>
 <20190912100755.GB9897@ming.t460p>
 <04b485ad-90e6-7752-b74f-9694de9c22a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b485ad-90e6-7752-b74f-9694de9c22a6@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 17 Sep 2019 00:50:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 16, 2019 at 05:27:39PM +0800, Yufen Yu wrote:
> 
> 
> On 2019/9/12 18:07, Ming Lei wrote:
> > On Thu, Sep 12, 2019 at 04:49:15PM +0800, Yufen Yu wrote:
> > > 
> > > On 2019/9/12 12:16, Ming Lei wrote:
> > > > On Thu, Sep 12, 2019 at 11:29:18AM +0800, Yufen Yu wrote:
> > > > > On 2019/9/12 10:46, Ming Lei wrote:
> > > > > > On Sat, Sep 07, 2019 at 06:24:50PM +0800, Yufen Yu wrote:
> > > > > > > There is a race condition between timeout check and completion for
> > > > > > > flush request as follow:
> > > > > > > 
> > > > > > > timeout_work    issue flush      issue flush
> > > > > > >                    blk_insert_flush
> > > > > > >                                     blk_insert_flush
> > > > > > > blk_mq_timeout_work
> > > > > > >                    blk_kick_flush
> > > > > > > 
> > > > > > > blk_mq_queue_tag_busy_iter
> > > > > > > blk_mq_check_expired(flush_rq)
> > > > > > > 
> > > > > > >                    __blk_mq_end_request
> > > > > > >                   flush_end_io
> > > > > > >                   blk_kick_flush
> > > > > > >                   blk_rq_init(flush_rq)
> > > > > > >                   memset(flush_rq, 0)
> > > > > > Not see there is memset(flush_rq, 0) in block/blk-flush.c
> > > > > Call path as follow:
> > > > > 
> > > > > blk_kick_flush
> > > > >       blk_rq_init
> > > > >           memset(rq, 0, sizeof(*rq));
> > > > Looks I miss this one in blk_rq_init(), sorry for that.
> > > > 
> > > > Given there are only two users of blk_rq_init(), one simple fix could be
> > > > not clearing queue in blk_rq_init(), something like below?
> > > > 
> > > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > > index 77807a5d7f9e..25e6a045c821 100644
> > > > --- a/block/blk-core.c
> > > > +++ b/block/blk-core.c
> > > > @@ -107,7 +107,9 @@ EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
> > > >    void blk_rq_init(struct request_queue *q, struct request *rq)
> > > >    {
> > > > -	memset(rq, 0, sizeof(*rq));
> > > > +	const int offset = offsetof(struct request, q);
> > > > +
> > > > +	memset((void *)rq + offset, 0, sizeof(*rq) - offset);
> > > >    	INIT_LIST_HEAD(&rq->queuelist);
> > > >    	rq->q = q;
> > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > index 1ac790178787..382e71b8787d 100644
> > > > --- a/include/linux/blkdev.h
> > > > +++ b/include/linux/blkdev.h
> > > > @@ -130,7 +130,7 @@ enum mq_rq_state {
> > > >     * especially blk_mq_rq_ctx_init() to take care of the added fields.
> > > >     */
> > > >    struct request {
> > > > -	struct request_queue *q;
> > > > +	struct request_queue *q;	/* Must be the 1st field */
> > > >    	struct blk_mq_ctx *mq_ctx;
> > > >    	struct blk_mq_hw_ctx *mq_hctx;
> > > Not set req->q as '0' can just avoid BUG_ON for NULL pointer deference.
> > > 
> > > However, the root problem is that 'flush_rq' have been reused while
> > > timeout function handle it currently. That means mq_ops->timeout() may
> > > access old values remained by the last flush request and make the wrong
> > > decision.
> > > 
> > > Take the race condition in the patch as an example.
> > > 
> > > blk_mq_check_expired
> > >      blk_mq_rq_timed_out
> > >          req->q->mq_ops->timeout  // Driver timeout handle may read old data
> > >      refcount_dec_and_test(&rq)
> > >      __blk_mq_free_request   // If rq have been reset has '1' in
> > > blk_rq_init(), it will be free here.
> > > 
> > > So, I think we should solve this problem completely. Just like normal
> > > request,
> > > we can prevent flush request to call end_io when timeout handle the request.
> > Seems it isn't specific for 'flush_rq', and it should be one generic issue
> > for any request which implements .end_io.
> > 
> > For requests without defining .end_io, rq->ref is applied for protecting
> > its lifetime. However, rq->end_io() is still called even if rq->ref doesn't
> > drop to zero.
> > 
> > If the above is correct, we need to let rq->ref to cover rq->end_io().
> 
> We ignore the fact that we may also need to free 'rq' after calling
> rq->end_io(),
> such as end_clone_request(), mq_flush_data_end_io().
> 
> If  we let 'rq->ref' to cover rq->end_io(), 'rq->ref' have been decreased to
> '0'
> before calling __blk_mq_free_request(). Then, the function will never be
> called.
> 
> So, I think flush request may need to be fixed individually.

Thinking of this issue further, given other cases of .end_io() still
depends on blk_mq_free_request() for freeing request, it is fine
to just fix flush request.


Thanks,
Ming
