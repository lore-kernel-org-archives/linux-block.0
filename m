Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A6CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 15:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbiDRPxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiDRPwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 11:52:34 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC085AE49
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 08:33:05 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y85so4999712iof.3
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LXj6l1SIzMiGd0F8WnSspnVhDnfpp7z0rMQUAc/4akE=;
        b=YmfY0AvXT0xwonY1k18wME4X5j+utcTyjbM5kTSIJ2Sfdq2WcOlhZD/9Qsjy9ADhVT
         25JBwrts+1gp4A3s9bZv+vkDcPJRkViees3ich1TGM8GeQzKdA971ED2sk8ayu/Z6vBq
         g/rR8h6l6VGP2xY0UpEZJkw/Uo0MpSaPG+X6wDh4ZwfPSzKfpUxnMDdgWDgtQupeSmZ9
         wRVSQVbFmLhMrPr8QmT+AZQPm7ENFdqolRqVsCZIV92zgR272s5yKY5Gg/p9X40ZCwSt
         GuBTZakoblzwZ6LVBkzi+cyu6o+KbIEYbDqOK0Bh8Oe6rFAXGbOuYhYZA6a4YLPMxFFg
         IslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LXj6l1SIzMiGd0F8WnSspnVhDnfpp7z0rMQUAc/4akE=;
        b=0MjqBXzugjTxGCJCNYr4XCXRCM076CWV6dBAXHRAGfWPSJI3JrT4b9bzY/nEhzfj1i
         ShdBICOe4zWHIDkYhBEz/Oy+nGDX5H1533LGte+xvW58kbOcCf7rPKQQHgyx84FikNIq
         6WX8GwOITetfNMhPEe6HOPIErZ2ExZQxSiTh2eEYNTFNZUWDC1ZxtPWlT7mXkJMOmaKa
         VdMSb2cvho4BWyPSzgZ+rcbVku/d+H4xGvbxjr3dtfJn8OKbyQJPrArlFYgvAOQoTnS+
         gOHshUUNGqrbH1pj33DFd0u+X3evm5PW3lUo9eblkjLeajL7uXC1ZGgosv9z0OITBKdV
         QJsg==
X-Gm-Message-State: AOAM530qDro0SKKf2hW6ew8wgnPDcucN3nhTVVYxkBZLAtsRYx79PClK
        oNVGeCUutkBaCGlpj81PIwHL4Q==
X-Google-Smtp-Source: ABdhPJwGF3gvlBEhBonFyPnwG51X6A+BdfyzEgPCalkbk2CbbMhFeGOyDOH0K+kIxrComukz8fm0Cw==
X-Received: by 2002:a05:6602:c3:b0:64f:d28f:a62c with SMTP id z3-20020a05660200c300b0064fd28fa62cmr4771325ioe.212.1650295985255;
        Mon, 18 Apr 2022 08:33:05 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o11-20020a92a80b000000b002c1ec0ca545sm7316890ilh.18.2022.04.18.08.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 08:33:04 -0700 (PDT)
Message-ID: <2e7aa3f5-7fad-5188-f7f6-3ba8f75d4b6f@kernel.dk>
Date:   Mon, 18 Apr 2022 09:33:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Question] Accessing read data in bio request
Content-Language: en-US
To:     Jasper Surmont <surmontjasper@gmail.com>,
        linux-block@vger.kernel.org
References: <CAH4tiUtGuZP6QnO6L9EEDFL08O-UusHihO6CbvEf-QwJM3QPCg@mail.gmail.com>
 <eab14c0a-dd66-555c-8830-d23a5068273c@kernel.dk>
 <b975d3aa-e5b1-c16d-1820-4de5d84576cc@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b975d3aa-e5b1-c16d-1820-4de5d84576cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please don't top post

On 4/18/22 7:06 AM, Jasper Surmont wrote:
> On 18/04/2022 04:59, Jens Axboe wrote:
>> On 4/14/22 8:15 AM, Jasper Surmont wrote:
>>> I'm writing a device mapper target, and on a bio (read) request I want
>>> to access (for example just logging) the data that was just read (by
>>> providing a callback to bio->bio_end_io).
>>>
>>> I've figured out I could read the data by using bvec_kmap_local() on
>>> each bio_vec to get a pointer to the data. However, if my
>>> understanding is correct this seems like an unefficient way: if the
>>> bio just finished a read then shouldn't the data already be mapped
>>> somewhere? If so, where?
>>
>> Not necessarily - if you're doing passthrough or O_DIRECT IO, then
>> no mapping necessarily exists for any part of the IO.
>
> Okay thanks! So does this mean that you would suggest doing it with
> bvec_kmap_local()? Or are there other, maybe better, methods?

That's the way, yes.

-- 
Jens Axboe

