Return-Path: <SRS0=0HSq=CV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE61C433E2
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C4B208B3
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 14:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISgc92OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgILOH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Sep 2020 10:07:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbgILOHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Sep 2020 10:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599919610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPwQiHvAv7wsXej8Zd/nygKO59cvFZQB1hoT7gIn9bg=;
        b=ISgc92OY0u2n3PbSbIYQX1XZ4VRc5WzrMykeEx2pXJl96wadQHX/blJNPamZblXdd9eHu7
        O8RFTMt23+kpRYVFVHtXx9gXugNoT4Am9A9npul3lZGzjmhE6b6r7ZEKfiZQ80qKDVnK3p
        LK34oxbbC9LGzA3KyjOSH/ldWPfhblo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-wMp-Q_XtPX2Tx9YlJrmDJw-1; Sat, 12 Sep 2020 10:06:48 -0400
X-MC-Unique: wMp-Q_XtPX2Tx9YlJrmDJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55A9D640B7;
        Sat, 12 Sep 2020 14:06:47 +0000 (UTC)
Received: from T590 (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C30175141;
        Sat, 12 Sep 2020 14:06:35 +0000 (UTC)
Date:   Sat, 12 Sep 2020 22:06:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: allow 'chunk_sectors' to be non-power-of-2
Message-ID: <20200912140630.GC210077@T590>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-4-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215338.44805-4-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 05:53:38PM -0400, Mike Snitzer wrote:
> It is possible for a block device to use a non power-of-2 for chunk
> size which results in a full-stripe size that is also a non
> power-of-2.
> 
> Update blk_queue_chunk_sectors() and blk_max_size_offset() to
> accommodate drivers that need a non power-of-2 chunk_sectors.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/blk-settings.c   | 10 ++++------
>  include/linux/blkdev.h | 12 +++++++++---
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index b09642d5f15e..e40a162cc946 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -172,15 +172,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);
>   *
>   * Description:
>   *    If a driver doesn't want IOs to cross a given chunk size, it can set
> - *    this limit and prevent merging across chunks. Note that the chunk size
> - *    must currently be a power-of-2 in sectors. Also note that the block
> - *    layer must accept a page worth of data at any offset. So if the
> - *    crossing of chunks is a hard limitation in the driver, it must still be
> - *    prepared to split single page bios.
> + *    this limit and prevent merging across chunks. Note that the block layer
> + *    must accept a page worth of data at any offset. So if the crossing of
> + *    chunks is a hard limitation in the driver, it must still be prepared
> + *    to split single page bios.
>   **/
>  void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
>  {
> -	BUG_ON(!is_power_of_2(chunk_sectors));
>  	q->limits.chunk_sectors = chunk_sectors;
>  }
>  EXPORT_SYMBOL(blk_queue_chunk_sectors);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 453a3d735d66..e72bcce22143 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1059,11 +1059,17 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>  static inline unsigned int blk_max_size_offset(struct request_queue *q,
>  					       sector_t offset)
>  {
> -	if (!q->limits.chunk_sectors)
> +	unsigned int chunk_sectors = q->limits.chunk_sectors;
> +
> +	if (!chunk_sectors)
>  		return q->limits.max_sectors;
>  
> -	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
> -			(offset & (q->limits.chunk_sectors - 1))));
> +	if (is_power_of_2(chunk_sectors))
> +		chunk_sectors -= (offset & (chunk_sectors - 1));
> +	else
> +		chunk_sectors -= sector_div(offset, chunk_sectors);
> +
> +	return min(q->limits.max_sectors, chunk_sectors);
>  }
>  
>  static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
> -- 
> 2.15.0
> 

is_power_of_2() is cheap enough for fast path, so looks fine to support
non-power-of-2 chunk sectors.

Maybe NVMe PCI can remove the power_of_2() limit too.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

