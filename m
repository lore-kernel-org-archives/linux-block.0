Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A970C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 08:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbiCOIKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbiCOIKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:10:11 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E851261D
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:08:59 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id t11so27658450wrm.5
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ugxPm0nSHs7cXNitwLn3JTCCMl6sBC/FNjV8Rk7pEsI=;
        b=2DhZmmgFV55TcTfjba86TvGoCJpcr8coiuUiQRIfroCIdbD9JI51ZxHQv2u06fNRSK
         WvyVR15Gr9wocQaoo3MHY5pwkMd6kRzCTJACdkSgiUTUFcMpn18mrBApkD9HLvA0updK
         3ZzHpBTJyxWNwSJdzD8342EpkY4COAp+mfvhbJ/OkEB4F6wHa5dEqjJ6158dHmbzdJVD
         4zvbzqFXlO9Ob7T0c3DgNUtFlqit/8p8oQbjqh/ZLwGoplFK4CC3A/JfBy4AN8ecwa+b
         ecaWJzB+jcpHmAwZ/YjbFwJM1/JAfSW2y22bua41OXnjJXa/pyxAxBJ/uQYhi3ZnHvo1
         gC7w==
X-Gm-Message-State: AOAM531KnOzU9ABL1zcZ0CqQMfQk25HULVXS4xRKPLRFRZKeqvpEGTzB
        H27TqUZhYhIixbEzNej1TP4=
X-Google-Smtp-Source: ABdhPJxNxsyILnkE/lFf9K0OZpEVpsTw4VW+3CvMzP5eEdfo1DJZQIjznxpspeJyR4W/UKMcgz8hVg==
X-Received: by 2002:a5d:64a5:0:b0:1f0:6041:159 with SMTP id m5-20020a5d64a5000000b001f060410159mr19536959wrp.703.1647331737757;
        Tue, 15 Mar 2022 01:08:57 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm23473298wrt.63.2022.03.15.01.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:08:57 -0700 (PDT)
Message-ID: <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
Date:   Tue, 15 Mar 2022 10:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
 <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hi Sagi,
>>
>> Haven't these use cases already been mentioned in the email at the 
>> start of this thread? The use cases I am aware of are implementing 
>> cloud-specific block storage functionality and also block storage in 
>> user space for Android. Having to parse NVMe commands and PRP or SGL 
>> lists would be an unnecessary source of complexity and overhead for 
>> these use cases. My understanding is that what is needed for these use 
>> cases is something that is close to the block layer request interface 
>> (REQ_OP_* + request flags + data buffer).
>>
> 
> Curiously, the former was exactly my idea. I was thinking about having a 
> simple nvmet userspace driver where all the transport 'magic' was 
> handled in the nvmet driver, and just the NVMe SQEs passed on to the 
> userland driver. The userland driver would then send the CQEs back to 
> the driver.
> With that the kernel driver becomes extremely simple, and would allow 
> userspace to do all the magic it wants. More to the point, one could 
> implement all sorts of fancy features which are out of scope for the 
> current nvmet implementation.

My thinking is that this simplification can be done in a userland
core library with a simpler interface for backends to plug into (or
a richer interface if that is what the use-case warrants).

> Which is why I've been talking about 'inverse' io_uring; the userland 
> driver will have to wait for SQEs, and write CQEs back to the driver.

"inverse" io_uring is just a ring interface, tcmu has it as well, I'm
assuming you are talking about the scalability attributes of it...
