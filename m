Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB00C7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjDFCmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjDFCmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:42:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D64121
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:42:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x15so35987018pjk.2
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680748936; x=1683340936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXN0QRVqdQgUnqslYFfeYyHp0F293/NQ02krkhJWwHE=;
        b=nofj1Dx6oTe67tt5N9hqYvB9z4yzedHdn7WKCvd3fTiMI2ywcnLpin8OdjiWkGTZiW
         S2sehywmVzzuuTuXip5RI1YlrFPRWJtukn8DHZsajma4xuA21nagkYtEETeBqFcDEMW5
         ODcZRcIZnOu7FYpInw40KomI71Nhwgo2piVWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748936; x=1683340936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXN0QRVqdQgUnqslYFfeYyHp0F293/NQ02krkhJWwHE=;
        b=SEvhmedd2oTvhPy1vI8if/onSY55La4K+SumC4r3qLlM69HN7iOTSnn+2wCMJQ8rQ3
         gfasUkcivGfP141KLOkA96cG6vMXEI2f9kP1FR70/R/zMHVXpWnDKYdQvAEjxvLTsUhT
         wOdMYDdQsfUs3eAAF0e5xqXBOhE0TL5OhpZ2K16cTikAAEJLVOSihlSdMZg08QPBcgJk
         zKm9O80ONg/fdJn/Nhj4dhkIJ8yll+n1O9kOriSitEqOpLd8zetXz8fdbuR7TXncpgTY
         Oon4mJWqPJUaEt2cguIFKbKYkP5k8fa6wkCCfrKhgHxcyPb5DzE532B5VfE+L9fxB/pl
         im4g==
X-Gm-Message-State: AAQBX9f/e1z4k7sQIilh6NbBM91b0qIKMb/IGkjG3YSYJ4wR45dVpO3i
        i8AzyyquFSVn2k1YVcuOfIs3GQ==
X-Google-Smtp-Source: AKy350Z9jeB2sku2Y8M8omwwXQD3Lvyn7H3SqUIoTWd8lHPOgMKaJI2h9vTcla2C5blV0WXsOPynIQ==
X-Received: by 2002:a05:6a20:6d09:b0:dc:a14e:d9bf with SMTP id fv9-20020a056a206d0900b000dca14ed9bfmr1188040pzb.43.1680748935982;
        Wed, 05 Apr 2023 19:42:15 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b0062dd6b4ffeesm114001pfn.1.2023.04.05.19.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:42:15 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:42:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/16] zram: refactor highlevel read and write handling
Message-ID: <20230406024212.GR12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> +static void zram_bio_read(struct zram *zram, struct bio *bio)
>  {
> -	int ret;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	unsigned long start_time;
>  
> -	if (!op_is_write(op)) {
> -		ret = zram_bvec_read(zram, bvec, index, offset, bio);
> -		if (unlikely(ret < 0)) {
> +	start_time = bio_start_io_acct(bio);
> +	bio_for_each_segment(bv, bio, iter) {
> +		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
> +		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
> +				SECTOR_SHIFT;
> +
> +		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
>  			atomic64_inc(&zram->stats.failed_writes);

						->failed_reads

> -			return ret;
> -		}
> -		flush_dcache_page(bvec->bv_page);
> -	} else {
> -		ret = zram_bvec_write(zram, bvec, index, offset, bio);
> -		if (unlikely(ret < 0)) {
> -			atomic64_inc(&zram->stats.failed_reads);
> -			return ret;
> +			bio->bi_status = BLK_STS_IOERR;
> +			break;
>  		}
> -	}
> +		flush_dcache_page(bv.bv_page);
>  
> -	zram_slot_lock(zram, index);
> -	zram_accessed(zram, index);
> -	zram_slot_unlock(zram, index);
> -	return 0;
> +		zram_slot_lock(zram, index);
> +		zram_accessed(zram, index);
> +		zram_slot_unlock(zram, index);
> +	}
> +	bio_end_io_acct(bio, start_time);
> +	bio_endio(bio);
>  }
>  
> -static void __zram_make_request(struct zram *zram, struct bio *bio)
> +static void zram_bio_write(struct zram *zram, struct bio *bio)
>  {
>  	struct bvec_iter iter;
>  	struct bio_vec bv;
> @@ -1970,11 +1966,15 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
>  		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
>  				SECTOR_SHIFT;
>  
> -		if (zram_bvec_rw(zram, &bv, index, offset, bio_op(bio),
> -				bio) < 0) {
> +		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
> +			atomic64_inc(&zram->stats.failed_reads);

						->failed_writes

>  			bio->bi_status = BLK_STS_IOERR;
>  			break;
>  		}
> +
> +		zram_slot_lock(zram, index);
> +		zram_accessed(zram, index);
> +		zram_slot_unlock(zram, index);
>  	}
>  	bio_end_io_acct(bio, start_time);
>  	bio_endio(bio);
> @@ -1989,8 +1989,10 @@ static void zram_submit_bio(struct bio *bio)
>  
>  	switch (bio_op(bio)) {
>  	case REQ_OP_READ:
> +		zram_bio_read(zram, bio);
> +		break;
>  	case REQ_OP_WRITE:
> -		__zram_make_request(zram, bio);
> +		zram_bio_write(zram, bio);
>  		break;
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_WRITE_ZEROES:
> -- 
> 2.39.2
> 
