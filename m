Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E45C47404
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE20A222BE
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ODuxhFr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbfJDNFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:05:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40521 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfJDNFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 09:05:24 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so13285077iof.7
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=owB+0qIMoiD4khHlOx6XdkpZsBAmXun1zaiAh9/ru18=;
        b=ODuxhFr4Dd5XuPsWn8IgPf1Swa5PlcyIBmSDPW1rS8uMDmK/6S6dNDgHYKOKImNbFX
         61kuxlnGal/bij6RzNCjSbQFbV7/QKNvSqqeLrElxOT7W+JRcZVBfNiUJhVm4qVX1XQM
         BqU2ZwbWxD49TWAP4j/HpGiH7Ks63Gt+3VhDcv3kvOST28oYKVSHzYy8aYSviabTRuLo
         e7sAG++Cq+6kKv7+yzxac2hrYLZ/Lq2XCtM7rrO0wdZNLHsCD06cguZIijSs3D5OARk8
         7gH0j5AZi+fPyGfNifdjh4jFu9G325QH8+6J7smw/7vblWcTVsAIMTdURw/Ju/wU9pKv
         uy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=owB+0qIMoiD4khHlOx6XdkpZsBAmXun1zaiAh9/ru18=;
        b=bkwAvQnVJEpb1BDibqgEllr70g/kFlw3pPjpdBkFw5b1SnCjyQYvl2E8k2wIdsbNDc
         RY3xLqkQEqkgmgE5zysYddSwC3Om0Ia62m6s7IcXwz/26MysOhkTVHi5f4vPOrU26CD4
         bSFdhh5CGd8OZ0cUwIiLvkq8cvRGp6ugfIl16vN4RrXaRB5tfX1Fw25U8ZejbXi+7Cdd
         3PjQU1sHMt/jv4975ZIm41ifw7UNsLwTIkcW4Nh7BJYFUHUvINHTDoLuiPfvmzyPEBfa
         nY0TojG3nlTZqX6kXcCaJ57QSudR/tqM6fvzXRGLpPVHpkfzqjlA7wvJLMzKfKfHafyc
         Qo2w==
X-Gm-Message-State: APjAAAUJ/uGuX3DP2H1H5Obju5eOAndiXWRyjPNf00QQTA6CSMXhZE67
        Buf56C3NRAEHTphGLsCrRAt3ng==
X-Google-Smtp-Source: APXvYqyKDvzAIIP552KZ9+y07//EEg/8qO3hqsy4XiD/90My4DhgNsPdBABRFOkw9vnr0KbsN/SlDw==
X-Received: by 2002:a6b:7102:: with SMTP id q2mr12090006iog.154.1570194323097;
        Fri, 04 Oct 2019 06:05:23 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w68sm3266361ili.59.2019.10.04.06.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:05:22 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: Fix reversed nonblock flag
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
 <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a18d7d7-323a-5903-2952-814954910ddd@kernel.dk>
Date:   Fri, 4 Oct 2019 07:05:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/19 4:07 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()
> passes something opposite.
> 
> v2: fix build error by test robot: Rebase from custom tree
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>   fs/io_uring.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index c934f91c51e9..c909ea2b84e9 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2703,6 +2703,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>   	struct io_kiocb *shadow_req = NULL;
>   	bool prev_was_link = false;
>   	int i, submit = 0;
> +	bool force_nonblock = true;
>   
>   	if (to_submit > IO_PLUG_THRESHOLD) {
>   		io_submit_state_start(&state, ctx, to_submit);
> @@ -2710,9 +2711,9 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>   	}
>   
>   	for (i = 0; i < to_submit; i++) {
> -		bool force_nonblock = true;
>   		struct sqe_submit s;
>   
> +		force_nonblock = true;
>   		if (!io_get_sqring(ctx, &s))
>   			break;
>   
> @@ -2761,7 +2762,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>   
>   	if (link)
>   		io_queue_link_head(ctx, link, &link->submit, shadow_req,
> -					block_for_last);
> +					force_nonblock);
>   	if (statep)
>   		io_submit_state_end(statep);

Shouldn't this just be:

   		io_queue_link_head(ctx, link, &link->submit, shadow_req,
 					!block_for_last);

We're outside the loop, so by definition at the end of what we need to
do. We don't need to factor in the fiddling of force_nonblock here,
it'll be false at this point anyway. Only exception is error handling,
if the caller asked for more than what was in the ring. Not a big
deal...

-- 
Jens Axboe

