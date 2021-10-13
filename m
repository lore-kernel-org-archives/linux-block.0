Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB13C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6405D60ED4
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhJMJY6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230150AbhJMJY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634116973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWnFrkPl/HQNKGbEFFdCtAjAbrQ0f0wfX+pKKqhAWSU=;
        b=aQuS4SnYdXl85kxRQ0cmDIQzW67msxsxCpouMOtoGJ48bsgEplbgzP0aEi4AZM4CZ9jn6D
        y9hFLis4zaxYj/qcc8ra75ahw6HfcBSOz/rTD4nwCy1nw2n2EYnguU3Ze/eD2T70aaBRlb
        5izYTbLVbBzyC9Fa2hI4SRuJG355VCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-n_8-IG_fM_uOmtY2wl_brw-1; Wed, 13 Oct 2021 05:22:52 -0400
X-MC-Unique: n_8-IG_fM_uOmtY2wl_brw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22CBF5074C;
        Wed, 13 Oct 2021 09:22:51 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782BE22713;
        Wed, 13 Oct 2021 09:22:47 +0000 (UTC)
Date:   Wed, 13 Oct 2021 17:22:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Message-ID: <YWalYoOZmpkmAZNK@T590>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 04:40:59PM +0800, John Garry wrote:
> Since it is now possible for a tagset to share a single set of tags, the
> iter function should not re-iter the tags for the count of #hw queues in
> that case. Rather it should just iter once.
> 
> Fixes: e0fdf846c7bb ("blk-mq: Use shared tags for shared sbitmap support")
> Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 72a2724a4eee..c943b6529619 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -378,9 +378,12 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>  void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  		busy_tag_iter_fn *fn, void *priv)
>  {
> -	int i;
> +	unsigned int flags = tagset->flags;
> +	int i, nr_tags;
> +
> +	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>  
> -	for (i = 0; i < tagset->nr_hw_queues; i++) {
> +	for (i = 0; i < nr_tags; i++) {
>  		if (tagset->tags && tagset->tags[i])
>  			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>  					      BT_TAG_ITER_STARTED);

blk_mq_queue_tag_busy_iter() needn't such change?


Thanks,
Ming

