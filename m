Return-Path: <SRS0=Wa/x=VC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5784C4649E
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC55216E3
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P8AUUnWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfGEQZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:25:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36142 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGEQZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jul 2019 12:25:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so4839489plt.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2019 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pz7K9jKvQTtILFQnoorv1Z3ZqKE2ao5OdrFQMgDSyXw=;
        b=P8AUUnWFoALJ7U/y2AmUEmSiCMqlC+53Vclf84+KYhh+Tjfo+4ytw3Ct+0DVul0Jzq
         bNdEVqNOhE4OuuIqFIGltU4zigwYMODWc+sLsfqZlo/ZtNV9qfqXacMdlqtDIOuYA0KI
         47z2jQE9gKz2yYoNNwcjqFcnV3VhplqP7K7t+B/V7jTZEzleUDFSGq/FFuUdyjgglBhy
         XRLZmETkvCq2AtSXt/LEvz9Wmj/0XoiaerSa/wtAu0jlSnwZYVmBvtRSXXsSZUtUZL78
         b+Ptfmb80qFVaOY0JIImEQl70LtF54s6VGlSK8P01EQRwfCJgzVE2rAji34Rba6vUhyr
         FgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pz7K9jKvQTtILFQnoorv1Z3ZqKE2ao5OdrFQMgDSyXw=;
        b=XpfdIhpVgwdN4yCVToioT8Et2/jsJDbEDagfPNDg4aoZ35pFdnxtSbsnkWKiIKqxok
         R9r4iGnvk/4RF5uhc+g9mgASPLe1G8X5hFy05PchF24KckBWRiVq4fQKJA7plyS+tyDN
         zbBWOJklgBl7JaztDRqjmCOXSmJ7p1gl+lE0kzi5eAd0p3rs52Miw3RT8WF1DIv6ecLA
         htC0rl5DmWI6oKORDHpeq5as2C85F+6wWMvWGRHesFlPaASLnolguAl9Y5yUAcx+VTVC
         7HwrVamoBhOokNa5+w4qnjMsaIl34PfmHfQAae2u3Sm9GP907PMe/3hzfNbPJvJ3yxpX
         +1Gg==
X-Gm-Message-State: APjAAAXFFTEmP/yAgdabYl91YLEUqDcq3p761ZkXpwjpoF5ufsDEOqa2
        +nXKFCnC1yP+VcBuEacSCN809fyuk6VnwQ==
X-Google-Smtp-Source: APXvYqxHparBOko4qc+jBjF8r9jz/rO4zy+KH6knn5unFSxITvuDZCzBSs9fEHc+RzM8+LIRe7dldw==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr6530885plo.302.1562343924901;
        Fri, 05 Jul 2019 09:25:24 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i126sm9323617pfb.32.2019.07.05.09.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 09:25:24 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix io_sq_thread_stop running in front of
 io_sq_thread
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     ebiggers@kernel.org, liuzhengyuan@kylinos.cn,
        linux-block@vger.kernel.org
References: <000000000000665152058c0d7ed9@google.com>
 <1562307120-6785-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c3affad-fc75-d64d-c0e0-829d2343d074@kernel.dk>
Date:   Fri, 5 Jul 2019 10:25:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562307120-6785-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/5/19 12:12 AM, Jackie Liu wrote:
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 4ef62a4..4bbecbb 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -231,6 +231,7 @@ struct io_ring_ctx {
>   	struct task_struct	*sqo_thread;	/* if using sq thread polling */
>   	struct mm_struct	*sqo_mm;
>   	wait_queue_head_t	sqo_wait;
> +	bool			sqo_thread_started;
>   
>   	struct {
>   		/* CQ ring */
> @@ -2009,6 +2010,8 @@ static int io_sq_thread(void *data)
>   	unsigned inflight;
>   	unsigned long timeout;
>   
> +	ctx->sqo_thread_started = true;
> +
>   	old_fs = get_fs();
>   	set_fs(USER_DS);
>   
> @@ -2243,6 +2246,8 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
>   static void io_sq_thread_stop(struct io_ring_ctx *ctx)
>   {
>   	if (ctx->sqo_thread) {
> +		while (!ctx->sqo_thread_started)
> +			schedule();
>   		/*
>   		 * The park is a bit of a work-around, without it we get
>   		 * warning spews on shutdown with SQPOLL set and affinity
> 

Probably want to make that an unsigned long, and then use
set_bit/test_bit for this to avoid funky memory ordering issues.

-- 
Jens Axboe

