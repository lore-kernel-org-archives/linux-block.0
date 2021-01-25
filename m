Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D227AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48D022C9C
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbhAYCaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbhAYC3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 21:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611541672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4zw9Ed9jnquZ25gKaNKjF+BNmz4ZiKVVZvrldy7Ek4=;
        b=UrQY0bnPrwRmdtL0TsH6gTzDXjWavNLPcMBRdi3klLtd3zlR/qMGj4jQfBs6MNTiPsNnVN
        fLMmTws9uLdvbvZXQd8ljMlFJLWpCpnWCR5jWPsbzHIAnJgxWzOh/6zkC69QC826/EMGlv
        lvqosfLbksCp9XqZ8BSCe9jgULFfnJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-E7H9V6B8PNC994uVl-hvHQ-1; Sun, 24 Jan 2021 21:27:48 -0500
X-MC-Unique: E7H9V6B8PNC994uVl-hvHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B0510054FF;
        Mon, 25 Jan 2021 02:27:47 +0000 (UTC)
Received: from T590 (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 554EF60C17;
        Mon, 25 Jan 2021 02:27:42 +0000 (UTC)
Date:   Mon, 25 Jan 2021 10:27:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/6] block: improvement on bioset & bvec allocation
Message-ID: <20210125022738.GB984849@T590>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 11, 2021 at 11:05:51AM +0800, Ming Lei wrote:
> Hello Jens,
> 
> All are bioset / bvec improvement, and most of them are quite
> straightforward.
> 
> V3:
> 	- share two line code via goto with one label, only patch 1 is
> 	  changed
> 
> V2:
> 	- patch style change, most is in patch 1
> 	- commit log change
> 
> Ming Lei (6):
>   block: manage bio slab cache by xarray
>   block: don't pass BIOSET_NEED_BVECS for q->bio_split
>   block: don't allocate inline bvecs if this bioset needn't bvecs
>   block: set .bi_max_vecs as actual allocated vector number
>   block: move three bvec helpers declaration into private helper
>   bcache: don't pass BIOSET_NEED_BVECS for the 'bio_set' embedded in
>     'cache_set'
> 
>  block/bio.c               | 122 +++++++++++++++++---------------------
>  block/blk-core.c          |   2 +-
>  block/blk.h               |   4 ++
>  drivers/md/bcache/super.c |   2 +-
>  include/linux/bio.h       |   4 +-
>  5 files changed, 61 insertions(+), 73 deletions(-)
> 
> -- 
> 2.28.0
> 

Hello Jens,

Can you queue this patchset for 5.12?


Thanks,
Ming

