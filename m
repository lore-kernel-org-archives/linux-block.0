Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67232C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 23:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiI0XNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0XNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 19:13:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531110FE0C
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:13:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so10391848plo.3
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UJTVTF7GsB8WpU0mzGalF4mvAHD5zFwQkBXDVqT6Slo=;
        b=bqoHH7RBkhJqq+4havq16Mab3h6+jKJREpniWcE2whwI3vLyh20MafYQLM+6N0nLvt
         +aqzs+p3WSDzF/5vBqaITJwHFksiR2EZzXRqSJW28RPIyTF24e29OweMtRvnVyGG+U+1
         CmvsgrQhKAAycR7c5Tpn8UkExIYiwDhCm3JXJpS/7xnjQ6V/JAzsFe8cztR3Mpum9Ed4
         S1FVjmFsoE0lzY58TFvtSfsIWYIFfApLRVV6piUJqGvbKzwpAfG1TY/Is9gJqlwapJfG
         PMTzs8cKpbm68iID3NUNmUtI5IoQSGENA9dIndtxKC/k74gSl/FZc2d5urE8yo97OuLl
         voGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UJTVTF7GsB8WpU0mzGalF4mvAHD5zFwQkBXDVqT6Slo=;
        b=cCCg8Li+Ko2sg/7ptyGZaWLVroAhoT3PV69XWRcfstw0lnRMrfLVoMnPh6ZyTI4nvr
         3YiNEweOXm7Ph8zMOvSwcNO1WT9/6kuFTGkqEwJTx7MW3EDAgF5uy4XCUicKaRz4j/l3
         VosJ2qnjcaw72WmQf2yhC7Kykd1Ejwi4bHxswD6tG9m5PeNx8DciVU2JgOQBtOjItqwu
         ZZXQe+nKhXOKVABrL3LIWUhxjSQAywgH99KME0DXn/Xt5MfiYYenTz7xap5BIcmbJnnr
         TlUD0Bb/VT5D/mt3Vz5n4Xol4+NUfaVQl7HjulYTEexWCIDGj69vMpSIL1RX389Al6gK
         CtFQ==
X-Gm-Message-State: ACrzQf2Y9Tt6yOwBZB/ksAeHOk3mWRkVCUvsZ+0OOQUpz1kfdMMG8am/
        QH91ungN0i/R5qH/LYTU+dv2mg==
X-Google-Smtp-Source: AMsMyM4OnDHOqlnJmN5Mj/DdrLaxn2xAmHhmfSZyEPL0ysbAOK56GASfVoUI/nEgkLwFOl5qg5pyew==
X-Received: by 2002:a17:902:c245:b0:178:3912:f1f7 with SMTP id 5-20020a170902c24500b001783912f1f7mr29148364plg.75.1664320389490;
        Tue, 27 Sep 2022 16:13:09 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x3-20020a628603000000b00528a097aeffsm2366210pfd.118.2022.09.27.16.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 16:13:09 -0700 (PDT)
Message-ID: <9ef7cb1d-9186-6482-fdf9-7d78e600a36f@kernel.dk>
Date:   Tue, 27 Sep 2022 17:13:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        gost.dev@samsung.com
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
 <YzMp+SIsv6Aw4bFW@infradead.org>
 <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
 <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
 <80b83432-27a4-35ab-53a5-954bf1d7e415@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <80b83432-27a4-35ab-53a5-954bf1d7e415@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/22 5:10 PM, Damien Le Moal wrote:
> On 9/28/22 08:07, Damien Le Moal wrote:
>> On 9/28/22 01:52, Jens Axboe wrote:
>>> On 9/27/22 10:51 AM, Christoph Hellwig wrote:
>>>> On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
>>>>> Ah yes, good point. We used to have this notion of 'fs' request, don't
>>>>> think we do anymore. Because it really should just be:
>>>>
>>>> A fs request is a !passthrough request.
>>>
>>> Right, that's the condition I made below too.
>>>
>>>>> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>>>>>          return NULL;
>>>>>
>>>>> for that condition imho. I guess we could make it:
>>>>>
>>>>> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>>>>>          return NULL;
>>>>
>>>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>>>> REQ_OP_WRITE_ZEROES.  So this should be:
>>>>
>>>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>>>> 		return NULL;
>>>
>>> I'd rather just make it explicit and use that. Pankaj, do you want
>>> to spin a v2 with that?
>>
>> It would be nice to reuse the bio equivalent of
>> blk_req_needs_zone_write_lock().
>>
>> The test would be:
>>
>> 	if (bio_needs_zone_write_locking())
>> 		return NULL;
> 
> Note that we could also add a "IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&" to
> the condition or stub the helper to have this hunk disappear for the
> !CONFIG_BLK_DEV_ZONED case.

Indeed, that would be nice.

-- 
Jens Axboe
