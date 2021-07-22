Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922FC6377B
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A53561244
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 01:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGVAoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhGVAoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 20:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626917107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YCknDlwiK06Agki9IC1KblbLKoT1F5X8jxQs4wbCb0=;
        b=WNIVBysqnDtXW0XtboHSe/yZ4Pm6uUeIs4ujlwUM+d0TYcr/cJqRXPW6FsvMsZBkVfNyJR
        eQPbQeNkeuU5b19IkmeWulb6BDPuV/la8djylfc40ukxAxQFY5UGP15W98kgdbR321h/ng
        eayjX1eQ+h+jwlhCpGcoVc99DunCbdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-0GMUQ4bVMX2VLzhvkQzG4w-1; Wed, 21 Jul 2021 21:25:04 -0400
X-MC-Unique: 0GMUQ4bVMX2VLzhvkQzG4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B42B41005D58;
        Thu, 22 Jul 2021 01:25:02 +0000 (UTC)
Received: from T590 (ovpn-13-66.pek2.redhat.com [10.72.13.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D3860C5F;
        Thu, 22 Jul 2021 01:24:53 +0000 (UTC)
Date:   Thu, 22 Jul 2021 09:24:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 2/3] blk-mq: mark if one queue map uses managed irq
Message-ID: <YPjI4N5qsuRgPHS4@T590>
References: <20210721091723.1152456-1-ming.lei@redhat.com>
 <20210721091723.1152456-3-ming.lei@redhat.com>
 <20210721143716.GB11058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721143716.GB11058@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 21, 2021 at 04:37:16PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 05:17:22PM +0800, Ming Lei wrote:
> > +	/* So far RDMA doesn't use managed irq */
> > +	map->use_managed_irq = false;
> 
> It certainly did when I wrote this code.  The comment should be
> something "sigh, someone fucked up the rdma queue mapping.  No managed
> irqs for now".

But if it rdma queue mapping uses managed irq, the issue in blk_mq_alloc_request_hctx()
can be hard to fix, :-(


Thanks,
Ming

