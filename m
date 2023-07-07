Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39881EB64D9
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 10:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGGKHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 06:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGGKHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 06:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B8170F
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688724407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSvxmo86chuNdo4OZEtSWD076Vkrebseittknh73kpQ=;
        b=HOCnwj6MGdPt5w9Cyz0ZIINk18beVgb/AKrf0Trwlu2Nm76UiUIFvba8oNq1Msf3LyX5aE
        uTqaKawhL9LWbqdvI7SSpBs1Xy11uT444lzWugwvw8dZTWXP+Xz94PALrZCMooXmPswZ0b
        fOnh4oGbQS9+MW60jpAPVag7jvTa8do=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Rg4ImdXwM9ei7Tx08fjlXg-1; Fri, 07 Jul 2023 06:06:41 -0400
X-MC-Unique: Rg4ImdXwM9ei7Tx08fjlXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3C5D185A791;
        Fri,  7 Jul 2023 10:06:40 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED40200BA8B;
        Fri,  7 Jul 2023 10:06:35 +0000 (UTC)
Date:   Fri, 7 Jul 2023 18:06:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v3 4/4] blk-flush: reuse rq queuelist in flush state
 machine
Message-ID: <ZKfjpkBmbM8OZIuI@ovpn-8-34.pek2.redhat.com>
References: <20230707093722.1338589-1-chengming.zhou@linux.dev>
 <20230707093722.1338589-5-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707093722.1338589-5-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 07, 2023 at 05:37:22PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since we don't need to maintain inflight flush_data requests list
> anymore, we can reuse rq->queuelist for flush pending list.
> 
> Note in mq_flush_data_end_io(), we need to re-initialize rq->queuelist
> before reusing it in the state machine when end, since the rq->rq_next
> also reuse it, may have corrupted rq->queuelist by the driver.
> 
> This patch decrease the size of struct request by 16 bytes.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v3:
>  - fix a bug report of blktests nvme/012, we need to re-initialize
>    rq->queuelist before reusing it in the state machine when end.
>    Because rq->rq_next reuse may have corrupted it. Thanks Ming Lei.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

