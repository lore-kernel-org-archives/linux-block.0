Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D5EE4993
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 12:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjHVM4i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjHVM4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 08:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B6CC7
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692708948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K68YHbA3+U8O9M9xl9/6yOrkj/8TeOjc2yYUeFDBx14=;
        b=C+5Fa30SsO6k6+06eBhQnWDuRxhDGdBi0ib79Hpv2aOrX1XlDzmlDSEQ+SPONuNZoricO1
        TMI1CPLON4/T2afN6UF4EdBATm3ieRkZTkK8AaXdVaS8abyu7arh0Q06PH9UDGeEDa1qcX
        DY8AQR3x5Gv+EOUKZ1MVGshwohV/+3c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-mZ8LSaXPOCazOkhgI8lbJw-1; Tue, 22 Aug 2023 08:55:44 -0400
X-MC-Unique: mZ8LSaXPOCazOkhgI8lbJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 825D83C0F676;
        Tue, 22 Aug 2023 12:55:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 484CF492C13;
        Tue, 22 Aug 2023 12:55:38 +0000 (UTC)
Date:   Tue, 22 Aug 2023 20:55:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 3/3] blk-mq: prealloc tags when increase tagset
 nr_hw_queues
Message-ID: <ZOSwRtKM75UWDryy@fedora>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
 <20230821095602.70742-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821095602.70742-3-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 21, 2023 at 05:56:02PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Just like blk_mq_alloc_tag_set(), it's better to prepare all tags before
> using to map to queue ctxs in blk_mq_map_swqueue(), which now have to
> consider empty set->tags[].
> 
> The good point is that we can fallback easily if increasing nr_hw_queues
> fail, instead of just mapping to hctx[0] when fail in blk_mq_map_swqueue().
> 
> And the fallback path already has tags free & clean handling, so all
> is good.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

