Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF704C282D0
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA2D214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="lG1OXiOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA2PuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:50:02 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34595 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfA2PuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:50:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so12250447vsi.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrAA2YCG0MN9FJwIUd71VNysqRSpz+WIaMTPbpQs+kM=;
        b=lG1OXiOr+OdMF+6Xt1zYaAHUjyWMgj/h1wNZC+hK+XaheYjsyyIcJPsyj7Nx9DQe7M
         dQgyX7so1GbDeojSMLJS2ZFZvbfSf15m8cCwQYV9JP3tMnbkHkKlkE/EqnuyvBnSxHV9
         w8bwaaxUNtCkLKpAV4x3jpi/cvsuRGmDuaidALLpnwTnHLCKSsYgOVg5NNNg7h3VzQf+
         jwHQI6iAloBkaZrBRKLUTPdQZnabZ+zKMuMDCLilx7p1saGowDy2ml7YDsBBkcwX2p5Z
         Do8RjpJG19UGIGIi7/1oPjeWMJqNRvNAYRhABDBMCaj90IFcKaKCM1YQs+JC/z9W1l85
         WwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrAA2YCG0MN9FJwIUd71VNysqRSpz+WIaMTPbpQs+kM=;
        b=qiX8CgRYncBnULKhKOBppwKvNKmHFux6sG+2hnlSFCFFZZfJobGuiSqvPQ/n+C9kvC
         RFcABtEuEbhLqDKsZw0bdM9HQELaBIlpq8OdpvtsBdt/SJEMKw+g0h8zZAGybaae1cfO
         1lZOYcA/KDwo9YUOCST5igRyNE0r4IWIOxgPEhXoSgkxMHKPu+45GVgGFQ+kCD5MTQB1
         lzbtG2yj7eZv3zCIJek1LBLpVjG3bPgWy9urku5nXtJjQ5ph2sBfZUuF/OUFBipcz7iT
         ghpSN5/dyneQoSKhLKaNmwEHM8CdMo8BiaI87JkLC6TWHdcEsuDkUpZL+OqetScnuygz
         HgDw==
X-Gm-Message-State: AJcUukcqX7JLF+9t78CSUQAKRcWFXpUTEGFCFHo65onWPxNY8yT43MWX
        UfIodyGAUVVD9HT/XVf3qDj1cW8UIURT0w22b7C6KA==
X-Google-Smtp-Source: ALg8bN7V8FScIjAeprGqpUaYxNe1VBjpzTVeQa2mgGq2NaTsZElEU+E2dRKGyeG8Q4yGYt5rWpstDlTMsxk5Q6lte7U=
X-Received: by 2002:a67:1106:: with SMTP id 6mr10715231vsr.213.1548777000745;
 Tue, 29 Jan 2019 07:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20190129084737.718-1-hans@owltronix.com> <FDFE70E2-CA70-456F-8507-94BF822BF9A7@javigon.com>
 <CANr-nt34gCrRWsNrAfKS1Opy=kV5EwuR_C1VDjQbBP5MnfdgpA@mail.gmail.com> <74C79F4D-E9B0-4F47-ACF2-9335D3DB8604@javigon.com>
In-Reply-To: <74C79F4D-E9B0-4F47-ACF2-9335D3DB8604@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 29 Jan 2019 16:49:49 +0100
Message-ID: <CANr-nt3K3OWRoe9jHT0fJWZdSBTmiro4KERTNPu9CDiZB8QgAw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: extend line wp balance check
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 4:03 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 29 Jan 2019, at 13.49, Hans Holmberg <hans@owltronix.com> wrote:
> >
> > On Tue, Jan 29, 2019 at 12:19 PM Javier Gonz=C3=A1lez <javier@javigon.c=
om> wrote:
> >>> On 29 Jan 2019, at 09.47, hans@owltronix.com wrote:
> >>>
> >>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >>>
> >>> pblk stripes writes of minimal write size across all non-offline chun=
ks
> >>> in a line, which means that the maximum write pointer delta should no=
t
> >>> exceed the minimal write size. Extend the line write pointer balance =
check
> >>> to cover this case.
> >>>
> >>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >>> ---
> >>>
> >>> This patch applies on top of Zhoujie's V3 of
> >>> "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
> >>>
> >>> drivers/lightnvm/pblk-recovery.c | 60 ++++++++++++++++++++-----------=
-
> >>> 1 file changed, 37 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk=
-recovery.c
> >>> index 02d466e6925e..d86f580036d3 100644
> >>> --- a/drivers/lightnvm/pblk-recovery.c
> >>> +++ b/drivers/lightnvm/pblk-recovery.c
> >>> @@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk,=
 struct pblk_line *line)
