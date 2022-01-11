Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0751C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 18:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiAKSLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbiAKSLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 13:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641924703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+wTX6j3j97mwwT4hfGBYkyGT2W0iJs1CdSTf1zXvJM=;
        b=aGL60E4ZLl9p9PTc0rUNNzdzzDO+nQPFlFeHufphClCCt57neb5PTrqIQG2LnPvE5lbbw1
        +cRIbptdLg6TEShpklqcGm4vxEKr/t5E2n3xQZ/K0vuLGC/26ys0ZrGxtc6mTQ6MzHMJsX
        Vhiz30IwCe6P0miN64SOlp++0tYsuVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-UAhRdY9mN2qUlj29G69VJw-1; Tue, 11 Jan 2022 13:11:42 -0500
X-MC-Unique: UAhRdY9mN2qUlj29G69VJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95DE01083F60;
        Tue, 11 Jan 2022 18:11:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B78107FBBE;
        Tue, 11 Jan 2022 18:11:27 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 2/3] block: add blk_alloc_disk_srcu
References: <20211221141459.1368176-1-ming.lei@redhat.com>
        <20211221141459.1368176-3-ming.lei@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 11 Jan 2022 13:13:58 -0500
In-Reply-To: <20211221141459.1368176-3-ming.lei@redhat.com> (Ming Lei's
        message of "Tue, 21 Dec 2021 22:14:58 +0800")
Message-ID: <x49mtk2jg2h.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> Add blk_alloc_disk_srcu() so that we can allocate srcu inside request queue
> for supporting blocking ->queue_rq().
>
> dm-rq needs this API.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  block/genhd.c         |  5 +++--
>  include/linux/genhd.h | 12 ++++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 3c139a1b6f04..d21786fbb7bb 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1333,12 +1333,13 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  }
>  EXPORT_SYMBOL(__alloc_disk_node);
>  
> -struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
> +struct gendisk *__blk_alloc_disk(int node, bool alloc_srcu,
> +		struct lock_class_key *lkclass)
>  {
>  	struct request_queue *q;
>  	struct gendisk *disk;
>  
> -	q = blk_alloc_queue(node, false);
> +	q = blk_alloc_queue(node, alloc_srcu);
>  	if (!q)
>  		return NULL;
>  
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 6906a45bc761..20259340b962 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -227,23 +227,27 @@ void blk_drop_partitions(struct gendisk *disk);
>  struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  		struct lock_class_key *lkclass);
>  extern void put_disk(struct gendisk *disk);
> -struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
> +struct gendisk *__blk_alloc_disk(int node, bool alloc_srcu,
> +		struct lock_class_key *lkclass);
>  
>  /**
> - * blk_alloc_disk - allocate a gendisk structure
> + * __alloc_disk - allocate a gendisk structure
>   * @node_id: numa node to allocate on
> + * @alloc_srcu: allocate srcu instance for supporting blocking ->queue_rq
>   *
>   * Allocate and pre-initialize a gendisk structure for use with BIO based
>   * drivers.
>   *
>   * Context: can sleep
>   */
> -#define blk_alloc_disk(node_id)						\
> +#define __alloc_disk(node_id, alloc_srcu)				\
>  ({									\
>  	static struct lock_class_key __key;				\
>  									\
> -	__blk_alloc_disk(node_id, &__key);				\
> +	__blk_alloc_disk(node_id, alloc_srcu, &__key);			\
>  })
> +#define blk_alloc_disk(node_id) __alloc_disk(node_id, false)
> +#define blk_alloc_disk_srcu(node_id) __alloc_disk(node_id, true)
>  void blk_cleanup_disk(struct gendisk *disk);
>  
>  int __register_blkdev(unsigned int major, const char *name,

