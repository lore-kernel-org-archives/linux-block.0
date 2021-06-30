Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD5C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E92861CD4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhF3Iub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233875AbhF3Iu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 04:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625042879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BRgUmAkhzxR66VtSPc5n97wSxRw2/ltCg6mBskAIrE=;
        b=GzuJ1bJhu3XXN9WRoS9LE5QaQ4vYNg6xVTINiehiKiTA8ZOY+erVyXmSckmuclAvJokBOx
        5+Ppu/Bs+U0oB7ntJWOJYLyhThqYNO327GwdKT1dYjxqLNCfVT5S2Wjzu3OShCdrvs5CBr
        Fy3w1kftNhqZ89SbWylDhPF29JViU4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-dcquosp0M5yTB3x8-TK3gg-1; Wed, 30 Jun 2021 04:47:58 -0400
X-MC-Unique: dcquosp0M5yTB3x8-TK3gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33816A40C1;
        Wed, 30 Jun 2021 08:47:56 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2EC25C230;
        Wed, 30 Jun 2021 08:47:48 +0000 (UTC)
Date:   Wed, 30 Jun 2021 16:47:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/2] nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for
 fc/rdma/tcp/loop
Message-ID: <YNwvsNcTBu6yGW1o@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-3-ming.lei@redhat.com>
 <46fdb02d-8d71-d465-072d-5e8d6ec3601f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fdb02d-8d71-d465-072d-5e8d6ec3601f@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 10:15:46AM +0200, Hannes Reinecke wrote:
> On 6/29/21 9:49 AM, Ming Lei wrote:
> > All the 4 host drivers don't use managed irq for completing request, so
> > it is correct to pass the flag to blk-mq.
> > 
> > Secondly with this flag, blk-mq will help us dispatch connect request
> > allocated via blk_mq_alloc_request_hctx() to driver even though all
> > CPU in the specified hctx's cpumask are offline.
> > 
> How is this supposed to work?
> To my understanding, only cpus in the hctx cpumask are eligible to send I/O.
> So if all of these CPUs are offline, who exactly is submitting I/O?
> More to the point, which CPU will be submitting the connect request?

Please see __blk_mq_delay_run_hw_queue(), which will pass WORK_CPU_UNBOUND 
to kblockd_mod_delayed_work_on() for this situation.


Thanks,
Ming

