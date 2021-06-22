Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA18BC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B587961075
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFVR3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:29:42 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:52144 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFVR3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 13:29:41 -0400
Received: by mail-pj1-f47.google.com with SMTP id k5so12497084pjj.1;
        Tue, 22 Jun 2021 10:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDTX8YmbiwRpMt6jiQDt+NdG80VPPhT2S2LVoaPP0rs=;
        b=RFTMa0V2woewcfzp5E284NtKiIb2rXKO8QkG4vswWqbx2ClQO4wiM0cos5baRT4fth
         zaLi+A1605DtrZ9MQQ1ahwmWQCPhELKbFValBYsedPGcDggPqB6Ge5tQQaPEd/leo9aq
         Jt1zE6k5FCWu7ba+TWe5R1BPFp0iWjWraxFhHdrjQ15maL3VFLlj2Rn/55ccUH/bgh89
         phAxsKAaO2Lea8OE7+z8ntUGpaV0Us1MFU75IJNrGibbCJihLv6WAqaRM9vUCzF1VC+9
         mQMlAFDQnQDdqUcmxqX7rgoxXE2vhCNoBy+vm0eb6+1HoLgGa/c681daj2ehftCGkyZA
         lKsw==
X-Gm-Message-State: AOAM531Ar1YYK0a2sPH9dWkZbaXoL+0HRcoSill8zdGXks6pL7phT1gx
        8jdenefGPWglJzAmWzx7/s8=
X-Google-Smtp-Source: ABdhPJzJN6ws+q6XGvkAUn6iRQ7P0VAa8qBTM9yPcb1TWTfPDNt+hIQrqpHoOrP9wB5tvWW0IwlJqA==
X-Received: by 2002:a17:902:d489:b029:126:60a0:4797 with SMTP id c9-20020a170902d489b029012660a04797mr5197952plg.5.1624382845401;
        Tue, 22 Jun 2021 10:27:25 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id y20sm21724868pfb.207.2021.06.22.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:27:15 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:27:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <20210622172712.3bdlxnsghmbn6nry@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGVI/vKSBAM8dlh@kroah.com>
 <20210622163208.epx4lf3pv2x2d5b4@garbanzo>
 <YNIa8tym7TmZFWaZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIa8tym7TmZFWaZ@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 07:16:34PM +0200, Greg KH wrote:
> On Tue, Jun 22, 2021 at 09:32:08AM -0700, Luis Chamberlain wrote:
> > On Tue, Jun 22, 2021 at 09:45:39AM +0200, Greg KH wrote:
> > > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > > @@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
> > > >  {
> > > >  	int ret;
> > > >  
> > > > +	if (!try_module_get(THIS_MODULE))
> > > > +		return -ENODEV;
> > > > +
> > > 
> > > You can not increment/decrement your own module's reference count and
> > > expect it to work properly, as it is still a race.
> > 
> > The goal here is to prevent an rmmod call if this succeeds. If it
> > succeeds then any subsequent rmmod will fail. Can you explain how
> > this is still racy?
> 
> {sigh}
> 
> What happens if the driver core is just about to call hot_add_show() and
> the module is removed from the system.  It then calls to the memory
> location that hot_add_show() was previously at, but now that is not a
> valid pointer to code, and boom.

The new kobject_get() on patch 3/3 ensures that the device will be up
throughout the entire life of the store call, and thus prevent the
code being executed being removed, no?

  Luis
