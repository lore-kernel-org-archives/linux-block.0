Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 13:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348720AbiBNNqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:46:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354711AbiBNNp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 08:45:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E0DB849
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 05:45:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so18907779pja.3
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 05:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AFL1QrRZFiRBpJOUN2fd4w7QGVdaH7B6zGnzpkZBapw=;
        b=D6bX9VUCLqM8jyGjb4VMY6tXa0mEG//TgY5UlTRkkJdLxthwxikwk0zQq/r5v5aiZ3
         gMk15/vGlBSxyKjWaUMOfvAPG+GTTrQfLbIa2UmLc7FMQBMIFGgjJAtI1DOMlPvZSXgc
         YJlV6SKYCigwk09hDb8NWNa5BFAk+jApnpIkij9CYFhqi2xtgRLQKd95BmsHhWLopGYw
         aHdHCY6JG6ol4MOVKhc7VQbEYIBvKHlDABre2sI8jTJIWqWm+POAoOFpmw4uBgYOyrj1
         BZQfqdNhvUMAr1ceftYG0sWBfKeuW/8+MujkM6NhFdU5+mAsxtZbnfNmhOSPxInQjije
         tqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFL1QrRZFiRBpJOUN2fd4w7QGVdaH7B6zGnzpkZBapw=;
        b=Kf5npIHW0TNMAPlB16SD+mWNZ2usjvVbg32kuNuoWDQSiWDCBRR6bB9Kmrs6mI3htE
         /WJmXh0LDV/TcoJ4Z27X9C1sO4daCeOAtHGgjsJPKHFKnZMBvuk05odfUrnEuC19E0f3
         9wAa8JaX8EUZkuoe0GkYhEtb+HUJnzK+0AdbPZo+xU4oDJmNtqtDDkMQ1QMZ6x5lzV7d
         0S7V6J5S3bBKAc2v9ABaQbYyaowBikAY2zzFuMr5T+0Zyorsl6J8++3V+z2C7Jbvxhvu
         KOCgvQ6HphJ6/WjCK0qY3mCITaB21/JlR+9Euw/5HA1ylJcl1HAN4Q8/BwpcqlGunD+Z
         4lpQ==
X-Gm-Message-State: AOAM531fl3IQ8/Sa46Ur7xvAlhFUWJSeUddZZamQ/cqVr+9FgTiKUJna
        3jTz6DNwNfLdua8SL1TIk8KCzQ==
X-Google-Smtp-Source: ABdhPJxEThvNuxPwxJjuBk8NHTkaRqgrmTwxf1q5rLUh7kyivevFeJz3lSSqx9N3v0rnvuKnEq95jQ==
X-Received: by 2002:a17:902:a98b:: with SMTP id bh11mr14370585plb.49.1644846349300;
        Mon, 14 Feb 2022 05:45:49 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ch19sm14417318pjb.19.2022.02.14.05.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 05:45:48 -0800 (PST)
Subject: Re: [PATCH 0/4] blk-lib: cleanup bdev_get_queue()
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "jiangguoqing@kylinos.cn" <jiangguoqing@kylinos.cn>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
References: <20220214100859.9400-1-kch@nvidia.com>
 <5e12a394-031f-51f6-a5f1-39f8d0ee369c@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fe8553e-d9b0-bcbf-f332-55dbf1985358@kernel.dk>
Date:   Mon, 14 Feb 2022 06:45:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5e12a394-031f-51f6-a5f1-39f8d0ee369c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/22 3:19 AM, Chaitanya Kulkarni wrote:
> On 2/14/22 2:08 AM, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> Based on the comment in the include/linux/blkdev.h:bdev_get_queue()
>> the return value of the function will never be NULL. This patch series
>> removes those checks present in the blk-lib.c, also removes the not
>> needed local variable pointer to request_queue from the write_zeroes
>> helpers.
>>
>> Below is the test log for  discard (__blkdev_issue_disacrd()) and
>> write-zeroes (__blkdev_issue_write_zeroes/__blkdev_issue_zero_pages()).
>>
>> -ck
>>
> 
> This clashes with Christoph's write same cleanup. I'll resend this
> once that is in the linux-block tree, meanwhile any comments on
> discard, write-zeroes and zero-pages patches are welcome.

Please just collapse those patches into 1. Right now it's 4 patches
with identical titles, that's very confusing.

-- 
Jens Axboe

