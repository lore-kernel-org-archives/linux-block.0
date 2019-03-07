Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3957C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 21:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDE320684
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 21:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bIg7J8+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCGVyI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:54:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35350 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCGVyI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 16:54:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so12339709pgd.2
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yGAJqssnTNBVYlMGoebUqqZzxEjMZ4NzDRgagEy+k6k=;
        b=bIg7J8+lmEbG9XajS2NEpoCBAMnU1ZpJsiCzgoOSnRM5K9E3cRiHE+am2GBMicsakv
         pikTqStSYoHDeiXfYgy7ia+ietoE0Y2k7aQ9eHPUK4auY78/G+qkqWPJWG/8l7Z79ebw
         mIc/tKr7pl/naqyDtebhhm8QjTcJwxdYGi4zU0C5M9HpteYP91nqDbNpcQ/61PEZQaLD
         LnvwgMI03zmeUuRsMICOSINMKqboHQPz8M3KR9ULXSc6opym1NzO35rAL5YH07Xr0Mr4
         a+uZeFlO5T3/HctQK44hR+M9lHoFm+zFVMuF80KJDm4ZS3PlnFoWtbWVHAKR+If+POKA
         mtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGAJqssnTNBVYlMGoebUqqZzxEjMZ4NzDRgagEy+k6k=;
        b=XSgqOB6lKRG7t2ZangzyIHrHXJXKS3aZ4dcYaFqcwaaGbO6cQtJvRfUhdmob+pSosT
         iPr+Z4A2CH1y1QYhA9/brj8U+lEWz0QVNITo1NsyZ42q9YWrfAsKzHsy7hzmjEd5WoM5
         1y+sCEv+R30P2E3Z6XvpE3FdkjUQSwUd/t07Mft+PSLen2/SbjCHMRhqhnSbOZhXOmOm
         HDspIl1yjuDIkRfJMJ30FasQa/2viSBTzL0o7b2ZnZ0aDvPrrHRxNXLjeZtLPeoHyeeS
         XKxm1NycKKIJVLTZNePR7rdfUhwzaEsBN/IGBbZ057nHaEeF704G9wwhKk/JD8nLA7Zm
         RTFg==
X-Gm-Message-State: APjAAAVoVkjK6MhGZEgcwLcIkIkAMDTILXtW16UHdGgDnS/54aKHIvGT
        DEtZ2oTgLWVXKi93ik+BTkJl1nXWRAsGMg==
X-Google-Smtp-Source: APXvYqxZl3yAptI8+GBSspr2mZr3mtgwZS+IFw/LEd+B2cVesz5rydlWIz7yMjEwyURg6cuD4nnBMg==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3mr15175266plk.313.1551995647378;
        Thu, 07 Mar 2019 13:54:07 -0800 (PST)
Received: from [172.20.10.3] ([107.72.97.82])
        by smtp.gmail.com with ESMTPSA id k12sm585533pga.21.2019.03.07.13.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 13:54:06 -0800 (PST)
Subject: Re: [PATCH] block: init flush rq ref count to 1
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org
References: <20190307213718.28017-1-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9542ba4-a468-5f23-1f1a-c1172769d7d9@kernel.dk>
Date:   Thu, 7 Mar 2019 14:54:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307213718.28017-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/19 2:37 PM, Josef Bacik wrote:
> We discovered a problem in newer kernels where a disconnect of a NBD
> device while the flush request was pending would result in a hang.  This
> is because the blk mq timeout handler does
> 
>         if (!refcount_inc_not_zero(&rq->ref))
>                 return true;
> 
> to determine if it's ok to run the timeout handler for the request.
> Flush_rq's don't have a ref count set, so we'd skip running the timeout
> handler for this request and it would just sit there in limbo forever.
> 
> Fix this by always setting the refcount of any request going through
> blk_init_rq() to 1.  I tested this with a nbd-server that dropped flush
> requests to verify that it hung, and then tested with this patch to
> verify I got the timeout as expected and the error handling kicked in.
> Thanks,

Looks good to me, thanks Josef.

-- 
Jens Axboe

