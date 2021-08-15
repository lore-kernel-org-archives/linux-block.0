Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E9C4338F
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 07:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9112260462
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 07:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhHOHHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 03:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236043AbhHOHHh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 03:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B3660F46;
        Sun, 15 Aug 2021 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629011222;
        bh=MGpxdFg0FEpxaQvnYjKQqOYJDHxqKeogQ+801DJZ65g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdYrxOSlWb11vRj/7e8IwUXbkxL+nrQQCFNd2+T6UjCkcWQKPl/EIVE+TYYuArdKl
         WM2vVuWGGf+3R5P4webgHePS5OMP3g0wSa7bD1BbaPcsdEg/ERm7tcBRuwDIaxS0A+
         qIH83UoXy+0xmaFUPZW0SvwtXe7hKDsCZ2UN2lkA=
Date:   Sun, 15 Aug 2021 09:06:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YRi9EQJqfK6ldrZG@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 15, 2021 at 03:52:45PM +0900, Tetsuo Handa wrote:
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -303,9 +303,9 @@ struct gendisk *__blk_alloc_disk(int node);
>  void blk_cleanup_disk(struct gendisk *disk);
>  
>  int __register_blkdev(unsigned int major, const char *name,
> -		void (*probe)(dev_t devt));
> +		      void (*probe)(dev_t devt), struct module *owner);
>  #define register_blkdev(major, name) \
> -	__register_blkdev(major, name, NULL)
> +	__register_blkdev(major, name, NULL, NULL)
>  void unregister_blkdev(unsigned int major, const char *name);

Do not force modules to put their own THIS_MODULE macro as a parameter,
put it in the .h file so that it happens automagically, much like the
usb_register() define in include/linux/usb.h is created.

If you do that, you can probably get rid of the __register_blkdev()
direct calls as well...

thanks,

greg k-h
