Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765EDEE4996
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 12:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjHVMrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHVMrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 08:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A0CD5
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692708389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gDPDk1Kq+6VFaBdbaEC4ExFJZ9+gDFr8BOe1DLrkwg=;
        b=i5ttU4KOH/vg1jxrY2bQV5lLRWAlrU44Ws+nqOvToZgLteJbpGWhqcWdwC05LZpkHKtL2Y
        bRb3QWp7NmsioqpxWrSzo+vcqWgZzR0u/WnHaQoCyAudt636A2c9IB63zJMUD/CZgAhHIG
        OHbcyOFWcuiKNC51EjA+MKG1daNncZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-hJE6hMbzPQC-vQFxPTrR6w-1; Tue, 22 Aug 2023 08:46:23 -0400
X-MC-Unique: hJE6hMbzPQC-vQFxPTrR6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4B2D101B432;
        Tue, 22 Aug 2023 12:46:20 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 788D11121314;
        Tue, 22 Aug 2023 12:46:16 +0000 (UTC)
Date:   Tue, 22 Aug 2023 20:46:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 2/3] blk-mq: delete redundant tagset map update when
 fallback
Message-ID: <ZOSuE7UlkEIXuQVk@fedora>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
 <20230821095602.70742-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821095602.70742-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 21, 2023 at 05:56:01PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> When we increase nr_hw_queues fail, the fallback path will use
> blk_mq_update_queue_map() to clear and update all maps.
> Obviously, this line of update of HCTX_TYPE_DEFAULT only is not
> needed, so delete it.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

