Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F082FC433F5
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 18:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiEISRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiEISRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 14:17:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374F18073F
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 11:13:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f2so16207372ioh.7
        for <linux-block@vger.kernel.org>; Mon, 09 May 2022 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nbP4UxLudGGNXmlugF8xlwUjdH1zs5seOC29q5oKmlM=;
        b=PybJiJI+d6ApKBe4iSRLaK6vywNjH97JUmHy6z+pDyFUQ52ijVw8IzHkt19i9PfCex
         /CiILaWaKuwS1WOkuZwboqWsSpJtluUcdtf+e3vK32dHeUvErjB6yip3QLAHx4vpT1TC
         ZIVSlvVQoqPXFMA3VgPK0AxnURv2ZcP7jRI9eGIQ/pRztwh/vkHfZSQlsPWN6fLN5E8m
         J3NvcRuxxd+jsPb5WiKXDoRZ6wgXDWwevVTWPfJoXK1xD4NzXej2tv9QO2/JjUqz5P5F
         jKcXf7Dy3dHKtd6cNYyqVBx9obL5nsM1In1c0CvffbEZk7y5sZ5R/kPXPim2HCsT8zx+
         jADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nbP4UxLudGGNXmlugF8xlwUjdH1zs5seOC29q5oKmlM=;
        b=ATYOAGNCtmfep8RV8LDg1PvVHUCzwmK0uwnEQH3Iou16/4hKkrV9C11H0SOZvnSg7U
         KyghwpmLXbr5LzxUWF5VZcrRa/MCznctflLb385oXqaaW+HnyZ/z7fFrkosYDBEPQqvk
         9x6DQPzwZS4pkDNsQuE18bePor1jkCrAqj/vAtqs/7U6ap6pL0UejLXhpYm5P7uFAQTJ
         VcJ0X8QCWsY9y1dHpufJYB4gdILkHAQYdS4EYYFDXaFw57Rg2dm1lnz9yBKTMcv1mVCC
         tc6BIsJm2OBaxQ9agilm9U7lxVq81oP+o9nHO7kL5/vcgXFdBNkOUCSYbso+LDg47/Zv
         sZGg==
X-Gm-Message-State: AOAM532lRDYC9BjZO6F0ca4lU2xxTZHaf+Tt/St2KtdDSgxQ0bAJCRlM
        vdB7/t3Ylstw/4OZTC3yXOx6dA==
X-Google-Smtp-Source: ABdhPJxpiF7pEVwsiiKNfZHLI9HL8Q///9vvlshdKdDVPVDb+qc+pwHj7s9deiXYZWA3j7ytvjkfIA==
X-Received: by 2002:a05:6602:2e82:b0:65a:a33e:6d3f with SMTP id m2-20020a0566022e8200b0065aa33e6d3fmr7341288iow.44.1652120022527;
        Mon, 09 May 2022 11:13:42 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v4-20020a92ab04000000b002cfa97470c1sm980351ilh.21.2022.05.09.11.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 11:13:42 -0700 (PDT)
Message-ID: <14b5e588-3df8-fbdc-d4df-ae9187c18812@kernel.dk>
Date:   Mon, 9 May 2022 12:13:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] ubd: add io_uring based userspace block driver
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220509092312.254354-1-ming.lei@redhat.com>
 <8e3ecd00-1c73-7481-fec2-158528b2798f@infradead.org>
 <87bkw6lgoo.fsf@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87bkw6lgoo.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/22 12:11 PM, Gabriel Krisman Bertazi wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 5/9/22 02:23, Ming Lei wrote:
>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>> index fdb81f2794cd..3893ccd82e8a 100644
>>> --- a/drivers/block/Kconfig
>>> +++ b/drivers/block/Kconfig
>>> @@ -408,6 +408,13 @@ config BLK_DEV_RBD
>>>  
>>>  	  If unsure, say N.
>>>  
>>> +config BLK_DEV_USER_BLK_DRV
>>> +	bool "Userspace block driver"
>>> +	select IO_URING
>>> +	default y
>>
>> Any "default y" driver is highly questionable and needs to be justified.
>>
>> Also: why is it bool instead of tristate?
> 
> I think it's only bool because it depends on task_work_add, which is
> not exported to modules.  It is something to be fixed for sure, can
> that function just be exported?

There might (rightfully) be resistance to doing that, as it's one of
this interfaces that's a bit tricky to use correctly and still have it
be efficient and not introduce dependency loops...

But this is very much RFC and in progress stuff, so I don't really think
we need to pay much attention to that at this point.

-- 
Jens Axboe

