Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E5CA9EB9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 00:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7E82084B
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 00:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSdmqb8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392153AbfJXAdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 20:33:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388218AbfJXAdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 20:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571877217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjt331/bC3eTRmvUqLdS/Gse6qvavmMOFrBUV4dEjjM=;
        b=jSdmqb8JPu9EZj6cdqpYGHQWC92uEA5pryB3DQ7YgOXhTr8nINB3vlAo7+4lf/MqmptBMA
        er8pRyCLUNPhHvUdnnySSEVUzIhke9eiS0GW94kBuGvMddz70WKDh/uxbAnThJBAhnovA4
        /njkxR7Q9huFkRVMCExILJvGYoqHOe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-7Ar9gCXeOqekbymjny_5Nw-1; Wed, 23 Oct 2019 20:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6002D1800D6B;
        Thu, 24 Oct 2019 00:33:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AFAF1001B35;
        Thu, 24 Oct 2019 00:33:24 +0000 (UTC)
Date:   Thu, 24 Oct 2019 08:33:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 2/4] block: Fix a race between blk_poll() and
 blk_mq_update_nr_hw_queues()
Message-ID: <20191024003319.GA15426@ming.t460p>
References: <20191021224259.209542-1-bvanassche@acm.org>
 <20191021224259.209542-3-bvanassche@acm.org>
 <20191022094154.GB9037@ming.t460p>
 <322f024f-6756-aa29-28ac-a17aa8499279@acm.org>
MIME-Version: 1.0
In-Reply-To: <322f024f-6756-aa29-28ac-a17aa8499279@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7Ar9gCXeOqekbymjny_5Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 23, 2019 at 01:58:24PM -0700, Bart Van Assche wrote:
> On 2019-10-22 02:41, Ming Lei wrote:
> > On Mon, Oct 21, 2019 at 03:42:57PM -0700, Bart Van Assche wrote:
> >> +int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> >> +{
> >> +=09int ret;
> >> +
> >> +=09if (!percpu_ref_tryget(&q->q_usage_counter))
> >> +=09=09return 0;
> >> +=09ret =3D __blk_poll(q, cookie, spin);
> >> +=09blk_queue_exit(q);
> >> +
> >> +=09return ret;
> >> +}
> >=20
> > IMO, this change isn't required. Caller of blk_poll is supposed to
> > hold refcount of the request queue, then the related hctx data structur=
e
> > won't go away. When the hctx is in transient state, there can't be IO
> > to be polled, and it is safe to call into IO path.
> >=20
> > BTW, .poll is absolutely the fast path, we should be careful to add cod=
e
> > in this path.
>=20
> Hi Ming,
>=20
> I'm not sure whether all blk_poll() callers really hold a refcount on
> the request queue.

Please see __device_add_disk() which takes one extra queue ref, which
won't be dropped until the disk is released.

Meantime blkdev_get() holds gendisk reference via bdev_get_gendisk(),
and blkdev_get() is called by blkdev_open().

The above way should guarantee that the request queue won't go away
when IO is submitted to queue via blkdev fs inode.

> Anyway, I will convert this code change into a
> comment that explains that blk_poll() callers must hold a request queue
> reference.

Good point.


Thanks,
Ming

