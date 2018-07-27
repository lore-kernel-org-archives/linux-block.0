Return-Path: <linux-block-owner@vger.kernel.org>
Received: from jablonecka.jablonka.cz ([91.219.244.36]:59902 "EHLO
        jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbeG0Xi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 19:38:26 -0400
Date: Fri, 27 Jul 2018 23:53:14 +0200
From: Vojtech Pavlik <vojtech@suse.com>
To: Noah Massey <noah.massey@gmail.com>
Cc: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] bcache: initiate bcache_debug to NULL
Message-ID: <20180727215314.lcjnzl3cpognyqhn@suse.cz>
References: <20180726142239.44669-1-colyli@suse.de>
 <20180726142239.44669-9-colyli@suse.de>
 <CADfjVrhRtwdGF6bs_yCQms=TXxHynZb87r9gzRNoicQ70-n8OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADfjVrhRtwdGF6bs_yCQms=TXxHynZb87r9gzRNoicQ70-n8OQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 27, 2018 at 01:37:57PM -0400, Noah Massey wrote:

> On Thu, Jul 26, 2018, 10:23 AM Coly Li <colyli@suse.de> wrote:
> 
> > Global variable bcache_debug is firstly initialized in bch_debug_init(),
> > and destroyed in bch_debug_exit(). bch_debug_init() is called in
> > bcache_init() with many other functions, if one of the previous calling
> > onces failed, bcache_exit() will be called in the failure path.
> >
> > The problem is, if bcache_init() fails before bch_debug_init() is called,
> > then in bcache_exit() when bch_debug_exit() is called to destroy global
> > variable bcache_debug, at this moment bcache_debug is unndefined, then the
> > test of "if (!IS_ERR_OR_NULL(bcache_debug))" might be buggy.
> >
> > This patch initializes global varabile bcache_debug to be NULL, to make
> > the failure code path to be predictable.
> >
> > Signed-off-by: Coly Li <colyli@suse.de>
> > ---
> >
> 
> Makes sense
> 
> Reviewed-by: Noah Massey <noah.massey@gmail.com>

Aren't global variables zeroed by default anyway?

>  drivers/md/bcache/debug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> > index 57f8f5aeee55..24b0eb65ddec 100644
> > --- a/drivers/md/bcache/debug.c
> > +++ b/drivers/md/bcache/debug.c
> > @@ -17,7 +17,7 @@
> >  #include <linux/random.h>
> >  #include <linux/seq_file.h>
> >
> > -struct dentry *bcache_debug;
> > +struct dentry *bcache_debug = NULL;
> >
> >  #ifdef CONFIG_BCACHE_DEBUG
> >
> > --
> > 2.17.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

-- 
Vojtech Pavlik
Director SUSE Labs
