Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F9FEB64DB
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 08:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbjFNInx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbjFNInn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 04:43:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCA1FF7;
        Wed, 14 Jun 2023 01:43:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3c578c602so22984335ad.2;
        Wed, 14 Jun 2023 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686732219; x=1689324219;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4Bs/PAPewAld+aW9rD9XKg3d5bhqgzcFi6pB2zrKLM=;
        b=P+L8bIAU310D9e9BP5BgfuTm4dD7YfbyCENN4mWVtz9PPuT1VE9Pt1fugnSANjSHS+
         qvuCwi/XaWbp4dV/6i9HkoZAJC64v2dwjcYkD41xW7zOScCzOx7KRiXMxzy5rurlFprO
         SGMGrnJHlZN+4pmqehXDnFncPKmzZm1IEK3fDMEUL3nh/QtsSbdc0hU35TAwdoCMQzcV
         u13mExyCZxubaZ9rkzEnX3VfiZHdaMweqlcR+7DwfBfmk4A4Usv7KxlkzIPu3co5yqg/
         XTXqoLHJUW5JvU0HVNxg4Ko7Se3AWMhahiSqquiRf/Eay408uJVXu440wrU0o8UECZMf
         nNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732219; x=1689324219;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4Bs/PAPewAld+aW9rD9XKg3d5bhqgzcFi6pB2zrKLM=;
        b=kcIg6JxRAwVMbOACLXcqC1cMaBJRFAzjsHhXBXElV5PanTEAoBEsUXHKCMPeX/JOU9
         RjlmqK7KbTu4h7mr34rDWwP/0wFIkqL0XmcMA9L18/efqi41k+4A/ZxulJbBHqSFWxmn
         V7ruMCMNwqE0MSum5xur8BXuXTMec0E+FgQu9zeUNPWEtBDcETpsr3KYqwOu1XeBMbc4
         CzLVduahvnDl0R5L5TO9pgNHiwCiKmymS6/E+JafbseeaqzpBg6kTClFowBv+ZjViJuB
         52cBbgdeRq/twT1+zU1YVUBJdjcDLKVm6yGCW3KXit9Xz4W2iSc5WAtxriA4cZMV7ML+
         1rmA==
X-Gm-Message-State: AC+VfDz9jpOQIF50ru1PizvAABfiIoRYrbP3cDlB2+pjTSjCTNTLMibE
        9lWFAGzwkWyDmy3c7nTi988=
X-Google-Smtp-Source: ACHHUZ60PZyEd889M6yQmNdq0F8KCEl4UQITL7rIk1vnYN10tDDwoZpQuQj5gAKMtH6RUs54Y7h82Q==
X-Received: by 2002:a17:903:41ce:b0:1ac:8837:df8 with SMTP id u14-20020a17090341ce00b001ac88370df8mr13414287ple.6.1686732219328;
        Wed, 14 Jun 2023 01:43:39 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001b39ffff838sm7858769plk.25.2023.06.14.01.43.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:43:38 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
 <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
 <4507409.LvFx2qVVIh@lichtvoll.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        Joanne Dow <jdow@earthlink.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <98267647-af04-d463-cb5d-c5d6b0a05777@gmail.com>
Date:   Wed, 14 Jun 2023 20:43:32 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <4507409.LvFx2qVVIh@lichtvoll.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

