Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9DEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CC56135E
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTMhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:37:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F6C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:35:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t16so25700467eds.9
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AIUG2DKiJ/k1TWYi303BcsgiSoqcxCxnxsS6TCkUmag=;
        b=UYIKOAxRQMa+DSED1U6SEBdoLK880pc2/c+wn1hx5cuoZvanYaJgy/CZtDSRxxXXtM
         PLVA46nymMR+eEFT/VlXJ6LiryGJ0vI8YbmPoho/lf8CUu2nPjFKNhKI3Haz4vCSIDfi
         ux/LbF95a/oxOivzUtUX41MICXl3ihcqZGnjbmphUHA0ZDSlPFIA5XsmkztmnLoWPdQ7
         mMk8/b87pTNHCe4U1p9Wym9FRUFKpxvwuupdHQ1SVkgKqSh8sl3ZByvvS8EelzA09HjI
         4axk9XOXkIbdmVyJSCqJBjVgNwLf1e/twOoHvtBw7MS9UM38wjbQu2ExZ8ibTO0m91Xu
         qwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AIUG2DKiJ/k1TWYi303BcsgiSoqcxCxnxsS6TCkUmag=;
        b=G+qxNMB6TZHmiKJqUlVU3RDYN/uU1kLGVLnfATzcnLEg1ZJsE/K5e/K3wI5j1grfxc
         AHhmAwkdxcy7GA2KDvJIVG1W8sf6BqzPLng3tCE3mFetc6UAi4cgVfz3uLWzUKTw6+ae
         aGBCU4M49/CJ0WJK2K5UtqiEWnSLyaPNgj51E1phjFYBjgUh/JcfsK3VEkEa0yJbICW6
         SKb19GGBfID8XP/fGPOtxRitScyQrTkElIvYFAub8mSL9hsq+PTzHJuKmlJOmyAmH+n6
         L0M7KtEZga4MjwBRNtTZQ1dB7GFFVI6pV6IEV61zMybSKSWb9RX3cscloUxglwDw81FE
         7G6g==
X-Gm-Message-State: AOAM532RD9gRWFmLzT4TY9FfUESgHe+EVR1qBwgsjrJEqLWGzeVcwXjV
        mAVJzhFE63NVGyV5TiWWekE=
X-Google-Smtp-Source: ABdhPJxdYY1mCCTMGtvaxSv+Mb/6Q15yP60Q7I6ScQGeuK4Mv1yC2pBckGQo7LPqbHG4kcWi1Nqa9Q==
X-Received: by 2002:a17:906:3913:: with SMTP id f19mr43935336eje.357.1634733302832;
        Wed, 20 Oct 2021 05:35:02 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id e7sm1250741edk.3.2021.10.20.05.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:35:02 -0700 (PDT)
Message-ID: <52ea0e58-011d-4d2c-6f26-39bb68db1d89@gmail.com>
Date:   Wed, 20 Oct 2021 13:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 12/16] block: add single bio async direct IO helper
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c8d2d919894fd0112f21723a9cb50b6c7cbd9613.1634676157.git.asml.silence@gmail.com>
 <YW+48urtsamKhEpz@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+48urtsamKhEpz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:36, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:21PM +0100, Pavel Begunkov wrote:
>> +	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
>> +	dio = container_of(bio, struct blkdev_dio, bio);
>> +	__bio_set_dev(bio, bdev);
>> +	bio->bi_iter.bi_sector = pos >> 9;
> 
> SECTOR_SHIFT.
> 
>> +	bio->bi_write_hint = iocb->ki_hint;
>> +	bio->bi_end_io = blkdev_bio_end_io_async;
>> +	bio->bi_ioprio = iocb->ki_ioprio;
>> +	dio->flags = 0;
>> +	dio->iocb = iocb;
>> +
>> +	ret = bio_iov_iter_get_pages(bio, iter);
>> +	if (unlikely(ret)) {
>> +		bio->bi_status = BLK_STS_IOERR;
>> +		bio_endio(bio);
>> +		return BLK_STS_IOERR;
> 
> This function does not return a blk_status_t, so this is wrong (and
> sparse should have complained).  I also don't think the error path
> here should go hrough the bio for error handling but just do a put and
> return the error.

My bad, following __blkdev_direct_IO() it was intended to be
blk_status_to_errno(BLK_STS_IOERR), but just return is much
better.

> 
>> +	if (iov_iter_rw(iter) == READ) {
>> +		bio->bi_opf = REQ_OP_READ;
>> +		if (iter_is_iovec(iter)) {
>> +			dio->flags |= DIO_SHOULD_DIRTY;
>> +			bio_set_pages_dirty(bio);
>> +		}
>> +	} else {
>> +		bio->bi_opf = dio_bio_write_op(iocb);
>> +		task_io_account_write(bio->bi_iter.bi_size);
>> +	}
>> +
>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>> +		bio->bi_opf |= REQ_NOWAIT;
> 
> This code is entirely duplicated, pleae move it into an (inline) helper.

I'll try it out, thanks

>> +	/*
>> +	 * Don't plug for HIPRI/polled IO, as those should go straight
>> +	 * to issue
>> +	 */
> 
> This comment seems misplaced as the function does not use plugging at
> all.

will kill it


-- 
Pavel Begunkov
