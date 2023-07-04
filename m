Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7392EB64DD
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGDTaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 15:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGDTaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 15:30:22 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272BE5B;
        Tue,  4 Jul 2023 12:30:20 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-565d65adcf2so3436661eaf.3;
        Tue, 04 Jul 2023 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688499020; x=1691091020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6GwQNuQoPzKEctHnLR1MdtDAqznYQQ2gb9SsVrjkj8=;
        b=phRPC/3CT8tjDE6GohLc286LMIrphQeS8w0G9QzvauTZH7wEtmfquBhORGIDiIa4rs
         GAjSUTn6Gd6418AOsVUjOv1KC6JnJp/sZgR0iATv0x58wNAAXuwyCxGbh8tkrcef8rXv
         FuCOp5RAeSAaC76hsm9zI8YEjnL/SFu+UIuVJhQmGBfOyklEDr/F5lSeo1TcVZcIQsv/
         5ToVx4DOohwHgbLQ2P9lFNspAy7BK1Db323vGgctHGv1rwoWHVUq5thV/Io0nODBu085
         wbuwfMHQ5wuP+AKsRURiXMpyMEeZayeAHt16g3dQ9wC9TKOPQ8uWu9Cz6aemweS8/4s9
         UNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688499020; x=1691091020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6GwQNuQoPzKEctHnLR1MdtDAqznYQQ2gb9SsVrjkj8=;
        b=H6MVYJ/9K8RJx16FiYAo5ngWcxvN0WHlkRhZeSDhCjaQEXWyhhlRNbX4kqv2bhw3FR
         L+/oxVM5PSPE6QhyNo8/nKyjg9fpB8/SyzTsHi3ZLJURONPsT1iGAgobLfW8ClxDM2ze
         F4mZgLjADk89NgWAsnaPTbh9Mc6UvFG2QcS+bGHIRz3xUy6Op3Vjj+fWqp+eDz32f+ls
         9SvngQ8qEjoRkb2B8XPqHRPhJFXxCLyRpQDxxaz3KXA7vfBmca6bt6caGnRe/rr4YwVt
         d7rRhk/dHvlSlPzCoqq3R1M0bd1p5gNKlRpIAiMz+wNSccAV7X/MwfcLfAti4IRmLWhe
         NT/g==
X-Gm-Message-State: AC+VfDwz89o8cgoOM4t+hWRvzqQ27lt2pYYzsAU1Okbp0ohwNDYHnJgC
        ENOUZy2NCQT3gnJZansy7ow=
X-Google-Smtp-Source: ACHHUZ7CQJXWsdzZ1tydlQmjVUQ/r04to1VhbVdOjEDBjB2ZLRXooct8/GoHmzhS4Hng+HR6wvey7w==
X-Received: by 2002:a05:6808:bcc:b0:3a3:7a28:f841 with SMTP id o12-20020a0568080bcc00b003a37a28f841mr16424267oik.41.1688499019164;
        Tue, 04 Jul 2023 12:30:19 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:2c51:ccb9:9db0:5657? ([2001:df0:0:200c:2c51:ccb9:9db0:5657])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b00671aa6b4962sm14772265pfo.114.2023.07.04.12.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 12:30:18 -0700 (PDT)
Message-ID: <69cf5397-1a99-8cc5-ed48-d354f0ad05df@gmail.com>
Date:   Wed, 5 Jul 2023 07:30:07 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] block: bugfix for Amiga partition overflow check patch
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org
References: <20230704054955.16906-1-schmitzmic@gmail.com>
 <CAMuHMdUY6T7Q+fusJtHQxYTnKAvsdOJvFL_ZS-bkJTV32Y2yCw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdUY6T7Q+fusJtHQxYTnKAvsdOJvFL_ZS-bkJTV32Y2yCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

