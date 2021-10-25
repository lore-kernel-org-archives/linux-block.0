Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DAAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140FE60E52
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhJYKbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJYKbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 06:31:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72463C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 03:28:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso12548825wmd.3
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Te9zNoIa0vFfWqKPM7HQ04jgG0BMBOIhARAaFs7PR/A=;
        b=Fh0wnlmFoS0TxD8/SuYJUucvk/U04aCqcPL03PluHNPa9swvT5Q1dW0a7j1P65Q4FK
         qeITslZLfC8/9TuCdLQtoJFahm4XgV22Y7l4XJKxtgzMcA8f/zukeum4vIE/he55r/W2
         7VZnZvu5s54l+53lWJeZg2P9hgDbbhMc0NbMpLVL9/V2ojkR0yUka9WBEUolauBeVkR1
         FYGOJ41/XoFtQNI1SCQfCAgq18OxU3NhyYZN4J8S6sfomgCB/HsHXtEHbXqYcuRMFmg4
         tjwEYUoHyFRJebXrxoHrY4ckos6F0AGpkBa/BJa21DDkC1/2ujzHNXXTG2c9HNAmJKE1
         3SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Te9zNoIa0vFfWqKPM7HQ04jgG0BMBOIhARAaFs7PR/A=;
        b=hpWY0ErpCJhg6ihiZyqM3g56q5rvdz30w2vEHc5H+KFJtR4OaY+oeH2baaf3AjlQtK
         fTOJy+xgpyY1hrK1c4OEmYtbeuQ1dI0eDyRq4hM7M4MFqm8tOVVpCqpwtUE258ER61/P
         eJ8IvKF6iino/U7xdzrTKsyLUJuzk9fqfj46k8uIBRpVEjVeqrqM0jUu2lUjP/e/QBBO
         uGuzQ2xPT/Kvyd5Qzzbk0rFJ/s/YLPgWL1l5d+LzSJvwbz0EiKPwOJHuMZl25pfAzFs5
         s8j1GKgCqDpUxZmkFWkXzwhrKMZv6BQ19OPyYKBHumRCWjk/yjHmWiPTkOsD00p+dUB9
         x6Ww==
X-Gm-Message-State: AOAM532U/CFpKJSz4su3XXfWS+AMST6tccaUx+YZp4saHL6y98hQiPNj
        6Hcw4noXj8dsULF8Gkr/FtI=
X-Google-Smtp-Source: ABdhPJxD87Np1I35qwOYSJDhgWhqO9dQqxdMj2af6aeotusCFZ80wThxeUu6zu/4dGAapHsB18KYGA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr16015481wme.160.1635157729234;
        Mon, 25 Oct 2021 03:28:49 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.144.165])
        by smtp.gmail.com with ESMTPSA id f9sm5544664wrx.31.2021.10.25.03.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 03:28:48 -0700 (PDT)
Message-ID: <59bdf1f5-c96d-2cdf-32ba-a8b3ab777cf8@gmail.com>
Date:   Mon, 25 Oct 2021 11:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
 <YXZeNUVx3cJW/lV+@infradead.org>
 <4e53a08b-3cfa-8351-2713-af632a759e88@gmail.com>
In-Reply-To: <4e53a08b-3cfa-8351-2713-af632a759e88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 11:12, Pavel Begunkov wrote:
> On 10/25/21 08:35, Christoph Hellwig wrote:
>> On Sat, Oct 23, 2021 at 05:21:35PM +0100, Pavel Begunkov wrote:
>>> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
>>> serves only multio-bio I/O, which we don't poll. Now we can remove
>>> anything related to I/O polling from it.
>>
>> Looks good, but please also remove the entire non-multi bio support
>> while you're at it.
> 
> ok, will include into the series

You mean simplifying __blkdev_direct_IO(), right? E.g. as mentioned
removing DIO_MULTI_BIO.

There is also some potential for doing bio_iov_vecs_to_alloc()
only once and doing some refactoring on top of it, but would
need extra legwork that is better to go separately.

-- 
Pavel Begunkov
