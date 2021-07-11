Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD6C07E96
	for <linux-block@archiver.kernel.org>; Sun, 11 Jul 2021 05:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1681A613AF
	for <linux-block@archiver.kernel.org>; Sun, 11 Jul 2021 05:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhGKFDb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jul 2021 01:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhGKFDb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jul 2021 01:03:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BEA86128C;
        Sun, 11 Jul 2021 05:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625979644;
        bh=LabtziYmIibDl3S/j2tFIXcw/GEXbgb0a6inH+Q2Z6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbG0jUtv0e4NC5AXUHWyOh7xB21IjwO1L7Gdd7R/vb8tKSaB+JOrftFwPfUreVAkA
         0HcnYGpZS52GlInwxcyP6TwmWd4AFxY2u6cFjlDB3Ws+qNzgz+V8KLxXCEFeHJ3UAo
         DAmaHIdGqANHla5vqF8QkgTzd/XBs3WztYTowbc0=
Date:   Sun, 11 Jul 2021 07:00:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, minchan@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, rafael@kernel.org,
        axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <YOp6+vlBRM5RqofW@kroah.com>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
 <20210710122851.aae9783ae9b1a703d565cbec@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710122851.aae9783ae9b1a703d565cbec@linux-foundation.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 10, 2021 at 12:28:51PM -0700, Andrew Morton wrote:
> On Fri,  2 Jul 2021 17:19:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> > +static ssize_t module_ ## _name ## _store(struct device *dev, \
> > +				   struct device_attribute *attr, \
> > +				   const char *buf, size_t len) \
> > +{ \
> > +	ssize_t __ret; \
> > +	if (!try_module_get(THIS_MODULE)) \
> > +		return -ENODEV; \
> > +	__ret = _name ## _store(dev, attr, buf, len); \
> > +	module_put(THIS_MODULE); \
> > +	return __ret; \
> > +}
> 
> I assume that Greg's comments on try_module_get() are applicable here
> also.

Yes, this is still broken code and does not do what it says it does,
please do not merge it.

Again, almost anything that does try_module_get(THIS_MODULE) is broken,
this code included.  I'll write more in a week or so when I get a chance
to get to this series in my reviews...

thanks,

greg k-h
