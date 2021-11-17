Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76671C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CEC61B1B
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhKQQBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhKQQBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 11:01:12 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B11C061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:58:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e144so3825618iof.3
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyKxEDS1lFPcrJBEjl8gqi5xe+K9i22fJm4o+Q6TIEs=;
        b=sAj+J0fCJpQRDOp1vGMuHVA9s5f1sKVwwUhlJKD+t8lIDxU+oQVet57att6O72CHze
         E7DqZKPUdYwzWIIWEnabC1pB9MUyxS3ABGxZA20JaFCY37VHgPSj4wCYxyX3yJwol6Nw
         5MVje+H7rNmJRtigmfaI5kkCse5RBZU+WpOvLqtMON0OD1fkJvHBWs7cPP2BWiIhYlc5
         lAB+JuYA3jhQc8BfIKd4XKOKiritkCWEX5ZCQehY322zPr1XOe2KK3tBx/M+3a9j70tz
         2ZkVpxnx3DTTBzWBjJFckBkhNcWRy6ePXV35cTB4VQ+e2+mKuLqi+hKJcmaeiNU5R1a1
         Xi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyKxEDS1lFPcrJBEjl8gqi5xe+K9i22fJm4o+Q6TIEs=;
        b=qYrU59k1Sh9KPX6dxhOZa84Pw33VTAF1KjQ3JaRd1Vj3f4A/yqr1LPPaSKun+7TB+J
         D0xpzdwgd08YqZ6ihVxX8Pa3cau46eZnJzy2zBhV5ufQkk8QN/G7MwCc+lInvfnU4/m6
         9yHHtklgzgCjcL1gEm/kT7ut+Bj5zqPV7zumIa5z/bEYzXOY0GUH61V09l7bNOm8xgYs
         Df8TfccLerom1u5oqCnvsG221JLPYAWSv3u9l7z5Pg8if/wiHyvhSn/DeEnLEBv9d4Yl
         jWh3FrznlR9EAuN968BLgg1o8sbHSH8hlsZr+3nY8cM0XxlSrH0h05Qxe0ujABNHB0bX
         ZCKg==
X-Gm-Message-State: AOAM5315mdLvhg6v2BfpiZEyeWAUL9foKD1f+lXIC2KmGBRF2C44arRj
        mKu4oghA0GMH6KbVGIjmIU2tvmEqSklguOKZ
X-Google-Smtp-Source: ABdhPJxwmceYJYHPOamhOhLHo4lapc1rlmPE//fkkxMevEKuC1BnTPDRYKLaJ3EQWqUPt2d9m+4fWQ==
X-Received: by 2002:a05:6638:3795:: with SMTP id w21mr14111682jal.73.1637164692858;
        Wed, 17 Nov 2021 07:58:12 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g11sm148514ioo.3.2021.11.17.07.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:58:12 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-5-axboe@kernel.dk> <YZS/tKW/I55Kus+D@infradead.org>
 <7ead0d6b-a976-6a33-3d07-2ad06e159b8c@kernel.dk>
Message-ID: <08281fdd-8b45-b762-94e6-7c29cabbb2eb@kernel.dk>
Date:   Wed, 17 Nov 2021 08:58:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7ead0d6b-a976-6a33-3d07-2ad06e159b8c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/21 8:55 AM, Jens Axboe wrote:
> On 11/17/21 1:39 AM, Christoph Hellwig wrote:
>> On Tue, Nov 16, 2021 at 08:38:07PM -0700, Jens Axboe wrote:
>>> This enables the block layer to send us a full plug list of requests
>>> that need submitting. The block layer guarantees that they all belong
>>> to the same queue, but we do have to check the hardware queue mapping
>>> for each request.
>>>
>>> If errors are encountered, leave them in the passed in list. Then the
>>> block layer will handle them individually.
>>>
>>> This is good for about a 4% improvement in peak performance, taking us
>>> from 9.6M to 10M IOPS/core.
>>
>> The concept looks sensible, but the loop in nvme_queue_rqs is a complete
>> mess to follow. What about something like this (untested) on top?
> 
> Let me take a closer look.

Something changed, efficiency is way down:

     2.26%     +4.34%  [nvme]            [k] nvme_queue_rqs


-- 
Jens Axboe

