Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A3C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C094821872
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CQLh3yWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfCOQ1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:27:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36957 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfCOQ1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:27:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so6818895pgq.4
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q/h5sW4zwC66hsK7pFD8JpPIy1ccmGT3reT7z0shy08=;
        b=CQLh3yWz5+1Cm7tv/z4fbUInFOeN2ilmA+pBwCJ9NNCWMtKAa46pDTByI4iHmOluqZ
         XvSw+Gzc3JWB1rr+z5GDex0lsk+gqP9+W9L0g3btI0/kZb6RYgDlVSMUiakJBKI+7vnu
         41phUGgykIYoym56S1gXAEj4O5744VnmY55EmeME/JXqawYAuiDz4FvuG/pUsBl9I9/z
         TxblLgeHXrew7PYKd5VbRu+/kmLOe1FXKQYwFHhINtlS0a86udCuDL+WVaie/iQJbA6F
         Hmmrq1qhAAy+/UEMZ3alZSNZ6EaXu1quVgkCNQbT0VCMvantCXX7mOPZzJtXzBr5cQ6y
         rPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/h5sW4zwC66hsK7pFD8JpPIy1ccmGT3reT7z0shy08=;
        b=Xyt5pstKIWjKZvyWtJNAp7JsjdA5Pmnqic+eMXsfX6ZY02HfdjmYAHDYRNvcOBH/T5
         QI+43J+rDNcezs5TuhG3U9WjlZ9QfKbEUnqopAyY18xduiB9nZtCVf96/lPmLkjeQUbx
         k9xwlmmMQG4RDOm/nmKuzP+jPYnKy4/LSdY/CgXVwNbOiIfY3zYmmZjazvuYR9Yt4e6c
         oDTRKlSyrqeQJoIyfpdb6i8ef9+l6efK5IrtG1nepAEZXJ1aOl9Ok+f8szW7XUJN8TUy
         QXQHuwjPrQ9Ar5i3XZir0gn5PQTzLqNMwahM6tDwvycNmiBLcDjj6+Ums9Gz3c/uiDAr
         ByLQ==
X-Gm-Message-State: APjAAAXTKhJFza+BpW/UmJiCW84FBYGA8aMdwqAor7avd9eqhEJhTjGe
        fZIVpfpX+Ltf4gBxiBskkuSBYg==
X-Google-Smtp-Source: APXvYqwvshMnrbAP0FTbFAki6xlVgP5w1jOJhDpUxP/9U4HHmJZ5EWGghsmnhklrK5iSzdfK7oJAnQ==
X-Received: by 2002:a63:fd10:: with SMTP id d16mr4230201pgh.306.1552667251721;
        Fri, 15 Mar 2019 09:27:31 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 71sm3617301pgc.23.2019.03.15.09.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:27:30 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: add io_uring_event cache hit information
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190315145938.21516-1-axboe@kernel.dk>
 <20190315145938.21516-4-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa0e7a3a-d7dc-2b6e-5a2c-adf99aab27a6@kernel.dk>
Date:   Fri, 15 Mar 2019 10:27:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315145938.21516-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/19 8:59 AM, Jens Axboe wrote:
> Add hint on whether a read was served out of the page cache, or if it
> hit media. This is useful for buffered async IO, O_DIRECT reads would
> never have this set (for obvious reasons).
> 
> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
> set.

Linus, curious on your opinion on this one. I had this as part of the
original series, but removed it from the pull request due to the
mincore etc discussions.

Leaving the patch intact for you. This is part of a small series of
improvements, which sit on top of a series of fixes for this release.

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f66a4a5daf35..513df722702e 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -635,10 +635,14 @@ static void kiocb_end_write(struct kiocb *kiocb)
>  static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>  {
>  	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
> +	unsigned ev_flags = 0;
>  
>  	kiocb_end_write(kiocb);
>  
> -	io_cqring_add_event(req->ctx, req->user_data, res, 0);
> +	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
> +		ev_flags = IOCQE_FLAG_CACHEHIT;
> +
> +	io_cqring_add_event(req->ctx, req->user_data, res, ev_flags);
>  	io_put_req(req);
>  }
>  
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index e23408692118..24906e99fdc7 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -69,6 +69,11 @@ struct io_uring_cqe {
>  	__u32	flags;
>  };
>  
> +/*
> + * io_uring_event->flags
> + */
> +#define IOCQE_FLAG_CACHEHIT	(1U << 0)	/* IO did not hit media */
> +
>  /*
>   * Magic offsets for the application to mmap the data it needs
>   */
> 


-- 
Jens Axboe

