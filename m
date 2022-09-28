Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBDC54EE9
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiI1RO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiI1ROM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:14:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22344EDD0C
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 10:13:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so3190225pjs.1
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wWlQ9VK0DD9czemBerx4SeOis5QOOAIANjEKI2qVGtE=;
        b=cqKovKCQW42IllwbMKlBvvUs/FTWNZj2mcCK4y8ThaGVMsyk99k64owZjUZ1wWxcQ6
         nYikmRHFfUAOgeWZGS+Nn9LoJ8ZbviC192qAAj4lWH/thexYx83hrfTITHakHOENrtxc
         zVPqhWKPDZON3vonUHsXNxB/06q2VX4xHkzzWTZ62frKoxiIVahORXc7MJfSDedHTM4s
         zRsfCkZ8dIQ5YcJrh2KGXCJbQ37RZW2Tk7wXLqPTvYW2cQ9wGtvzCEWMqM3gp84kDF5e
         3Vqks9P8ozmtfwHJhhPD3yV6cRuVrPJNwa2MleHi5Ry/pIgPG35wdEOx+1G7zOrTFGJ6
         wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wWlQ9VK0DD9czemBerx4SeOis5QOOAIANjEKI2qVGtE=;
        b=I25MlGTDHrBkCETnlUF1LSXM7eomEer8zkgPZuD/V1UzG8Dx1PgrmS2hFBK51oH2Ve
         t404ZLtjMQ2i5HggNin7rGXFm2uxUZQe9taS6u1+ogyQVbCG6CZirhH4P80qUlRpihvp
         q02Na2buL0UExhLNfyQOozU3rgBcCOw2gefUgk1lzTNofZ9rgTxnX/OwRRL1wyJef5tn
         HYWYsJfpl+F1WvSVJXNs7aVvx+hb3OSOaYxdGSa0odNb8+0+ATEWefqXmFZWa5Ki/o2z
         gAbvVu88QhNnUN0Wj7ou9i9rLG3PhSDBxwElTUZmiQAx9ayL/4/6io1qWjc7vqB9uykv
         jjDw==
X-Gm-Message-State: ACrzQf1Ghhk3hzd56BmihmzBArAjAD3EQDnZLaquhtIB0bIMxluVdRJ/
        ocmRb4bpU878wJOxhvpek9CMgw==
X-Google-Smtp-Source: AMsMyM52hwd593t/SShjlopLYj42VgkbaQcw6sT5ciMCuzKacBGMa3jiLUuF7+xtWM+y2NRNlketfA==
X-Received: by 2002:a17:90b:33d2:b0:203:15e7:1571 with SMTP id lk18-20020a17090b33d200b0020315e71571mr11445784pjb.186.1664385216734;
        Wed, 28 Sep 2022 10:13:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r9-20020a635d09000000b004393cb720afsm3844788pgb.38.2022.09.28.10.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:13:36 -0700 (PDT)
Message-ID: <3a8f1bbb-7430-5bb5-351f-45f46b09db5d@kernel.dk>
Date:   Wed, 28 Sep 2022 11:13:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com>
 <20220927173610.7794-1-joshi.k@samsung.com>
 <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
 <20220928171244.GA16907@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220928171244.GA16907@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/22 11:12 AM, Christoph Hellwig wrote:
> On Wed, Sep 28, 2022 at 08:28:02AM -0600, Jens Axboe wrote:
>> Christoph, are you happy with the changes at this point?
> 
> I'll look at it now.  Too much on my plate for less than 24 hour turn
> around times..

Yeah I know, I believe Kanchan is OOO for a bit from today which is
part of the reason why it got quick respins.

Thanks!

-- 
Jens Axboe


