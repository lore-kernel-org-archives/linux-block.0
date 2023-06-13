Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B22EB64D0
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjFMQMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbjFMQMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 12:12:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADAB1996
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tRe+ry/d1S1cbQUoIT9zhWL3/1FXEnUE3z0GlFWsg+M=; b=k0AFCTQ4ypdDp4VvsXrWZr30QF
        IUSBbaOJSMLrkOiILvZirS7X5eRQg+AAMCmBHFdAT/eN/vc6pNE7KdLsVyoXl0yrdOhQuZ2SwYZ01
        hdMDN19xI8xLMZneHRr/rciMAecVk5KqdQtajhv9Js7d5W8RGyyydXcOyMY2xpa0AFWvuZLicMyHV
        5RleL2U4Z9LR/3MqJeVFgN3SKV7e29DNEU72hBedoXHpx52Fkv4pUWZm9+gAQtHM6YrUdgO9qvhgg
        XpvCU2aWodlDCikn+oY3hlK78JwmGp1xGLfZ6+AOwk8NUwcM72Sq/IWTCfi9IroSv3AAsO7gcvEYr
        iXhLyqrw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q96d0-008YWv-30;
        Tue, 13 Jun 2023 16:12:18 +0000
Message-ID: <07e68b2b-3179-015c-1105-c76bdb11d35d@infradead.org>
Date:   Tue, 13 Jun 2023 09:12:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] swim3: fix the floppy_locked_ioctl prototype
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230613154309.327557-1-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230613154309.327557-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/13/23 08:43, Christoph Hellwig wrote:
> Add back the accidentally dropped mode parameter.
> 
> Fixes: b60f7635788a ("swim3: fix the floppy_locked_ioctl prototype")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/block/swim3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
> index 945a0315425070..dc43a63b346946 100644
> --- a/drivers/block/swim3.c
> +++ b/drivers/block/swim3.c
> @@ -882,7 +882,7 @@ static int fd_eject(struct floppy_state *fs)
>  static struct floppy_struct floppy_type =
>  	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,NULL };	/*  7 1.44MB 3.5"   */
>  
> -static int floppy_locked_ioctl(struct block_device *bdev,
> +static int floppy_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  			unsigned int cmd, unsigned long param)
>  {
>  	struct floppy_state *fs = bdev->bd_disk->private_data;

-- 
~Randy
