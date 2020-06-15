Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C740C433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 10:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4222B20663
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 10:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAL3taHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFOKmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:42:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39149 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729382AbgFOKmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 06:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592217755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPHbnpsP7nJsHwqhoLDcDNp33N50coO4YGuyYQ7o3xw=;
        b=CAL3taHDo1UJgEEenMF+vgCm5TWMglhZdDjXF4JQ1U3KL4659tuSi1PKSy1KwuTaJzaHRv
        gtvXiZvwy74tqRVy+JKjamWsUU5JbI1CMz17eBtVoF3A4PuCyTC8QhZ96LU/CxvOMn5vrk
        uUaX1CHqVDW6ejZPHMMnpprHzP0tOO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-T5eMHHQzOJucP76Svdhvjg-1; Mon, 15 Jun 2020 06:42:31 -0400
X-MC-Unique: T5eMHHQzOJucP76Svdhvjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B46C106B242;
        Mon, 15 Jun 2020 10:42:30 +0000 (UTC)
Received: from T590 (ovpn-12-247.pek2.redhat.com [10.72.12.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9264F768DC;
        Mon, 15 Jun 2020 10:42:24 +0000 (UTC)
Date:   Mon, 15 Jun 2020 18:42:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Remove redundant 'return' statement
Message-ID: <20200615104218.GB19764@T590>
References: <a93d3ae2b37c01bc1d30b0eb229241b81405e6ad.1592212094.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a93d3ae2b37c01bc1d30b0eb229241b81405e6ad.1592212094.git.baolin.wang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 15, 2020 at 05:12:23PM +0800, Baolin Wang wrote:
> The blk_mq_all_tag_iter() is a void function, thus remove
> the redundant 'return' statement in this function.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  block/blk-mq-tag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 44f3d09..ae722f8 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -376,7 +376,7 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
>  void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>  		void *priv)
>  {
> -	return __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
> +	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

