Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB9C433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 00:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhKWAx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230287AbhKWAx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Nov 2021 19:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637628618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI4xwS67uWRtAxPmd/QWkrE2V3axVpG5d7on5DAy23Y=;
        b=ZzKFRGBYAewdo+f6bRmA2PK+1ihlUsbckyfjJN1kzes73seEn5B0PEHhfbZwRLm9xrPSrc
        pfmA1JHngu40d/WUdJTxRr67T4yZGcIHp9gTvfCUgGZV7RvmTEtIor3JLSY1zFKx1LvVPs
        awiETU7amQzMyV9qAaPU5jMWEoLfE8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-huY-HsI9NSWPK7g6JCr7YQ-1; Mon, 22 Nov 2021 19:50:17 -0500
X-MC-Unique: huY-HsI9NSWPK7g6JCr7YQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE2E802B52;
        Tue, 23 Nov 2021 00:50:16 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70E0856A92;
        Tue, 23 Nov 2021 00:50:08 +0000 (UTC)
Date:   Tue, 23 Nov 2021 08:50:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        czhong@redhat.com
Subject: Re: [PATCH V2 1/1] block: avoid to touch unloaded module instance
 when opening bdev
Message-ID: <YZw6un6PYKE+mAMG@T590>
References: <20211111020343.316126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111020343.316126-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 10:03:43AM +0800, Ming Lei wrote:
> disk->fops->owner is grabbed in blkdev_get_no_open() after the disk
> kobject refcount is increased. This way can't make sure that
> disk->fops->owner is still alive since del_gendisk() still can move
> on if the kobject refcount of disk is grabbed by open() and
> disk->fops->open() isn't called yet.
> 
> Fixes the issue by moving try_module_get() into blkdev_get_by_dev()
> with ->open_mutex() held, then we can drain the in-progress open()
> in del_gendisk(). Meantime new open() won't succeed because disk
> becomes not alive.
> 
> This way is reasonable because blkdev_get_no_open() needn't to touch
> disk->fops or defined callbacks.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: czhong@redhat.com
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove comment as suggested by Christoph
> 	- improve commit log a bit

Hi Jens,

Ping...

Thanks,
Ming

