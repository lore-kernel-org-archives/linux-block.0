Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6515C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 14:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJUOyt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJUOys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 10:54:48 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C1A6F550
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 07:54:47 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3172934pjl.0
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 07:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y+qseLtdxHaZrYJfMoftuayR6ceA4QborT9tQQO6kE=;
        b=mFG3sICku5rAEjJhrEK1fKcBTE2+Q8BvmKQsYtM7puuqFVSEQwgHq85NMTbf0IJDlD
         2zmgUW4AN4Ay5h6OaFq3plBAe8/hRfnOlqoeCMbUYtPqyCf2xLlS00qWEWuYztPsGjYx
         cCtu2MNrywGS4Nd6Qmv9ggP0JTgtAhxUF89W/mdIOAETTCrJK+Ir5vqDuC+sF66OzMGZ
         ajyie879jWjBh03LHdI+HWUyqQqUfZ15FdkdEYYfecej/u0pbCDy1bKOwGjhdzoFecQY
         hdc5rplc2mw2I0sPDU7m44SOimxZWQ/tTthx/T7vqqy37CTauFBPz122TIVCys0PEEkW
         tk5g==
X-Gm-Message-State: ACrzQf0tlveVoJ7UbfZYcRPaX4nVlJcDxKduS2eCs3CePa2OZzREHq9e
        bs0Tqe57r7W0hE2M2r0SONc=
X-Google-Smtp-Source: AMsMyM6aibq9SB89fPTayS5ue5AjPliWtsHcIqvsKZ1hP+zJs5WXQmVNEoOpj2jJYyu+He2SkbeGOA==
X-Received: by 2002:a17:902:8d93:b0:17f:852e:f84e with SMTP id v19-20020a1709028d9300b0017f852ef84emr19196370plo.20.1666364086924;
        Fri, 21 Oct 2022 07:54:46 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b0017f5c7d3931sm14611741plb.282.2022.10.21.07.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:54:46 -0700 (PDT)
Message-ID: <65e2a1ec-34b4-cb5b-06f7-410160b8da96@acm.org>
Date:   Fri, 21 Oct 2022 07:54:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Issue in blk_mq_alloc_request_hctx()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
References: <b44c42f8-db20-eff8-fba4-07a64ca47918@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b44c42f8-db20-eff8-fba4-07a64ca47918@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/22 04:16, John Garry wrote:
> -    return blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
> +    rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
>                       alloc_time_ns);
> +    if (!rq)
> +        goto out_queue_exit;
> +
> +    rq->__data_len = 0;
> +    rq->__sector = (sector_t) -1;
> +    rq->bio = rq->biotail = NULL;
> +    return rq;

Hi John,

Shouldn't the new struct request member initializations be moved into 
blk_mq_rq_ctx_init() such that all blk_mq_rq_ctx_init() callers are fixed?

Thanks,

Bart.
