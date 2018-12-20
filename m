Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB4BC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 08:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46941217D8
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 08:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZNg/Yda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeLTIjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:39:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42618 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeLTIjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 03:39:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so785866wrx.9;
        Thu, 20 Dec 2018 00:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tz9TaXR6gcZrCTo+f4Wp3ZzziHem+XAiwnGimym1Lv4=;
        b=hZNg/YdardnGncRqfSfhThnUI9E37LXJiRD11GHqou2F2zvw7mdpkdIpc5MgtbTOsW
         G8alcoIDNTs0hkAeDyDlvadAhmQlPvaahSsXvL+RGx2Pl1dxWFKH1d3J7HFutN3YqOYQ
         cVKxvIrEHyeVGL1q527uoD1oJW/oGB90ZlUPOo64HgyBWd75iAdhvZkT1bIDnerLUhz3
         D4Nwc0XHkByyl8FdLt21WSg4ZjHVETm7eAFD74uUfCL/fo6MXhqgTprKus6HOwpI++8N
         6AlSzK+ObpomsFce4mVY6LtVKD6Tz6xJ6tCJKbXg4m/rS1A2DWyorIqSvii4Jtu0TkvE
         2M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tz9TaXR6gcZrCTo+f4Wp3ZzziHem+XAiwnGimym1Lv4=;
        b=IsXA5nPCSpiOg3DGbeF2bBO5z5mM2o9DUIsdSKFn+X1aSfFbHQGR2nCbNp+3zCuVQr
         3H7P6F3yUmp/xdDmiGcK2HgpiMW/v6b6bv+Iqh47tbHPQZEM6IB0GiRoU2mH5nHEXVNj
         VTzw6XHCmZDKfFfYmXO2+24dpIX6MjkSe/jKALHA1sjhmZA3yzTDbrbTANLKuX8AvyU/
         +8QNMv42foa/+O+Ucg8Ussdi9GqxEz3Lb43SToPjGCIAE89Z4hdljHcfwT0C3u9AIcM8
         i+gLdSBPNXAVpsPIsEP4ssHICWgH78DyAedqZ4ikvpXepecd1jgbKElVHfrwAV4hgBgV
         nW4Q==
X-Gm-Message-State: AA+aEWbbsqYHkIG5/Ls2Vs3/l8Z6RSAs4EHITHcOTrRGUiu+lfwfsfrw
        9YZGCll+9ReLDJWiacx3r9rNPNmVAmddo4pHgFA0zaPkKjc=
X-Google-Smtp-Source: AFSGD/WF3MPlg4LE+eQNmaKGet71VhjPKmhuWzL79qXZt25uDArF+KjqMDm+nmXffCONIZt5vdMTULKOxSMTsKVUw04=
X-Received: by 2002:a5d:6907:: with SMTP id t7mr21130763wru.226.1545295158850;
 Thu, 20 Dec 2018 00:39:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
 <20181218140157.GB7144@kmo-pixel> <CA+NNRhFgAqHSxYP2TqDx_bLNGYOEe8paHU9dz7Nos=dhMDK9gQ@mail.gmail.com>
 <20181219113238.GA13550@kmo-pixel>
In-Reply-To: <20181219113238.GA13550@kmo-pixel>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Thu, 20 Dec 2018 16:40:06 +0800
Message-ID: <CA+NNRhHj==hzonpTFmC1mk5wabqqkQGOno-+Zay8FhXPiM6y3Q@mail.gmail.com>
Subject: Re: [PATCH] bcache: treat stale && dirty keys as bad keys
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kent Overstreet <kent.overstreet@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:32=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Wed, Dec 19, 2018 at 09:32:55AM +0800, Junhui Tang wrote:
> > hello Kent
> >
> > Long long no see, glad to hear you again.
> >
> > >> Then two steps:
> > >> A) update k1 to k2 in btree node memory;
> > >>    bch_btree_insert_keys(b, op, insert_keys, replace_key)
> > >> B) Write the bset(contains k2) to cache disk by a 30s delay work
> > >>    bch_btree_leaf_dirty(b, journal_ref).
> > >> But before the 30s delay work write the bset to cache device,
> > >> these things happend:
> > >> A) GC works, and reclaim the bucket k2 point to;
> > >> B) Allocator works, and invalidate the bucket k2 point to,
> > >>    and increase the gen of the bucket, and place it into free_inc
> > >>    fifo;
> > >> C) Until now, the 30s delay work still does not finish work,
> > >>    so in the disk, the key still is k1, it is dirty and stale
> > >>    (its gen is smaller than the gen of the bucket). and then the
> > >>    machine power off suddenly happens;
> > >> D) When the machine power on again, after the btree reconstruction,
> > >>    the stale dirty key appear.
> >
> > > Only prior to journal replay, right? Or did you uncover something mor=
e severe?
> > No, it's after the journal replay, and in write_dirty_finish(), when
> > replace a dirty key with a clean key by calling bch_btree_insert(),
> > no journal will write.
>
> Holy crap you're right, this was from before I moved journalling to be dr=
iven by
> the btree update path.
>
> I think a better fix here would be to journal the btree updates writeback=
 does,
> but given that we haven't been journalling those updates all this time yo=
ur fix
> does make sense too.

Journal those updates would consume lots of resources, so I don't think it =
a
good way. And this fix is very simple.

Kent, Could you add an Acked-by or Reviewed-by for this patch? So Coly
can put it to upstream.
>
> >
> > >> In bch_extent_bad(), when expensive_debug_checks is off, it would
> > >> treat the dirty key as good even it is stale keys, and it would
> > >> cause bellow probelms:
> > >> A) In read_dirty() it would cause machine crash:
> > >>    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
> > >> B) It could be worse when reads hits stale dirty keys, it would
> > >>    read old incorrect data.
> >
> > >Neither of these can happen until after journal replay is finished. Pr=
ior to
> > >journal replay we expect to find stale dirty keys - if we find any aft=
er journal
> > >replay then it's indicative of a real bug.
> > As I said previous, since no journal writes after inserting a replace k=
ey in
> > writeback, so this issue has nothing to do with journal.
> >
> > This is a real problem in my environment, after running IO sometimes, I=
 turn off
> > the power suddenly,  then turn on the power, and the machine crash in
> > read_dirty() due to the stale && dirty keys.