> >>>      return (distance > line->left_msecs) ? line->left_msecs : distan=
ce;
> >>> }
> >>>
> >>> -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
> >>> -                                   struct pblk_line *line)
> >>> +/* Return a chunk belonging to a line by stripe(write order) index *=
/
> >>> +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
> >>> +                                               struct pblk_line *lin=
e,
> >>> +                                               int index)
> >>> {
> >>>      struct nvm_tgt_dev *dev =3D pblk->dev;
> >>>      struct nvm_geo *geo =3D &dev->geo;
> >>> -     struct pblk_line_meta *lm =3D &pblk->lm;
> >>>      struct pblk_lun *rlun;
> >>> -     struct nvm_chk_meta *chunk;
> >>>      struct ppa_addr ppa;
> >>> -     u64 line_wp;
> >>> -     int pos, i, bit;
> >>> +     int pos;
> >>>
> >>> -     bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line)=
;
> >>> -     if (bit >=3D lm->blk_per_line)
> >>> -             return 0;
> >>> -     rlun =3D &pblk->luns[bit];
> >>> +     rlun =3D &pblk->luns[index];
> >>>      ppa =3D rlun->bppa;
> >>>      pos =3D pblk_ppa_to_pos(geo, ppa);
> >>> -     chunk =3D &line->chks[pos];
> >>>
> >>> -     line_wp =3D chunk->wp;
> >>> +     return &line->chks[pos];
> >>> +}
> >>>
> >>> -     for (i =3D bit + 1; i < lm->blk_per_line; i++) {
> >>> -             rlun =3D &pblk->luns[i];
> >>> -             ppa =3D rlun->bppa;
> >>> -             pos =3D pblk_ppa_to_pos(geo, ppa);
> >>> -             chunk =3D &line->chks[pos];
> >>> +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
> >>> +                                   struct pblk_line *line)
> >>> +{
> >>> +     struct pblk_line_meta *lm =3D &pblk->lm;
> >>> +     int blk_in_line =3D lm->blk_per_line;
> >>> +     struct nvm_chk_meta *chunk;
> >>> +     u64 max_wp, min_wp;
> >>> +     int i;
> >>>
> >>> -             if (chunk->state & NVM_CHK_ST_OFFLINE)
> >>> -                     continue;
> >>> +     i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
> >>> +
> >>> +     /* If there is one or zero good chunks in the line,
> >>> +      * the write pointers can't be unbalanced.
> >>> +      */
> >>> +     if (i >=3D (blk_in_line - 1))
> >>> +             return 0;
> >>>
> >>> -             if (chunk->wp > line_wp)
> >>> +     chunk =3D pblk_get_stripe_chunk(pblk, line, i);
> >>> +     max_wp =3D chunk->wp;
> >>> +     if (max_wp > pblk->max_write_pgs)
> >>> +             min_wp =3D max_wp - pblk->max_write_pgs;
> >>> +     else
> >>> +             min_wp =3D 0;
> >>> +
> >>> +     i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
> >>> +     while (i < blk_in_line) {
> >>> +             chunk =3D pblk_get_stripe_chunk(pblk, line, i);
> >>> +             if (chunk->wp > max_wp || chunk->wp < min_wp)
> >>>                      return 1;
> >>> -             else if (chunk->wp < line_wp)
> >>> -                     line_wp =3D chunk->wp;
> >>> +
> >>> +             i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line,=
 i + 1);
