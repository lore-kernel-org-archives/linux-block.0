Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D060DC2B9F7
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1BC613E3
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhE1QaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 12:30:21 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:37821 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhE1QaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 12:30:21 -0400
Received: by mail-pg1-f170.google.com with SMTP id t193so2928643pgb.4
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t+PzXrg39UDcIn84flOZlOx80R3VdZb8jorx3LvJRVM=;
        b=OPeTndy8j/+eugJSUKmV1EhP69dRakEU3F8EHDqoqiNtAkSCIXi80sfmZ38LD8cBAS
         gv8r/xBCsZBRLwGu5PCUjSMwt5ilI5uh5d9P7hKa0WRGcQBYot0nUfpBAdKDQm1UG3xC
         znO/sdCpaxEykskpEPz1exSDc7DCPDjLya5VKY+yYCqHYr5SpQAODgdlZtBh9WpUmLp5
         LPj6ObO/nln813hgvBq2esjGV1FykEtLxbvczqzkss3HQlyAyn1fVUlpXkTfjNKTYcOK
         UOUvPuOw0SUl0CVBJBOFRlVfb+la0Rc2YyQuc+WzjijklrEAVpa+T/OYJFm7rPw0Hriv
         Zxgg==
X-Gm-Message-State: AOAM531r/9Ad4hanVjgM+EIJEBWXW3bopkRcBA91D1ickeCYHDBvRxOg
        J+hMDPYeUmMx5LfrPQm44yst4i7VQTY=
X-Google-Smtp-Source: ABdhPJzTbyyGwDqDRN6XkYXd7W9i4g0ZdxvNn1cgudLedAS2pVQgZGHrid9z4idwVrlLEUILd7ru+w==
X-Received: by 2002:a65:424b:: with SMTP id d11mr9667259pgq.171.1622219325779;
        Fri, 28 May 2021 09:28:45 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id u19sm4724642pfn.158.2021.05.28.09.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 09:28:45 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
To:     Wang Jianchao <jianchao.wan9@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
 <ef81558a-cab2-ca2f-dba8-e032ecdb8154@gmail.com>
 <22c245e9-469c-0a0f-ad31-455a33f1e073@acm.org>
 <b3878299-ae9b-d03a-eaa8-b1890afcbfe2@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <feca5738-690c-3842-e5a8-998f0f5e3228@acm.org>
Date:   Fri, 28 May 2021 09:28:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b3878299-ae9b-d03a-eaa8-b1890afcbfe2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 7:05 PM, Wang Jianchao wrote:
> Does it really matter that issue IO request by the order of io priority ?
> 
> Given a device with a 32 depth queue and doesn't support io priority, even if
> we issue the request by the order of io priority, will the fw of device handle
> them by the same order ? Or in the other word, we always issue 32 io requests
> to device one time and then the fw of device decides how to handle them.
> The order of dispatching request from queue may only work when the device's
> queue is full and we have a deeper queue in io scheduler. And at this moment,
> maybe the user needs to check why their application saturates the block device.
> 
> As for the qos policy of io priority, it seems similar with wbt in which read,
> sync write and background write have different priority. Since we always want
> the io with higher priority to be served more by the device, adapting the depth
> of queue of different io priority may work ;)

Hi Jianchao,

Our conclusion from the extensive measurements we ran is that we cannot
reach our latency goals for high-priority I/O without I/O priority
support in the storage device. This is why we are working with device
vendors on implementing I/O priority support in the storage devices that
matter to us.

Thanks,

Bart.

