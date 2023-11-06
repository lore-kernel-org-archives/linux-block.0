Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C89C4332F
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 01:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKFBQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Nov 2023 20:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFBP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Nov 2023 20:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB310B
        for <linux-block@vger.kernel.org>; Sun,  5 Nov 2023 17:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699233313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1DllSt6fTArQRMX3GewORWveJZhIv9vhXbNXa37doI=;
        b=fLC0rVOS1Tic5VPklR0pDhVL3lbPTr74b05TqtQpcU2L2SAfaoGiBvFZajmY+7eHKOnrel
        Yz+bnYmGPLbTG5nMz6sHOVFvsjVGF4ihF8/da/nV+6l9qH3nxVg6b5QOXQXeVffoKqp6CF
        ypzyXS84qn9oy+9MxJnXRG2twtQeGD8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-FAXzbPVoOsqT7G56Up_RQw-1; Sun, 05 Nov 2023 20:15:08 -0500
X-MC-Unique: FAXzbPVoOsqT7G56Up_RQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF626811E7D;
        Mon,  6 Nov 2023 01:15:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 430E5492BE7;
        Mon,  6 Nov 2023 01:15:01 +0000 (UTC)
Date:   Mon, 6 Nov 2023 09:14:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com
Subject: Re: [PATCH V3] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <ZUg+EfA8b/j5XTD7@fedora>
References: <20231025025737.358756-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025025737.358756-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 25, 2023 at 10:57:37AM +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used for isolating CPUs
> for specific task, and user often won't want block IO to disturb these CPUs,
> also long IO latency may be caused if blk-mq kworker is scheduled on these
> isolated CPUs.
> 
> Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> the responsibility should be on wq user.
> 
> So don't not run block kworker on isolated CPUs by ruling out isolated CPUs
> from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
> all CPUs in this hw queue are offline, this way can avoid any cost in fast
> IO code path.
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> 
> V3:
> 	- avoid to check invalid cpu as reported by Bart
> 	- take current cpu(to be offline, not done yet) into account
> 	- simplify blk_mq_hctx_has_online_cpu()

Hello Jens and Guys,

Ping...

thanks,
Ming

