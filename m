Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA23EC4332F
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiDRN7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbiDRN5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 09:57:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3722AC78
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 06:06:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so16737384ljb.2
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:references:from
         :in-reply-to:content-transfer-encoding;
        bh=ir6p9qR6i3Lf2PnQ+lXVT9cyaA0B4G3OxK1MKpNTHKI=;
        b=GbZCV4Jy3veDwuv5swETs0LY36CQTAjPT9A9mfgofncNEQfTODzrb8UF5iQbMu3Cfd
         djpXL044CCjuJBzcMNFn21kP2zaSjJdcOomHsAkZVzeMRO0GHSEf+M0mBoEjXsF+oh4H
         8eKBKUos1s5e5+BcbkGAA+g1eqevvhou5Oya3RJ/Bzfmgp1bkCKGpGF5UhYrPaHV80Av
         JsRa9IiiuaKm1w4M1PSA4viRSgysIkjjCLzHKcGlED8/MjuGebMHLDjEXdQc7dYmz9h5
         oOUVjDD5hVZqTuUKgLG2yfZNBVUQ/dr20TuYSceFS/GfF4jp7QAhNmdij5ZnL1GX4bJ3
         PkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=ir6p9qR6i3Lf2PnQ+lXVT9cyaA0B4G3OxK1MKpNTHKI=;
        b=3hK3ooZLX1qNfGYQHVJtF9xXQ7uqCSCLpNuQgkt5F0PYE80JNyamiOF053Jv/c+SkT
         RzBP/+PQOfRD/aHvB4H5jJOgl+k8Y+nkX1rg4uPC5dIUoCJ9ojdJVuNnwSwlcF3gE/rI
         v/SCsb9XuUNRpfUfhb0SUIx6Fb8Nn61ILuckWFBDupQa8nv7te3J4IrDA5JDkaCDWnhr
         VrV8491hVb6v5TZXtfsAiY1DQJHn8Cee0Lb8ZXsUeHl1rDNJNleYaXhesPkViUx5drWw
         afxTSAJ742j//t/nEo9sv/81WYkGPDy/iQiEZcBcsm1xs/fgYOwqKcfxSAW46wdaoClr
         mICg==
X-Gm-Message-State: AOAM532ZHC8pUD2guRX9lbLMFau1o0WjOvMjC+qESw6FdqxEVgTrFolg
        A4t1ttNIJHEYWvWdDR7Ram70P/V4AFs6yQ==
X-Google-Smtp-Source: ABdhPJzm3HSLEnjcYa9iv6di0SjGbytLsUqwpX2B24OLlLrgWDd585ZYRjyYdDvUpE+2zbaVhEBRog==
X-Received: by 2002:a2e:88c8:0:b0:24d:b907:d71e with SMTP id a8-20020a2e88c8000000b0024db907d71emr4174962ljk.431.1650287213249;
        Mon, 18 Apr 2022 06:06:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a302:88ff::1? (dzpbkv-4yyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:a302:88ff::1])
        by smtp.gmail.com with ESMTPSA id p11-20020a19604b000000b0046fb725b88fsm929812lfk.224.2022.04.18.06.06.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 06:06:52 -0700 (PDT)
Message-ID: <b975d3aa-e5b1-c16d-1820-4de5d84576cc@gmail.com>
Date:   Mon, 18 Apr 2022 16:06:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Question] Accessing read data in bio request
To:     linux-block@vger.kernel.org
References: <CAH4tiUtGuZP6QnO6L9EEDFL08O-UusHihO6CbvEf-QwJM3QPCg@mail.gmail.com>
 <eab14c0a-dd66-555c-8830-d23a5068273c@kernel.dk>
From:   Jasper Surmont <surmontjasper@gmail.com>
In-Reply-To: <eab14c0a-dd66-555c-8830-d23a5068273c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Okay thanks! So does this mean that you would suggest doing it with 
bvec_kmap_local()?
Or are there other, maybe better, methods?

Thanks!

On 18/04/2022 04:59, Jens Axboe wrote:
> On 4/14/22 8:15 AM, Jasper Surmont wrote:
>> I'm writing a device mapper target, and on a bio (read) request I want
>> to access (for example just logging) the data that was just read (by
>> providing a callback to bio->bio_end_io).
>>
>> I've figured out I could read the data by using bvec_kmap_local() on
>> each bio_vec to get a pointer to the data. However, if my
>> understanding is correct this seems like an unefficient way: if the
>> bio just finished a read then shouldn't the data already be mapped
>> somewhere? If so, where?
> Not necessarily - if you're doing passthrough or O_DIRECT IO, then
> no mapping necessarily exists for any part of the IO.
>
>
