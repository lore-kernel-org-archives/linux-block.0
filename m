Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390CCD4F2B
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjIVIu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjIVIu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 04:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD301A1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695372574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdkJCshrm7+2NA6hvRhWRajvLtyMYVnCdJT2DMlaAKU=;
        b=RTyJGAYX0TmcQklzt3NC4KfPFipDR406QECKkZ+LLRm11g8aAonR1r728jJfIV3k0C4YeA
        dyMJTmCiZI03dmzM2Fn5ONvMmBIF74l63Vq3jMEhmxhiN2ah1yCFJaKIS5oR/wRQnXF/rJ
        WiWgkwHWs/znsPB6MwIPnaVbS305rjo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-C71-KhJUPMejREfGGRZhaw-1; Fri, 22 Sep 2023 04:49:28 -0400
X-MC-Unique: C71-KhJUPMejREfGGRZhaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB7D11C06EC4;
        Fri, 22 Sep 2023 08:49:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BFA1140E950;
        Fri, 22 Sep 2023 08:49:21 +0000 (UTC)
Date:   Fri, 22 Sep 2023 16:49:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 4/5] blk-mq: update driver tags request table when
 start request
Message-ID: <ZQ1VDRYXpynVXU/4@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-5-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-5-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 13, 2023 at 03:16:15PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now we update driver tags request table in blk_mq_get_driver_tag(),
> so the driver that support queue_rqs() have to update that inflight
> table by itself.
> 
> Move it to blk_mq_start_request(), which is a better place where
> we setup the deadline for request timeout check. And it's just
> where the request becomes inflight.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks
Ming

