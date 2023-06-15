Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983AAEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 15:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbjFOPpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbjFOPpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 11:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017822942
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686843859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F60AvhA0FMiJNRtBO0yYLpZvFzJjensEGvAZvskekGI=;
        b=FzlqMq9YdNcCfinCiVxZFlXlDtOWYSL4GJsvyqLMxo7MCIiKaqYdXw/Wjs9FYcqyrTeGMr
        qCR3bK8KaWLJdKgS4TWleRsBHSVGF6sikO1QZ/kRWnLYhpqyX2U4AGNomv2SQLS984Q7hj
        9PyQcPTajFJGG90eFH3oBzRQSgIQBgM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-HHAVvWZwMkKt4IOOcyr_Iw-1; Thu, 15 Jun 2023 11:44:15 -0400
X-MC-Unique: HHAVvWZwMkKt4IOOcyr_Iw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC0EE2999B53;
        Thu, 15 Jun 2023 15:44:01 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C2C71C558;
        Thu, 15 Jun 2023 15:43:56 +0000 (UTC)
Date:   Thu, 15 Jun 2023 23:43:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 09:16:27AM -0600, Keith Busch wrote:
> On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> > NVMe calls freeze/unfreeze in different contexts, and controller removal
> > may break in-progress error recovery, then leave queues in frozen state.
> > So cause IO hang in del_gendisk() because pending writeback IOs are
> > still waited in bio_queue_enter().
> 
> Shouldn't those writebacks be unblocked by the existing check in
> bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> disk state update or wakeup on this condition?

GD_DEAD is only set if the device is really dead, then all pending IO
will be failed.

We need to try to handle these IOs first if device isn't set as dead by
calling blk_mark_disk_dead().

Thanks,
Ming

