Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C3EC47253
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EEC21835
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgEASWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36575 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgEASWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 14:22:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id u15so3415225ljd.3;
        Fri, 01 May 2020 11:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8+Jd8UCtLAIGXZVwCPsEaZASdfjfz3pNWNDidIes4aw=;
        b=dRRsAnjqiO0Y/IRyiyuai5zwBNd3KeGPMbwXZk3b9EB0W/L1eP3dEqK5WWmQOHE4BH
         abMjQ7vV1U/hv5DCXHE9dggAbPTYHmYW8CqLyeuuaDYeyCoTVmFl/InhR6aCSU80JwCr
         Fjk02IEYIUkbSmNe03Gx1ylnlJCRx/h4TexrfFRpezPtCxNxvZW16RSwBzAxaUCqv/co
         vK1KPnu5zizR5YcdXwRuKU4cZQdZ6tkerJlBpccXyldtwbAvyymxhqjSg4ZgDpRYiAB8
         MlN+ywOpXaRX3B0b6E+TaeWjPgJ0yv5vInaEAa0DvjtbfhLTBzDPqX5kxesd7Ev176ID
         EnJg==
X-Gm-Message-State: AGi0PubznVb4QtzoHEWXY6qZbezo4u5Xg+bFBtenCn/EwVT53+z8bQh0
        lJpa6WyVhn4Yd4xXBeC7+7u4ue9nNOE=
X-Google-Smtp-Source: APiQypJPJtx5E/RLyGfj5dMr7YO7W0i075oInSAkD8SLpPniCHZoIHXbKMaf3nv8oMfCWbp0x8Cozw==
X-Received: by 2002:a2e:553:: with SMTP id 80mr3094778ljf.147.1588357325092;
        Fri, 01 May 2020 11:22:05 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.150.177])
        by smtp.gmail.com with ESMTPSA id o20sm2681967lfc.39.2020.05.01.11.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 11:22:04 -0700 (PDT)
To:     Joe Perches <joe@perches.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200501134416.72248-1-efremov@linux.com>
 <c05138cb12f43498299d2b438173d082be2ebf17.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH v3 0/4] floppy: suppress UBSAN warning in
 setup_rw_floppy()
Message-ID: <2c506547-236e-02e2-53f1-9484ba6ae453@linux.com>
Date:   Fri, 1 May 2020 21:22:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c05138cb12f43498299d2b438173d082be2ebf17.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/20 9:02 PM, Joe Perches wrote:
> On Fri, 2020-05-01 at 16:44 +0300, Denis Efremov wrote:
>> These patches are based on Willy's cleanup patches
>> https://lkml.org/lkml/2020/3/31/609.
> 
> Maybe add pr_fmt and clean up a few messages so
> all the logging output is prefixed too.
>

Yes, I'm preparing next patchset with almost the same pr_fmt patch in it.
However, simply adding pr_fmt is not enough. We need to remove DPRINT macro
from the driver because it uses current_drive and this is wrong after Willy's cleanups.

#define DPRINT(format, args...) \                                                
        pr_info("floppy%d: " format, current_drive, ##args)

I also don't like debug_dcl and how it is used.
 
> ---
>  drivers/block/floppy.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c3daa64..b26bb1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -145,6 +145,8 @@
>   * Better audit of register_blkdev.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #undef  FLOPPY_SILENT_DCL_CLEAR
>  
>  #define REALLY_SLOW_IO
> @@ -1724,7 +1726,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
>  	if (current_fdc >= N_FDC || fdc_state[current_fdc].address == -1) {
>  		/* we don't even know which FDC is the culprit */
>  		pr_info("DOR0=%x\n", fdc_state[0].dor);
> -		pr_info("floppy interrupt on bizarre fdc %d\n", current_fdc);
> +		pr_info("interrupt on bizarre fdc %d\n", current_fdc);
>  		pr_info("handler=%ps\n", handler);
>  		is_alive(__func__, "bizarre fdc");
>  		return IRQ_NONE;
> @@ -2276,7 +2278,7 @@ static void request_done(int uptodate)
>  	reschedule_timeout(MAXTIMEOUT, msg);
>  
>  	if (!req) {
> -		pr_info("floppy.c: no request in request_done\n");
> +		pr_info("no request in request_done\n");
>  		return;
>  	}
>  
> @@ -4181,8 +4183,7 @@ static void floppy_rb0_cb(struct bio *bio)
>  	int drive = cbdata->drive;
>  
>  	if (bio->bi_status) {
> -		pr_info("floppy: error %d while reading block 0\n",
> -			bio->bi_status);
> +		pr_info("error %d while reading block 0\n", bio->bi_status);
>  		set_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
>  	}
>  	complete(&cbdata->complete);
> @@ -4954,7 +4955,7 @@ static void floppy_release_irq_and_dma(void)
>  #endif
>  
>  	if (delayed_work_pending(&fd_timeout))
> -		pr_info("floppy timer still active:%s\n", timeout_message);
> +		pr_info("timer still active:%s\n", timeout_message);
>  	if (delayed_work_pending(&fd_timer))
>  		pr_info("auxiliary floppy timer still active\n");
>  	if (work_pending(&floppy_work))
> 
> 
