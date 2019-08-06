Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69FC31E40
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 13:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6620C01
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 13:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1QxTZ9Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfHFNmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:42:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33764 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFNmC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 09:42:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so41543153pfq.0
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gnwBRlo+7+zmEYS9bsZqThdkMyiCfikjENhYQMGNLQI=;
        b=1QxTZ9CnKOnOO/O9IxMsHmtTeb/SWWyDflw7MkizbSC3kemLg9vOFbBt4HpgfyEZ8W
         qs19BSiSS0x9qsUtA42c+1n8fng4cXX5eukW2yWEKtst0Ak9nw/weJljRMdifyWcvyPU
         qtvO4ifI4oFHjTLg09zeCXJrhfPmMWoYKd6PxiVZbCjX3+t08a6oieJ/BnIzd5SAKfSp
         Lg2flLusFrGVs8udLdudLFSywu+fnwS0+GH1g6Cc87CMQNj5PwOX7DfM/NRmWEO+fba9
         DkXsHcFhgwlt0UDFYf+cpPtEu1nkSW6yNyThI5aB2O3tpQIOQFX2bIQA1tvxlMlAOJit
         8T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gnwBRlo+7+zmEYS9bsZqThdkMyiCfikjENhYQMGNLQI=;
        b=NOdav6CiEmMHSv4hSXnq1Uq00B/BM55d14Tvyqbs0iMsJQexxQAJ2buBnKxQAPgVmF
         nNicUqOQ7UdLtB9zq8MAEEaIKZFrtFfSPL+phdkMu+J/SxEqDVUCRGc0+iu1BZ6xYWmy
         0d3TSL9DhvA8Joha3tIs59GxLNeII7v317ZNfuv+Rwzp2FddCgM9kGIQGvDeMSAezA3N
         7sCKBRw8F+Kq+LIeS9tK+61bKDltC0J1Xk+yAPnIeHeoEMmtBNgxZAHClMlE6rBl6jeq
         dLZxM/Q/Hncj6DlKUctjVAGsI2xG+kLvXr3bupC2AgfDXWSXLvVuM+j0Ng/Bp9u1H+Bz
         GeTQ==
X-Gm-Message-State: APjAAAWFYQUxyA4VZJpRw6zettEfLQoQBkAhQZbATA7z1gNeH1TZFILI
        1bCz24DnHTU7Byj/NThDnN6z/wbXMkrBCQ==
X-Google-Smtp-Source: APXvYqyAJV8qw1ylUJmsGy44X0HqqvaQ738dA3zkZ8nhsODjP9so+qu9v1bJ4+cpS+NCd+EL1WQN6A==
X-Received: by 2002:a63:7709:: with SMTP id s9mr3032820pgc.296.1565098921726;
        Tue, 06 Aug 2019 06:42:01 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:5cfb:b4eb:1062:5bea? ([2605:e000:100e:83a1:5cfb:b4eb:1062:5bea])
        by smtp.gmail.com with ESMTPSA id t8sm18329062pji.24.2019.08.06.06.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:42:00 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove duplicate judgments when put_user_pages
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1565062652-12596-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55c67427-f9b8-9d0c-2cfb-6a4ff28c6ec9@kernel.dk>
Date:   Tue, 6 Aug 2019 06:41:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565062652-12596-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/19 8:37 PM, Jackie Liu wrote:
> When pret is less than or equal to 0, put_user_pages can be
> processed correctly.
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   fs/io_uring.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 8a1de5a..be1e010 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2959,8 +2959,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
>   			 * if we did partial map, or found file backed vmas,
>   			 * release any pages we did get
>   			 */
> -			if (pret > 0)
> -				put_user_pages(pages, pret);
> +			put_user_pages(pages, pret);

Let's not do this, it's confusing and someone reviewing this code would
have to look it up every time. It's not in a hot path either.

-- 
Jens Axboe

