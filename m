Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB24C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 03:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiBWDSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 22:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiBWDSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 22:18:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E680813CC0
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 19:18:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i21so14034395pfd.13
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 19:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4GZxDLk+20YpEEQ5H3hKtSRMnKsQKg5NJx5AIQgDf1w=;
        b=0NxNemHx9vmwobMTkN8qPmmwAb/BWivjzMGDQbNI5OZmSQ+ZOtNI8NCYzeNxFlAmWl
         SI+RR3AVGzmyceFMD6H++I8d+ckeE4F9O0lqtd6NfZi2l7lvlf4IwujKn9JK3AGTT4Y+
         VVEJ0a/gfnRo0Knrht9v6Sn+hPGID5srKNXoZuhgD22cQp+uWrkJw0NnqVmkjIRehoB9
         aGWPoUZ70ifb0lWKBkt38S6yAVJQQ2dnIDksTvolarsszu+5ZGkP06hZwecMyYrc22sq
         75PIPUxQOCidDj8jZBCiBShrODfvbW8dj7/JtybWmntMxKiefLFzihSVnZjgFyX7gQ4t
         w1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4GZxDLk+20YpEEQ5H3hKtSRMnKsQKg5NJx5AIQgDf1w=;
        b=ErSAHamh7ddbNS9QO0f1NWCoL4DgvYrXSE2AL+2N2Ml4bmCUsAKMcp0mUj5WWh+pb7
         mTpZMZA0meaioIAoCvLuKLnEDAQjaCgy0MyosBL6W3/XLgxy8XSA+j1NW8CutKiL4LLZ
         1nAFPveCQO7Aof9+SkcxiApu1/PhkH+8BG9iDitLg7nNSbIkfuDyoig47lpA26R1KZHg
         ofukNBagvKDsg/DqZXknZ5nn9F5izURSVSE9XDXpUF+R5mNwxvt9DMb8pq3qrN6kk/y5
         vBsTH0HVnjBb+erbq4kLwdYLPoWjBGd05MXCfaVjzuEr+A1fYn+Ht2bTBsyvjnRykC+x
         /XGg==
X-Gm-Message-State: AOAM533OOWutBKSWLK7Huc22kHM9au1j+HK5iS+VEYV1y+iLHqCxGMJQ
        asdL+Hc+8AiOWWzVbRIiT+F1SC7dkoNNpQ==
X-Google-Smtp-Source: ABdhPJx7Uj1XH395ML5PRbWNhIo6+4DOlzQolZPsp/kc0m39V/uwz+CzYlb3tbRcHvERFaKG2m6Waw==
X-Received: by 2002:a63:5911:0:b0:36c:4394:5bfa with SMTP id n17-20020a635911000000b0036c43945bfamr21664060pgb.519.1645586300390;
        Tue, 22 Feb 2022 19:18:20 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h5sm18201407pfc.69.2022.02.22.19.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 19:18:20 -0800 (PST)
Message-ID: <a236f414-53e9-3569-4bd7-e986b8bf8472@kernel.dk>
Date:   Tue, 22 Feb 2022 20:18:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: block: potential bug on linux-block/for-next
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ecc72e5f-dd71-d940-d50d-0347631a7933@nvidia.com>
 <3610d58a-ef1d-a460-4bb7-de3d0297dae2@kernel.dk>
 <3386f561-604f-ff9d-51ca-77ff90835376@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3386f561-604f-ff9d-51ca-77ff90835376@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/22 8:14 PM, Chaitanya Kulkarni wrote:
> On 2/22/22 18:58, Jens Axboe wrote:
>> On 2/22/22 7:49 PM, Chaitanya Kulkarni wrote:
>>> Hi,
>>>
>>> After today's pull on linux-block/for-next test QEMU is not able to
>>> boot, any information about how to solve this will be helpful as
>>> it is blocking blktest testing, here is dmsg :-
>>>
>>> [    1.304698] ata1.00: Read log 0x00 page 0x00 failed, Emask 0x1
>>> [    1.305587] ata1.01: Read log 0x00 page 0x00 failed, Emask 0x1
>>> [    1.455959] systemd[1]: Cannot be run in a chroot() environment.
>>> [    1.456743] systemd[1]: Freezing execution.
>>
>> What was the previous one you tried? What are the changes between the
>> two?
>>
> 
> This is the one tried and can boot normally:-
> 
> root@dev linux-block ((HEAD detached at 03546d43eb84)) # git log -1
> commit 03546d43eb841d5fd66203822c2bb290a46464c9 (HEAD)
> Merge: a102cd383c4a 55143a783f07
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Feb 16 19:38:35 2022 -0700
> 
>      Merge branch 'for-5.18/drivers' into for-next
> 
>      * for-5.18/drivers:
>        null_blk: remove hardcoded alloc_cmd() parameter

Can you bisect between those two? Not sure what this might be...

-- 
Jens Axboe

