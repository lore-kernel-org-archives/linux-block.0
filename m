Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5740EC7618F
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272442075E
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjoHpB28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfG1GIY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:08:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46392 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG1GIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:08:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so7602633pgk.13
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+GP7qdv+AVyCrN3vNUjydQUTuh5aKMTj137o5Nk0wI=;
        b=LjoHpB28WYkjEQ0e344luxKvSKz+sCAQ5Q5FwKOsctT8OlhOno2Z+svuwOVgMEH7lX
         9KPIBiavma8iI5KGlPN5nPXtwM9+W0eUGOiy1+DDxrRnKYxKwahEbesOp9zL9cai9uR9
         sRai9LZvYeg2oF0BdiaFOF8Frb3T8i4/Nz6VH7YvedD3rUBa+f1zivJJ9YqVEtnEZPt9
         1Ebg1Wo3Irt1TicFxs7r0ZE6Kw8opL4V27cG7k/OlzaAGEW3FJqqY2HcTkXvwhinBnCM
         OE/ki8XdQO/0AHapyg7iyvDcB+iGQ6LZ6Pv2F465pqxpgKqN/ghLny1WfT+bF01kaEM6
         Guhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+GP7qdv+AVyCrN3vNUjydQUTuh5aKMTj137o5Nk0wI=;
        b=c83R2/iY1LrGPFVPYBDxAm0mfDi8rPHpXGjsUg4aKN+IJfkf32DZ/u1TlPVac80UKj
         sQ2dnI3GTggnb++aarIy18Sv65I2DU0D8Txe7u6l4v035ZWFulOzGWfs2M4Z7DayxL3K
         PqaL52Bw/3Y2NYYXiYS7fQgwYW/njfCeg5WpuClIsNAKH8aOGc7jWYu5EHallRYMPUbQ
         lMvvHk9GfWq/oEbNPAkEciRiBQP2Pl7CBFiiDNp8MK9YRCkq9ilDPCcInhvdg/alErE5
         dbV/CA3EFVt1JwFLvbxws9AKlB5CdL02gWBziowZfqxp7QCLLOUhql5mwgZWkQ1AZWm/
         b4ZQ==
X-Gm-Message-State: APjAAAXjjYrx+swNTNvDzHLdlEdB1Q0EdzhNWIdWuuzX5/7EQ9Lx9Yev
        fqma5QcoCeaZSPnAymifX9E=
X-Google-Smtp-Source: APXvYqwwrwj9qfmFzHIGftxE6cZQbEcQWotZqUPPl90me1wxjRPc9+4zSKpTWnCfwnz9QYjNlIgT2Q==
X-Received: by 2002:a62:7994:: with SMTP id u142mr30773698pfc.39.1564294103357;
        Sat, 27 Jul 2019 23:08:23 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id v18sm53350671pgl.87.2019.07.27.23.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:08:22 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:08:20 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 3/8] null_blk: add support for write-zeroes
Message-ID: <20190728060820.GE24390@minwoo-desktop>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711175328.16430-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-11 10:53:23, Chaitanya Kulkarni wrote:
> This patch adds support to execute REQ_OP_WRITE_ZEROES operations on
> the null_blk device when device is not memory-backed. Just like
> REQ_OP_DISCARD we add a new module parameter to enable this support.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/null_blk_main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 20d60b951622..65da7c2d93b9 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -198,6 +198,10 @@ static bool g_discard;
>  module_param_named(discard, g_discard, bool, 0444);
>  MODULE_PARM_DESC(discard, "Allow REQ_OP_DISCARD processing. Default: false");
>  
> +static bool g_write_zeroes;
> +module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
> +MODULE_PARM_DESC(write_zeroes, "Allow REQ_OP_WRITE_ZEROES processing. Default: false");
> +
>  static struct nullb_device *null_alloc_dev(void);
>  static void null_free_dev(struct nullb_device *dev);
>  static void null_del_dev(struct nullb *nullb);
> @@ -535,7 +539,10 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->zone_size = g_zone_size;
>  	dev->zone_nr_conv = g_zone_nr_conv;
>  	dev->discard = g_discard;
> +	dev->write_zeroes = g_write_zeroes;
>  	pr_info("discard : %s\n", dev->discard ? "TRUE" : "FALSE");
> +	pr_info("write-zeroes : %s\n", dev->write_zeroes ? "TRUE" : "FALSE");
> +
>  	return dev;
>  }
>  
> @@ -1419,6 +1426,13 @@ static void null_config_discard(struct nullb *nullb)
>  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
>  }
>  
> +static void null_config_write_zeroes(struct nullb *nullb)
> +{
> +	if (nullb->dev->write_zeroes == false)

Can this trivial one for the style like the others in this module ?
	if (!nullb->dev->write_zeroes)

Besides that it looks good to me :)

Thanks!
