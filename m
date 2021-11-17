Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA5BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6091860EE4
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhKQP6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhKQP6b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 10:58:31 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59943C061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:55:33 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w15so3278082ill.2
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Ct/WdnHEgJHH8QHvcb/w5m2k+Fmtukz/MihX0JhM98=;
        b=AqDR18QXb2d93ScaXIxLoR2kTmsb0wTcA0fONcFbskLHbrIERtsfFrTJfEYH5NDAm2
         njrvREtSzlsq6NgXOa3OL3EmN7oq9W0Syh7sSVeWEe2OCHKnZ2aOMv8pzxnxHtd3Pss1
         1IOTw92KL/7S5pfiqZXPMBRSatrFVH+vjcLR9I/S4EWQ0L3amkP+kVSseFEfCBC+xOOY
         Fdqsf/C9hzrdJIs3SemTRozgqRB6r0auj77mcGOcSXzEYCnBQGJkaT0vsO80IWrFfZ6Z
         W94HiYCZg+z77WV5qYIRm0F2xnTxv/4B7qZ7YmRDFNuYXs0O1BMOD+K4XzLA+/yJ0D4K
         mHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Ct/WdnHEgJHH8QHvcb/w5m2k+Fmtukz/MihX0JhM98=;
        b=ghZ42wPZCv/MB7cIgE4r5ec1fjjqQGw/5htBeUDHrpu2oLYJIPSpiFvT7SszXDtZTP
         y8XlEs4keEh9yZNf1MBor3SnhK45nchdQCFgwK0ASedPk/q1mC3vA4UTmhuwbQXcV6qz
         4hXiig1A57RXK1hfRI9KZqcFcn8xoIM8cxVIOiP1e/w6UXgP2YZUziDbiuzizlzcgNcq
         dQN6TGcgFk/mKHAnbuwjUWYO+VUigSmcOJKJRrqxfZwliKwJ1E8P2b7qRcvenlLfqRJU
         /E5C0XUmqb9xgTh5C6fPeIJjL6MN/h5wg9n40PjrKI2go2Zw63E4y0rB/m8x3sKHMh2R
         QqZA==
X-Gm-Message-State: AOAM5309bXI7YpsDL/RSBkefk3QYPXkgVG6MJoFK7LmOvXCvLU1WUQne
        7snJF0yARvKin5TICn6T91dLyX5lDHzLPsmN
X-Google-Smtp-Source: ABdhPJzvAXO19d9GRlPVNAKrGO0RcLsSceLuHiCGEmJPF/HBVdQ4EynRCpOPelmOz1TcLigcGHMUjw==
X-Received: by 2002:a05:6e02:604:: with SMTP id t4mr10812420ils.129.1637164532636;
        Wed, 17 Nov 2021 07:55:32 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l2sm123832ils.82.2021.11.17.07.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:55:32 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-5-axboe@kernel.dk> <YZS/tKW/I55Kus+D@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ead0d6b-a976-6a33-3d07-2ad06e159b8c@kernel.dk>
Date:   Wed, 17 Nov 2021 08:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZS/tKW/I55Kus+D@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/21 1:39 AM, Christoph Hellwig wrote:
> On Tue, Nov 16, 2021 at 08:38:07PM -0700, Jens Axboe wrote:
>> This enables the block layer to send us a full plug list of requests
>> that need submitting. The block layer guarantees that they all belong
>> to the same queue, but we do have to check the hardware queue mapping
>> for each request.
>>
>> If errors are encountered, leave them in the passed in list. Then the
>> block layer will handle them individually.
>>
>> This is good for about a 4% improvement in peak performance, taking us
>> from 9.6M to 10M IOPS/core.
> 
> The concept looks sensible, but the loop in nvme_queue_rqs is a complete
> mess to follow. What about something like this (untested) on top?

Let me take a closer look.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 13722cc400c2c..555a7609580c7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -509,21 +509,6 @@ static inline void nvme_copy_cmd(struct nvme_queue *nvmeq,
>  		nvmeq->sq_tail = 0;
>  }
>  
> -/**
> - * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
> - * @nvmeq: The queue to use
> - * @cmd: The command to send
> - * @write_sq: whether to write to the SQ doorbell
> - */
> -static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
> -			    bool write_sq)
> -{
> -	spin_lock(&nvmeq->sq_lock);
> -	nvme_copy_cmd(nvmeq, cmd);
> -	nvme_write_sq_db(nvmeq, write_sq);
> -	spin_unlock(&nvmeq->sq_lock);
> -}

You really don't like helpers? Code generation wise it doesn't matter,
but without this and the copy helper we do end up having some trivial
duplicated code...

-- 
Jens Axboe

