Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589BC4363D
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 02:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8729E22242
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 02:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9VbReao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411458AbgJUCz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 22:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411448AbgJUCzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 22:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603248953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C3lHh1yqGfKBxJQ92zcMrpQvEmDt/UhUB1iPnoptL40=;
        b=H9VbReaoVz1xWlRr3EsvHzDhdkiJByZB1B16NL9qJoatJpeYM3z8Tfy53QtzuiB2cr5KpD
        QFv55rnJt2bg/OSxffOYq/bR48p7sFhohpVjZeEMEC8W/Yvqg3YdsFwH4ci+cWYYT/wGDf
        XKGxC3+vO/YTPv4dgCPzBDUqO1vysMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-50l8hsfoP3q05P06AivNvA-1; Tue, 20 Oct 2020 22:55:51 -0400
X-MC-Unique: 50l8hsfoP3q05P06AivNvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748411006C90;
        Wed, 21 Oct 2020 02:55:49 +0000 (UTC)
Received: from T590 (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38AB35B4A1;
        Wed, 21 Oct 2020 02:55:37 +0000 (UTC)
Date:   Wed, 21 Oct 2020 10:55:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
Message-ID: <20201021025534.GD1571548@T590>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
 <20201020085301.1553959-4-ming.lei@redhat.com>
 <e1d53ce3-ea27-439e-5e7a-ba790742908e@huawei.com>
 <20201021012241.GC1571548@T590>
 <7a3cdbdb-8e57-484c-fcb3-e8e72dfe8d13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3cdbdb-8e57-484c-fcb3-e8e72dfe8d13@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 21, 2020 at 10:20:11AM +0800, Chao Leng wrote:
> 
> 
> On 2020/10/21 9:22, Ming Lei wrote:
> > On Tue, Oct 20, 2020 at 05:04:29PM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2020/10/20 16:53, Ming Lei wrote:
> > > > During controller's CONNECTING state, admin/fabric/connect requests
> > > > are submitted for recovery controller, and we allow to abort this request
> > > > directly in time out handler for not blocking setup procedure.
> > > > 
> > > > So timout vs. normal completion race exists on these requests since
> > > > admin/fabirc/connect queues won't be shutdown before handling timeout
> > > > during CONNECTING state.
> > > > 
> > > > Add atomic completion for requests from connect/fabric/admin queue for
> > > > avoiding the race.
> > > > 
> > > > CC: Chao Leng <lengchao@huawei.com>
> > > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > > > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
> > > >    1 file changed, 37 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > index d6a3e1487354..7e85bd4a8d1b 100644
> > > > --- a/drivers/nvme/host/tcp.c
> > > > +++ b/drivers/nvme/host/tcp.c
> > > > @@ -30,6 +30,8 @@ static int so_priority;
> > > >    module_param(so_priority, int, 0644);
> > > >    MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
> > > > +#define REQ_STATE_COMPLETE     0
> > > > +
> > > >    enum nvme_tcp_send_state {
> > > >    	NVME_TCP_SEND_CMD_PDU = 0,
> > > >    	NVME_TCP_SEND_H2C_PDU,
> > > > @@ -56,6 +58,8 @@ struct nvme_tcp_request {
> > > >    	size_t			offset;
> > > >    	size_t			data_sent;
> > > >    	enum nvme_tcp_send_state state;
> > > > +
> > > > +	unsigned long		comp_state;
> > > I do not think adding state is a good idea.
> > > It is similar to rq->state.
> > > In the teardown process, after quiesced queues delete the timer and
> > > cancel the timeout work maybe a better option.
> > > I will send the patch later.
> > > The patch is already tested with roce more than one week.
> > 
> > Actually there isn't race between timeout and teardown, and patch 1 and patch
> > 2 are enough to fix the issue reported by Yi.
> > 
> > It is just that rq->state is updated to IDLE in its. complete(), so
> > either one of code paths may think that this rq isn't completed, and
> > patch 2 has addressed this issue.
> > 
> > In short, teardown lock is enough to cover the race.
> The race may cause abnormals:
> 1. Reported by Yi Zhang <yi.zhang@redhat.com>
> detail: https://lore.kernel.org/linux-nvme/1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com/
> 2. BUG_ON in blk_mq_requeue_request
> Because error recovery and time out may repeated completion request.
> First error recovery cancel request in tear down process, the request
> will be retried in completion, rq->state will be changed to IDEL.

Right.

> And then time out will complete the request again, and samely retry
> the request, BUG_ON will happen in blk_mq_requeue_request.

With patch2 in this patchset, timeout handler won't complete the request any
more.

> 3. abnormal link disconnection
> Firt error recovery cancel all request, reconnect success, the request
> will be restarted. And then time out will complete the request again,
> the queue will be stoped in nvme_rdma(tcp)_complete_timed_out,
> Abnormal link diconnection will happen. The condition(time out process
> is delayed long time by some reason such as hardware interrupt) is need.
> So the probability is low.

OK, the timeout handler may just get chance to run after recovery is
done, and it can be fixed by calling nvme_sync_queues() after
updating to CONNECTING or before updating to LIVE together with patch 1 & 2.

> teardown_lock just serialize the race. and add checkint the rq->state can avoid
> the 1 and 2 scenario, but 3 scenario can not be fixed.

I didn't think of scenario 3, which seems not triggered in Yi's test.


thanks,
Ming

