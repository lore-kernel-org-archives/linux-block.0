Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899B1EB64DD
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 07:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGDHUh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGDHUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 03:20:36 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A45186;
        Tue,  4 Jul 2023 00:20:35 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c5ce57836b8so479690276.1;
        Tue, 04 Jul 2023 00:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455234; x=1691047234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SINVr2+fCQAmrriwlODfMcxNoF1PuIatQe8b/YUwrkE=;
        b=Fv+sQ1X7KzU81VEyNTIMeV7Z9aDDN0yJzy1sUVoxIsHUc8KRb5KwopPHH9nE9uzJTD
         rmK7KPzokm8be2yTWFc4DhpCMNWoWeCJllO/JRLHiFrMlbhMCDI/R63T9/jZpVtk+lEM
         kFQ6KW2LjR7Yi85mIyP+bCY9X3h+M5kxZkNI9BbZRgu50NRLvfvMslocLW40EgrPcECN
         7BoJzpozGdO5JzoPbQR0ErKiSkLL39mQgS3r++/c8OvmaGgvomA4796OqItsSmq2t4s9
         Qgtk9NT3SpysnKrX4GqnqZXMTrvHGLL04YMYRQtz323VLJDIV9JrRDOBWqKkHSWHassq
         lK3Q==
X-Gm-Message-State: ABy/qLaJL1ISMWelqt0EdvZpys7pkCrBUDDSa3lQsc62EqU5cRk6GnU5
        bTXUP94ZSNaTz9NCMb3t2eWnV/P6a9P9Fw==
X-Google-Smtp-Source: APBJJlGlA/T2WOO0oOOXh90QhOzfs11CUEV0F1pAUSYlFsd20Yb365DvqVlD08Cy16HODJb4g/KXyA==
X-Received: by 2002:a25:2144:0:b0:c11:974f:4b7b with SMTP id h65-20020a252144000000b00c11974f4b7bmr10092321ybh.23.1688455233894;
        Tue, 04 Jul 2023 00:20:33 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y137-20020a25328f000000b00b99768e3b83sm4788812yby.25.2023.07.04.00.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:20:33 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso5958912276.2;
        Tue, 04 Jul 2023 00:20:33 -0700 (PDT)
X-Received: by 2002:a5b:1ca:0:b0:c5d:ba4b:dcdf with SMTP id
 f10-20020a5b01ca000000b00c5dba4bdcdfmr800670ybp.37.1688455233287; Tue, 04 Jul
 2023 00:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230704054955.16906-1-schmitzmic@gmail.com>
In-Reply-To: <20230704054955.16906-1-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 09:20:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUY6T7Q+fusJtHQxYTnKAvsdOJvFL_ZS-bkJTV32Y2yCw@mail.gmail.com>
Message-ID: <CAMuHMdUY6T7Q+fusJtHQxYTnKAvsdOJvFL_ZS-bkJTV32Y2yCw@mail.gmail.com>
Subject: Re: [PATCH v3] block: bugfix for Amiga partition overflow check patch
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi MIchael,

Thanks for your patch!

On Tue, Jul 4, 2023 at 7:50 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> fails the 'blk>0' test in the partition block loop if a
> value of (signed int) -1 is used to mark the end of the
> partition block list.
>
> This bug was introduced in patch 3 of my prior Amiga partition
> support fixes series, and spotted by Christian Zigotzky when
> testing the latest block updates.
>
> Explicitly cast 'blk' to signed int to allow use of -1 to
> terminate the partition block linked list.

That's the explanation for what this patch does.

The below is not directly related to that, so IMHO it does not
belong in the description of this patch.

We do not really have a way to record comments in git history
after the fact.  The best you can do is to reply to the email thread
where the patch was submitted.  When people follow the Link:
tag to the lore archive in the original commit, they can read any follow-ups.

> Testing by Christian also exposed another aspect of the old
> bug fixed in commits fc3d092c6b ("block: fix signed int
> overflow in Amiga partition support") and b6f3f28f60
> ("block: add overflow checks for Amiga partition support"):
>
> Partitions that did overflow the disk size (due to 32 bit int
> overflow) were not skipped but truncated to the end of the
> disk. Users who missed the warning message during boot would

I am confused.  So before, the partition size as seen by Linux after
the truncation, was correct?

> go on to create a filesystem with a size exceeding the
> actual partition size. Now that the 32 bit overflow has been

But if Linux did see the correct size, mkfs would have used the correct
size, too, and the size in the recorded file system should be correct?

> corrected, such filesystems may refuse to mount with a
> 'filesystem exceeds partition size' error. Users should
> either correct the partition size, or resize the filesystem
> before attempting to boot a kernel with the RDB fixes in
> place.

Hence there is no need to resize the file system, just to fix the
partition size in the RDB?

> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Cc: <stable@vger.kernel.org> # 6.4
> Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>
> --
>
> Changes since v2:
>
> Adrian Glaubitz:
> - fix typo in commit message
>
> Changes since v1:
>
> - corrected Fixes: tag
> - added Tested-by:
> - reworded commit message to describe filesystem partition
>   size mismatch problem

> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>         }
>         blk = be32_to_cpu(rdb->rdb_PartitionList);
>         put_dev_sector(sect);
> -       for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
> +       for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {

And this block number is supposed to be in the first 2 cylinders of
the disk, so it can never be equal or larger than 1 << 31, right?
We only really expect to see -1 here, not just any negative number.
So I think it would be safer to check against -1.
Or  against U32_MAX, to avoid the cast.

>                 /* Read in terms partition table understands */
>                 if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
>                         pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
