Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:14104 "EHLO
        BJEXCAS006.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752402AbdJaKdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 06:33:36 -0400
Date: Tue, 31 Oct 2017 18:33:33 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Jan Kara <jack@suse.cz>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] bdi: add error handle for bdi_debug_register
Message-ID: <20171031103332.GB1616@source.didichuxing.com>
References: <cover.1509038624.git.zhangweiping@didichuxing.com>
 <b28a35a3af256e2c64b905728b0e9df307e12b0b.1509038624.git.zhangweiping@didichuxing.com>
 <20171030131016.GI23278@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171030131016.GI23278@quack2.suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 30, 2017 at 02:10:16PM +0100, Jan Kara wrote:
> On Fri 27-10-17 01:36:14, weiping zhang wrote:
> > In order to make error handle more cleaner we call bdi_debug_register
> > before set state to WB_registered, that we can avoid call bdi_unregister
> > in release_bdi().
> > 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> >  mm/backing-dev.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index e9d6a1ede12b..54396d53f471 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -893,10 +893,13 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
> >  	if (IS_ERR(dev))
> >  		return PTR_ERR(dev);
> >  
> > +	if (bdi_debug_register(bdi, dev_name(dev))) {
> > +		device_destroy(bdi_class, dev->devt);
> > +		return -ENOMEM;
> > +	}
> >  	cgwb_bdi_register(bdi);
> >  	bdi->dev = dev;
> >  
> > -	bdi_debug_register(bdi, dev_name(dev));
> >  	set_bit(WB_registered, &bdi->wb.state);
> >  
> >  	spin_lock_bh(&bdi_lock);
> > @@ -916,6 +919,8 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
> >  	va_start(args, fmt);
> >  	ret = bdi_register_va(bdi, fmt, args);
> >  	va_end(args);
> > +	if (ret)
> > +		bdi_put(bdi);
> 
> Why do you drop bdi reference here in case of error? We didn't do it
> previously if bdi_register_va() failed for other reasons...
> 
At first I want add cleanup, because
device_add_disk->bdi_register_owner->bdi_register doen't do clanup. But
I notice that mtd_bdi_init also call bdi_register and do cleanup, so
this bdi_put() is wrong. I'll remove it at V2. Thanks a lot.

--
weiping
