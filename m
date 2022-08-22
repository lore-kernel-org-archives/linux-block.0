Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED8C32792
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiHVVJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiHVVJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 17:09:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF597CE2D;
        Mon, 22 Aug 2022 14:09:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 202so10495783pgc.8;
        Mon, 22 Aug 2022 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gz4TjFfRMy/GKJrcv0vAqxpjcjD+Ruap5X5XIcBeBIQ=;
        b=kreTVFdLGJiS8DqdIGYaSYYyw/wUEuaSxMvwQv4ATHjvBfVJ39N3pWcuxEfqQ8J0ar
         /eHw2S23JVZIg9ic94WtpZwObgsZ87Yj1WzoOOHapqxGset2IBjEKxbfPVnPg37SgBeI
         fp9WHuuYh3AUKuY3wQNosjboUk1LobeHdY5qwj9iHZTj8g6V5xWMhiGEze2X1TZQ0h+P
         Fg/GDnpQrf7c6mf6jsj3p+bf8S80JqnoE6oo6zkUNIGo9DgEF8ZNNZGZs7HOQu8KsiXZ
         xy4in2SalfFj/XXp9p9aMAo5ct0xyo7/9QK3uXNvdaJafhAzuNrHvehn3nGetdrEzFjc
         0TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gz4TjFfRMy/GKJrcv0vAqxpjcjD+Ruap5X5XIcBeBIQ=;
        b=EqElD9gvkD0hz8XkopkuksshRwtCPTkXc1Ux3qV2BNjcBOVxxzCooaBc9otcd+uI50
         jwui4+WnMi/ZJVUut1cfHLCQR6WnB4qtofUXjWy9aBNuVp6geBCccrazdNiPA5a6KXgq
         ExoR3Q4W4fQCwB+MJLMYFaF+3BvwFzO7q/EyVXRkqqlDUImC7j9M4CdJkHiSM6pjelTL
         uuRfzEg7XrW6U6/zpk9DaKfE59V82hDm9Y0nfxAyJSNCHlFiCdxc0Yos4UftfNYS8Vqp
         /v3uBDVCemGa/9yRFs6VYcnV8TAWkLTGCeHm/Q9feXziL84dCz5+Q0+XYeQxtGvmxJPK
         TIJw==
X-Gm-Message-State: ACgBeo2Oq3lzx6eqfEtOb/L9NUwynEhzkGkArArbcMUMucHaSCM2a4rt
        frbDo+JSJQ0Z3gn4YsSVNrs=
X-Google-Smtp-Source: AA6agR69sJr2exNM0G1qLBOCoAdRhs7JwbnhD5PBPK7FzlebBo2lPwI3LogXb7qcTdkaZbW7xpfuUA==
X-Received: by 2002:a62:6347:0:b0:531:c5a7:b209 with SMTP id x68-20020a626347000000b00531c5a7b209mr22401334pfb.60.1661202594422;
        Mon, 22 Aug 2022 14:09:54 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:642a:8878:46a3:c3df? ([2001:df0:0:200c:642a:8878:46a3:c3df])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b0016e808dbe55sm8922839plf.96.2022.08.22.14.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 14:09:54 -0700 (PDT)
Message-ID: <376eda15-9f5e-88e6-5a1f-f4f706ed1169@gmail.com>
Date:   Tue, 23 Aug 2022 09:09:49 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220726045747.4779-1-schmitzmic@gmail.com>
 <20220726045747.4779-3-schmitzmic@gmail.com> <Yt/TQOJQZEhZE+2p@infradead.org>
 <CAMuHMdWW1=kXC14H6iUFF61sMOnsbfXodKS=mpdNbCtvgvjqKA@mail.gmail.com>
 <81e8bd2a-bb3f-6da0-ed39-b522a6b822be@gmail.com>
 <CAMuHMdU2S820t37cfojnBUumYM9V3ntZJ0AtANE-NSJDkHQLag@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdU2S820t37cfojnBUumYM9V3ntZJ0AtANE-NSJDkHQLag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

saw this a minute too late - will resend again.

Cheers,

     Michael

On 23/08/22 09:03, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Mon, Aug 22, 2022 at 10:38 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> On 11/08/22 23:40, Geert Uytterhoeven wrote:
>>> On Tue, Jul 26, 2022 at 1:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>> On Tue, Jul 26, 2022 at 04:57:47PM +1200, Michael Schmitz wrote:
>>>>> The Amiga partition parser module uses signed int for partition sector
>>>>> address and count, which will overflow for disks larger than 1 TB.
>>>>>
>>>>> Use u64 as type for sector address and size to allow using disks up to
>>>>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>>>>> format allows to specify disk sizes up to 2^128 bytes (though native
>>>>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
>>>>> u64 overflow carefully to protect against overflowing sector_t.
>>>>>
>>>>> Bail out if sector addresses overflow 32 bits on kernels without LBD
>>>>> support.
>>>>>
>>>>> This bug was reported originally in 2012, and the fix was created by
>>>>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
>>>>> discussed and reviewed on linux-m68k at that time but never officially
>>>>> submitted (now resubmitted as separate patch).
>>>>> This patch adds additional error checking and warning messages.
>>>>>
>>>>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>>>>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>> --- a/block/partitions/amiga.c
>>>>> +++ b/block/partitions/amiga.c
>>>>>                 if (!data) {
>>>>> -                     pr_err("Dev %s: unable to read RDB block %d\n",
>>>>> -                            state->disk->disk_name, blk);
>>>>> +                     pr_err("Dev %s: unable to read RDB block %llu\n",
>>>>> +                            state->disk->disk_name, (u64) blk);
>>>> No need for the various printk casts, a sector_t is always an
>>>> unsigned long long.
>>> That is true, as of commit 72deb455b5ec619f
>>> ("block: remove CONFIG_LBDAF") in v5.2.
>>> Since 4.9, 4.14, and 4.19 are still receiving stable updates, the
>>> cast should be re-added when this is backported.
>> Does this require a note in the commit message, or explicit CC to Greg?
> According to [1], you should add
>
>      Cc: <stable@vger.kernel.org> # 5.2
>
> [1] https://docs.kernel.org/process/stable-kernel-rules.html?highlight=prerequisites
>
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
