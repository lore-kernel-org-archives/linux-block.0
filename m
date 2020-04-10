Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C37C2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 08:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD262051A
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 08:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJIf4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:35:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43994 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJIfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 04:35:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id k28so833678lfe.10;
        Fri, 10 Apr 2020 01:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DcH37kFw3pA3TszaAlB4FxdsO6scQAKynKBKosGJvw8=;
        b=NNfvw6+PavF+mc8vRL6F585DhlDMhbFQul6ultsRxTpdBQh0Q5icTrp6cGPm0iRAj0
         6I9xcKKta4iK2ZNdBXaI3FLcGplWpfhFsmYAAKFu/8v1CW//xWxIEnxXQEUZxkmQycsS
         CBddePTUiwTD1Naw7h3lWAhoWTLMWy9xaWAgYVSfnMKv01UMEq4hWXcsLeNIKGVTtqjP
         qd+xL47UEwbo5gf0kQb4GCVNRNtdtVppSruWM0D20tRMSWmzUYWO52iwf0JMAK3R5MyZ
         4kzlfwXGXHAYMqcuuXdGJBq2+F1M2zolsqXP4OYY6Ea9P2M9XUcdJkGAf9t1PQzAb8Rg
         EAwA==
X-Gm-Message-State: AGi0PuY2Hm3q0DzBzWY1NCiIkna7SpF1pZ2A0ysJfOjeR/1HpOPPdYrs
        bu5OaUUi+sadIV7NbxLX+dBr0/KnNZ4=
X-Google-Smtp-Source: APiQypJCdNAwb1kOP3vYH3Df/92yjIoG2YCAIQhGV7XlAyX7GLcVkjbB1jVG0LvJh2DJL9zCr0i1Qw==
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr2050367lfb.115.1586507753158;
        Fri, 10 Apr 2020 01:35:53 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-231-41.ip.moscow.rt.ru. [188.32.231.41])
        by smtp.gmail.com with ESMTPSA id i20sm895855lfe.15.2020.04.10.01.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 01:35:52 -0700 (PDT)
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200331094054.24441-1-w@1wt.eu>
 <20200331094054.24441-23-w@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH 22/23] floppy: cleanup: do not iterate on current_fdc in
 DMA grab/release functions
Message-ID: <f5fb363f-8c2c-3aca-6b71-4a45544d067a@linux.com>
Date:   Fri, 10 Apr 2020 11:35:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331094054.24441-23-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I see a couple of similar cycles in do_floppy_init:

for (i = 0; i < N_FDC; i++) {
        current_fdc = i;
        memset(&fdc_state[current_fdc], 0, sizeof(*fdc_state));
        fdc_state[current_fdc].dtr = -1;
        fdc_state[current_fdc].dor = 0x4;
...
}

for (i = 0; i < N_FDC; i++) {
        current_fdc = i;
        fdc_state[current_fdc].driver_version = FD_DRIVER_VERSION;
...
}

On 3/31/20 12:40 PM, Willy Tarreau wrote:
> Both floppy_grab_irq_and_dma() and floppy_release_irq_and_dma() used to
> iterate on the global variable while setting up or freeing resources.
> Now that they exclusively rely on functions which take the fdc as an
> argument, so let's not touch the global one anymore.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/block/floppy.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 8850baa3372a..77bb9a5fcd33 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4854,6 +4854,8 @@ static void floppy_release_regions(int fdc)
>  
>  static int floppy_grab_irq_and_dma(void)
>  {
> +	int fdc;
> +
>  	if (atomic_inc_return(&usage_count) > 1)
>  		return 0;
>  
> @@ -4881,24 +4883,24 @@ static int floppy_grab_irq_and_dma(void)
>  		}
>  	}
>  
> -	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
> -		if (fdc_state[current_fdc].address != -1) {
> -			if (floppy_request_regions(current_fdc))
> +	for (fdc = 0; fdc < N_FDC; fdc++) {
> +		if (fdc_state[fdc].address != -1) {
> +			if (floppy_request_regions(fdc))
>  				goto cleanup;
>  		}
>  	}
> -	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
> -		if (fdc_state[current_fdc].address != -1) {
> -			reset_fdc_info(current_fdc, 1);
> -			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
> +	for (fdc = 0; fdc < N_FDC; fdc++) {
> +		if (fdc_state[fdc].address != -1) {
> +			reset_fdc_info(fdc, 1);
> +			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
>  		}
>  	}
> -	current_fdc = 0;
> +
>  	set_dor(0, ~0, 8);	/* avoid immediate interrupt */
>  
> -	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++)
> -		if (fdc_state[current_fdc].address != -1)
> -			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
> +	for (fdc = 0; fdc < N_FDC; fdc++)
> +		if (fdc_state[fdc].address != -1)
> +			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
>  	/*
>  	 * The driver will try and free resources and relies on us
>  	 * to know if they were allocated or not.
> @@ -4909,15 +4911,16 @@ static int floppy_grab_irq_and_dma(void)
>  cleanup:
>  	fd_free_irq();
>  	fd_free_dma();
> -	while (--current_fdc >= 0)
> -		floppy_release_regions(current_fdc);
> +	while (--fdc >= 0)
> +		floppy_release_regions(fdc);
> +	current_fdc = 0;
>  	atomic_dec(&usage_count);
>  	return -1;
>  }
>  
>  static void floppy_release_irq_and_dma(void)
>  {
> -	int old_fdc;
> +	int fdc;
>  #ifndef __sparc__
>  	int drive;
>  #endif
> @@ -4958,11 +4961,9 @@ static void floppy_release_irq_and_dma(void)
>  		pr_info("auxiliary floppy timer still active\n");
>  	if (work_pending(&floppy_work))
>  		pr_info("work still pending\n");
> -	old_fdc = current_fdc;
> -	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++)
> -		if (fdc_state[current_fdc].address != -1)
> -			floppy_release_regions(current_fdc);
> -	current_fdc = old_fdc;
> +	for (fdc = 0; fdc < N_FDC; fdc++)
> +		if (fdc_state[fdc].address != -1)
> +			floppy_release_regions(fdc);
>  }
>  
>  #ifdef MODULE
> 
