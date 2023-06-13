Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1157EB64DA
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 22:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFMWMC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjFMWMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 18:12:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0761989;
        Tue, 13 Jun 2023 15:11:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-543d32eed7cso2667450a12.2;
        Tue, 13 Jun 2023 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686694312; x=1689286312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYvFV+rRgOj31IeXun1J8221rw1qfjApgNtLvJG7y7Q=;
        b=g6oqo0kB4RqVvgJXE0QBsLnZmfaeVLV+l/nEQHa9dCVc3AaW++OnDyFOxS3J8yvX10
         6xSlS2GKw/Mg7LqXLTQXt4QukLbmM7CbflpFLF5w+0gzrVnt8NxxOc0+cwbgai3R/jfa
         CPjJ6ZyzNE26HVrF4ZIK4C+bhTgPh6m3oVmjspzWRT3b7HiXS4++QJziJnTfuWaoFAZ2
         RFdNSvPk3TymroBRxpR0h9TsPGv7zj/mCwDIwumpT8EkXnUz40ejPxsLV4z1c+YnVkFq
         MoDWhzUy/tEusTvZ88TekCokvLf3hr7DMWJtBz5PaGbqVFuE1CvTVdzhfIw5Gd5NkEVX
         2xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686694312; x=1689286312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYvFV+rRgOj31IeXun1J8221rw1qfjApgNtLvJG7y7Q=;
        b=C1oQFg1hu0+mwRgrw7dALScxFzQRxBF7OtWWCFhVL+dTHX4gJJ7dlfdlZIZrh0QUOJ
         dn7Ncg1xVe/ZnlrKkd5uIBZGEsptL/9xoKejHNh2Pz5nklxavUHWh0DHsfi73j8m4+LG
         VcMttZyP1PRSzHV59PP18ZkkyPqJ0FRu5IlxuFZLssmodluV2o7WO+REhiboBH7/3WHB
         EjvNsFlsdr1gyynRkXQKf3e6nxip9aqqBn/tZCbrvaaYvSv/1uofSg8Qwiv7C5LIWLUP
         muevf01r+IDTE8dwg9IlhepA8V1hzhUCXyPwQPDGm1JRHBrMtaI2HM+i4P0mdtTz+d5C
         y4GQ==
X-Gm-Message-State: AC+VfDwwqvx92DG98lyVKZFqR+EnWz4Pl1J3rsK7aLkSBSXjpnlZTEna
        K9dsvFTd+dWqoq2OTZU4U3Q=
X-Google-Smtp-Source: ACHHUZ4gMeUCzbu/44eWvUPib9Y87vE0Hu8usy96+kGWbmGtvkVZvAJVVMsKshD4A1KfBHNyu0jjNg==
X-Received: by 2002:a17:90a:fd8b:b0:25b:d7e3:a018 with SMTP id cx11-20020a17090afd8b00b0025bd7e3a018mr16146pjb.35.1686694311786;
        Tue, 13 Jun 2023 15:11:51 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:ad3e:4a38:ffce:bee7? ([2001:df0:0:200c:ad3e:4a38:ffce:bee7])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b0025c03008555sm2884069pjh.4.2023.06.13.15.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 15:11:51 -0700 (PDT)
Message-ID: <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
Date:   Wed, 14 Jun 2023 10:11:45 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <4814181.GXAFRqVoOG@lichtvoll.de>
 <12241273-9403-426e-58ed-f3f597fe331b@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <3748744.kQq0lBPeGt@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

On 13/06/23 22:57, Martin Steigerwald wrote:
> Michael Schmitz - 13.06.23, 10:18:24 CEST:
>> Am 13.06.2023 um 19:25 schrieb Martin Steigerwald:
>>> Hi Michael, hi Jens, Hi Geert.
>>>
>>> Michael Schmitz - 22.08.22, 22:56:10 CEST:
>>>> On 23/08/22 08:41, Jens Axboe wrote:
>>>>> On 8/22/22 2:39 PM, Michael Schmitz wrote:
>>>>>> Hi Jens,
>>>>>>
>>>>>> will do - just waiting to hear back what needs to be done
>>>>>> regarding
>>>>>> backporting issues raised by Geert.
>>>>> It needs to go upstream first before it can go to stable. Just
>>>>> mark
>>>>> it with the right Fixes tags and that will happen automatically.
>>> […]
>>>
>>>> thanks - the Fixes tag in my patches refers to Martin's bug report
>>>> and won't be useful to decide how far back this must be applied.
>>>>
>>>> Now the bug pre-dates git, making the commit to 'fix'
>>>> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit
>>>> special, please yell if you want me to lie about this and use a
>>>> later commit specific to the partition parser code.
>>> After this discussion happened I thought the patch went in. However…
>>> as John Paul Adrian asked in "Status of affs support in the kernel
>>> and affstools" thread on linux-m68k and debian-68k mailing list, I
>>> searched for the patch in git history but did not find it.
>> I may have messed that one up, as it turns out. Last version was v9
>> which I had to resend twice, and depending on what Jens uses to keep
>> track of patches, the resends may not have shown up in his tool. I
>> should have bumped the version number instead.
>>
>> I'll see if my latest version still applies cleanly ...
> Many thanks!
>
> Would be nice to see it finally go in.
My last version (v9) still applies, but that one still threw a sparse 
warning for patch 2:

Link:https://lore.kernel.org/all/202208231319.Ng5RTzzg-lkp@intel.com

Not sure how to treat that one - rdb_CylBlocks is not declared as big 
endian so the warning is correct, but as far as I can see, for all 
practical purposes rdb_CylBlocks would be expected to be in big endian 
order (partition usually prepared on a big endian system)?

I can drop the be32_to_cpu conversion (and would expect to see a warning 
printed on little endian systems), or force the cast to __be32. Or 
rather drop that consistency check outright...

Cheers,

     Michael

>
> Best,
