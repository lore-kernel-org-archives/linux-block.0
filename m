Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A8EC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A893D208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Bg2SaTrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A893D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeK1BYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:24:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46395 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeK1BYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 20:24:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so16538971lfc.13
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IVCP6KjXw4SdUwbraedFu0XHwLpTkR+LBKdggOrcVKs=;
        b=Bg2SaTrsDEw+KHgOQyc850or4mspu7N2ECj7kE4F0P4XJgX67Cf/kkHts9jFtQckIO
         duh0lFE+pJ4ng2o53589zA+aPfGz8lIZR7Fj9mA3bfAO8Ibj6Puu4U775RVBAFsgFU7E
         0ObOtfqyAjyg2Nqaf5u40n1FpJtodm6ar8c756peSV0bUSXQN3GlNewel9TCKn3AA8oN
         yjbN0Wu2IrR7X3k5BdUrQH8FFOSN8knRqk/dAiT3xBancd6z2kcXUBvV5OjbntxWKMtj
         rFII2mUuL5JRFzJ+wnBVSZHyzW03HKznjsFDoz3JuPiI1w1MHHVGrZqrTfArK4lZb769
         Z8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IVCP6KjXw4SdUwbraedFu0XHwLpTkR+LBKdggOrcVKs=;
        b=izvqrR8ugfWFm4VdCf52F0HFkJzWnHShQpvs3RWJh8rsCYOCq+CwmLFLNKMhZ9lJ7H
         Lu4jK8/8cgO71K6FmY9qNsZbl4Eto/9z0LggLpdbSC0m5/WppaeEFpUjNukiIwoVxwPq
         sQz+p5MdNp4FlOdBqXUA8IDq+YwlJ80xurJ4AckoTdfYd8p3GQl9eZwv+pAreDaf/t0g
         dly/Hl4/BPcSIx9WTUEm4gLQYji27/jHDUQ6OyBoExkBPOW/4o0FFUlEfzQe1IBkyeft
         XZ9EZMrfbsbTr43uPXRCtQ3ZMcOqcYK5hifhUcxyCwRXE52gYho3ulTsf89n1SDScbSD
         NTOw==
X-Gm-Message-State: AGRZ1gIjmQFHA1K2Uq2YHcDwT7x+sEO7IbvdRycQnuelCsJxcmYqNXBB
        MmiGAYTDJbkHgt8DfNPNl78/xA==
X-Google-Smtp-Source: AJdET5fbmdnN3V+HnExkc3D9LiQ1DcNKht6W7TAdapfNWXsWBbtQlSJYS2kNc+zj10uKEWg3pPSp/Q==
X-Received: by 2002:a19:a86:: with SMTP id 128mr18014259lfk.139.1543328776402;
        Tue, 27 Nov 2018 06:26:16 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id f29sm614699lfa.46.2018.11.27.06.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 06:26:15 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: adjust the position of the lock
To:     javier@cnexlabs.com
Cc:     suhua.tanke@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181127015309.2374-1-suhua.tanke@gmail.com>
 <F75BC3C7-FACE-4C04-A9BE-5A3AA25D3466@cnexlabs.com>
 <a53eb78d-90d3-f84e-a0bf-9acbc32671f4@lightnvm.io>
 <ACAA275B-AC2C-4147-AF88-E250771CA1DD@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <55a08621-53cd-66b0-5b31-ca2bd6b26861@lightnvm.io>
Date:   Tue, 27 Nov 2018 15:26:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ACAA275B-AC2C-4147-AF88-E250771CA1DD@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/2018 03:24 PM, Javier Gonzalez wrote:
> 
>> On 27 Nov 2018, at 15.22, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 11/27/2018 01:57 PM, Javier Gonzalez wrote:
>>>> On 27 Nov 2018, at 02.53, Hua Su <suhua.tanke@gmail.com> wrote:
>>>>
>>>> Add lock protection for list operations.
>>>> Signed-off-by: Hua Su <suhua.tanke@gmail.com>
>>>> ---
>>>> drivers/lightnvm/pblk-core.c | 17 ++++++++++-------
>>>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>>> index 6944aac43b01..e490df217dac 100644
>>>> --- a/drivers/lightnvm/pblk-core.c
>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>> @@ -1286,24 +1286,27 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
>>>>     list_del(&line->list);
>>>>
>>>>     ret = pblk_line_prepare(pblk, line);
>>>> -    if (ret) {
>>>> -        list_add(&line->list, &l_mg->free_list);
>>>> -        spin_unlock(&l_mg->free_lock);
>>>> -        return ret;
>>>> -    }
>>>> -    spin_unlock(&l_mg->free_lock);
>>>> +    if (ret)
>>>> +        goto out;
>>>>
>>>>     ret = pblk_line_alloc_bitmaps(pblk, line);
>>>>     if (ret)
>>>> -        return ret;
>>>> +        goto out;
>>>>
>>>>     if (!pblk_line_init_bb(pblk, line, 0)) {
>>>>         list_add(&line->list, &l_mg->free_list);
>>>> +        spin_unlock(&l_mg->free_lock);
>>>>         return -EINTR;
>>>>     }
>>>> +    spin_unlock(&l_mg->free_lock);
>>>>
>>>>     pblk_rl_free_lines_dec(&pblk->rl, line, true);
>>>>     return 0;
>>>> +
>>>> +out:
>>>> +    list_add(&line->list, &l_mg->free_list);
>>>> +    spin_unlock(&l_mg->free_lock);
>>>> +    return ret;
>>>> }
>>>>
>>>> void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
>>>> --
>>>> 2.19.1
>>> This path is only touched by the recovery path, which is single
>>> threaded, so there is no race condition as is. Also, if recovery fails,
>>> pblk will not create the instance at all. This said, it would be
>>> good to protect the list_add on the pblk_line_init_bb() error path in
>>> case this code is used for some other purpose in the future.
>>
>> I like your explanation here. Another option is that we could add a comment to notify the developer that it safe in this context?
> 
> Sure. Do you want to add it? Or should I send it?
> 
> Javier
> 

Please send it. Thanks!
