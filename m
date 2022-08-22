Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DACC3F6B0
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 20:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiHVUik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiHVUij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 16:38:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9605D13D22;
        Mon, 22 Aug 2022 13:38:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso15150996pjl.1;
        Mon, 22 Aug 2022 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8+bbzyZJBA3STFYzhSS/rUuL8EtOuxDK7o0s5W9SIzk=;
        b=T3YrQWR1c83tFgmgmkexx1hcRmJLZ6l9aGjFRHH2JngMTvJ0nGH6F2/hy+pZZJJDhI
         eOzsBvUQY3dfosIQhZoD5GhSjh1xiYeADOrOQ0tuJt3n0nOZlOFqzDEWMdJmI3jSBDtS
         tNDCvSwtJIvcXpCr8V+iSH47iy27+MFzugdBFt/AjbR5+jJtPUCpCQBPmMxFqHChygia
         FSjCsvHaOpOy8Elvq8Jyc2UmfYqPT1Gyk4haVbzXWydpNVvWXW6oBbieRJED8lbcdsT5
         qjS2/G2r+szKMnrTHjkqjo6qmmssPhVC95YZh+mS1Idb3F7aAavSbJ8hkxbEdVUl4iGJ
         3QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8+bbzyZJBA3STFYzhSS/rUuL8EtOuxDK7o0s5W9SIzk=;
        b=IUGGDJ1qhjuHUUb/rqnvGG8PDJL2s1K5t+TEGHN9qUT0CEP9h97wSDUlOn+6YIzBdo
         PU2JbHe7+Z0xkHc0Xde49fva0RbFzXhLKZ9Qt0/VtEtjiaV6Or1gRQv01Tzy7lLOaTdV
         Crdro17ia207ZUMZWmHhp13AUCURxe1EgRuz9DcCSSxWfYDJ+D1froFlcJB/m9Q7dVF7
         6IKVk2Z0LpVofLjY+mhVivQtcDtKLoehUAKCc9tjteVGR9tGWVS3LhgW/QXzDBcOCJ37
         Gmxu4rKzHoSwF8ZnKMkQl+/9nI030VjMpIBomPsF+E0QbeeNWx9zp+aGmrHBlg9gqzmh
         NLsA==
X-Gm-Message-State: ACgBeo1C7XklQdMMJ0eBWQhwmOrFh23HwrAW/diOXx5v8zZXNX8YOE0i
        7YRZDeJkqI93CL/IICiLaTt32To8r4c=
X-Google-Smtp-Source: AA6agR786402sCYAz5zihq7rt7I3AziqCmMLoJRBciesipL+5ImGHp46yGBBYpdLgYcthhr0cN8xmg==
X-Received: by 2002:a17:902:cec1:b0:172:e677:553b with SMTP id d1-20020a170902cec100b00172e677553bmr7525994plg.99.1661200718077;
        Mon, 22 Aug 2022 13:38:38 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:642a:8878:46a3:c3df? ([2001:df0:0:200c:642a:8878:46a3:c3df])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0a8200b001fb08830742sm4581804pjw.44.2022.08.22.13.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:38:37 -0700 (PDT)
Message-ID: <81e8bd2a-bb3f-6da0-ed39-b522a6b822be@gmail.com>
Date:   Tue, 23 Aug 2022 08:38:32 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220726045747.4779-1-schmitzmic@gmail.com>
 <20220726045747.4779-3-schmitzmic@gmail.com> <Yt/TQOJQZEhZE+2p@infradead.org>
 <CAMuHMdWW1=kXC14H6iUFF61sMOnsbfXodKS=mpdNbCtvgvjqKA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdWW1=kXC14H6iUFF61sMOnsbfXodKS=mpdNbCtvgvjqKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

On 11/08/22 23:40, Geert Uytterhoeven wrote:
> Hi Christoph,
>
> On Tue, Jul 26, 2022 at 1:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>> On Tue, Jul 26, 2022 at 04:57:47PM +1200, Michael Schmitz wrote:
>>> The Amiga partition parser module uses signed int for partition sector
>>> address and count, which will overflow for disks larger than 1 TB.
>>>
>>> Use u64 as type for sector address and size to allow using disks up to
>>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>>> format allows to specify disk sizes up to 2^128 bytes (though native
>>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
>>> u64 overflow carefully to protect against overflowing sector_t.
>>>
>>> Bail out if sector addresses overflow 32 bits on kernels without LBD
>>> support.
>>>
>>> This bug was reported originally in 2012, and the fix was created by
>>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
>>> discussed and reviewed on linux-m68k at that time but never officially
>>> submitted (now resubmitted as separate patch).
>>> This patch adds additional error checking and warning messages.
>>>
>>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> --- a/block/partitions/amiga.c
>>> +++ b/block/partitions/amiga.c
>>>                if (!data) {
>>> -                     pr_err("Dev %s: unable to read RDB block %d\n",
>>> -                            state->disk->disk_name, blk);
>>> +                     pr_err("Dev %s: unable to read RDB block %llu\n",
>>> +                            state->disk->disk_name, (u64) blk);
>> No need for the various printk casts, a sector_t is always an
>> unsigned long long.
> That is true, as of commit 72deb455b5ec619f
> ("block: remove CONFIG_LBDAF") in v5.2.
> Since 4.9, 4.14, and 4.19 are still receiving stable updates, the
> cast should be re-added when this is backported.

Does this require a note in the commit message, or explicit CC to Greg?

Cheers,

     Michael

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
