Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7028C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBPI7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 03:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBPI7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 03:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093D3E08B
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676537894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oDp1wiF/TeUnnSAMJgHSLhTNA+6BBM+fmVT610sGqA=;
        b=fgmtrxafFQ/J/LKAkxMjjsTqM18/1zYR8LMwZfVneCMiJ+Sab7AQ7m/cOCk3QQBeHB3bxx
        u2f1e5E8DzyRnW+wwMcf/NAMNXnFDf2U3km0FT0g4inVifhMO/oCZfpu2YDjzvf+qX43dz
        FdQg3AJPPw3NbQdJfsaenzzsURf0oEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-_PWNsmfPNj2-yC95Y621jw-1; Thu, 16 Feb 2023 03:58:10 -0500
X-MC-Unique: _PWNsmfPNj2-yC95Y621jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F3C6101A55E;
        Thu, 16 Feb 2023 08:58:10 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AA212026D68;
        Thu, 16 Feb 2023 08:58:06 +0000 (UTC)
Date:   Thu, 16 Feb 2023 16:58:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        ming.lei@redhat.com
Subject: Re: [PATCH 1/2] blktests/src: add mini ublk source code
Message-ID: <Y+3wGE9IiHIEECvO@T590>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216030134.1368607-2-ming.lei@redhat.com>
 <20230216081938.oyc6ys5zo3bayrqw@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216081938.oyc6ys5zo3bayrqw@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shinichiro,

Thanks for the review!

On Thu, Feb 16, 2023 at 08:19:39AM +0000, Shinichiro Kawasaki wrote:
> Hi Ming, thanks for the patches. It sounds a good idea to extend blktests
> coverage to ublk.
> 
> Regarding the commit title, I suggest this:
> 
>    src: add mini ublk source codes
> 
> The word "blktests" can be placed after the word "PATCH" as follows:
> 
>    [PATCH blktests] src: add mini ublk source codes
> 
> Please try --subject-prefix="PATCH blktests" option for git format-patch.

OK.

> 
> On Feb 16, 2023 / 11:01, Ming Lei wrote:
> > Prepare for adding ublk related test:
> > 
> > 1) ublk delete is sync removal, this way is convenient to
> >    blkg/queue/disk instance leak issue
> > 
> > 2) mini ublk has two builtin target(null, loop), and loop IO is
> > handled by io_uring, so we can use ublk to cover part of io_uring
> > workloads
> > 
> > 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> > add/delete disk dynamically, this way may cover disk plug & unplug
> > tests
> > 
> > 4) ublk specific test given people starts to use it, so better to
> > let blktest cover ublk related tests
> > 
> > Add mini ublk source for test purpose only, which is easy to use:
> > 
> > ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> > 	 default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)
> > 	 -t loop -f backing_file
> > 	 -t null
> > ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> > 	 -a delete all devices, -n delete specified device
> > ./miniublk list [-n dev_id] -a
> > 	 -a list all devices, -n list specified device, default -a
> > 
> > ublk depends on liburing 2.2, so allow to ignore ublk build failure
> > in case of missing liburing, and we will check if ublk program exits
> > inside test.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  Makefile            |    2 +-
> >  src/Makefile        |   13 +-
> >  src/ublk/miniublk.c | 1385 +++++++++++++++++++++++++++++++++++++++++++
> >  src/ublk/ublk_cmd.h |  278 +++++++++
> >  4 files changed, 1674 insertions(+), 4 deletions(-)
> >  create mode 100644 src/ublk/miniublk.c
> >  create mode 100644 src/ublk/ublk_cmd.h
> > 
> > diff --git a/Makefile b/Makefile
> > index 5a04479..b9bbade 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2,7 +2,7 @@ prefix ?= /usr/local
> >  dest = $(DESTDIR)$(prefix)/blktests
> >  
> >  all:
> > -	$(MAKE) -C src all
> > +	$(MAKE) -i -C src all
> 
> This -i option to ignore errors is applied to all build targets, so it will hide
> errors. Instead os ignoring the error, how about checking the liburing version
> with pkg-config command? I roughly implemented it as the patch below on top of
> your patch. It looks working.
> 
> diff --git a/src/Makefile b/src/Makefile
> index 9bb8da6..c600099 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -2,6 +2,11 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>  		else echo "$(3)"; fi)
>  
> +HAVE_PACKAGE_VER = $(shell if pkg-config --atleast-version="$(2)" "$(1)"; \
> +			then echo 1; else echo 0; fi)
> +
> +HAVE_LIBURING := $(call HAVE_PACKAGE_VER,liburing,2.2)

