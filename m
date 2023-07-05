Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABBDEB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 19:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjGET0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjGET0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 15:26:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074981FC8;
        Wed,  5 Jul 2023 12:25:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b88e99673eso20293765ad.0;
        Wed, 05 Jul 2023 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688585144; x=1691177144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTGMwlxjgIPq8hZWcJugZVRyWJlTrNPe6BjOWeskKkQ=;
        b=IdaCeINzlEstyZdIRrW1hrj/uikDvLoD+ntjJFEkwGd79Q7MKOjhKmEA73WeIyRvbI
         g6nVv95XkK5m16cKDnjNKQUznZ0/KJtafjae66vbWA6HoT4e/p/wUvuJ/ENayCyGsVB6
         6EfUBjUmy3f1dzBjWq68KPlev9BbRLQ2XJzGtHBEbE127pHt5CvZKIdtO1Vdguk11V4q
         V17GMbXN3v313T88M/i2wtxHFDgE2KfQrsZMlcj3wz2qUyIkiymeKA+7N1jjpKPywt1f
         l5bPqPJrYFxNY50pGPkY8b3kylKDeQXHyFZbQPWzh9NcIYZR8lQBuC3UxTao95E5U4rk
         dKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585144; x=1691177144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTGMwlxjgIPq8hZWcJugZVRyWJlTrNPe6BjOWeskKkQ=;
        b=Ney9F6zA1PlzHW4wX5JcnRXUF9YcM9HbosybN28hQkGOHx+gKjvqJWpJ3VvogkBzCJ
         taL92+uaL1QaT7526bQhrdfKN1GwQ42gnwLumQgQFa4Az+W6AZ3jSmJ1sqi6i5nhnYMF
         sAkXbzh3jZ92L+iPHB+NTLAktNB2phHKhPsIvFAAEaGpMqo3/u40Ok6yZAbShz9ThwQL
         D3EK7IuQxzRijX5ru8jo5c1BN8A1xJcPFvIeQiJLMgPqqh0UgRN6+ayaJm99RVXCXVvk
         JFiUazT/aq/X0nBnPP+QsnxZwzokZ9cVH3UZUVleajRCddsagZImZFmFd2pllqtjABK3
         kKVg==
X-Gm-Message-State: ABy/qLbhfLcP8T/KbHCJxvBIiIk4Vp4b45Y6CByn1Cj17lwz8er3DlL6
        YHZJKJ/6bhLoYf7/sPkkqbU=
X-Google-Smtp-Source: APBJJlG/WjX8Z3w2uqyocC+CIuHSwtffE8uNfDgHFT1bNCVIVr7VbfKRJI28WHBFFlO8DtlJiQwRgw==
X-Received: by 2002:a17:902:c246:b0:1b6:b95d:768e with SMTP id 6-20020a170902c24600b001b6b95d768emr14021958plg.32.1688585144408;
        Wed, 05 Jul 2023 12:25:44 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:65c6:1730:4701:8c0b? ([2001:df0:0:200c:65c6:1730:4701:8c0b])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001b6674b6140sm19314212pll.290.2023.07.05.12.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 12:25:43 -0700 (PDT)
Message-ID: <def97c03-533d-4ce0-4303-e8465233bd7c@gmail.com>
Date:   Thu, 6 Jul 2023 07:25:37 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <CAMuHMdUc-mqHC80euFrXLGGJO3gLW3ywu2aG4MDQi5ED=dWFeQ@mail.gmail.com>
 <06995206-5dc5-8008-ef06-c76389ef0dd8@gmail.com>
 <CAMuHMdVGNB_aZnDHw_wfDTinDk+LKkP1Lx96Cgm0jM6J1WdACQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdVGNB_aZnDHw_wfDTinDk+LKkP1Lx96Cgm0jM6J1WdACQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

On 5/07/23 21:08, Geert Uytterhoeven wrote:
>
>>>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>>>> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>>> Please drop this line.
>> Because it's redundant, as I've also used Link:?
> (That, too ;-)
>
> Because the use of the Message-ID: tag in patches is not documented.

Now I wonder where I picked up that habit ...

> IIRC, it might also cause issues when applying, as the downloaded patch
> will appear to have two Message-IDs.
That's correct (if you refer to a patch in mbox format), but from the 
context of the two Message-ID lines, it ought to be clear which one 
matters.
> I'm not sure the sample git hook in Documentation/maintainer/configure-git.rst
> (and all variants the various maintainers are using) handles this correctly.

You're right, it won't check for context there.

In this particular instance, it won't use my Message-ID tag anyway 
though (forgot the angle brackets).

I'll fix that in v5 later.

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
