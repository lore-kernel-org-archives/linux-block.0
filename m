Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:39904 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdF0J6J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 05:58:09 -0400
Date: Tue, 27 Jun 2017 12:58:07 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Frans Klaver <fransklaver@gmail.com>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, <axboe@fb.com>,
        <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH] ligtnvm: if LUNs are already allocated fix return
Message-ID: <20170627095806.GA51634@dhcp-216.srv.tuxera.com>
References: <20170627083950.11312-1-matias@cnexlabs.com>
 <20170627083950.11312-2-matias@cnexlabs.com>
 <CAH6sp9NuonymjV0n2nsChcTKZ6sq5+S_s3uQ-48M0mY9LQh9mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <CAH6sp9NuonymjV0n2nsChcTKZ6sq5+S_s3uQ-48M0mY9LQh9mg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Frans,

On Tue, Jun 27, 2017 at 11:06:44AM +0200, Frans Klaver wrote:
> On Tue, Jun 27, 2017 at 10:39 AM, Matias Bj�rling wrote:
> > From: Rakesh Pandit <rakesh@tuxera.com>
> >
> > While creating new device with NVM_DEV_CREATE if LUNs are already
> > allocated ioctl would return -ENOMEM which is wrong.  This patch
> > propagates -EBUSY from nvm_reserve_luns which is correct response.
> >
> > Fixes: ade69e243 ("lightnvm: merge gennvm with core")
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > Signed-off-by: Matias Bj�rling <matias@cnexlabs.com>
> > ---
> >  drivers/lightnvm/core.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> > index b8f82f5..9ff348f 100644
> > --- a/drivers/lightnvm/core.c
> > +++ b/drivers/lightnvm/core.c
> > @@ -235,7 +235,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> >         struct nvm_target *t;
> >         struct nvm_tgt_dev *tgt_dev;
> >         void *targetdata;
> > -       int ret;
> > +       int ret = 0;
> 
> Is there any way that you can reach a 'return ret' without having ret
> set by some other assignment?
> 
>

No.

I should have been more careful.

> >         tt = nvm_find_target_type(create->tgttype, 1);
> >         if (!tt) {
> > @@ -252,8 +252,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> >         }
> >         mutex_unlock(&dev->mlock);
> >
> > -       if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
> > -               return -ENOMEM;
> > +       ret = nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
> > +       if (ret)
> > +               goto err;
> 
> Why don't you return err straight away here?

Intent was to future-proofing if num_reserve_luns would return
anything other than -EBUSY and 0 but yes returning -EBUSY directly
would be fine.

> 
> 
> >         t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
> >         if (!t) {
> > @@ -314,8 +315,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> >         mutex_lock(&dev->mlock);
> >         list_add_tail(&t->list, &dev->targets);
> >         mutex_unlock(&dev->mlock);
> > -
> > -       return 0;
> > +err:
> > +       return ret;
> 
> This should not be necessary. In any case, the de-init order should
> always be the reverse of the init order, so we don't end up confused.

Only if we directly return -EBUSY.  Good point about getting confused
I would resend quickly by directly returning error.  That would not
confuse folks.

I would send an alternate patch which returns -EBUSY directly and do
same thing.

Thanks,

> 
> Frans
