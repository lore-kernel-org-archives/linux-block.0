Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23951EB64DB
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 19:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjFNTqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFNTql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 15:46:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C4268B;
        Wed, 14 Jun 2023 12:46:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-662f0feafb2so34604b3a.1;
        Wed, 14 Jun 2023 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686771986; x=1689363986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0/h5UvpkgDq5M0U5ADRQZBtCF8xt6myQegN9qs09bc=;
        b=FV+A7zf9/CXU7ydZcmrEaUyaenGpTIDlI4uOHTglxLzVD1dPxllE5Z7hrhfiaRZGyW
         TVeEm8UD0+Ousp6BcqEtlPjhbwPipPGDqAh0h5cw4ZOywPfwOzVYQxxZcWMhUYrcS1uk
         duYpt1nJHP9cGAWEOEForWKIcxSNLsbcP0CbzRwPbxoI4uCxVIDTGL5TzL8a+95ErUrJ
         pDh44cQ8SPjx11YJp8CU/bVm0dcyaJHlAur2DI6ByB3+8OC3MqJeo7Qm4MvKcDBXHbdE
         QY8zmzwvbEyUzE6vw/mfJ1Q4m5ggeJz+AtfLGp2rLgt+fo3zWPMhDzCVHYdbJzxE+WZk
         CZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771986; x=1689363986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0/h5UvpkgDq5M0U5ADRQZBtCF8xt6myQegN9qs09bc=;
        b=a/tsAYiBQhB2/wtQbcUEBi1Ti4/l4kTD2Qw3bFCDBMlHL4Weq66Rj8nzwJZFUOmTTQ
         /WCkvypkMPm2OQrtdg2FQQfzrnEW/ezQpqlDqwr7CZzyalR4jiJMpen2Gofu1SKyfiY/
         Rsumxdliq6nmLtIRaiBWF0qjMnLAofAG6aDwBqtTT0SkCfST3uUpPW4CJ1e0Eiykkmsn
         UZTDkwfLyY9uLhbhdpbg7JMZx1t/DAgLTtlqjAfECzPa7R7FfWI3bdt+7/Nnod6AM8aH
         +PWlatarjca00GsaOLecrCutBi2CWpywUhG4nTFmYOAUiADX+89fAcsC/c/lLZ8y9eC3
         Eu6A==
X-Gm-Message-State: AC+VfDyZfPxTAacuHKEsiTRlHYRIhDIXbqNR2uVzyCjNoC1tP/ZVOSIh
        d3X853SOT6fbQb4RQ4b3qv8=
X-Google-Smtp-Source: ACHHUZ694L+Ntr1Qfx3gZD7XLTcwyAOGDRHrVXhsBK5be0yAntUsugVZA39nwFdDJOvGLy3ay5R+vA==
X-Received: by 2002:a05:6a20:3945:b0:119:4141:6989 with SMTP id r5-20020a056a20394500b0011941416989mr3397465pzg.13.1686771986308;
        Wed, 14 Jun 2023 12:46:26 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:5447:d1ff:c6bd:ec5d? ([2001:df0:0:200c:5447:d1ff:c6bd:ec5d])
        by smtp.gmail.com with ESMTPSA id z17-20020a631911000000b00548fb73874asm9935996pgl.37.2023.06.14.12.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 12:46:25 -0700 (PDT)
Message-ID: <d535f282-faae-8dff-608a-5566315f3bf4@gmail.com>
Date:   Thu, 15 Jun 2023 07:46:20 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     jdow <jdow@earthlink.net>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
 <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
 <4507409.LvFx2qVVIh@lichtvoll.de>
 <98267647-af04-d463-cb5d-c5d6b0a05777@gmail.com>
 <05bd2c1b-a985-d935-a955-06a048d54c18@earthlink.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <05bd2c1b-a985-d935-a955-06a048d54c18@earthlink.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Joanne,

this is about the 2 TB disk issue - 32 bit integer overflow on 
start_sect and nr_sects. The fix for that never went in.

Thanks for confirming everything in the RDB is meant to be big endian.

On 14/06/23 20:54, jdow wrote:
>
> The patch I did a LONG time ago read the RDBs correctly. I presume it 
> was removed from the kernel build and lost? (I fixed what had been 
> there because it would not mount some of my disks. RDBs permit some 
> very um "unsavory" things such as nested partitions.)
>
The other 'unsavoury' thing that worries us here is the fact that the 
number of heads and sectors (per cylinder) is defined in the partition 
block as well as in the RDB. We use the data from the partition block to 
calculate start sector and number of sectors for a partition, and my 
overflow checking path added a test that heads*sectors ==  
rdb_CylBlocks. I wonder how important that test is - do you know of any 
case where the head and sector numbers in RDB and partition blocks differ?

Thanks again,

     Michael

