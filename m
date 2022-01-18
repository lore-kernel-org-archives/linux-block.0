Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiARQFT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:05:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346227AbiARQFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 11:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642521908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCc18KftUcAdf696445JNgnMCUdZbyxw7z9bQIIN+tg=;
        b=PzreSuAB/FlclHscYzI5Wh8c4grMfOQiGEDq+cO9K54RsdH5U9iiSycIolLL4rASb7o+E0
        zVo21YG9/dTXDzkFLXwYz1tPynLAg3CdtYpEHuhRktyrPYE+XuD1/c3/OlXXvZmgLrfRGF
        Zy64ta7dba8NrnDLUvVKYhA6JXtFGlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-_lsRHrioPuqA2i7GdkPYKQ-1; Tue, 18 Jan 2022 11:05:07 -0500
X-MC-Unique: _lsRHrioPuqA2i7GdkPYKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5023610D57FE;
        Tue, 18 Jan 2022 15:59:32 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 150AB73283;
        Tue, 18 Jan 2022 15:59:29 +0000 (UTC)
Date:   Tue, 18 Jan 2022 23:59:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: move freeing disk into queue's release handler
Message-ID: <Yebj3KBUo5A0PXuN@T590>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
 <20220116041815.1218170-2-ming.lei@redhat.com>
 <20220118082259.GA21847@lst.de>
 <YebhFeJb/0Fux5Ei@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YebhFeJb/0Fux5Ei@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 18, 2022 at 11:47:33PM +0800, Ming Lei wrote:
> On Tue, Jan 18, 2022 at 09:22:59AM +0100, Christoph Hellwig wrote:
> > How does this work for SCSI where we can detach the disk from the
> > request queue, reattach it and then maybe later free them both?
> 
> Commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk") has
> marked queue as dying, so how can the above case work given no any code
> clears the queue's dying flag?

oops, my fault, blk_queue_start_drain() actually doesn't set
QUEUE_FLAG_DYING, so the rettach case works with commit 8e141f9eb803.


Thanks,
Ming

