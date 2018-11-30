Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A6C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536E520834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vz++wDH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536E520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLAE1w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:27:52 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34868 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAE1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:27:51 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so10367827itp.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KNxllN2l7Hf7xaBvctnzZJilxGfYRv18G41irQZZZ54=;
        b=vz++wDH1Ft0X20ShpMMurTVg7YDax3fryMOFQaogW8uCuzTdiOVI0vK7/Scs4Nz17B
         sGe1TjhVsNGJ2wJxLxRs59JdCoE/ujf/uU3g1QnqCKh5AgQ5bYILzenTYRiA4PWOw/zL
         LdorDrMqhijKhwEgtNs+Vw48Zf6yJDTEYd0PuAOicQln9q3ztU91EQjy2zdDf09Uy9yc
         2/rtSK+5VVv/FQVkwqpzCL3QvGiPXa/Nw2/Mc9a7ajQk15dcYcjC056DH/gwL4LInP7o
         bfOyYl2jJwXnO+OIvONbjl7kdT/pV+SnnlKtlUzmLkLIMwyhgaxTbP8zs1xZW/pPxlZ8
         aVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KNxllN2l7Hf7xaBvctnzZJilxGfYRv18G41irQZZZ54=;
        b=R5UoVqQk/dQnLM0YRr9U0eVhxpGzSuMJHOXV1CHyTHqUfQv7oEd0VAqg7yIazTii95
         qaRrnKHc+YFDE9tnkV9+sFPQwWzu1pYRiNLG+KE5ODBrWzx63aPr830w6Lq9F4DQg+me
         0Uint3xGf13edkxV/khsmSo+x5ZfDEd9IYkV5qAumvkNwMcmIUzQUI72CQDStiWsmTKJ
         O0CsVjqZO7UsprT+2WUly2L99cem9f6eWKHTdL1GThESEnEGYfgKuSLhT4j2XOGuxNWl
         iUpJE/G50Hzj/7Rlp1GWC6ziQmPhorkRuRnUnCBNQ6M9PDfj3c0aF2nfmfscCORp57Qs
         dvlw==
X-Gm-Message-State: AA+aEWbI+5At7CDmFqkd7MJy8yTaKbe9tw2VrE+r3YdUAs7VZUg/w1q0
        6HcLoJJOop7O5dglgKW9VbNfFg==
X-Google-Smtp-Source: AFSGD/W9hfbLI9eL5DQ8RBz0grudz0WEMg/um6MibxAxvd6MX2YJE/nMahWi2bmtxFAJMgUjFRi6zQ==
X-Received: by 2002:a24:3842:: with SMTP id b63mr6710688ita.19.1543598272537;
        Fri, 30 Nov 2018 09:17:52 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w124-v6sm1525075ita.0.2018.11.30.09.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:17:50 -0800 (PST)
Subject: Re: [PATCH 05/27] block: ensure that async polled IO is marked
 REQ_NOWAIT
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-6-axboe@kernel.dk> <1543597960.4347.3.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6044f9e1-0175-823b-b923-998094bdca72@kernel.dk>
Date:   Fri, 30 Nov 2018 10:17:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543597960.4347.3.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 10:12 AM, Bart Van Assche wrote:
> On Fri, 2018-11-30 at 09:56 -0700, Jens Axboe wrote:
>> We can't wait for polled events to complete, as they may require active
>> polling from whoever submitted it. If that is the same task that is
>> submitting new IO, we could deadlock waiting for IO to complete that
>> this task is supposed to be completing itself.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 6de8d35f6e41..ebc3d5a0f424 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -402,8 +402,16 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>  
>>  		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>>  		if (!nr_pages) {
>> -			if (iocb->ki_flags & IOCB_HIPRI)
>> +			if (iocb->ki_flags & IOCB_HIPRI) {
>>  				bio->bi_opf |= REQ_HIPRI;
>> +				/*
>> +				 * For async polled IO, we can't wait for
>> +				 * requests to complete, as they may also be
>> +				 * polled and require active reaping.
>> +				 */
>> +				if (!is_sync)
>> +					bio->bi_opf |= REQ_NOWAIT;
>> +			}
>>  
>>  			qc = submit_bio(bio);
>>  			WRITE_ONCE(iocb->ki_cookie, qc);
> 
> Setting REQ_NOWAIT from inside the block layer will make the code that
> submits requests harder to review. Have you considered to make this code
> fail I/O if REQ_NOWAIT has not been set and to require that the context
> that submits I/O sets REQ_NOWAIT?

It's technically still feasible to do for sync polled IO, it's only
the async case that makes it a potential deadlock.

-- 
Jens Axboe

