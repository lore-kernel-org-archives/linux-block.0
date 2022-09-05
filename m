Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990E0ECAAD5
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiIERuZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiIERuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 13:50:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93C5F122
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 10:50:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so12744032pja.4
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PNaCX0S9iGhKAlyPWJAoKRpsa01FH9FlALaZF1PJLS0=;
        b=lMnZ13siCUzc0zOynH5OarlVG770rcTKcozKwKhb4GoNXLZfY5qo+9mE7Rm0XEkk4a
         7+b9inDvYw4dIC8yt82RCx0511+bCZvHLylAQVe083yQrOokin8d4Bu3HfKuV8CbVJRA
         EhJOGja7bkAuGXfJEMJrqCAC+0bBEoAJ8NzdfFy3Ye4uHrtYsANZomFnRc7ReT3dtOxA
         Tny4ZaZ8Z7mRAtzJcKiOSUfRnpFgEMc+IAx5tVYfGT+f3C2vL9f9efDWiKMUbsqQhCUS
         /7uLU76kveNyfhJz3meNYUioN4Kodaak/BlvSmO+zX+o1pSAJQ+cXnLiZyy8e4MSnhwd
         5kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PNaCX0S9iGhKAlyPWJAoKRpsa01FH9FlALaZF1PJLS0=;
        b=7rRQJwdmcQbUrt9HdiCExWEAbNCKjK3jmSJaXxa/5bhRPQKK2GkV+xc3t24OqjcXZv
         kwnQcSSO7JlckJc+04EZW+byPnCfW0wm78ngxr7j1Jwu08/Uh2vzkzI9UDMtBdh2X7t5
         dFXE0qAksl1OSd0IwTlG9sCI9vetTQ0BHV2NkkChqeaDpTT9Nk40mhuYn29toTH0rLm3
         Z7oSf+n3NnSx4qDAA8+uecRqNy8ly3tHj+sz7AKQhx5terIJaM06gO2hpIgtq7Bqbv8q
         WEI35CBIK4px3Hi4hK8N4BU5ReoclmIL9eESIRKba9XjrKg9SJcK14p8oNtwda/UT1kt
         uzug==
X-Gm-Message-State: ACgBeo3QC1rrUJwUQvUzuk2zf2/GVN9b9XGdJZDRnrBu8X0PgTZhYjbp
        HyDiAO/c3oJekwt9tAAoBtc/CpoytCiCLw==
X-Google-Smtp-Source: AA6agR5R9puDZtsQGlvBHmoPXUZgxeA3Szf5wt3UY93HyWP9kB/FpM7r9D8ZOEgLdp4cZ5V/aaVWYw==
X-Received: by 2002:a17:90b:4b81:b0:1fd:d736:9d04 with SMTP id lr1-20020a17090b4b8100b001fdd7369d04mr20794110pjb.121.1662400222422;
        Mon, 05 Sep 2022 10:50:22 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0017543086eb3sm7914486plg.274.2022.09.05.10.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 10:50:21 -0700 (PDT)
Message-ID: <8a6f1186-e202-7d0c-6e4a-6a456cf7f4f7@kernel.dk>
Date:   Mon, 5 Sep 2022 11:50:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b@epcas5p4.samsung.com>
 <20220905134833.6387-2-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220905134833.6387-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/22 7:48 AM, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> This is a new helper that callers can use to obtain a bvec iterator for
> the previously mapped buffer. This is preparatory work to enable
> fixed-buffer support for io_uring_cmd.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  include/linux/io_uring.h |  8 ++++++++
>  io_uring/uring_cmd.c     | 11 +++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> index 58676c0a398f..dba6fb47aa6c 100644
> --- a/include/linux/io_uring.h
> +++ b/include/linux/io_uring.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/xarray.h>
> +#include <uapi/linux/io_uring.h>
>  
>  enum io_uring_cmd_flags {
>  	IO_URING_F_COMPLETE_DEFER	= 1,
> @@ -32,6 +33,8 @@ struct io_uring_cmd {
>  };
>  
>  #if defined(CONFIG_IO_URING)
> +int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> +		struct iov_iter *iter, void *ioucmd);
>  void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
>  void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>  			void (*task_work_cb)(struct io_uring_cmd *));
> @@ -59,6 +62,11 @@ static inline void io_uring_free(struct task_struct *tsk)
>  		__io_uring_free(tsk);
>  }
>  #else
> +int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> +		struct iov_iter *iter, void *ioucmd)
> +{
> +	return -1;
> +}

Is this right? Shouldn't it return -EOPNOTSUPP or another suitable actual
error value?

Apart from that, I think the patchset looks fine now.

-- 
Jens Axboe


