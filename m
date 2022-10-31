Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E4C38A02
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 00:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJaAf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 20:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaAf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 20:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED35F99
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667176470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nK9JUhdTgb0upsG9+KDhCEy0NCFqRXTlysqwPYilhWA=;
        b=YAOkHuvoxVgFDV1ORE2nnkamdG2v/rELdhRKqkkKalIaQS5eH9B0dMJPYLrKgbRtRog7hA
        Ho33r9d3DvQrAndqLvypj/vxKy82Vf4/iZZyMzmKgXF9KvMxnlY85tYkYT3YXm3CH1sxHL
        q4O3Ywp325b2QSl2RpLw7ViH7kquCtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-YEHptREUO1WcTj8qR0PADA-1; Sun, 30 Oct 2022 20:34:27 -0400
X-MC-Unique: YEHptREUO1WcTj8qR0PADA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E12BC185A792;
        Mon, 31 Oct 2022 00:34:26 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 140431759E;
        Mon, 31 Oct 2022 00:34:21 +0000 (UTC)
Date:   Mon, 31 Oct 2022 08:34:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 1/1] blk-mq: avoid double ->queue_rq() because of
 early timeout
Message-ID: <Y18YCBE/oCvM1+IA@T590>
References: <20221026051957.358818-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026051957.358818-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 01:19:57PM +0800, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
> 
> So far, it is driver's responsibility to cover the race between timeout
> and completion, so it seems supposed to be solved in driver in theory,
> given driver has enough knowledge.
> 
> But it is really one common problem, lots of driver could have similar
> issue, and could be hard to fix all affected drivers, even it isn't easy
> for driver to handle the race. So David suggests this patch by draining
> in-progress ->queue_rq() for solving this issue.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- add callback for handle expired only, suggested by Keith Busch

Hi Jens,

Any chance to merge this fix? Either 6.1 or 6.2 is fine for me.


Thanks,
Ming