Am 14.06.2023 um 19:19 schrieb Martin Steigerwald:
> Hi Michael, hi Joanne.
>
> @Joanne: I am cc'ing you in this patch as I bet you might be able to
> confirm whether the rdb_CylBlocks value in Amiga RDB is big endian. I
> hope you do not mind. I would assume that everything in Amiga RDB is big
> endian, but I bet you know for certain.
>
> Michael Schmitz - 14.06.23, 00:11:45 CEST:
>> On 13/06/23 22:57, Martin Steigerwald wrote:
>>> Michael Schmitz - 13.06.23, 10:18:24 CEST:
>>>> Am 13.06.2023 um 19:25 schrieb Martin Steigerwald:
>>>>> Hi Michael, hi Jens, Hi Geert.
>>>>>
>>>>> Michael Schmitz - 22.08.22, 22:56:10 CEST:
>>>>>> On 23/08/22 08:41, Jens Axboe wrote:
>>>>>>> On 8/22/22 2:39 PM, Michael Schmitz wrote:
>>>>>>>> Hi Jens,
>>>>>>>>
>>>>>>>> will do - just waiting to hear back what needs to be done
>>>>>>>> regarding
>>>>>>>> backporting issues raised by Geert.
>>>>>>>
>>>>>>> It needs to go upstream first before it can go to stable. Just
>>>>>>> mark
>>>>>>> it with the right Fixes tags and that will happen automatically.
>>>>>
>>>>> […]
>>>>>
>>>>>> thanks - the Fixes tag in my patches refers to Martin's bug
>>>>>> report
>>>>>> and won't be useful to decide how far back this must be applied.
>>>>>>
>>>>>> Now the bug pre-dates git, making the commit to 'fix'
>>>>>> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit
>>>>>> special, please yell if you want me to lie about this and use a
>>>>>> later commit specific to the partition parser code.
>>>>>
>>>>> After this discussion happened I thought the patch went in.
>>>>> However…
>>>>> as John Paul Adrian asked in "Status of affs support in the kernel
>>>>> and affstools" thread on linux-m68k and debian-68k mailing list, I
>>>>> searched for the patch in git history but did not find it.
>>>>
>>>> I may have messed that one up, as it turns out. Last version was v9
>>>> which I had to resend twice, and depending on what Jens uses to
>>>> keep
>>>> track of patches, the resends may not have shown up in his tool. I
>>>> should have bumped the version number instead.
>>>>
>>>> I'll see if my latest version still applies cleanly ...
>>>
>>> Many thanks!
>>>
>>> Would be nice to see it finally go in.
>>
>> My last version (v9) still applies, but that one still threw a sparse
>> warning for patch 2:
>>
>> Link:https://lore.kernel.org/all/202208231319.Ng5RTzzg-lkp@intel.com
>>
>> Not sure how to treat that one - rdb_CylBlocks is not declared as big
>> endian so the warning is correct, but as far as I can see, for all
>> practical purposes rdb_CylBlocks would be expected to be in big endian
>> order (partition usually prepared on a big endian system)?
>
> While I did not specifically check myself I would be highly surprised in
> case anything in RDB data structure would be little endian. Amiga is a
> big endian platform. I'd expect little endian only to be used where
> there was need to interface with little endian platforms – like in PC
> emulators.

That's what I thought - mind you, rdb_CylBlocks is not declared little 
endian, just __u32 which can be either.

The reason why only rdb_SummedLongs, rdb_BlockBytes and 
rdb_PartitionList are explicitly declared big endian is probably quite 
simple - nothing else was used by the Linux RDB parser. My patch adds 
rdb_CylBlocks to that list, so that ought to be changed to big endian, too.

affs_hardblocks.h is a UAPI header - what are the rules and 
ramifications around changes to those? Might not be worth the hassle in 
the end.

> It may not be easy to find any confirmation in developer documentation,
> I'd assume that wherever it would not have been stated differently, big
> endian is assumed for AmigaOS.
>
>> I can drop the be32_to_cpu conversion (and would expect to see a
>> warning printed on little endian systems), or force the cast to
>> __be32. Or rather drop that consistency check outright...
>
> So "be32_to_cpu" converts big to little endian in case the CPU
> architecture Linux runs on is little endian?

Correct - in order to use RDB partitions on little endian systems, all 
of the data used by the Linux kernel must be converted to host byte 
order before using them in calculations.

>
> Well again… I'd say it is safe to assume that anything in Amiga RDB is
> big endian.

Let's do that then. Unless someone feels strongly otherwise, I'll drop 
the rdb_CylBlocks check.

Cheers,

	Michael

>
> Best,
>
