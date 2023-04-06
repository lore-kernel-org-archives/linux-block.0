Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AADC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjDFC4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjDFC4a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:56:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B465010F6
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:56:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q2so192548pll.7
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680749787; x=1683341787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AK9fwd/Vws1TaPzSlCmXG6j9yI6xeqQMUEflUc5xSN8=;
        b=TLrEw7jB0nnBHtBXpHUXHCCrzs/pRkuWKgxCRqGQdfb6RKOV9D1ZJ1zhpzyUxDr9XR
         eJTJfW34JrW30vWESAgV6cY7KvL1c2xjEglmtgqnsQ/RVYJ51r5+lEy7twEYbjgRpUpz
         X6LU5mHJbhswp8kVtsaRt1ZclyTNlAysa6+fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749787; x=1683341787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK9fwd/Vws1TaPzSlCmXG6j9yI6xeqQMUEflUc5xSN8=;
        b=FotKeZzc8B8oWT+Mdr319bQNrL28LL+o2n+8dH9O/c0BeIDG2QFwkIsou/0CTs8NAv
         vgyNOmoYsDqg4vADzwTi1vgFroZ6LZ5xjFGrVLA2jGHNaUx/60p1YfTEy70BgaqFIqKh
         /0KPj+dkiSWS5DuBfv3oSfbieBoVUk69+rKrx6ylWVubI1w5YIN+NRgjFMCivfq217+3
         DxaPSC8RizOkvpfIpVCxoV8ObhxTWrLO3ftInB6eG2yJ12rKGpUZ9OR5hDtrKK1xoE7n
         iveobBJ/0sv9f09dlF1ZiQnKMNEIk+avQRFKZOdkvh3naps/7Dyzb+03x/LnCGDr2ito
         Bh/g==
X-Gm-Message-State: AAQBX9d6FvgNqywlACOoshVpA2CpVZSZAlOqqtRywlsg20DAfgGxPfjT
        v9F+Qkx/35Iv3zbvwsB7AFWIgg==
X-Google-Smtp-Source: AKy350YCbETiHZ5SSigY97RWk2D1YCV1hoXXlJtKRuLhIrMw4H2RbFkyzKPqF4jAccW44xHp/FtXUg==
X-Received: by 2002:a05:6a20:3b97:b0:d3:5224:bbc2 with SMTP id b23-20020a056a203b9700b000d35224bbc2mr1382877pzh.42.1680749787180;
        Wed, 05 Apr 2023 19:56:27 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q66-20020a634345000000b00513955cc174sm75774pga.47.2023.04.05.19.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:56:26 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:56:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/16] zram: directly call zram_read_page in
 writeback_store
Message-ID: <20230406025622.GU12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-10-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> writeback_store always reads a full page, so just call zram_read_page
> directly and bypass the boune buffer handling.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

> ---
>  drivers/block/zram/zram_drv.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 6187e41a346fd8..9d2b6ef4638903 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -54,9 +54,8 @@ static size_t huge_class_size;
>  static const struct block_device_operations zram_devops;
>  
>  static void zram_free_page(struct zram *zram, size_t index);
> -static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
> -				u32 index, int offset, struct bio *bio);
> -
> +static int zram_read_page(struct zram *zram, struct page *page, u32 index,
> +			  struct bio *bio, bool partial_io);
>  
>  static int zram_slot_trylock(struct zram *zram, u32 index)
>  {
> @@ -671,10 +670,6 @@ static ssize_t writeback_store(struct device *dev,
>  	}
>  
>  	for (; nr_pages != 0; index++, nr_pages--) {
> -		struct bio_vec bvec;
> -
> -		bvec_set_page(&bvec, page, PAGE_SIZE, 0);
> -
>  		spin_lock(&zram->wb_limit_lock);
>  		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
>  			spin_unlock(&zram->wb_limit_lock);
> @@ -718,7 +713,7 @@ static ssize_t writeback_store(struct device *dev,
>  		/* Need for hugepage writeback racing */
>  		zram_set_flag(zram, index, ZRAM_IDLE);
>  		zram_slot_unlock(zram, index);
> -		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
> +		if (zram_read_page(zram, page, index, NULL, false)) {

In theory we can call zram_read_from_zspool() here, but zram_read_page()
is fine with me.

>  			zram_slot_lock(zram, index);
>  			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
>  			zram_clear_flag(zram, index, ZRAM_IDLE);
> @@ -729,9 +724,8 @@ static ssize_t writeback_store(struct device *dev,
>  		bio_init(&bio, zram->bdev, &bio_vec, 1,
>  			 REQ_OP_WRITE | REQ_SYNC);
>  		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
> -
> -		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
> -				bvec.bv_offset);
> +		bio_add_page(&bio, page, PAGE_SIZE, 0);
> +	
>  		/*
>  		 * XXX: A single page IO would be inefficient for write
>  		 * but it would be not bad as starter.
> -- 
> 2.39.2
> 
