Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37589CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117D221D7F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfJYUvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:51:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38792 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYUvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:51:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so3218324wms.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LHCDSwoi5zmdyjGEtOo/N1Lz2NfMg4bBAivq86GIOFE=;
        b=rZUt5zL2NdiXGIPVrXKYocM5L26/iJf8OFKN7Ox7k7TRZAWEIlpbAnSWwlyhnty+1v
         6yUPBle5kUWrx1Zn31yWF5SE0ilRPGKTxL86P5yuroSsYyV0L+ZPx0LQJBF0nrFEQMbb
         xlIyWK41sbpgwPkZf8z4Zh4S29wp3xhw0nUfxwelg8+83N+gmfH6KnkP8SwFlWihpjih
         g1zlc4Jc0fWFfOAXtvbfKyGu0s+KYbO57t12cvLDfToTsFHoXHCGBONjy4bNxaYNVXVr
         Vd+9rxUty/6kCWfYb2jgM+pX46xPDMceZKhdfFP1TRokAAw/uZ+240cMgeGvH+CTRj9j
         MQBA==
X-Gm-Message-State: APjAAAVqP0STgaUlvGEQcVat0Mw6Gv50cwKKmQ5AK37OYFMERMqswf+3
        b/B5HO91+lv+MFpxgXsoCLg=
X-Google-Smtp-Source: APXvYqz6I/2F/hb7dO3W7xcMPMx87BvnJkeyAOYFlHNYifaPfQaL6ZK+bnDXMelVobYljM/uRZTrAQ==
X-Received: by 2002:a05:600c:2908:: with SMTP id i8mr5428353wmd.142.1572036677907;
        Fri, 25 Oct 2019 13:51:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c14sm3156973wru.24.2019.10.25.13.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:51:17 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
To:     James Smart <jsmart2021@gmail.com>, linux-block@vger.kernel.org
Cc:     Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c0423099-f5eb-b513-3e1b-ec719d753f15@grimberg.me>
Date:   Fri, 25 Oct 2019 13:51:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023175700.18615-1-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8538dc415499..0b06b4ea57f1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -461,6 +461,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   		return ERR_PTR(-EXDEV);
>   	}
>   	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids)
> +		cpu = cpumask_first(alloc_data.hctx->cpumask);

I'd just drop the cpu_online_mask test, we don't care about the cpu
being online as this request is running already.
