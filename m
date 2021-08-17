Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5BFC4338F
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B2160E52
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 01:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhHQBEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 21:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhHQBEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 21:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629162253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG5Fcyxm6S4hnyaO0xkZZn4/EVP6ILH79aGGHJXsp5U=;
        b=axg/vRgxfTSaBcHwXANVthuK3quPn6E/s4zV8jqDe2uf2aRv4wkqx3IwGQl86kyckF/znH
        V/ymr8PlHDuzfohDWcK2Tk+hGhVzY32quhU1J2B5O5jSyPeI+p2oX7S1FKiZJDUQPcThiC
        ShUq8EH3Z6MtuTwgbhnTip3G6svc++s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-I-Xts_sVNROY6j4sQcp46w-1; Mon, 16 Aug 2021 21:04:10 -0400
X-MC-Unique: I-Xts_sVNROY6j4sQcp46w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 812A21853026;
        Tue, 17 Aug 2021 01:04:08 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EE755D6A8;
        Tue, 17 Aug 2021 01:03:56 +0000 (UTC)
Date:   Tue, 17 Aug 2021 09:03:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] blk-mq: don't grab rq's refcount in
 blk_mq_check_expired()
Message-ID: <YRsK9/ewQFLaRtLZ@T590>
References: <20210811155202.629575-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811155202.629575-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 11:52:02PM +0800, Ming Lei wrote:
> Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
> refcount before calling ->fn(), so needn't to grab it one more time
> in blk_mq_check_expired().
> 
> Meantime remove extra request expire check in blk_mq_check_expired().
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove extra request expire check as suggested by Keith
> 	- modify comment a bit
> 

Hello Jens,

Ping...

Thanks,
Ming

