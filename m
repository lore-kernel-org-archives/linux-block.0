Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D5C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 01:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJUBlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJUBla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 21:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF54B2339A1
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666316487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUvNrwuuXKA8zc+bBog52EGAOJU0uXYgk0rzBuuiK4U=;
        b=Jmhb2J74sdEZvWTd0fLZTAEau9rMCcjZB7WRB25LiyhwiXpomm30NaL0knwtO/i8+4nu9m
        n1Vw9b0v3y8MC3bSA6O9MV9RY3KC90N6cxZ4N0oyBE20ocM6I18uNfSk9TmyUF+am2T4cj
        s3ZLiEgVqYwVMJnHJJitY2i3HEuVL0I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-qj3smm-uNxmM29d6c4utCg-1; Thu, 20 Oct 2022 21:41:22 -0400
X-MC-Unique: qj3smm-uNxmM29d6c4utCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B5EC29AB40C;
        Fri, 21 Oct 2022 01:41:22 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45C674014CF0;
        Fri, 21 Oct 2022 01:41:13 +0000 (UTC)
Date:   Fri, 21 Oct 2022 09:41:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <Y1H4soZ///Wi1sov@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 12:56:03PM +0200, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.  Becuase there are a lot less
> tagsets there is also no need for the variable size allocation trick.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       | 27 +++++----------------------
>  block/blk-mq.c         | 25 +++++++++++++++++--------
>  block/blk-mq.h         | 14 +++++++-------
>  block/blk-sysfs.c      |  9 ++-------
>  block/blk.h            |  9 +--------
>  block/genhd.c          |  2 +-
>  include/linux/blk-mq.h |  4 ++++
>  include/linux/blkdev.h |  9 ---------
>  8 files changed, 37 insertions(+), 62 deletions(-)

q->tag_set is supposed to be live when calling blk_mq_quiesce_queue
and blk_mq_unquiesce_queue, especially del_gendisk() quieses request
queue, so looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

