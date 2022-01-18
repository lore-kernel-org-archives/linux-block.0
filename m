Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE5DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiARPwp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232516AbiARPwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 10:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642521163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gquFfOR0xiFNLfrS0pvE5c5azb/hNWp0sLy8/kX3zI=;
        b=FQ3qCeWAWxCh9JgxZ1p5/01AXa8Tdm8K9BfIgtkYFn2PB2T+iroqjzgAVgX1x3zjWY+SBg
        cHa71RbW2ZKh391S1ZAoqOWRTY+QVSIJDLFTw5T2gsFt9oZ+WUHcNc8edagWbt+JJ/lbYe
        xj4QXgPbaGSjTQcMJdQT8SBgwR1MOGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-omh4R_mxOSmzlAcMq-9alg-1; Tue, 18 Jan 2022 10:52:42 -0500
X-MC-Unique: omh4R_mxOSmzlAcMq-9alg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4761310B4344;
        Tue, 18 Jan 2022 15:47:42 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65FA13468A;
        Tue, 18 Jan 2022 15:47:38 +0000 (UTC)
Date:   Tue, 18 Jan 2022 23:47:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: move freeing disk into queue's release handler
Message-ID: <YebhFeJb/0Fux5Ei@T590>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
 <20220116041815.1218170-2-ming.lei@redhat.com>
 <20220118082259.GA21847@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118082259.GA21847@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 18, 2022 at 09:22:59AM +0100, Christoph Hellwig wrote:
> How does this work for SCSI where we can detach the disk from the
> request queue, reattach it and then maybe later free them both?

Commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk") has
marked queue as dying, so how can the above case work given no any code
clears the queue's dying flag?

Can you share steps for this test case? And it shouldn't hard to extend this
patch for supporting it.

Thanks, 
Ming

