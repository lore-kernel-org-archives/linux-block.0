Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACC861053
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhJNPdE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJNPdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:33:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74FC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:30:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r134so4230283iod.11
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VX1lbw/foGB8B+c2uDiAVB0hUG02xY/RB1A+NxJSlHU=;
        b=Wpvk2ewrwI4z0Bl/5v6ZKufBQcJMnWIZNOUN2HyOgwldoMixA67irki/BPM7kuomHL
         UmPxeWxBJ1PdnNYvdf+a+R2AMX1ym3UHvfaVwaZgXn7UyTPXORY+hlU4tellxCCjmwPQ
         rXHlPcDrF/znUke+NmiBRv5ubqshuct0/tNkZA4DLEbXK4Kkp6VTnpELhDg7uQ9+9IWK
         C++o3ZodQnOGcHqOzLQYkid97dOuPl822PQ/Cey1YlASwh70VCFrBOXPjj+OUcyTBzgU
         z/D0aqEsvvJfjSq8EeUx4cwcTPKVzRuPsGpwptXLtboofNQ3M5w1i0mIrbkjNwz+zHMY
         p7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VX1lbw/foGB8B+c2uDiAVB0hUG02xY/RB1A+NxJSlHU=;
        b=uO6xEdD9MeORrKqiJA/F46EfiRMJei3R5co2Sz+ikiSU8EZnei4kTSsVjao7nbpXfJ
         6gFhW9R9UM4ehLvm80jg/t49TOn9BBM+sl8OWc8b+2VPQ5DhCI0iTWjJezm2L3/moSoM
         MLlZtfQBeEZVzYJqYitlnEUT4hoM2nkP8d13mVk9sWhdb/zLfaFV/uOjTZMXESx7D9bC
         NOuZvXZEOKUueydAQHf/bj7BwAlG99P/RLd6DBfWFVw8WtcVefbiL8pFlzGFgBYiGCoj
         Biaif9G9AaCsG1/fHqTQuogSJxiKmxwTEqJDLBgy+nbgA/qEKFWMBd3UXSEsRaBlRKsm
         lXeA==
X-Gm-Message-State: AOAM532Ue2RnHzVYVLgTrCy9FN1VQTIK6ds33fFElH+rLJwg7XBy3z7K
        7ChNcNm2VYfus0I5F8ePoYGoEwtdLBWFVQ==
X-Google-Smtp-Source: ABdhPJzB8+roeuKEkT6kurPnQwmWN882qbXEDXKDo4RoAjebkbJ9BjDt2C6Ydz1zHCOZzu0g4DYYoA==
X-Received: by 2002:a05:6602:3c5:: with SMTP id g5mr3103172iov.42.1634225457826;
        Thu, 14 Oct 2021 08:30:57 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d4sm1555899ilv.3.2021.10.14.08.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:30:57 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-7-axboe@kernel.dk> <YWffkZ2w/mhcJIAU@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f42b215e-0126-d2c1-2548-b58aaf3cbb84@kernel.dk>
Date:   Thu, 14 Oct 2021 09:30:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWffkZ2w/mhcJIAU@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 1:43 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:54:13AM -0600, Jens Axboe wrote:
>> +void nvme_complete_batch_req(struct request *req)
>> +{
>> +	nvme_cleanup_cmd(req);
>> +	nvme_end_req_zoned(req);
>> +	req->status = BLK_STS_OK;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
>> +
> 
> I'd be tempted to just merge this helper into the only caller.
> nvme_cleanup_cmd is exported anyway, so this would just add an export
> for nvme_end_req_zoned.

Sure, I can do that.

>> +static __always_inline void nvme_complete_batch(struct io_batch *iob,
>> +						void (*fn)(struct request *rq))
>> +{
>> +	struct request *req;
>> +
>> +	req = rq_list_peek(&iob->req_list);
>> +	while (req) {
>> +		fn(req);
>> +		nvme_complete_batch_req(req);
>> +		req = rq_list_next(req);
>> +	}
>> +
>> +	blk_mq_end_request_batch(iob);
> 
> Can we turn this into a normal for loop?
> 
> 	for (req = rq_list_peek(&iob->req_list); req; req = rq_list_next(req)) {
> 		..
> 	}

If you prefer it that way for nvme, for me the while () setup is much
easier to read than a really long for line.

>> +	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
>> +		/*
>> +		 * Do normal inline completion if we don't have a batch
>> +		 * list, if we have an end_io handler, or if the status of
>> +		 * the request isn't just normal success.
>> +		 */
>> +		if (!iob || req->end_io || nvme_req(req)->status)
>> +			nvme_pci_complete_rq(req);
>> +		else
>> +			rq_list_add_tail(&iob->req_list, req);
>> +	}
> 
> The check for the conditions where we can or cannot batch complete
> really should go into a block layer helper.  Something like the
> incremental patch below:

That's a good idea, I'll add that.

-- 
Jens Axboe

