Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EDCC48BE5
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D80061369
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 19:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhFVT7X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:59:23 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:33332 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhFVT7W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 15:59:22 -0400
Received: by mail-pj1-f48.google.com with SMTP id bv7-20020a17090af187b029016fb18e04cfso2368404pjb.0;
        Tue, 22 Jun 2021 12:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6P1ow+pRARLgjDdjBJdEH/jZUIklYYEVSyWdXMAgBw=;
        b=VWXvTKiEy/ZXN3SbCC6kqND2jgWPuQ5nA5a4kgfSYLqpMyXcXiPlAV2ze/u+av5zga
         2W+vrbl+d2cI6AlLYl1ZdfPp7VeFYbZzUVYKnjH84+noUvRjh00dqA/a1vEdrl9d8CzI
         IsB+WhWuj84oJdNzLxC83lKkSHAeO70ITL/LCLev/YSPd18rYNxAVeVDXKe5GpIyHZ3+
         EMYMrkfj6ogUOP1DrFntD4vnFOWifEd06L0jKXqngFqHIKk3ZvHK0OjiqbJmQElmFCy9
         HuTfW2T6Dk4fuf+3VNIROseKUsA83EJ9vpY9SqMTTZ0CL9J6VIHg+nncX/eVQdbUx3j9
         ZxoQ==
X-Gm-Message-State: AOAM533U/M62GWMxVGsatWX9D7DTc2dtaoeKkJX9MxKAxzMNMd3cTrgJ
        bPqb+wBpL6/o6uX1L4i0EzU=
X-Google-Smtp-Source: ABdhPJyjWuycNVfXuKiLx69sTDWkv3s5d6PKjujzDcKCWqMSiKe64SsQnJU1lFF1SGG2xCyOmeaXrA==
X-Received: by 2002:a17:90a:b390:: with SMTP id e16mr5527937pjr.197.1624391825224;
        Tue, 22 Jun 2021 12:57:05 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id y80sm136984pfb.204.2021.06.22.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 12:57:04 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:57:01 -0700
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
Message-ID: <20210622195701.klggwzrcadcz4az2@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGVI/vKSBAM8dlh@kroah.com>
 <20210622163208.epx4lf3pv2x2d5b4@garbanzo>
 <YNIa8tym7TmZFWaZ@kroah.com>
 <20210622172712.3bdlxnsghmbn6nry@garbanzo>
 <YNImWFPbVDrpTFQP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNImWFPbVDrpTFQP@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 08:05:12PM +0200, Greg KH wrote:
> On Tue, Jun 22, 2021 at 10:27:12AM -0700, Luis Chamberlain wrote:
> > On Tue, Jun 22, 2021 at 07:16:34PM +0200, Greg KH wrote:
> > > On Tue, Jun 22, 2021 at 09:32:08AM -0700, Luis Chamberlain wrote:
> > > > On Tue, Jun 22, 2021 at 09:45:39AM +0200, Greg KH wrote:
> > > > > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > > > > @@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
> > > > > >  {
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	if (!try_module_get(THIS_MODULE))
> > > > > > +		return -ENODEV;
> > > > > > +
> > > > > 
> > > > > You can not increment/decrement your own module's reference count and
> > > > > expect it to work properly, as it is still a race.
> > > > 
> > > > The goal here is to prevent an rmmod call if this succeeds. If it
> > > > succeeds then any subsequent rmmod will fail. Can you explain how
> > > > this is still racy?
> > > 
> > > {sigh}
> > > 
> > > What happens if the driver core is just about to call hot_add_show() and
> > > the module is removed from the system.  It then calls to the memory
> > > location that hot_add_show() was previously at, but now that is not a
> > > valid pointer to code, and boom.
> > 
> > The new kobject_get() on patch 3/3 ensures that the device will be up
> > throughout the entire life of the store call, and thus prevent the
> > code being executed being removed, no?
> 
> I do not know, I no longer remember what is in that patch at the moment
> as it is long-gone from my queue.

It was the changes *you* recommended, a generic way to ensure the
lifetime of the derefernce is valid. I had used bdgrab()/bdget() and you
suggested we generalize it with the kobject_get() for the device and a
bus get. With that change, I confirm that the device will still be
present during the lifetime of the sysfs knobs call.

> Also, if the device will be "up" for the whole lifetime, why do you need
> to increment the module reference count?

The goal is to prevent a deadlock. The lifetime of the device is not
an issue in this deadlock case, the issue is a race with module removal
and that code path using a lock which is also used on a sysfs knob.

  Luis
