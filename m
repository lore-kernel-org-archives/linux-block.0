Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175CBC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 02:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324422315
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 02:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQUakmSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKSCdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:33:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfKSCdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 21:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574130798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MkXorS37MAT9qquxxYHBHfZi9PjbohKS55KZ5S0L6Y=;
        b=WQUakmSrUbtSfEM8i4TiAN05QtdHxq7KEdhje3KQpvtACaH7ZniAOmBdfM14xWOUxKxQH3
        ZELkw3dMVCitdTALuUsyYVkhvMVl9Qwuowi+iogR2mLyCiAxtMxLUCHfI4T3GGpkNIw1k3
        36jyW7O9jpOlHDS8Anzu+DLbFIlNWkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-WSpetWe3N8mJo7dOYsxl0Q-1; Mon, 18 Nov 2019 21:33:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48271005502;
        Tue, 19 Nov 2019 02:33:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 837BB46469;
        Tue, 19 Nov 2019 02:33:06 +0000 (UTC)
Date:   Tue, 19 Nov 2019 10:33:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191119023301.GC391@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WSpetWe3N8mJo7dOYsxl0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 18, 2019 at 04:05:56PM -0800, Sagi Grimberg wrote:
>=20
> > Hi Sagi,
> >=20
> > On Fri, Nov 15, 2019 at 02:38:44PM -0800, Sagi Grimberg wrote:
> > >=20
> > > > Hi,
> > >=20
> > > Hey Ming,
> > >=20
> > > > Use blk_mq_alloc_request() for allocating NVMe loop, fc, rdma and t=
cp's
> > > > connect request, and selecting transport queue runtime for connect
> > > > request.
> > > >=20
> > > > Then kill blk_mq_alloc_request_hctx().
> > >=20
> > > Is it really so wrong to have an API to allocate a tag that belongs t=
o
> > > a specific queue? Why must the tags allocation always correlate to th=
e
> > > running cpu? Its true that NVMe is the only consumer of this at the
> > > moment, but does this mean that the interface should be removed becau=
se
> > > it has one (or rather four) consumer(s)?
> >=20
> > Now blk-mq takes a static queue mapping between CPU and hw queues, give=
n
> > CPU hotplug may happen any time, so the specified hw queue may become
> > inactive any time.
> >=20
> > Queue mapping from CPU to hw queue is one core model of blk-mq which
> > relies a lot on the fact that hw queue active or not depends on
> > request's submission CPU. And we always can retrieve one active hw
> > queue if there is at least one online CPU.
> >=20
> > IO request is always mapped to the proper hw queue via the submission
> > CPU and queue type.
> >=20
> > So blk_mq_alloc_request_hctx() is really weird from the above blk-mq's
> > model.
> >=20
> > Actually the 4 consumer is just one single type of usage for submitting
> > connect command, seems no one explain this special usage before. And th=
e
> > driver can handle well enough without this interface just like this
> > patch, can't it?
>=20
> Does removing the cpumask_and with cpu_online_mask fix your test?

It can be workaround this way, or return NULL if the hctx becomes
inactive.

But there is big problem to dispatch such request to inactive hctx, as
I explained.

>=20
> this check is wrong to begin with because it can not be true right after
> the check.
>=20
> This is a much simpler fix that does not create this churn local to
> every driver. Also, I don't like the assumptions about tag reservations
> that the drivers is taking locally (that the connect will have tag 0
> for example). All this makes this look like a hack.

The patch I posted can be applied to non-reserved tag too, and the connect
request can figured by rq->private_rq_data simply.

Also, we can provide blk_mq_rq_is_reserved() helper if you think 'rq->tag =
=3D=3D 0'
is like a hack.

>=20
> There is also the question of what happens when we want to make connects
> parallel, which is not the case at the moment...

There are several solutions for this:

1) schedule the connection on selected CPUs, so that all hw queues can be
covered

2) use single tag_set for connect command only.


Thanks,=20
Ming

