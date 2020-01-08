Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E35C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B042070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jdBfmiLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAHCeW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:34:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52833 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:34:21 -0500
Received: by mail-pj1-f68.google.com with SMTP id a6so402920pjh.2
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 18:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+OUK4mONyXnSdEaVe8487QznN+a088R11GlSLXBlRtM=;
        b=jdBfmiLKUEtOZ7VrzKTKq/yPwgjLgbiFoYpZtX41Mwm0mVLQ7d82yaLpsI0GnPTUhd
         7kYIbIrRCM1k93g6mtv7yMXpiYhBOvrxlgGhtSISwWyhIgI6DYtPVzM7bEsF+t5IP13w
         zkwY7MVLccWrkQmqaI1X0LbRxZJsrZ8Tctet8DFj5NGeWWUXJInEV+7poiLB+PMJTLvb
         69R6WwwVqo6hD0qA6+Oh2O6emZxBRKwLJEY7tq4f1EkXvKYpWVU66kCJXpEhNZ+SmfeJ
         cW4IVaenHbPGXxYPjOrlHUjwkrL/Sl1d3jpCkJIIEoY4H/t5wRWfuc0RInO4PkEEcUTr
         8kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+OUK4mONyXnSdEaVe8487QznN+a088R11GlSLXBlRtM=;
        b=VEXtjeYUvhGMqelrNgvBAXLfDyM1E2hv+zOZU6Jr/X1uVMFWcTG4t9ug0IztSHdC4Y
         8UjrPAu0Cmzr+nXbx4zF9M2tX/d02bb+NNwVS5UYpQ/hxGbYjefr1B8qorRRMxTbGWLq
         3FIzrImWjqrWQR7GJPZ4MQETK8Y0y+J7C7w5WTDFUAGtkU1fgDQFmLaztBk/lhDykMIh
         2NkR8OdYaGZoDjsLuAe7pb7zcgE1uq2gBdWIUrQP9eVL9ZpCosD4AeFAWY7ykKBVWA/+
         lhcgt7BiYXiG9zmMd5WaXc+/PgjnBsNMgZWUBvMEbag6AcSmnNkDixH5YEqWrGSrdvtS
         Iytg==
X-Gm-Message-State: APjAAAUOWDGFVIMmooxvq99+j6zfGXunrJXW2oHcdUAO0EmRY6FReBUW
        qhOZXEYY+DU0xmzRao5mC4Y0wg==
X-Google-Smtp-Source: APXvYqzmaOLiqUsuZLzP4ks+V8L2R+A4zKOgH0/nVBAn4xJTKps2gMVetFld4Ic1OXUFqh9EE4qKzA==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr3032535plo.214.1578450861036;
        Tue, 07 Jan 2020 18:34:21 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c15sm921435pja.30.2020.01.07.18.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 18:34:20 -0800 (PST)
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20200108012526.26731-1-ming.lei@redhat.com>
 <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5fa8b59-6685-d914-6163-1d515777300b@kernel.dk>
Date:   Tue, 7 Jan 2020 19:34:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/20 7:06 PM, Damien Le Moal wrote:
> On 2020/01/08 10:25, Ming Lei wrote:
>> Commit 429120f3df2d starts to take account of segment's start dma address
>> when computing max segment size, and data type of 'unsigned long'
>> is used to do that. However, the segment mask may be 0xffffffff, so
>> the figured out segment size may be overflowed because DMA address can
>> be 64bit on 32bit arch.
>>
>> Fixes the issue by using 'unsigned long long' to compute max segment
>> size.
>>
>> Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  block/blk-merge.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 347782a24a35..b0fcc72594cb 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct request_queue *q,
>>  
>>  static inline unsigned get_max_segment_size(const struct request_queue *q,
>>  					    struct page *start_page,
>> -					    unsigned long offset)
>> +					    unsigned long long offset)
>>  {
>>  	unsigned long mask = queue_segment_boundary(q);
>>  
>>  	offset = mask & (page_to_phys(start_page) + offset);
> 
> Shouldn't mask be an unsigned long long too for this to give the
> expected correct result ?

Don't think so, and the seg boundary is a ulong to begin with as well.

-- 
Jens Axboe

