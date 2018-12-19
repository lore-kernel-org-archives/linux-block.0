Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653A4C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 01:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6CD2133F
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 01:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHgrc8oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeLSB3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:29:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36987 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeLSB3I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 20:29:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so17404061wrt.4;
        Tue, 18 Dec 2018 17:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xykshv3SfB4eUFzVzL/WHUvfKGKWyBiadc57zfBu/6w=;
        b=XHgrc8oPZqkqrvu/gHaEkXuZhjTjw7sp5c6tWWn94GsbvxouRUz0mL8RuCJ479Ffl/
         3TKbSGVv6gWABbusnRclC54NtgytPB411K37uxba0/GocSMSkropJi39YLUrZnTqUWmD
         +P0+YxMx23oxy9WmzGGD9mNnDi5VRR5pDHqNrzGArnZReuetcQaQx6QSbedzmjcCSb33
         K7Clhm+27aVpviErR+vs5Jfm/C2ogpQEtIEG2A4JtH/T37Mvwt4I/SZKm1EAeRmT1I83
         ZopNqd1Zz5j7jJH6UZ1+Ib0OKOoEQQQ8t45elx6wnRfyVYpSjMGlnla6JwxlILqteBIp
         K8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xykshv3SfB4eUFzVzL/WHUvfKGKWyBiadc57zfBu/6w=;
        b=Ub3dPmr9c8gHDWtW3D541sQL8g8aIw6lJgAo+CFfW8SQzFYRghoySk/Prh66muHn8u
         xakPBkZSQD7L/3/DuWebndTSWosbYENq8pLK2A035qqpq4ulV9+lWG7bB/Mo/bw6pvXP
         m63ATWDMXewbjGfgWuNTxmqABBZvoXDXQ+23eJNvWm0h8n6ZldBIaAG/nO7PEezWVRHJ
         ioCBuDFPXH1aw79WpIzY3A5IncZptgp2LTayP6G1iUKmA0dRxRNnuxO15KxmpuSTkSHa
         OczqAILDC1RU1WCpepOt+IFEAwAe4RMAMUjN0TSfgPE5QcTT8K4+dTSXRAiFOQwPubTQ
         Grew==
X-Gm-Message-State: AA+aEWbtM1eU0YDzEe4FjVchkiz9ajOEGkrYa2hdFt1HySqL64twYkPc
        Yb1U4CRtSJb1kOKaAlRVQArdQcZ0W3sy954ABLw=
X-Google-Smtp-Source: AFSGD/XaUWsTIjzWz4Hzze7ufUN4DIo4W2YcK+ug6690kspbvaxAWkYKMDAVdVZIQf8ONNOfy6s1WHtcfEzlJ7tCyFI=
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr17797727wrn.109.1545182945563;
 Tue, 18 Dec 2018 17:29:05 -0800 (PST)
MIME-Version: 1.0
References: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
 <20181218140157.GB7144@kmo-pixel>
In-Reply-To: <20181218140157.GB7144@kmo-pixel>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Wed, 19 Dec 2018 09:30:15 +0800
Message-ID: <CA+NNRhGbiJt+rc3ejUF7yQFUPLLXPvttQ874RFoZ-N49Pox+YA@mail.gmail.com>
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

hello Kent
long long no see, glad to hear you again.
>> Then two steps:
>> A) update k1 to k2 in btree node memory;
>>    bch_btree_insert_keys(b, op, insert_keys, replace_key)
>> B) Write the bset(contains k2) to cache disk by a 30s delay work
>>    bch_btree_leaf_dirty(b, journal_ref).
>> But before the 30s delay work write the bset to cache device,
>> these things happend:
>> A) GC works, and reclaim the bucket k2 point to;
>> B) Allocator works, and invalidate the bucket k2 point to,
>>    and increase the gen of the bucket, and place it into free_inc
>>    fifo;
>> C) Until now, the 30s delay work still does not finish work,
>>    so in the disk, the key still is k1, it is dirty and stale
>>    (its gen is smaller than the gen of the bucket). and then the
>>    machine power off suddenly happens;
>> D) When the machine power on again, after the btree reconstruction,
>>    the stale dirty key appear.

> Only prior to journal replay, right? Or did you uncover something more se=
vere?
No, it's after the journal replay, and in write_dirty_finish(), when
replace a dirty key with
a clean key by calling bch_btree_insert(), no journal will write.

>> In bch_extent_bad(), when expensive_debug_checks is off, it would
>> treat the dirty key as good even it is stale keys, and it would
>> cause bellow probelms:
>> A) In read_dirty() it would cause machine crash:
>>    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
>> B) It could be worse when reads hits stale dirty keys, it would
>>    read old incorrect data.

