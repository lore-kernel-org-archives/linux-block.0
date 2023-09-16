Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780EC46CA1
	for <linux-block@archiver.kernel.org>; Sat, 16 Sep 2023 09:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbjIPJYT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Sep 2023 05:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbjIPJYR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Sep 2023 05:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A68FA173B
        for <linux-block@vger.kernel.org>; Sat, 16 Sep 2023 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694856206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGEP6R3c9Jhc+DpCgSNfDoTCVIo/fpZjOC0f7OC9AbQ=;
        b=S0/p9CD9LIgPmu5gKfYzmBFqWY2yS1eZXa7Vz9Dlx1p9gWREwzijQh61MrhWOTHzE5iyYk
        v/lvHY5ZHP14Qr7jdv1OBHquOKyG+mviFX/TdNSJRdEUTR1jITrhP0yAHiWKX93R6Om4+w
        SE5XOCSK9GO5bc+DIHPMSD7wgdAMrbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-dS3atwUAML2XJhTUgDpg-Q-1; Sat, 16 Sep 2023 05:23:23 -0400
X-MC-Unique: dS3atwUAML2XJhTUgDpg-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E707945921;
        Sat, 16 Sep 2023 09:23:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B14D40C6EBF;
        Sat, 16 Sep 2023 09:23:15 +0000 (UTC)
Date:   Sat, 16 Sep 2023 17:23:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH v2 1/5] blk-mq: account active requests when get driver
 tag
Message-ID: <ZQVz/hFxxaM8Orza@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 13, 2023 at 03:16:12PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> There is a limit that batched queue_rqs() can't work on shared tags
> queue, since the account of active requests can't be done there.
> 
> Now we account the active requests only in blk_mq_get_driver_tag(),
> which is not the time we get driver tag actually (with none elevator).
> 
> To support batched queue_rqs() on shared tags queue, we move the
> account of active requests to where we get the driver tag:
> 
> 1. none elevator: blk_mq_get_tags() and blk_mq_get_tag()
> 2. other elevator: __blk_mq_alloc_driver_tag()
> 
> This is clearer and match with the unaccount side, which just happen
> when we put the driver tag.
> 
> The other good point is that we don't need RQF_MQ_INFLIGHT trick
> anymore, which used to avoid double account of flush request.
> Now we only account when actually get the driver tag, so all is good.
> We will remove RQF_MQ_INFLIGHT in the next patch.

RQF_MQ_INFLIGHT is only set for BLK_MQ_F_TAG_QUEUE_SHARED, so we can
avoid the extra atomic accounting for !BLK_MQ_F_TAG_QUEUE_SHARED.

But now your patch switches to account unconditionally by removing
RQF_MQ_INFLIGHT, not friendly for !BLK_MQ_F_TAG_QUEUE_SHARED.

Thanks, 
Ming

