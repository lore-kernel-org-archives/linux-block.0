Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C06C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607D860EE6
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhGWKfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 06:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhGWKfT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 06:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB1CF60EBD;
        Fri, 23 Jul 2021 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627038951;
        bh=vPpc4EBJHfaWG3UHa1IL/ov8VeoKpBgjAjG5K6zxFA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIKLySDVvcFzKJ/ht2HpdPzrhRBzdM63jR4veD8E24cNoyNWHpYsFnuTJfMNOrqN/
         mrE/yotkZCfG+BlWLB57UZo9Sz7yaMqUBFlRJBf75pFfZG9gNGI8/zcEn9h2fn0mkM
         0AYxMggHkHJycXvRQTjJYqN/xU+1xK0f3QTLG81U=
Date:   Fri, 23 Jul 2021 13:15:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <YPqk5WCBgvNQzq4S@kroah.com>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
 <YPgFGd+FZQZWODY7@kroah.com>
 <20210722221705.kyrdkpt6fwf5k56o@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722221705.kyrdkpt6fwf5k56o@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 03:17:05PM -0700, Luis Chamberlain wrote:
> On Wed, Jul 21, 2021 at 01:29:29PM +0200, Greg KH wrote:
> > On Fri, Jul 02, 2021 at 05:19:57PM -0700, Luis Chamberlain wrote:
> > > +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> > > +static ssize_t module_ ## _name ## _store(struct device *dev, \
> > > +				   struct device_attribute *attr, \
> > > +				   const char *buf, size_t len) \
> > > +{ \
> > > +	ssize_t __ret; \
> > > +	if (!try_module_get(THIS_MODULE)) \
> > > +		return -ENODEV; \
> > 
> > I feel like this needs to be written down somewhere as I see it come up
> > all the time.
> 
> I'll go ahead and cook up a patch to do just this after I send this
> email out.
> 
> > Again, this is racy and broken code.  You can NEVER try to increment
> > your own module reference count unless it has already been incremented
> > by someone external first.
> 
> In the zram driver's case the sysfs files are still pegged on, because
> as we noted before the kernfs active reference will ensure the store
> operation still exists.

How does that happen without a module lock?

> If the driver removes the operation prior to
> getting the active reference, the write will just fail. kernfs ensures
> once a file is opened the op is not removed until the operation completes.

How does it do that?

> If a file is opened then, the module cannot possibly be removed. The
> piece of information we realy care about is the use of module_is_live()
> inside try_module_get() which does:
> 
> static inline bool module_is_live(struct module *mod)
> {                                                                               
> 	return mod->state != MODULE_STATE_GOING;
> }
> 
> The try allows module removal to trump use of the sysfs file. If
> userspace wants the module removed, it gives up in favor for that
> operation.

I do not see the tie in kernfs to module reference counts, what am I
missing?

thanks,

greg k-h