>  {^_^}
>
> On 20230614 01:43:32, Michael Schmitz wrote:
>> Hi Martin,
>>
>> Am 14.06.2023 um 19:19 schrieb Martin Steigerwald:
>>> Hi Michael, hi Joanne.
>>>
>>> @Joanne: I am cc'ing you in this patch as I bet you might be able to
>>> confirm whether the rdb_CylBlocks value in Amiga RDB is big endian. I
>>> hope you do not mind. I would assume that everything in Amiga RDB is 
>>> big
>>> endian, but I bet you know for certain.
>>>
>>> Michael Schmitz - 14.06.23, 00:11:45 CEST:
>>>> On 13/06/23 22:57, Martin Steigerwald wrote:
>>>>> Michael Schmitz - 13.06.23, 10:18:24 CEST:
>>>>>> Am 13.06.2023 um 19:25 schrieb Martin Steigerwald:
>>>>>>> Hi Michael, hi Jens, Hi Geert.
>>>>>>>
>>>>>>> Michael Schmitz - 22.08.22, 22:56:10 CEST:
>>>>>>>> On 23/08/22 08:41, Jens Axboe wrote:
>>>>>>>>> On 8/22/22 2:39 PM, Michael Schmitz wrote:
>>>>>>>>>> Hi Jens,
>>>>>>>>>>
>>>>>>>>>> will do - just waiting to hear back what needs to be done
>>>>>>>>>> regarding
>>>>>>>>>> backporting issues raised by Geert.
>>>>>>>>>
>>>>>>>>> It needs to go upstream first before it can go to stable. Just
>>>>>>>>> mark
>>>>>>>>> it with the right Fixes tags and that will happen automatically.
>>>>>>>
>>>>>>> […]
>>>>>>>
>>>>>>>> thanks - the Fixes tag in my patches refers to Martin's bug
>>>>>>>> report
>>>>>>>> and won't be useful to decide how far back this must be applied.
>>>>>>>>
>>>>>>>> Now the bug pre-dates git, making the commit to 'fix'
>>>>>>>> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit
>>>>>>>> special, please yell if you want me to lie about this and use a
>>>>>>>> later commit specific to the partition parser code.
>>>>>>>
>>>>>>> After this discussion happened I thought the patch went in.
>>>>>>> However…
>>>>>>> as John Paul Adrian asked in "Status of affs support in the kernel
>>>>>>> and affstools" thread on linux-m68k and debian-68k mailing list, I
>>>>>>> searched for the patch in git history but did not find it.
>>>>>>
>>>>>> I may have messed that one up, as it turns out. Last version was v9
>>>>>> which I had to resend twice, and depending on what Jens uses to
>>>>>> keep
>>>>>> track of patches, the resends may not have shown up in his tool. I
>>>>>> should have bumped the version number instead.
>>>>>>
>>>>>> I'll see if my latest version still applies cleanly ...
>>>>>
>>>>> Many thanks!
>>>>>
>>>>> Would be nice to see it finally go in.
>>>>
>>>> My last version (v9) still applies, but that one still threw a sparse
>>>> warning for patch 2:
>>>>
>>>> Link:https://lore.kernel.org/all/202208231319.Ng5RTzzg-lkp@intel.com
>>>>
>>>> Not sure how to treat that one - rdb_CylBlocks is not declared as big
>>>> endian so the warning is correct, but as far as I can see, for all
>>>> practical purposes rdb_CylBlocks would be expected to be in big endian
>>>> order (partition usually prepared on a big endian system)?
>>>
>>> While I did not specifically check myself I would be highly 
>>> surprised in
>>> case anything in RDB data structure would be little endian. Amiga is a
>>> big endian platform. I'd expect little endian only to be used where
>>> there was need to interface with little endian platforms – like in PC
>>> emulators.
>>
>> That's what I thought - mind you, rdb_CylBlocks is not declared 
>> little endian, just __u32 which can be either.
>>
>> The reason why only rdb_SummedLongs, rdb_BlockBytes and 
>> rdb_PartitionList are explicitly declared big endian is probably 
>> quite simple - nothing else was used by the Linux RDB parser. My 
>> patch adds rdb_CylBlocks to that list, so that ought to be changed to 
>> big endian, too.
>>
>> affs_hardblocks.h is a UAPI header - what are the rules and 
>> ramifications around changes to those? Might not be worth the hassle 
>> in the end.
>>
>>> It may not be easy to find any confirmation in developer documentation,
>>> I'd assume that wherever it would not have been stated differently, big
>>> endian is assumed for AmigaOS.
>>>
>>>> I can drop the be32_to_cpu conversion (and would expect to see a
>>>> warning printed on little endian systems), or force the cast to
>>>> __be32. Or rather drop that consistency check outright...
>>>
>>> So "be32_to_cpu" converts big to little endian in case the CPU
>>> architecture Linux runs on is little endian?
>>
>> Correct - in order to use RDB partitions on little endian systems, 
>> all of the data used by the Linux kernel must be converted to host 
>> byte order before using them in calculations.
>>
>>>
>>> Well again… I'd say it is safe to assume that anything in Amiga RDB is
>>> big endian.
>>
>> Let's do that then. Unless someone feels strongly otherwise, I'll 
>> drop the rdb_CylBlocks check.
>>
>> Cheers,
>>
>>     Michael
>>
>>>
>>> Best,
>>>
