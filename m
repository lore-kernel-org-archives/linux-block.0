Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3EC63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3296C2085B
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLCGvM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgLCGvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606978186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tVcm7rW4DUcx0F/zEfb0fcyyeNk85tOI+gJY/teZCvk=;
        b=g8nP7erGSFhBgMspc5dMrqg/24T4aZJPQo/vZuN3sh6wzfr3aQKmuVdGL1gdrit3Fq0AAG
        yBzQGHs20jvrslrYZUPDvxqajYWjBZb5qQWRbvHdPHF4pnrISVsxDSKJcbqhn/NatGoKH6
        ywYVqNWYlZTTXH3gfZWEQyfxxLKCbQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-xwma2b44N6uRr6wydrijWw-1; Thu, 03 Dec 2020 01:49:44 -0500
X-MC-Unique: xwma2b44N6uRr6wydrijWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F324C1006C85;
        Thu,  3 Dec 2020 06:49:42 +0000 (UTC)
Received: from T590 (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68DF010016FB;
        Thu,  3 Dec 2020 06:49:36 +0000 (UTC)
Date:   Thu, 3 Dec 2020 14:49:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: use right tag offset after wait
Message-ID: <20201203064931.GB629758@T590>
References: <cover.1606699505.git.asml.silence@gmail.com>
 <beee275f48a98e42f073ee63221e9610fc9470b5.1606699505.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beee275f48a98e42f073ee63221e9610fc9470b5.1606699505.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 30, 2020 at 01:36:25AM +0000, Pavel Begunkov wrote:
> blk_mq_get_tag() selects tag_offset in the beginning and doesn't update
> it even though the tag set it may have changed hw queue during waiting.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-mq-tag.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..dbbf11edf9a6 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -101,10 +101,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  			return BLK_MQ_NO_TAG;
>  		}
>  		bt = tags->breserved_tags;
> -		tag_offset = 0;
>  	} else {
>  		bt = tags->bitmap_tags;
> -		tag_offset = tags->nr_reserved_tags;
>  	}
>  
>  	tag = __blk_mq_get_tag(data, bt);
> @@ -167,6 +165,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  	sbitmap_finish_wait(bt, ws, &wait);
>  
>  found_tag:
> +	if (data->flags & BLK_MQ_REQ_RESERVED)
> +		tag_offset = 0;
> +	else
> +		tag_offset = tags->nr_reserved_tags;
> +

So far, the tag offset is tag-set wide, and 'tag_offset' is same for all tags,
looks no need to add the extra check.


thanks,
Ming

