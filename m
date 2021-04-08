Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970AC433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DF661159
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhDHIhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 04:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhDHIhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 04:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617871015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOA0xB3rNXG4BSY+IxPVfdJIxfzxpsclazgrzyolNlI=;
        b=W4PTlTacpsOFBfn/WsxbcYUsXs7V4fnlGocqAspn36DCVJxs5pIkOLYWh6w4HlFUY4X5uI
        lm8U35N8wPx62iUrrh13cYsjwO24uVz9MOSa4OYqccCDrM1YMBIzix5Xc7QJeGtZ4RmR8J
        G1ZAjop2Q716i/i1b6WmHNoUeAFlUcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Y0sd0jbWMyK--vsAUwXl1Q-1; Thu, 08 Apr 2021 04:36:51 -0400
X-MC-Unique: Y0sd0jbWMyK--vsAUwXl1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51E3D87504E;
        Thu,  8 Apr 2021 08:36:50 +0000 (UTC)
Received: from T590 (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CBBE5D755;
        Thu,  8 Apr 2021 08:36:43 +0000 (UTC)
Date:   Thu, 8 Apr 2021 16:36:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
Message-ID: <YG7AlzvLSyyeM8lL@T590>
References: <20210406031933.767228-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406031933.767228-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

On Tue, Apr 06, 2021 at 11:19:33AM +0800, Ming Lei wrote:
> Yanhui found that write performance is degraded a lot after applying
> hctx shared tagset on one test machine with megaraid_sas. And turns out
> it is caused by none scheduler which becomes default elevator caused by
> hctx shared tagset patchset.
> 
> Given more scsi HBAs will apply hctx shared tagset, and the similar
> performance exists for them too.
> 
> So keep previous behavior by still using default mq-deadline for queues
> which apply hctx shared tagset, just like before.
> 
> Fixes: 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per tagset")
> Reported-by: Yanhui Ma <yama@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Any chance to make it in 5.12 if you are fine?

Thanks,
Ming

