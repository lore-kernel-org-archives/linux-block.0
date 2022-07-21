Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 14:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiGUOYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiGUOYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 10:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42A9087C03
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658413433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbOxLyJ9P8/pqIokGdRy1Y81x/fGIkhTLEzGK7xIwmo=;
        b=gOwlnc+5b4ENZb+Jo8WRBugSrqfOdUBitSo3j2IN1LAqidhWSMfF1QhANJdKEQtOoB2dsT
        hVUGc5Efb+zBzy9oyFGjpDCamo5uVZhnFsuc4ni6phM1QOBhm6eFv/mZzrTto9huohLg7r
        epZO2yFzRYFwyCDIUYlf8qQoZ7/8HSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-R3a8YWkSMhKQvnfGr6r1sQ-1; Thu, 21 Jul 2022 10:23:51 -0400
X-MC-Unique: R3a8YWkSMhKQvnfGr6r1sQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70A8385A587;
        Thu, 21 Jul 2022 14:23:51 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F38CB492C3B;
        Thu, 21 Jul 2022 14:23:47 +0000 (UTC)
Date:   Thu, 21 Jul 2022 22:23:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] ublk: rewrite ublk_ctrl_get_queue_affinity to not
 rely on hctx->cpumask
Message-ID: <Ytlhbq5GRWdQwGA3@T590>
References: <20220721130916.1869719-1-hch@lst.de>
 <20220721130916.1869719-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721130916.1869719-8-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 03:09:15PM +0200, Christoph Hellwig wrote:
> Looking at the hctxs and cpumap is not safe without at very last a RCU
> reference.  It also requires the queue to be set up before starting the
> device, which leads to rather awkward life time rules.
> 
> Instead rewrite ublk_ctrl_get_queue_affinity to just build the cpumask
> directly from the mq_map in the tag set, similar to hctx->cpumask is
> built.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

