Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9488EB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjGEHZH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGEHZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 03:25:04 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F8197;
        Wed,  5 Jul 2023 00:25:03 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-c17534f4c63so7293170276.0;
        Wed, 05 Jul 2023 00:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541902; x=1691133902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHXs/BS3Y7HzNAK2aBSyxTx4XzKEmygepT/uAz4vVew=;
        b=QEp7IArrt98iO/cXpdU+fLWrizt7T0Cts6Hl+yUga9/F6nAY8SVfyW7Jzjabe7L1+J
         cegQIh1bkbJo8I1eLghx+guiyJNh5rSXJLkKItbWfWunS06n6lKZQf/R8TW+Ox/6xkd5
         FoiGHajnrFuM+GbIsbezu0QwN8YNRNMYsNLz6Yfy+zWv9jSquFkm61HOWIpD+En4qB55
         aBsdKqtQMRUUsztxYJcjG0Tf7OAvnqYLlNL/Zk/41lGkG19SKZZWVZ0vZwYxTJTO7fkm
         1gc86sf2QntN6LXIvk3z/U6co+Hv0hdcBHn9/0u4eKJIuVtEntJCgN/30atAJq9hYXnv
         132g==
X-Gm-Message-State: ABy/qLZMgKKpNcioCnwvtcaiXDJv+jOJ6hZMUehFee5mVuvmtaRtJyU6
        CvqMkIZQUKhgbgjkpyrsQNt5JnjGYN0iAw==
X-Google-Smtp-Source: APBJJlHfMHtENzQR3F52HzVpoikSgW3XaAINJDjUDUko/krNWef+lSm6ljRyYvemcbEDzUGsJl2vAQ==
X-Received: by 2002:a25:c707:0:b0:bca:531d:dcde with SMTP id w7-20020a25c707000000b00bca531ddcdemr14333885ybe.30.1688541902317;
        Wed, 05 Jul 2023 00:25:02 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 127-20020a250b85000000b00be8e8772025sm5142993ybl.45.2023.07.05.00.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 00:25:01 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c5e67d75e0cso1407489276.2;
        Wed, 05 Jul 2023 00:25:01 -0700 (PDT)
X-Received: by 2002:a5b:d4c:0:b0:bd5:ddcd:bc9e with SMTP id
 f12-20020a5b0d4c000000b00bd5ddcdbc9emr14126946ybr.17.1688541901302; Wed, 05
 Jul 2023 00:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230704054955.16906-1-schmitzmic@gmail.com> <CAMuHMdUY6T7Q+fusJtHQxYTnKAvsdOJvFL_ZS-bkJTV32Y2yCw@mail.gmail.com>
 <69cf5397-1a99-8cc5-ed48-d354f0ad05df@gmail.com>
In-Reply-To: <69cf5397-1a99-8cc5-ed48-d354f0ad05df@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 09:24:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVD9r2XjPYU9WJXYoSO5LriCoYy+TOp4ddru3WbX803Tg@mail.gmail.com>
Message-ID: <CAMuHMdVD9r2XjPYU9WJXYoSO5LriCoYy+TOp4ddru3WbX803Tg@mail.gmail.com>
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

Hi Michael,

On Tue, Jul 4, 2023 at 9:30 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 4/07/23 19:20, Geert Uytterhoeven wrote:
> > On Tue, Jul 4, 2023 at 7:50 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> >> fails the 'blk>0' test in the partition block loop if a
> >> value of (signed int) -1 is used to mark the end of the
> >> partition block list.
> >>
> >> This bug was introduced in patch 3 of my prior Amiga partition
> >> support fixes series, and spotted by Christian Zigotzky when
> >> testing the latest block updates.
> >>
> >> Explicitly cast 'blk' to signed int to allow use of -1 to
> >> terminate the partition block linked list.
> > That's the explanation for what this patch does.
> >
> > The below is not directly related to that, so IMHO it does not
> > belong in the description of this patch.
>
> Yes, I realize that. I had hoped that by way of the Fixes: tag, people
> would be able to relate that comment to the correct commit. Might be a
> little circuitous ...
>
> > We do not really have a way to record comments in git history
> > after the fact.  The best you can do is to reply to the email thread
> > where the patch was submitted.  When people follow the Link:
> > tag to the lore archive in the original commit, they can read any follow-ups.
>
> Does lore pick up related patches through the In-Reply-To header? In
> that case it would be easiest for me to to put this comment in a cover
> letter to the bugfix patch.

Lore does not do that (b4 (the tool to download patch series from lore)
usually can link a series to its previous version, though).
New replies sent to a patch submission do end up in the right thread,
so any later comments (bug reports, Reviewed/Tested-by tags, ...)
can be found easily by following the Link: tag in the commit.

> >> Testing by Christian also exposed another aspect of the old
> >> bug fixed in commits fc3d092c6b ("block: fix signed int
> >> overflow in Amiga partition support") and b6f3f28f60
> >> ("block: add overflow checks for Amiga partition support"):
> >>
> >> Partitions that did overflow the disk size (due to 32 bit int
> >> overflow) were not skipped but truncated to the end of the
> >> disk. Users who missed the warning message during boot would
> > I am confused.  So before, the partition size as seen by Linux after
> > the truncation, was correct?
>
> No, it was incorrect (though valid).
>
> On a 2 TB disk, a partition of 1.3 TB at the end of the disk (but not
> extending to the very end!) would trigger a overflow in the size
> calculation:
>
> sda: p4 size 18446744071956107760 extends beyond EOD,

Oh, so they were not "truncated to the end of the disk"?

> That's only noted somewhere inside put_partition. The effective
> partition size seen by the kernel and user tools is then that of a
> partition extending to EOD (in Christian's case a full 8 GB more than
> recorded in the partition table).
>
> >> go on to create a filesystem with a size exceeding the
> >> actual partition size. Now that the 32 bit overflow has been
> > But if Linux did see the correct size, mkfs would have used the correct
> > size, too, and the size in the recorded file system should be correct?
>
> mkfs used what the old kernel code gave as partition size. That did
> 'seem' correct at that time, but after the overflow fixes (which prevent
> other partition miscalculations, which in Martin's case caused
> partitions to overlap), the partitions size is actually correct and
> smaller than the filesystem size.
>
> I have a hunch I don't explain myself very well.

;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
