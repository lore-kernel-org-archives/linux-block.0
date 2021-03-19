Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B1FC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A446197B
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSRoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 13:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhCSRod (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 13:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616175873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yprWRSB7vS80FLiQJh7hMRGMJTNWmDK1YYymuS08YsU=;
        b=cJH+0lowBQrIp9OlB6EAh1xY3zwSh9NhpEELRFbq5xRYPawodLt9a3ZrYIkLAEo7l6rcd1
        xuJ08EFfiVU4YLfKzGJlYGkMuzkNe3e8UP1TbxTaTDY7zzz47ev2htHH+8E7qEkAfkMXvb
        zssKcujnQeC1Bg6UEBETL8xS1UW/w1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-Z6xNQzUzO0SAJjXNwNAqiA-1; Fri, 19 Mar 2021 13:44:31 -0400
X-MC-Unique: Z6xNQzUzO0SAJjXNwNAqiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D466681744F;
        Fri, 19 Mar 2021 17:44:29 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 766C019C79;
        Fri, 19 Mar 2021 17:44:23 +0000 (UTC)
Date:   Fri, 19 Mar 2021 13:44:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 06/13] block: add new field into 'struct bvec_iter'
Message-ID: <20210319174422.GD9938@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318164827.1481133-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18 2021 at 12:48pm -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> There is a hole at the end of 'struct bvec_iter', so put a new field
> here and we can save cookie returned from submit_bio() here for
> supporting bio based polling.
> 
> This way can avoid to extend bio unnecessarily.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/bvec.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index ff832e698efb..61c0f55f7165 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -43,6 +43,15 @@ struct bvec_iter {
>  
>  	unsigned int            bi_bvec_done;	/* number of bytes completed in
>  						   current bvec */
> +
> +	/*
> +	 * There is a hole at the end of bvec_iter, define one filed to

s/filed/field/

> +	 * hold something which isn't relate with 'bvec_iter', so that we can

s/relate/related/
or
s/isn't relate with/doesn't relate to/

> +	 * avoid to extend bio. So far this new field is used for bio based

s/to extend/extending/

> +	 * pooling, we will store returning value of underlying queue's

s/pooling/polling/

> +	 * submit_bio() here.
> +	 */
> +	unsigned int		bi_private_data;
>  };
>  
>  struct bvec_iter_all {
> -- 
> 2.29.2
> 

