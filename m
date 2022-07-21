Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E95C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiGUHiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGUHiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 169A07C1B9
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658389130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KS7z6Vxt/4L+DXrY4nWS/TdY5mycUijxp5LTfR36aEc=;
        b=e/r1pR9335Q/3elPxnSXjv67wiOznW1m1KYGssVZafV3Y/l5WvGknDOOfVdg6WUx19vS5E
        wMplU98veusmeatO6jbSLpUmlcotGYr4bW7yD9eB4JOipEHVNsRP//ouDeRCpbLHMAsFkR
        uH0ncCHr/GKoGITv7yp6ZBueTEYLAmc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-tAE6aCUNORGE0K9DXF9DiQ-1; Thu, 21 Jul 2022 03:38:48 -0400
X-MC-Unique: tAE6aCUNORGE0K9DXF9DiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B0751C288C3;
        Thu, 21 Jul 2022 07:38:48 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D09671415118;
        Thu, 21 Jul 2022 07:38:44 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:38:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH 7/8] ublk: rewrite ublk_ctrl_get_queue_affinity to not
 rely on hctx->cpumask
Message-ID: <YtkCf3eAc0kbACp0@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-8-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:31AM +0200, Christoph Hellwig wrote:
> Looking at the hctxs and cpumap is not safe without at very last a RCU
> reference.  It also requires the queue to be set up before starting the
> device, which leads to rather awkware life time rules.
> 
> Instead rewrite ublk_ctrl_get_queue_affinity to call blk_mq_map_queues
> on an on-stack blk_mq_queue_map and build the cpumask from that.
> 
> Note: given that ublk has not made it into a released kernel it might
> make sense to change the ABI for this command to instead copy the
> qmap.mq_map array (a nr_cpu_ids sized array of unsigned integer
> values  where the CPU index directly points to the queue) to userspace.

qmap.mq_map is too big.

tag_set is embedded into ublk_device, and can be allocated once during
adding device, then ublk_ctrl_get_queue_affinity() can retrieve the info from
tag_set's map directly, then it is simplified a lot.

Also all info for building tag_set is setup during adding device, and
these info won't be changed after adding device, so it is reasonable
to allocate tagset just once.


Thanks,
Ming

