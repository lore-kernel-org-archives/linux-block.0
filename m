Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF10C34022
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57A220836
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 03:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLgJpdeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgBRDE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:04:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgBRDE0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 22:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581995064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyZW/Ktx7axLt/SWGti91dUVmafJ334/8fDNA/sZCEM=;
        b=jLgJpdeVYkCMJHVeD4ajrel6ymZxbeiq1DDshI75l0s0aKLjHxxcCzM9K2DjQT/uIaas4F
        4Qvwnk5CS/HCKtoBCV/IxiFPCmDtTzf/XoUKYbNwdZYjqvPQ9rDGbK383vnbElbukCz4r5
        bPHY/TJz5Kezt8bD7h78P23tQz7Oycc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-qkxYGGtVPPaKDMiIoYgVIQ-1; Mon, 17 Feb 2020 22:04:20 -0500
X-MC-Unique: qkxYGGtVPPaKDMiIoYgVIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B598A8010F2;
        Tue, 18 Feb 2020 03:04:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8905E60BE1;
        Tue, 18 Feb 2020 03:04:13 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:04:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH 1/5] blk-mq: Fix a comment in include/linux/blk-mq.h
Message-ID: <20200218030408.GA30750@ming.t460p>
References: <20200217210839.28535-1-bvanassche@acm.org>
 <20200217210839.28535-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200217210839.28535-2-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 17, 2020 at 01:08:35PM -0800, Bart Van Assche wrote:
> The 'hctx_list' member of struct blk_mq_hw_ctx is not a list head but
> instead an entry in q->unused_hctx_list. Fix the comment above this
> struct member.
>=20
> Cc: Andr=E9 Almeida <andrealmeid@collabora.com>
> Fixes: d386732bc142 ("blk-mq: fill header with kernel-doc")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blk-mq.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 11cfd6470b1a..31344d5f83e2 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -162,7 +162,10 @@ struct blk_mq_hw_ctx {
>  	struct dentry		*sched_debugfs_dir;
>  #endif
> =20
> -	/** @hctx_list:	List of all hardware queues. */
> +	/**
> +	 * @hctx_list: if this hctx is not in use, this is an entry in
> +	 * q->unused_hctx_list.
> +	 */
>  	struct list_head	hctx_list;

The patch itself is correct, however, we may rename the field as
'unused_node' or whatever so that it can be self-documented.


Thanks,
Ming

