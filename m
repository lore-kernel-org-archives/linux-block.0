Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE4C0015E
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 23:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGEXy5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEXy5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 19:54:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2A10F5;
        Wed,  5 Jul 2023 16:54:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b32c1dd1so30095ad.0;
        Wed, 05 Jul 2023 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688601295; x=1691193295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI7G8VKZliJvT8wrQBOaRM/M+f2koQckOLP4AY19Wnw=;
        b=dOO8/TZKvsFtOSOZ9smn/JIyCXYmCtuywHWOEfLn9bLjMaR81+2xAtCyywI9ct2wPl
         VpkmwaGm8g3Qo9AJ5pTgj7h/4RwtSndZAPL72irWMha/k6WDquK4qtjiko2M+corz74v
         GORzdchAJBhH+DUWIhl1d4AQ5Ceuv9u2vEJqy70lCSDlxHKLUwKHo1zJFmENqtueVPpO
         S+3X1fT0i+p/M9zNk6nc0BXxqWMLvdLNFoSv0dSu5lM3tV00An4juTnQtLZ0kWDhJ/Q+
         JLFYfZ1/4fPMtCd+87b1GrQpP7fec2zTS8QiayQpwRP9T1HDY9PR/yV6+5afVSHrN+Gm
         J+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688601295; x=1691193295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JI7G8VKZliJvT8wrQBOaRM/M+f2koQckOLP4AY19Wnw=;
        b=UJWcXGNj1gJZTI3j29rn8NA8zUkaDxrpxSs2prj8k48DzdzA25aktGiGip5qfpyiQK
         Vhdq4JjnvgtjYVxnuLmKS8g9iVRoEmvC6nUH0uiJ0W7qsCJqmxEHVHqzjA5eOZVaDiRi
         bVhp0IefxxViysI6lUm89ab0VPlb6AFZgmAdGD/dUPZ1/Ag1EFG0VuTR0/B04NNyhMZA
         v1AZqVhzVmPUnTaVtWVoeEIAfuZOkWg5jnlL9U23Ji6ZdXI0ev5oHx2cyICp+RI4nk9p
         0DG8kVtd+zaf7mr3Rng6gXIS1/dcD/9dc/UOmbWeelgA2VVkQaLlpNzGn9JCWZhgUkvU
         ge0A==
X-Gm-Message-State: ABy/qLbUIQn1QU7WVsYbCA735VrGsTTiFkEM41LT6NOA89dsPpHIeg88
        eEeteoljs6eaqSxLFeaq45s=
X-Google-Smtp-Source: APBJJlGCPm5vP+V750hjMd/G8MliyrZQNXiUg4q5e6pqMUKCJIpRI0Vy0dN7odpn8973xtXSXF40Bw==
X-Received: by 2002:a17:903:110d:b0:1b3:d6c8:7008 with SMTP id n13-20020a170903110d00b001b3d6c87008mr394660plh.57.1688601295526;
        Wed, 05 Jul 2023 16:54:55 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:65c6:1730:4701:8c0b? ([2001:df0:0:200c:65c6:1730:4701:8c0b])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001b87bedcc6fsm48194plr.93.2023.07.05.16.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 16:54:54 -0700 (PDT)
Message-ID: <e15fb0c5-d9d2-454d-9741-32dd9bae58b8@gmail.com>
Date:   Thu, 6 Jul 2023 11:54:49 +1200
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
 <01cf1491-a9b3-2342-3fd6-f4cae212bc43@gmail.com>
 <49192b95-8fc8-7dcd-f062-a4876731e347@kernel.dk>
 <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
 <481c0e2a-320c-e53d-2a0e-ba5fa6ea4049@kernel.dk>
 <c9bcd3ca-8260-3f29-26d1-0c00e2b098a3@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <c9bcd3ca-8260-3f29-26d1-0c00e2b098a3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

thanks for patching this all up!

On 6/07/23 10:38, Jens Axboe wrote:
> On 7/5/23 4:34?PM, Jens Axboe wrote:
>> On 7/5/23 4:25?PM, Michael Schmitz wrote:
>>> Hi Jens,
>>>
>>> On 6/07/23 10:13, Jens Axboe wrote:
>>>>>> should be enough for it to go into stable from 5.2 and onwards.
>>>>> OK - I wasn't certain whether you wanted the Fixes or stable tag dropped.
>>>>>>> (Greg didn't seem to object to the Fixes: as such, just to the
>>>>>>> incorrect version prereq)
>>>>>> I think it's really confusing... A patch should only have a Fixes tag if
>>>>>> it's fixing a specific bug in that patch. Either it is, in which case
>>>>>> you would not need Cc stable at all since it's only in 6.5-rc, or it
>>>>> It is fixing a bug in b6f3f28f60. I should have checked whether the
>>>>> patch series had already gone to release, not just -rc, instead of
>>>>> just adding the stable tag out of caution.
>>>> But this is the confusion - if it's fixing a bug in b6f3f28f60, then why
>>>> is it marked as needing to get backported much further back, predating
>>>> that commit?
>>> I see - it doesn't need to be backported that far back _alone_. It
>>> only needs to be applied after  b6f3f28f60 once that one has been
>>> backported.
>> OK I see - I think there's some serious misunderstandings here then :-)
That's probably understating it. I need to reread the patch submission 
notes.
>> It sounds like it fixes a bug in b6f3f28f60 alone, and it has no
>> business going into stable. The commit should _just_ be marked with it
>> fixing that. If someone were to backport that previous series, then
>> their tooling or diligence should notice this dependency and this
>> current commit should be picked as well.
>>
>> There should be no Cc: stable on this patch at all, I'll fix it up.
> Here's what I have:
>
> https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=7eb1e47696aa231b1a567846bbe3a1e1befe1854
>
> which has the following manual edits:
>
> 1) Change the title/subject line of the patch. "bugfix for Amiga
> partition overflow check patch" means very little. The fact that this
> patch is a bug fix for a previous commit is explicit with the Fixes
> line.
>
> 2) Break lines at 72-74 chars, yours were very short.
Somehow a limit of 60 had stuck in my mind.
>
> 3) Drop message-id
>
> 4) Drop cc stable tag
>
> 5) Drop the revision history. This should be behind three '---' lines
> and then it's dropped automatically.

Argh - looks like I've made that mistake more often than not in the past 
few years. I'll remember that now.

>
> Let's hope this is it for Amiga partition handling!

I should certainly hope so!

Cheers,

     Michael

