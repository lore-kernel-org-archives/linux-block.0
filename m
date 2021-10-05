Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E349C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327F76121F
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJERMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhJERMf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 13:12:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9DC061749
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 10:10:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h1so157562ila.1
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AkJLClJJ5bauorxHEoDKg0TJm7AU7dkaRYlW5L/xmtQ=;
        b=BtMP0popbuIQatUxMSdYf8Ce4TOYJ7vhdCkfglgZDlNn1F+ae5QX5+UIJPRG/vR9GI
         J5RAGjulU0t/mtWGUNoT1/PGltZb3+W2zLng9a6yfDpMElPjUyEQ8z8Vw4FIasLcVv54
         iQ9SvADHSOtudLGPEoO1YSU4eDkrCRrJ5d3cfcEjHOFhpoSEG7745PWCVSymLbsTEatC
         PBIdL59LewBqR7Zck63uf2sNAqmKgqxPOmn5zGRt5D1K8MsNDV6yJFqiu2fXsqFT+Oes
         NUs6/y6cHj2iqMjjaVHZDHmDnOBdbFxpYEFyoqr1B7ScgVmKgh0HRLsEEXheAHOGZU0W
         M6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AkJLClJJ5bauorxHEoDKg0TJm7AU7dkaRYlW5L/xmtQ=;
        b=MS0r716UogAQLkKMKiDGSCtsnrvFND54fxMxxIZFetxQiDebiTXFw7HSQFtueC7nai
         e2jk8v43qGTd64EAsktWKJzTnccafUXDFdLcYO/VZQn0/gs4nUqCkFoc2fPGzXOIZSwV
         ft+Gj5YzYCMYa323+zrQuLeHyuJTLgNJLQmg2assFOhFKMoTjbgxtuz16UTgljEsbJ6R
         VJ6PqkuN5ScHeywvkMj4r/s7LVmgBwe9PfQVP/ptvtf9qfoUvxfmnNg62gCBBZwBvdU3
         Qnsr0IxVvau4lNNFP2o8fRu8mfYcI7YSDVUBjhss8QTJQI6d3HZuj3f6F+bRSR6OuuPB
         H8mA==
X-Gm-Message-State: AOAM531sTXdAQ7drwiuaUNiTM5R5vbSytybB1d+cywPmkIOBN7iqUloS
        ejsO52e9uNtkffaCUc6zq43tkBgP6PX9+mMV/EM=
X-Google-Smtp-Source: ABdhPJyfFqBtouSzpzmGsLyYj/fP2qVo9W6Z1jsfk5vzE8e++yPnsNEJsq1GDrv5nEihENxKCJijPA==
X-Received: by 2002:a05:6e02:d8c:: with SMTP id i12mr3578116ilj.190.1633453843655;
        Tue, 05 Oct 2021 10:10:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l1sm11300985ilc.65.2021.10.05.10.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:10:43 -0700 (PDT)
Subject: Re: [PATCH] block: don't call should_fail_request() for
 !CONFIG_FAIL_MAKE_REQUEST
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <50093280-104b-545a-c4c9-2fc3efd45520@kernel.dk>
 <69b72109-a488-e0c2-3f8a-0fff917e66dd@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ed8898b-0776-fb58-2003-aefe9875a746@kernel.dk>
Date:   Tue, 5 Oct 2021 11:10:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <69b72109-a488-e0c2-3f8a-0fff917e66dd@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/21 11:04 AM, Bart Van Assche wrote:
> On 10/5/21 8:32 AM, Jens Axboe wrote:
>> Unnecessary function call, if we don't have that specific configuration
>> option enabled.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 5454db2fa263..a267f11f55cb 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -697,8 +697,10 @@ static inline bool bio_check_ro(struct bio *bio)
>>   
>>   static noinline int should_fail_bio(struct bio *bio)
>>   {
>> +#ifdef CONFIG_FAIL_MAKE_REQUEST
>>   	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
>>   		return -EIO;
>> +#endif
>>   	return 0;
>>   }
>>   ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
> 
> Has the performance impact of this patch been measured? I'm asking because I
> found the following in blk-core.c:
> 
> #ifdef CONFIG_FAIL_MAKE_REQUEST
> [ ... ]
> #else /* CONFIG_FAIL_MAKE_REQUEST */
> static inline bool should_fail_request(struct block_device *part,
> 					unsigned int bytes)
> {
> 	return false;
> }
> #endif /* CONFIG_FAIL_MAKE_REQUEST */

True, might be a leftover from some other experimentation. Looks like we
can just ignore that patch.

-- 
Jens Axboe

