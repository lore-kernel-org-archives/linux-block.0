Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E9C4338F
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4453C60E74
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGVVgg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:36:36 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41800 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhGVVgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 17:36:36 -0400
Received: by mail-pl1-f180.google.com with SMTP id e14so942827plh.8;
        Thu, 22 Jul 2021 15:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KjDm2tntM7APsKw0ldKBybDQvh8O5xALMiXoPEkyZTI=;
        b=aK9jPCxRz/gghaXzA/b2/yqVvgkg7N/H/XJceMUA3rKvUNlqwwNWoUIrbslPLCMFH2
         LmTGbBI1tcMHs4HAgLMW6tmR+FvIvZMrLfPpQwcAWEgB5ORJV1HzH0a1LNWBglp7SdOM
         BXEroyCdOjEzYj/EEQho2MdKYj3eapXaVUVmYVTTniKXnnTj0D/TgsRd3Pj5+821jycV
         2C2l6d5Y28N8jyLfwsfJqK/DDbVEdJmI40+tyWKglwVE75jqTnrhNG2MhA49k2bgruF1
         sA6LdhHWWTc19/mPtu06Fc3/1LSfz84dEdbOhHL+lM2oBsq+XTvgp7tsP+dZMclr3H1Z
         3phw==
X-Gm-Message-State: AOAM533fEMg96qPV1pOSrJvBqvlctwW1Uxjhl71teKF0+yq96CaFXfUc
        30raG1w4nyVuIRWVxie9ct4=
X-Google-Smtp-Source: ABdhPJzouoXE7Wgjzor7XhzXWq+ByqM9pelabWAXOU//gBHckMfX0mANrBFzySFWfklAhrdfb5KFUg==
X-Received: by 2002:a63:3243:: with SMTP id y64mr2033130pgy.244.1626992229655;
        Thu, 22 Jul 2021 15:17:09 -0700 (PDT)
Received: from garbanzo ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id bv22sm23528815pjb.21.2021.07.22.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:17:08 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:17:05 -0700
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
Message-ID: <20210722221705.kyrdkpt6fwf5k56o@garbanzo>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
 <YPgFGd+FZQZWODY7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgFGd+FZQZWODY7@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 21, 2021 at 01:29:29PM +0200, Greg KH wrote:
> On Fri, Jul 02, 2021 at 05:19:57PM -0700, Luis Chamberlain wrote:
> > +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> > +static ssize_t module_ ## _name ## _store(struct device *dev, \
> > +				   struct device_attribute *attr, \
> > +				   const char *buf, size_t len) \
> > +{ \
> > +	ssize_t __ret; \
> > +	if (!try_module_get(THIS_MODULE)) \
> > +		return -ENODEV; \
> 
> I feel like this needs to be written down somewhere as I see it come up
> all the time.

I'll go ahead and cook up a patch to do just this after I send this
email out.

> Again, this is racy and broken code.  You can NEVER try to increment
> your own module reference count unless it has already been incremented
> by someone external first.

In the zram driver's case the sysfs files are still pegged on, because
as we noted before the kernfs active reference will ensure the store
operation still exists. If the driver removes the operation prior to
getting the active reference, the write will just fail. kernfs ensures
once a file is opened the op is not removed until the operation completes.

If a file is opened then, the module cannot possibly be removed. The
piece of information we realy care about is the use of module_is_live()
inside try_module_get() which does:

static inline bool module_is_live(struct module *mod)
{                                                                               
	return mod->state != MODULE_STATE_GOING;
}

The try allows module removal to trump use of the sysfs file. If
userspace wants the module removed, it gives up in favor for that
operation.

> As "proof", what happens if this module is unloaded right _before_ this
> call happens?  The module will be unloaded, memory zeroed out (or
> overridden), and then the processor will resume here and try to call (or
> return into) this code path.

The use of try_module_get() is protected to be correct by the kernfs active
reference, which in turn ensures the module is not gone. That is, when
a sysfs file read / write op is issued, if the file was opened we *know*
the module is not gone yet. It cannot possibly be removed. But once
inside the operation, try_module_get() can check to see if userspace did
want to remove the module, and if so it would immediately bail out and
yield to that operation.

Userspace cannot open a sysfs file with the module being gone.
The kernfs active prevents that.

> Boom.

I think it would be good we add a self test for this particular case.
I'll go ahead and extend my sysfs tests with one test for this case.

I could do this by adding a new sysfs file to the test driver and where
all it does is this try_module_get() thing. This can then be raced with
module removals attempts.

But it does not mean all you say is wrong.

I think the value of what you are saying requires documenting as it
was not clear to me either. I'll send a patch now.

> Just say no to "try_module_get(THIS_MODULE)" as it is totally wrong.

Context is required and documented. I'll end a patch.

  Luis
