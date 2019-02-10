Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93507C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78021934
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfBJJhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:37:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:37932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfBJJhC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 04:37:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A1DAAC6F;
        Sun, 10 Feb 2019 09:37:01 +0000 (UTC)
Subject: Re: [PATCH 19/19] io_uring: add io_uring_event cache hit information
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190209211346.26060-1-axboe@kernel.dk>
 <20190209211346.26060-20-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ca60183a-bb43-930c-8bf1-026c2528723d@suse.de>
Date:   Sun, 10 Feb 2019 10:36:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190209211346.26060-20-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/19 10:13 PM, Jens Axboe wrote:
> Add hint on whether a read was served out of the page cache, or if it
> hit media. This is useful for buffered async IO, O_DIRECT reads would
> never have this set (for obvious reasons).
> 
> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
> set.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/io_uring.c                 | 7 ++++++-
>   include/uapi/linux/io_uring.h | 5 +++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 11a549b5dcbf..d7a10484d748 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -587,11 +587,16 @@ static void io_fput(struct io_kiocb *req)
>   static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>   {
>   	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
> +	unsigned ev_flags = 0;
>   
>   	kiocb_end_write(kiocb);
>   
>   	io_fput(req);
> -	io_cqring_add_event(req->ctx, req->user_data, res, 0);
> +
> +	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
> +		ev_flags = IOCQE_FLAG_CACHEHIT;
> +
> +	io_cqring_add_event(req->ctx, req->user_data, res, ev_flags);
>   	io_free_req(req);
>   }
>   
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index e23408692118..24906e99fdc7 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -69,6 +69,11 @@ struct io_uring_cqe {
>   	__u32	flags;
>   };
> 
> +/*
> + * io_uring_event->flags
> + */
> +#define IOCQE_FLAG_CACHEHIT	(1U << 0)	/* IO did not hit media */
> +
>   /*
>    * Magic offsets for the application to mmap the data it needs
>    */
> 

Hmm. The point of this patch being ... what?
Just setting a newly introduced flag seems to be a bit pointless.
Unless it has some magic interaction with io_cqring_add_event().
But then that function would have had to have knowledge of that flag 
already, which would be ... odd.

Please clarify.

Cheers,

Hannes
