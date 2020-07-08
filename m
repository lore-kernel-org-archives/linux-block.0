Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED9C433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E400720708
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rg0dcHkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGHWjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHWix (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:38:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B71C08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 15:38:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so99199pfq.11
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0IDR+Jdn/swMjriOk89kNCPU0czu+vBFpA+hJGhx0VU=;
        b=rg0dcHkxPIVVrYjkS34uSdILXxUhoqLXohzmIYDsJMLstyvORLpsfkj2HW06TsOpdW
         pPK8pUxjKa133FVWqYPrJMvTtY5DsTH5iPcIj71bWRo4I0a6/WuNJInZLBm/wqCEgPt4
         LPm71+MdEKvcACPKGkaUGxAxihomelQNS+TAgD4lm+TVlYRbuWIk81nhoomGM2yeUfIY
         He94kpz/oOD+0IPxf6i+5pN5dSJO1Ukp78RjPCkhgDWj++70sccbt+L+6OIYCRBcpQ03
         +rChcmq4N1f1Xz//Qv+2Pqxqe8deIcaVz7YkMSSX2ZdAU2flEY4HByWb0S4YkwVJp1Ey
         dj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0IDR+Jdn/swMjriOk89kNCPU0czu+vBFpA+hJGhx0VU=;
        b=k37/y/goeBPuKBu2M73Kjma0ovMiWYEnVTIAE4XwMIpXF8MewU7qBYtAvyLn0TEXEe
         0nNx14OL3q+7t3wqKrN7vy8eusviYnJUECmYnmbe0LB0O9OGyzJMl1AHX4D18I9fZNhB
         2zWNKnqFtbJAULTDlcBjjVRhnTj53X7i96LwFWNIQPZ+ijwyKQU9RK+QmKHU/yeX6dVC
         77Ngyep6RW+MRc8pZuCjF28TUQgKnFXmG3jfjYLpVhukMJH978D+pXk99PkrPlYkDeQr
         2KkvnErA4NKn3iQoisGibQLRxWej6mp1Xk8NYiMUy7dPVI9wgykOfAwgFeuyJr/z3k0O
         VqPg==
X-Gm-Message-State: AOAM531EbNkYK9gtXOpaFFdf8U5EjBv1UGOPQURqIm7dUVHAU4h/EqT8
        t1Y9tsknnoP10MPcQ/7aWJKMOA==
X-Google-Smtp-Source: ABdhPJzU0QCgwB29x3U5ahxJfjqWMwTCjZWeHX8Ch1hjXQRSaxDVY/HeShauYg4FvnhP1AF82X9d2w==
X-Received: by 2002:a65:5682:: with SMTP id v2mr51087824pgs.231.1594247933001;
        Wed, 08 Jul 2020 15:38:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e5sm480906pjv.18.2020.07.08.15.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:38:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] fs: Remove kiocb->ki_complete
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200708222637.23046-3-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33e0220c-242d-1856-9d4e-31528011a06e@kernel.dk>
Date:   Wed, 8 Jul 2020 16:38:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> @@ -341,12 +343,25 @@ struct kiocb {
>  	randomized_struct_fields_end
>  };
>  
> +static inline int kiocb_completion_id(struct kiocb *kiocb)
> +{
> +	return kiocb->ki_flags >> _IOCB_COMPLETION_SHIFT;
> +}
> +
> +static inline void kiocb_set_completion(struct kiocb *kiocb, int id)
> +{
> +	kiocb->ki_flags = (kiocb->ki_flags & (~IOCB_COMPLETION_FNS)) |
> +				(id << _IOCB_COMPLETION_SHIFT);
> +}
> +
>  static inline bool is_sync_kiocb(struct kiocb *kiocb)
>  {
> -	return kiocb->ki_complete == NULL;
> +	return kiocb_completion_id(kiocb) == 0;
>  }
>  
>  void complete_kiocb(struct kiocb *kiocb, long ret, long ret2);
> +int register_kiocb_completion(void (*)(struct kiocb *, long, long));
> +void unregister_kiocb_completion(int id);

Same here, you seem to mix and match whether you prefix with kiocb or
not. Why not make them all kiocb_*?

kiocb_register_completion() and so forth.

-- 
Jens Axboe

