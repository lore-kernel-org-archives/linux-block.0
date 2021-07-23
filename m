Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB964C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DF360F12
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGWRIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:08:50 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:53037 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGWRIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 13:08:49 -0400
Received: by mail-pj1-f41.google.com with SMTP id m1so3303284pjv.2;
        Fri, 23 Jul 2021 10:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVq7BuihyDs6U5fbD+HjeGXA6oSWtvxoBeFtNKI0rF4=;
        b=n2AUiOH1UF5IQ36xjaaI358Wwt1nvI3AFipRBBAZsbGOg1iDPlG4k9fkLOwMXlDI8k
         Tsr594tBxDMd/ttSvM8MUMRycI9UeFHMEzbqE7PCtXoCGyjnZIcxHZvS/D5kmdUOL8p1
         5j5c9lNZrlYb3LqjcuRMMk+R6svJ9Vkgj5eC2gjxtgNZfLT+dbOGPumDjl+R4+cREP4X
         Tabl7ebZpHUt+pxBDUIdnhZWTlUF67PG/6aExAJ39uLNaN19RkUu/76MW3Jt4OwYORz6
         0K0sknLntQA14E54hVB24tjHledlwTGF9wF10Soc/aXII5nz08LZus2jPRDEUXu9PKKK
         UCFQ==
X-Gm-Message-State: AOAM5339FBHmTpZuePX9BXdMVUTt1yXpziyMkvPibS+uqGm8iY0lxkPY
        4LPjI5v9aihUe/sQBMynhZw=
X-Google-Smtp-Source: ABdhPJxBqtQcKyF1sSsYYs3OWkdIcNd2VpqffePNt9jVQr4QToTgSVSslxrOsKh+UU91fYCM3uwM2w==
X-Received: by 2002:a17:902:d4d2:b029:12b:72cf:9178 with SMTP id o18-20020a170902d4d2b029012b72cf9178mr4657436plg.53.1627062562844;
        Fri, 23 Jul 2021 10:49:22 -0700 (PDT)
Received: from garbanzo ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id t10sm38653566pgv.52.2021.07.23.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:49:21 -0700 (PDT)
Date:   Fri, 23 Jul 2021 10:49:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <20210723174919.ka3tzyre432uilf7@garbanzo>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
 <YPgFGd+FZQZWODY7@kroah.com>
 <20210722221705.kyrdkpt6fwf5k56o@garbanzo>
 <YPqk5WCBgvNQzq4S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPqk5WCBgvNQzq4S@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 23, 2021 at 01:15:49PM +0200, Greg KH wrote:
> On Thu, Jul 22, 2021 at 03:17:05PM -0700, Luis Chamberlain wrote:
> > On Wed, Jul 21, 2021 at 01:29:29PM +0200, Greg KH wrote:
> > > On Fri, Jul 02, 2021 at 05:19:57PM -0700, Luis Chamberlain wrote:
> > > > +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> > > > +static ssize_t module_ ## _name ## _store(struct device *dev, \
> > > > +				   struct device_attribute *attr, \
> > > > +				   const char *buf, size_t len) \
> > > > +{ \
> > > > +	ssize_t __ret; \
> > > > +	if (!try_module_get(THIS_MODULE)) \
> > > > +		return -ENODEV; \
> > > 
> > > I feel like this needs to be written down somewhere as I see it come up
> > > all the time.
> > 
> > I'll go ahead and cook up a patch to do just this after I send this
> > email out.
> > 
> > > Again, this is racy and broken code.  You can NEVER try to increment
> > > your own module reference count unless it has already been incremented
> > > by someone external first.
> > 
> > In the zram driver's case the sysfs files are still pegged on, because
> > as we noted before the kernfs active reference will ensure the store
> > operation still exists.
> 
> How does that happen without a module lock?

If a read / write operations is happening on a sysfs file created by a
module, the module cannot be removed because it is the module's own
responsibility to remove the sysfs file on module exit. There is no
module lock. It is inferred.

> > If the driver removes the operation prior to
> > getting the active reference, the write will just fail. kernfs ensures
> > once a file is opened the op is not removed until the operation completes.
> 
> How does it do that?

Using an active reference.

> > If a file is opened then, the module cannot possibly be removed. The
> > piece of information we realy care about is the use of module_is_live()
> > inside try_module_get() which does:
> > 
> > static inline bool module_is_live(struct module *mod)
> > {                                                                               
> > 	return mod->state != MODULE_STATE_GOING;
> > }
> > 
> > The try allows module removal to trump use of the sysfs file. If
> > userspace wants the module removed, it gives up in favor for that
> > operation.
> 
> I do not see the tie in kernfs to module reference counts, what am I
> missing?

Let me try to describe this again. Let's take it step by step, premise
by premise on the inference assumption. Let me know at which point you
disagree.

We are talking about sysfs files and you're argument is that
try_module_get() should lock the module, and so cannot be used
in sysfs files. My point is that such module lock is inferred:

1) Sysfs files are created by a module, that same module is responsible
   for removing the same sysfs files.
2) The module can only be removed and gone, once *all* sysfs files are
   removed first.
3) If any of the module's sysfs files are present the module must
   still be present
4) kernfs ensures that if a file is opened the file will not be
   removed until any pending operation completes
5) If a sysfs file is used to write something, that means the
   sysfs file has not yet been removed, and we know it will
   remain in existance throughout its entire operation
6) When a sysfs file operation is being run, the module must
   always exist

  Luis
