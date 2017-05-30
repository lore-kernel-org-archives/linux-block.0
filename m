Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36383 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdE3NY6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 09:24:58 -0400
Received: by mail-it0-f47.google.com with SMTP id o5so41342754ith.1
        for <linux-block@vger.kernel.org>; Tue, 30 May 2017 06:24:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170529090548.GA33534@dhcp-216.srv.tuxera.com>
References: <20170513195038.GA8782@hercules.tuxera.com> <0BEA8552-A2D0-4B70-A9CF-98A019726FCC@cnexlabs.com>
 <20170529090548.GA33534@dhcp-216.srv.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Date: Tue, 30 May 2017 15:24:57 +0200
Message-ID: <CAOA7RkOe4QgFMKg6UqjMFknAsjc13w2Pa4bS-mLE1Sm9UogDGg@mail.gmail.com>
Subject: Re: [PATCH] ligtnvm: if LUNs are already allocated fix return
To: Rakesh Pandit <rakesh@tuxera.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 29, 2017 at 11:05 AM, Rakesh Pandit <rakesh@tuxera.com> wrote:
> Hi Matias,
>
> On Mon, May 15, 2017 at 06:31:58AM +0000, Javier Gonzalez wrote:
>> >
>> > On 13 May 2017, at 21.50, Rakesh Pandit <rakesh@tuxera.com> wrote:
>> >
>> > While creating new device with NVM_DEV_CREATE if LUNs are already
>> > allocated ioctl would return -ENOMEM which is wrong.  This patch
>> > propagates -EBUSY from nvm_reserve_luns which is correct response.
>> >
>> > Fixes: ade69e243 ("lightnvm: merge gennvm with core")
>> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> > ---
>> > drivers/lightnvm/core.c | 11 ++++++-----
>> > 1 file changed, 6 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> > index 6a4aa60..440deb5 100644
>> > --- a/drivers/lightnvm/core.c
>> > +++ b/drivers/lightnvm/core.c
>> > @@ -235,7 +235,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, str=
uct nvm_ioctl_create *create)
>> >     struct nvm_target *t;
>> >     struct nvm_tgt_dev *tgt_dev;
>> >     void *targetdata;
>> > -   int ret;
>> > +   int ret =3D 0;
>> >
>> >     tt =3D nvm_find_target_type(create->tgttype, 1);
>> >     if (!tt) {
>> > @@ -252,8 +252,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, str=
uct nvm_ioctl_create *create)
>> >     }
>> >     mutex_unlock(&dev->mlock);
>> >
>> > -   if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
>> > -           return -ENOMEM;
>> > +   ret =3D nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
>> > +   if (ret)
>> > +           goto err;
>> >
>> >     t =3D kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
>> >     if (!t) {
>> > @@ -314,8 +315,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, str=
uct nvm_ioctl_create *create)
>> >     mutex_lock(&dev->mlock);
>> >     list_add_tail(&t->list, &dev->targets);
>> >     mutex_unlock(&dev->mlock);
>> > -
>> > -   return 0;
>> > +err:
>> > +   return ret;
>> > err_sysfs:
>> >     if (tt->exit)
>> >             tt->exit(targetdata);
>> > --
>> > 2.9.3
>>
>> Looks good.
>>
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>
>
> May you review/approve this so that it gets queued ?

Thanks, Rakesh. Will do. Queued it up for 4.13.

-Matias
