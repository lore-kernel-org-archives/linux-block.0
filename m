Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCECC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CB060249
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFUXWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:22:13 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:42866 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFUXWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 19:22:12 -0400
Received: by mail-pj1-f50.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so993676pjn.1;
        Mon, 21 Jun 2021 16:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r3PT3lnzh99ay3MnNT5OKpjH6BWO1Q/7C6HJoY6qJKo=;
        b=B79Jq2F/siMNRZduCWz8DjTRUW1H/gdufykJI/TtwId6hlghKEDzlkc0xukHqCIECG
         BLyC36bgJXlwazkhX2WpwE36QEz1s5GHQs8m5xr2Ic5o3stQV1vj7Gl7NKMGwSLK07Q/
         LrQHCx7x3kv0qfNYQ69hJNpGIAzyQlLWK0FwJSwr/L1OXHP2hO8bShPwg/aQ9E6kYhba
         pvBcSmEsAPFsGGPx1XROdR2tBJfDCj1N64s/xJHlKijIpIw7uW9HMXfgdwq1tLusihQP
         1m3OGgq2FlWgvKbu5cWrsYAMaTFCPzKAetawPvXNuKFvrnXPBTHCcZW4jcDrnj8wsHU9
         vBNA==
X-Gm-Message-State: AOAM533ssnuGvUco2Wfj18z+xeRn8N0DIOdD6QbYItqgPiVFEHezbegm
        im4ZZwHzSluGnnYWyYvreo0=
X-Google-Smtp-Source: ABdhPJwRTsVMS8ul709iRt+SzdpE0zd8262zVIB5j0foVsZXxPpfbVj4EDFVT05bbeEMRnDmjCB2xA==
X-Received: by 2002:a17:90a:1a:: with SMTP id 26mr633912pja.187.1624317596631;
        Mon, 21 Jun 2021 16:19:56 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id u23sm19889644pgk.38.2021.06.21.16.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:19:55 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:19:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <20210621231952.kjrtc47hhdd3xybf@garbanzo>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
 <20210521201618.GX4332@42.do-not-panic.com>
 <YKgbzO0AkYN4J7Ye@kroah.com>
 <20210521210817.GY4332@42.do-not-panic.com>
 <YKi3UpQm0HUxJi87@kroah.com>
 <20210525011607.GG4332@42.do-not-panic.com>
 <YKyqJsvds9eH3IZ7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKyqJsvds9eH3IZ7@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 09:41:26AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 25, 2021 at 01:16:07AM +0000, Luis Chamberlain wrote:
> > Live patching needs to lock code ;) and hey it works ;)
> 
> Live patching is vodoo magic.  But it just "adds" code paths, and later,
> when it feels all is good, then it can remove stuff (if it even does,
> I do not remember).  Adding is easy, removing is hard.

I didn't say it was easy. I meant that we support it and we can consider
its support as well.

> > Addressing the kobject refecount here should in theory address most
> > deadlocks (what my third patch addresses) as well becuase, as you imply,
> > our protection of the kobject should prevent removal, but that's not
> > always the case. I think you're failing to consider a shared global
> > driver lock, which can be used on sysfs files, which in turn have
> > *nothing* kref'd. And so the module removal can still try to nuke sysfs
> > files, if those sysfs files like to mess with the shared global driver
> > lock.
> 
> If any driver has that kind of crud, they deserve the nightmare that
> would happen if it interacts this way.  Don't worry about that, it's not
> a pattern that anyone should be using.
>
> And again, if the code and data is still there, the lock is ok to grab,
> there should not be a problem.  If so, we can fix the driver.

I went back to the drawing board with this in mind. But a few things to
note:

The issue of the deadlock does not imply a lock has to be global. So long
as the rmmod path uses a lock which is also used by sysfs files, you can end
up in a deadlock.

Despite this, I tried to remove the global lock on the zram driver, however it
just doesn't seem right to remove it, its being used to help protect a
generic state machine and a global lock seems perfectly reasonable for the
driver.

If you still believe the global is not needed, let me know what you come
up with as an alternative. I just can't find a clean way to do away with
that, *and*, I still also think this pattern might be prevalent in the
kernel in different places. I am not sure we can set as generic rule:

  "Thou Shalt Not use the same lock on rmmod and sysfs files"

I'm moving forward in my v3 series by keeping it and instead now
providing module device attribute wrappers. The idea with this is,
that if we are not yet sure what to do yet, we can at least have
drivers integrate these helpers as well when and if they find they need
a similar solution.

  Luis
