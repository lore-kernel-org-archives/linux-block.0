Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A803C7EE2F
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 20:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCCUa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCCUa4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 15:30:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CBD584B5
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 12:30:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4752457wmb.0
        for <linux-block@vger.kernel.org>; Fri, 03 Mar 2023 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677875453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3yvMwjt6xFYaMq/afOnMv1J07K4v3G6XTO2evlZ7mY=;
        b=KBK7hG35eJ18DWv2F0xdxjcpt+QT9cF+RvIaR4O0T1Ystw4isvSs199DJOmeju7gp8
         +aveiV0I/5gSqZL2FWPZloEb47Zbo86hrwg06JPhS/9H9IIA12JTXd2F00BIjpvNH3Uw
         mfNCyu1fPJ8KNcloLT7d43gxvl6CO1N/0THEOwWOeA3gY4FhZdJK9TptUQT6Q2vl582b
         EFBfjFaJFredisuFhKhSRj0RBXc4yGTJA+NvRrs5FCCgjskMtDwS7svk+ZsUI1MtTVlD
         tZA8Qhm+17o2lg2byGcceZOeXE+vbSW+BsUGl6DbXyGPG3NOqQME8wHewDZNWBLFtF06
         ADBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3yvMwjt6xFYaMq/afOnMv1J07K4v3G6XTO2evlZ7mY=;
        b=pP4Qqo1433kKi8nQsY1VXhBn/RrITjKD+G16WbIDd9vs3dzXndFy9hwjAOY/VDIVtp
         pUBzw9g7NbLjbs5dFgxJkz0izW+A/LAeZGGPUHWGdJRzCrtSIXhlDSGMa3tO5mbNsGoe
         nPNDGNfi0WPziddP0CMSINDHYvxIjJiwvne7JbRqV7aJFAZ4uR1b4Yt+9Js/l4nF0Spe
         dPmtUjSXJMYYXk9ZP+MRMJaE5iLsNfEQW4VKGuoxO0vvBYXrhmP4PPKKPsP6D6BMh2ru
         aU+dkgy+FOb2BfzzGjU4sxaYvi1i0T4ju0Cm5tVvSLruEA5q6kcosjD7NDW/MIw4DlCS
         zLRQ==
X-Gm-Message-State: AO0yUKV/+asKYpzBVfq+iPaRjDUSrOPbUe+b/yu1xkhfaT4kM113neCG
        bDWEoFb2uRYwGLJwWACU3jNgbUcJQBZcduTEXCi9ijxHpO3BTTnjJVo=
X-Google-Smtp-Source: AK7set+Q58mXwFqpdfGGoGb/9qe4TgdagAF/hR0+0hLQuUSfyK2f2DVusn5lzPjtI3t227/kvK5CSZ02qTHImLt3K3c=
X-Received: by 2002:a7b:c2a2:0:b0:3e1:787:d706 with SMTP id
 c2-20020a7bc2a2000000b003e10787d706mr680695wmk.2.1677875453543; Fri, 03 Mar
 2023 12:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20230303071959.144604-1-ebiggers@kernel.org> <20230303071959.144604-3-ebiggers@kernel.org>
 <CAJkfWY7KNcJwLKST6TefRZ6TyFNd6C1LXo_tD2yWGdVMjmsOtA@mail.gmail.com> <ZAJPcMibOQ9DARmp@gmail.com>
In-Reply-To: <ZAJPcMibOQ9DARmp@gmail.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Fri, 3 Mar 2023 12:30:42 -0800
Message-ID: <CAJkfWY6BGT-++LjcAs=JELOn_54-TRquJfjz0bx-yw30g0mt-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] blk-crypto: make blk_crypto_evict_key() more robust
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fscrypt@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

You're right. Nevermind.

Reviewed-by: Nathan Huckleberry <nhuck@google.com>

On Fri, Mar 3, 2023 at 11:50=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Fri, Mar 03, 2023 at 11:45:00AM -0800, Nathan Huckleberry wrote:
> > >  int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
> > >                            const struct blk_crypto_key *key)
> > > @@ -389,22 +377,22 @@ int __blk_crypto_evict_key(struct blk_crypto_pr=
ofile *profile,
> > >
> > >         blk_crypto_hw_enter(profile);
> > >         slot =3D blk_crypto_find_keyslot(profile, key);
> > > -       if (!slot)
> > > -               goto out_unlock;
> > > -
> > > -       if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) !=3D 0)) {
> > > -               err =3D -EBUSY;
> > > -               goto out_unlock;
> > > +       if (slot) {
> > > +               if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) !=3D 0=
)) {
> > > +                       /* BUG: key is still in use by I/O */
> > > +                       err =3D -EBUSY;
> > > +               } else {
> > > +                       err =3D profile->ll_ops.keyslot_evict(
> > > +                                       profile, key,
> > > +                                       blk_crypto_keyslot_index(slot=
));
> > > +               }
> > > +               /*
> > > +                * Callers may free the key even on error, so unlink =
the key
> > > +                * from the hash table and clear slot->key even on er=
ror.
> > > +                */
> > > +               hlist_del(&slot->hash_node);
> > > +               slot->key =3D NULL;
> > >         }
> >
> > The !slot case still needs to be handled. If profile->num_slots !=3D 0
> > and !slot, we'll get an invalid index from blk_crypto_keyslot_index.
> >
> > With that change,
> > Reviewed-by: Nathan Huckleberry <nhuck@google.com>
> >
> > Thanks,
> > Huck
> >
> > > -       err =3D profile->ll_ops.keyslot_evict(profile, key,
> > > -                                           blk_crypto_keyslot_index(=
slot));
> > > -       if (err)
> > > -               goto out_unlock;
> > > -
> > > -       hlist_del(&slot->hash_node);
> > > -       slot->key =3D NULL;
> > > -       err =3D 0;
> > > -out_unlock:
> > >         blk_crypto_hw_exit(profile);
> > >         return err;
> > >  }
>
> I'm not sure what you're referring to.  The !slot case is handled correct=
ly, and
> it's the same as before.
>
> - Eric
