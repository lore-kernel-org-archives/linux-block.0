Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC71AC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 23:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjEPXai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 19:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEPXaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 19:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD122D5E
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 16:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C60E63F26
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C46C433EF;
        Tue, 16 May 2023 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684279833;
        bh=w0TYyIqHxsEPo8Oz6+I0KakehkiqW+xwmPKu0wIOwRI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cETxzogdg2nzlP2OCJ95GwdzQrixSyXhxNw8mta44pplzL6LZBP8FRgOorrPfR5OA
         y0K9TRsF6S4qj8twRMjUMbhzCs2o/qP//+pBN4DIcZKPbktLg8Frn6hDo7RnR9+C5T
         CaYqKUD7nbrlgbJjv6tb2lSMILUSXTStq44PHcaCYGc9GeKQrIwFDYuXmJU8io1kFQ
         Sk+ZP/WJp7MZMmQ2QdtWHoN4tz/zhxByhBJtJSDDm5N+yYEqNSuquzhPnoli0OiXFj
         W/gur0Wqlk3omsdtLEio6Kpv7lxl9rNbqCIvQ3HR0SKiOZvOINxxgoO82Hw4FaECMb
         67OqM9PpXIf1w==
Message-ID: <84348f20-6849-549c-5113-2faf1a6b40ad@kernel.org>
Date:   Wed, 17 May 2023 08:30:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 03/11] block: Introduce op_is_zoned_write()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-4-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Introduce a helper function for checking whether write serialization is
> required if the operation will be sent to a zoned device. A second caller
> for op_is_zoned_write() will be introduced in the next patch in this
> series.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index db24cf98ccfb..a4f85781060c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1281,13 +1281,16 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
>  	return disk_zone_no(bdev->bd_disk, sec);
>  }
>  
> +/* Whether write serialization is required for @op on zoned devices. */
> +static inline bool op_is_zoned_write(enum req_op op)

I do not like the name of this function as it has nothing to do with zoned
devices. What about something like op_is_data_write() to clarify what is being
tested ?

> +{
> +	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
> +}
> +
>  static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
>  					  enum req_op op)
>  {
> -	if (!bdev_is_zoned(bdev))
> -		return false;
> -
> -	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
> +	return bdev_is_zoned(bdev) && op_is_zoned_write(op);
>  }

Or if you really want to rewrite this, may be something like:

static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
  					  enum req_op op)
{
	return bdev_is_zoned(bdev) &&
	       (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES);
}

which is very easy to understand.


-- 
Damien Le Moal
Western Digital Research

