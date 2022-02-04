Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B8C433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 15:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359789AbiBDPdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 10:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359796AbiBDPdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 10:33:51 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7135C061755
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 07:33:49 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m17so5096095ilj.12
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMXiHyFzmCWgQxEDyehhgwNaKxoIkXmTAnhc9E5Tz7k=;
        b=PZ+FFNjEjQConjxrjIpu8ar1icI68F4XDfgl76CwIf+IC5o51EMrrmIGjESSaWxyzU
         cmYKPIiKyBJ/e8OT4qudBPOLLKZsEQRdHLrXedbt8+IbBCWWV0J11Bjk+5NMVvd8+Zqc
         /6sQNKxjynDwNA/yAoDCdNa1mib7Y0ewzQvXnRqjSecOik1/Bhk8iMpCN5LuPqo/o39l
         ig5NdvNmyAqDx6ouS8Ke55fplMg0jNsoSFhPFIH2MzbdLfFzBjKJDKOo/00dRTWRKWau
         /ibCxF6WagtUys+8gT68UhL8WBiy7LOU+/huLof2DpAf6jNZ8RvQkjcfR2k4WVawMetx
         xpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMXiHyFzmCWgQxEDyehhgwNaKxoIkXmTAnhc9E5Tz7k=;
        b=Ml+/H965TULIxL7p28Xlwe+BRLzavyNLHPq8APqgqcVTLpqJbnVMWSghjpnCqMQjG6
         1P7N2ljDBkUrxB7Mq/Z3//y3DtFcS9XzdtJ7Ch0ShVYO/FR83plRl1jpDoZb0oK+QmTE
         68C//UN3FAxl02S19u3jquEB71JqxoB+BgUhzPT1j24eY3s0D6Xu4iqnGsFYffSYspMz
         WznujDV/a1roHqzwwQqR4bmP9lBi/xx1oBhA8rGtR6h4E1IUL4exhJtcqmYikK7ghdwT
         ZwFIx6jT0vFKBazzvoqF7uym1HOdjGIELSHq83FcnTyQmT8xXtGF8+LQJFtImP6Ufx5E
         33pg==
X-Gm-Message-State: AOAM5315ZfffG9I4JbADpKlreVapFW04CpRlgwTig+H3wX2emJGRWWO7
        A/tYRPRsWGiRbZhBAa7Z4nw0Kg==
X-Google-Smtp-Source: ABdhPJyxJY+wPZeoWcH2SOmdAobH35e3EnCxOS/1SHm4IhpBQrwnGZDne//CO9i6kh4AXjsI3J/Gtw==
X-Received: by 2002:a05:6e02:1687:: with SMTP id f7mr1127479ila.143.1643988829269;
        Fri, 04 Feb 2022 07:33:49 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y22sm1087583iow.2.2022.02.04.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 07:33:48 -0800 (PST)
Subject: Re: Partial direct-io loop regression in 5.17-rc
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Kozina <okozina@redhat.com>
References: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
 <08e1dbde-b27c-fd99-294c-8e4715b92576@kernel.dk>
 <54f98c2a-4a40-75ed-8f66-11cc6b2fd190@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65bfe3d6-504c-8fba-2bf4-541ab24b324b@kernel.dk>
Date:   Fri, 4 Feb 2022 08:33:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <54f98c2a-4a40-75ed-8f66-11cc6b2fd190@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/22 8:03 AM, Milan Broz wrote:
> 
> 
> On 04/02/2022 14:32, Jens Axboe wrote:
>> On 2/4/22 2:22 AM, Milan Broz wrote:
>>> Hi Jens,
>>>
>>> It seems that there is a regression in direct-io over loop for partial
>>> direct-io reads (or perhaps even for other situations).
>>>
>>> If I run this code (loop over 6M file, dd direct-io read with 4M blocks)
>>>
>>> IMG=tst.img
>>> LOOP=/dev/loop66
>>>
>>> truncate -s 6M $IMG
>>> losetup $LOOP $IMG
>>> dd if=$LOOP of=/dev/null bs=4M iflag=direct
>>> losetup -d $LOOP
>>>
>>>
>>> on older kernel (<=5.16) it reads the whole file
>>>     6291456 bytes (6.3 MB, 6.0 MiB) copied, 0.201591 s, 31.2 MB/s
>>>
>>>
>>> while on 5.17-rc (tested on today/s Linus' git) it reads only the full blocks:
>>>     4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.201904 s, 20.8 MB/s
>>>
>>> No error reported, exit code is 0.
>>
>> Can you try:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=3e1f941dd9f33776b3df4e30f741fe445ff773f3
> 
> Yes, it works now.
> (Not sure why I did not check if this patch is mainline, as I know
> about it. My bad...)
> 
> So this is going to some next rc, right?

Yes, it'll be in -rc3, pushing it out today or tomorrow.

-- 
Jens Axboe

