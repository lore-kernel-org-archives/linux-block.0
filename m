Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA348C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 02:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89A92075F
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 02:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUAgFz22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgEYCRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 May 2020 22:17:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388308AbgEYCRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 May 2020 22:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590373049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXtO9SiCIkTUFllKfzseidfZIN6SrD/bEaYRbu6d+QU=;
        b=XUAgFz222DYFphHjtL0SZLcGohb0SMcDcf44iMlGOXV7Mb6o03HtEyGNhmJmQgjh6TR5KQ
        ZIhBkjE3+VX+uNbzO7ee523gixzavto0Szx9td095FrQqZ4ms5IG2nE0eJpYcxs1RwzuoB
        ayYStpaIiw++du9kzd3BCwaNnvTJ7OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-wV56Q89lPvyIleJu64mK5Q-1; Sun, 24 May 2020 22:17:26 -0400
X-MC-Unique: wV56Q89lPvyIleJu64mK5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5AE71005510;
        Mon, 25 May 2020 02:17:24 +0000 (UTC)
Received: from T590 (ovpn-13-214.pek2.redhat.com [10.72.13.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2456310013C1;
        Mon, 25 May 2020 02:17:18 +0000 (UTC)
Date:   Mon, 25 May 2020 10:17:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/9] blk-mq: support batching dispatch from scheduler
Message-ID: <20200525021714.GA791214@T590>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 23, 2020 at 03:45:55PM +0800, Baolin Wang wrote:
> Hi Ming,
> 
> On Wed, May 13, 2020 at 5:55 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Hi Guys,
> >
> > More and more drivers want to get batching requests queued from
> > block layer, such as mmc[1], and tcp based storage drivers[2]. Also
> > current in-tree users have virtio-scsi, virtio-blk and nvme.
> >
> > For none, we already support batching dispatch.
> >
> > But for io scheduler, every time we just take one request from scheduler
> > and pass the single request to blk_mq_dispatch_rq_list(). This way makes
> > batching dispatch not possible when io scheduler is applied. One reason
> > is that we don't want to hurt sequential IO performance, becasue IO
> > merge chance is reduced if more requests are dequeued from scheduler
> > queue.
> >
> > Tries to start the support by dequeuing more requests from scheduler
> > if budget is enough and device isn't busy.
> >
> > Simple fio test over virtio-scsi shows IO can get improved by 5~10%.
> >
> > Patches can be found from the following tree too:
> >
> >         https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-batching-submission
> >
> > Patch 1 ~ 7 are improvement and cleanup, which can't applied without
> > supporting batching dispatch.
> >
> > Patch 8 ~ 9 starts to support batching dispatch from scheduler.
> 
> Sorry for late reply. I've tested your patch set and got some better
> performance. Thanks.
> Tested-by: Baolin Wang <baolin.wang7@gmail.com>

Hi Baolin,

Thanks for your test & feedback, then looks this approach is good.

I will address comments on v1 and post v2 soon.


Thanks,
Ming

