Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBEEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjFPHWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245012AbjFPHWJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74D30C1
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686900054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tqp0jBy0MAwlbUsOY9gyPmPTKTK42ZPVNu6TVt7Ucvw=;
        b=ZIIngV5zUGJPpZnvWG9v6ulF63VbR+VZk9aaSlywDbBOzG1KAI2piRIHOVxOgCEo5sF2Wp
        YGyqFpTSVnCtPHqjeZd62Ga+vvlIEeLZsAn1WRqP5c1kMY2rUoa9LeKt2E50uYmELOKsFU
        IxY6xeEBscdjVWqUQGh7URAaSJUIZ8A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15--JlAnzDoOqqlAjkngnYWaA-1; Fri, 16 Jun 2023 03:20:49 -0400
X-MC-Unique: -JlAnzDoOqqlAjkngnYWaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10D55281424C;
        Fri, 16 Jun 2023 07:20:48 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 366D540C20F4;
        Fri, 16 Jun 2023 07:20:42 +0000 (UTC)
Date:   Fri, 16 Jun 2023 15:20:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
 <20230616054800.GA28499@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616054800.GA28499@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 07:48:00AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 15, 2023 at 11:43:51PM +0800, Ming Lei wrote:
> > On Thu, Jun 15, 2023 at 09:16:27AM -0600, Keith Busch wrote:
> > > On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> > > > NVMe calls freeze/unfreeze in different contexts, and controller removal
> > > > may break in-progress error recovery, then leave queues in frozen state.
> > > > So cause IO hang in del_gendisk() because pending writeback IOs are
> > > > still waited in bio_queue_enter().
> > > 
> > > Shouldn't those writebacks be unblocked by the existing check in
> > > bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> > > disk state update or wakeup on this condition?
> > 
> > GD_DEAD is only set if the device is really dead, then all pending IO
> > will be failed.
> 
> del_gendisk also sets GD_DEAD early on.

No.

The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
bio_queue_enter().

Thanks,
Ming

