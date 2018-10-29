Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44269 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeJ2Sob (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 14:44:31 -0400
Received: by mail-vk1-f196.google.com with SMTP id h128so395272vkg.11
        for <linux-block@vger.kernel.org>; Mon, 29 Oct 2018 02:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com> <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
In-Reply-To: <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
From: Hans Holmberg <hans@owltronix.com>
Date: Mon, 29 Oct 2018 10:56:22 +0100
Message-ID: <CANr-nt0kcMYrGA5fmG1HBG+Hp6DUwi7B+SWTVfjYtHYE5EGELw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix chunk close trace event check
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 26, 2018 at 8:49 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 10/26/2018 10:12 AM, Hans Holmberg wrote:
> > The check for chunk closes suffers from an off-by-one issue, leading
> > to chunk close events not being traced. Fix this.
> >
> > Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states=
")
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >
> >   drivers/lightnvm/pblk-core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index 6944aac43b01..6581c35f51ee 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pbl=
k, struct nvm_rq *rqd)
> >               if (caddr =3D=3D 0)
> >                       trace_pblk_chunk_state(pblk_disk_name(pblk),
> >                                                       ppa, NVM_CHK_ST_O=
PEN);
> > -             else if (caddr =3D=3D chunk->cnlb)
> > +             else if (caddr =3D=3D (chunk->cnlb - 1))
> >                       trace_pblk_chunk_state(pblk_disk_name(pblk),
> >                                                       ppa, NVM_CHK_ST_C=
LOSED);
> >       }
> >
>
> Thanks Hans, Applied for 4.21/5.1. Note that you're sending from your
> owntronix email account. Checkpatch complains that sender and author
> doesn't match.

Ah, I must have messed up my git configuration.
Would you mind updating the patch author to "Hans Holmberg
<hans.holmberg@cnexlabs.com>" in for-4.21/core?

Thanks,
Hans
