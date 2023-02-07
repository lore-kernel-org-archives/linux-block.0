Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2EBC61DA4
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 00:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBGA4g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBGA4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 19:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554933449
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675731343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xab6yaqQhUADgjEaX4jCYFge8g71VoEH5wyXFWZGIFs=;
        b=ITAGW7+VQEWw6W0THP6XIOi1sd4wNe0/NNzoJysme/B0SU9Oe0n9n4Jl3AyLbywozmuMiU
        Zi6v724t6X9bqHxybX9NqTZjbJU4b0WxpPX0UhFdU91pZc5dOFk2HGJ8/9AqMh3pzbjeXa
        V45GDQmsAlx9q7Mx2Dr5Qy0PnQq1xjc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-DfdjnKIqOsyTlYf7i8ojlQ-1; Mon, 06 Feb 2023 19:54:51 -0500
X-MC-Unique: DfdjnKIqOsyTlYf7i8ojlQ-1
Received: by mail-pf1-f198.google.com with SMTP id k22-20020a056a00169600b00593939d0601so7213238pfc.5
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 16:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xab6yaqQhUADgjEaX4jCYFge8g71VoEH5wyXFWZGIFs=;
        b=OOjjwZYPmWoQEWIxNMBynV58US3r60A5SJ+Jyz5yB0V6YEZpckX9Yx4gZqxq0kAmVM
         fjBEomm+RNfXdiZMF0JavjKGMZ6/001DdB4Fg9COmZGR1bPOgast0I8hqyD1PIa+sVoc
         o8HU/AmTLL5mDUfANbeX+MisSgcG3ppvDyflz3vTHEApAoYJQcbheYn/CVtpjDQsmu5w
         sTRzXTd0QgynURdUIoZUwrJ8EVqbUtPFp79tJo46MTxh6gotZkbcB+bB4YBO/OVxaxz1
         2z4IxK7z3rPEwESei6mKp+hpT9Axsn0L4Emx5U/Bs2M9Wcf/hXf3nZqBuTpFNP8O42rD
         duQg==
X-Gm-Message-State: AO0yUKVItOCIHMqhLtK+sSI2JI0W8+V1bjljGRMycthy4JxMSv/d7Wzr
        ydmHyebCiwJs3VCulvteDjatap1hcfdfoo/dpHhSNP1XStymzv+/2wm7TKEIqf9OYpqRfNTnllb
        /4KVYX7S0bSFgbWZySqwqBE8=
X-Received: by 2002:a17:90b:3511:b0:230:c41b:4d8d with SMTP id ls17-20020a17090b351100b00230c41b4d8dmr1277629pjb.16.1675731277434;
        Mon, 06 Feb 2023 16:54:37 -0800 (PST)
X-Google-Smtp-Source: AK7set8P3gWmrKE1AVwAcDsBacpeQIPvSoZcpc/5nSGEQJpN+YN5XOiP3VJ8Bhg1KzRCJ4TedcxS2w==
X-Received: by 2002:a17:90b:3511:b0:230:c41b:4d8d with SMTP id ls17-20020a17090b351100b00230c41b4d8dmr1277616pjb.16.1675731277089;
        Mon, 06 Feb 2023 16:54:37 -0800 (PST)
Received: from [10.72.13.183] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004da5d3a8023sm6671549pgf.79.2023.02.06.16.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 16:54:36 -0800 (PST)
Message-ID: <06f51bab-42e1-975a-ad4f-6815c2063adb@redhat.com>
Date:   Tue, 7 Feb 2023 08:54:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] rbd: avoid double free memory on error path in
 rbd_dev_create()
Content-Language: en-US
To:     =?UTF-8?B?0J/QtdGC0YDQvtCy0LAg0J3QsNGC0LDQu9C40Y8g0JzQuNGF0LDQudC70L4=?=
         =?UTF-8?B?0LLQvdCw?= <n.petrova@fintech.ru>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20230203141515.125205-1-n.petrova@fintech.ru>
 <CAOi1vP_7Oaw8O-p2X1xymzym1Xf_RZeN0u=SeE4Zbc2y+AfgYA@mail.gmail.com>
 <c01e807428894bef8fed628df0b8f4b6@fintech.ru>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <c01e807428894bef8fed628df0b8f4b6@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 06/02/2023 23:15, Петрова Наталия Михайловна wrote:
> Hi Ilya!
> Thanks for your response! I don't quite understand your idea and suggestion. The patch is designed to avoid double free memory. I explored the code again and suppose there is another situation for rbd_dev->rbd_client and rbd_dev->spec. Free memory of these pointers is possible only once in rbd_dev_free() function. In do_rbd_add() deallocation memory is only for rbd_opts: drivers/block/rbd.c 7157.

Hi Петрова,

If the rbd_dev_create() fails, for spec it will be freed in 
rbd_dev_create()->rbd_spec_put() first and then in do_rbd_add() it will 
call rbd_spec_put() again.

It won't trigger double free but this should generate a warning when the 
refcount underflow, because the refcount_dec_and_test() will warn and 
then return false when underflow happens.

The same for rbd_client.

Thanks,

- Xiubo

> Correct me if I'm wrong.
>
> Thanks,
> Natalia
>
> -----Original Message-----
> From: Ilya Dryomov <idryomov@gmail.com>
> Sent: Monday, February 6, 2023 2:59 PM
> To: Петрова Наталия Михайловна <n.petrova@fintech.ru>
> Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>; Jens Axboe <axboe@kernel.dk>; ceph-devel@vger.kernel.org; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-project@linuxtesting.org; Alexey Khoroshilov <khoroshilov@ispras.ru>
> Subject: Re: [PATCH] rbd: avoid double free memory on error path in rbd_dev_create()
>
> On Fri, Feb 3, 2023 at 3:15 PM Natalia Petrova <n.petrova@fintech.ru> wrote:
>> If rbd_dev_create() fails after assignment 'opts' to 'rbd_dev->opts',
>> double free of 'rbd_options' happens:
>> one is in rbd_dev_free() and another one is in do_rbd_add().
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
>> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>>   drivers/block/rbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c index
>> 04453f4a319c..ab6bfc352cde 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -5357,7 +5357,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>>          if (!rbd_dev)
>>                  return NULL;
>>
>> -       rbd_dev->opts = opts;
>>
>>          /* get an id and fill in device name */
>>          rbd_dev->dev_id = ida_simple_get(&rbd_dev_id_ida, 0, @@
>> -5372,6 +5371,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>>          if (!rbd_dev->task_wq)
>>                  goto fail_dev_id;
>>
>> +       rbd_dev->opts = opts;
>>          /* we have a ref from do_rbd_add() */
>>          __module_get(THIS_MODULE);
>>
>> --
>> 2.34.1
>>
> Hi Natalia,
>
> It seems like a similar issue is affecting rbd_dev->rbd_client and rbd_dev->spec.  Unlike rbd_dev->opts, they are ref-counted and I'm guessing that the verification tool doesn't go that deep.
>
> I'd prefer all three to be addressed in the same change, since it's the same error path.  Would you be willing to look into that and post a new revision or should I treat just this patch as a bug report?
>
> Thanks,
>
>                  Ilya

-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

