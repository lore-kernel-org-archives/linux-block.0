Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C5CC433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980D461446
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 14:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhD2OoG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhD2OoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 10:44:05 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E6C06138B
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 07:43:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e14so30588662ils.12
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xc0QKhBze4+2KGKCm5xfUoTSmv8nyFMkOZoCMexMvyI=;
        b=AittbQ4vkN+J2WNkCfMy9JvizeJXymGBO5VSM9uZo3Vh3j0zjz8ut+1OTsmwtNMq7P
         7NRxfqutaKAnP8HWIHUiHaVEZ5PGfjbmIzvbCEfSOspoI3DwRSjxRgZvd/A0V3UYtLzF
         meUe05jDjozFqcYEd6g1NR52AjUYzCqSXGIQs6tCe5eNOl6pRNkwlRXQCbOxeWP5rqvX
         eMsffpmoNA1fQnIKUY4Al6a2046xSBq1mnWvdC/jSFL7Yiu+vUOS8nupnuvkJVAU+l2D
         anajeHUWhVEOsXlyB+HWVFIS9222LHht93UGK09LoGrz5h3VdPZ95OnSRpbjgeZV4Slg
         IY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xc0QKhBze4+2KGKCm5xfUoTSmv8nyFMkOZoCMexMvyI=;
        b=ansXmDyd6UuVoc5OVKchYgvokPTh4kRVwSxMzuDdJ9LI7hNf7YsdW11+nXKIkwSBH6
         lQ9vmjSO+9D9wzY2EkjdtrQNoseiiATvofq0JSYoZqvmZSCZrfzE53BxyOG5eTTSpPux
         OO+xF7Gm119CgTESM5Nuf80x5fBmGQZcrXjZ0Ju/uqTMqDWo5DxqkjDTeWXrrxFE8s4/
         Zbe1wVx2odQflpGFsNGVQsR6SPha3spfu6CvBjac7oxv3dJLaKEEJTlyj473onSsEki4
         4JSU+KnxlHmWq5eGazcqW+SeEJxJPCb9CjWzgQA7ATve5eeZOh3FcaFB+0zlVYpW6cmQ
         VC7g==
X-Gm-Message-State: AOAM530nEXUnJBUcI++mmVYOVd6h0lrWkyk1sAm/HjHzuuRXkO9q7moy
        BFVroSFfXGnFPYx6aEeNbnOIeASy1OugYw==
X-Google-Smtp-Source: ABdhPJxiVY9YDMynYcoLb2RyCaHu/qJWEyyjNEa8heFKtFbBNb2evP1Y3mYYlZrG724bgO/nBc8dxw==
X-Received: by 2002:a05:6e02:1b8f:: with SMTP id h15mr40260ili.151.1619707397026;
        Thu, 29 Apr 2021 07:43:17 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 16sm1424506iln.42.2021.04.29.07.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 07:43:16 -0700 (PDT)
Subject: Re: Can we make the io_poll queue attibute read-only
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20210429073206.GA3925@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0161d16-db00-0666-c637-724c3e1c16ea@kernel.dk>
Date:   Thu, 29 Apr 2021 08:43:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429073206.GA3925@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/21 1:32 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> while looking at the polling code I wonder if we have to keep supporting
> the change of the io_poll attribute and thus the poll flag on a live
> queue.  The support to change this goes back to before supporting the
> explicit poll queues, and was used as the prime interface to enable
> polling.  Now that we use explicit poll queues the driver specific
> paramters to set them up work as the prime interface to enable polling.
> They can still be changed at runtime, although much more invasively
> (i.e. controller reset in nvme).  The upside is that we don't need
> to bother with draining the bios and two queue flags, and don't have
> a confusing duplicated user interface.

I think so, doesn't make much sense anymore. There's no point in
configuring for poll queues and then disabling it through sysfs.

Rather than make it RO and risk breaking apps, why not just ignore the
write?

-- 
Jens Axboe

