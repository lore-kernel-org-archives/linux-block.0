Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2F4C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7665611C9
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 14:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKKOya (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:54:30 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:44825 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhKKOya (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 09:54:30 -0500
Received: by mail-ua1-f50.google.com with SMTP id p2so12304784uad.11;
        Thu, 11 Nov 2021 06:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HuDzM58G6iBWbKUBUepe9DPEIQghryjBLteScwaz/s=;
        b=zlEF7MnEs62rmdhusY08azMIAEDso5D6LL3PSE2us/e0s70Ld51qdqVdTZCgEuMKwM
         7fGTR+WtU6f6cmOTJh6s4VuZr+kg5dDUXha0i+80RHnKWuobyxIVLJx6mT3joQ4/k5y6
         KNBj9HAgh1Kx/Plr1U8nitbXZ+4Jr2BU8XdUvP2MzCUI3sZ3Z35GKswNOsTFf4WkxbT2
         f44GV5DMYfXUGylEZU14r1fD5mMAREzdKow0J28SU0QJlJCbU2ylHVzFssJvy+T46xbo
         pLDbUkkurzPYchQPc5LXu7hKRE8R2TzwegLY6NlYrXoV2ptLzeZ0md5qCubtvqw7Nkze
         hHVg==
X-Gm-Message-State: AOAM53011DkpzPB2kkMN4sLxMpWyMYFN7uRZFhf5wGWFB5iOZgGXXA27
        maYhxWUDfErrOHklvKgsnCsq3LA1eaxnAA==
X-Google-Smtp-Source: ABdhPJyXbe/DdaQVelNDsOj5cKGT6qv0UznxTor6ssvcFhejTqg5WNuaR4O8SB6Sc82dN8xKEW3nXg==
X-Received: by 2002:ab0:3898:: with SMTP id z24mr11081012uav.26.1636642300214;
        Thu, 11 Nov 2021 06:51:40 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id k1sm2267533uaq.0.2021.11.11.06.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 06:51:40 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id e2so12359328uax.7;
        Thu, 11 Nov 2021 06:51:39 -0800 (PST)
X-Received: by 2002:a67:af0a:: with SMTP id v10mr11671783vsl.35.1636642299512;
 Thu, 11 Nov 2021 06:51:39 -0800 (PST)
MIME-Version: 1.0
References: <YYQoLzMn7+s9hxpX@infradead.org> <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org> <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk> <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk> <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk> <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <YY0eVnbjmHmPZ3M4@T590>
In-Reply-To: <YY0eVnbjmHmPZ3M4@T590>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Nov 2021 15:51:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTiF3MpcwHc=jCGLoBtTngzXTLHsYSYKPyfLBFBn8B2g@mail.gmail.com>
Message-ID: <CAMuHMdWTiF3MpcwHc=jCGLoBtTngzXTLHsYSYKPyfLBFBn8B2g@mail.gmail.com>
Subject: Re: [PATCH 4/5] block: move queue enter logic into blk_mq_submit_bio()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Thu, Nov 11, 2021 at 2:45 PM Ming Lei <ming.lei@redhat.com> wrote:
> On Thu, Nov 11, 2021 at 01:58:38PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 4 Nov 2021, Jens Axboe wrote:
> > > On 11/4/21 1:04 PM, Christoph Hellwig wrote:
> > > > On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
> > > > > On 11/4/21 12:52 PM, Christoph Hellwig wrote:
> > > > > > Looks good:
> > > > > >
> > > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > >
> > > > > So these two are now:
> > > > >
> > > > > https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
> > > > >
> > > > > which is the one I sent here, and then the next one gets cleaned up to
> > > > > remove that queue enter helper:
> > > > >
> > > > > https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
> > > > >
> > > > > Can I add your reviewed-by to this last one as well? Only change is the
> > > > > removal of blk_mq_enter_queue() and the weird construct there, it's just
> > > > > bio_queue_enter() now.
> > > >
> > > > Sure.
> > >
> > > Thanks, prematurely already done, as you could tell :-)
> >
> > The updated version is now commit 900e080752025f00 ("block: move queue
> > enter logic into blk_mq_submit_bio()") in Linus' tree.
> >
> > I have bisected failures on m68k/atari (on ARAnyM, using nfhd as the
> > root device) to this commit, e.g.:
> >
> >     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
> >     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> >     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
> >     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> >     Buffer I/O error on dev sda1, logical block 0, lost sync page write
> >
> >     EXT4-fs (sda1): I/O error while writing superblock
> >     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
> >     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> >     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
> >     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> >     Buffer I/O error on dev sda1, logical block 0, lost sync page write
> >     EXT4-fs (sda1): I/O error while writing superblock
> >
> > This may happen either when mounting the root file system (leading to an
> > unable to mount root fs panic), or later (leading to a read-only
> > rootfs).
>
> BTW, today I just found that hang in blk_mq_freeze_queue_wait() is
> caused by commit 900e080752025f00, and the following patch can fix it:
>
> - blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
>
> https://lore.kernel.org/linux-block/20211111085650.GA476@lst.de/T/#m759b88fda094a65ebf29bc81b780967cdaf9cf28
>
> Maybe you can try the above patch.

Thanks! I have applied both patches, but it doesn't make a difference.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
