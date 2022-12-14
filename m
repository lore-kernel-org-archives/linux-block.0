Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39988C4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiLNRyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 12:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiLNRyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 12:54:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8F17E3A
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 09:54:35 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id d14so6896776ilq.11
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEgBSJx43wrVVq1GzpGX8Mc4Y2UuwgPrS0qiOUvxx5M=;
        b=ZsOOQ5UIHuGFD59wf53jytyh+r7oPCX7+8i5SqReQr3V5N7zcfrqG6CATOjywQZbx/
         cMPU6a9lUI0O/6P4gVaC0MTv45f+unEBfcFDgDw/5oH0IpFKiUi5e7RZKCzcmS5o/Uoo
         jHF8axRzEsIohLb04iF2DL1ddVreznZAzjPcydTwJpAouRNh6R0ZmozgGLuGAakj4oAX
         8OY6Bn/TFGe5ihbrodrp2F7Ri8pebUf6MxWbsvFCdh5jt6MkBiLQBlfRtcco2Yz3hO/z
         b/fO5y3M/JpWgm6vWQSL0e71jgoX04JlI1hbjMbC8wf/usYe8oJkXjxVfo5MG24cbyt5
         XITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEgBSJx43wrVVq1GzpGX8Mc4Y2UuwgPrS0qiOUvxx5M=;
        b=U7WOK1oNgyrK8F/97QuebYEa03jNR2jQRNhfbxLMzkpBggyqZTszRlEBN5zXkbcZ6I
         gXuqz7NngrxCjDYWe7jkc6XSNUd8OXhSbnNNJj2nNrs0DUfClk6TfMqAqD0+FMMIIZ3x
         B4PjZd5z1x3VF86Fw7fpID8pbw4hDELt3tdQuSTJEcEl32wmxt9J+XtEvHC6Q4kkX1+s
         WUJNKjU6dv0ywrhrSsdKUbkuvTJxULpapvDqQ5HL0gV3bD9X2mx/Ows/7sD73WIZo87w
         90GxkKwVet0VoZL4dCMNC39VncedoTeo58NLaaJFwzpIHhkSaTPbtzZ0K2eDUpuP5dzA
         /y2Q==
X-Gm-Message-State: ANoB5pmdkFWAEoZ3AnJbiKd94SFLXBWku8zuUrrJFcYekj6/sEQWMuut
        zA8lHlTlKgSepGDPdEu7pcvc1EZrbIBuW4iXspY=
X-Google-Smtp-Source: AA0mqf6lk+p378ifpnYve4eRG1VaTeTeVG0/6u2t/RRmx6WO/cFHWcS6TTlwnSBGBPMPvRdpcRsr7w==
X-Received: by 2002:a92:cd8d:0:b0:302:d99a:bfd1 with SMTP id r13-20020a92cd8d000000b00302d99abfd1mr3703693ilb.0.1671040475240;
        Wed, 14 Dec 2022 09:54:35 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e5-20020a0566380cc500b0038a01eba60fsm1938964jak.69.2022.12.14.09.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:54:34 -0800 (PST)
Message-ID: <d3f761ce-4670-9665-3db0-86c2cd528811@kernel.dk>
Date:   Wed, 14 Dec 2022 10:54:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V3 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
 <Y5anOZyJBCes1XEo@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5anOZyJBCes1XEo@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/22 8:59 PM, Ming Lei wrote:
> On Wed, Dec 07, 2022 at 08:32:59PM +0800, Ming Lei wrote:
>> Hello,
>>
>> Stefan Hajnoczi suggested un-privileged ublk device[1] for container
>> use case.
>>
>> So far only administrator can create/control ublk device which is too
>> strict and increase system administrator burden, and this patchset
>> implements un-privileged ublk device:
>>
>> - any user can create ublk device, which can only be controlled &
>>   accessed by the owner of the device or administrator
>>
>> For using such mechanism, system administrator needs to deploy two
>> simple udev rules[2] after running 'make install' in ublksrv.
>>
>> Userspace(ublksrv):
>>
>> 	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
>>     
>> 'ublk add -t $TYPE --un_privileged' is for creating one un-privileged
>> ublk device if the user is un-privileged.
>>
>>
>> [1] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
>> [2] https://github.com/ming1/ubdsrv/blob/unprivileged-ublk/README.rst#un-privileged-mode
>>
>> V3:
>> 	- don't warn on invalid user input for setting devt parameter, as
>> 	  suggested by Ziyang, patch 4/6
>> 	- fix one memory corruption issue, patch 6/6
> 
> Hello Guys,
> 
> Ping...

I think timing was just a tad late on this. OK if we defer for 6.3, or are
there strong arguments for 6.2?


-- 
Jens Axboe


