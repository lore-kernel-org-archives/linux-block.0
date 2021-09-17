Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A6C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 03:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF8461074
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 03:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbhIQDfQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232440AbhIQDfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 23:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631849634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpjC2vhQxMNwcJykwWES5XKw9YQ1dBU9ER+zWax0kyA=;
        b=R6tlPCE/s6UcVw7FHm8yYXeeW/iCI/c8Vf0XhJPbuHktqvXAb+2ghovVD1UiVD1SRKhR9m
        YNnV/TngGegdz8mUqmYCppKbys4VHeRh/qPsTnzCIo4mlnkFyMPh6I8vjxgjTqACL5B1G+
        hKvBR2GmirVCbxgdOor4WPM9ZAeoMw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-wkzXyDo5MjeoCvg_x25aVw-1; Thu, 16 Sep 2021 23:33:53 -0400
X-MC-Unique: wkzXyDo5MjeoCvg_x25aVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A9F71006AA3;
        Fri, 17 Sep 2021 03:33:51 +0000 (UTC)
Received: from T590.Home (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 964E960BF4;
        Fri, 17 Sep 2021 03:33:42 +0000 (UTC)
Date:   Fri, 17 Sep 2021 11:33:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v9] nbd: fix uaf in nbd_handle_reply()
Message-ID: <YUQMo1afA8v5/RJW@T590.Home>
References: <20210916093350.1410403-8-yukuai3@huawei.com>
 <20210916141810.2325276-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916141810.2325276-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 10:18:10PM +0800, Yu Kuai wrote:
> There is a problem that nbd_handle_reply() might access freed request:
> 
> 1) At first, a normal io is submitted and completed with scheduler:
> 
> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>  blk_mq_rq_ctx_init
>   sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> ...
> blk_mq_get_driver_tag
>  __blk_mq_get_driver_tag -> get tag from tags
>  tags->rq[tag] = sched_tag->static_rq[internel_tag]
> 
> So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
> to the request: sched_tags->static_rq[internal_tag]. Even if the
> io is finished.
> 
> 2) nbd server send a reply with random tag directly:
> 
> recv_work
>  nbd_handle_reply
>   blk_mq_tag_to_rq(tags, tag)
>    rq = tags->rq[tag]
> 
> 3) if the sched_tags->static_rq is freed:
> 
> blk_mq_sched_free_requests
>  blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
>   -> step 2) access rq before clearing rq mapping
>   blk_mq_clear_rq_mapping(set, tags, hctx_idx);
>   __free_pages() -> rq is freed here
> 
> 4) Then, nbd continue to use the freed request in nbd_handle_reply
> 
> Fix the problem by get 'q_usage_counter' before blk_mq_tag_to_rq(),
> thus request is ensured not to be freed because 'q_usage_counter' is
> not zero.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v9:
>  - move percpu_ref_put() behind.

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

