Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97DCC433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 17:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiCXRH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiCXRHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 13:07:25 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B1B0D11
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:05:52 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j18so7537163wrd.6
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cc9jnKprvH4sxMEa054bpk4cO4MVjVk6tMsIKhmeeGw=;
        b=t8lVknupn+Z4uA76q/gJx/I3CdD0TQE5LPoopWwAKvg/KfnJaYRYsuzRqHONwxWH2S
         /EhL8LqvTfL9Tbmwnf9bl77pzVZA0TG4HMsbCimna0djSCfb4Rw1L1Loawv2+ferXdgX
         0REaEkZWuc0xOwVMz5WB1+63bKPBzhGe8LBGRyJXkVY8Uw/zccWdgt0mtxctLsxhdR8K
         PZ6RKD5zgflQZ1+6Shc2XxJsK3cq3hFMcepcBjEBtwo5QsRHeJFGF/JD4l+jMa77mZ31
         ruUNsanq9iiEA2QLb2sPWOnsnVaLvB1/kDL/lCyLyb3tR0MOZZS+EBwGoAWlSPBbcP5e
         CrJQ==
X-Gm-Message-State: AOAM5311sQAyu/OUPv3fkGgT3QBIPJGwJAUAOrGLjqjlq+Ip2CQwNBP3
        vCoapz61aA6Ia2pgbKqsn/E=
X-Google-Smtp-Source: ABdhPJynn3oNoXuWOS/MHFkMKXGopR2dfB/bxFzwUp/CSu68SJfulaWq4BBBWQ6YYdwKxSF4/x3u2A==
X-Received: by 2002:a5d:6d07:0:b0:205:7ac5:1453 with SMTP id e7-20020a5d6d07000000b002057ac51453mr5429508wrq.149.1648141550863;
        Thu, 24 Mar 2022 10:05:50 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net. [85.65.206.129])
        by smtp.gmail.com with ESMTPSA id b1-20020adfd1c1000000b002058537af75sm3220567wrd.104.2022.03.24.10.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:05:50 -0700 (PDT)
Message-ID: <692ef2af-240e-9682-5530-5d55e49797d5@grimberg.me>
Date:   Thu, 24 Mar 2022 19:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
 <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
 <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
 <YjBKaoBYtofJXrgw@infradead.org>
 <1cec32d1-511e-1a78-b157-9ecaebc72c66@grimberg.me>
 <87bkxwqwvn.fsf@collabora.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <87bkxwqwvn.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> FYI, I have absolutely no interest in supporting any userspace hooks
>>> in nvmet.
>>
>> Don't think we are discussing adding anything specific to nvmet, a
>> userspace backend will most likely sit behind a block device exported
>> via nvmet (at least from my perspective). Although I do see issues
>> with using the passthru interface...
>>
>>> If you want a userspace nvme implementation please use SPDK.
>>
>> The original use-case did not include nvmet, I may have stirred
>> the pot saying that we have nvmet loopback instead of a new kind
>> of device with a new set of tools.
>>
>> I don't think that spdk meets even the original android use-case.
>>
>> Not touching nvmet is fine, it just eliminates some of the possible
>> use-cases. Although personally I don't see a huge issue with adding
>> yet another backend to nvmet...
> 
> After discussing with google for the r/w/flush use-case (cloud, not
> android), they are interested in avoiding the source of complexity that
> arises from implementing the NVMe protocol in the interface.  Even if it
> is hidden behind a userspace library, it means converting block
> rq->nvme->block rq, which might have a performance impact?
> 
>  From your previous message, I think we can move forward with dissociating
> the original use case from nvme passthrough, and have the userspace hook
> as a block driver?

Yes, there is no desire to do that.
