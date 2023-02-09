Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B94C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 03:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjBIDmT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 22:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjBIDmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 22:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FED23660
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 19:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675914095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbW9aAe+2h5hZXVZHRxOgrNyP6II/ic5cjLjQDf+SlA=;
        b=TofiRXppGMQr7OxgxLF1OnAXKdJMYI8CX0f3wYV1AkuvpGPAf79oqU/QOoI9z5LFh22Ibk
        WiqSxR1OndTItqgNpgiUcZ0zq08XyX/j2I6Y4ErMrY3NsJWclVj3rGGyjB43cDIB2/Wl/3
        aZnv1xvvc3PiQlRGvWtd8+aBsr49pTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-FKQNaSwkPQ6M5lfyRioJVQ-1; Wed, 08 Feb 2023 22:41:31 -0500
X-MC-Unique: FKQNaSwkPQ6M5lfyRioJVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6628B8027EB;
        Thu,  9 Feb 2023 03:41:31 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D04A8140EBF4;
        Thu,  9 Feb 2023 03:41:28 +0000 (UTC)
Date:   Thu, 9 Feb 2023 11:41:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiao Ni <xni@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Merge bio before checking ->cached_rq
Message-ID: <Y+RrY2Gsf9lRQwvL@T590>
References: <20230209031930.27354-1-xni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209031930.27354-1-xni@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 09, 2023 at 11:19:30AM +0800, Xiao Ni wrote:
> It checks if plug->cached_rq is empty before merging bio. But the merge action
> doesn't have relationship with plug->cached_rq, it trys to merge bio with
> requests within plug->mq_list. Now it checks if ->cached_rq is empty before
> merging bio. If it's empty, it will miss the merge chances. So move the merge
> function before checking ->cached_rq.
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>  block/blk-mq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

