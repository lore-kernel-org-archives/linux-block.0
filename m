Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4EEC04AB5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CA127A3F
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 14:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfFCOzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:55:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42605 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfFCOzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 10:55:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so545811pff.9
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2019 07:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZRqowIuJ/mwTtMwz49+ETVSEY7q2s/YkdqSrPsKNBg=;
        b=nro8ZntAySGM4qCr6loXibqu9DVL2J3BDXaOLlcV7wlO5qlxp727UQ3gDvuB7+Nntg
         Rh6Bec8attHSqqVt6rEYhaTvTVDsY+CgkLSG6e9e2EDC+baXhI4fmuH2unq3WYYdTxAv
         pv1GQa3LthZkLSTZI1xbBaq5c5ty74B0B2NDCl5RJ3zmhEsJJnLPWrU/sIiC8W8fqw/3
         OUYBSKuW2/oI72GLlz/k1gHs1h/4Q5JzMak+ZlEVN2z5/6nkcA5M0C5AVxFGryDsu4Q6
         3ZS8byz8MpE1RRPraC429ZuJc8gRrSWfeA5mq97wqy9KR0Q7hW8VW4mDadM/TNxkVP+X
         Tyzw==
X-Gm-Message-State: APjAAAWBuuX3LYgJ9euZVEQMWWbbwekR+sSQYLr1sCUPrHaiZEkUnz9H
        ILH/syGtPvrXJ588OVCZxLs=
X-Google-Smtp-Source: APXvYqwvRvxqNXLqMW9gWlvU2t+l/YXPVdar2V1nuOJmnOVzKQAdevIa96+F3QPoJb31TOdLZFdGKA==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr30100850pjk.89.1559573709396;
        Mon, 03 Jun 2019 07:55:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t15sm15125957pjb.6.2019.06.03.07.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 07:55:08 -0700 (PDT)
Subject: Re: [PATCH] block :blk-sysfs: fix refcount imbalance on the error
 path
To:     Lin Yi <teroincn@163.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liujian6@iie.ac.cn, csong@cs.ucr.edu,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com
References: <20190603074653.GA12767@163.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <786ba0b5-708d-dfcd-29cf-ccf20386f949@acm.org>
Date:   Mon, 3 Jun 2019 07:55:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603074653.GA12767@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/19 12:46 AM, Lin Yi wrote:
> kobject_add takes a refcount to the object dev->kobj, but forget to
> release it on the error path, lead to a memory leak.
> 
> Signed-off-by: Lin Yi <teroincn@163.com>
> ---
>   block/blk-sysfs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 75b5281..539b7cb 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -971,6 +971,7 @@ int blk_register_queue(struct gendisk *disk)
>   	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
>   	if (ret < 0) {
>   		blk_trace_remove_sysfs(dev);
> +		kobject_put(&dev->kobj);
>   		goto unlock;
>   	}

Have you reviewed the other kobject_add() calls in the block layer? Are 
there more such calls that need to be fixed?

Additionally, please add "Fixes:" and "Cc: stable" tags.

Thanks,

Bart.
