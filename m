Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3681FC00144
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 02:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiG0CG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiG0CG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 22:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3B3B313A0
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 19:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658887616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrW8jKOXy4zIaqDSOECjGw2UAAY/m/OViioGmxRQ7ns=;
        b=VJQK0CDGdIIPbsiqczud2DmMg7+/yZZZ6F6bXU9AFf4OFBJPC8iMb9Cw9AGvaDjm3HvJNX
        wL+bdkKVW3ND6dXVV0TZo76qM5SI0PsuBYmPKgDEHXcVYlmnT+CcGPRrc0gmOQnFYkCwAd
        BGOAMcWBXkuCS1Y5QZBo58ECRQWLvgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-fDUkH9v8MT2b0VUs6GP1jg-1; Tue, 26 Jul 2022 22:06:54 -0400
X-MC-Unique: fDUkH9v8MT2b0VUs6GP1jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33A17101A588;
        Wed, 27 Jul 2022 02:06:54 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 688EDC28100;
        Wed, 27 Jul 2022 02:06:50 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:06:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, yukuai3@huawei.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: run queue no matter whether the request is
 the last request
Message-ID: <YuCdtr/J172j2ZkK@T590>
References: <20220726110111.1557859-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726110111.1557859-1-yuyufen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 07:01:11PM +0800, Yufen Yu wrote:
> We do test on a virtio scsi device (/dev/sda) and the default mq
> scheduler is 'none'. We found a IO hung as following:
> 
> blk_finish_plug
>   blk_mq_plug_issue_direct
>       scsi_mq_get_budget
>       //get budget_token fail and sdev->restarts=1
> 
> 			     	 scsi_end_request
> 				   scsi_run_queue_async
>                                    //sdev->restart=0 and run queue
> 
>      blk_mq_request_bypass_insert
>         //add request to hctx->dispatch list
> 
>   //continue to dispath plug list
>   blk_mq_dispatch_plug_list
>       blk_mq_try_issue_list_directly
>         //success issue all requests from plug list
> 
> After .get_budget fail, scsi_mq_get_budget will increase 'restarts'.
> Normally, it will run hw queue when io complete and set 'restarts'
> as 0. But if we run queue before adding request to the dispatch list
> and blk_mq_dispatch_plug_list also success issue all requests, then
> on one will run queue, and the request will be stall in the dispatch
> list and cannot complete forever.

The story isn't related with scsi actually.

> 
> It is wrong to use last request of plug list to decide if run queue is
> needed since all the remained requests in plug list may be from other
> hctxs. To fix the bug, pass run_queue as true always to
> blk_mq_request_bypass_insert().
> 
> Fix-suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

