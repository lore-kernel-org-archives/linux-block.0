Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E70AEB64D7
	for <linux-block@archiver.kernel.org>; Mon, 19 Jun 2023 02:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFSCx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Jun 2023 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFSCx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2023 22:53:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0588E4E;
        Sun, 18 Jun 2023 19:53:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b549e81cecso1643515ad.0;
        Sun, 18 Jun 2023 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687143234; x=1689735234;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcW1VUXTqcSc+mMUauKY0UCtX0Nd8ZbF6k2ii5GYHdA=;
        b=qZDLkP7m9HtsnGf2OuczgZWOWhpB4CCADkesjrgcg5ZTM1XTBgY8KEjkV4hSmZfoIJ
         Kid2JeOmMTbAEyfaJxwyD/TBJbo5cg3My76H20uHvPsOvIPmwPPFV96tMe+uinswJ4IZ
         ZTg+N8eKRzwa3Q/8LLBFBgvqakCwJdh+oRwWaO7JXTpxkY58iw2cHqOqeFhShQDnuQLt
         9u17/giJOm4BsQ151qK+upIrBOreQUxuMfFe04IbDgU+u51kbCYhcHJVMqCrwhVPbDSh
         /XHq29LI7WAoTXZ+mNZIwCZSM/1KC2wqmtld1cqU/DIPOnB3geDxwMjJi5ruZKeCkPrW
         MuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687143234; x=1689735234;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HcW1VUXTqcSc+mMUauKY0UCtX0Nd8ZbF6k2ii5GYHdA=;
        b=UPyTESzqDdtCvR6TkKDDoiUu4ZmaLWOBOM/gXo2UbDArcZnz6maYGNe8AHTEwx9Rzf
         HZCV4FR8TTjJ3hFyb0Sq3ZNx2NNtWwS5YrzeUQGaedxcNzEfPg4rY9IKOvZBIPntHpPG
         ilEdXr+IU3vKcI16c47C2rwaDgZK9t2kGdnfYA3iUVeTAOj4B+V75YFXGdeDg5nW9mSi
         UHC19EVtAY2t4CMBhY67bkNcS/NnvuJzVnKtHPbFLwipaK/biM+8VBGjSyBWoJ9KD2+6
         lVIPUimEABbK2y27Pum3pKbP1V2or5O7wdAaeGgXvaihs8uSbF82WE7tcaFMv4Fnou1n
         8IIQ==
X-Gm-Message-State: AC+VfDzWkybYig5NO+LzjtXo96lMK5MQqqETZNFqj9mPThGZsTQEvJj+
        /3o518+4B45+NttTRAjDvLkZq5QVufQ=
X-Google-Smtp-Source: ACHHUZ4sug0G5UmyVJCVoN+6pnic1syO1JLx7pj9HnnqDKeHP35kdVDp18umy8bDO80CO482avnPHQ==
X-Received: by 2002:a17:902:e848:b0:1b5:49fc:e336 with SMTP id t8-20020a170902e84800b001b549fce336mr1885019plg.42.1687143233794;
        Sun, 18 Jun 2023 19:53:53 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0019e60c645b1sm10805337plr.305.2023.06.18.19.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2023 19:53:53 -0700 (PDT)
Subject: Re: [PATCH v12 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230616223616.6002-1-schmitzmic@gmail.com>
 <20230616223616.6002-3-schmitzmic@gmail.com>
 <CAMuHMdXo+Za3_Bz-PaLhq_oZzEzkN=g5YyDp=vaX7485WuE=Cg@mail.gmail.com>
 <e29dcf24-367f-4304-9b01-7913e0dcf650@gmail.com>
 <CAMuHMdUHNGKP4jFM7CDhFxHWd+SR4GG6Co0PosLCk1qpBV176w@mail.gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, hch@lst.de, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d4c2a542-f8ce-2aef-805b-d5fc3091e30a@gmail.com>
Date:   Mon, 19 Jun 2023 14:53:45 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHNGKP4jFM7CDhFxHWd+SR4GG6Co0PosLCk1qpBV176w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

Am 18.06.2023 um 19:51 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Sun, Jun 18, 2023 at 5:10 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 17.06.2023 um 23:08 schrieb Geert Uytterhoeven:
>>> On Sat, Jun 17, 2023 at 12:36 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>>> The Amiga partition parser module uses signed int for partition sector
>>>> address and count, which will overflow for disks larger than 1 TB.
>>>>
>>>> Use u64 as type for sector address and size to allow using disks up to
>>>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>>>> format allows to specify disk sizes up to 2^128 bytes (though native
>>>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
>>>> u64 overflow carefully to protect against overflowing sector_t.
>>>>
>>>> This bug was reported originally in 2012, and the fix was created by
>>>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
>>>> discussed and reviewed on linux-m68k at that time but never officially
>>>> submitted (now resubmitted as patch 1 of this series).
>>>>
>>>> Patch 3 (this series) adds additional error checking and warning
>>>> messages. One of the error checks now makes use of the previously
>>>> unused rdb_CylBlocks field, which causes a 'sparse' warning
>>>> (cast to restricted __be32).
>>>>
>>>> Annotate all 32 bit fields in affs_hardblocks.h as __be32, as the
>>>> on-disk format of RDB and partition blocks is always big endian.
>>>>
>>>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>>>> Cc: <stable@vger.kernel.org> # 5.2
>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Thanks - now I notice the patch title for this one doesn't fit too well
>> anymore.
>>
>> Would a change of title mess up the common patch tracking tools?
>
> You mean changing one patch subject in v13?

Correct.

> Nah, happens all the time, so the tooling should handle that fine.

OK - I need to add your review tag anyway.

Cheers,

	Michael
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
