Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC2C7EE23
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbjELPUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbjELPUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056BB7EFC
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683904788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2Y9QkuohUAYZFpwfWfBZDo63ou+H4aR2f4gtpk1yss=;
        b=L3o5xGXkMthybHOrMncq4SBIpcvyuNUAjCFxCNJYsGMUgZJU79AGPD560EbGq+LCNZFnaH
        mVmDfIUmZFdLj87AvQlEHpWZlb4OlahodQmBKJdHEk+8fFSk1gsQ7ZzAFWPZOiG8+uLbuZ
        jJsXHHeKk7jpqrSGH2yko5Lo0/YEMOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-Nd5thIowOSiltNqCdjzraQ-1; Fri, 12 May 2023 11:19:44 -0400
X-MC-Unique: Nd5thIowOSiltNqCdjzraQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F7E88533DC;
        Fri, 12 May 2023 15:19:44 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9AC2C15BA0;
        Fri, 12 May 2023 15:19:40 +0000 (UTC)
Date:   Fri, 12 May 2023 23:19:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
> On 5/12/23 9:03?AM, Ming Lei wrote:
> > Passthrough(pt) request shouldn't be queued to scheduler, especially some
> > schedulers(such as bfq) supposes that req->bio is always available and
> > blk-cgroup can be retrieved via bio.
> > 
> > Sometimes pt request could be part of error handling, so it is better to always
> > queue it into hctx->dispatch directly.
> > 
> > Fix this issue by queuing pt request from plug list to hctx->dispatch
> > directly.
> 
> Why not just add the check to the BFQ insertion? That would be a lot
> more trivial and would not be poluting the core with this stuff.

pt request is supposed to be issued to device directly, and we never
queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
passthrough plugging").

some pt request might be part of error handling, and adding it to
scheduler could cause io hang.


Thanks,
Ming

