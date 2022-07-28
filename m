Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EDCC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 11:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiG1LsZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiG1LsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 07:48:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DA051438
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 04:48:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf4so2727578ejc.3
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A5fKjup9D9rQoedBX3MyI9bu3Baa4R81SgHdnVlxBf8=;
        b=RPZJh7msHO3x8tbdGa49j5gKnZOjZIZsBFOaFHM6rf44kVcS31dm7qlST8ogVzBXDj
         xDXxC014RLQvO59jzHgPbZpYNAhWPGjLNpZzSfblR05OgFO7Cm2gSVkuZKGZm3pnH+A+
         yGV61qd8jkHNRDpdg10Qcbe4pOqzBg+7xEK8+ZP2HJqa9pQ8MZmWZ0XthAyFDWoUg5+I
         G2oqRT69xcjgy+Ict/bWGN2V4FSG1JBtZjsX3ZY4ncocFhKLfXZM1bChx6QYKnXzLbNQ
         VZUDKGsJuFusP2yPpDUTDlqQzlkFiesgHr4H/lnBlYaHKSus+QW/ba6K9xm8OO4WxYsQ
         ctgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A5fKjup9D9rQoedBX3MyI9bu3Baa4R81SgHdnVlxBf8=;
        b=qIUBW1zOBB5FIjgoQRu05r6vyNCexK25jEh7n3ccL3eZ/znnrGa8CUwkDSVCQ658Gk
         YmMsnFd2uoy7Y5P673AwXYfaE+fMNaC4GxiSuxM7+H6tdyDrSeX5JSUYM9Wp8qqTKF13
         SAU32FrlxEF0ff4EpnwcX/cWPc7ZWef1x72E/hM7kry0+X/VPhrJX9SdHcFXWYrfOHp6
         1T4usPb5uuMbcEbwRPGr+d0nry5/GTqZZFRqWr/n2/i01ftz+/oaAHI2eEVbSNBphSHR
         PouUas13BHw1QLbfJvayL9sSIOKJCkMw3c0X+QEfCFC7cbpnMFz/AaWS3S5bkIfpVX0j
         AObA==
X-Gm-Message-State: AJIora+vpKDu+dW30jBeFo5Pi5a6LY35w/b37o5/dWB85HZAlESpUnpR
        eyt+6Y68kn0Ci9v7LEUywzk=
X-Google-Smtp-Source: AGRyM1tj7z88KH5dFtTdFlQ1rGw7wm/oN5/+DeUSh2mfWxpSOUu6Ian0t6j/f6gU1KgznoMrqCI9vg==
X-Received: by 2002:a17:906:974d:b0:72f:2835:f664 with SMTP id o13-20020a170906974d00b0072f2835f664mr21704859ejy.543.1659008902110;
        Thu, 28 Jul 2022 04:48:22 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c51a000000b0043bba5ed21csm554839edq.15.2022.07.28.04.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 04:48:21 -0700 (PDT)
Message-ID: <96e8cda9-4675-fe91-8da2-e9b5d946cf8c@gmail.com>
Date:   Thu, 28 Jul 2022 13:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Errors in log with WRITE_ZEROES over loop on NFS
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Ondrej Kozina <okozina@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <975ea807-667d-3ef3-b3e2-26b22ea74029@gmail.com>
 <c1455cb9-44e0-7add-58ac-d63876a22cd9@nvidia.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <c1455cb9-44e0-7add-58ac-d63876a22cd9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/07/2022 23:37, Chaitanya Kulkarni wrote:
> On 7/27/22 06:01, Milan Broz wrote:
>> Hi,
>>
>> We switched to using BLKZEROOUT ioctl in libcryptsetup, and now we see a
>> lot of messages like
>>
>>    : operation not supported error, dev loop1, sector 0 op
>> 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
>>
>> But the operation succeeds (ioctl returns 0).
>>
>> As it seems, this happens when a loop device is allocated over a file on
>> NFS mounted directory.
>> Easy to reproduce (5.19-rc8) by doing this in NFS mounted dir:
>>
>>    # truncate -s 1M test.img
>>    # losetup /dev/loop1 test.img
>>    # fallocate -zn -l 1048576 /dev/loop1
>>
>>
>> Shouldn't the block layer be quiet here and just switch to a different
>> wipe method?
>> (I think it happens in other cases.)
> 
> without having all the setup details when underlying controller
> advertises the it does support write-zeroes and then when
> actual command fails you should this message.

This is a different case. There is no HW in between.
It is just NFS exported dir. On host system it works, on guest where
the dir is mounted it prints that warning.
  
> In case device doesn't support the write-zeroes then block layer
> silently executes the emulation path that REQ_OP_WRITE with
> zeored out pages.

I know, the point was that it is confusing if the error is printed
while the fallback actually works as expected.

Thanks,
Milan
