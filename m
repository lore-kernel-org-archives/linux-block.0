Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D71EE49A3
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 12:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjHVMqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjHVMqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 08:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61054CC1
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692708346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GLAdsgxJX/mrZzN7FseNgZA8I+uALj79rWo/D+tLhU=;
        b=EzTSX9nUfcUCSyL6nViHHIiQJXnRbSg1NJ6a9lpLJTjt3sz8sAcVhYTiUPXTzmI+tnm9ko
        zrF68ADYrJQbx84JeQPSfxrKgInfncXEQ5TtpIewmd685DZCdc1mafjW8kR9y0IWH2aKcp
        xK8Tk6I5C3kBs/cFkRYtg+zE7HdHeAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-1yq39qkaMZWWDb8A-7MWkQ-1; Tue, 22 Aug 2023 08:45:43 -0400
X-MC-Unique: 1yq39qkaMZWWDb8A-7MWkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6E5685CBE5;
        Tue, 22 Aug 2023 12:45:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 684B163F78;
        Tue, 22 Aug 2023 12:45:38 +0000 (UTC)
Date:   Tue, 22 Aug 2023 20:45:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 1/3] blk-mq: fix tags leak when shrink nr_hw_queues
Message-ID: <ZOSt7XayXNGkMofU@fedora>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821095602.70742-1-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 21, 2023 at 05:56:00PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Although we don't need to realloc set->tags[] when shrink nr_hw_queues,
> we need to free them. Or these tags will be leaked.
> 
> How to reproduce:
> 1. mount -t configfs configfs /mnt
> 2. modprobe null_blk nr_devices=0 submit_queues=8
> 3. mkdir /mnt/nullb/nullb0
> 4. echo 1 > /mnt/nullb/nullb0/power
> 5. echo 4 > /mnt/nullb/nullb0/submit_queues
> 6. rmdir /mnt/nullb/nullb0
> 
> In step 4, will alloc 9 tags (8 submit queues and 1 poll queue), then
> in step 5, new_nr_hw_queues = 5 (4 submit queues and 1 poll queue).
> At last in step 6, only these 5 tags are freed, the other 4 tags leaked.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

