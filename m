Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4542ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 14 Sep 2022 10:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiINKhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiINKhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 06:37:46 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD77821C
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 03:37:41 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id cc5so15160958wrb.6
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 03:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NG/tBYKdW3eE5R+C+Bl2XIXo8xD4ho8d93dBF9Mlcvo=;
        b=Hm8aNbO5bMsApvCBz8Am8Q2pB/YizYfKIAbbl8PUiCSC1Lz47pEM0GARj4Vc1LZCSY
         ozsCWMXanIlZEbDAp9WBiax4sQBVmMPF/R7eDi4JOFHu05c9CH0D+ib7HbRVkcCt+bTf
         EaAcBNyOyFpA7ofJcF9WrnCLY1h8jHzPzzKlnGQG7SA7YP6NKEpJWPZoBU1CPuBCzYHN
         vFDURq7A2h2QKbLPsdkEBOOEJVGFSJxqh+m6gZJ2jA34RroCwnU5gxnUoQonFzlIfDn0
         kUx4v1xexMDwsGz/vkCGWHmPwbREJ4g7jtkBCyGrK3IGcFJO/vwqt7IRz/do/r5EeDLP
         PeGw==
X-Gm-Message-State: ACgBeo2UfDSC6+fHm9EtMGC29VVP68g8PEE93gqmVIIm6Pnms38Eqoe1
        WcQs8koBHi00JtDaFf2Ok5w=
X-Google-Smtp-Source: AA6agR7EP0j7pEOqfggaZOV7sbicE/PSXYZGEUcfLwVpr57ptpJXjkugCTGax/jds2f3MoYbfyOesw==
X-Received: by 2002:a05:6000:1ac7:b0:22a:906d:3577 with SMTP id i7-20020a0560001ac700b0022a906d3577mr8759177wry.33.1663151860348;
        Wed, 14 Sep 2022 03:37:40 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003a342933727sm18921430wmo.3.2022.09.14.03.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:37:39 -0700 (PDT)
Message-ID: <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
Date:   Wed, 14 Sep 2022 13:37:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> FYI, each blktests test case can define DMESG_FILTER not to fail with specific
>>>> keywords in dmesg. Test cases meta/011 and block/028 are reference use
>>>> cases.
>>>
>>> Ah okay, let me look into it.
>>
>> So I made the state read function a bit more robust (test if state file
>> exists) and the it turns out this made rdma happy(??) but tcp is still
>> breaking.
> 
> s/tcp/fc/
> 
> On closer inspection I see following sequence for fc:
> 
> [399664.863585] nvmet: connect request for invalid subsystem blktests-subsystem-1!
> [399664.863704] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
> [399664.863758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> [399664.863784] nvme nvme0: NVME-FC{0}: reconnect failure
> [399664.863837] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> When the host tries to reconnect to a non existing controller (the test
> called _remove_nvmet_subsystem_from_port()) the target returns 0x4182
> (NVME_SC_DNR|NVME_SC_READ_ONLY(?)).

That is not something that the target is supposed to be doing, I have no
idea why this is sent. Perhaps this is something specific to the fc
implementation?

  So arguably fc behaves correct by
> stopping the reconnects. tcp and rdma just ignore the DNR.

DNR means do not retry the command, it says nothing about do not attempt
a future reconnect...

> If we agree that the fc behavior is the right one, then the nvmet code
> needs to be changed so that when the qid_max attribute changes it forces
> a reconnect. The trick with calling _remove_nvmet_subsystem_from_port()
> to force a reconnect is not working. And tcp/rdma needs to honor the
> DNR.

tcp/rdma honor DNR afaik.
