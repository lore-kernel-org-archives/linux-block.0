Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D6C18E5B
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383220679
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4l7y9ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgCPPhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:37:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33064 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731671AbgCPPhL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 11:37:11 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 11:37:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584373030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9NYthtSyS0TAEKXo9BxTrSBFRL6EUd/t78j4Okqe78=;
        b=F4l7y9nyO0y/YIEggr5THyY/GhIp3+ZFOe1XKTMMdoHywuk9cmJeTS3NB+jPr+MF85YDm0
        gD4JDPT6XBH6GA+VL5W07Xt+c1ab7n/0eL9oCb723wF0sL4gVhZOgeiJ66EGjT4rGvgKZR
        z6BzpGwDnO/zmSOSe4/2zbOMHij4w+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436--xwhKOgqNiyCSqdkrDohug-1; Mon, 16 Mar 2020 11:31:00 -0400
X-MC-Unique: -xwhKOgqNiyCSqdkrDohug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D481105616;
        Mon, 16 Mar 2020 15:30:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 307C11CB;
        Mon, 16 Mar 2020 15:30:47 +0000 (UTC)
Date:   Mon, 16 Mar 2020 23:30:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nbd: make starting request more reasonable
Message-ID: <20200316153033.GA11016@ming.t460p>
References: <20200303130843.12065-1-yuyufen@huawei.com>
 <9cdba8b1-f0e5-a079-8d44-0078478dd4d8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdba8b1-f0e5-a079-8d44-0078478dd4d8@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 16, 2020 at 08:26:35PM +0800, Yufen Yu wrote:
> Ping and Cc to more expert in blk-mq.
> 
> On 2020/3/3 21:08, Yufen Yu wrote:
> > Our test robot reported a warning for refcount_dec trying to decrease
> > value '0'. The reason is that blk_mq_dispatch_rq_list() try to complete
> > the failed request from nbd driver, while the request have finished in
> > nbd timeout handle function. The race as following:
> > 
> > CPU1                             CPU2
> > 
> > //req->ref = 1
> > blk_mq_dispatch_rq_list
> > nbd_queue_rq
> >    nbd_handle_cmd
> >      blk_mq_start_request
> >                                   blk_mq_check_expired
> >                                     //req->ref = 2
> >                                     blk_mq_rq_timed_out
> >                                       nbd_xmit_timeout

This shouldn't happen in reality, given rq->deadline is just updated
in blk_mq_start_request(), suppose you use the default 30 sec timeout.
How can the race be triggered in so short time?

Could you explain a bit your test case?

> >                                         blk_mq_complete_request
> >                                           //req->ref = 1
> >                                           refcount_dec_and_test(&req->ref)
> > 
> >                                     refcount_dec_and_test(&req->ref)
> >                                     //req->ref = 0
> >                                       __blk_mq_free_request(req)
> >    ret = BLK_STS_IOERR
> > blk_mq_end_request
> > // req->ref = 0, req have been free
> > refcount_dec_and_test(&rq->ref)
> > 
> > In fact, the bug also have been reported by syzbot:
> >    https://lkml.org/lkml/2018/12/5/1308
> > 
> > Since the request have been freed by timeout handle, it can be reused
> > by others. Then, blk_mq_end_request() may get the re-initialized request
> > and free it, which is unexpected.
> > 
> > To fix the problem, we move blk_mq_start_request() down until the driver
> > will handle the request actully. If .queue_rq return something error in
> > preparation phase, timeout handle may don't need. Thus, moving start
> > request down may be more reasonable. Then, nbd_queue_rq() will not return
> > BLK_STS_IOERR after starting request.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> > ---
> >   drivers/block/nbd.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 78181908f0df..5256e9d02a03 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -541,6 +541,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> >   		return -EIO;
> >   	}
> > +	blk_mq_start_request(req);
> > +
> >   	if (req->cmd_flags & REQ_FUA)
> >   		nbd_cmd_flags |= NBD_CMD_FLAG_FUA;
> > @@ -879,7 +881,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
> >   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> >   		dev_err_ratelimited(disk_to_dev(nbd->disk),
> >   				    "Socks array is empty\n");
> > -		blk_mq_start_request(req);

I think it is fine to not start request in case of failure, given 
__blk_mq_end_request() doesn't check rq's state.



Thanks,
Ming

