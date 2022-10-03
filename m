Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E13C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 08:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJCIgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJCIfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 04:35:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B176D563
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 01:07:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so10099994wrr.3
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 01:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hVBNQ5c/KIbk2+4B3+qMf2aC9Bjz6M4lskTK/SNnjPA=;
        b=10gM2r4vlcVw00LduSidR3Hvj/12RJeuIFSZ7HE6Sr1PIrv8JkWLmAuKZRfSzNYtMs
         j94ebCCpYGsrvbzpt53hvqzk9e5FoezAd/QEJCieNRXLhoxdzK44EX1WM+XGdgZfXQDp
         LrRgBjiDxFqQL8LjXkRLP9vpX/yI1T9YjiXfh8VvDiEeuhOU32FIDXv8iCdwG/w4I9R6
         4DM39Dn2RaRyddGAfn3uJABF7Z4RNE5jFiS4qMG3Ycv2ANk14lQqfJsl1EDm2w37gS90
         +JtdeiSsI24IopW6XFEomyWB3xLTLJky6uQlNKbpkdrkcJaGtdBtA+k/tMVtd0O31fmX
         EtiA==
X-Gm-Message-State: ACrzQf0FBJEyvaaywSU2FgPCfRmDDzmEAKW6TDyMqyPVXPSNRnJ89mDE
        J/BCOMqxpk7l4sp8PeepyarFtasXluI=
X-Google-Smtp-Source: AMsMyM6Xntuf0ZnDgCbmn571IIKvBlrQXrbOZepgknpJ4oagT39vJ+3j7uTee23pecwDYwg+s8CNVQ==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr12178760wrw.179.1664784152958;
        Mon, 03 Oct 2022 01:02:32 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm9056820wrz.32.2022.10.03.01.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:02:32 -0700 (PDT)
Message-ID: <cef09c04-17d6-c588-be9f-b33e36dfce1a@grimberg.me>
Date:   Mon, 3 Oct 2022 11:02:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
 <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> 3. Do you have some performance numbers (we're touching the fast path
>>>>> here) ?
>>>>
>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>> preemption disable. This is a very small price to pay for what we gain.
>>>
>>> It does add up, though, and some environments disable stats to skip the
>>> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
>>> assuming you need to account for stats.
>>
>> But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
>> You mean disable IO stats in runtime?
> 
> Yes, the user can disable it at any time. That actually makes things a bit
> tricky since it can be enabled at the start of an IO and disabled by the time
> it completes.

That is what blk_do_io_stat is for, we can definitely export that.
