Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E670CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 00:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C751D60EFE
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 00:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhINAzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 20:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhINAzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 20:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631580870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJecgffscZyS8jybTRNi6LBusFI022jT9cPdy4rCZas=;
        b=AbxjpX4pwdPR6xsbTIsMpJTARxPDuMgs2lxxJMRFGh2yXg9kfAZmHL4tnstrbIMiIBRCkW
        mfrU6LVi+6nmN8aY0lROdZDy7kx1YdLWM/npgwRHCxmXT6Q237FxgmGExLTaxUtal//cx5
        xtLshpKbeRs9mpx5o7JKfUtkxvdu+ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-I0hSVFWSPi-u5Rp1IxLG4w-1; Mon, 13 Sep 2021 20:54:29 -0400
X-MC-Unique: I0hSVFWSPi-u5Rp1IxLG4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB20835DE1;
        Tue, 14 Sep 2021 00:54:28 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F01FA7A5CE;
        Tue, 14 Sep 2021 00:54:18 +0000 (UTC)
Date:   Tue, 14 Sep 2021 08:54:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 1/6] nbd: don't handle response without a
 corresponding request message
Message-ID: <YT/yw3QomdPgHx6m@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909141256.2606682-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 10:12:51PM +0800, Yu Kuai wrote:
> While handling a response message from server, nbd_read_stat() will
> try to get request by tag, and then complete the request. However,
> this is problematic if nbd haven't sent a corresponding request
> message:
> 
> t1                      t2
>                         submit_bio
>                          nbd_queue_rq
>                           blk_mq_start_request
> recv_work
>  nbd_read_stat
>   blk_mq_tag_to_rq
>  blk_mq_complete_request
>                           nbd_send_cmd
> 
> Thus add a new cmd flag 'NBD_CMD_INFLIGHT', it will be set in
> nbd_send_cmd() and checked in nbd_read_stat().
> 
> Noted that this patch can't fix that blk_mq_tag_to_rq() might
> return a freed request, and this will be fixed in following
> patches.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

