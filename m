Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34152 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbdEWOac (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 10:30:32 -0400
Received: by mail-qk0-f176.google.com with SMTP id k74so131763180qke.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2017 07:30:31 -0700 (PDT)
Date: Tue, 23 May 2017 10:30:29 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Josef Bacik <jbacik@fb.com>, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd: don't leak nbd_config
Message-ID: <20170523143029.GA3915@destiny>
References: <1495535911-29036-1-git-send-email-idryomov@gmail.com>
 <20170523141445.GA1568@destiny>
 <8e9d481e-462e-c3f7-8c35-d80f87d1de9a@fb.com>
 <CAOi1vP-MEe6deZzwHt1btXALrDshwcxM79ZrG0uaGd1wRV_xWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOi1vP-MEe6deZzwHt1btXALrDshwcxM79ZrG0uaGd1wRV_xWA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 04:27:56PM +0200, Ilya Dryomov wrote:
> On Tue, May 23, 2017 at 4:16 PM, Jens Axboe <axboe@fb.com> wrote:
> > On 05/23/2017 08:14 AM, Josef Bacik wrote:
> >> On Tue, May 23, 2017 at 12:38:31PM +0200, Ilya Dryomov wrote:
> >>> nbd_config is allocated in nbd_alloc_config(), but never freed.
> >>>
> >>> Fixes: 5ea8d10802ec ("nbd: separate out the config information")
> >>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> >>> ---
> >>>  drivers/block/nbd.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>
> >> Oops, thanks Ilya
> >>
> >> Reviewed-by: Josef Bacik <jbacik@fb.com>
> >
> > Since config is referenced, why isn't this done in nbd_config_put()
> > instead?
> 
> Josef's 5ea8d10802ec added that nbd->config = NULL to nbd_reset(), so
> I followed his lead.  It could be done nbd_config_put() -- nbd_reset()
> call in nbd_dev_add() looks like a no-op to me.  Josef?
> 

Yeah it used to be called more, but when I moved the config to be ref counted it
lost it's old uses and I just didn't notice enough to delete it.  Just fold that
into nbd_config_put() and call it a day.  Thanks,

Josef
