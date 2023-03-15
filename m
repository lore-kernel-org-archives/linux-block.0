Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA6C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 01:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCOBT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCOBT5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 21:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90A196A7
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678843149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+zSK2UuHAw7KcY4Qhi2LdjG2MJMX8+P0PfgNatqtjw=;
        b=SHmUgPGlfnh0FGBW+u0BFJWSwcEEzAXkcVKsQmPvZQYudfY4NltD3snFnOr9BcXvu1iQee
        0Y9n4FWZm7kNTyjOEshSgPcGHK4Bg4Ug5d7x76riIrdeXUXaAaVaXOSvQE5RwJxdMADxue
        OVnVmuaNgXuenYopA7mqTG9hWFMXySg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-tjB5lpIkMrymcXbcrugU6g-1; Tue, 14 Mar 2023 21:19:05 -0400
X-MC-Unique: tjB5lpIkMrymcXbcrugU6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 209A43814585;
        Wed, 15 Mar 2023 01:19:05 +0000 (UTC)
Received: from ovpn-8-22.pek2.redhat.com (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6DD42A68;
        Wed, 15 Mar 2023 01:19:01 +0000 (UTC)
Date:   Wed, 15 Mar 2023 09:18:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chris Leech <cleech@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: fix "bad unlock balance detected" on q->srcu in
 __blk_mq_run_dispatch_ops
Message-ID: <ZBEdAIhaq/5ymewd@ovpn-8-22.pek2.redhat.com>
References: <20230310010913.1014789-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310010913.1014789-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 10, 2023 at 09:09:13AM +0800, Ming Lei wrote:
> From: Chris Leech <cleech@redhat.com>
> 
> The 'q' parameter of the macro __blk_mq_run_dispatch_ops may not be one
> local variable, such as, it is rq->q, then request queue pointed by
> this variable could be changed to another queue in case of
> BLK_MQ_F_TAG_QUEUE_SHARED after 'dispatch_ops' returns, then
> 'bad unlock balance' is triggered.
> 
> Fixes the issue by adding one local variable for doing srcu lock/unlock.
> 
> Fixes: 2a904d00855f ("blk-mq: remove hctx_lock and hctx_unlock")
> Cc: Marco Patalano <mpatalan@redhat.com>
> Signed-off-by: Chris Leech <cleech@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hi Jens,

This patch fixes one hang issue on blk_mq_quiesce_queue(), so could you
make it to v6.3 if you are fine?


Thanks,
Ming