> >>>      }
> >>>
> >>>      return 0;
> >>> @@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk,=
 struct pblk_line *line,
> >>>      int ret;
> >>>      u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - lm->smeta_=
sec;
> >>>
> >>> -     if (pblk_line_wp_is_unbalanced(pblk, line))
> >>> +     if (pblk_line_wps_are_unbalanced(pblk, line))
> >>>              pblk_warn(pblk, "recovering unbalanced line (%d)\n", lin=
e->id);
> >>>
> >>>      ppa_list =3D p.ppa_list;
> >>> --
> >>> 2.17.1
> >>
> >> If I am understanding correctly, you want to protect against the case
> >> where a pfail has broken the ws_min partition of a chunk, right? I say
> >> this because there is a guarantee that the minimal write size and pblk=
's
> >> write size align with ws_min and ws_opt. Even if we have grown bad
> >> blocks on pfail for the current line (which is a bigger problem becaus=
e
> >> we have potentially lost data), this guarantee would remain.
> >>
> >> If this is the case, my first reaction would be to say that the
> >> controller is responsible for guaranteeing atomicity for both scalar a=
nd
> >> vector I/Os. If this is not guaranteed, we have bigger problems than
> >> this (e.g., for the write error recovery path).
> >>
> >> Are you thinking of a different case?
> >
> > The write pointer check triggers a warning if something unexpected has
> > happened to the chunks.
> > i.e. if something else than pblk messed with the disk, or if the user
> > tries to recover a pblk instance with an invalid lun configuration.
>
> But this will only solve a very specific corner case of this, right?
> This is, when you are writing at WP on a middle LUN exactly < ws_min.
>> For example, If the user attempts to start pblk with a different LUN
> configuration, the alignment is the same an pblk will actually fail
> because it cannot find any emeta.

Well, we will try to recover a line if the emeta data cannot be read
or the data fails the crc check, and the recovery path assumes that
the write pointers pointers have been incremented in the pblk stripe
order. We'll get a warning now for all cases if this assumption is not
valid.

> For completion, the original wp_unbalanced patch attempted to protect
> against the case where several outstanding I/Os to different PUs are
> inflight and then you have a pfail. In this case, a write to a PU that
> is not "next" in the line bitmap completes and we have a whole, meaning
> that if we recover this case, we risk to overwrite valid data, as we
> break the "sequentiality" the line, which allows for recovering by
> replaying the P2L stored on the OOB.

For outstanding writes, we can leave no guarantees anyway. If a
presync was attached to a bio, that bio will complete when the write
completes.

>
> >
> > This patch adds a warning if a chunk wp is too small(i.e. if a chunk
> > was unexpectedly reset)
>
> I am not arguing against the implementation, I am just trying to
> understand what you are trying to fix. If it is the case I described
> originally, then I do not think it is possible on the Open-Channel
> architecture. If you want to add protection against corruptions, then
> this needs more work as many corruption cases are missing - you would
> need something like a OOB watermark to protect open lines and something
> like a OOB lba CRC check in emeta to validate that no data has been
> altered.
>
> If you ask me, I do not think the latter belongs to pblk, and if it did,
> I would suggest a whole new (optional) feature that adds this short of
> integrity protection, ideally, reusing NVMe PI. In the original pblk, we
> have followed the same assumption as block devices do; you can go an
> write on the side to a block device that has a FS on top; the block
> device will not complain at all - if the FS detects this then they will
> try to fix it, otherwise you lost data.
>
> In this context, we have discussed about a pblk tool a la fsck, which can
> cover all this cases instead of adding more complexity to the recovery
> path in the kernel. Here, you patch makes sense we fail if something
> suspicious has occurred and move the burden to the pblk tool for it to
> do the repair. But again, if the goal s adding integrity protection, it
> needs to cover the rest of the cases.
>
> Hope this makes sense.

It does! I'm not trying to do anything more than warn if the write
pointers are not what we expect them to be.

You're right, we need some sort of superblock and some recovery tool
to make pblk more robust against corruptions.
Now, we get a warning at least :)
