Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6293DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 01:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477B760F26
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 01:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhINBNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237193AbhINBND (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 21:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631581906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAmERlnzgu6E6drIi7Ej5aFj4eTItZbD2NbSWsNlmtQ=;
        b=In9RLAtlE4rjx/2K0/ZbJqhGf28D/hBzpBK9d4mebPKEzXG2yuGAabm8pUifD1xKr9rMWd
        xKpHLeDUhZQxg53y2Sn1cxRbwRN7dsm7hTq/Fs8Rn4+mBNkJplf/5mdy0wlUsJ4QMWhwi6
        sxjJTGLMm24J8YTbN8vI+tCdoAJR2TA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-AWq1OgyxOhaXC5VvJWxvPQ-1; Mon, 13 Sep 2021 21:11:45 -0400
X-MC-Unique: AWq1OgyxOhaXC5VvJWxvPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC277802936;
        Tue, 14 Sep 2021 01:11:43 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9220A60C82;
        Tue, 14 Sep 2021 01:11:34 +0000 (UTC)
Date:   Tue, 14 Sep 2021 09:11:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YT/2z4PSeW5oJWMq@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909141256.2606682-6-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
> blk_mq_tag_to_rq() can only ensure to return valid request in
> following situation:
> 
> 1) client send request message to server first
> submit_bio
> ...
>  blk_mq_get_tag
>  ...
>  blk_mq_get_driver_tag
>  ...
>  nbd_queue_rq
>   nbd_handle_cmd
>    nbd_send_cmd
> 
> 2) client receive respond message from server
> recv_work
>  nbd_read_stat
>   blk_mq_tag_to_rq
> 
> If step 1) is missing, blk_mq_tag_to_rq() will return a stale
> request, which might be freed. Thus convert to use
> blk_mq_find_and_get_req() to make sure the returned request is not
> freed.

But NBD_CMD_INFLIGHT has been added for checking if the reply is
expected, do we still need blk_mq_find_and_get_req() for covering
this issue? BTW, request and its payload is pre-allocated, so there
isn't real use-after-free.


Thanks,
Ming

