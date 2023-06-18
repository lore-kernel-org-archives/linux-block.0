Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E0DEB64DC
	for <linux-block@archiver.kernel.org>; Sun, 18 Jun 2023 03:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjFRDKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jun 2023 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFRDKt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2023 23:10:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B5E5A;
        Sat, 17 Jun 2023 20:10:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39ce64700cbso1854879b6e.0;
        Sat, 17 Jun 2023 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687057846; x=1689649846;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLuT+2NzBAXHCK3cGleHFvnJZZ+XBr8qJcVGkHAsIQo=;
        b=IJ7K4UHUX67qftKWzNY8/niY+7urxToTW/eWv2NQ0IFFRs8UJDWC4d/emClzCu39qm
         ZSJWgTBHYzhv2ZbC78EqnFFJLqlJkQzOoq0LLFghGWHVwjN2rhmr6SoY6iMJW61ZaBGE
         UGFP6WEfFtVnwMQ6rvfAkOVE08/tJMem7Eph4aCXU46HVCD+Hm8X7TubH5tXSaHJ43Ty
         648WnrG22R0qGEHDCpZ4USsQRurQrrfH75dXxM3RqQIU+TMkLtYY5EYHR2OTD7oLeTD4
         M+Z4F1baPJ7ZnXVZUi+0SY+/GRpD0scCU7Z2HTGuET73euIzUZ7bTBNKtK7AVylvydW0
         lPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687057846; x=1689649846;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLuT+2NzBAXHCK3cGleHFvnJZZ+XBr8qJcVGkHAsIQo=;
        b=hwqzJzSxqx1JqnBVwF6MipuUBbR2lAnF7TmkfrHiW15aG3G70Sl0BsHjEAg++YMTGa
         e9v+xAZYnpIrjGL2zM5G+kHFDCQ1qulRlnva1wde7vokAoHhg+CwBJdvhwpZXBC1hsp1
         oev35B7A/mLtwovhsgENFLb4nUzYdhBEDZyMnPaGmgFWdXJDjfrNDcE8mm0QOyJN8FkQ
         PU3uUehrq+JSk4dbJkFhXIEoR9gZbkmel4TztWaqrpKKiiVWzBepEi1CI5BOHi+9X+Fj
         vd7U22tB3+ifhF1WBZmW7aXg9fWi6VL6HNiQ5j5o7oyQ6Tpv8GifvgpS99Zzo/DgzU33
         QMrA==
X-Gm-Message-State: AC+VfDxXYF7oy7C8k67gs2DLzlvVmbt8WOhVaz+LqH5A5lD2wainWj07
        oZ42Sjou/GPpA6DSEes+ZW6nHp6Oee4=
X-Google-Smtp-Source: ACHHUZ7f4TlBLNCSeWyO4adJ+o+fKG/W7gEpILn4xOiJ7bxY2+pV+B2dDI8SEWFFiRcBs3qVKbYGMw==
X-Received: by 2002:a54:4181:0:b0:39c:b3ae:865e with SMTP id 1-20020a544181000000b0039cb3ae865emr6948294oiy.55.1687057846213;
        Sat, 17 Jun 2023 20:10:46 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b0065980654baasm15537805pff.130.2023.06.17.20.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2023 20:10:45 -0700 (PDT)
Subject: Re: [PATCH v12 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230616223616.6002-1-schmitzmic@gmail.com>
 <20230616223616.6002-3-schmitzmic@gmail.com>
 <CAMuHMdXo+Za3_Bz-PaLhq_oZzEzkN=g5YyDp=vaX7485WuE=Cg@mail.gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, hch@lst.de, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e29dcf24-367f-4304-9b01-7913e0dcf650@gmail.com>
Date:   Sun, 18 Jun 2023 15:10:38 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXo+Za3_Bz-PaLhq_oZzEzkN=g5YyDp=vaX7485WuE=Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

Am 17.06.2023 um 23:08 schrieb Geert Uytterhoeven:
> On Sat, Jun 17, 2023 at 12:36 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> The Amiga partition parser module uses signed int for partition sector
>> address and count, which will overflow for disks larger than 1 TB.
>>
>> Use u64 as type for sector address and size to allow using disks up to
>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>> format allows to specify disk sizes up to 2^128 bytes (though native
>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
>> u64 overflow carefully to protect against overflowing sector_t.
>>
>> This bug was reported originally in 2012, and the fix was created by
>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
>> discussed and reviewed on linux-m68k at that time but never officially
>> submitted (now resubmitted as patch 1 of this series).
>>
>> Patch 3 (this series) adds additional error checking and warning
>> messages. One of the error checks now makes use of the previously
>> unused rdb_CylBlocks field, which causes a 'sparse' warning
>> (cast to restricted __be32).
>>
>> Annotate all 32 bit fields in affs_hardblocks.h as __be32, as the
>> on-disk format of RDB and partition blocks is always big endian.
>>
>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>> Cc: <stable@vger.kernel.org> # 5.2
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks - now I notice the patch title for this one doesn't fit too well 
anymore.

Would a change of title mess up the common patch tracking tools?

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
