Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A9C4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiJQJu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiJQJuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 05:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AD0178A3
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666000242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/hLKlsERRt3h4yQf2hkRC/CTDlKS76rGmOOz0nro80=;
        b=h4/AFWXg3rrO08Ij3N9xhvH9S6+M9ixdGSF26sW/6/9ofTdM8ZuQn5ZH7AxWwUGJ7WEvjr
        Z5GPkX3G2Lq0hlB7FJDZR0JRXOsJSurA3oiCiK7kA0+csHoC8V2zmyyR85Sq4hXx1zsQ9m
        wbUrgMmRcjtdaPmz+wgBhU33y05xSW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-m6trYIe7OI-mWk54wyFVqg-1; Mon, 17 Oct 2022 05:50:36 -0400
X-MC-Unique: m6trYIe7OI-mWk54wyFVqg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A767800B30;
        Mon, 17 Oct 2022 09:50:36 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F7B492B04;
        Mon, 17 Oct 2022 09:50:29 +0000 (UTC)
Date:   Mon, 17 Oct 2022 17:50:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Message-ID: <Y00lYIhUNv1CxqiK@T590>
References: <20221016052006.11126-1-kch@nvidia.com>
 <Y00fkc1N+Cif/Kxt@T590>
 <0af3d1a4-8166-ea1e-8710-c51479c587a1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af3d1a4-8166-ea1e-8710-c51479c587a1@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 09:30:47AM +0000, Chaitanya Kulkarni wrote:
> 
> >> +	/*
> >> +	 * Unblock any pending dispatch I/Os before we destroy the device.
> >> +	 * From null_destroy_dev()->del_gendisk() will set GD_DEAD flag
> >> +	 * causing any new I/O from __bio_queue_enter() to fail with -ENODEV.
> >> +	 */
> >> +	blk_mq_unquiesce_queue(nullb->q);
> >> +
> >> +	null_destroy_dev(nullb);
> > 
> > destroying device is never good cleanup for handling timeout/abort, and it
> > should have been the last straw any time.
> > 
> 
> That is exactly why I've added the rq_abort_limit, so until the limit
> is not reached null_abort_work() will not get scheduled and device is
> not destroyed.

I meant destroying device should only be done iff the normal abort handler
can't recover the device, however, your patch simply destroys device
without running any abort handling.


Thanks,
Ming

