Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D035EC433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhKWXbE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbhKWXbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 18:31:01 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B494C0613E1
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 15:27:36 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x10so764576ioj.9
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 15:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=;
        b=280Bz0k0OYWwkdgLxOgZ/yknvlsY35nBXX/FIA0GJh2OzyEIkxt5dpnuKGk0CYLcq5
         TCs4l/IGtMPPRvIkfh7gH/pGmvzlVs6NvyJ6w0hdoNhSV+OrMcIQ3v/8q1lQ5kw8U6Jo
         YJdu23zpP/HXsN9JN5PLPhkmOp7O5i/Dl5tvuU2dAtz3FXIdr84ljg79VUvjuJ9xMmSB
         G3mOJRwlnaX+CHGjYsLwiXdPsGNQDhV56Wx0xvgeY537pwm+O7xdFZ5lNODLLwNyTH6s
         54nHv7m6oEMU/8qeYijxiOpI/ELZH/jkBgHWIgtbAND6MJO1j/yuAGZFGzgb+3joCKwm
         Z4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=;
        b=Qbm0WJUsV46T3Z8HcdsT1T1KwugErDf+N/zZtEPUUdGVOQkrvfmw7F/0bsRwhCChEo
         NMpeGn+lKipYm311Rqm15cid7/S32rNK4o3TjKwV90SN/AsRsNYNzVbd3Ua4Oz6xHQ9w
         xMj8w75CVyRreF92PPgFDug7IHJV7M0DpFiahxQCh48KvpQZthYigYB8muXFHlildJE+
         9/pA3DmYTPF5Lbxp79+wlyz5wiPbTP+UiCoG+0Z6WcUyfH64ksaSvZUYiZGJQDpRs4sf
         u7qSC78tIHaqGtFfWX4qMBWgS11pRo3xfjdVofsw2a1E7dZ4jYaUuuytAtDsGsU5CIuC
         Iwzw==
X-Gm-Message-State: AOAM533prRCwgqlfdnU1ZHiwWFxQdptJcgJIgouA0mePJS7NSXsuqWYo
        e+aoJoxj5vN6pBTt5W+ziGEMTQ==
X-Google-Smtp-Source: ABdhPJwCLJjwK3aKbSmDRGjmTjIcEDCwjg5vNWeo2TaKak1MQec8VtkkIaTJqJiEgLX5uA6pCl1ncA==
X-Received: by 2002:a05:6602:1604:: with SMTP id x4mr10349425iow.84.1637710055352;
        Tue, 23 Nov 2021 15:27:35 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s15sm9869112ilu.16.2021.11.23.15.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 15:27:34 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
Date:   Tue, 23 Nov 2021 16:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 2:05 PM, Kenneth R. Crudup wrote:
> 
> (Please forgive the SPAMmy nature of the To: list; I'm not exactly sure whose
> subsystem this issue belongs to, so please trim as appropriate).
> 
> I've got a Kioxia NVMe SSD on my Dell XPS-7390 2-in-1 running an i7-1065G7 CPU
> with 32GB RAM.  If you need more info (and I suspect so), please let me know.
> 
> I'm sorry I don't have a better description of the problem, but I run Linus'
> master branch (and sometimes I weed out problems like this). I'm current as of
> his commit 1360572566 (the 5.16-rc2 tag).
> 
> For about two weeks now every now and then my block/NVMe/...? subsystem comes to
> a total halt on writes, and I get a system that can no longer issue writes
> (reads/pageins still seem to work) until I reboot. SysRq-S/U/B still leaves a
> dirty ext4 filesystem requring recovery on reboot.
> 
> It happens at random- twice today as a matter of fact- and there doesn't seem to
> be any particular action that causes it:

It looks like some missed accounting. You can just disable wbt for now, would
be a useful data point to see if that fixes it. Just do:

echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec

and that will disable writeback throttling on that device.

I'll take a look at this, but most likely not until start next week...

-- 
Jens Axboe

