Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4209C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 09:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiGSJ0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiGSJ0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 05:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D3671FCD4
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658222790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnpQK91imTwcGXJbe3ARMgWDl7NhU+3xTTo950W5UxE=;
        b=jTfJfT7n7Rm+/n3UVelKq6WNneBDqkoyR4mDWD1xBfFdch6pz+1zwTjKDZVcTD4A4QAZQk
        CoE1hxCFB4tg0OK50QqPd5Fuz0lJj07Rf2HNxumXXxIq0aGkEdARg/oNGhzFnMoWmQKoRx
        bTNO2D2a2V77NgSEmKdl8zLbTF8CHxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-AC7Eqi4QMl-z25RLTEQm9Q-1; Tue, 19 Jul 2022 05:26:26 -0400
X-MC-Unique: AC7Eqi4QMl-z25RLTEQm9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA769101A54E;
        Tue, 19 Jul 2022 09:26:25 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 340331121314;
        Tue, 19 Jul 2022 09:26:21 +0000 (UTC)
Date:   Tue, 19 Jul 2022 17:26:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
Message-ID: <YtZ4uSRqR/kLdqm+@T590>
References: <20220718123528.178714-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718123528.178714-1-yuyufen@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 08:35:28PM +0800, Yufen Yu wrote:
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

Here the issue shouldn't be related with scsi's get budget or
scsi_run_queue_async.

If blk-mq adds request into ->dispatch_list, it is blk-mq core's
responsibility to re-run queue for moving on. Can you investigate a
bit more why blk-mq doesn't run queue after adding request to
hctx dispatch list?



Thanks,
Ming

