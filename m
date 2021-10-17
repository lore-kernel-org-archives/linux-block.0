Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C559C433FE
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 22:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551046108E
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhJQWnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhJQWnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 18:43:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398FC06161C;
        Sun, 17 Oct 2021 15:41:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so63243603edx.8;
        Sun, 17 Oct 2021 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Limn6bLCuPublZ0I9FNtGu/mfoi+V+L5uBvnzeLAJ8g=;
        b=I/K7TLKObDaVo20Xl7ItIkFyKnMBfnE5zkY49K5G2mp1n2o53iige7cSOEf2Y/xQip
         MWn6NsCu9Azk0s9gukE6HltVV5+aE/ZHHS4ViKNor2OXjsB7OLgVral9MdJYd/hNNKx6
         4nl9x9WDKFKAqPrgOshWBOqZhhGQDOxJhbA+diHi0i5qxU/47NtKx6GKeeRSz68GXgKA
         gviu9Sbi7eteoIcsum3fgWGHJJ0jh9VXLkcZZ6wwdJzfApR/twmqLTnT7+gEWz+0qJXg
         trE6iPy/G063/F8HjM3ys4ywL/eHpUSHwL28yMFGuIsADisjmJGmWMlDJjRXg6BheIDU
         6aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Limn6bLCuPublZ0I9FNtGu/mfoi+V+L5uBvnzeLAJ8g=;
        b=FVvE4bBOxChoKN0XRuPEEtkWEjd15JULT1WGupByocMhdeylc00awi1lww/mJS1SjP
         1lhmAmP8fdLZZkfeKu/UYFdtoy9ZwRMmYuNQskmDohdnyTZ8bcoKDiPnyxitlNScVD1R
         MSlFhiw6+nEqyJdIM65FGRLpv/kC+RdDLpcX+gl6qPoGcyGvTIBGC66wGKDAMIFsnYSi
         wZHXbfHwoodyA711pCxMApjfRtN3yU4TX9f5wtkFOQUujB0i2UnYGvQ65sTghDzfu/24
         jhLMFeAQPfd8iiTflzgzIpqte0AnZYWbFIFT7OlqXs04E3g6GMk0p9BTs/wrVKI6Pydw
         2wdw==
X-Gm-Message-State: AOAM533DnQqy6KNLLUaSbS2/1CYcaY01ccyDxcIC0u27R49o8Z90AgHS
        B+fthoW14X5ZGpg+AGTROWA=
X-Google-Smtp-Source: ABdhPJz582iYOOfu22DNRwo0+frZpajUNW3oeIIbuxUUybuyUHkGq/29RGVLC/Y0kldI4nbREuhuRQ==
X-Received: by 2002:a50:be8f:: with SMTP id b15mr39207157edk.200.1634510467146;
        Sun, 17 Oct 2021 15:41:07 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.145.195])
        by smtp.gmail.com with ESMTPSA id v10sm5475871ejk.112.2021.10.17.15.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 15:41:06 -0700 (PDT)
Message-ID: <9b4a54c6-8aad-628d-5369-71122987c87b@gmail.com>
Date:   Sun, 17 Oct 2021 22:41:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/5] cache request_queue pointer
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
References: <cover.1634219547.git.asml.silence@gmail.com>
 <dba463cb-3f1e-0972-aeaf-099d7c12bd0e@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <dba463cb-3f1e-0972-aeaf-099d7c12bd0e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 12:59, Jens Axboe wrote:
> On 10/14/21 8:03 AM, Pavel Begunkov wrote:
>> Cache request_queue in bdev and replace two derefs in
>> bdev->bd_disk->queue with bdev->bd_queue. Benchmarking
>> with nullblk gave me around +1% to peak perf.
>>
>> All patches are self contained and don't rely on others from
>> the set including 1/5 and can be taken separately. And some
>> changes go in separate patches to minimise conflicts. When
>> we agree on the approach, I'll send the rest converting some
>> other spots out of block.
> 
> Looks fine to me. Christoph, any concerns?
> 
> One note, though - s/fater/faster in patches 2..5 in the commit
> message.

Noted. I expect there will be a bunch of conflicts, I'll resend
it, hopefully once you refined and posted some of your stuff.

-- 
Pavel Begunkov
