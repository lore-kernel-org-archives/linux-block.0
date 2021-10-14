Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58329C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F6660E8B
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhJNP3u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJNP3t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:29:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C9C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:27:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n7so4305148iod.0
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lGWBAwIH2KpeqDBNhTQLENnmemTVlaNlNZfgPLpBcmM=;
        b=8JknfybjNOHfCPNKcbmTEshJ1atbgImt6YLCZvMSzs5q4wkT4vk+LQ4+EbcWhvgUr/
         bRWXKGpX5nAPUXRXazks59rOIunENQjnICs/Tqoef8QXdb3K9VlNndFTAbs/T0jZCksw
         2FcBe0yGZNqmfNjAqBeL7R2bpscqJxxo/i/J+kR9TCG9PJLOdaJPwL5muld6aeVC87PB
         r40AW+83gqoajz6AbjWRoiQtbKlp16tj63AVTEc0t/SAQKj+FnGEqyLXCG97TJj1ZIZ3
         5v3ix06eIPlH9U1d+oIcRA58QXd33SLEfU2e/wHGdPa6jtSdEdbjCiWgESlMToH3GkLU
         6CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGWBAwIH2KpeqDBNhTQLENnmemTVlaNlNZfgPLpBcmM=;
        b=RK4727ItORLSofWaz8SiK1Jfc0xFwSH3wa7BGGsFW02RIVRpOyopBkyh5CgixQgknF
         uusuaQcKmFg68LtDaWKkePF/zvJSyQ2FQZHYuhFmfnTMy2UKlHUgld7NvFPUM3rdphEE
         FPICZHAZKinFll11Nbg18kkBETzUQ4xOg5f52EizhqYhQ042xidN5SbEjl1NU6r/2pCK
         oAsc3WgPMxy4po2C2e+tNvxwj/A4e0hb5Cvoq0aTHMA4iUD8mKKNchVyA8WbWyFJidlm
         LFTMxbQWvC76DEEE614MQwBH3tYJB7gRyXWEJCWiu3S//XwicheNnJZPsnHSghzT4hwr
         OdcA==
X-Gm-Message-State: AOAM533O1Ts1LlNTN1E7eq6tgYn3PT4e5vl2W2iuCOJqxlyl1uxxG6ls
        FXqpFP5OFMQjp1NPsP+LH5c1KxozuoLjqw==
X-Google-Smtp-Source: ABdhPJx0iv/XLY5iQTCpQx/ttbmXg/n7x2bDiW8yPsnwZJb2gnXsi4dxq+SY0IS//jgPY38JYtYohw==
X-Received: by 2002:a05:6602:2ac8:: with SMTP id m8mr3077749iov.112.1634225263780;
        Thu, 14 Oct 2021 08:27:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j3sm1494599ilu.15.2021.10.14.08.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:27:43 -0700 (PDT)
Subject: Re: [PATCH 5/9] block: add support for blk_mq_end_request_batch()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-6-axboe@kernel.dk> <YWfdEPSIVmTzht/1@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59841e78-fc15-8ee9-ecba-519a43570081@kernel.dk>
Date:   Thu, 14 Oct 2021 09:27:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWfdEPSIVmTzht/1@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 1:32 AM, Christoph Hellwig wrote:
>> +void blk_mq_end_request_batch(struct io_batch *iob)
>> +{
>> +	int tags[TAG_COMP_BATCH], nr_tags = 0, acct_tags = 0;
>> +	struct blk_mq_hw_ctx *last_hctx = NULL;
>> +	struct request *rq;
>> +	u64 now = 0;
>> +
>> +	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
>> +		if (!now && blk_mq_need_time_stamp(rq))
>> +			now = ktime_get_ns();
>> +		blk_update_request(rq, rq->status, blk_rq_bytes(rq));
>> +		__blk_mq_end_request_acct(rq, rq->status, now);
>> +
>> +		if (rq->q->elevator) {
>> +			blk_mq_free_request(rq);
>> +			continue;
>> +		}
> 
> So why do we even bother adding requests with an elevator to the batch
> list?  

You still get the benefit of amortized time keeping, and it's more
efficient to complete in batches rather than one-at-the-time. It's just
not as good as the non-elevator path.

>> +	/*
>> +	 * csd is used for remote completions, fifo_time at scheduler time.
>> +	 * They are mutually exclusive. result is used at completion time
>> +	 * like csd, but for batched IO. Batched IO does not use IPI
>> +	 * completions.
>> +	 */
>>  	union {
>>  		struct __call_single_data csd;
>>  		u64 fifo_time;
>> +		blk_status_t status;
>>  	};
> 
> The ->status field isn't needed any more now that error completions
> aren't batched.

Killed.

-- 
Jens Axboe

