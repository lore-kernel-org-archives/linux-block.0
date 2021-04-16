Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475BC433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 20:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A518613C7
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 20:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbhDPUES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242654AbhDPUER (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 16:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618603431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kqwxsx+MRBYBkqvR2OmLtUQzOcoajlA/yVwvOd9pcJ8=;
        b=fTUoHHiCh5TDsb7F713m45ks4fsT2JVFb2Eld4806oUopOiid04qDl8/fI+JKl2UGqb8K5
        GExfOpj4ztC8k4duwuYm2ERhUwoEaopu63H0nIiwT7zaixGXhjO/qDT/T3O60niiC2vh50
        vSvZ2rf2tsvwyiPOATeYUxAvx1JBLb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-yKzm0bVCO0uK_P3y-e7Z_A-1; Fri, 16 Apr 2021 16:03:49 -0400
X-MC-Unique: yKzm0bVCO0uK_P3y-e7Z_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4647280D6A9;
        Fri, 16 Apr 2021 20:03:48 +0000 (UTC)
Received: from ovpn-112-203.phx2.redhat.com (ovpn-112-203.phx2.redhat.com [10.3.112.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF73107D5C0;
        Fri, 16 Apr 2021 20:03:40 +0000 (UTC)
Message-ID: <01f223290184e0b2301c8dadc435520594c3dee9.camel@redhat.com>
Subject: Re: [dm-devel] [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
Date:   Fri, 16 Apr 2021 16:03:40 -0400
In-Reply-To: <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
References: <20210415231530.95464-1-snitzer@redhat.com>
         <20210415231530.95464-4-snitzer@redhat.com>
         <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2021-04-16 at 16:07 +0200, Hannes Reinecke wrote:
> 
> Hmm. Quite convoluted, methinks.
> Shouldn't this achieve the same thing?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e89ec2522ca6..8c36a2196b66 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -303,8 +303,10 @@ static inline enum nvme_disposition
> nvme_decide_disposition(struct request *req)
>         if (likely(nvme_req(req)->status == 0))
>                 return COMPLETE;
> 
> -       if (blk_noretry_request(req) ||
> -           (nvme_req(req)->status & NVME_SC_DNR) ||
> +       if (blk_noretry_request(req))
> +               nvme_req(req)->status |= NVME_SC_DNR;
> +
> +       if ((nvme_req(req)->status & NVME_SC_DNR) ||
>             nvme_req(req)->retries >= nvme_max_retries)
>                 return COMPLETE;
> 

I am not in favor of altering ->status to set DNR jus to
simplify the following conditional.

-Ewan

