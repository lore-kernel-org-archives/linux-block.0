Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36827 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbcINCP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2016 22:15:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so322008wma.3
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2016 19:15:28 -0700 (PDT)
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH 1/3] block: remove bio_destructor_t
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com
References: <1473602584-11744-1-git-send-email-hch@lst.de>
 <1473602584-11744-2-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Message-ID: <2b3670e0-9394-8681-8ac5-5967f11fd9ae@acm.org>
Date: Wed, 14 Sep 2016 04:15:25 +0200
MIME-Version: 1.0
In-Reply-To: <1473602584-11744-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/11/2016 04:03 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blk_types.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 436f43f..a2f4add 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -16,7 +16,6 @@ struct block_device;
>  struct io_context;
>  struct cgroup_subsys_state;
>  typedef void (bio_end_io_t) (struct bio *);
> -typedef void (bio_destructor_t) (struct bio *);
>
>  #ifdef CONFIG_BLOCK
>  /*

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
