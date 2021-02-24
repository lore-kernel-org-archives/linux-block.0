Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3233C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64537600CF
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 11:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhBXLVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:21:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232806AbhBXLVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 06:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614165612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jJ4jc72M5PbEjXxT0Wi0W4m7621PUvO0etSZ1MK8OI=;
        b=EqnD18adXbhD/DyybQvxo//gxRor9S+OpPL6GFji0kc+bpKFNOkrPKrnY2PDi0523VB4kE
        zLEpW4fTMdHWASQz5y51WVaIXwMHG8ViMNhyetPJQ6pKGOschgBVRPz17TkGSnK6PBMI/o
        V6m+WPn3zpDZfaqZ2IyFNP/3XAUcipk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-v2JpZjoCONSLnFILOV-duA-1; Wed, 24 Feb 2021 06:20:08 -0500
X-MC-Unique: v2JpZjoCONSLnFILOV-duA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC7661008304;
        Wed, 24 Feb 2021 11:20:06 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 954026064B;
        Wed, 24 Feb 2021 11:19:57 +0000 (UTC)
Date:   Wed, 24 Feb 2021 19:19:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: memory allocations in bounce_clone_bio must
 not fail
Message-ID: <YDY2WPtSLmvNt0W2@T590>
References: <20210224072407.46363-1-hch@lst.de>
 <20210224072407.46363-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224072407.46363-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 08:24:07AM +0100, Christoph Hellwig wrote:
> The caller can't cope with a failure from bounce_clone_bio, so
> use __GFP_NOFAIL for the passthrough case.  bio_alloc_bioset already
> won't fail due to the use of mempools.
> 
> And yes, we need to get rid of this bock layer bouncing code entirely
> sooner or later..
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bounce.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 417faaac36b691..87983a35079c22 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -242,12 +242,11 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
>  	 *    __bio_clone_fast() anyways.
>  	 */
>  	if (bio_is_passthrough(bio_src))
> -		bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
> +		bio = bio_kmalloc(GFP_NOIO | __GFP_NOFAIL,
> +				  bio_segments(bio_src));

bio_kmalloc() still may fail if bio_segments(bio_src) is > UIO_MAXIOV.


-- 
Ming