I tried this way, and it fails in case that liburing is built
against source tree directly. And liburing2.2 is still a bit new, and even
some distributions doesn't package it. I will think about other way
for the check.

> +
>  C_TARGETS := \
>  	loblksize \
>  	loop_change_fd \
> @@ -18,8 +23,11 @@ C_MINIUBLK := ublk/miniublk
>  CXX_TARGETS := \
>  	discontiguous-io
>  
> +ifeq ($(HAVE_LIBURING), 1)
> +TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
> +else
>  TARGETS := $(C_TARGETS) $(CXX_TARGETS)
> -ALL_TARGETS := $(TARGETS) $(C_MINIUBLK)
> +endif
>  
>  CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
>  
> @@ -28,12 +36,12 @@ override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
>  		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
>  MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring -Iublk
>  
> -all: $(ALL_TARGETS)
> +all: $(TARGETS)
>  
>  clean:
> -	rm -f $(ALL_TARGETS)
> +	rm -f $(TARGETS)
>  
> -install: $(ALL_TARGETS)
> +install: $(TARGETS)
>  	install -m755 -d $(dest)
>  	install $(TARGETS) $(dest)
>  
> 
> 
> >  
> >  clean:
> >  	$(MAKE) -C src clean
> > diff --git a/src/Makefile b/src/Makefile
> > index 3b587f6..83e8a62 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -13,23 +13,27 @@ C_TARGETS := \
> >  	sg/syzkaller1 \
> >  	zbdioctl
> >  
> > +C_MINIUBLK := ublk/miniublk
> > +
> >  CXX_TARGETS := \
> >  	discontiguous-io
> >  
> >  TARGETS := $(C_TARGETS) $(CXX_TARGETS)
> > +ALL_TARGETS := $(TARGETS) $(C_MINIUBLK)
> >  
> >  CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
> >  
> >  override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
> >  override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
> >  		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
> > +MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring
> 
> In my envronemen, -Iublk was required also to avoid a build error.

Yeah, I just triggered it in my another VM.

> 
> >  
> > -all: $(TARGETS)
> > +all: $(ALL_TARGETS)
> >  
> >  clean:
> > -	rm -f $(TARGETS)
> > +	rm -f $(ALL_TARGETS)
> >  
> > -install: $(TARGETS)
> > +install: $(ALL_TARGETS)
> >  	install -m755 -d $(dest)
> >  	install $(TARGETS) $(dest)
> >  
> > @@ -39,4 +43,7 @@ $(C_TARGETS): %: %.c
> >  $(CXX_TARGETS): %: %.cpp
> >  	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
> >  
> > +$(C_MINIUBLK): %: ublk/miniublk.c
> > +	$(CC) $(CFLAGS) $(MINIUBLK_FLAGS) -o $@ ublk/miniublk.c
> > +
> >  .PHONY: all clean install
> > diff --git a/src/ublk/miniublk.c b/src/ublk/miniublk.c
> > new file mode 100644
> > index 0000000..dc80246
> > --- /dev/null
> > +++ b/src/ublk/miniublk.c
> > @@ -0,0 +1,1385 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> Many of the blktests files have the license GPL-3.0+. GPL-2.0+ should be fine,
> but is there reasoning to have GPL-2.0+?

Looks it is one copy & paste, will change to 3.0+ in V2.

> 
> > +// Copyright (C) 2023 Ming Lei
> > +
> > +/*
> > + * io_uring based mini ublk implementation with null/loop target,
> > + * for test purpose only.
> > + *
> > + * So please keep it simple & reliable.
> > + */
> [...]
> 
> > diff --git a/src/ublk/ublk_cmd.h b/src/ublk/ublk_cmd.h
> > new file mode 100644
> > index 0000000..f6238cc
> > --- /dev/null
> > +++ b/src/ublk/ublk_cmd.h
> > @@ -0,0 +1,278 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> This license is new to blktests. Do we need this license to this header file?
> Ah, is this file copied from linux kernel source tree? If so, I would like to
> avoid the copy and the duplication.

It is one kernel uapi header file.

OK, then looks we can take the way for figuring out linux/blkzoned.h.


Thanks, 
Ming

