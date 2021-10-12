Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D7C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF10A60F23
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhJLS5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhJLS5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:57:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CFEC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:55:06 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d125so46119iof.5
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y4BkUejWWbxwro8RwlwmcyvYl1DMqukmdPz8gCVTOI8=;
        b=24lRoAlZREVGXzIKCxg83SBFoiK+ocgtZnd9IrA0aoctveCRIhUJUaylCRU84twOZ/
         orY3pZtIynvfxYO11CWOL/Jjdv4QUltZeVyRDpZ/ksuln2HWp8OVRheHHaWdygmTE+Yk
         5+fuIPmWFiIFZFn5A8N4yoq9XrmqoHqxZkGh4khoNURn3xZI5NYIQPtprh1uNiXQHqy+
         0oAa0AyQTfRlWUZ8bvg/t4XvrYUCkqupVoJEku+UCxsU74p1N0D/6fYPtf9S/Mw6c4Ho
         u7/reQpK0m7tACTTy0YFsNOQSDUfE5/AJv930wSKMYAxxUjHKKOGby3TT6WwXJ7TwfyV
         Qf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4BkUejWWbxwro8RwlwmcyvYl1DMqukmdPz8gCVTOI8=;
        b=w8p0aBT7hKv+pqC007fcHiXgra9L2ZVuCRbSQBtALpxeg1Et8vXpe3kP7bqAp/TejS
         cUvxP4zQ+hp604odSE+QrExbEtt4TqGqQY9/f2sSrryk/dr1LIp6We267Nns03GJlvxo
         /g0UDpngFDVDGv1ZnrQCdNtKg/0XY6OCBRFixx8BrqoeHDKRhtv6wsEUMTqC7CV4YWuz
         2vk3Lom5Nn83VSxKrAXyZ6Q+pCsms7GNsS86kpzfF/kuG3t+WrM2pMA4rfQGnUh2SqDt
         Y57thW+tlMVJuDTuaf3fhCOwjtaYGVcbtfqlDeLVQMXSx1Hx9WVV0iNkz2BgWwKqa1UU
         RXnA==
X-Gm-Message-State: AOAM533x3VWR0lS07Cl1uleVwshDZtEqTOmNHZviY7GMPeOPT52w7atJ
        r8ngZW8jUNCF/LR7n3l9QfGSHxw0cug21Q==
X-Google-Smtp-Source: ABdhPJzZhLxyngzQEYi2rL/zns78mL19HXww4EhiUWOzk1fhlx82fMsfk/Ed3d3ZDz4v0yWvYOuwmA==
X-Received: by 2002:a5d:9493:: with SMTP id v19mr24963021ioj.34.1634064905797;
        Tue, 12 Oct 2021 11:55:05 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m2sm2417411ilg.72.2021.10.12.11.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:55:05 -0700 (PDT)
Subject: Re: [PATCH 4/9] block: add support for blk_mq_end_request_batch()
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-5-axboe@kernel.dk>
 <7bba1955-75e9-0146-7556-2e5c50dad7d1@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8efc988-112c-7a65-dd5e-265746f8e568@kernel.dk>
Date:   Tue, 12 Oct 2021 12:55:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7bba1955-75e9-0146-7556-2e5c50dad7d1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 12:32 PM, Bart Van Assche wrote:
> On 10/12/21 11:17 AM, Jens Axboe wrote:
>> +void blk_mq_put_tags(struct blk_mq_tags *tags, int *array, int nr_tags)
>> +{
>> +	sbitmap_queue_clear_batch(&tags->bitmap_tags, tags->nr_reserved_tags,
>> +					array, nr_tags);
>> +}
> 
> How about changing the name of the 'array' argument into 'tag_array' to 
> make it more clear what the argument represents?

Sure, done.

-- 
Jens Axboe

