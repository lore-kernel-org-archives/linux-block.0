Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:61156 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdF0LjL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 07:39:11 -0400
Date: Tue, 27 Jun 2017 14:39:08 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Frans Klaver <fransklaver@gmail.com>
CC: Jens Axboe <axboe@fb.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: Re: [PATCH V2] lightnvm: if LUNs are already allocated fix return
Message-ID: <20170627113908.GA52999@dhcp-216.srv.tuxera.com>
References: <20170627104315.GA52146@dhcp-216.srv.tuxera.com>
 <CAH6sp9MMAenKxknXYkCwOY9H7h_CT9zkBTvrykssVMPOdGtzqQ@mail.gmail.com>
 <20170627112344.GA52927@dhcp-216.srv.tuxera.com>
 <CAH6sp9OYu5rTS-R263CEh_FSnKVUL1GBwk30wq3Bxr0fD8LjhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAH6sp9OYu5rTS-R263CEh_FSnKVUL1GBwk30wq3Bxr0fD8LjhA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 27, 2017 at 01:27:40PM +0200, Frans Klaver wrote:
> On Tue, Jun 27, 2017 at 1:23 PM, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > On Tue, Jun 27, 2017 at 01:01:22PM +0200, Frans Klaver wrote:
> >> On Tue, Jun 27, 2017 at 12:43 PM, Rakesh Pandit <rakesh@tuxera.com> wrote:
> >> > While creating new device with NVM_DEV_CREATE if LUNs are already
> >> > allocated ioctl would return -ENOMEM which is wrong.  This patch
> >> > propagates -EBUSY from nvm_reserve_luns which is correct response.
> >> >
> >> > Fixes: ade69e243 ("lightnvm: merge gennvm with core")
> >> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> >> > ---
> >> >
> >> > V2: return error code directly instead of using ret variable (Frans)
> >> >
> >> >  drivers/lightnvm/core.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >> > index b8f82f5..c5d71c6 100644
> >> > --- a/drivers/lightnvm/core.c
> >> > +++ b/drivers/lightnvm/core.c
> >> > @@ -253,7 +253,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> >> >         mutex_unlock(&dev->mlock);
> >> >
> >> >         if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
> >> > -               return -ENOMEM;
> >> > +               return -EBUSY;
> >>
> >> Why aren't you propagating ret in this version?
> >
> > Well nvm_reserve_luns either returns 0 or -EBUSY and it is unlikely
> > that return value would change and even if it does this can be
> > updated.
> 
> If you propagate the result of nvm_reserve_luns(), the casual reader
> will immediately understand that any possible faulty result is
> returned. returning -EBUSY here might suggest you're overriding
> whatever this function returns.

I don't have a strong opinion for or against. That was being done
irrespective of this change already.  But you have a valid argument.
I would post V3.

Thanks,
