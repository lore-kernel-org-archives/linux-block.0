Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34751 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbcINCQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2016 22:16:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id g141so331155wmd.1
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2016 19:16:47 -0700 (PDT)
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH 3/3] block: remove IOPRIO_BITS
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com
References: <1473602584-11744-1-git-send-email-hch@lst.de>
 <1473602584-11744-4-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Message-ID: <e5cf1164-ed47-67a8-2aca-5e0329cf1b41@acm.org>
Date: Wed, 14 Sep 2016 04:16:45 +0200
MIME-Version: 1.0
In-Reply-To: <1473602584-11744-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/11/2016 04:03 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/ioprio.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index beb9ce1..8c12390 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -7,7 +7,6 @@
>  /*
>   * Gives us 8 prio classes with 13-bits of data for each class
>   */
> -#define IOPRIO_BITS		(16)
>  #define IOPRIO_CLASS_SHIFT	(13)
>  #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