>Neither of these can happen until after journal replay is finished. Prior =
to
>journal replay we expect to find stale dirty keys - if we find any after j=
ournal
>replay then it's indicative of a real bug.
As I said previous, since no journal writes after inserting a replace key i=
n
writeback, so this issue has nothing to do with journal.

This is a real problem in my environment, after running IO sometimes, I tur=
n off
the power suddenly,  then turn on the power, and the machine crash in
read_dirty()
due to the stale && dirty keys.

Kent Overstreet <kent.overstreet@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=
=8818=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:02=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Tue, Dec 18, 2018 at 02:37:14PM +0800, Junhui Tang wrote:
> > From 8ca52771f1d3b83ff55dc80ba633901a081963bf Mon Sep 17 00:00:00 2001
> > From: Tang Junhui <tang.junhui.linux@gmail.com>
> > Date: Tue, 18 Dec 2018 10:38:26 +0800
> > Subject: [PATCH] bcache: treat stale && dirty keys as bad keys
> >
> > Stale && dirty keys can be produced in the follow way:
> > After writeback in write_dirty_finish(), dirty keys k1 will
> > replace by clean keys k2
> > =3D=3D>ret =3D bch_btree_insert(dc->disk.c, &keys, NULL, &w->key);
> > =3D=3D>btree_insert_fn(struct btree_op *b_op, struct btree *b)
> > =3D=3D>static int bch_btree_insert_node(struct btree *b,
> >        struct btree_op *op,
> >        struct keylist *insert_keys,
> >        atomic_t *journal_ref,
> > Then two steps:
> > A) update k1 to k2 in btree node memory;
> >    bch_btree_insert_keys(b, op, insert_keys, replace_key)
> > B) Write the bset(contains k2) to cache disk by a 30s delay work
> >    bch_btree_leaf_dirty(b, journal_ref).
> > But before the 30s delay work write the bset to cache device,
> > these things happend:
> > A) GC works, and reclaim the bucket k2 point to;
> > B) Allocator works, and invalidate the bucket k2 point to,
> >    and increase the gen of the bucket, and place it into free_inc
> >    fifo;
> > C) Until now, the 30s delay work still does not finish work,
> >    so in the disk, the key still is k1, it is dirty and stale
> >    (its gen is smaller than the gen of the bucket). and then the
> >    machine power off suddenly happens;
> > D) When the machine power on again, after the btree reconstruction,
> >    the stale dirty key appear.
>
> Only prior to journal replay, right? Or did you uncover something more se=
vere?
>
> > In bch_extent_bad(), when expensive_debug_checks is off, it would
> > treat the dirty key as good even it is stale keys, and it would
> > cause bellow probelms:
> > A) In read_dirty() it would cause machine crash:
> >    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
> > B) It could be worse when reads hits stale dirty keys, it would
> >    read old incorrect data.
>
> Neither of these can happen until after journal replay is finished. Prior=
 to
> journal replay we expect to find stale dirty keys - if we find any after =
journal
> replay then it's indicative of a real bug.
>
> >
> > This patch tolerate the existence of these stale && dirty keys,
> > and treat them as bad key in bch_extent_bad().
> >
> > Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
> > ---
> >  drivers/md/bcache/extents.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
> > index 1d09674..f9eb03c 100644
> > --- a/drivers/md/bcache/extents.c
> > +++ b/drivers/md/bcache/extents.c
> > @@ -535,6 +535,7 @@ static bool bch_extent_bad(struct btree_keys *bk,
> > const struct bkey *k)
> >  {
> >   struct btree *b =3D container_of(bk, struct btree, keys);
> >   unsigned i, stale;
> > + char buf[80];
> >
> >   if (!KEY_PTRS(k) ||
> >       bch_extent_invalid(bk, k))
> > @@ -544,19 +545,20 @@ static bool bch_extent_bad(struct btree_keys
> > *bk, const struct bkey *k)
> >   if (!ptr_available(b->c, k, i))
> >   return true;
> >
> > - if (!expensive_debug_checks(b->c) && KEY_DIRTY(k))
> > - return false;
> > -
> >   for (i =3D 0; i < KEY_PTRS(k); i++) {
> >   stale =3D ptr_stale(b->c, k, i);
> >
> > + if (stale && KEY_DIRTY(k)) {
> > + bch_extent_to_text(buf, sizeof(buf), k);
> > + pr_info("stale dirty pointer, stale %u, key: %s",
> > +     stale,
> > +     buf);
> > + }
> > +
> >   btree_bug_on(stale > 96, b,
> >        "key too stale: %i, need_gc %u",
> >        stale, b->c->need_gc);
> >
> > - btree_bug_on(stale && KEY_DIRTY(k) && KEY_SIZE(k),
> > -      b, "stale dirty pointer");
> > -
> >   if (stale)
> >   return true;
> >
> > --
> > 1.8.3.1
