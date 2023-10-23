Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712AC00A8F
	for <linux-block@archiver.kernel.org>; Mon, 23 Oct 2023 23:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjJWXqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Oct 2023 19:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJWXqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2023 19:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5BDD
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2023 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698104724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8108ZK/uYMS29R+GboAUTn6c5bPK/gI994W5VC5oVsw=;
        b=ZnmlNig1HjZnk9FxIit3rN3yud5pyiD7/PRY3sOE1+GApaGnQ7nCf/oBIvUgiTECVu7fPY
        EgGsBYeTwMvEYJnnhJ0UgN7nqaIhNCgNi/Ozz3CrS218Qw9i0J+xyJCbBPFrbMS3ZMrg0+
        J4vgOSkhTA3cqQH7Kcqs+9+QHt5u4EU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-PQtrGROaMdOCysOffZFoLg-1; Mon,
 23 Oct 2023 19:45:20 -0400
X-MC-Unique: PQtrGROaMdOCysOffZFoLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 887093811F2C;
        Mon, 23 Oct 2023 23:45:20 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BB8B492BD9;
        Mon, 23 Oct 2023 23:45:14 +0000 (UTC)
Date:   Tue, 24 Oct 2023 07:45:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <ZTcFhmdAPL0LQD7J@fedora>
References: <20231013124758.1492796-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013124758.1492796-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 13, 2023 at 08:47:58PM +0800, Ming Lei wrote:
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
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove module parameter, meantime use queue map to check if
> 	all cpus in one hctx are offline

Hello Guys,

Ping...



Thanks,
Ming

