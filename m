Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014BEB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 22:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGEWJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGEWJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 18:09:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A91706;
        Wed,  5 Jul 2023 15:09:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668704a5b5bso131001b3a.0;
        Wed, 05 Jul 2023 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688594996; x=1691186996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lFsQwF//38jWHnrkBreRY3DYLxAfwcffBzCccFGDkc=;
        b=pKFug/tCF1hiF4tuD4ksLuNsPr+aXfbg0HGbRuwDMXeKvg/Xsn7rD/1J5YJspemQJv
         Beegj9f0+uh9Jw5Hd3Hwv9f6BNHoTQfbx8DJ+a8xnDBbjp0Tgf327Y4IIzyniqD5HB98
         WUUd7Zt9HmXnteqeTsyBX6zVu1SVryIpxA2J9FXFStTtGqG8t2wp1XYE8g8ViiOpobtS
         UsqlJKroP3DBbgrn/JUwjl9dmTz5mXm7pSjsX75jmZOPhD74ahvWjdSuJ1YB7/VZN+KG
         gpn4F2vtRKPYdgpT7xtL9RYxmvjwWqmKnrGOUN+4dSMedulblqMDrUm1eDw99kLfWRK4
         4Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688594996; x=1691186996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lFsQwF//38jWHnrkBreRY3DYLxAfwcffBzCccFGDkc=;
        b=ZJIdBJ2opAAV6oZXiRWXN/b5YWe/Xz3ErPdrlAnS/rnFrOwnyrkZI6wEwNSKAwO8Gp
         54a3oe3ob7yYi/6KzvMjrq+MmPcOkqw9I7qiyltlcQPBg5q0ZQ+GoZQ5D6Q6bd7ubWYZ
         OtJeT9bcOz3FFQcqbk5qq2XW5uoEftdTUFQdohnVkVL5YZJTDRQHlNSDObBfWH/TgJ36
         Yzvl3gdvpXif/jnYjMhyuApWoK6oGdo75g69SbxlAnw+tfvVEtwTpNCRFWTCFoDSHTNM
         4yoY68Cm8kdkMbmGU22AmQ/sRG7YDj3gOzP0eZKClIa9eAJMmzXXIIn19oYD4pcxPSai
         Azvw==
X-Gm-Message-State: ABy/qLbjjc2M8CwbnNzlqvZR3R+ZBpWyepzUFUF+WCTyDp1k5WA3M26L
        vSYnws9ICF7f2cP+NEjQs6w=
X-Google-Smtp-Source: APBJJlEY/XbHp+5FIoUBstPlOlXa1a2LuDDoUe4y6DkVUYjK64IKJUlvN9gnk0qk9JGUfTIxZcFAKw==
X-Received: by 2002:a05:6a00:1790:b0:681:c372:5aa4 with SMTP id s16-20020a056a00179000b00681c3725aa4mr146009pfg.27.1688594996070;
        Wed, 05 Jul 2023 15:09:56 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:65c6:1730:4701:8c0b? ([2001:df0:0:200c:65c6:1730:4701:8c0b])
        by smtp.gmail.com with ESMTPSA id n4-20020aa79044000000b0063a04905379sm16414pfo.137.2023.07.05.15.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 15:09:55 -0700 (PDT)
Message-ID: <01cf1491-a9b3-2342-3fd6-f4cae212bc43@gmail.com>
Date:   Thu, 6 Jul 2023 10:09:50 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
 <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 6/07/23 09:44, Jens Axboe wrote:
> On 7/5/23 3:41?PM, Michael Schmitz wrote:
>> Hi Jens,
>>
>> On 6/07/23 08:42, Jens Axboe wrote:
>>> On 7/4/23 5:38?PM, Michael Schmitz wrote:
>>>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>>>> Cc: <stable@vger.kernel.org> # 5.2
>>> This is confusing - it's being marked for stable, but also labeled as
>>> fixing a commit that isn't even a release yet?
>> True - but as you had pointed out, the commit this fixes is set in
>> stone. How do we ensure this bugfix is picked up as well when the
>> other patches are backported? Does that  happen automatically, or do I
>> need to add a Link: tag to the patch being fixed?
> This:
>
> Cc: <stable@vger.kernel.org> # 5.2
>
> should be enough for it to go into stable from 5.2 and onwards.
OK - I wasn't certain whether you wanted the Fixes or stable tag dropped.
>> (Greg didn't seem to object to the Fixes: as such, just to the
>> incorrect version prereq)
> I think it's really confusing... A patch should only have a Fixes tag if
> it's fixing a specific bug in that patch. Either it is, in which case
> you would not need Cc stable at all since it's only in 6.5-rc, or it
It is fixing a bug in b6f3f28f60. I should have checked whether the 
patch series had already gone to release, not just -rc, instead of just 
adding the stable tag out of caution.
> isn't and you should just have the stable tag with 5.2+ as you already
> have.
>
> I'll apply this and remove the Fixes line, and the message id thing
> too.

Thanks - whatever is least confusing is fine, as long as it's backported 
to stable in the end.

Won't be sending v5 then...

Cheers,

     Michael



