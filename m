Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285AC433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 06:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLGhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJLGhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 02:37:50 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AAB03D3
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 23:37:43 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso1870039wmq.0
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 23:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzazz2LGm2icEmkVZBKyvXHDcPEponMOSCNSkIH0wgI=;
        b=GPw10vr61IMcRfr39ssqlqkECCz/cNJ8UbU5Aa8RtytPi6BTBwyLCIgQmDpWvkvFfp
         iLuXFRICvOMKWWI0tKRVF6CtWdZO36bHTiOYUCeqXAagqKlxZV35/lWPVU1G4QPF+7ho
         Pb8h4Meot5x+z4Ut2LHTDMBKXVyU2kr3vm8utknP5Mao4Z584levObEhXkpqNZ4vrYVz
         EhpllJhqOkEajHfnCWqBzXen8gMi7qLSd1pV7naDKlpKRwR1zGcn69zcPcBmLxSIAQGG
         ZH1L/Msl9BPcnpkUPqOrdeZvlglTsf1LY81ONo6kAy4XvKlXL/+BYEQg0C4uWuUduoKz
         ygCw==
X-Gm-Message-State: ACrzQf11iFgKZtMJfAl7zgpO777D1hcSFXdwbem1PEMcXLOkARoEZo2z
        jg04hgVylv3zFcjXavRpi8U=
X-Google-Smtp-Source: AMsMyM4JijtLxbt2ktWylR00buTODn27IC2f7iR7kF5eewPHXO7bGTRr/sy3mSvEUvQ7Yvyf66bGTQ==
X-Received: by 2002:a1c:7407:0:b0:3c6:cc25:c02f with SMTP id p7-20020a1c7407000000b003c6cc25c02fmr1603832wmc.124.1665556662410;
        Tue, 11 Oct 2022 23:37:42 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b0022aeba020casm12952192wru.83.2022.10.11.23.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 23:37:41 -0700 (PDT)
Message-ID: <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
Date:   Wed, 12 Oct 2022 09:37:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
 <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>>> But maybe we can avoid that, and because we allocate
>>> the connect_q ourselves, and fully know that it should
>>> not be apart of the tagset quiesce, perhaps we can introduce
>>> a new interface like:
>>> -- 
>>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>>> {
>>>     ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>>>     if (IS_ERR(ctrl->connect_q))
>>>         return PTR_ERR(ctrl->connect_q);
>>>     return 0;
>>> }
>>> -- 
>>>
>>> And then blk_mq_quiesce_tagset can simply look into a per request-queue
>>> self_quiesce flag and skip as needed.
>>
>> I'd just make that a queue flag set after allocation to keep the
>> interface simple, but otherwise this seems like the right thing
>> to do.
> Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
> If we use blk_mq_quiesce_tagset, It will cause the above mechanism to fail.
> I review the code, only pci can not ensure secure stop/start pairing.
> So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, not 
> PCI.
> Do you think that's acceptable?
> If that's acceptable, I will try to send a patch set.

I don't think that this is acceptable. But I don't understand how
NVME_NS_STOPPED would change anything in the behavior of tagset-wide
quiesce?