On 4/07/23 19:20, Geert Uytterhoeven wrote:
> Hi MIchael,
>
> Thanks for your patch!
>
> On Tue, Jul 4, 2023 at 7:50 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>> fails the 'blk>0' test in the partition block loop if a
>> value of (signed int) -1 is used to mark the end of the
>> partition block list.
>>
>> This bug was introduced in patch 3 of my prior Amiga partition
>> support fixes series, and spotted by Christian Zigotzky when
>> testing the latest block updates.
>>
>> Explicitly cast 'blk' to signed int to allow use of -1 to
>> terminate the partition block linked list.
> That's the explanation for what this patch does.
>
> The below is not directly related to that, so IMHO it does not
> belong in the description of this patch.
Yes, I realize that. I had hoped that by way of the Fixes: tag, people 
would be able to relate that comment to the correct commit. Might be a 
little circuitous ...
> We do not really have a way to record comments in git history
> after the fact.  The best you can do is to reply to the email thread
> where the patch was submitted.  When people follow the Link:
> tag to the lore archive in the original commit, they can read any follow-ups.
Does lore pick up related patches through the In-Reply-To header? In 
that case it would be easiest for me to to put this comment in a cover 
letter to the bugfix patch.
>
>> Testing by Christian also exposed another aspect of the old
>> bug fixed in commits fc3d092c6b ("block: fix signed int
>> overflow in Amiga partition support") and b6f3f28f60
>> ("block: add overflow checks for Amiga partition support"):
>>
>> Partitions that did overflow the disk size (due to 32 bit int
>> overflow) were not skipped but truncated to the end of the
>> disk. Users who missed the warning message during boot would
> I am confused.  So before, the partition size as seen by Linux after
> the truncation, was correct?

No, it was incorrect (though valid).

On a 2 TB disk, a partition of 1.3 TB at the end of the disk (but not 
extending to the very end!) would trigger a overflow in the size 
calculation:

sda: p4 size 18446744071956107760 extends beyond EOD,

That's only noted somewhere inside put_partition. The effective 
partition size seen by the kernel and user tools is then that of a 
partition extending to EOD (in Christian's case a full 8 GB more than 
recorded in the partition table).

>> go on to create a filesystem with a size exceeding the
>> actual partition size. Now that the 32 bit overflow has been
> But if Linux did see the correct size, mkfs would have used the correct
> size, too, and the size in the recorded file system should be correct?

mkfs used what the old kernel code gave as partition size. That did 
'seem' correct at that time, but after the overflow fixes (which prevent 
other partition miscalculations, which in Martin's case caused 
partitions to overlap), the partitions size is actually correct and 
smaller than the filesystem size.

I have a hunch I don't explain myself very well.

>
>> corrected, such filesystems may refuse to mount with a
>> 'filesystem exceeds partition size' error. Users should
>> either correct the partition size, or resize the filesystem
>> before attempting to boot a kernel with the RDB fixes in
>> place.
> Hence there is no need to resize the file system, just to fix the
> partition size in the RDB?

Yes, that's the easiest way to do it, but we don't yet know if gparted 
(for example) does allow to do that. Mucking around with hexedit (which 
is what I used to verify this change gives identical partition sizes for 
old and new kernels) isn't to everyone's taste.

I haven't looked at amiga-fdisk - that one might be easiest to fix.

Cheers,

     Michael


>
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>> Cc: <stable@vger.kernel.org> # 6.4
>> Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>
>> --
>>
>> Changes since v2:
>>
>> Adrian Glaubitz:
>> - fix typo in commit message
>>
>> Changes since v1:
>>
>> - corrected Fixes: tag
>> - added Tested-by:
>> - reworded commit message to describe filesystem partition
>>    size mismatch problem
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>>          }
>>          blk = be32_to_cpu(rdb->rdb_PartitionList);
>>          put_dev_sector(sect);
>> -       for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
>> +       for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
> And this block number is supposed to be in the first 2 cylinders of
> the disk, so it can never be equal or larger than 1 << 31, right?
> We only really expect to see -1 here, not just any negative number.
> So I think it would be safer to check against -1.
> Or  against U32_MAX, to avoid the cast.
>
>>                  /* Read in terms partition table understands */
>>                  if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
>>                          pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
> Gr{oetje,eeting}s,
>
>                          Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
