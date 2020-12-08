Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F4EC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BE323A79
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 16:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgLHQoE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 11:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgLHQoE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 11:44:04 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C0C06179C
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 08:43:23 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id g20so25528840ejb.1
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 08:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=D8+mVv5RQD8CpwgxKVSJQQo0Mrt9GXSeIe0fUjQKEjI=;
        b=JhygiiAMZZ8cxNN6KOPqRt5fibeTv+eKpnYOBzIRK4hGs9zW+2dDgwuK4CcJX/K1NL
         Pddii6jc6uq1ad0tx+J25fR2jeiibn2ZPkR4w+fsbLsO5HIkPrDx0FzpK72yLqeft+p5
         4mZT5yC37yUUFI5JmRaRdalnUtCFnGdpJ7kNcRzlephIlUeWdbE5A5O7IGdPeEwWDSRV
         aLOERNHJtIyj0KxgLKTBlS660Gcs+/x+mjDI1LL3ElN1r8MUUrqH8rnZixuWn0hnrUrZ
         zZj/FwaQodlLSP0+k/CNgUDsNvEOnMatdozdFQpANZ09g9rxCUmuE1CedUwAk6B3WcGW
         S52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D8+mVv5RQD8CpwgxKVSJQQo0Mrt9GXSeIe0fUjQKEjI=;
        b=GIqkUMgZ072S5TkJ9A0Hw3RQ8rGnBm5+/LIckMSCwS7YG7GGBqHehpxypgmJjOWgdH
         RALycbu1VAOLwlDqMNY6QgDCWZzhcUIEvg3vQWb3Uxrrnt/IbBaWo8J98/J0kiphYpox
         jJ2+3KOVQNGrMIXzyHbAdzX8XpdQyIHz0yyqDBzG4g3u35GbBmqOAOK1GfbF7tZAap1/
         Zrfb+9S+q3iRYDYMOdgamloldK8OWuik5W9Sw8VwegzG5MLeL8t0y5unZzYfzvg2LjXn
         6dtjQ4lJeK8rMYT3Xs2jf6QEUZ8FaVhnU+zI2HKFtOzflAQZ53IoB0Y/eWzD2C42Q2CE
         nHTQ==
X-Gm-Message-State: AOAM53032JkACTrwhseyXtudX25FyZVQkjQ/OqmtOYkYBKGRfRhstGdS
        +TaEA/cUkLl+MPjVzDzGHgF+mQ==
X-Google-Smtp-Source: ABdhPJwhueFDgAgw8uVmhQYVi+Y3Z1PNRxP2pO93LILiSMWVKWXJhuroBVKcGQvBhzsnV3j+PkxJKw==
X-Received: by 2002:a17:906:4e53:: with SMTP id g19mr7925334ejw.454.1607445802481;
        Tue, 08 Dec 2020 08:43:22 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id k2sm16166403ejp.6.2020.12.08.08.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 08:43:20 -0800 (PST)
Subject: Re: [PATCH] drivers/lightnvm: fix a null-ptr-deref bug in pblk-core.c
To:     tangzhenhao <tzh18@mails.tsinghua.edu.cn>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20201130072356.5378-1-tzh18@mails.tsinghua.edu.cn>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <53dfdf3e-56f5-3043-1b57-5507231f0e0d@lightnvm.io>
Date:   Tue, 8 Dec 2020 17:43:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201130072356.5378-1-tzh18@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/11/2020 08.23, tangzhenhao wrote:
> At line 294 in drivers/lightnvm/pblk-write.c, function pblk_gen_run_ws is called with actual param GFP_ATOMIC. pblk_gen_run_ws call mempool_alloc using "GFP_ATOMIC" flag, so mempool_alloc can return null. So we need to check the return-val of mempool_alloc to avoid null-ptr-deref bug.
>
> Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
> ---
>   drivers/lightnvm/pblk-core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 97c68731406b..1dddba11e721 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1869,6 +1869,10 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
>   	struct pblk_line_ws *line_ws;
>   
>   	line_ws = mempool_alloc(&pblk->gen_ws_pool, gfp_mask);
> +	if (!line_ws) {
> +		pblk_err(pblk, "pblk: could not allocate memory\n");
> +		return;
> +	}
>   
>   	line_ws->pblk = pblk;
>   	line_ws->line = line;

Thank you, Hao. Good catch.

Reviewed-by: Matias Bjørling <mb@lightnvm.io>

Hi Jens, would you be so kind to pick this up when convenient?

Thanks!

Best, Matias

