Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A54C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB55561056
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhJNPpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhJNPpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:45:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F4C061753
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:43:16 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h10so3991638ilq.3
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n99f58iIiq54ZW95wbCfDJfvvdzSuzodM4C7Udbf0RU=;
        b=udHTP5c2aYaZk31cesxKhvHBzXjIsfXI5KCthU1mALNsLc9EBOG7Ge6jovWngysTis
         R2hyRpx8Pd2ndoYxvki+5Bc/LwM86SrEwX2Q/VoaHs1/GaCY8Qn0TvoX1KsO6E0mAYBd
         BiL5GNIeym+g13ZfuEJEow4h4/g5uaZbqD42MtjHeot8Ocx91QNtfGwEuLEo/0Spd9Sg
         pAOAV1RGKE1lzHIhZmZQvu0mGLEFfuCrkUQuckqB05k/2wLc0FjbQpCqkZZEGpKQWSvP
         3V73liaomUzao4tEwE2JP+uh7UpqqCwhgvrxrFvmDvqOMbBfdw6YKgT1euNkb3spC28o
         TECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n99f58iIiq54ZW95wbCfDJfvvdzSuzodM4C7Udbf0RU=;
        b=5B0zXTmeBu4//HnlwL9ecLmBqfn8LQtgFOFfSvWsGizhpqJzwrPpHXHX+pXArd9x47
         nSS+AeRPxusT6EPmx/lXGsaYIN3yO9lfApKeEqjRQ24Pu/ZsI6xOb5yo1gNvnMIAwDqr
         V+ebI6EgAfEdn2S8AmT/+jn7TLB55pNnQ0gDumJoe5QxTD9ph3Kir16NJV1rIeXgZvDT
         H/e+aeGg9siCLFaYa9AgL0ZKg02vVPHq950yhFM+kKR8ZaRi8oTfqUL1EwZUT9POctye
         SRGLQLV6w2pLz4+rRNLiORUZRut8U/TC/XEehIqUYgrchp6Q7EUVAZtK2ZYPSvBaU7wc
         zyjQ==
X-Gm-Message-State: AOAM532I/NZpgqQ1vVNAHHe+e2JicUXgaq+cSo8cQtUNN4P/ahjSPuoP
        J/+xy3mLsvrIgs3XkbClHSGLpCkJEqge1A==
X-Google-Smtp-Source: ABdhPJyqCtNPp6AdbN2qdAPfz4FJlJ7GMOogGC9uZsykZ/G8qr83Vblt2q/hrhMgF7TdCW+N59r38A==
X-Received: by 2002:a05:6e02:1c05:: with SMTP id l5mr3026421ilh.7.1634226196113;
        Thu, 14 Oct 2021 08:43:16 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j3sm1511588ilu.15.2021.10.14.08.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:43:15 -0700 (PDT)
Subject: Re: [PATCH 7/9] block: assign batch completion handler in blk_poll()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-8-axboe@kernel.dk> <YWfgzYEEjfPKupJL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c609f3e-b727-2ede-b578-0be2394a484f@kernel.dk>
Date:   Thu, 14 Oct 2021 09:43:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWfgzYEEjfPKupJL@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 1:48 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:54:14AM -0600, Jens Axboe wrote:
>> If an io_batch is passed in to blk_poll(), we need to assign the batch
>> handler associated with this queue. This allows callers to complete
>> an io_batch handler on by calling it.
> 
> blk_poll() is gone now :)
> 
>> +	if (iob) {
>> +		iob->complete = q->mq_ops->complete_batch;
>> +		if (!iob->complete) {
>> +			WARN_ON_ONCE(iob->req_list);
>> +			iob = NULL;
>> +		}
>> +	}
> 
> Assigning first and checking later looks a little strange, even if it
> makes no actual difference.  Why not:
> 
> 	if (iob && q->mq_ops->complete_batch)
> 	 	iob->complete = q->mq_ops->complete_batch;
> 	else
> 		iob = NULL;

Done.

> Also I'd expect this patch in the series right after the other block
> patches.

Moved.

-- 
Jens Axboe

