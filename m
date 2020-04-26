Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA9C55186
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 03:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B76620724
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 03:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4Wls5H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDZDAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:00:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgDZDAA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 23:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587869998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgAUqRrHW2Uk9GWQWRdP1gyQgZ7e+CvG2W3OuQs8Az0=;
        b=S4Wls5H7Zle0yg9TI5dMpXHwLigFgK4htUFVopFbgMfY/7A/ky53RyZdepE3H0vpZjm/cr
        cHK7tt/h9+WGQciJ0TXw5F/fqGWBprT4eocGVX+EisFnkWAT8zE6+j/TJAS+mu9hB97Gan
        LxfomMbOpxVYXAHf0m2w5ZMXJKTJE5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-p0sGB4UTMdKyHjaICbHWag-1; Sat, 25 Apr 2020 22:59:56 -0400
X-MC-Unique: p0sGB4UTMdKyHjaICbHWag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D1E107ACCD;
        Sun, 26 Apr 2020 02:59:55 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC93360300;
        Sun, 26 Apr 2020 02:59:49 +0000 (UTC)
Date:   Sun, 26 Apr 2020 10:59:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/11] block: improve the kerneldoc comments for
 submit_bio and generic_make_request
Message-ID: <20200426025944.GB512559@T590>
References: <20200425170944.968861-1-hch@lst.de>
 <20200425170944.968861-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425170944.968861-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 07:09:34PM +0200, Christoph Hellwig wrote:
> The current documentation is a little weird, as it doesn't clearly
> explain which function to use, and also has the guts of the information
> on generic_make_request, which is the internal interface for stacking
> drivers.
> 
> Fix this up by properly documenting submit_bio, and only documenting
> the differences and the use case for generic_make_request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index dffff21008886..68351ee94ad2e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -992,28 +992,13 @@ generic_make_request_checks(struct bio *bio)
>  }
>  
>  /**
> - * generic_make_request - hand a buffer to its device driver for I/O
> + * generic_make_request - re-submit a bio to the block device layer for I/O
>   * @bio:  The bio describing the location in memory and on the device.
>   *
> - * generic_make_request() is used to make I/O requests of block
> - * devices. It is passed a &struct bio, which describes the I/O that needs
> - * to be done.
> - *
> - * generic_make_request() does not return any status.  The
> - * success/failure status of the request, along with notification of
> - * completion, is delivered asynchronously through the bio->bi_end_io
> - * function described (one day) else where.
> - *
> - * The caller of generic_make_request must make sure that bi_io_vec
> - * are set to describe the memory buffer, and that bi_dev and bi_sector are
> - * set to describe the device address, and the
> - * bi_end_io and optionally bi_private are set to describe how
> - * completion notification should be signaled.
> - *
> - * generic_make_request and the drivers it calls may use bi_next if this
> - * bio happens to be merged with someone else, and may resubmit the bio to
> - * a lower device by calling into generic_make_request recursively, which
> - * means the bio should NOT be touched after the call to ->make_request_fn.
> + * This is a version of submit_bio() that shall only be used for I/O that is
> + * resubmitted to lower level drivers by stacking block drivers.  All file

No, generic_make_request() can be used by any block driver instead of
stacking drivers, see bio split, blk_throttle.c and bounce, maybe more.


Thanks, 
Ming

