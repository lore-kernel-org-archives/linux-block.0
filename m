Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372DAEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFPHev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245019AbjFPHep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663191993
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686900836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YU3joFkw4kZzWWYuU925f38CU9gyhPWMQcZQu/tUalI=;
        b=D7dxemPlhbsnilcCOmQJQS1xlTFDlcUrJ9F+8C8J7KtraSCBpZ/pgkvxfPchiYpTa/LP25
        5eQjDTa89GGFKwJOK5Kal9JzZ8d1/KFtVT7M/6WzAeDagsR+pHG1Cw2+POepWAsFQd963d
        mzDNNramnxQdYm0eG6RkriXftmGoaCc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-Yf57gMwsN_2oY6PazRG36Q-1; Fri, 16 Jun 2023 03:33:53 -0400
X-MC-Unique: Yf57gMwsN_2oY6PazRG36Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FE0A3811F3B;
        Fri, 16 Jun 2023 07:33:52 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AAED140E952;
        Fri, 16 Jun 2023 07:33:46 +0000 (UTC)
Date:   Fri, 16 Jun 2023 15:33:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZIwQVWAXrvH7N1kK@ovpn-8-18.pek2.redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
 <20230616054800.GA28499@lst.de>
 <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
 <20230616072721.GA30186@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616072721.GA30186@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 09:27:21AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 16, 2023 at 03:20:38PM +0800, Ming Lei wrote:
> > > > > Shouldn't those writebacks be unblocked by the existing check in
> > > > > bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> > > > > disk state update or wakeup on this condition?
> > > > 
> > > > GD_DEAD is only set if the device is really dead, then all pending IO
> > > > will be failed.
> > > 
> > > del_gendisk also sets GD_DEAD early on.
> > 
> > No.
> > 
> > The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
> > bio_queue_enter().
> 
> What is the workload here?  If del_gendisk is called to remove a disk
> that is in perfectly fine state and can do I/O, fsync_bdev should write
> back data, which is what is exists for.  If the disk is dead, we should
> have called blk_mark_disk_dead before.

It is basically that removing ctrl breaks in-progress error recovery,
then queues are left as quiesced and froze.

https://lore.kernel.org/linux-nvme/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#u

https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/

Thanks, 
Ming

