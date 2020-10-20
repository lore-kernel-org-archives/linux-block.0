Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC325C433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 07:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53079223FB
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 07:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/hz+qlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405194AbgJTHcz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 03:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405120AbgJTHcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 03:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603179173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5fZk9ZOUyXU+5fs3seAn9Cpf07yezdvtfP1S4DGH9U=;
        b=e/hz+qlgs276BxtB695kCgi++JrFI/ohq9EC36XzaaRyGgKP1qmQ9HAhsb/MmVmq5eBLJ+
        MszCluFn8zMFpOJo0wGwdcm3E32Sbka7yyz7AMiOiLl31prjezKbIj9qdXDx9HmmLGbsYY
        wTpKOwlZeTj0OvMynnj14hiXzS6im7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-7dSh3vtCM6GH7nVlzSYxmw-1; Tue, 20 Oct 2020 03:32:48 -0400
X-MC-Unique: 7dSh3vtCM6GH7nVlzSYxmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BA8101EBF0;
        Tue, 20 Oct 2020 07:32:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91F1A60C13;
        Tue, 20 Oct 2020 07:32:45 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C36298C7B8;
        Tue, 20 Oct 2020 07:32:44 +0000 (UTC)
Date:   Tue, 20 Oct 2020 03:32:44 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Message-ID: <826927458.4718534.1603179164356.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq/nvme-tcp: fix timed out related races
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.12]
Thread-Topic: blk-mq/nvme-tcp: fix timed out related races
Thread-Index: Qut3buSHRQri3y33UqEsXCV2T19poQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Ming, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>

For the timeout issue, I've filed below issue to track it, thanks.
https://bugzilla.kernel.org/show_bug.cgi?id=209763

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Ming Lei" <ming.lei@redhat.com>
To: "Jens Axboe" <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, "Christoph Hellwig" <hch@lst.de>, "Keith Busch" <kbusch@kernel.org>
Cc: "Yi Zhang" <yi.zhang@redhat.com>, "Sagi Grimberg" <sagi@grimberg.me>, "Chao Leng" <lengchao@huawei.com>, "Ming Lei" <ming.lei@redhat.com>
Sent: Friday, October 16, 2020 10:28:07 PM
Subject: [PATCH 0/4] blk-mq/nvme-tcp: fix timed out related races

Hi,

The 1st 2 patches fixes request completion related races.

The 2nd 3 patches fixes/improves nvme-tcp error recovery.

With the 4 patches, nvme/012 can pass on nvme-tcp in Zhang Yi's test
machine.


Ming Lei (4):
  blk-mq: check rq->state explicitly in
    blk_mq_tagset_count_completed_rqs
  blk-mq: think request as completed if it isn't IN_FLIGHT.
  nvme: tcp: fix race between timeout and normal completion
  nvme: tcp: complete non-IO requests atomically

 block/blk-flush.c       |  2 ++
 block/blk-mq-tag.c      |  2 +-
 drivers/nvme/host/tcp.c | 76 +++++++++++++++++++++++++++++------------
 include/linux/blk-mq.h  |  8 ++++-
 4 files changed, 65 insertions(+), 23 deletions(-)

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>


-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

