Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD70C32792
	for <linux-block@archiver.kernel.org>; Sat, 20 Aug 2022 15:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbiHTPhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Aug 2022 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbiHTPhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Aug 2022 11:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DC6AA12
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661009864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSUDwEi1svTWS13A5fcvj35eehBaJVIHJlmeSdMUK/M=;
        b=cx1EAOZFIZNVYkUlcg2+QrxMupJaHKVBd/yPygNDCsxdyUQOQ8rd2xcKUTr5CUtAM0yywo
        izedAR11QX9rMSNcAtvRtfYeTWQ4m+/iXwkuRenBVTcuGHxH5rX+OC9lyBAm4aX3PABXha
        DZ+Ue0RpTWsDiR42GwihLzGsm+JewIM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-XuRm_QaKMr6n7YKEl2IZbA-1; Sat, 20 Aug 2022 11:37:43 -0400
X-MC-Unique: XuRm_QaKMr6n7YKEl2IZbA-1
Received: by mail-ed1-f71.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so4457805edd.21
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 08:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CSUDwEi1svTWS13A5fcvj35eehBaJVIHJlmeSdMUK/M=;
        b=EI7nJBH5lD4wj9Yl4LORNOEB2KKyAwJUpBQZZBNYTe13IiZRI4+jbDOybkt375qzTM
         wzkKxfELpiMyy6jqvaZR7Rz36mLeB9JBqnC9wfzvnzvIxBOO3dxRu4ylyw2an+zHrEiA
         Tk0slYViZsu8exZRxaIATAwSaY/EeDJe2etYJQQ8NkzVTQI20Z964cxupY6gBzCzhi9E
         DpG8yDs5zhceOPHeS/LrQ2PvWvghWXUvfBh6K8JoCH5gewGoeZ6J3UTozBMzfLWcW21l
         Xql2kuInnHzkZCZPPxUpANAeN4O6D7bnmm8YS4lczKhbBcuxO2X9sgzImif7b/3pBqjA
         XLfg==
X-Gm-Message-State: ACgBeo2C72cBvby4BSgaFXLmBSLXFZJom/cba0gz1VLKIq/t7siFbm1G
        dBEBfXCKY/bL8KmoOquze1Cwd7nrAmQbDiZNxwOKYrQsoX+VjQVEMCMio5GmzKkyheupuVLNcwH
        kOURLrF2SlQ97OKjBihpv2U8=
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id v21-20020a056402349500b0043dd76ee9ffmr10158396edc.227.1661009862300;
        Sat, 20 Aug 2022 08:37:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56NKhopv/ioAeFb925MKnrc4gMGSU/vLUjnbjCFZdK2VcWWVNy8nDcXS+vYMB17jvhSSMtNQ==
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id v21-20020a056402349500b0043dd76ee9ffmr10158391edc.227.1661009862150;
        Sat, 20 Aug 2022 08:37:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ku7-20020a170907788700b0073d15dfdc09sm2324594ejc.11.2022.08.20.08.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 08:37:41 -0700 (PDT)
Message-ID: <1c4ffc37-df00-0487-2e4e-79b5178d9741@redhat.com>
Date:   Sat, 20 Aug 2022 17:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: 6.0-rc1 regression block (blk_mq) / RCU task stuck errors +
 block-io hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, rcu@vger.kernel.org
References: <dd6844e7-f338-a4e9-2dad-0960e25b2ca1@redhat.com>
 <17ccd5ae-0268-1bee-7822-1352f4c676ba@acm.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <17ccd5ae-0268-1bee-7822-1352f4c676ba@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On 8/19/22 16:49, Bart Van Assche wrote:
> On 8/19/22 05:01, Hans de Goede wrote:
>> I've been dogfooding 6.0-rc1 on my main workstation and I have hit
>> this pretty serious bug, serious enough for me to go back to 5.19
>>
>> My dmesg is showing various blk_mq (RCU?) related lockdep splats
>> followed by some tasks getting stuck on disk-IO. E.g. "sync"
>> is guaranteed to hang, but other tasks too.
>>
>> This seems to be mainly the case on "sd" disks (both sata
>> and USB) where as my main nvme drive seems fine, which has
>> probably saved me from worse issues...
>>
>> Here are 4 task stuck reports from my last boot, where
>> I had to turn off the machine by keeping the power button
>> pressed for 4 seconds.
>>
>> [ ... ]
>>
>> Sorry for not being able to write a better bug-report but I don't have
>> the time to dive into this deeper. I hope this report is enough for
>> someone to have a clue what is going on.
> 
> Thank you for the detailed report. I think this report is detailed enough to root-cause this issue, something that was not possible before this report.
> 
> Please help with verifying whether this patch fixes this issue: "[PATCH] scsi: sd: Revert "Rework asynchronous resume support"" (https://lore.kernel.org/linux-scsi/20220816172638.538734-1-bvanassche@acm.org/).

Thanks that is very useful. I'm running 6.0-rc1 with this
patch added now and so far I've not seen the problem re-occur.

I was also seeing 6.0 suspend/resume issues on 2 laptops with
sata disks (rather then NVME) which I did not yet get around
to collecting logs from / reporting. I'm happy to report that
those suspend/resume issues are also fixed by this.

I'll reply to the patch with my Tested-by for this.

Regards,

Hans

