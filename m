Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1559C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E1320675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="yvqcGHKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCFOTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:19:13 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44789 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCFOTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:19:13 -0500
Received: by mail-vs1-f67.google.com with SMTP id r201so2283988vsc.11
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oHgn3xhXKrdu6b5i1xePy8oP4hEd0QcgBf8XN3JGbZY=;
        b=yvqcGHKNafX0bIUJsMbFpKb7iTcu5sYBMpqMVkQ2NIK7a0GPVRH6JyiE5+HUAOZjVL
         35pxz6OqLV24reCVPCGwk57rZKpFKMwiiLB8w3RAOFFnNBnRy3EnQ8qqd5hfcm+ku/dd
         i0iTOSM1Dj87121WJfyOGGtKIJiVVyy9yYvmyVso9c+Uy3yTW4KNhkv5ZKlraMvNxHza
         0/h8oygRDRwa4nPZwwJ2gq0XSiT4a+rPvxkMcND8sEjlYG3U297SCFYDe8xJGWRIYTQs
         1eRFpIomgU3Z6c9an1EUs3E0/+Ist2BoeDmS6fIiCKWuiR77+HzukbdIe3QuDwWBuiN5
         CkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oHgn3xhXKrdu6b5i1xePy8oP4hEd0QcgBf8XN3JGbZY=;
        b=swhoFMutiWlajNdlkDh4MWCNcOTsSsvnTQflsumecjIQN0b3x181jlZSIsGSPfmsX2
         LcgW/n0KJz4fMylIGSXCor2jhIgbkCMZ1mKjys8WIiukV86YKh0E/GWfwS6yKFzBaNMM
         jP9L9H7pCB5udyTvd/2Kz7NGzYEW/rXgX2cOn+UtkmNIX/5cYv3Mxga/4jRDO7QEdE2f
         M4SMDS23xn69Dx94fjNjzln+Xr6Zp56O3ox0KrBN7Kl4FdRbsgLw86ndPtWIgaekyF21
         /W/+sBz3zshAT/bPgZFQeurk/RhzPU+hr4Alc4Uqqj1I/sUtwHoc2FXV7WEYDr8PaJ43
         TJyA==
X-Gm-Message-State: APjAAAU3fRXJnSSqMte5mDcDdinBr0TK5Gy0IGGcDjw7ZQ2/B5s/ZtSe
        iAVXXpHxCBjHuTEJj/QsdCrPP4FF6etgMDY9yW+Y9Zkj68g=
X-Google-Smtp-Source: APXvYqzSdoLVgddCkkxXn7t1F1tq380qt7pgwLV7JA32K3gA8DvAlAme6GH5CxsWoWjyH3svLLD9hy1q+LSVm2kRxps=
X-Received: by 2002:a67:f409:: with SMTP id p9mr3987826vsn.213.1551881952223;
 Wed, 06 Mar 2019 06:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-4-igor.j.konopko@intel.com> <7739757A-D33E-4E82-A050-09CBB32EDE46@javigon.com>
In-Reply-To: <7739757A-D33E-4E82-A050-09CBB32EDE46@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:19:01 +0100
Message-ID: <CANr-nt1U5Ucygm2YCg5wPKZHDdB+iM_uH-t4Mr=c_OzwTzrt7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] lightnvm: pblk: Count all read errors in stats
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 6, 2019 at 8:28 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 5 Mar 2019, at 14.51, Igor Konopko <igor.j.konopko@intel.com> wrote:
> >
> > Currently when unknown error occurs on read path there is only dmesg
> > information about it, but it is not counted in sysfs statistics.
> >
> > We would also like to track the number of such a requests, so new type
> > of counter 'read_ctrl_errors" is added in that patch.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c  | 1 +
> > drivers/lightnvm/pblk-init.c  | 1 +
> > drivers/lightnvm/pblk-sysfs.c | 3 ++-
> > drivers/lightnvm/pblk.h       | 1 +
> > 4 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index 39280c1..64280e6 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nv=
m_rq *rqd)
> >               atomic_long_inc(&pblk->read_failed);
> >               break;
> >       default:
> > +             atomic_long_inc(&pblk->read_ctrl_errors);
> >               pblk_err(pblk, "unknown read error:%d\n", rqd->error);
> >       }
> > #ifdef CONFIG_NVM_PBLK_DEBUG
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
> > index 81e8ed4..f4b6d8f2 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -1230,6 +1230,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, s=
truct gendisk *tdisk,
> >       atomic_long_set(&pblk->read_empty, 0);
> >       atomic_long_set(&pblk->read_high_ecc, 0);
> >       atomic_long_set(&pblk->read_failed_gc, 0);
> > +     atomic_long_set(&pblk->read_ctrl_errors, 0);
> >       atomic_long_set(&pblk->write_failed, 0);
> >       atomic_long_set(&pblk->erase_failed, 0);
> >
> > diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysf=
s.c
> > index 7d8958d..922273c 100644
> > --- a/drivers/lightnvm/pblk-sysfs.c
> > +++ b/drivers/lightnvm/pblk-sysfs.c
> > @@ -94,11 +94,12 @@ static ssize_t pblk_sysfs_stats(struct pblk *pblk, =
char *page)
> >       ssize_t sz;
> >
> >       sz =3D snprintf(page, PAGE_SIZE,
> > -                     "read_failed=3D%lu, read_high_ecc=3D%lu, read_emp=
ty=3D%lu, read_failed_gc=3D%lu, write_failed=3D%lu, erase_failed=3D%lu\n",
> > +                     "read_failed=3D%lu, read_high_ecc=3D%lu, read_emp=
ty=3D%lu, read_failed_gc=3D%lu, read_ctrl_errors=3D%lu, write_failed=3D%lu,=
 erase_failed=3D%lu\n",
> >                       atomic_long_read(&pblk->read_failed),
> >                       atomic_long_read(&pblk->read_high_ecc),
> >                       atomic_long_read(&pblk->read_empty),
> >                       atomic_long_read(&pblk->read_failed_gc),
> > +                     atomic_long_read(&pblk->read_ctrl_errors),
> >                       atomic_long_read(&pblk->write_failed),
> >                       atomic_long_read(&pblk->erase_failed));
> >
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index 381f074..6c82776 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -684,6 +684,7 @@ struct pblk {
> >       atomic_long_t read_empty;
> >       atomic_long_t read_high_ecc;
> >       atomic_long_t read_failed_gc;
> > +     atomic_long_t read_ctrl_errors;
> >       atomic_long_t write_failed;
> >       atomic_long_t erase_failed;
> >
> > --
> > 2.9.5
>
> The only nitpick would be that if any user space script is relying on
> the syses output for the errors, this could break them. Maybe we could
> add a sysfs version file to mange this? Otherwise, it looks good.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

Agree with Javier here, as sysfs interfaces are supposed to be stable
(in the absence of a version file), so adding one would be a good
idea.
